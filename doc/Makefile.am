man_MANS = POFileConsistency.1 POFileChecker.1 POFileSpell.1 \
	POFileFill.1 POFileEquiv.1 POFileStatus.1 POFileClean.1 \
	POFileGlossary.1
EXTRA_DIST = $(man_MANS)
docbook = POFileConsistency.xml POFileChecker.xml POFileSpell.xml \
	POFileFill.xml POFileEquiv.xml POFileStatus.xml POFileClean.xml \
	POFileGlossary.xml

docbook: docbook2man docbook2html

docbook2man:
	for I in $(docbook); do \
	xsltproc \
	/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl $$I; \
	done

docbook2html:
	for I in $(docbook); do \
	xsltproc \
	/usr/share/sgml/docbook/xsl-stylesheets/html/docbook.xsl $$I > \
	$${I%%.xml}.html; \
	done
