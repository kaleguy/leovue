import _ from 'lodash'
const hljs = require('highlight.js')
// const pug = require('pug')
const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})

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

function parseQueryString (config, url) {
  var urlParams = {}
  url.replace(
    new RegExp('([^?=&]+)(=([^&]*))?', 'g'),
    function ($0, $1, $2, $3) {
      urlParams[$1] = $3
    }
  )
  for (let k in urlParams) {
    let v = urlParams[k]
    if (/#/.test(v)){
      v = v.substring(0, v.indexOf('#'))
    }
    if (typeof v !== 'undefined') {
      config[k] = v.replace(/%2F/g, '/').replace(/%27/g, "'")
    }
  }
  const hash = window.location.hash
  let baseMode = 't'
  if (window.lconfig.baseMode) { baseMode = window.lconfig.baseMode }
  if (!hash || hash.length < 3) {
    //window.location.hash = baseMode + '/1'
    //window.location = window.location
  }
  return urlParams
}
/**
 * return formatted text, e.g. markdown or html
 * @param text {string}
 * @returns {string}
 */
function formatText (text, noWrapper) {
  if (!text) { return '' }
  let language = getLanguage(text)

  // text = text.replace(/<</g, '\u00AB')
  // text = text.replace(/>>/g, '\u00BB')
  text = text.replace(/<<(.*?)>>/g, '<sectionlink :title="\'$1\'"/>')
  // text = text.replace(/<<(.*?)>>/g, '<div class=section-link">«$1»</div>')
  text = text.replace(/\[\[(.*?)\]\]/g, '<nodelink :title="\'$1\'"/>')

  // just plain text
  if (!language) {
    language = 'plaintext'
  }
  // remove directives from first line
  if (/^\s*?@/.test(text)) {
    text = removeFirstLine(text)
  }
  let mu = ''
  switch (language) {
    case 'text':
      text = `<div class="text">${text}</div>`
      break
    case 'plaintext':
      text = `<div class="text">${text}</div>`
      break
    case 'md':
      text = md.render(text)
      text = text.replace(/src="https:.*?https:/g, 'src="https:') // hack to fix md not handling absolute urls
      break
    case 'pug': // eslint-disable-line
      text = window.pug.render(text) // need to add pug for this to work, see commented out code in index.html
    case 'python':
      text = processPython(text)
      break
    case 'html':
      break
    case 'VueComponent':
      const muv = hljs.highlight('javascript', text)
      text = muv.value
      text = `<pre>${text}</pre>`
      break
    default:
      text = hiliteCode(text, language)
  }
  if (noWrapper) { return text }
  text = `<div class='content'>${text}</div>`
  return text
}

function sendGTag (item) {
  if (_.isUndefined(gtag)) { return } // eslint-disable-line
  gtag('config', 'UA-118289537-1', {  // eslint-disable-line
    'page_title': item.name,
    'page_path': '#/t/' + item.id,
    't': item.t
  })
}
/**
 * Chop the end of a string off
 * @param s {string} The input string
 * @param c {string} The character from which the string will be chopped
 * @returns {string} The chopped string
 */
function chop (s, c) {
  if (s.indexOf(c) < 0) { return s }
  return s.substring(0, s.lastIndexOf(c))
}

function hiliteCode(text, language) {
  text = text.replace(/<sectionlink :title="'(.*?)'"\/>/g, '«$1»')
  text = text.replace(/<sectionlink title="(.*?)"\/>/g, '«$1»')
  const mu = hljs.highlight(language, text)
  text = mu.value
  text = `<pre v-pre>${text}</pre>`
  text = text.replace(/«(.*?)»/g, '<span class="csection-link">«$1»</span>')
  return text
}

function processPython(t) {
  const a = t.split(/\n/)
  const b = []
  let c = []
  let buffer = ''
  let inDocString = false
  a.forEach(line => {
    if (/'''/.test(line)) {
      inDocString = !inDocString
      if (!inDocString) {
        c = c.map(line => line.replace(/^\s*?\|/g, '').replace(/</g, '&lt;').replace(/>/, '&gt;').replace(/^\s*?#/,''))
        let docString = c.join('\n')
        docString = md.render(docString)
        b.push(docString)
        c = []
      } else {
        buffer = hiliteCode(buffer, 'python')
        b.push(buffer)
        buffer = ''
      }
      return // skip this line
    }
    if (inDocString) {
      return c.push(line)
    }
    // line = processSingleDocstring(line)
    buffer = buffer + '\n' + line
  })
  t = b.join('') + hiliteCode(buffer, 'python')
  return t
}

function processSingleDocstring(t) {
  if (/"""/.test(t)) {
  }
  return t
}

function processDocstring(t) {
  if (/'''/.test(t)) {
    t = t.replace(/'''/, '</pre>')
    t = t.replace(/'''/, '<pre>')
    t = t.replace(/\|/g, '')
    t = md.render(t)
  }
  return t
}

function getObjectByKeyFromTree (d, k, v) {
  if (d[k].indexOf(v) > -1) {
    return d
  }
  if (!d.children) { return '' }
  for (let i = 0; i < d.children.length; i++) {
    let o = getObjectByKeyFromTree(d.children[i], k, v)
    if (o) { return o }
  }
}

// parseQueryString(window.location.href)

module.exports = {
  replaceRelUrls,
  getFileExtension,
  getLanguage,
  removeFirstLine,
  parseQueryString,
  formatText,
  getObjectByKeyFromTree,
  sendGTag,
  chop
}

/*
 showContent: function () {
 let targetEl = this.targetEl
 if (!targetEl) {
 this.inline = true
 }
 // test for presence of url in title, if so it is external content
 if (/^\[/.test(this.model.name)) {
 return showSite.call(this, this.model.name, this.inline)
 } else {
 this.$store.commit('CONTENT_PANE', {type: 'text'})
 showText.call(this, this.textItems[this.model.t])
 }
 }
 */

/* ,
 setContent: function () {
 if (this.model.t && !this.initialized && (this.$store.state.currentItem.id === this.model.id)) {
 this.$store.commit('INIT') // set that current item has been shown
 this.showContent()
 }
 if ((!this.targetEl) && this.isOpen && (this.$store.state.currentItem.id !== this.model.id)) {
 this.showContent()
 }
 }
 */

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


