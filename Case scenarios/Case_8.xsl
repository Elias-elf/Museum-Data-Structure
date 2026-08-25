<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="Museum">
		<html>
			<body>
				<h1>Artifacts Under Restoration</h1>
				<ul>
					<xsl:apply-templates select="Artifacts/Artifact" mode="si"/>
				</ul>
				<h1>Artifacts Not Under Restoration</h1>
				<ul>
					<xsl:apply-templates select="Artifacts/Artifact" mode="no"/>
				</ul>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Artifact" mode="si">
		<xsl:if test="RestorationHistory/@under_restoration = 'true'">
			<li>id=<xsl:value-of select="@id"/>: <xsl:value-of select="substring-before(Description, '.')"/>
			</li>
		</xsl:if>
	</xsl:template>
	<xsl:template match="Artifact" mode="no">
		<xsl:if test="RestorationHistory/@under_restoration = 'false'">
			<li>id=<xsl:value-of select="@id"/>: <xsl:value-of select="substring-before(Description, '.')"/>
			</li>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*"/>
</xsl:stylesheet>