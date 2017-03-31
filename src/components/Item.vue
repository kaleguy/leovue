<template>
  <li>
    <div
      :class="{bold: isFolder, active: active}"
      @click="toggle">
      <span v-if="isFolder">{{isOpen ? '▼' : '▶'}}</span>
      {{model.name}}
    </div>
    <ul v-show="isOpen" v-if="isFolder">
      <item
        class="item"
        v-for="model in model.children"
          :model="model"
          :textItems="textItems"
          :targetEl="targetEl">
      </item>
    </ul>
  </li>
</template>

<script>
var marked = require('marked')
var hljs = require('highlight.js')
let currentNode = null
let initialized = false
function showText (title, rightPane, text) {
  if (!text) {
    rightPane.innerHTML = ''
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
    rightPane.innerHTML = `<textarea readonly>${text}</textarea>`
    return
  }
  // remove directives from first line
  if (/^\s*?@/.test(text)) {
    text = removeFirstLine(text)
  }
  switch (language) {
    case 'md':
      text = marked(text)
      rightPane.innerHTML = text
      break
    case 'html':
      rightPane.innerHTML = text
      break
    default:
      text = `<pre><code class="${language}">${text}</code></pre>`
      rightPane.innerHTML = text
      hljs.highlightBlock(rightPane)
  }
}
function getLanguage (text) {
  var language = ''
  var re = /^@language (\w+)/
  var languageTokens = re.exec(text)
  if (languageTokens) {
    language = languageTokens[1]
    console.log(language)
  }
  return language
}

function removeFirstLine (text) {
  return text.split(/[\n]/).splice(1).join('\n')
}
import router from '../router'
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
    if (!currentNode) {
      currentNode = this
      this.active = true
    }
    if (this.model.sel) {
      console.log('hhhh', this.model.id)
      this.openFlag = true
    }
    if (this.model.sel === 2) {
      currentNode = this
      this.active = true
      showText(this.model.name, this.targetEl, this.textItems[this.model.t])
    }
  },
  updated () {
    if (this.showContent && this.model.text && !initialized) {
      initialized = true
      showText(this.model.name, this.targetEl, this.model.text)
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

