<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Top 5 exhibitions with the highest average number of visitors per day</title>
      </head>
      <body>
        <h1>Top 5 exhibitions with the highest average number of visitors per day</h1>
        <table border="1" cellpadding="6" cellspacing="0">
          <thead>
            <tr>
              <th>Rank</th>
              <th>Exhibition ID</th>
              <th>Theme</th>
              <th>Opening date</th>
              <th>Closing date</th>
              <th>Adult visitors/day</th>
              <th>Under-age visitors/day</th>
              <th>Average visitors/day</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="Museum/Exhibitions/Exhibition">
              <xsl:sort select="number(VisitorCount/Adult) + number(VisitorCount/UnderAge)" data-type="number" order="descending"/>
            </xsl:apply-templates>
          </tbody>
        </table>
        <p>
          <strong>Calculation:</strong>
          <xsl:text> Average visitors/day = Adult visitors/day + Under-age visitors/day.</xsl:text>
        </p>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Exhibition">
    <xsl:if test="position() &lt;= 5">
      <tr>
        <td><xsl:value-of select="position()"/></td>
        <td><xsl:value-of select="@id"/></td>
        <td><xsl:value-of select="Theme/@ref"/></td>
        <td><xsl:value-of select="Schedule/OpeningDate"/></td>
        <td><xsl:value-of select="Schedule/ClosingDate"/></td>
        <td><xsl:value-of select="VisitorCount/Adult"/></td>
        <td><xsl:value-of select="VisitorCount/UnderAge"/></td>
        <td>
          <strong>
            <xsl:value-of select="number(VisitorCount/Adult) + number(VisitorCount/UnderAge)"/>
          </strong>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
