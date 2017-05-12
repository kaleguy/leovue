import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'
import router from '../router'
import axios from 'axios'
const util = require('../util.js')
const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})
const hljs = require('highlight.js')

Vue.use(Vuex)

function formatText (text) {
  let language = util.getLanguage(text)

  text = text.replace(/<</g, '\u00AB')
  text = text.replace(/>>/g, '\u00BB')

  // just plain text
  if (!language) {
    language = 'plaintext'
  }
  // remove directives from first line
  if (/^\s*?@/.test(text)) {
    text = util.removeFirstLine(text)
  }
  switch (language) {
    case 'plaintext':
      text = `<div class="text">${text}</div>`
      break
    case 'md':
      text = md.render(text)
      break
    case 'html':
      break
    default:
      const mu = hljs.highlight(language, text)
      text = mu.value
      // text = `<pre><code class="${language}">${text}</code></pre>`
      text = `<pre>${text}</pre>`
  }
  text = `<div class='content'>${text}</div>`
  return text
}

function showText (context, text, id) {
  context.commit('CONTENT_PANE', {type: 'text'})
  if (!text) {
    text = ''
    // console.log('NO TEXT', id, context.state.leotext)
    context.commit('CURRENT_ITEM_CONTENT', { text })
    return
  }
  text = formatText(text)
  // current (user selected) content item
  context.commit('CURRENT_ITEM_CONTENT', { text })
  // hash of all content items
  const newItem = { id, t: text }
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
}

function isRelative (url) {
  var ok = true
  if (/^http/.test(ok)) {
    ok = false
  }
  return ok
}

function loadLeoNode (context, item) {
  const title = item.name
  const id = item.id
  let {url, label} = getUrlFromTitle(title)
  console.log('LABEL', label)
  getLeoJSON(url, id).then(data => {
    let text = data.textItems
    context.commit('ADDTEXT', { text })
    data = data.data
    if (name) {
      item.name = data.name
      item.children = data.children
    } else {
      item.name = label
      item.children.push(data)
    }
  })
}
function getUrlFromTitle (title) {
  const re = /^\[(.*?)\]\((.*?)\)$/
  const match = re.exec(title)
  let url = match[2]
  let label = match[1]
  if (!url) { return null }
  if (isRelative(url)) {
    url = 'static/' + url
  }
  return {url, label}
}

function showSite (context, title, id) {
  let {url, label} = getUrlFromTitle(title)
  console.log(label)
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
        html = formatText(html)
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
        html = formatText(html)
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
 * setData Set data loaded from the Leo file.
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
  const openItems = JSON.search(ldata.data, '//*[id="' + id + '"]/ancestor::*')
  if (!openItems) { return }
  const openItemIds = openItems.reduce((acc, o) => {
    acc.push(o.id + '')
    return acc
  }, [])
  openItemIds.push(id + '')
  context.commit('OPEN_ITEMS', {openItemIds})
  const ids = openItemIds
  context.dispatch('setContentItems', {ids})
  context.dispatch('setCurrentItem', {id})
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
    viewType: 'tree',
    currentItem: {
      id: 0,
      next: 0,
      prev: 0
    },
    currentItemContent: '',
    contentItems: {},
    openItemIds: [],
    history: [0],
    historyIndex: 0,
    iframeHTML: '',
    contentItemsUpdateCount: 0
  },
  mutations: {
    LEO (state, o) {
      state.leodata = o.data
      state.leotext = o.text
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
      var routeName = state.route.name
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
    loadLeo (context, o) {
      getLeoJSON(o.filename, o.id).then(ldata => {
        setData(context, ldata, o.filename, o.route)
      })
    },
    loadLeoFromXML (context, o) {
      const ldata = transformLeoXML(o.xml)
      setData(context, ldata, 'dnd', o.route)
    },
    setContentItems (context, o) {
      const ids = o.ids
      ids.forEach(id => {
        let item = JSON.search(context.state.leodata, '//*[id="' + id + '"]')
        if (item) {
          item = item[0]
          if (/^\[/.test(item.name)) {
            setSiteItem(context, item.name, item.id)
          } else {
            let text = context.state.leotext[item.t]
            text = formatText(text)
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
    setCurrentItem (context, o) {
      const id = o.id
      context.commit('CURRENT_ITEM', {id})
      let item = JSON.search(context.state.leodata, '//*[id="' + id + '"]')
      if (item) {
        item = item[0]
        if (/^\[/.test(item.name)) {
          if (/\.leo\)$/.test(item.name)) {
            loadLeoNode(context, item)
          } else {
            showSite(context, item.name, id)
            setSiteItem(context, item.name, id)
          }
        } else {
          // console.log(item.t, context.state.leotext[item.t], context.state.leotext)
          showText(context, context.state.leotext[item.t], id)
        }
      }
    }
  }
})
