<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="catalog">
		<catalog>
			<xsl:apply-templates select="element" />
		</catalog>
	</xsl:template>

	<xsl:template match="element">
		<Plant>
			<xsl:attribute name="Question">
				<xsl:value-of select="question" />
			</xsl:attribute>
			<xsl:attribute name="Respond">
				<xsl:value-of select="respond" />
			</xsl:attribute>
			<xsl:attribute name="Date">
				<xsl:value-of select="date" />
			</xsl:attribute>
		</Plant>
	</xsl:template>

</xsl:stylesheet>