<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Responsibles and their respective restoration projects</title>
			</head>
			<body>
				<h1>Responsibles and their respective restoration projects</h1>
				<xsl:apply-templates select="//Responsible[not(FullName = preceding::Responsible/FullName)]">
					<xsl:sort select="FullName" order="ascending"/>
				</xsl:apply-templates>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Responsible">
		<xsl:variable name="projects" select="//Project[Responsible/FullName = current()/FullName]"/>
		<xsl:if test="$projects">
			<h2>
				<xsl:value-of select="FullName"/>
			</h2>
			<ul>
				<xsl:apply-templates select="$projects"/>
			</ul>
		</xsl:if>
	</xsl:template>
	<xsl:template match="Project">
		<li>
			<xsl:value-of select="Responsible/Domain"/>
			<xsl:text> - </xsl:text>
			<xsl:value-of select="Responsible/Expertise"/>
		</li>
	</xsl:template>
</xsl:stylesheet>