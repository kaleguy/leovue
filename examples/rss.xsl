<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:media="http://search.yahoo.com/mrss/"
                xmlns:rdf="http://purl.org/rss/1.0/"
                exclude-result-prefixes="rdf media"
>
  <xsl:output method="html"/>

  <xsl:template match="/">
    <xsl:apply-templates select="*"/>
    <xsl:apply-templates select="//item | //rdf:item"/>
  </xsl:template>

  <xsl:template match="results">
    <h1>GOT HERE</h1>
  </xsl:template>

  <xsl:template match="item | rdf:item">
    <table>
      <tr>
        <td valign="top">
          <xsl:apply-templates select="media:content[@medium='image']"/>
        </td>
        <td valign="top">
          <a target="_blank" href="{link}">
            <xsl:apply-templates select="title | rdf:title"/>
          </a>
          <xsl:apply-templates select="description"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="title | rdf:title">
    <div class="rss-title">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <xsl:template match="description">
    <div class="rss-description">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <xsl:template match="media:content[@medium='image']">
    <img class="rss-img" height="{@height}" width="{@width}" src="{@url}"/>
  </xsl:template>

  <xsl:template match="text()|@*">
  </xsl:template>

</xsl:stylesheet>
