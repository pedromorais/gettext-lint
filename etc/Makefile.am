EXTRA_DIST = report.xsl report.css count.xsl

install-data-local:
	@$(NORMAL-INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(pkgdatadir); \
        $(INSTALL_DATA) $(EXTRA_DIST) $(DESTDIR)$(pkgdatadir)
