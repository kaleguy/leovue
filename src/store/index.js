import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'
import router from '../router'
import axios from 'axios'
import _ from 'lodash'
// import CSV from 'csv-string'
import Papa from 'papaparse'
const util = require('../util.js')
const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})
const lunr = require('lunr')

function loadIndex (titles, text) {
  const docs = loadIndexItems([], titles, text)
  // return indexItems
  let idx = lunr(function () {
    this.ref('id')
    this.field('text')
    docs.forEach(function (doc) {
      this.add(doc)
    }, this)
  })
  return {idx, docs}
}
function loadIndexItems (arr, titles, textItems) {
  if (!titles) { return arr }
  titles.forEach(item => {
    arr.push(
      {
        id: item.id,
        name: item.name,
        text: textItems[item.t]
      }
    )
    loadIndexItems(arr, item.children, textItems)
  })
  return arr
}

Vue.use(Vuex)

function showText (context, text, id) {
  context.commit('CONTENT_PANE', {type: 'text'})
  if (!text) {
    text = ''
    context.commit('CURRENT_ITEM_CONTENT', { text })
    return
  }
  text = util.formatText(text)
  // current (user selected) content item
  context.commit('CURRENT_ITEM_CONTENT', { text })
  // hash of all content items
  const newItem = { id, t: text }
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
}
/**
 * Get subtree names for preloading bookmarked nodes
 * @param acc {array} - accumulator
 * @param p {string} - path, e.g. 28-2-10-5
 * @param startIndex {integer} - start with O to get all
 */
function getRoots (acc, p, startIndex) {
  const i = p.indexOf('-', startIndex)
  if (i < 0) { return acc }
  acc.push(p.substring(0, i))
  return getRoots(acc, p, i + 1)
}
/**
 * Is url relative
 * @param url {string}
 * @returns {boolean} - if is relative
 */
function isRelative (url) {
  let ok = true
  if (/^[xh]ttp/.test(url)) { // xhttp is to indicate xframe header should be ignored
    return false
  }
  if (/^\//.test(url)) {
  //  return false
  }
  if (window.lconfig.filename) {
    return false
  }
  return ok
}
/**
 * Chop the end of a string off
 * @param s {string} The input string
 * @param c {string} The character from which the string will be chopped
 * @returns {string} The chopped string
 */
function chop (s, c) {
  if (s.indexOf(c) < 0) { return s }
  return s.substring(0, s.lastIndexOf(c))
}
// load subtree - separate leo file loaded into node
function loadLeoNode (context, item) {
  console.log('LOADING SUBTREE')
  const p = new Promise((resolve, reject) => {
    const title = item.name
    const id = item.id
    let {url, label} = getUrlFromTitle(title)
    getLeoJSON(url, id).then(data => {
      let text = data.textItems
      data = data.data
      context.commit('ADDTEXT', {text})
      if (data.length === 1) {
        context.commit('RESET') // content item has not been drawn
        console.log('RESET')
        context.dispatch('setCurrentItem', {id})
        data = data[0]
        item.children = data.children
        item.t = data.t
        item.name = label // convert to regular title so won't reload
      } else { // TODO: trunkless load logic in complete
        item.name = label
        item.children = data
      }
      resolve(true)
    })
  }).catch(e => console.log('Error: ', e))
  return p
}
function getUrlFromTitle (title) {
  const re = /^\[(.*?)\]\((.*?)\)$/
  const match = re.exec(title)
  let url = match[2]
  let label = match[1]
  if (!url) { return null }
  if (isRelative(url)) {
    // url = 'static/' + url
  }
  // absolute urls require no further processing
  if (/^[xh]ttp/.test(url)) { // xttp will result in http call via proxy
    return {url, label}
  }
  let cname = window.lconfig.filename
  if (cname.indexOf('/') < 0) {
    cname = ''
  }
  if (cname) {
    let u = window.lconfig.filename
    u = chop(u, '#')
    u = chop(u, '?')
    u = chop(u, '/')
    url = u + '/' + url
  }
  return {url, label}
}
function showPresentation (context, title, id) {
  const iframeHTML = `
    <div style="width:100%">
    <iframe
       src="about:blank" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
    </div>
  `
  context.commit('IFRAME_HTML', {iframeHTML})
  context.commit('CONTENT_PANE', {type: 'site'})
}

