man_MANS = POFileConsistency.1 POFileChecker.1 POTFileChecker.1
EXTRA_DIST = $(man_MANS)
docbook = POFileConsistency.xml POFileChecker.xml POTFileChecker.xml

docbook2man:
	for I in $(docbook); do \
	xsltproc \
	/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl $$I; \
	done
