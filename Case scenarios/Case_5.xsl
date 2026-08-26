<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Top 5 exhibitions with the longest duration</title>
      </head>
      <body>
        <h1>Top 5 exhibitions with the longest duration</h1>
        <table border="1" cellpadding="6" cellspacing="0">
          <thead>
            <tr>
              <th>Rank</th>
              <th>Exhibition ID</th>
              <th>Theme</th>
              <th>Opening date</th>
              <th>Closing date</th>
              <th>Duration (days)</th>
            </tr>
          </thead>
          <tbody>
            <!--
              XSLT 1.0 reads ISO dates as text, so it cannot subtract
              ClosingDate and OpeningDate directly.

              For sorting, each date is converted to a Julian Day Number (JDN):
                duration = closing JDN - opening JDN
            -->
            <xsl:apply-templates select="Museum/Exhibitions/Exhibition">
              <xsl:sort data-type="number" order="descending"
                select="
                  (number(substring(Schedule/ClosingDate, 9, 2))
                   + floor((153 * (number(substring(Schedule/ClosingDate, 6, 2)) + 12 * floor((14 - number(substring(Schedule/ClosingDate, 6, 2))) div 12) - 3) + 2) div 5)
                   + 365 * (number(substring(Schedule/ClosingDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/ClosingDate, 6, 2))) div 12))
                   + floor((number(substring(Schedule/ClosingDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/ClosingDate, 6, 2))) div 12)) div 4)
                   - floor((number(substring(Schedule/ClosingDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/ClosingDate, 6, 2))) div 12)) div 100)
                   + floor((number(substring(Schedule/ClosingDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/ClosingDate, 6, 2))) div 12)) div 400)
                   - 32045)
                  -
                  (number(substring(Schedule/OpeningDate, 9, 2))
                   + floor((153 * (number(substring(Schedule/OpeningDate, 6, 2)) + 12 * floor((14 - number(substring(Schedule/OpeningDate, 6, 2))) div 12) - 3) + 2) div 5)
                   + 365 * (number(substring(Schedule/OpeningDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/OpeningDate, 6, 2))) div 12))
                   + floor((number(substring(Schedule/OpeningDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/OpeningDate, 6, 2))) div 12)) div 4)
                   - floor((number(substring(Schedule/OpeningDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/OpeningDate, 6, 2))) div 12)) div 100)
                   + floor((number(substring(Schedule/OpeningDate, 1, 4)) + 4800 - floor((14 - number(substring(Schedule/OpeningDate, 6, 2))) div 12)) div 400)
                   - 32045)"/>
            </xsl:apply-templates>
          </tbody>
        </table>
        <p><strong>Calculation:</strong><xsl:text> Duration = Closing date - Opening date.</xsl:text></p>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Exhibition">

    <xsl:if test="position() &lt;= 5">
      <!-- Split OpeningDate into numeric-->
      <xsl:variable name="openYear" select="number(substring(Schedule/OpeningDate, 1, 4))"/>
      <xsl:variable name="openMonth" select="number(substring(Schedule/OpeningDate, 6, 2))"/>
      <xsl:variable name="openDay" select="number(substring(Schedule/OpeningDate, 9, 2))"/>

      <!--
        Prepare the opening date for the Gregorian-to-JDN formula
        openA is 1 for January/February and 0 for March-December
        (Take January and February as months of the previous year)
      -->
      <xsl:variable name="openA" select="floor((14 - $openMonth) div 12)"/>
      <xsl:variable name="openY" select="$openYear + 4800 - $openA"/>
      <xsl:variable name="openM" select="$openMonth + 12 * $openA - 3"/>

      <!--
        Convert the opening date to a Julian Day Number
        (The div 4, div 100 and div 400 terms apply Gregorian leap-year rules)
      -->
      <xsl:variable name="openJdn" select="$openDay + floor((153 * $openM + 2) div 5) + 365 * $openY + floor($openY div 4) - floor($openY div 100) + floor($openY div 400) - 32045"/>

      <!-- ClosingDate -> JDN (same methode)-->
      <xsl:variable name="closeYear" select="number(substring(Schedule/ClosingDate, 1, 4))"/>
      <xsl:variable name="closeMonth" select="number(substring(Schedule/ClosingDate, 6, 2))"/>
      <xsl:variable name="closeDay" select="number(substring(Schedule/ClosingDate, 9, 2))"/>
      <xsl:variable name="closeA" select="floor((14 - $closeMonth) div 12)"/>
      <xsl:variable name="closeY" select="$closeYear + 4800 - $closeA"/>
      <xsl:variable name="closeM" select="$closeMonth + 12 * $closeA - 3"/>

      <xsl:variable name="closeJdn" select="$closeDay + floor((153 * $closeM + 2) div 5) + 365 * $closeY + floor($closeY div 4) - floor($closeY div 100) + floor($closeY div 400) - 32045"/>

      <tr>
        <td><xsl:value-of select="position()"/></td>
        <td><xsl:value-of select="@id"/></td>
        <td><xsl:value-of select="Theme/@ref"/></td>
        <td><xsl:value-of select="Schedule/OpeningDate"/></td>
        <td><xsl:value-of select="Schedule/ClosingDate"/></td>
        <td><strong><xsl:value-of select="$closeJdn - $openJdn"/></strong></td>
      </tr>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
