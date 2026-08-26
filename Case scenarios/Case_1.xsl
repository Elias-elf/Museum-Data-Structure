<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<!-- This use case is one of two, which outputs results in XML format -->
	<!-- In this scenario, we're looking for the top 5 collections, having the highest restoration workload.-->
	<!-- Workload means the number of artifacts under restoration, i.e. the artifacts whose restoration attribute is 'true'.-->
	<!-- Because collection membership is many-to-many, one artifact may contribute to several collections, and will be counted once for each parent collection. -->
	<!-- In the event of a tie, collections are sorted with respect to the total number of restoration projects covering each. -->
	<xsl:template match="/">
		<xsl:variable name="museum" select="/Museum"/>
		<UseCase number="1" type="XML">
			<TopFiveCollections>
				<!-- Iterate over Collection nodes. -->
				<xsl:for-each select="$museum/Collections/Collection">
					<!-- Primary ranking: artifacts in the collection which are under restoration. -->
					<xsl:sort select="count($museum/Artifacts/Artifact[Collection/@ref = current()/@id
                and
                RestorationHistory/@under_restoration = 'true'])" data-type="number" order="descending"/>
					<!-- Second criterion: number of associated restoration projects. -->
					<xsl:sort select="count($museum/Restoration/Project[
						  Artifacts/Artifact/@ref = $museum/Artifacts/Artifact[
							  Collection/@ref = current()/@id
							  and
							  RestorationHistory/@under_restoration = 'true']/@id
						])" data-type="number" order="descending"/>
					<!-- Final deterministic tie-breaker. -->
					<xsl:sort select="@id" data-type="text" order="ascending"/>
					<!-- position() is evaluated after sorting and therefore gives the rank. -->
					<xsl:if test="position() &lt;= 5">
						<xsl:variable name="collectionId" select="@id"/>
						<xsl:variable name="collectionArtifacts" select="$museum/Artifacts/Artifact[Collection/@ref = $collectionId]"/>
						<xsl:variable name="restoredArtifacts" select="$collectionArtifacts[RestorationHistory/@under_restoration = 'true']"/>
						<xsl:variable name="restorationProjects" select="$museum/Restoration/Project[Artifacts/Artifact/@ref = $restoredArtifacts/@id]"/>
						<Collection rank="{position()}" id="{$collectionId}" title="{normalize-space(Title)}">
							<Description>
								<xsl:value-of select="Description"/>
							</Description>
							<Artifact_ToBe_Restored>
								<xsl:value-of select="count($restoredArtifacts)"/>
								<!--This is the 1st ranking criteria - Number of artifacts under restoration-->
							</Artifact_ToBe_Restored>
							
							<ProjectCount>
								<xsl:value-of select="count($restorationProjects)"/>
								<!--This is the 2nd ranking criteria - Number of the associated restoration projects-->
							</ProjectCount>
							
							<TotalArtifactCount>
								<xsl:value-of select="count($collectionArtifacts)"/>
								<!--Total number of artifacts in the Collection - for information (not a ranking criteria)-->
							</TotalArtifactCount>
							
						</Collection>
					</xsl:if>
				</xsl:for-each>
			</TopFiveCollections>
		</UseCase>
	</xsl:template>
</xsl:stylesheet>
