EXTRA_DIST = report.xsl count.xsl

install-data-local:
	@$(NORMAL-INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(pkgdatadir); \
        $(INSTALL_DATA) report.xsl $(DESTDIR)$(pkgdatadir); \
        $(INSTALL_DATA) count.xsl $(DESTDIR)$(pkgdatadir)
