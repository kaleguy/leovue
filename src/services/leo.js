import escape from 'escape-html'

function loadXMLDoc (filename, type) {
  const xhttp = new XMLHttpRequest()
  xhttp.open('GET', filename, false) // synchronous
  xhttp.send('')
  return xhttp['response' + type]
}
function cleanText(data){
  // if (! data){ return }
  // debugger;
  data.name = data.name.replace(/<</g,'\u00AB');
  data.name = data.name.replace(/>>/g,'\u00BB');
  let children = data.children;
  if (!children) { return }
  for (let i = 0; i < children.length; i++){
    cleanText(children[i])
  }
}
function getLeoJSON (filename) {
  var p = new Promise((resolve, reject) => {
    const xmlString = loadXMLDoc('./static/' + filename + '.leo', 'Text')
    const oParser = new DOMParser()
    const xml = oParser.parseFromString(xmlString, 'text/xml')
    const tnodes = xml.getElementsByTagName('t')
    let textItems = {}
    for (let i = 0; i < tnodes.length; i++){
      let el = tnodes[i]
      let elText = el.textContent
      let a = el.getAttribute('tx')
      a = a.replace(/\./g,'_')
      if (
         (/^@language /.test(elText)) &&
         (!/^@language html/.test(elText))
      ){
        elText = escape(elText)
      }
      textItems[a] = elText
    }
    const xsl = loadXMLDoc('./static/leo.xsl', 'XML')
    const xsltProcessor = new XSLTProcessor()
    xsltProcessor.importStylesheet(xsl)
    const resultDocument = xsltProcessor.transformToFragment(xml, document)
    let data = resultDocument.textContent
    data = data.replace(/,\s?$/, '') // kludge to get rid of trailing comma
    data = JSON.parse(data)
    cleanText(data)
    const xdata = {}
    xdata.data = data
    xdata.textItems = textItems
    resolve(xdata)
  })
  return p
}

export {getLeoJSON}
