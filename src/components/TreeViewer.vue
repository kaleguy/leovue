<template>
  <div class="treeviewer">
    <div class="panes-container">
      <div class="left-pane" id="left-pane">
        <ul id="demo">
          <item
            class="item"
            :model="data.data">
          </item>
        </ul>
      </div>
      <div class="panes-separator" id="panes-separator"></div>
      <div class="right-pane" id="right-pane">
      </div>
    </div>

  </div>
</template>

<script>
import Item from './Item'
import {getLeoJSON} from '../services/leo.js'

console.log(getLeoJSON)

let model = {
  data: {}
}

let leftPane
let rightPane
let paneSep
let currentNode = null

function showText (text) {
  if (!text) { return }

  let language = getLanguage(text)

  // just plain text
  if (!language) {
    rightPane.innerHTML = `<textarea readonly>${text}</textarea>`
    return
  }

  // remove directives
  text = removeFirstLine(text)

  switch (language) {
    case 'md':
     // text = marked(text)
      rightPane.innerHTML = text
      break
    case 'html':
      rightPane.innerHTML = text
      break
    default:
      text = `<pre><code class="${language}">${text}</code></pre>`
      rightPane.innerHTML = text
    //  hljs.highlightBlock(rightPane)
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
  name: 'treeviewer',
  components: {
    item: Item
  },
  data: function () {
    return {
      data: model,
      open: false,
      active: false
    }
  },
  computed: {
    isFolder: function () {
      return this.model.data.children && this.model.data.children.length
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
      showText(this.model.text)
    }
  },
  mounted: () => {
    leftPane = document.getElementById('left-pane')
    rightPane = document.getElementById('right-pane')
    paneSep = document.getElementById('panes-separator')
    rightPane.innerHTML = ''

    // The script below constrains the target to move horizontally between a left and a right virtual boundaries.
    // - the left limit is positioned at 10% of the screen width
    // - the right limit is positioned at 90% of the screen width
    var leftLimit = 0
    var rightLimit = 90

    paneSep.sdrag(function (el, pageX, startX, pageY, startY, fix) {
      fix.skipX = true
      if (pageX < window.innerWidth * leftLimit / 100) {
        pageX = window.innerWidth * leftLimit / 100
        fix.pageX = pageX
      }
      if (pageX > window.innerWidth * rightLimit / 100) {
        pageX = window.innerWidth * rightLimit / 100
        fix.pageX = pageX
      }
      var cur = pageX / window.innerWidth * 100
      if (cur < 0) {
        cur = 0
      }
      if (cur > window.innerWidth) {
        cur = window.innerWidth
      }
      var right = (100 - cur - 2)
      leftPane.style.width = cur + '%'
      rightPane.style.width = right + '%'
    }, null, 'horizontal')
    getLeoJSON().then(ldata => {
      model.data = ldata
      // console.log('xxx', data.name)
    })
    // data.name = 'xxxxx'
    // console.log(data)
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.treeviewer{
  height: 100%
}
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}


textarea {
  margin-top:20px;
  border: none;
  background-color: transparent;
  resize: none;
  outline: none;
  font-size:16px;
  font-family: Verdana;
  height:100%;
  width:100%;

}

.panes-container {
  display: flex;
  width: 100%;
  overflow: hidden;
}

.left-pane {
  width: 250px;
  background: #fff;
}

.panes-separator {
  width: 11px;
  background: #eee;
  position: relative;
  cursor: col-resize;
/*  background-image: url('vertical.png'); */
  background-repeat: no-repeat;
  background-position: 50%;
}

.right-pane {
  flex: auto;
  background: #fff;
}

.panes-container,
.panes-separator,
.left-pane,
.right-pane {
  margin: 0;
  padding: 0;
  height: 100%;
}
.right-pane {
  padding:10px;
  padding-top:0px;
}


</style>
