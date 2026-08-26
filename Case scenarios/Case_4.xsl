<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    extension-element-prefixes="exsl">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
 
<xsl:variable name="artifact-data" select="/Museum/Artifacts"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Exhibitions displaying artifacts made of more than five different materials</title>
      </head>
      <body>
        <h1>Exhibitions displaying artifacts made of more than five different materials</h1>
        <xsl:apply-templates select="/Museum/Exhibitions/Exhibition"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Exhibition">
    <xsl:variable name="artifact-refs" select="Artifacts/Artifact"/>
    <xsl:variable name="material-list">
      <materials>
        <xsl:for-each select="$artifact-data/Artifact[@id = $artifact-refs/@ref]/Material">
          <material><xsl:value-of select="normalize-space(.)"/></material>
        </xsl:for-each>
      </materials>
    </xsl:variable>
    <xsl:variable name="distinct-materials"
      select="exsl:node-set($material-list)/materials/material[not(. = preceding-sibling::material)]"/>

    <xsl:if test="count($distinct-materials) &gt; 5">
      <h2><xsl:value-of select="@id"/></h2>
      <p>
        <strong>Number of different materials: </strong>
        <xsl:value-of select="count($distinct-materials)"/>
      </p>
      <ul>
        <xsl:for-each select="$distinct-materials">
          <xsl:sort select="." order="ascending"/>
          <li><xsl:value-of select="."/></li>
        </xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
