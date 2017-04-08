<template>
  <li>
    <div
      :class="{bold: isFolder, active: active}"
      @click="toggle">
      <span v-if="isFolder">{{isOpen ? '▼' : '▶'}}</span>
      {{vtitle}}
    </div>
    <ul v-show="isOpen" v-if="isFolder">
      <item
        class="item"
        v-for="model in model.children"
          :model="model"
          :key="model.id"
          :textItems="textItems"
          :targetEl="targetEl">
      </item>
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
  // TODO: replace this with Vuex
  document.getElementById('tlayout').style.display = 'block'
  document.getElementById('vpane').style.display = 'none'
  if (/^\[/.test(title)) {
    return showSite(title, panel)
  }
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
        html = replaceRelUrls(html, base)
        panel.innerHTML = html
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
  // TODO: replace this with Vuex
  document.getElementById('tlayout').style.display = 'none'
  document.getElementById('vpane').style.display = 'block'
  panel = document.getElementById('vpane')
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
export default {
  name: 'item',
  props: {
    open: Boolean,
    model: Object,
    showContent: Boolean,
    targetEl: Element,
    textItems: Object
  },
  data: function () {
    return {
      reset: true,
      openFlag: false,
      active: false,
      initialized: false
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
    }
  },
  methods: {
    toggle: function () {
      this.reset = false
      if (this.isFolder) {
        this.openFlag = !this.openFlag
      }
      if (currentNode) {
        currentNode.active = false
      }
      currentNode = this
      currentNode.active = true
      showText(this.model.name, this.targetEl, this.textItems[this.model.t])
      router.push({name: 'Node', params: { id: this.model.id }})
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
      this.initialized = true
      showText(this.model.name, this.targetEl, this.textItems[this.model.t])
    }
    if (!currentNode) {
      currentNode = this
      this.active = true
    }
  },
  updated () {
    if (this.showContent && this.model.t && !this.initialized) {
      this.initialized = true
      showText(this.model.name, this.targetEl, this.textItems[this.model.t])
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->


<style scoped>
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
  .active {
    background: #81ff00;
  }
  .activeb {
    background: #81ff00;
    font-weight:bold;
  }
  li > div {
    padding-left:4px;
  }
</style>

