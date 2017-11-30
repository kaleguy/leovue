<template>
  <div class="pane">
    <div v-show="textContent"
         id="tlayout">
      <div id="lhandle"
           class="handle">
        <div class="handle-button"
             v-show="hasPrev"
             @click="goPrev">
          <icon class="icon"
                name="chevron-left"></icon>
        </div>
      </div>
      <div class="right-cpane">
        <component :is="dynComponent" v-bind="$props"/>
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
    <div v-show="iframeContent"
         style="min-height:100%; display:flex; background:#fff; width: 100%"
         v-html="iframeHTML"
         id="vpane">
    </div>
  </div>
</template>

<script>
import router from '../router'
import {presentation} from '../lib/presentation'
const util = require('../util.js')

// functions for dealing with x-frame headers
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
  // iframe.src = window.url
  loadURL(window.url)
}
// end functions for dealing with x-frame headers

function loadPresentation(item, textItems, iframe) {
  let content = ''
  item.children.forEach((page, index) => {
    let pageContent = textItems[page.t]
    // page.presentation = {id: item.id, index}
    content = content + '<section>' +  util.formatText(pageContent, true) + '</section>'
  })
  const html = presentation(item.name, content)
  iframe.contentWindow.document.open()
  // iframe.contentWindow.document.write(html.replace(/<head>/i, '<head><base href="' + url + '"><scr' + 'ipt>document.addEventListener("click", function(e) { if(e.target && e.target.nodeName == "A") { e.preventDefault(); parent.loadURL(e.target.href); } });</scr' + 'ipt>'))
  iframe.contentWindow.document.write(html)
  iframe.contentWindow.document.close()
}

export default {
  name: 'contentpane',
  components: {
  },
  data () {
    return {
    }
  },
  methods: {
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
    }
  },
  computed: {
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
      const id = this.$store.state.currentItem.id
/*
      if (id) {
        console.log(this.data)
        const item = JSON.search(this.data, '//!*[id="' + id + '"]')[0]
        if (item.presentation && item.presentation.index > 0) {
          console.log('I', item.presentation.index)
          return
        }
      }
*/
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
  },
  updated () {
    const id = this.$store.state.currentItem.id
    const item = JSON.search(this.data, '//*[id="' + id + '"]')[0]
    overrideXFrame(item, this.$store.state.leotext)
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
  }
  .handle {
    width:50px;
    align-items: center;
    flex: auto;
    display: flex;
  }
  .right-cpane {
    flex: auto;
    background: #fff;
    padding:0px;
    padding-top: 33px;
    max-width: 620px;
    width: 620px;
    min-width: 500px;
    height: calc(100vh - 33px);
    overflow: auto;
  }
  p {
    line-height:1.3em;
  }
  #vpane {
    width: 100%;
    background: #fff;
    height: 100%;
  }
  #tlayout {
    background: #fff;
    min-height: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    flex-wrap: nowrap;
  }
  .pane {
    height: 100%;
    background: #fff;
    width: 100%;
    position: relative;
  }
  .voutline {
  }
</style>
