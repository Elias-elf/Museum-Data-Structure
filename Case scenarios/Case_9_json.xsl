<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:variable name="doubleQuote">"</xsl:variable>
    <xsl:variable name="singleQuote">'</xsl:variable>
    
    <!-- This use case extracts artifact details, materials, and restoration status to JSON. -->
    <xsl:template match="/">
        {
          "Artifacts": [
            <xsl:for-each select="Artifacts/Artifact">
              {
                "id": "<xsl:value-of select='@id'/>",
                "Description": "<xsl:value-of select='translate(normalize-space(Description), $doubleQuote, $singleQuote)'/>",
                "Materials": [
                  <xsl:for-each select="Material">
                    "<xsl:value-of select='.'/>"<xsl:if test="position() != last()">,</xsl:if>
                  </xsl:for-each>
                ],
                "Cultural_Heritage_Ref": "<xsl:value-of select='CulturalHeritage/@ref_Theme'/>",
                "Under_Restoration": "<xsl:value-of select='RestorationHistory/@under_restoration'/>"
              }<xsl:if test="position() != last()">,</xsl:if>
            </xsl:for-each>
          ]
        }
    </xsl:template>
</xsl:stylesheet>