function showSite (context, title, id) {
  let {url, label} = getUrlFromTitle(title) // eslint-disable-line
  if (!url) { return }
  const ext = util.getFileExtension(url)
  const base = url.substring(0, url.lastIndexOf('/'))
  // TODO: add spinner
  if (ext === 'md') {
    axios.get(url)
      .then((response) => {
        let html = md.render(response.data)
        html = '@language md\n<div class="md">' + html + '</div>'
        html = util.replaceRelUrls(html, base)
        // html = util.formatText(html)
        showText(context, html, id)
        context.commit('CONTENT_PANE', {type: 'text'})
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
  const iframeHTML = `
    <div style="width:100%">
    <iframe
       src="${url}" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
    </div>
  `
  context.commit('IFRAME_HTML', {iframeHTML})
  context.commit('CONTENT_PANE', {type: 'site'})
  // context.commit('CONTENT_ITEM_UPDATE')
}

function setSiteItem (context, title, id) {
  let {url, label} = getUrlFromTitle(title)
  console.log(label) // TODO: remove this, it is here for eshint
  const ext = util.getFileExtension(url)
  const base = url.substring(0, url.lastIndexOf('/'))
  // TODO: add spinner
  if (ext === 'md') {
    axios.get(url)
      .then((response) => {
        let html = md.render(response.data)
        html = '@language md\n<div class="md">' + html + '</div>'
        html = util.replaceRelUrls(html, base)
        html = util.formatText(html)
        const newItem = {
          id: id,
          t: html
        }
        context.commit('CONTENT_ITEM_UPDATE')
        context.commit('CONTENT_ITEM', {item: newItem})
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
  const iframeHTML = `
    <div class="vinline">
    <iframe
       src="${url}" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
    </div>
  `
  const newItem = {
    id: id,
    t: iframeHTML
  }
  // context.commit('IFRAME_HTML', {iframeHTML})
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
}

/**
 * setData Set data loaded from the Leo file, get content for open items (from path).
 * @param context
 * @param ldata
 * @param filename
 * @param route
 */
function setData (context, ldata, filename, route) {
  context.commit('RESET') // content item has not been drawn
  context.commit('INIT_DATA') // loaded the leo data
  context.commit('LEO', {
    data: ldata.data,
    text: ldata.textItems,
    filename: filename
  })
  loadDataSets(context, ldata)
  loadDataTables(context, ldata)
  loadPresentations(ldata.data[0])
  setLanguageNodes(context, ldata)
  let id = route.params.id
  if (!id) {
    id = '1'
  }
  // TODO: use vuex-router
  const match = route.path.match(/\/(\w+)\//)
  let pathType = 't'
  if (match) {
    pathType = match[0]
  }
  pathType = pathType.replace(/\//g, '')
  context.commit('VIEW_TYPE', {type: pathType})
  const path = route.path
  let npath = null
  if (path) {
    npath = path.substring(path.indexOf(2, '/'))
  }
  let subtrees = []
  if (npath) {
    subtrees = getRoots([], npath)
  }
  loadSubtrees(context, subtrees, ldata.data).then(() => {
    const openItems = JSON.search(ldata.data, '//*[id="' + id + '"]/ancestor::*')
    if (!openItems) { return }
    if (!openItems.length) { return }
    const openItemIds = openItems.reduce((acc, o) => {
      if (o.id) { acc.push(o.id + '') }
      return acc
    }, [])
    openItemIds.push(id + '')
    context.commit('OPEN_ITEMS', {openItemIds})
    const ids = openItemIds
    context.dispatch('setContentItems', {ids})
    context.dispatch('setCurrentItem', {id})
  })
}
function loadPresentations (data) {
  let p = /@presentation ([a-zA-Z0-9]*)(.*)$/.test(data.name)
  let a = /^« /.test(data.name)
  // const matches = true
  if (p || a) {
    loadPresentation(data.id, data.children)
  }
  data.children.forEach(loadPresentations)
}
function loadPresentation (id, pages) {
  if (!pages) { return }
  pages.forEach((page, index) => {
    page.presentation = { pid: id, index }
  })
}

function loadSubtrees (context, trees, data) {
  if (!trees.length) { return Promise.resolve() }
  const p = new Promise((resolve, reject) => {
    // TODO: this just loads the first subtree, need to load all
    let item = JSON.search(data, '//*[id="' + trees[0] + '"]')[0]
    loadLeoNode(context, item).then(res => resolve(res))
  })
  return p
}
// for @clean nodes, set children with @language of extension
function setLanguageNodes (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    setLanguageNode(context, d, textItems)
  })
  // window.lconfig.dataSets = context.state.dataSets
}
function setLanguageNode (context, d, textItems) {
  const title = d.name
  let language = ''
  if (/^\s*@clean/.test(title)) {
    var re = /(?:\.([^.]+))?$/
    var ext = re.exec(title)[1]
    var ng = ['txt', 'md', 'html']
    if (ng.indexOf(ext) === -1) {
      language = ext
    }
    const langs = {
      js: 'javascript',
      ts: 'typescript',
      py: 'python',
      java: 'java',
      c: 'c'
    }
    if (langs[ext]) {
      language = langs[ext]
    }
  }
  if (language) {
    return addDirectiveToSubTree(d, '@language ' + language, textItems)
  }
  d.children.forEach(child => {
    setLanguageNode(context, child, textItems)
  })
}

/**
 * e.g. add '@language javascript' to this item and all below
 * @param subtree
 * @param directive
 * @param textItems
 */
function addDirectiveToSubTree (subtree, directive, textItems) {
  const text = textItems[subtree.t]
  if (!/^@/.test(text)) {
    textItems[subtree.t] = directive + '\n' + text
  }
  subtree.children.forEach(child => {
    addDirectiveToSubTree(child, directive, textItems)
  })
}
function loadDataSets (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    loadDataSet(context, d, textItems)
  })
  window.lconfig.dataSets = context.state.dataSets
}
function loadDataSet (context, item, textItems) {
  const text = textItems[item.t]
  const matches = item.name.match(/@dataSet ([a-zA-Z0-9]*)(.*)$/)
  if (matches) {
    const k = _.trim(matches[1])
    let v = text.replace(/^@language (\w+)/, '') // get rid of language directive
    try {
      v = JSON.parse(v)
    } catch (e) {
      console.log('Unable to parse data for: ' + item.name + ' ' + e)
    }
    context.commit('ADDDATASET', {k, v})
  }
  item.children.forEach(child => {
    loadDataSet(context, child, textItems)
  })
}
function loadDataTables (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    loadDataTable(context, d, textItems)
  })
  window.lconfig.dataTables = context.state.dataTables
}
function loadDataTable (context, item, textItems) {
  const text = textItems[item.t]
  const matches = item.name.match(/@dataTable ([a-zA-Z0-9]*)(.*)$/i)
  if (matches) {
    const k = _.trim(matches[1])
    const title = matches[2] || ''
    let v = text.replace(/^@language (\w+)/, '') // get rid of language directive
    let arr = null
    try {
      arr = Papa.parse(v).data
    } catch (e) {
      arr = []
      console.log('Unable to parse dataTable for: ' + item.name + ' ' + e)
    }
    arr.forEach(r => {
      r.forEach((c, i) => {
        r[i] = _.trim(c)
      })
    })
    const objArr = []
    const cols = arr[0]
    for (let r = 1; r < arr.length; r++) {
      let row = arr[r]
      let rowObj = {}
      for (let c = 0; c < row.length; c++) {
        let colName = cols[c]
        if (colName.indexOf('$') === -1) {
          rowObj[colName] = row[c]
        }
      }
      // let obj = arr[r].reduce((acc, v, i) => { acc[cols[i]] = v; return acc }, {})
      objArr.push(rowObj)
    }
    v = {title, arr, objArr}
    context.commit('ADDDATATABLE', {k, v})
  }
  item.children.forEach(child => {
    loadDataTable(context, child, textItems)
  })
}

// ========= The Store ===============
export default new Vuex.Store({
  state: {
    leotext: {},
    leodata: {},
    filename: '',
    initialized: false,
    initializedData: false,
    contentPane: 'text',
    viewType: 't',
    currentItem: {
      id: 0,
      next: 0,
      prev: 0,
      type: 'item'
    },
    currentItemContent: '',
    contentItems: {},
    currentPage: {
      id: 0
    },
    dataSets: {},
    dataTables: {},
    openItemIds: [],
    history: [0],
    historyIndex: 0,
    iframeHTML: '',
    contentItemsUpdateCount: 0,
    idx: null,
    accordion: false,
    accordionPrev: false,
    searchFlag: false,
    selecting: false // e.g. in search dialog using arrow keys
  },
  mutations: {
    ADDDATASET (state, o) {
      state.dataSets[o.k] = o.v
    },
    ADDDATATABLE (state, o) {
      state.dataTables[o.k] = o.v
    },
    TOGGLEACCORDION (state) {
      state.accordion = !state.accordion
    },
    SETSEARCHFLAG (state) {
      state.searchFlag = true
    },
    SELECTINGON (state) {
      if (!state.searchFlag) {
        state.accordionPrev = state.accordion
      }
      state.accordion = true
    },
    SELECTINGOFF (state) {
      state.searchFlag = false
      state.accordion = state.accordionPrev
    },
    LEO (state, o) {
      state.leodata = o.data
      state.leotext = o.text
      const c = loadIndex(o.data, o.text)
      state.idx = c.idx
      state.idxDocs = c.docs
      state.filename = o.filename
      window.lconfig.leodata = o.data
      window.lconfig.leotext = o.text
    },
    // lunr search index
    RESETINDEX (state, o) {
      if (_.isUndefined) {
        console.log('No state in RESETINDEX')
        return
      }
      const c = loadIndex(state.leodata, state.leotext)
      state.idx = c.idx
      state.idxDocs = c.docs
      state.filename = o.filename
    },
    ADDTEXT (state, o) {
      const text = o.text
      for (let k in text) {
        state.leotext[k] = text[k]
      }
    },
    INIT (state) {
      state.initialized = true
    },
    INIT_DATA (state) {
      state.initializedData = true
    },
    RESET (state) {
      state.initialized = false
    },
    CONTENT_PANE (state, o) {
      state.contentPane = o.type
    },
    IFRAME_HTML (state, o) {
      state.iframeHTML = o.iframeHTML
    },
    VIEW_TYPE (state, o) {
      state.viewType = o.type
    },
    CURRENT_ITEM_CONTENT (state, o) {
      state.currentItemContent = o.text
    },
    CURRENT_PAGE (state, o) {
      const id = o.id
      state.currentPage.id = id
      if (+id === 0) { return }
      let routeName = state.route.name
      if (routeName === 'Top') {
        routeName = 'Node'
      }
      router.replace({name: routeName, params: { id }})
    },
    // for inline content, keep hash of content items
    CONTENT_ITEM (state, o) {
      const item = o.item
      state.contentItems[item.id] = item.t
    },
    CONTENT_ITEM_UPDATE (state, o) {
      state.contentItemsUpdateCount = state.contentItemsUpdateCount + 1
    },
    CURRENT_ITEM (state, o) {
      const id = o.id
      // check current for identical
      if (o.id === state.currentItem.id) {
        return
      }
      // TODO: check prev/next for identical before change
      const nextSibling = JSON.search(state.leodata, '//children[id="' + id + '"]/following-sibling::*')
      const prevSibling = JSON.search(state.leodata, '//children[id="' + id + '"]/preceding-sibling::children')
      let next = 0
      let prev = 0
      if (nextSibling[0]) {
        next = nextSibling[0].id
      }
      if (prevSibling[0]) {
        prev = prevSibling[prevSibling.length - 1].id
      }
      if (id - prev !== 1) {
        prev = 0
      }
      if (next - id !== 1) {
        next = 0
      }
      state.currentItem.id = id
      state.currentItem.prev = prev
      state.currentItem.next = next
      let routeName = state.route.name
      if (routeName === 'Top') {
        routeName = 'Node'
      }
      router.replace({name: routeName, params: { id }})

      if (typeof o.historyIndex !== 'undefined') {
        state.historyIndex = o.historyIndex
      } else {
        state.history.push(id)
        state.historyIndex = state.historyIndex + 1
      }
      state.initialized = false
    },
    OPEN_ITEMS (state, o) {
      const ids = state.openItemIds
      ids.splice(0, ids.length)
      ids.push(...o.openItemIds)
    }
  },
  actions: {
    setMessages (context) {
      window.addEventListener('message', function (event) {
        if (!event.data) { return }
        if (!Object.keys(event.data).length) { return }
        let data = {}
        if (_.isObject(event.data)) {
          data = event.data
        } else {
          data = JSON.parse(event.data)
        }
        console.log('MDATA', data)
        if (data.namespace === 'leovue' && data.eventName === 'setcurrentitem') {
          const id = data.state.id
          context.dispatch('setCurrentItem', {id})
          console.log('setcurrentitem', id)
        }
        if (data.namespace === 'reveal' && data.eventName === 'slidechanged') {
          const id = data.state.indexh
          context.dispatch('setCurrentPage', {id})
          // Slide changed, see data.state for slide number
        }
      })
    },
    loadLeo (context, o) {
      getLeoJSON(o.filename, o.id).then(ldata => {
        setData(context, ldata, o.filename, o.route)
      })
    },
    loadLeoFromXML (context, o) {
      transformLeoXML(o.xml).then(ldata => {
        setData(context, ldata, 'dnd', o.route)
      })
    },
    // Given a list of ids, get the content. Needed for
    // inline mode and displaying content in a path.
    setContentItems (context, o) {
      const ids = o.ids
      ids.forEach(id => {
        let item = JSON.search(context.state.leodata, '//children[id="' + id + '"]')
        if (!item[0]) {
          console.log(item, id, context.state.leodata)
        }
        if (item && item[0]) {
          item = item[0]
          // if it starts with a bracket it is a link in markdown syntax
          if (/^\[/.test(item.name)) {
            setSiteItem(context, item.name, item.id)
          } else {
            let text = context.state.leotext[item.t]
            text = util.formatText(text)
            const newItem = {
              t: text,
              id: id
            }
            context.commit('CONTENT_ITEM', {item: newItem})
            context.commit('CONTENT_ITEM_UPDATE')
          }
        }
      })
    },
    setCurrentPage (context, o) {
      let page = +o.id
      let id = context.state.currentItem.id
      // if we're setting a page, we're displaying a presentation
      const presentationNode = JSON.search(context.state.leodata, '//*[id="' + id + '"]')[0]
      const pageNode = presentationNode.children[page]
      // const pageNode = 0
      // console.log('PN', presentationNode, pageNode, page)
      if (!pageNode) {
        id = 0
      } else {
        id = pageNode.id
      }
      context.commit('CURRENT_PAGE', {id})
    },
    setCurrentItem (context, o) {
      const id = o.id
      // if in iframe, just raise event and leave
      if (window.parent !== window.self) {
        // console.log('sending event')
        // let type = 'leovue'
        // let event = new CustomEvent('message', { data: {id, type} })
        // window.dispatchEvent(event)
        // window.parent.postMessage(JSON.stringify({ namespace: 'leovue', eventName: 'setcurrentitem', state: {id} }), '*')
        return
      }
      // open parent nodes, close others
      const openItems = JSON.search(context.state.leodata, '//*[id="' + id + '"]/ancestor::*')
      let openItemIds = openItems.reduce((acc, o) => {
        if (o.id) { acc.push(o.id + '') }
        return acc
      }, [])
      openItemIds.push(id + '')
      if (context.state.accordion) {
        context.commit('OPEN_ITEMS', {openItemIds})
        const ids = openItemIds
        context.dispatch('setContentItems', {ids})
      } else {
      // open parent nodes
        const currentOpenItemIds = context.state.openItemIds
        openItemIds = _.uniq(currentOpenItemIds.concat(openItemIds))
        context.commit('OPEN_ITEMS', {openItemIds})
      }
      let item = JSON.search(context.state.leodata, '//*[id="' + id + '"]')
      context.commit('CURRENT_ITEM', {id})
      if (_.get(item, '[0].presentation')) {
        context.commit('CURRENT_PAGE', {id: 0})
      }
      if (item) {
        item = item[0]
        if (/^@presentation /.test(item.name)) {
          return showPresentation(context, item.name, id)
        }
        if (/^« /.test(item.name) && _.has(item.children[0], 'presentation')) {
          return showPresentation(context, item.name, id)
        }
        // bracket means load file/site
        if (/^\[/.test(item.name)) {
          // load leo file from item title
          if (/\.leo\)$/.test(item.name)) {
            console.log('load leo')
            loadLeoNode(context, item, true).then(
              res => context.commit('RESETINDEX')
            )
          } else {
            console.log('load site')
            showSite(context, item.name, id)
            setSiteItem(context, item.name, id)
          }
        } else {
          // console.log(item.t)
          showText(context, context.state.leotext[item.t], id)
        }
        if (item.presentation) {
          context.commit('CURRENT_ITEM', {id: item.presentation.pid})
          context.commit('CURRENT_PAGE', {id})
          return showPresentation(context, item.name, id)
        }
      }
    }
  }
})
