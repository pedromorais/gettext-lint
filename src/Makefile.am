bin_SCRIPTS = \
	POFileChecker \
	POFileConsistency \
	POFileEquiv \
        POFileFill \
	POFileSpell \
	POFileStatus \
	POFileReplace \
	POFileConsistencyShell \
	POFileSpellShell \
	POTFileChecker

EXTRA_DIST = *.py PO*.in

install-data-local:
	@$(NORMAL-INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(pkgdatadir); \
        $(INSTALL_DATA) *.py $(DESTDIR)$(pkgdatadir)

pychecker:
	@for i in *.py; do pychecker -Q $$i; done

clean:
	@$(NORMAL-CLEAN)
	rm -f *~ *.pyc *.pyo
