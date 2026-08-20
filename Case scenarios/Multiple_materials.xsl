<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="Museum">
		<html>
			<body>
				<h1>Artifacts Made of Multiple Materials</h1>
				<ul>
					<xsl:apply-templates select="Artifacts/Artifact" mode="many"/>
				</ul>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Artifact" mode="many">
		<xsl:if test="count(Material) &gt; 1">
			<li>id=<xsl:value-of select="@id"/>: <xsl:value-of select="substring-before(Description, '.')"/> (<xsl:value-of select="count(Material)"/> materials)</li>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*"/>
</xsl:stylesheet>