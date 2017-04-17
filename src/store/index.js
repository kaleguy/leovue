import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'

Vue.use(Vuex)

function setData (context, ldata, filename) {
  context.commit('RESET')
  context.commit('INIT_DATA')
  context.commit('LEO', {
    data: ldata.data,
    text: ldata.textItems,
    filename: filename
  })
  // if there is a route, set the open nodes and current item
  // not using $route because doesn't seem accessible in store
  const hash = window.location.hash
  const match = hash.match(/(\d+)/)
  if (!match) { return }
  const selectedId = +match[0]
  const openItems = JSON.search(ldata.data, '//*[id="' + selectedId + '"]/ancestor::*')
  if (!openItems) { return }
  const openItemIds = openItems.reduce((acc, o) => {
    acc.push(+o.id)
    return acc
  }, [])
  openItemIds.push(selectedId)
  context.commit('OPEN_ITEMS', {openItemIds})
  const currentItem = {
    id: selectedId
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
    openItemIds: []
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
    VIEW_TYPE (state, o) {
      state.viewType = o.type
    },
    CURRENT_ITEM (state, o) {
      const id = o.id
      const nextSibling = JSON.search(state.leodata, '//*[id="' + id + '"]/following-sibling::*')
      const prevSibling = JSON.search(state.leodata, '//*[id="' + id + '"]/preceding-sibling::*')
      let next = 0
      let prev = 0
      if (nextSibling[0]) {
        next = nextSibling[0].id
      }
      if (prevSibling[0]) {
        prev = prevSibling[0].id
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
        setData(context, ldata, o.filename)
      })
    },
    loadLeoFromXML (context, o) {
      const ldata = transformLeoXML(o.xml)
      setData(context, ldata, 'dnd')
    }
  }
})
