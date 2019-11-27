<template>
  <div class="pane" id="dx">
    <div v-if="textContent">
      <div id="lhandle"
           class="handle">
        <div class="handle-button"
             v-show="hasPrev"
             @click="goPrev">
          <icon class="icon"
                name="chevron-left"></icon>
        </div>
      </div>
      <div id="tlayout">
        <div :style="{position:'relative', overflow: 'hidden', width: '100%', height: 'calc(100vh - 33px)'}">
          <div class="inner-container" id="content-inner-container" style="width:100%; overflow:hidden">
            <div id="content-inner-containerb" class="right-cpane" :style="{overflowY: 'auto'}" v-on:scroll="onScroll" >
              <div :style="{width: cpWidth, marginLeft: 'auto', marginRight: 'auto'}">
                <div v-if="noCompile">
                   FOOBAR
                </div>
                <div v-if="!noCompile">
                  <component :is="dynComponent" v-bind="$props"/>
                </div>
              </div>
            </div>
            </div>
          </div>
        </div>
      <div id="rhandle"
           class="handle">
        <div class="handle-button"
             v-show="hasNext"
             @click="goNext">
          <icon class="icon"
                name="chevron-right"></icon>
        </div>
      </div>
    </div>
    <div v-if="boardContent"
         style="display:flex; background:#fff; width: 100%"
         id="bpane">
      <div style="width:100%">
        <component :is="dynComponent" v-bind="$props"/>
      </div>
    </div>
    <div v-if="iframeContent"
         style="display:flex; background:#fff; width: 100%"
         v-html="iframeHTML"
         id="vpane">
    </div>
  </div>
</template>

<script>
const hljs = require('highlight.js')
import {presentation} from '../lib/presentation'
import _ from 'lodash'
const util = require('../util.js')

