const rss = `
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:media="http://search.yahoo.com/mrss/"
 xmlns:rdf="http://purl.org/rss/1.0/"
> 
<xsl:output method="html"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="//item | //rdf:item" />
  </xsl:template>

  <xsl:template match="results">
  </xsl:template>
  
  <xsl:template match="item | rdf:item">
    <table>
    <tr><td valign="top">
      <xsl:apply-templates select="media:content[@medium='image']"/>
    </td>
    <td valign="top">
      <a target="_blank" href="{link}"><xsl:apply-templates select="title | rdf:title"/></a>
      <xsl:apply-templates select="description | rdf:description"/>
    </td></tr>
    </table>   
  </xsl:template>
  
  <xsl:template match="title | rdf:title">
     <div class="rss-title"><xsl:value-of select="."/></div>
  </xsl:template>

  <xsl:template match="description | rdf:description">
     <div class="rss-description"><xsl:value-of select="."/></div>
  </xsl:template>
  
  <xsl:template match="media:content[@medium='image']">
    <img class="rss-img" height="{@height}" width="{@width}" src="{@url}" />
  </xsl:template>

  <xsl:template match="text()|@*">
  </xsl:template>

</xsl:stylesheet>

`

const styleSheets = { rss }

function render (xml, xslType) {
  const oParser = new DOMParser()
  if (!xslType) {
    xslType = 'rss'
  }
  const xslString = styleSheets[xslType]
  if (!xslString) {
    return (Promise.resolve('<div>No Matching XSL</div>'))
  }
  return new Promise((resolve, reject) => {
    let resultDocument = null
    try {
      xml = oParser.parseFromString(xml, 'text/xml')
      const descriptionNodes = xml.getElementsByTagName('description')
      for (let i = 0; i < descriptionNodes.length; i++) {
        const descriptionNode = descriptionNodes[i]
        // hack to get rid of garbage in Slashdot feed
        const garbageIndex = descriptionNode.innerHTML.indexOf('&lt;')
        if (garbageIndex > 0) {
          descriptionNode.innerHTML = descriptionNode.innerHTML.substring(0, garbageIndex).replace(/&amp;amp;/g, '&amp;')
        }
      }
      const xsl = oParser.parseFromString(xslString, 'text/xml')
      const xsltProcessor = new XSLTProcessor()
      xsltProcessor.importStylesheet(xsl)
      resultDocument = xsltProcessor.transformToFragment(xml, document)
    } catch (e) {
      console.log('Error in xsl transform:', e)
    }
    if (!resultDocument) {
      resolve('<div>Error</div>')
    }
    const dummy = document.createElement('section')
    dummy.setAttribute('id', 'dummy')
    dummy.style.display = 'none'
    document.body.appendChild(dummy)
    dummy.appendChild(resultDocument)
    let html = dummy.innerHTML
    html = '@language html\n' + html
    dummy.outerHTML = ''
    resolve(html)
  })
}

export default { render }
