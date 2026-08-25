<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="museum" select="/Museum"/>

    <UseCase number="1" type="XML">
      <Question>Which five collections have the greatest current restoration workload?</Question>
      <Metric>Number of artifacts in each collection whose RestorationHistory/@under_restoration attribute is true.</Metric>
      <TieBreakRule>Total number of artifacts in the collection descending, then collection ID ascending.</TieBreakRule>

      <TopCollections
        limit="5"
        evaluatedCollectionCount="{count($museum/Collections/Collection)}">

        <!-- Iterate directly over source Collection nodes. -->
        <xsl:for-each select="$museum/Collections/Collection">

          <!-- Primary ranking: currently restored artifacts in the collection. -->
          <xsl:sort
            select="count(
              $museum/Artifacts/Artifact[
                Collection/@ref = current()/@id
                and
                RestorationHistory/@under_restoration = 'true'
              ]
            )"
            data-type="number"
            order="descending"/>

          <!-- First tie-breaker: total collection size. -->
          <xsl:sort
            select="count(
              $museum/Artifacts/Artifact[
                Collection/@ref = current()/@id
              ]
            )"
            data-type="number"
            order="descending"/>

          <!-- Final deterministic tie-breaker. -->
          <xsl:sort select="@id" data-type="text" order="ascending"/>

          <!-- position() is evaluated after sorting and therefore gives the rank. -->
          <xsl:if test="position() &lt;= 5">
            <xsl:variable name="collectionId" select="@id"/>
            <xsl:variable name="collectionArtifacts"
              select="$museum/Artifacts/Artifact[
                Collection/@ref = $collectionId
              ]"/>
            <xsl:variable name="restoredArtifacts"
              select="$collectionArtifacts[
                RestorationHistory/@under_restoration = 'true'
              ]"/>
            <xsl:variable name="restorationProjects"
              select="$museum/Restoration/Project[
                Artifacts/Artifact/@ref = $restoredArtifacts/@id
              ]"/>

            <Collection
              rank="{position()}"
              id="{$collectionId}"
              title="{normalize-space(Title)}"
              currentRestorationArtifactCount="{count($restoredArtifacts)}"
              totalArtifactCount="{count($collectionArtifacts)}"
              associatedRestorationProjectCount="{count($restorationProjects)}"
              associatedRestorationLoanEUR="{sum($restorationProjects/Loan)}">

              <Description>
                <xsl:value-of select="Description"/>
              </Description>

              <WorkloadDefinition>
                <xsl:text>An artifact contributes once to this collection's workload when it belongs to the collection and has under_restoration='true'. Because collection membership is many-to-many, one artifact may contribute to several collections.</xsl:text>
              </WorkloadDefinition>
            </Collection>
          </xsl:if>
        </xsl:for-each>
      </TopCollections>
    </UseCase>
  </xsl:template>
</xsl:stylesheet>
