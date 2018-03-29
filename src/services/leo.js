// import escape from 'escape-html'
import axios from 'axios'

const xslTemplate = `
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="v">
    <xsl:variable name="t" select="@t"/>
    <xsl:variable name="nodeSet" select="//v[@t=$t]"/>
    <xsl:variable name="double_quote">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>
    {
    "id":  <xsl:value-of select="@id"/>,
    "t":   "<xsl:value-of select="translate(@t,'.','_')"/>",
    "name":"<xsl:value-of select="translate($nodeSet[1]/vh,concat('\',$double_quote),concat('|',$apos))"/>",
    "children":[<xsl:apply-templates select="$nodeSet[1]/v"/>]
    }
    <xsl:if test="position()!=last()">,</xsl:if>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
`
const outlineInfoTemplate = `

<h2>Outline Information</h2>
<% if (url) { %>
<p>
This outline was downloaded from <strong><%- url %>/</strong>.
</p>
<p>
Outline displayed via <a href="kaleguy.github.io">Leo Vue</a>
</p>
<% } else { %>
<p>
No url specified!
</p>
<p>
Url parameter format:
</p>
<p>?outlineUrl=https://www.mysite.com&outlineTitle=the outline
</p>

<% } %>
`
const outlineInfoError = `

#Error

No url specified!

Url parameter format:

url=www.mysite.com&name=the outline
  
`
function transform (xml, xslString, transformer, serializer) {
  function serverTransform(resolve, reject) {
    const xmlString = new serializer().serializeToString(xml)
    const config = {
      xslt: xslString,
      source: xmlString,
      result: String,
      props: {
        indent: 'yes'
      }
    }
    transformer.transform(config, (err, result) => {
      if (err) {
        console.log('ERROR:', err)
        return reject()
      }
      resolve(result)
    })
  }

  function clientTransform(resolve, reject) {
    const oParser = new DOMParser()
    const xsl = oParser.parseFromString(xslString, 'text/xml')
    const xsltProcessor = new XSLTProcessor()
    xsltProcessor.importStylesheet(xsl)
    const resultDocument = xsltProcessor.transformToFragment(xml, document)
    resolve(resultDocument.textContent)
  }

  const p = new Promise((resolve, reject) => {
    if (transformer) {
      return serverTransform(resolve, reject)
    } else {
      return clientTransform(resolve, reject)
    }
  })
  return p
}

function loadDoc (filename) {
  console.log('loading file:', filename, window.lconfig, 'test')

  var p = new Promise((resolve, reject) => {
    axios.get(filename)
      .then(function (response) {
        resolve(response.data)
      })
      .catch(function (error) {
        console.log(error)
        reject()
      })
  })
  return p
}
function cleanText(data, startId){
  data.name = data.name.replace(/<</g, '\u00AB')
  data.name = data.name.replace(/>>/g, '\u00BB')
  data.name = data.name.replace(/'/g, '\x27')
  data.name = data.name.replace(/"/g, '\x22')
  //data.name = escape(data.name)
  data.name = data.name.replace(/&#39;/g,'\x27')
  data.id = data.id + ''; // probably unneeded now
  let children = data.children;
  if (!children) { return }
  for (let i = 0; i < children.length; i++){
    cleanText(children[i], startId)
  }
  data.t = data.t.replace(/^.*?_/,'') // remove file uid
  if (startId) {
    data.t = startId + '-' + data.t + ''
  }
}
/**
 * TODO: move to util, also is in store/index, review logic for relative / subtrees
 * Is url relative
 * @param url {string}
 * @returns {boolean} - if is relative
 */
function isRelative (url) {
  var ok = true
  if (/^http/.test(url)) {
    ok = false
  }
  return ok
}
function getLeoJSON (filename, id) {
  if (filename.indexOf('#') > 0) {
    filename = filename.substring(0, filename.indexOf('#'))
  }
  var p = new Promise((resolve, reject) => {
    if (!filename.match(/static/) && isRelative(filename)) {
      // filename = 'static/' + filename
    }
    if (!filename.match(/\.leo$/)) {
      filename = filename + '.leo'
    }
    function fromOutline() {
      let url = lconfig.outlineUrl || ''
      url = url.replace('%3A', ':')
      let name = lconfig.outlineTitle
      if (!name) {
        name = url.replace(/^http[s]?:\/\//, '') // .split('/')[0]
      }
      const compiled = _.template(outlineInfoTemplate)
      const outlineInfoHTML = compiled({url})
      const data = []
      const textItems = {
        '2': outlineInfoHTML
      }
      let nodeTitle = `@outline [${name}](${url})`
      if (!url) {
        nodeTitle = 'Empty Outline'
      }
      const item = {
        name: nodeTitle,
        id: '1',
        children: [],
        t: ''
      }
      const infoItem = {
        name: 'Information',
        id: '2',
        children: [],
        t: '2'
      }
      data.push(item)
      data.push(infoItem)
      resolve({
        data,
        textItems
      })
    }
    function fromFile () {
      loadDoc(filename, 'Text')
        .then(xmlString => {
          return transformLeoXML(xmlString, id)
        })
        .then(data => resolve(data))
    }
    // filename = '~outline.leo'
    if (filename === '~outline.leo') {
      fromOutline()
    } else {
      fromFile()
    }
  })
  return p
}

function transformLeoXML2XML(xmlString, startId, parser) {
  const p = new Promise((resolve, reject) => {

    let oParser = null
    if (parser) {
      oParser = new parser()
    } else {
      oParser = new DOMParser()
    }
    const xml = oParser.parseFromString(xmlString, 'text/xml')
    const tnodes = xml.getElementsByTagName('t')
    let textItems = {}
    for (let i = 0; i < tnodes.length; i++) {
      let el = tnodes[i]
      let elText = el.textContent
      let a = el.getAttribute('tx')
      a = a.replace(/\./g, '_')
      a = a.replace(/^.*?_/, '')
      if (startId) {
        a = startId + '-' + a
      }
      if (
        (/^@language /.test(elText)) &&
        (!/^@language html/.test(elText)) &&
        (!/^@language md/.test(elText))
      ) {
        // elText = escape(elText)
      }
      textItems[a] = elText
    }
    const vnodes = xml.getElementsByTagName('v')
    let pid
    for (let i = 0; i < vnodes.length; i++) {
      pid = i + 1
      if (startId) {
        pid = startId + '-' + pid
      }
      vnodes[i].setAttribute('id', '"' + pid + '"')
    }
    resolve({xml, textItems})

  })
  return p
}
function transformLeoXML2JSON (data, startId, parser, transformer, serializer) {
    const p = new Promise((resolve, reject) => {
      const xml = data.xml
      const textItems = data.textItems
      transform(xml, xslTemplate, transformer, serializer).then(jsdata => {
        jsdata = jsdata.replace(/<\?xml version="1\.0" encoding="UTF-8"\?>/,'')
        jsdata = jsdata.replace(/,\s?$/, '') // kludge to get rid of trailing comma
        jsdata = '[' + jsdata + ']'
        jsdata = JSON.parse(jsdata)
        jsdata.forEach(d => cleanText(d, startId))
        const xdata = {}
        xdata.data = jsdata
        xdata.textItems = textItems
        return (xdata)
      }).then(data => resolve(data))

    })
    return p
}
function transformLeoXML(xmlString, startId, parser, transformer, serializer){
  return transformLeoXML2XML(xmlString, startId, parser)
    .then(data => transformLeoXML2JSON(data, startId, parser, transformer, serializer))
}

export {getLeoJSON, transformLeoXML, transformLeoXML2XML, transform}
