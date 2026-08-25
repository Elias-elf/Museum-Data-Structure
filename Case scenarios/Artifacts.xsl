<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- On spécifie qu'on veut générer du HTML -->
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Artifact Details &amp; Restoration</title>
            </head>
            <body>
                <h1>Museum Artifacts : Status Report</h1>
                <table border="1" cellpadding="5" style="border-collapse: collapse;">
                    <tr>
                        <th>ID</th>
                        <th>Artifact Name</th>
                        <th>Materials</th>
                        <th>Restoration Status</th>
                    </tr>
                    
                    <!-- Boucle sur chaque artefact -->
                    <xsl:for-each select="Artifacts/Artifact">
                        <tr>
                            <!-- 1. Extraction de l'ID -->
                            <td><xsl:value-of select="@id"/></td>
                            
                            <!-- 2. Extraction du Nom (on prend le texte avant le premier point, comme dans ton Python) -->
                            <td>
                                <xsl:choose>
                                    <xsl:when test="contains(Description, '.')">
                                        <xsl:value-of select="substring-before(Description, '.')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="Description"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            
                            <!-- 3. Extraction et jointure des matériaux -->
                            <td>
                                <xsl:for-each select="Material">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                                <xsl:if test="not(Material)">Unknown</xsl:if>
                            </td>
                            
                            <!-- 4. Extraction du statut de restauration -->
                            <td>
                                <xsl:choose>
                                    <xsl:when test="RestorationHistory/@under_restoration">
                                        <xsl:value-of select="RestorationHistory/@under_restoration"/>
                                    </xsl:when>
                                    <xsl:otherwise>Unknown</xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>