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

module.exports = {
  replaceRelUrls,
  getFileExtension,
  getLanguage,
  removeFirstLine
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

// get language from extension
/*
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
