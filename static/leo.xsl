<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="v">
        <xsl:variable name="t" select="@t"/>
        {
          "name":"<xsl:value-of select="vh"/>",
          "text":`<xsl:value-of select="//t[@tx=$t]"/>`,
          "children":[<xsl:apply-templates select="v"/>]
        }
        <xsl:if test="position()!=last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="text()"/>

</xsl:stylesheet>