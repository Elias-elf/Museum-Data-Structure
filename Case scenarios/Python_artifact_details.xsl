<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
        <head>
            <title>Artifact Details</title>
        </head>
        <body>
            <h2>Artifact Details, Materials, and Restoration Status</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Description</th>
                    <th>Materials</th>
                    <th>Restoration Status</th>
                </tr>
                <xsl:for-each select="Artifacts/Artifact">
                    <tr>
                        <td><xsl:value-of select="@id"/></td>
                        <td><xsl:value-of select="Description"/></td>
                        <td>
                            <xsl:for-each select="Material">
                                <xsl:value-of select="."/><xsl:if test="position() != last()">, </xsl:if>
                            </xsl:for-each>
                        </td>
                        <td>
                            <xsl:choose>
                                <xsl:when test="RestorationHistory/@under_restoration = 'true'">Under Restoration</xsl:when>
                                <xsl:otherwise>Available</xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
        </body>
        </html>
    </xsl:template>
</xsl:stylesheet>