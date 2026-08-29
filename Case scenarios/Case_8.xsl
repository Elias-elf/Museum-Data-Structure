<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<!-- This use case supports restoration tracking by separating artifacts that are -->
	<!-- currently under restoration from those that aren't, for quick status overview. -->
	<xsl:template match="Museum">
		<html>
			<body>
				<h1>Artifacts Under Restoration</h1>
				<ul>
					<xsl:apply-templates select="Artifacts/Artifact" mode="yes"/>
				</ul>
				<h1>Artifacts Not Under Restoration</h1>
				<ul>
					<xsl:apply-templates select="Artifacts/Artifact" mode="no"/>
				</ul>
			</body>
		</html>
	</xsl:template>
	<!-- mode="yes": artifacts currently under restoration. -->
	<xsl:template match="Artifact" mode="yes">
		<xsl:if test="RestorationHistory/@under_restoration = 'true'">
			<li>id=<xsl:value-of select="@id"/>: <xsl:value-of select="substring-before(Description, '.')"/>
			</li>
		</xsl:if>
	</xsl:template>
	<!-- mode="no": artifacts not under restoration. -->
	<xsl:template match="Artifact" mode="no">
		<xsl:if test="RestorationHistory/@under_restoration = 'false'">
			<li>id=<xsl:value-of select="@id"/>: <xsl:value-of select="substring-before(Description, '.')"/>
			</li>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*"/>
</xsl:stylesheet>