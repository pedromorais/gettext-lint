<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>

<xsl:template match="/po-file-status">
  <xsl:value-of select="count(file[@untranslated or @fuzzy or error])"/>
</xsl:template>

<xsl:template match="/po-file-checker|/pot-file-checker|/po-file-spell">
  <xsl:value-of select="count(file/error)"/>
</xsl:template>

<xsl:template match="/po-file-consistency">
  <xsl:value-of select="count(inconsistency)"/>
</xsl:template>

</xsl:stylesheet>
