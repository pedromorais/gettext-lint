man_MANS = POFileConsistency.1 POFileChecker.1 POFileSpell.1 \
	POTFileChecker.1
EXTRA_DIST = $(man_MANS)
docbook = POFileConsistency.xml POFileChecker.xml POFileSpell.xml \
	POTFileChecker.xml

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
