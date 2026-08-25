<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:variable name="museum" select="/Museum"/>
		<!-- Select source Artifact nodes; this remains a normal node-set in XSLT 1.0. -->
		<xsl:variable name="candidates" select="$museum/Artifacts/Artifact[
        RestorationHistory/@under_restoration = 'true'
        and
        @id = $museum/Exhibitions/Exhibition/Artifacts/Artifact/@ref
      ]"/>
		<UseCase number="2" type="XML">
			<Question>Which ten artifacts currently planned for restoration, have the greatest aggregate public-exhibition exposure?</Question>
			<Metric>Sum of daily adult and under-age visitors across every exhibition containing the artifact; restoration loan breaks ties.</Metric>
			<TopExposedRestoredArtifacts limit="10" eligibleCandidateCount="{count($candidates)}">
				<xsl:for-each select="$candidates">
					<!-- xsl:sort must be placed before every other instruction in xsl:for-each. -->
					<xsl:sort select="sum(
              $museum/Exhibitions/Exhibition[
                Artifacts/Artifact/@ref = current()/@id
              ]/VisitorCount/Adult
              |
              $museum/Exhibitions/Exhibition[
                Artifacts/Artifact/@ref = current()/@id
              ]/VisitorCount/UnderAge
            )" data-type="number" order="descending"/>
					<xsl:sort select="$museum/Restoration/Project[
              Artifacts/Artifact/@ref = current()/@id
            ][1]/Loan" data-type="number" order="descending"/>
					<xsl:sort select="@id" data-type="text" order="ascending"/>
					<!-- position() is evaluated after sorting, so it is the final rank. -->
					<xsl:if test="position() &lt;= 10">
						<xsl:variable name="artifactId" select="@id"/>
						<xsl:variable name="artifactExhibitions" select="$museum/Exhibitions/Exhibition[
                Artifacts/Artifact/@ref = $artifactId
              ]"/>
						<xsl:variable name="project" select="$museum/Restoration/Project[
                Artifacts/Artifact/@ref = $artifactId
              ][1]"/>
						<xsl:variable name="themeRef" select="CulturalHeritage/@ref_Theme"/>
						<Artifact rank="{position()}" id="{$artifactId}" title="{substring-before(Description, '. Creator or culture:')}" themeRef="{$themeRef}" themeName="{normalize-space($museum/Themes/Theme[@id = $themeRef]/CulturalHeritage)}" aggregateVisitorsPerDay="{sum(
                $artifactExhibitions/VisitorCount/Adult
                |
                $artifactExhibitions/VisitorCount/UnderAge
              )}" exhibitionCount="{count($artifactExhibitions)}" collectionCount="{count(Collection)}" restorationProjectRef="{$project/@id}" restorationLoanEUR="{$project/Loan}">
							<Description>
								<xsl:value-of select="Description"/>
							</Description>													
							<Exhibitions>
								<xsl:for-each select="$artifactExhibitions">
									<Exhibition ref="{@id}" themeRef="{Theme/@ref}" adultVisitorsPerDay="{VisitorCount/Adult}" underAgeVisitorsPerDay="{VisitorCount/UnderAge}" totalVisitorsPerDay="{sum(VisitorCount/Adult | VisitorCount/UnderAge)}"/>
								</xsl:for-each>
							</Exhibitions>
							<RestorationProject ref="{$project/@id}" loanEUR="{$project/Loan}"/>
						</Artifact>
					</xsl:if>
				</xsl:for-each>
			</TopExposedRestoredArtifacts>
		</UseCase>
	</xsl:template>
</xsl:stylesheet>
