<template>
  <li>
    <div
      :class="{bold: isFolder, active: active}"
      @click="toggle">
      <span v-if="isFolder">{{open ? '▼' : '▶'}}</span>
      {{model.name}}
    </div>
    <ul v-show="open" v-if="isFolder">
      <item
        class="item"
        v-for="model in model.children"
        :model="model"
        :targetEl="targetEl">
      </item>
    </ul>
  </li>
</template>

<script>
var marked = require('marked')
var hljs = require('highlight.js')
let currentNode = null
function showText (title, rightPane, text) {
  if (!text) { return }

  let language = getLanguage(text)

  if (/^\s*@clean/.test(title)) {
    var re = /(?:\.([^.]+))?$/
    var ext = re.exec(title)[1]
    var ng = ['txt', 'md', 'html']
    if (ng.indexOf(ext) === -1) {
      language = ext
    }
  }
  // just plain text
  if (!language) {
    rightPane.innerHTML = `<textarea readonly>${text}</textarea>`
    return
  }

  // remove directives
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
export default {
  name: 'item',
  props: {
    model: Object,
    targetEl: Element
  },
  data: function () {
    return {
      open: false,
      active: false
    }
  },
  computed: {
    isFolder: function () {
      return this.model.children && this.model.children.length
    }
  },
  methods: {
    toggle: function () {
      if (this.isFolder) {
        this.open = !this.open
      }
      if (currentNode) {
        currentNode.active = false
      }
      currentNode = this
      currentNode.active = true

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
  li > div {
    padding-left:4px;
  }
</style>

