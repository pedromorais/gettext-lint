<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml">

<xsl:output method="xml" media-type="text/html"
            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
            doctype-public="-//W3C//DTD XHTML 1.1//EN"/>

<xsl:param name="css"/>

<xsl:template match="/">
  <xsl:apply-templates select="*"/>
</xsl:template>

<!-- html structure -->

<xsl:template match="report|po-file-status|po-file-checker|pot-file-checker|po-file-spell|po-file-spell-overview|po-file-consistency|po-file-equiv">
  <html>
    <head>
      <title><xsl:apply-templates select="current()" mode="title"/></title>
      <xsl:if test="string-length($css) &gt; 0">
	<link rel="stylesheet" type="text/css" href="{$css}"/>
      </xsl:if>
    </head>
    <body>
      <xsl:apply-templates select="current()" mode="body"/>
    </body>
  </html>
</xsl:template>

<!-- meta report -->

<xsl:template match="report" mode="title">
  <xsl:text>Report</xsl:text>
</xsl:template>

<xsl:template match="report" mode="body">
  <xsl:apply-templates select="*" mode="body"/>
</xsl:template>


<!-- po file status -->

<xsl:template match="po-file-status" mode="title">
  <xsl:text>PO File Status Report</xsl:text>
</xsl:template>

<xsl:template match="po-file-status" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <xsl:variable name="p" select="file[@untranslated or @fuzzy or error or @not-found or @obsolete]"/>
  <p>
    <em>
      <xsl:call-template name="problems">
	<xsl:with-param name="c" select="count($p)"/>
      </xsl:call-template>
    </em>
  </p>
  <xsl:if test="count($p)">
    <table>
      <tr>
	<td>file</td>
	<td>fuzzy</td>
	<td>untranslated</td>
      </tr>
      <xsl:apply-templates select="$p" mode="status">
        <xsl:sort select="@name"/>
      </xsl:apply-templates>
    </table>
  </xsl:if>
</xsl:template>

<xsl:template match="file[error]" mode="status">
  <tr>
    <td><xsl:value-of select="@name"/></td>
    <td span="2"><xsl:value-of select="error"/></td>
  </tr>
</xsl:template>

<xsl:template match="file[@obsolete = 'true']" mode="status">
  <tr>
    <td><xsl:value-of select="@name"/></td>
    <td span="2">obsolete</td>
  </tr>
</xsl:template>

<xsl:template match="file[@not-found = 'true']" mode="status">
  <tr>
    <td><xsl:value-of select="@name"/></td>
    <td span="2">totally untranslated</td>
  </tr>
</xsl:template>

<xsl:template match="file" mode="status">
  <tr>
    <td><xsl:value-of select="@name"/></td>
    <td><xsl:value-of select="@fuzzy"/></td>
    <td><xsl:value-of select="@untranslated"/></td>
  </tr>
</xsl:template>


<!-- po file checker -->

<xsl:template match="po-file-checker" mode="title">
  <xsl:text>PO File Checker Report</xsl:text>
</xsl:template>

<xsl:template match="po-file-checker" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <em>
    <xsl:call-template name="problems">
      <xsl:with-param name="c" select="count(file/error)"/>
    </xsl:call-template>
  </em>
  <xsl:if test="file">
    <table>
      <tr>
	<td>file</td>
	<td>line</td>
	<td>problem</td>
      </tr>
      <xsl:apply-templates select="file" mode="checker"/>
    </table>
  </xsl:if>
</xsl:template>


<!-- pot file checker -->

<xsl:template match="pot-file-checker" mode="title">
  <xsl:text>POT File Checker Report</xsl:text>
</xsl:template>

<xsl:template match="pot-file-checker" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <em>
    <xsl:call-template name="problems">
      <xsl:with-param name="c" select="count(file/error)"/>
    </xsl:call-template>
  </em>
  <xsl:if test="file">
    <table>
      <tr>
	<td>file</td>
	<td>line</td>
	<td>problem</td>
      </tr>
      <xsl:apply-templates select="file" mode="checker"/>
    </table>
  </xsl:if>
</xsl:template>


<!-- po/pot checker common code -->

<xsl:template match="file" mode="checker">
  <tr>
    <td rowspan="{count(error)}"><xsl:value-of select="@name"/></td>
    <xsl:apply-templates select="error[position() = 1]" mode="checker"/>
  </tr>
  <xsl:for-each select="error[position() > 1]">
    <tr>
      <xsl:apply-templates select="current()" mode="checker"/>
    </tr>
  </xsl:for-each>
</xsl:template>

<xsl:template match="error" mode="checker">
  <td><xsl:value-of select="@line"/></td>
  <td><xsl:value-of select="current()"/></td>
