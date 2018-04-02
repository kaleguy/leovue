import Vue from 'vue'
import Vuex from 'vuex'
import {getLeoJSON, transformLeoXML} from '../services/leo.js'
import router from '../router'
import axios from 'axios'
import _ from 'lodash'
// import CSV from 'csv-string'
import Papa from 'papaparse'
import xsl from '../lib/xsl'
const parserURI = require('uri-parse-lib')
const HTML5Outline = require('h5o')
const util = require('../util.js')
const md = require('markdown-it')({
  html: true,
  linkify: true,
  typographer: true
})
console.log('xsl', axios, 'test', xsl)
const lunr = require('lunr')

function loadIndex (titles, text) {
  const docs = loadIndexItems([], titles, text)
  // return indexItems
  let idx = lunr(function () {
    this.ref('id')
    this.field('text')
    docs.forEach(function (doc) {
      this.add(doc)
    }, this)
  })
  return {idx, docs}
}
function loadIndexItems (arr, titles, textItems) {
  if (!titles) { return arr }
  titles.forEach(item => {
    arr.push(
      {
        id: item.id,
        name: item.name,
        text: textItems[item.t]
      }
    )
    loadIndexItems(arr, item.children, textItems)
  })
  return arr
}

Vue.use(Vuex)

function showText (context, text, id, nowrapper) {
  context.commit('CONTENT_PANE', {type: 'text'})
  if (!text) {
    text = ''
    context.commit('CURRENT_ITEM_CONTENT', { text })
    return
  }
  text = util.formatText(text, nowrapper)
  // current (user selected) content item
  context.commit('CURRENT_ITEM_CONTENT', { text })
  // hash of all content items
  const newItem = { id, t: text }
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
}
/**
 * Get subtree names for preloading bookmarked nodes
 * @param acc {array} - accumulator
 * @param p {string} - path, e.g. 28-2-10-5
 * @param startIndex {integer} - start with O to get all
 */
function getRoots (acc, p, startIndex) {
  const i = p.indexOf('-', startIndex)
  if (i < 0) { return acc }
  acc.push(p.substring(0, i))
  return getRoots(acc, p, i + 1)
}
/**
 * Is url relative
 * @param url {string}
 * @returns {boolean} - if is relative
 */
