import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    leotext: {},
    leodata: {},
    filename: ''
  },
  mutations: {
    LEO (state, o) {
      state.leodata = o.data
      state.leotext = o.text
      state.filename = o.filename
    }
  },
  actions: {
    loadLeo (context, o) {
      getLeoJSON(o.filename).then(ldata => {
        context.commit('LEO', {
          data: ldata.data,
          text: ldata.textItems,
          filename: o.filename
        })
      })
    },
    loadLeoFromXML (context, o) {
      const ldata = transformLeoXML(o.xml)
      debugger
      context.commit('LEO', {
        data: ldata.data,
        text: ldata.textItems,
        filename: 'dnd'
      })
    }
  }
})
