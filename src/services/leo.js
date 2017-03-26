function loadXMLDoc (filename, type) {
  const xhttp = new XMLHttpRequest()
  xhttp.open('GET', filename, false) // synchronous
  xhttp.send('')
  return xhttp['response' + type]
}

function getLeoJSON (filename) {
  var p = new Promise((resolve, reject) => {
    const xmlString = loadXMLDoc('./static/' + filename + '.leo', 'Text')
    const oParser = new DOMParser()
    const xml = oParser.parseFromString(xmlString, 'text/xml')
    const xsl = loadXMLDoc('./static/leo.xsl', 'XML')
    const xsltProcessor = new XSLTProcessor()
    xsltProcessor.importStylesheet(xsl)
    const resultDocument = xsltProcessor.transformToFragment(xml, document)
    let data = resultDocument.textContent
    data = data.replace(/,\s?$/, '') // kludge to get rid of trailing comma
    const xdata = null
    data = 'xdata = ' + data
    eval(data) // eslint-disable-line JSON.Parse doesn't work because of template strings
    resolve(xdata)
  })
  return p
}

export {getLeoJSON}
