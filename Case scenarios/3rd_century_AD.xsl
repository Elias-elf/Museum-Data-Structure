<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Artifacts - 3rd century AD</title>
				<meta charset="UTF-8"/>
			</head>
			<body>
				<h1>Artifacts from 3rd century AD</h1>
				<table border="1" cellpadding="6">
					<tr>
						<th>ID</th>
						<th>Description</th>
						<th>Provenance</th>
					</tr>
					<xsl:for-each select="//Artifact[HistoricalPeriod='3rd century AD']">
						<tr>
							<td>
								<xsl:value-of select="@id"/>
							</td>
							<td>
								<xsl:value-of select="substring-before(Description, '.')"/>
							</td>
							<td>
								<xsl:value-of select="Provenance"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
