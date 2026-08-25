<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:template match="/">
		<xsl:text>---
restoration_projects:
</xsl:text>
		<xsl:apply-templates select="Museum/Restoration/Project[Loan &gt;= 200000]">
			<xsl:sort select="Loan" data-type="number" order="descending"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Project">
		<xsl:text>- id: "</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>"
</xsl:text>
		<xsl:text>  budget: </xsl:text>
		<xsl:value-of select="Loan"/>
		<xsl:text>
</xsl:text>
		<xsl:text>  currency: "</xsl:text>
		<xsl:value-of select="Loan/@currency"/>
		<xsl:text>"
</xsl:text>
	</xsl:template>
</xsl:stylesheet>