// functions for dealing with x-frame headers
// TODO move these
window.getData = function (data) {
  if (data && data.query && data.query.results && data.query.results.resources && data.query.results.resources.content && data.query.results.resources.status == 200) {
    let html = data.query.results.resources.content
    if (/https:/.test(window.url)) {
      html = html.replace(/src="http:/g, 'src="https:')
    }
    loadHTML(html)
  } else if (data && data.error && data.error.description) {
    loadHTML(data.error.description)
  } else {
    loadHTML('Error: Cannot load ' + window.url)
  }
}
window.loadHTML = function (html) {
  iframe.src = 'about:blank'
  iframe.contentWindow.document.open()
  // iframe.contentWindow.document.write(html.replace(/<head>/i, '<head><base href="' + url + '"><scr' + 'ipt>document.addEventListener("click", function(e) { if(e.target && e.target.nodeName == "A") { e.preventDefault(); parent.loadURL(e.target.href); } });</scr' + 'ipt>'))
  iframe.contentWindow.document.write(html.replace(/<head>/i, '<head><base href="' + window.url + '"><scr' + 'ipt>document.addEventListener("click", function(e) { if(e.target && e.target.nodeName == "A") { e.preventDefault(); window.open(e.target.href); } });</scr' + 'ipt>'))
  iframe.contentWindow.document.close()
}
window.loadURL = function (src) {
  let url = src
  var script = document.createElement('script')
  script.src = 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20data.headers%20where%20url%3D%22' + encodeURIComponent(url) + '%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=getData'
  document.body.appendChild(script)
};
function overrideXFrame(item, textItems) {
  // console.log('override xframe')
  const iframe = document.getElementsByTagName('iframe')[0];
  if (!iframe){ return }
  window.iframe = iframe
  const url = iframe.src
  if (url === 'about:blank') {
    return loadPresentation(item, textItems, iframe)
  }
  console.log('URL', url)
  if (!/^\s?xttp/.test(url)) { return }
  window.url = url.replace(/^s?xttp/, 'http')
  loadURL(window.url)
}
// end functions for dealing with x-frame headers

function loadPresentation(item, textItems, iframe) {
  console.log('loading presentation', item)
  // debugger
  let content = ''
  let re = /^@props (.*)/
  if (!item.children.length) {
    console.log('pid', item.presentation.pid)
    return
  }
  item.children.forEach((page, index) => {
    let pageContent = textItems[page.t]
    let props = re.exec(pageContent)
    if (props) {
      props = props[1]
    } else {
      props = ''
    }
    content = content + '<section ' + props + '>' +  util.formatText(pageContent, true) + '</section>'
  })
  const html = presentation(item.name, content)
  iframe.contentWindow.document.open()
  iframe.contentWindow.document.write(html)
  iframe.contentWindow.document.close()
}

export default {
  name: 'contentpane',
  components: {
  },
  data () {
    return {
      xSections: [],
      handleScroll: null
    }
  },
  methods: {
    onScroll () {
      // bail if this isn't a paged item
      if (!this.xSections.length) { return }
      this.handleScroll()
    },
    goNext () {
      const next = this.$store.state.currentItem.next
      this.resetCurrentItem(next)
    },
    goPrev () {
      const prev = this.$store.state.currentItem.prev
      this.resetCurrentItem(prev)
    },
    resetCurrentItem (id) {
      // router.replace('/t/' + id)
      // const currentItem = { id }
      // this.$store.commit('RESET')
      this.$store.dispatch('setCurrentItem', {id})
    },
    dataTableClick (r) {
      const title = r.data.title.replace(/<[^>]*>/g, "")
      // const title = r.data.title.innerHTML.replaceAll("<[^>]*>", "")
      const item = JSON.search(this.$store.state.leodata, '//*[vtitle="' + title + '"]')[0]
      if (item) {
        const id = item.id
        this.$store.dispatch('setCurrentItem', {id})
      }
      console.log('ROW CLICK', title, item)
    }
  },
  computed: {
    cpWidth () {
      return window.lconfig.contentPaneWidth || '700px'
    },
    data () {
      return this.$store.state.leodata
    },
    text () {
      return this.$store.state.leotext
    },
    iframeContent () {
      if (this.$store.state.contentPane === 'site') {
        return true
      } else {
        return false
      }
    },
    boardContent () {
      if (this.$store.state.contentPane === 'board') {
        return true
      } else {
        return false
      }
    },
    textContent () {
      if (this.$store.state.contentPane === 'text') {
        return true
      } else {
        return false
      }
    },
    currentItemContent () {
      return this.$store.state.currentItemContent
    },
    noCompile() {
      return false
    },
    iframeHTML () {
      if (this.iframeContent) {
        return this.$store.state.iframeHTML
      } else {
        return ''
      }
    },
    hasNext () {
      return this.$store.state.currentItem.next
    },
    hasPrev () {
      return this.$store.state.currentItem.prev
    },
    dynComponent () {
      // const id = this.$store.state.currentItem.id
      const template = this.currentItemContent ? this.currentItemContent : '<div></div>'
      return {
        template, // use content as template for this component
        props: this.$options.props // re-use current props definitions
      }
    }
  },
  beforeUpdate () {
  },
  mounted () {
    const xSections = document.getElementsByClassName('x-section')
    if (xSections) {
      this.xSections = xSections
    }
    function handleScrollF() {
      const sections = Array.prototype.slice.call(this.xSections)
      sections.forEach(section => {
        const top = section.getBoundingClientRect().top
        if (top < 100) {
          const re = /-(\d+)$/
          const match = re.exec(section.id)
          let id = match[1]
          return this.$store.dispatch('setCurrentPageSection', {id})
        }
      })
    }
    this.handleScroll = _.debounce(handleScrollF, 50)
  },
  updated () {
    const blocks = this.$el.querySelectorAll('code')
    // debugger
    blocks.forEach(function(block) {
      hljs.highlightBlock(block);
    });
    const id = this.$store.state.currentItem.id
    const item = JSON.search(this.data, '//*[id="' + id + '"]')[0]
    overrideXFrame(item, this.$store.state.leotext)
    const clinks = document.getElementsByClassName('csection-link')
    let leodata = this.$store.state.leodata
    let me = this
    // section links in code content require explicit processing bc vue components
    // are turned off in code (with v-pre)
    function gotoSectionFunc (leodata) {
       function func (e) {
         try {
           let item = JSON.search(leodata, '//*[name="' + e.srcElement.innerHTML + '"]')[0]
           console.log('ITEM', item)
           let id = item.id
           me.$store.dispatch('setCurrentItem', {id})
         } catch (e) {
           console.log('goto section error:', e)
         }
       }
       return func
    }
    for (let i = 0; i < clinks.length; i++) {
      let clink = clinks[i]
      clink.onclick = gotoSectionFunc(leodata)
    }
  },
  watch: {
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
  .handle-button {
    height:20px;
    width: 20px;
    margin-left: auto;
    margin-right: auto;
    cursor: pointer;
    text-align: center;
    position: fixed;
    top: 50%;
    transform: translateY(-50%);
    color: #ccf;
    margin-left: 9px;
  }
  #lhandle {
    max-width: 50px;
    margin-right: 1%;
  }
  #rhandle {
    float: right;
  }
  .handle {
    width:50px;
    // align-items: center;
    //flex: auto;
    display: inline-block;
  }
  .right-cpane {
    flex: auto;
    background: #fff;
    padding: 0px;
    // padding-top: 33px;
    //max-width: 720px;
    //width: 700px;
    min-width: 500px;
    //overflow: auto;
    height: calc(100vh - 33px);
  }
  p {
    line-height:1.3em;
  }
  #vpane {
    width: 100%;
    background: #fff;
    //height: 400px;
    height: calc(100vh - 33px);
  }
  #bpane {
    width: 100%;
    background: #fff;
    height: calc(100vh - 33px);
    overflow: scroll;
  }
  #tlayout {
    background: #fff;
    min-height: 100%;
    margin: 0;
    margin-left: 5%;
    padding: 0;
    display: flex;
    flex-wrap: nowrap;
    justify-content: center;
  }
  .pane {
    // height: 100%;
    background: #fff;
    width: 100%;
    position: relative;
  }
  .voutline {
  }
</style>
