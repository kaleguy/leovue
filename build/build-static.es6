require('babel-core/register')
const leo = require('../src/services/leo')
const fs = require('fs')
const DOMParser = require('xmldom').DOMParser;
const XMLSerializer = require('xmldom').XMLSerializer;
const xslt4node = require('xslt4node')
const _ = require('lodash')
const xml = fs.readFileSync('static/docs.leo', 'utf8')
const util = require('../src/util')

const xslString = `
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="v">
    <xsl:variable name="t" select="@t"/>
    <div>
      <xsl:attribute name="href">
         <xsl:value-of select="$t"/>
      </xsl:attribute>
      <xsl:value-of select="./vh"/>
    </div>
    <xsl:text>
    </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
`

leo.transformLeoXML2XML(xml, 'L1', DOMParser)
  .then(xmlString => createMenu(xmlString, xslString))

function createMenu(data, xslString) {
  const xmlString = new XMLSerializer().serializeToString(data.xml)
  const config = {
    xslt: xslString,
    source: xmlString,
    result: String,
    props: {
      indent: 'yes'
    }
  }
  xslt4node.transform(config, (err, result) => {
    if (err) {
      console.log('ERROR:', err)
    }
    writeMenuFile(result)
  })
}

// leo.transformLeoXML(xml, 'L1', DOMParser, xslt4node, XMLSerializer)
//  .then(data => writeFiles(data))

function writeFiles(data) {
  const header = fs.readFileSync('./build/build-static-header.html')
  const footer = fs.readFileSync('./build/build-static-footer.html')
  const textItems = data.textItems
  _.each(textItems, (v, k) => {
    v = util.formatText(v)
    console.log(v)
    v = header + v + footer
    let filename = k + '.html'
    fs.writeFileSync('static/site/' + filename, v)
  })
  process.exit(0)
}

function writeMenuFile(data) {
  fs.writeFileSync('static/site/index.html', data)
}
