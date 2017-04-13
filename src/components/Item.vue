<template>
  <li>
    <div
      :class="{bold: isFolder, active: active}"
      @click="toggle">
      <span v-if="isFolder">
        <div class="arrow" v-bind:class="{arrowdown: isOpen}">▶</div>
      </span>
      {{vtitle}}
    </div>
    <div v-show="inline" :id="'item-' + model.id" class="inline"></div>
    <ul style="display:none" v-if="isFolder">
      <item
        class="item"
        v-for="model in model.children"
          :model="model"
          :key="model.id"
          :textItems="textItems"
          :vTargetEl="vTargetEl"
          :targetEl="targetEl">
      </item>
      <div v-show="inline" class="hshim"></div>
    </ul>
  </li>
</template>

<script>

const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})

const hljs = require('highlight.js')
let currentNode = null
function showText (title, panel, text) {
  if (!text) {
    panel.innerHTML = ''
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
    panel.innerHTML = `<div class="text">${text}</div>`
    return
  }
  // remove directives from first line
  if (/^\s*?@/.test(text)) {
    text = removeFirstLine(text)
  }
  switch (language) {
    case 'md':
      text = md.render(text)
      panel.innerHTML = text
      break
    case 'html':
      panel.innerHTML = text
      break
    default:
      text = `<pre><code class="${language}">${text}</code></pre>`
      panel.innerHTML = text
      hljs.highlightBlock(panel)
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
      .then(function (response) {
        let html = md.render(response.data)
        html = '<div class="md">' + html + '</div>'
        html = replaceRelUrls(html, base)
        panel.innerHTML = html
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
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

function removeFirstLine (text) {
  return text.split(/[\n]/).splice(1).join('\n')
}
import router from '../router'
import axios from 'axios'
import Velocity from 'velocity-animate'
export default {
  name: 'item',
  props: {
    open: Boolean,
    model: Object,
    showContentFlag: Boolean,
    targetEl: Element,
    vTargetEl: Element,
    textItems: Object
  },
  data: function () {
    return {
      reset: true,
      openFlag: false,
      active: false
    }
  },
  computed: {
    isFolder: function () {
      return this.model.children && this.model.children.length
    },
    isOpen: function () {
      return this.open || this.openFlag
    },
    isActive: function () {
      return this.active
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
    },
    inline () {
      return ((!this.targetEl) && this.isOpen)
    }

  },
  methods: {
    toggle: function () {
      const duration = 300
      const easing = 'easeOutExpo'
      this.reset = false
      if (this.isFolder) {
        this.openFlag = !this.openFlag
        const ul = this.$el.getElementsByTagName('UL')[0]
        ul.style.display = 'block'
        if (this.isOpen) {
          Velocity(ul, 'slideDown', {duration: duration, easing: easing})
        } else {
          Velocity(ul, 'slideUp', {duration: duration, easing: easing})
        }
      }
      if (currentNode) {
        currentNode.active = false
      }
      currentNode = this
      currentNode.active = true
      this.showContent()
      var routeName = this.$route.name
      router.push({name: routeName, params: { id: this.model.id }})
    },
    showContent: function () {
      if (!this.targetEl) {
        const contentEl = document.getElementById('item-' + this.model.id)
        showText(this.model.name, contentEl, this.textItems[this.model.t])
        return
      }
      if (/^\[/.test(this.model.name)) {
        this.$store.commit('CONTENT_PANE', {type: 'site'})
        return showSite(this.model.name, this.vTargetEl)
      } else {
        this.$store.commit('CONTENT_PANE', {type: 'text'})
        showText(this.model.name, this.targetEl, this.textItems[this.model.t])
      }
    }
  },
  mounted () {
    if (this.model.sel) {
      this.openFlag = true
    }
    if (this.model.sel === 2) {
      currentNode.active = false
      currentNode = this
      this.active = true
      this.$store.commit('INIT')
      this.showContent()
    }
    if (!currentNode) {
      currentNode = this
      this.active = true
    }
  },
  updated () {
    if (this.showContentFlag && this.model.t && !this.initialized) {
      this.$store.commit('INIT')
      this.showContent()
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->


<style scoped>
  .arrow {
    -webkit-transition: all .1s ease;
    transition: all .1s ease;
    text-align: center;
    display: inline-block;
    width: 20px;
  }
  .arrowdown {
    -webkit-transform: rotate(90deg);
    transform: rotate(90deg);
  }
  .item {
    cursor: pointer;
  }
  .bold {
    font-weight: bold;
  }
  ul {
    padding-left: 1em;
    line-height: 1.5em;
    list-style-type: none;
  }
  li {
    white-space: nowrap;
  }
  li > div {
    padding-left:4px;
  }
  .active {
    background: #81ff00;
  }
  .activeb {
    background: #81ff00;
    font-weight:bold;
  }
  .inline {
    max-width: 700px;
    white-space: normal;
    padding:30px;
  }
  .hshim {
    height: 40px;
  }
</style>