function isRelative (url) {
  let ok = true
  if (/^[xh]ttp/.test(url)) { // xhttp is to indicate xframe header should be ignored
    return false
  }
  if (/^\//.test(url)) {
  //  return false
  }
  if (window.lconfig.filename) {
    return false
  }
  return ok
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
// load subtree - separate leo file loaded into node
function loadLeoNode (context, item) {
  console.log('LOADING SUBTREE')
  const p = new Promise((resolve, reject) => {
    const title = item.name
    const id = item.id
    let {url, label} = getUrlFromTitle(title)
    if (!url) { return }
    getLeoJSON(url, id).then(data => {
      let text = data.textItems
      data = data.data
      context.commit('ADDTEXT', {text})
      if (data.length === 1) {
        context.commit('RESET') // content item has not been drawn
        console.log('SUBTREE RESET')
        context.dispatch('setCurrentItem', {id})
        data = data[0]
        item.children = data.children
        item.t = data.t
        item.name = label // convert to regular title so won't reload
      } else { // TODO: trunkless load logic incomplete for subtrees
        item.name = label
        item.children = data
      }
      resolve(true)
    })
  }).catch(e => console.log('Error: ', e))
  return p
}
function getUrlFromTitle (title) {
  const re = /^\[(.*?)\]\((.*?)\)$/
  title = title.replace(/^@[a-zA-Z]*? /, '')
  const match = re.exec(title)
  if (!match) { return null }
  let url = match[2]
  let label = match[1]
  if (!url) { return null }
  if (isRelative(url)) {
    // url = 'static/' + url
  }
  // absolute urls require no further processing
  if (/^[xh]ttp/.test(url)) { // xttp will result in http call via proxy
    return {url, label}
  }
  let cname = window.lconfig.filename
  if (cname.indexOf('/') < 0) {
    cname = ''
  }
  if (cname) {
    let u = window.lconfig.filename
    u = chop(u, '#')
    u = chop(u, '?')
    u = chop(u, '/')
    url = u + '/' + url
  }
  return {url, label}
}
function showPresentation (context, title, id) {
  const dummy = Math.random()
  const iframeHTML = `
    <div style="width:100%">
    <iframe
       src="about:blank" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       dummy="${dummy}"
       frameBorder="0" />
    </div>
  `
  context.commit('IFRAME_HTML', { iframeHTML })
  context.commit('CONTENT_PANE', { type: 'site' })
}
function showKanban (context, title, id) {
  let text = `<kanban/>`
  context.commit('CURRENT_ITEM_CONTENT', { text })
  const newItem = { id, t: text }
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
  context.commit('CONTENT_PANE', { type: 'board' })
}
function showMermaid (context, title, id) {
  let text = `<mermaid-board/>`
  context.commit('CURRENT_ITEM_CONTENT', { text })
  const newItem = { id, t: text }
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
  context.commit('CONTENT_PANE', { type: 'board' })
}
function showRSS (context, id, url) {
  let query = url
  // xttp means, route it through YQL

  if (/^xttp/.test(url)) {
    url = url.replace(/^xttp/, 'http')
    query = 'https://query.yahooapis.com/v1/public/yql?q=' +
      encodeURIComponent('select * from xml where url="' +
        url + '"') + '&format=xml'
  }
  axios.get(query)
    .then((response) => {
      let data = response.data
      xsl.render(data, 'xml').then(html => {
        // html = util.replaceRelUrls(html, base)
        showText(context, html, id)
        context.commit('CONTENT_PANE', {type: 'text'})
      })
    })
    .catch(function (error) {
      console.log(error)
    })
}

/**
 * Create Leo outline from target url
 * @param context
 * @param item
 * @param id
 * @param subpath {String} If a literate url has been used, this is the subpath, e.g Dinosaur@Eytomology, 'Eytomology' will be thee subpath
 * @returns {Promise<any>}
 */
function showPageOutline (context, item, id, subpath) {
  if (!id) {
    id = item.id
  }
  return new Promise((resolve, reject) => {
    let {url, label} = getUrlFromTitle(item.name) // eslint-disable-line
    if (!url) { return }
    let site = url
    const t = parserURI(url)
    let host = t.host
    let yql = "select * from htmlstring where url='" + site + "' AND xpath='//*'"
    let resturl = "https://query.yahooapis.com/v1/public/yql?q=" + encodeURIComponent(yql) + "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys" //eslint-disable-line
    context.commit('CURRENT_ITEM_CONTENT', { text: '<div class="spin-box"><div class="single10"></div></div>' })
    axios.get(resturl)
      .then((response) => {
        let dummy = document.getElementById('dummy')
        if (dummy) {
          dummy.outerHTML = ''
        }
        dummy = document.createElement('section')
        dummy.setAttribute('id', 'dummy')
        dummy.style.display = 'none'
        document.body.appendChild(dummy)
        let html = response.data.query.results.result
        // nasty hack to fix some pages on wikipedia (evolution chart is missing a tag) TODO: replace this with a parser
        let bad1 = html.indexOf('<div class="toccolours searchaux"')
        if (bad1) {
          let bad2 = html.indexOf('<div class="hatnote navigation-not-searchable"', bad1)
          html = html.substring(0, bad1) + html.substring(bad2)
        }
        html = cleanHTML(html, host)
        dummy.innerHTML = html
        let contentHTML = html

        // HACK select subnode if wikipedia
        let wikiContentEl = dummy.getElementsByClassName('mw-content-ltr')[0]
        if (wikiContentEl) {
          contentHTML = wikiContentEl.innerHTML
        }
        // HACK Gitbooks
        let gbContentEl = dummy.getElementsByClassName('markdown-section')[0]
        if (gbContentEl) {
          contentHTML = gbContentEl.innerHTML
          dummy = gbContentEl
        }

        contentHTML = '<div class="outline-pane">' +
          '<div class="note-box">' +
          'Downloaded from ' +
          site +
          '</div>' +
          contentHTML +
          '</div>'
        const outline = HTML5Outline(dummy)
        const outlineItem = {}
        const textItems = {}
        counter = 0 // TODO: refactor this to remove external var
        outlineToItem(outline.sections[0], outlineItem, item.id, textItems, host)

        _.remove(outlineItem.children, c => c.name === 'Contents')
        const fullContentItem = {
          id: item.id + '-0',
          name: 'Full Page Content',
          t: item.id + '-0'
        }
        outlineItem.children.unshift(fullContentItem)
        const lines = []
        // wikipedia hack
        const toc = document.getElementById('toc')
        if (toc && toc.previousElementSibling) {
          getPriorContent(toc.previousElementSibling, lines, host)
        }
        let priorContent = lines.reverse().join('')
        textItems[item.id + '-' + 1] = '<div class="fp-pane">' +
          priorContent +
          textItems[item.id + '-' + 1] + '</div>'
        textItems[item.id] = textItems[id + '-' + 1] // contentHTML
        textItems[item.id + '-0'] = contentHTML
        item.t = item.id
        context.commit('ADDTEXT', {text: textItems})
        item.children[0] = outlineItem
        context.commit('RESET') // content item has not been drawn
        if (window.lconfig.path) {
          subpath = window.lconfig.path
        }
        if (subpath) {
          let pathObj = translatePath(subpath, context.state.leodata)
          id = pathObj.npath
        }
        context.commit('CURRENT_ITEM', {id})
        context.commit('CURRENT_ITEM_CONTENT', { text: textItems[id] })
        item.children = outlineItem.children
        resolve(true)
      })
      .catch(function (error) {
        console.log(error)
        reject(error)
      })
  })
}
// TODO: possibly replace this with util.replaceRelUrls
function replaceRelLinks (host, content) {
  content = content.replace(/href="\/([a-zA-Z])/g, 'target="_blank" href="//' + host + '/$1')
  content = content.replace(/src="\/([a-zA-Z])/g, 'src="//' + host + '/$1')
  content = content.replace(/srcset="\//g, 'srcset="//' + host + '/')
  content = content.replace(/, \/static\/images/g, ', ' + '//' + host + '/static/images')
  return content
}

/**
 * Used by outlines
 * @param startNode
 * @param lines
 */
function getLeadContent (startNode, lines, host) {
  const sectionTags = ['H1', 'H2', 'H3', 'H4', 'H5']
  if (sectionTags.indexOf(startNode.tagName) > -1) {
    return
  }
  const nextSibling = startNode.nextElementSibling
  if (!nextSibling) { return }
  const cleanedHTML = cleanHTML(startNode.outerHTML, host)
  lines.push(cleanedHTML)
  getLeadContent(nextSibling, lines, host)
}

/**
 * Need this to fix html after retrieve from DOM
 * @param html
 * @returns {*}
 */
function cleanHTML (html, host) {
  // remove script tags
  html = html.replace(/<script(?:(?!\/\/)(?!\/\*)[^'"]|"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|\/\/.*(?:\n)|\/\*(?:(?:.|\s))*?\*\/)*?<\/script>/g, '')
  html = html.replace(/>\s+?,/g, '>,')
  html = html.replace(/>\s+?\./g, '>.')
  html = html.replace(/>\s+?["]/g, '>,"')
  html = html.replace(/\( "/g, '("')
  html = html.replace(/" \)/g, '")')
  html = replaceRelLinks(host, html)
  // html = html.replace(/>\s+?[.]/g, '.')
  return html
}

/**
 * For outlines: section prior to 2nd heading (for sites like Wikipedia
 * that don't have siblings to first heading).
 * @param startNode
 * @param lines
 */
function getPriorContent (startNode, lines, host) {
  const sectionTags = ['H1', 'H2', 'H3', 'H4', 'H5']
  if (sectionTags.indexOf(startNode.tagName) > -1) {
    return
  }
  const prevSibling = startNode.previousElementSibling
  if (!prevSibling) { return }
  lines.push(cleanHTML(startNode.outerHTML, host))
  getPriorContent(prevSibling, lines)
}

// TODO: do this without external var
let counter = 0
function outlineToItem (outline, item, idBase, textItems, host) {
  if (!outline.heading) {
    return
  }
  counter = +counter + 1
  item.id = idBase + '-' + counter
  item.name = getHeadingText(outline.heading.innerText)
  item.t = item.id
  const sections = outline.sections
  const html = getHTMLFromSection(outline, host)
  textItems[item.id] = html //  if (!sections || !sections.length) { return }
  item.children = []
  sections.forEach((section, i) => {
    let childItem = {}
    outlineToItem(section, childItem, +idBase, textItems, host)
    item.children.push(childItem)
  })
  return item
}
function getHeadingText (h) {
  if (!h) {
    h = ''
  }
  try {
    h = h.replace(/\n/g, '').replace(/\[.*?\]/i, '').trim()
  } catch (e) {
    console.log('Error in outline parse heading:', e)
  }
  return h
}
function getHTMLFromSection (outline, host) {
  const html = []
  const sections = outline.sections
  let content = ''
  const nextSibling = outline.startingNode.nextElementSibling
  if (nextSibling) {
    const contentArray = []
    getLeadContent(nextSibling, contentArray, host)
    content = contentArray.join('')
  }
  if (content) {
    html.push(content)
  }
  sections.forEach(section => {
    let heading = getHeadingText(section.heading.innerText)
    if (heading === 'Contents') { return } // wikipedia specific
    heading = `<sectionlink :title="'${heading}'"/>`
    if (heading) {
      html.push(heading)
    }
  })
  return '<div class="outline-pane">' + html.join('<br>') + '</div>'
}
function showD3Board (context, title, id) {
  let text = `<d3-board/>`
  context.commit('CURRENT_ITEM_CONTENT', { text })
  const newItem = { id, t: text }
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
  context.commit('CONTENT_PANE', { type: 'board' })
}
function showSite (context, title, id, content) {
  let {url, label} = getUrlFromTitle(title) // eslint-disable-line
  if (!url) { return }
  const ext = util.getFileExtension(url)
  const base = url.substring(0, url.lastIndexOf('/'))
  if (ext === 'md') {
    axios.get(url)
      .then((response) => {
        let html = md.render(response.data)
        html = '@language md\n<div class="md">' + html + '</div>'
        html = util.replaceRelUrls(html, base)
        // html = util.formatText(html)
        showText(context, html, id)
        context.commit('CONTENT_PANE', {type: 'text'})
      })
      .catch(function (error) {
        console.log(error)
      })
  }
  if (ext === 'xml') {
    showRSS(context, id, url)
  }
  const iframeHTML = `
    <div style="width:100%">
    <iframe
       src="${url}" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
    </div>
  `
  context.commit('IFRAME_HTML', {iframeHTML})
  context.commit('CONTENT_PANE', {type: 'site'})
  // context.commit('CONTENT_ITEM_UPDATE')
}

function setSiteItem (context, title, id) {
  let {url, label} = getUrlFromTitle(title)
  if (!url) { return }
  console.log(label) // TODO: remove this, it is here for eshint
  const ext = util.getFileExtension(url)
  const base = url.substring(0, url.lastIndexOf('/'))
  context.commit('CURRENT_ITEM_CONTENT', { text: '<div class="spin-box"><div class="single10"></div></div>' })
  if (ext === 'md') {
    axios.get(url)
      .then((response) => {
        let html = md.render(response.data)
        html = '@language md\n<div class="md">' + html + '</div>'
        html = util.replaceRelUrls(html, base)
        html = util.formatText(html)
        const newItem = {
          id: id,
          t: html
        }
        context.commit('CONTENT_ITEM_UPDATE')
        context.commit('CONTENT_ITEM', {item: newItem})
      })
      .catch(function (error) {
        console.log(error)
      })
    return
  }
  const iframeHTML = `
    <div class="vinline">
    <iframe
       src="${url}" height="100%" width="100%"
       marginwidth="0" marginheight="0"
       hspace="0" vspace="0"
       frameBorder="0" />
    </div>
  `
  const newItem = {
    id: id,
    t: iframeHTML
  }
  // context.commit('IFRAME_HTML', {iframeHTML})
  context.commit('CONTENT_ITEM', {item: newItem})
  context.commit('CONTENT_ITEM_UPDATE')
}

/**
 * setData Set data loaded from the Leo file, get content for open items (from path).
 * @param context
 * @param ldata
 * @param filename
 * @param route
 */
function setData (context, ldata, filename, route) {
  context.commit('RESET') // content item has not been drawn
  context.commit('INIT_DATA') // loaded the leo data
  context.commit('LEO', {
    data: ldata.data,
    text: ldata.textItems,
    filename: filename
  })
  loadDataSets(context, ldata)
  loadDataTables(context, ldata)
  loadPresentations(ldata.data[0])
  setLanguageNodes(context, ldata)
  setChildDirectives(context, ldata)
  // TODO: refactor use of id vs route.path
  let id = route.params.id
  // check if path is a literate path, translate to number (look up matching node name)
  const pathObj = translatePath(id, ldata.data)
  id = pathObj.npath
  if (!id) {
    id = '1'
  }
  // TODO: use vuex-router
  const match = route.path.match(/\/(\w)\//)
  let pathType = 't'
  if (match) {
    pathType = match[0]
  }
  pathType = pathType.replace(/\//g, '')
  context.commit('VIEW_TYPE', {type: pathType})
  let path = route.path
  // see if the path includes a subtree
  let npath = null
  if (path) {
    npath = path.substring(path.indexOf('/', 2) + 1)
  }
  let subtrees = []
  let subpath = '' // case of literate path in subtree
  if (npath) {
    // translate a literate path to number, TODO: remove duplicate, this is called above
    ({ npath, subpath } = translatePath(npath, ldata.data))
    // a subtree is a leo file loaded at a node
    subtrees = getRoots([], npath)
  }
  loadSubtrees(context, subtrees, ldata.data, id, subpath).then(() => {
    context.commit('SUBPATH', {subpath})
    const openItems = JSON.search(ldata.data, '//*[id="' + id + '"]/ancestor::*')
    if (!openItems) { return }
    if (!openItems.length) { return }
    const openItemIds = openItems.reduce((acc, o) => {
      if (o.id) { acc.push(o.id + '') }
      return acc
    }, [])
    openItemIds.push(id + '')
    context.commit('OPEN_ITEMS', {openItemIds})
    const ids = openItemIds
    context.dispatch('setContentItems', {ids})
    context.dispatch('setCurrentItem', {id})
  })
}

/**
 * Given a word path, find the matching node
 * @param p
 * @param d
 * @returns {{npath: *, subpath: string}}
 */
function translatePath (p, d) {
  let item = null
  let subpath = ''
  if (/^[A-Za-z]/.test(p)) {
    let uArray = p.split('*')
    if (uArray.length > 1) {
      p = uArray[0]
      subpath = _.last(uArray)
    }
    let pArray = p.split('~')
    let p2 = ''
    if (pArray.length === 2) {
      p = _.last(pArray)
      p2 = pArray[0]
    }
    if (p2) {
      item = JSON.search(d, '//*[name="' + p + '" and boolean(ancestor::*[name="' + p2 + '"])]')
    } else {
      // item = JSON.search(d, '//*[name="' + p + '"]')
      item = JSON.search(d, '//*[name[contains(.,"' + p + '")]]')
    }
    if (item && item[0]) {
      p = item[0].id
    } else {
      p = '1'
    }
  }
  return { npath: p, subpath }
}
function loadPresentations (data, loadSections) {
  let p = /@presentation ([a-zA-Z0-9]*)(.*)$/.test(data.name)
  if (p) { loadSections = true }
  let a = /^« /.test(data.name)
  if (p || (a && loadSections)) {
  // if (p) {
    console.log('loading', data.name)
    loadPresentation(data.id, data.children)
  }
  data.children.forEach(d => loadPresentations(d, loadSections))
}
function loadPresentation (id, pages) {
  if (!pages) { return }
  pages.forEach((page, index) => {
    page.presentation = { pid: id, index }
  })
}

/**
 * Used to load subtrees when navigating directly to a node.
 * @param context
 * @param trees {Array} Array of nodes to be preloaded.
 * @param data
 * @param topId
 * @param subpath
 * @returns {*}
 */
function loadSubtrees (context, trees, data, topId, subpath) {
  if (!trees.length) { return Promise.resolve() }
  let item = JSON.search(data, '//*[id="' + trees[0] + '"]')[0]
  context.commit('CURRENT_ITEM_CONTENT', { text: '<div class="spin-box"><div class="single10"></div></div>' })
  if (/^@outline/.test(item.name)) {
    return showPageOutline(context, item, topId, subpath)
  }
  const p = new Promise((resolve, reject) => {
    // TODO: this just loads the first subtree, need to load all in trees array for case of nested subtrees
    // TODO: implement subPat in leo subtree
    loadLeoNode(context, item).then(res => resolve(res))
  })
  return p
}
// add language directives to subtrees of existing language directives
function setChildDirectives (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    setChildDirective(context, d, textItems)
  })
}
function setChildDirective (context, d, textItems, parentDirective) {
  const text = textItems[d.t]
  const re = /^(@language \w+)/
  let languageDirective = re.exec(text)
  if (languageDirective) {
    languageDirective = languageDirective[1]
  }
  if (parentDirective && !languageDirective) {
    textItems[d.t] = parentDirective + '\n' + textItems[d.t]
    languageDirective = parentDirective
  }
  d.children.forEach(child => {
    setChildDirective(context, child, textItems, languageDirective)
  })
}
// for @clean nodes, set children with @language of extension
function setLanguageNodes (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    setLanguageNode(context, d, textItems)
  })
  // window.lconfig.dataSets = context.state.dataSets
}
function setLanguageNode (context, d, textItems) {
  const title = d.name
  let language = ''
  if (/^\s*@clean/.test(title)) {
    var re = /(?:\.([^.]+))?$/
    var ext = re.exec(title)[1]
    var ng = ['txt', 'md', 'html']
    if (ng.indexOf(ext) === -1) {
      language = ext
    }
    const langs = {
      js: 'javascript',
      ts: 'typescript',
      py: 'python',
      java: 'java',
      c: 'c'
    }
    if (langs[ext]) {
      language = langs[ext]
    }
  }
  if (language) {
    return addDirectiveToSubTree(d, '@language ' + language, textItems)
  }
  d.children.forEach(child => {
    setLanguageNode(context, child, textItems)
  })
}

/**
 * e.g. add '@language javascript' to this item and all below
 * @param subtree
 * @param directive
 * @param textItems
 */
function addDirectiveToSubTree (subtree, directive, textItems) {
  const text = textItems[subtree.t]
  if (!/^@/.test(text)) {
    textItems[subtree.t] = directive + '\n' + text
  }
  subtree.children.forEach(child => {
    addDirectiveToSubTree(child, directive, textItems)
  })
}
function loadDataSets (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    loadDataSet(context, d, textItems)
  })
  window.lconfig.dataSets = context.state.dataSets
}
function loadDataSet (context, item, textItems) {
  const text = textItems[item.t]
  const matches = item.name.match(/@dataSet ([a-zA-Z0-9]*)(.*)$/)
  if (matches) {
    const k = _.trim(matches[1])
    let v = text.replace(/^@language (\w+)/, '') // get rid of language directive
    try {
      v = JSON.parse(v)
    } catch (e) {
      console.log('Unable to parse data for: ' + item.name + ' ' + e)
    }
    context.commit('ADDDATASET', {k, v})
  }
  item.children.forEach(child => {
    loadDataSet(context, child, textItems)
  })
}
function loadDataTables (context, data) {
  const textItems = data.textItems
  data.data.forEach(d => {
    loadDataTable(context, d, textItems)
  })
  window.lconfig.dataTables = context.state.dataTables
}
function loadDataTable (context, item, textItems) {
  const text = textItems[item.t]
  const matches = item.name.match(/@dataTable ([a-zA-Z0-9]*)(.*)$/i)
  if (matches) {
    const k = _.trim(matches[1])
    const title = matches[2] || ''
    let v = text.replace(/^@language (\w+)/, '') // get rid of language directive
    let arr = null
    try {
      arr = Papa.parse(v).data
    } catch (e) {
      arr = []
      console.log('Unable to parse dataTable for: ' + item.name + ' ' + e)
    }
    arr.forEach(r => {
      r.forEach((c, i) => {
        r[i] = _.trim(c)
      })
    })
    const objArr = []
    const cols = arr[0]
    for (let r = 1; r < arr.length; r++) {
      let row = arr[r]
      let rowObj = {}
      for (let c = 0; c < row.length; c++) {
        let colName = cols[c]
        if (colName.indexOf('$') === -1) {
          rowObj[colName] = row[c]
        }
      }
      // let obj = arr[r].reduce((acc, v, i) => { acc[cols[i]] = v; return acc }, {})
      objArr.push(rowObj)
    }
    v = {title, arr, objArr}
    context.commit('ADDDATATABLE', {k, v})
  }
  item.children.forEach(child => {
    loadDataTable(context, child, textItems)
  })
}

// ========= The Store ===============
export default new Vuex.Store({
  state: {
    leotext: {},
    leodata: {},
    filename: '',
    initialized: false,
    initializedData: false,
    contentPane: 'text',
    viewType: 't',
    currentItem: {
      id: 0,
      next: 0,
      prev: 0,
      type: 'item'
    },
    currentItemContent: '',
    contentItems: {},
    currentPage: {
      id: 0
    },
    dataSets: {},
    dataTables: {},
    openItemIds: [],
    history: [0],
    historyIndex: 0,
    iframeHTML: '',
    contentItemsUpdateCount: 0,
    idx: null,
    accordion: false,
    accordionPrev: false,
    searchFlag: false,
    selecting: false, // e.g. in search dialog using arrow keys
    subpath: ''
  },
  mutations: {
    ADDDATASET (state, o) {
      state.dataSets[o.k] = o.v
    },
    ADDDATATABLE (state, o) {
      state.dataTables[o.k] = o.v
    },
    TOGGLEACCORDION (state) {
      state.accordion = !state.accordion
    },
    SETSEARCHFLAG (state) {
      state.searchFlag = true
    },
    SELECTINGON (state) {
      if (!state.searchFlag) {
        state.accordionPrev = state.accordion
      }
      state.accordion = true
    },
    SELECTINGOFF (state) {
      state.searchFlag = false
      state.accordion = state.accordionPrev
    },
    LEO (state, o) {
      state.leodata = o.data
      state.leotext = o.text
      const c = loadIndex(o.data, o.text)
      state.idx = c.idx
      state.idxDocs = c.docs
      state.filename = o.filename
      window.lconfig.leodata = o.data
      window.lconfig.leotext = o.text
    },
    // lunr search index
    RESETINDEX (state, o) {
      if (_.isUndefined) {
        console.log('No state in RESETINDEX') // TODO: this line needs fix
        return
      }
      const c = loadIndex(state.leodata, state.leotext)
      state.idx = c.idx
      state.idxDocs = c.docs
      state.filename = o.filename
    },
    ADDTEXT (state, o) {
      const text = o.text
      for (let k in text) {
        state.leotext[k] = text[k]
      }
    },
    INIT (state) {
      state.initialized = true
    },
    INIT_DATA (state) {
      state.initializedData = true
    },
    RESET (state) {
      state.initialized = false
    },
    CONTENT_PANE (state, o) {
      state.contentPane = o.type
    },
    IFRAME_HTML (state, o) {
      state.iframeHTML = o.iframeHTML
    },
    VIEW_TYPE (state, o) {
      state.viewType = o.type
    },
    CURRENT_ITEM_CONTENT (state, o) {
      state.currentItemContent = o.text
    },
    CURRENT_PAGE (state, o) {
      const id = o.id
      state.currentPage.id = id
      if (+id === 0) { return }
      let routeName = state.route.name
      if (routeName === 'Top') {
        routeName = 'Node'
      }
      router.replace({name: routeName, params: { id }})
    },
    // for inline content, keep hash of content items
    CONTENT_ITEM (state, o) {
      const item = o.item
      state.contentItems[item.id] = item.t
    },
    CONTENT_ITEM_UPDATE (state, o) {
      state.contentItemsUpdateCount = state.contentItemsUpdateCount + 1
    },
    CURRENT_ITEM (state, o) {
      const id = o.id
      // check current for identical
      if (o.id === state.currentItem.id) {
        return
      }
      // TODO: check prev/next for identical before change
      const nextSibling = JSON.search(state.leodata, '//children[id="' + id + '"]/following-sibling::*')
      const prevSibling = JSON.search(state.leodata, '//children[id="' + id + '"]/preceding-sibling::children')
      let next = 0
      let prev = 0
      if (nextSibling[0]) {
        next = nextSibling[0].id
      }
      if (prevSibling[0]) {
        prev = prevSibling[prevSibling.length - 1].id
      }
      if (id - prev !== 1) {
        prev = 0
      }
      if (next - id !== 1) {
        next = 0
      }
      state.currentItem.id = id
      state.currentItem.prev = prev
      state.currentItem.next = next
      let routeName = state.route.name
      if (routeName === 'Top') {
        routeName = 'Node'
      }
      router.replace({name: routeName, params: { id }})

      if (typeof o.historyIndex !== 'undefined') {
        state.historyIndex = o.historyIndex
      } else {
        state.history.push(id)
        state.historyIndex = state.historyIndex + 1
      }
      state.initialized = false
    },
    OPEN_ITEMS (state, o) {
      const ids = state.openItemIds
      ids.splice(0, ids.length)
      ids.push(...o.openItemIds)
    },
    SUBPATH (state, o) {
      state.subpath = o.subpath
    }

  },
  actions: {
    setMessages (context) {
      window.addEventListener('message', function (event) {
        if (!event.data) { return }
        if (!Object.keys(event.data).length) { return }
        let data = {}
        if (_.isObject(event.data)) {
          data = event.data
        } else {
          try {
            data = JSON.parse(event.data)
          } catch (e) {
            console.log('msg:', event.data)
          }
        }
        console.log('MDATA', data)
        if (data.namespace === 'leovue' && data.eventName === 'setcurrentitem') {
          const id = data.state.id
          context.dispatch('setCurrentItem', {id})
        }
        if (data.namespace === 'reveal' && data.eventName === 'slidechanged') {
          const id = data.state.indexh
          context.dispatch('setCurrentPage', {id})
          // Slide changed, see data.state for slide number
        }
      })
    },
    loadLeo (context, o) {
      getLeoJSON(o.filename, o.id).then(ldata => {
        setData(context, ldata, o.filename, o.route)
      })
    },
    loadLeoFromXML (context, o) {
      transformLeoXML(o.xml).then(ldata => {
        setData(context, ldata, 'dnd', o.route)
      })
    },
    // Given a list of ids, get the content. Needed for
    // inline mode and displaying content in a path.
    setContentItems (context, o) {
      const ids = o.ids
      ids.forEach(id => {
        let item = JSON.search(context.state.leodata, '//children[id="' + id + '"]')
        if (item && item[0]) {
          item = item[0]
          // if it starts with a bracket it is a link in markdown syntax
          if (/^\[/.test(item.name)) {
            setSiteItem(context, item.name, item.id)
          } else {
            let text = context.state.leotext[item.t]
            text = util.formatText(text)
            const newItem = {
              t: text,
              id: id
            }
            context.commit('CONTENT_ITEM', {item: newItem})
            context.commit('CONTENT_ITEM_UPDATE')
          }
        }
      })
    },
    setCurrentPage (context, o) {
      let page = +o.id
      let id = context.state.currentItem.id
      // if we're setting a page, we're displaying a presentation
      const presentationNode = JSON.search(context.state.leodata, '//*[id="' + id + '"]')[0]
      const pageNode = presentationNode.children[page]
      if (!pageNode) {
        id = 0
      } else {
        id = pageNode.id
      }
      context.commit('CURRENT_PAGE', {id})
    },
    // TODO: this is being called by loadSubtrees, fix logic (duplicate for openitems)
    setCurrentItem (context, o) {
      const id = o.id
      if (o.id === context.state.currentItem.id) { return }
      // if in iframe, just raise event and leave
      if (window.parent !== window.self) { return }
      // open parent nodes, close others
      const openItems = JSON.search(context.state.leodata, '//*[id="' + id + '"]/ancestor::*')
      let openItemIds = openItems.reduce((acc, o) => {
        if (o.id) { acc.push(o.id + '') }
        return acc
      }, [])
      openItemIds.push(id + '')
      if (context.state.accordion) {
        context.commit('OPEN_ITEMS', {openItemIds})
        const ids = openItemIds
        context.dispatch('setContentItems', {ids})
      } else {
        // open parent nodes
        const currentOpenItemIds = context.state.openItemIds
        openItemIds = _.uniq(currentOpenItemIds.concat(openItemIds))
        context.commit('OPEN_ITEMS', {openItemIds})
      }
      let item = JSON.search(context.state.leodata, '//*[id="' + id + '"]')
      context.commit('CURRENT_ITEM', {id})
      if (_.get(item, '[0].presentation')) {
        context.commit('CURRENT_PAGE', {id: 0})
      }
      if (item) {
        item = item[0]
        let itemText = context.state.leotext[item.t]
        console.log('item text', itemText)
        if (/^@presentation /.test(item.name)) {
          return showPresentation(context, item.name, id)
        }
        if (/^@kanban /.test(item.name)) {
          return showKanban(context, item.name, id)
        }
        if (/^@mermaid/.test(item.name)) {
          return showMermaid(context, item.name, id)
        }
        if (/^@rss/.test(item.name)) {
          let {url, label} = getUrlFromTitle(item.name) // eslint-disable-line
          if (!url) { return }
          return showRSS(context, id, url)
        }
        if (/^@xml/.test(item.name)) {
          let {url, label} = getUrlFromTitle(item.name) // eslint-disable-line
          if (!url) { return }
          return showXML(context, id, url)
        }
        if (/^@outline/.test(item.name)) {
          let mySubpath = context.state.subpath
          context.commit('SUBPATH', { subpath: '' })
          return showPageOutline(context, item, id, mySubpath).then(
            res => context.commit('RESETINDEX')
          )
        }
        if (/^@d3board /.test(item.name)) {
          return showD3Board(context, item.name, id)
        }
        if (/^« /.test(item.name) && _.has(item.children[0], 'presentation')) {
          // context.commit('CURRENT_ITEM', {id: item.children[0].presentation.pid})
          // context.commit('CURRENT_PAGE', {id})
          // context.commit('CURRENT_PAGE', {id: 0})
          return showPresentation(context, item.name, id)
        }
        // bracket means load file/site
        if (/^\[/.test(item.name)) {
          // load leo file from item title
          if (/\.leo\)$/.test(item.name)) {
            console.log('load leo')
            loadLeoNode(context, item, true).then(
              res => context.commit('RESETINDEX')
            )
          } else {
            console.log('load site')
            showSite(context, item.name, id, itemText)
            setSiteItem(context, item.name, id)
          }
        } else {
          showText(context, context.state.leotext[item.t], id)
        }
        // if it is a page in a presentation
        if (item.presentation) {
          context.commit('CURRENT_ITEM', {id: item.presentation.pid})
          context.commit('CURRENT_PAGE', {id})
          return showPresentation(context, item.name, id)
        } else {
          context.commit('CURRENT_PAGE', {id: 0})
        }
      }
    }
  }
})
