import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    leotext: [],
    leodata: [],
    currentFilename: 'docs.leo'
  },
  mutations: {
    increment (state) {
      state.count++
    }
  }
})
