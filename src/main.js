import Vue from 'vue'
import App from './App'
import AppBase from './AppBase.vue'
import router from './router'
import store from './store'
import { sync } from 'vuex-router-sync'
import StarRating from 'vue-star-rating'
import Icon from 'vue-awesome/components/Icon.vue'
import 'vue-awesome/icons/bars'
import 'vue-awesome/icons/arrow-left'
import 'vue-awesome/icons/arrow-right'
import 'vue-awesome/icons/check'
import 'vue-awesome/icons/chevron-left'
import 'vue-awesome/icons/'
import ForkMeOnGithub from 'fork-me-on-github-vue'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import 'timeline-vuejs/dist/timeline-vuejs.css'

// content components
import { LMap, LTileLayer, LMarker } from 'vue2-leaflet'
import InfoCard from 'vue-info-card'
import VTooltip from 'v-tooltip'
import VueYouTubeEmbed from 'vue-youtube-embed'
import VTable from './components/Table'
import VCTable from './content-components/VCTable'
import Mermaid from './content-components/Mermaid'
import MermaidP from './content-components/MermaidP'
import VSVG from './content-components/VSVG'
import SectionLink from './components/SectionLink'
import TOC from './components/TOC'
import NodeLink from './components/NodeLink'
import MathJaxComponent from './components/MathJax'
import ImageLeft from './components/layout/ImageLeft'
import LVTimeline from './components/LVTimeline'
import WordCloud from './components/WordCloud'
import Kanban from './components/Kanban'
import MermaidBoard from './components/MermaidBoard'
import D3Board from './components/D3Board'
import { TableComponent, TableColumn } from 'vue-table-component'
import SummaryTable from './components/SummaryTable'
import TagSearch from './components/TagSearch'
import VueWordCloud from 'vuewordcloud'

import {charts} from './content-components/Charts'
charts(Vue)

const Defiant = require('./lib/defiant') // eslint-disable-line

Vue.use(VTooltip)
Vue.use(VueYouTubeEmbed)
Vue.use(ForkMeOnGithub)
Vue.use(BootstrapVue)
Vue.component('star-rating', StarRating)
Vue.component('lv-timeline', LVTimeline)
Vue.component('word-cloud', WordCloud)
Vue.component('img-left', ImageLeft)
Vue.component('sectionlink', SectionLink)
Vue.component('toc', TOC) // table of contents (of child nodes)
Vue.component('Nodelink', NodeLink)
Vue.component('v-table', VTable)
Vue.component('v-svg', VSVG)
Vue.component('vc-table', VCTable)
Vue.component('mermaid', Mermaid)
Vue.component('mermaidp', MermaidP)
Vue.component('mj', MathJaxComponent)
Vue.component('info-card', InfoCard)
Vue.component('l-map', LMap)
Vue.component('l-tilelayer', LTileLayer)
Vue.component('l-marker', LMarker)
Vue.component('summary-table', SummaryTable)
Vue.component('table-component', TableComponent)
Vue.component('table-column', TableColumn)
Vue.component('kanban', Kanban)
Vue.component('mermaid-board', MermaidBoard)
Vue.component('d3-board', D3Board)
Vue.component('tagsearch', TagSearch)
Vue.component(VueWordCloud.name, VueWordCloud)

sync(store, router)

const util = require('./util.js')
util.parseQueryString(window.lconfig, window.location.href) // fill in global config object from url params

Vue.component('icon', Icon)

Vue.config.productionTip = false

let template = '<App/>'
let el = '#app'
if (window.lconfig.appBase) {
  template = '<AppBase />'
  el = '#app-base'
}

/* eslint-disable no-new */
require('./simpledrag.js')
new Vue({
  el,
  store,
  router,
  template: template,
  components: { App, AppBase },
  mounted: function () {
    // const vm = this
    window.addEventListener('keyup', e => {
      // If down arrow was pressed...
      let direction = ''
      e.preventDefault()
      switch (e.keyCode) {
        case 40:
          direction = 'down'
          break
        case 38:
          direction = 'up'
          break
        case 13:
          direction = 'in'
          break
        default:
      }
      if (direction) {
        this.$store.dispatch('changeCurrentItem', { direction })
      }
    })
  }
})
Vue.config.errorHandler = function (err, vm, info) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  // the error was found in. Only available in 2.2.0+
  console.log('Error: ', err, vm.name, info)
}
Vue.config.warnHandler = function (err) {
  // handle error
  // `info` is a Vue-specific error info, e.g. which lifecycle hook
  // the error was found in. Only available in 2.2.0+
  console.log('Warning: ', err)
}

window.noop = () => {}
