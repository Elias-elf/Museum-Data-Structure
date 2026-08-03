<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Budget for Restorations</title>
				<style>
					body { font-family: Georgia, serif; margin: 2em; }
					table { border-collapse: collapse; }
					td, th { border: 1px solid black; padding: 6px; }
				</style>
			</head>
			<body>
				<h1>Budget for Restorations</h1>
				<table>
					<tr>
						<th>Project ID</th>
						<th>Budget</th>
						<th>Responsible</th>
					</tr>
					<xsl:for-each select="Museum/Restoration/Project">
						<xsl:sort select="Loan" data-type="number" order="descending"/>
						<tr>
							<td><xsl:value-of select="@id"/></td>
							<td><xsl:value-of select="format-number(Loan, '#,##0')"/> €</td>
							<td><xsl:value-of select="Responsible/FullName"/></td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>