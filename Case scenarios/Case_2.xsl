<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<!-- This use case is one of two, which outputs results in XML format -->
	<!-- In this scenario, we're looking for the top 10 artifacts under restoration, having the highest public exposure.-->
	<!-- Exposure means the number of daily visitors across every exhibition containing the artifact.-->
	<!-- In the event of a tie, sort by the total restoration projects' loan.-->
	<!-- Because restoration membership is many-to-many, one artifact may be covered by several projects, and will be counted once for each parent project. -->
	<xsl:template match="/">
		<xsl:variable name="museum" select="/Museum"/>
		<!-- Select Artifact nodes which are jointly under restoration and planned for exhibitions. -->
		<xsl:variable name="candidates" select="$museum/Artifacts/Artifact[RestorationHistory/@under_restoration = 'true'
        and @id = $museum/Exhibitions/Exhibition/Artifacts/Artifact/@ref]"/>
		<UseCase number="2" type="XML">
			<TopTen_ExposedRestoredArtifacts keep="10" out_of_max="{count($candidates)}">
				<xsl:for-each select="$candidates">
					<!-- First sort by the total number of visitors per day -->
					<xsl:sort select="sum(
              $museum/Exhibitions/Exhibition[Artifacts/Artifact/@ref = current()/@id]/VisitorCount/Adult
              |
              $museum/Exhibitions/Exhibition[Artifacts/Artifact/@ref = current()/@id]/VisitorCount/UnderAge)" data-type="number" order="descending"/>
					<!-- In the event of a tie, sort by the total restoration project loan in descending order-->
					<xsl:sort select="sum($museum/Restoration/Project[Artifacts/Artifact/@ref = current()/@id]/Loan)" data-type="number" order="descending"/>
					<!-- Final deterministic tie-breaker. -->
					<xsl:sort select="@id" data-type="text" order="ascending"/>
					<!-- position() is evaluated after sorting, so it is the final rank. -->
					<xsl:if test="position() &lt;= 10">
						<xsl:variable name="artifactId" select="@id"/>
						<xsl:variable name="artifactExhibitions" select="$museum/Exhibitions/Exhibition[Artifacts/Artifact/@ref = $artifactId]"/>
						<Artifact rank="{position()}" id="{$artifactId}" title="{substring-before(Description, '. Creator or culture:')}">
							<MaxExposure unit="Visitors/Day">
								<xsl:value-of select="sum($artifactExhibitions/VisitorCount/Adult | $artifactExhibitions/VisitorCount/UnderAge)"/>
							</MaxExposure>
							<ExhibitionCount>
								<xsl:value-of select="count($artifactExhibitions)"/>
							</ExhibitionCount>
							<TotalRestorationLoan currency="EUR">
								<xsl:value-of select="sum($museum/Restoration/Project[Artifacts/Artifact/@ref = current()/@id]/Loan)"/>
							</TotalRestorationLoan>
						</Artifact>
					</xsl:if>
				</xsl:for-each>
			</TopTen_ExposedRestoredArtifacts>
		</UseCase>
	</xsl:template>
</xsl:stylesheet>
