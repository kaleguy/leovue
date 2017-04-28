<template>
  <li :x-id="model.id">
    <div
      :class="{bold: isFolder, active: active, topItem: top}"
      @click="toggle">
      <div v-bind:class="{'icon-bracket': top}"
           style="display:inline-block;
           padding-left:3px;
           padding-right:3px;"
           v-if="isFolder">
        <div class="arrow"
             v-bind:class="{arrowdown: isOpenA}">▶</div>
      </div>
      <span class="otitle">{{vtitle}}</span>
    </div>
    <div v-show="isOpen" class="child-items">
      <div v-show="isOpenInline"
           :id="'item-' + model.id"
           v-html="myContent"
           class="inline">
      </div>
      <ul v-if="isFolder">
        <item
          class="item"
          v-for="model in model.children"
          :model="model"
          :key="model.id"
          :textItems="textItems"
          :vTargetEl="vTargetEl"
          :targetEl="targetEl">
        </item>
        <div v-show="isOpenInline" class="hshim"></div>
      </ul>
    </div>
  </li>
</template>

<script>

const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})

const hljs = require('highlight.js')
function showText (text) {
  if (!text) {
    this.$store.commit('CURRENT_ITEM_CONTENT', { text })
    return
  }
  let language = getLanguage(text)

  text = text.replace(/<</g, '\u00AB')
  text = text.replace(/>>/g, '\u00BB')

  /*
  // get language from extension
  if (/^\s*@clean/.test(title)) {
    var re = /(?:\.([^.]+))?$/
    var ext = re.exec(title)[1]
    var ng = ['txt', 'md', 'html']
    if (ng.indexOf(ext) === -1) {
      language = ext
    }
    const langs = {
      js: 'javascript',
      ts: 'typescript'
    }
    if (langs[ext]) {
      language = langs[ext]
    }
  }
  */

  // just plain text
  if (!language) {
    language = 'plaintext'
  }
  // remove directives from first line
  if (/^\s*?@/.test(text)) {
    text = removeFirstLine(text)
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
  this.$store.commit('CURRENT_ITEM_CONTENT', { text })
  if (this.inline) {
    this.myContent = text
  }
}

function replaceRelUrls (html, base) {
  const parser = new DOMParser()
  const doc = parser.parseFromString(html, 'text/html')
  const images = doc.images
  for (let i = 0; i < images.length; i++) {
    let image = images[i]
    let src = image.getAttribute('src')
    if (/http:/.test(src)) { return }
    if (/^\//.test(src)) {
      src = base + src
    } else {
      src = base + '/' + src
    }
    image.setAttribute('src', src)
  }
  return doc.body.innerHTML
}

function getFileExtension (filename) {
  const re = /(?:\.([^.]+))?$/
  const ext = re.exec(filename)[1]
  return ext
}
// TODO: replace DOM manipulation in this function?
function showSite (title, panel) {
  const re = /^\[(.*?)\]\((.*?)\)$/
  const match = re.exec(title)
  const url = match[2]
  if (!url) { return }
  const ext = getFileExtension(url)
  const base = url.substring(0, url.lastIndexOf('/'))
  // TODO: add spinner
  if (ext === 'md') {
    axios.get(url)
      .then((response) => {
        let html = md.render(response.data)
        html = '@language md\n<div class="md">' + html + '</div>'
        html = replaceRelUrls(html, base)
        showText.call(this, html)
        this.$store.commit('CONTENT_PANE', {type: 'text'}) // TODO: still needed?
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
  panel.className = 'vinline'
  const iframeHTML = `
    <iframe
       src="" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
  `
  panel.innerHTML = iframeHTML
  let iframe = document.getElementsByTagName('iframe')[0]
  iframe.src = url
  this.$store.commit('CONTENT_PANE', {type: 'site'})
}

function getLanguage (text) {
  let language = ''
  const re = /^@language (\w+)/
  let languageTokens = re.exec(text)
  if (languageTokens) {
    language = languageTokens[1]
  }
  return language
}

/*
function getParentEls (arr, el) {
  if (el.parentElement) {
    arr.push(el.parentElement)
    getParentEls(arr, el.parentElement)
  } else {
    return arr
  }
}
*/

function removeFirstLine (text) {
  return text.split(/[\n]/).splice(1).join('\n')
}
import axios from 'axios'
import Velocity from 'velocity-animate'
export default {
  name: 'item',
  props: {
    model: Object,
    targetEl: Boolean,
    vTargetEl: Element,
    textItems: Object,
    top: Boolean
  },
  data: function () {
    return {
      reset: true,
      openFlag: false,
      inline: false,
      closearrow: false,
      myContent: ''
    }
  },
  computed: {
    isFolder: function () {
      return this.model.children && this.model.children.length
    },
    isOpen: function () {
      const ids = this.$store.state.openItemIds
      let open = true
      if (ids.indexOf(this.model.id) === -1) { open = false }
      return open
    },
    isOpenInline: function () {
      return this.isOpen && this.inline
    },
    isOpenA: function () {
      return this.isOpen && !this.closearrow
    },
    active: function () {
      if (!this.model) { return }
      return this.$store.state.currentItem.id === this.model.id
    },
    vtitle: function () {
      const re = /^\[(.*?)\]\((.*?)\)$/
      const match = re.exec(this.model.name)
      if (!match) {
        return this.model.name
      }
      const title = match[1]
      if (title) {
        return title
      } else {
        return this.name
      }
    },
    initialized () {
      return this.$store.state.initialized
    }
  },
  methods: {
    toggle: function () {
      // toggle the tree node
      let duration = 200
      const easing = 'linear'
      this.reset = false // TODO: remove
      // toggle the open/close state of the item
      let openItemIds = this.$store.state.openItemIds.slice(0)
      if (!this.isOpen) {
        openItemIds.push(this.model.id)
      } else {
        const a = []
        openItemIds.forEach((id) => {
          if (id === this.model.id) {
          } else {
            a.push(id)
          }
        })
        openItemIds = a
        this.closearrow = true
      }
      let inline = true
      if (this.targetEl) {
        inline = false
      }
      this.inline = inline
      if (this.isFolder) {
        const ul = this.$el.getElementsByClassName('child-items')[0]
        const il = this.$el.getElementsByClassName('inline')[0]
        ul.style.display = 'block'
        if (inline) {
          il.style.display = 'block'
        }
        if (!this.isOpen) {
          // const me = this
          this.$store.commit('OPEN_ITEMS', {openItemIds})
          Velocity(ul, 'slideDown', {duration, easing}).then((els) => {
          })
          // if (inline){
          //  Velocity(il, 'slideDown', {duration, easing})
          // }
        } else {
          Velocity(ul, 'slideUp', {duration, easing}).then((els) => {
            this.$store.commit('OPEN_ITEMS', {openItemIds})
            this.closearrow = false
            // this.inline = false
            // if (inline){
            //  Velocity(ul, 'slideDown', {duration, easing})
            // }
          })
        }
      }
      // toggle inline content if in inline mode
      if (inline && !this.isFolder) {
        duration = 300
        // TODO: refactor this
        let il = this.$el.getElementsByClassName('inline')[0]
        if (!il) {
          il = this.$el.getElementsByClassName('vinline')[0]
        }
        il.style.display = 'block'
        if (!this.isOpen) {
          Velocity(il, 'slideDown', {duration: duration, easing: easing})
          this.$store.commit('OPEN_ITEMS', {openItemIds})
        } else {
          const me = this
          Velocity(il, 'slideUp', {duration, easing}).then(function (els) {
            me.$store.commit('OPEN_ITEMS', {openItemIds})
            me.closearrow = false
          })
        }
      }

      // TODO: put this after Velocity promise
      const currentItem = {
        id: this.model.id
      }
      this.$store.commit('CURRENT_ITEM', currentItem)
    },
    showContent: function () {
      let targetEl = this.targetEl
      let vTargetEl = this.vTargetEl
      // let inline = false
      if (!targetEl) {
        this.inline = true
        vTargetEl = document.getElementById('item-' + this.model.id)
      }
      // test for presence of url in title, if so it is external content
      if (/^\[/.test(this.model.name)) {
        return showSite.call(this, this.model.name, vTargetEl)
      } else {
        this.$store.commit('CONTENT_PANE', {type: 'text'})
        showText.call(this, this.textItems[this.model.t])
      }
    },
    setContent: function () {
      if (this.model.t && !this.initialized && (this.$store.state.currentItem.id === this.model.id)) {
        this.$store.commit('INIT') // set that current item has been shown
        this.showContent()
      }
      if ((!this.targetEl) && this.isOpen && (this.$store.state.currentItem.id !== this.model.id)) {
        this.showContent()
      }
    }
  },
  watch: {
/*
    '$route': {
      handler: function (val, oldVal, changed) {
      },
      immediate: true
    }
*/
  },
  // TODO: refactor next two methocs
  mounted () {
    this.setContent()
  },
  updated () {
    this.setContent()
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->


<style scoped>
  .topItem SPAN {
    font-size: 30px;
  }
  .topItem {
    margin-bottom: 10px;
  }
  .topItemIcon {
    vertical-align: top;
    padding-left: 20px;
    margin-right: -10px;
  }
  .icon-bracket {
    display:inline-block;
    height: 100%;
    vertical-align: middle;
    padding-bottom: 8px;
    padding-left: 0;
  }
  .icon-bracket .arrow {
    display:inline-block;
    height: 100%;
    vertical-align: middle;
    padding-bottom: 2px;
    width: 20px;
  }
  .arrow {
    -webkit-transition: all .1s ease;
    transition: all .1s ease;
    text-align: center;
    display: inline-block;
    width: 11px;
    height: 21px;
    margin-top: 2px;
  }
  .arrowdown {
    -webkit-transform: rotate(90deg);
    transform: rotate(90deg);
  }
  .item {
    cursor: pointer;
    width: 100%;
  }
  .bold {
    font-weight: bold;
  }
  ul {
    padding-left: 1em;
    line-height: 1.4em;
    list-style-type: none;
    margin-bottom: 8px;
  }
  li {
    white-space: nowrap;
    min-width: 760px;
    margin-bottom: 4px;
    margin-top: 4px;
  }
  li > div {
    padding-left:4px;
  }
  .active {
    background: #81ff00;
    max-width: 762px;
  }
  .activeb {
    background: #81ff00;
    font-weight:bold;
  }
  .inline {
    max-width: 700px;
    white-space: normal;
    padding:30px;
    padding-top: 20px;
    padding-bottom: 20px;
    margin-top: 4px;
    margin-bottom: 16px;
    border:1px solid #ccc;
    border-radius: 4px;
    // box-shadow: -4px 0 8px -4px rgba(31, 31, 31, 0.8)
  }
  .vinline {
    max-width: 700px;
    white-space: normal;
    padding:0;
    padding-top: 0;
    padding-bottom: 0;
    margin-top: 4px;
    margin-bottom: 16px;
    height: 600px;
    width: 760px;
    border:1px solid #ccc;
    border-radius: 4px;
    overflow: auto;
  // box-shadow: -4px 0 8px -4px rgba(31, 31, 31, 0.8)
  }
  .hshim {
    height: 15px;
  }
  .otitle {
    padding-left: 4px;
  }
  .child-items {
    margin: 0;
    padding: 0;
  }
</style>