</xsl:template>


<!-- po file spell -->

<xsl:template match="po-file-spell" mode="title">
  <xsl:text>PO File Spell Report</xsl:text>
</xsl:template>

<xsl:template match="po-file-spell" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <em>
    <xsl:call-template name="problems">
      <xsl:with-param name="c" select="count(file/error)"/>
    </xsl:call-template>
  </em>
  <xsl:if test="file">
    <table>
      <tr>
	<td>file</td>
	<td>errors</td>
      </tr>
      <xsl:apply-templates select="file" mode="spell"/>
    </table>
  </xsl:if>
</xsl:template>

<xsl:template match="file" mode="spell">
  <tr>
    <td><xsl:value-of select="@name"/></td>
    <td><xsl:apply-templates select="error" mode="spell"/></td>
  </tr>
</xsl:template>

<xsl:template match="error" mode="spell">
  <xsl:value-of select="current()"/><xsl:text> </xsl:text>
</xsl:template>


<!-- po file spell overview -->

<xsl:template match="po-file-spell-overview" mode="title">
  <xsl:text>PO File Spell Overview Report</xsl:text>
</xsl:template>

<xsl:template match="po-file-spell-overview" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <em>
    <xsl:call-template name="problems">
      <xsl:with-param name="c" select="count(error)"/>
    </xsl:call-template>
  </em>
  <xsl:if test="error">
    <table>
      <tr>
	<td>error</td>
	<td>number of files</td>
      </tr>
      <xsl:apply-templates select="error" mode="spell-overview">
         <xsl:sort select="@count" data-type="number" order="descending"/>
      </xsl:apply-templates>
    </table>
  </xsl:if>
</xsl:template>

<xsl:template match="error" mode="spell-overview">
  <tr>
    <td><xsl:value-of select="@count"/></td>
    <td><xsl:value-of select="current()"/></td>
  </tr>
</xsl:template>


<!-- po file consistency -->

<xsl:template match="po-file-consistency" mode="title">
  <xsl:text>PO File Consistency Report</xsl:text>
</xsl:template>

<xsl:template match="po-file-consistency" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <em>
    <xsl:call-template name="problems">
      <xsl:with-param name="c" select="count(inconsistency)"/>
    </xsl:call-template>
  </em>
  <xsl:if test="inconsistency">
    <table>
      <tr>
	<td>msgid</td>
	<td>file</td>
	<td>msgstr</td>
      </tr>
      <xsl:apply-templates select="inconsistency"/>
    </table>
  </xsl:if>
</xsl:template>

<xsl:template match="inconsistency">
  <tr>
    <td rowspan="{count(msgstr)}"><xsl:value-of select="msgid"/></td>
    <xsl:apply-templates select="msgstr[position() = 1]"/>
  </tr>
  <xsl:for-each select="msgstr[position() > 1]">
    <tr>
      <xsl:apply-templates select="current()"/>
    </tr>
  </xsl:for-each>
</xsl:template>

<xsl:template match="msgstr">
  <td><xsl:apply-templates select="filename"/></td>
  <td><xsl:value-of select="content"/></td>
</xsl:template>

<xsl:template match="filename">
  <xsl:value-of select="current()"/>
  <xsl:if test="position()!=last()"><br/></xsl:if>
</xsl:template>


<!-- po file equiv -->

<xsl:template match="po-file-equiv" mode="title">
  <xsl:text>PO File Glossary</xsl:text>
</xsl:template>

<xsl:template match="po-file-equiv" mode="body">
  <h1><xsl:apply-templates select="current()" mode="title"/></h1>
  <xsl:if test="entry">
    <table>
      <tr>
	<td>original</td>
	<td>translation</td>
      </tr>
      <xsl:apply-templates select="entry">
        <xsl:sort select="original" data-type="text" order="ascending"/>
      </xsl:apply-templates>
    </table>
  </xsl:if>
</xsl:template>

<xsl:template match="entry">
  <tr>
    <td><xsl:value-of select="original"/></td>
    <td>
      <xsl:for-each select="translation">
	<xsl:value-of select="current()"/>
	<xsl:if test="position() != last()">, </xsl:if>
      </xsl:for-each>
    </td>
  </tr>
</xsl:template>


<!-- utility templates -->

<xsl:template name="problems">
  <xsl:param name="c"/>
  <xsl:choose>
    <xsl:when test="$c &gt; 1">
      <xsl:value-of select="$c"/>
      <xsl:text> problems found</xsl:text>
    </xsl:when>
    <xsl:when test="$c = 1">
      <xsl:text>1 problem found</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>no problems found</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
