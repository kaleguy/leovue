import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    leotext: {},
    leodata: {},
    filename: '',
    initialized: false,
    contentPane: 'text',
    viewType: 'tree'
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
    RESET (state) {
      state.initialized = false
    },
    CONTENT_PANE (state, o) {
      // debugger
      state.contentPane = o.type
    },
    VIEW_TYPE (state, o) {
      state.viewType = o.type
    }
  },
  actions: {
    loadLeo (context, o) {
      getLeoJSON(o.filename, o.id).then(ldata => {
        context.commit('RESET')
        context.commit('LEO', {
          data: ldata.data,
          text: ldata.textItems,
          filename: o.filename
        })
      })
    },
    loadLeoFromXML (context, o) {
      const ldata = transformLeoXML(o.xml)
      context.commit('RESET')
      context.commit('LEO', {
        data: ldata.data,
        text: ldata.textItems,
        filename: 'dnd'
      })
    }
  }
})
