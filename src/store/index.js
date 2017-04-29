import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'
import router from '../router'
import axios from 'axios'
const util = require('../util.js')

Vue.use(Vuex)

const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})
const hljs = require('highlight.js')
function showText (context, text) {
  if (!text) {
    text = ''
    context.commit('CURRENT_ITEM_CONTENT', { text })
    return
  }
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
      text = `<pre><code class="${language}">${text}</code></pre>`
      text = hljs.highligh(text)
  }
  context.commit('CURRENT_ITEM_CONTENT', { text })
}

function showSite (title, inline) {
  const re = /^\[(.*?)\]\((.*?)\)$/
  const match = re.exec(title)
  const url = match[2]
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
        showText.call(this, html)
        this.$store.commit('CONTENT_PANE', {type: 'text'})
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
  let iframeClass = 'vinline'
  if (!inline) {
    iframeClass = 'voutline'
  }
  const iframeHTML = `
    <div class='${iframeClass}'>
    <iframe
       src="${url}" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
   </div>
  `
  this.$store.commit('IFRAME_HTML', {iframeHTML})
  this.$store.commit('CONTENT_PANE', {type: 'site'})
}

/*
showContent: function () {
  let targetEl = this.targetEl
  if (!targetEl) {
    this.inline = true
  }
  // test for presence of url in title, if so it is external content
  if (/^\[/.test(this.model.name)) {
    return showSite.call(this, this.model.name, this.inline)
  } else {
    this.$store.commit('CONTENT_PANE', {type: 'text'})
    showText.call(this, this.textItems[this.model.t])
  }
}
*/

/* ,
setContent: function () {
  if (this.model.t && !this.initialized && (this.$store.state.currentItem.id === this.model.id)) {
    this.$store.commit('INIT') // set that current item has been shown
    this.showContent()
  }
  if ((!this.targetEl) && this.isOpen && (this.$store.state.currentItem.id !== this.model.id)) {
    this.showContent()
  }
}
*/

// ===============================================

function setData (context, ldata, filename, route) {
  context.commit('RESET') // content item has not been drawn
  context.commit('INIT_DATA') // loaded the leo data
  context.commit('LEO', {
    data: ldata.data,
    text: ldata.textItems,
    filename: filename
  })
  let selectedId = route.params.id
  if (!selectedId) {
    selectedId = 1
  }
  const match = route.path.match(/\/(\w+)\//)
  let pathType = 't'
  if (match) {
    pathType = match[0]
  }
  pathType = pathType.replace(/\//g, '')
  context.commit('VIEW_TYPE', {type: pathType})
  const openItems = JSON.search(ldata.data, '//*[id="' + selectedId + '"]/ancestor::*')
  if (!openItems) { return }
  const openItemIds = openItems.reduce((acc, o) => {
    acc.push(+o.id)
    return acc
  }, [])
  openItemIds.push(+selectedId)
  context.commit('OPEN_ITEMS', {openItemIds})
  const currentItem = {
    id: +selectedId
  }
  context.commit('CURRENT_ITEM', currentItem)
}
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
    openItemIds: [],
    history: [0],
    historyIndex: 0,
    iframeHTML: ''
  },
  mutations: {
    LEO (state, o) {
      state.leodata = o.data
      state.leotext = o.text
      state.filename = o.filename
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
    CURRENT_ITEM (state, o) {
      const id = o.id
      console.log('ID', id)
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
    /*,
    HISTORY_INDEX (state, o) {
      state.historyIndex = o.historyIndex
    } */
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
    setCurrentItem (context, o) {
      const item = o.item
      context.commit('CURRENT_ITEM', {id: item.id})
      context.commit('CONTENT_PANE', {type: 'text'})
      showText(context, context.state.leotext[item.t])
      console.log(showSite)
    }
  }
})
