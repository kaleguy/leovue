<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="v">
    <xsl:variable name="t" select="@t"/>
    <xsl:variable name="nodeSet" select="//v[@t=$t]"/>
    {
    "t":   "<xsl:value-of select="translate(@t,'.','_')"/>",
    "name":"<xsl:value-of select="$nodeSet[1]/vh"/>",
    "children":[<xsl:apply-templates select="$nodeSet[1]/v"/>]
    }
    <xsl:if test="position()!=last()">,</xsl:if>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>
