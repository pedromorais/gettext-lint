bin_SCRIPTS = \
	POFileChecker \
	POFileConsistency \
	POFileEquiv \
        POFileFill \
	POFileSpell \
	POFileStatus \
	POFileClean

EXTRA_DIST = *.py PO*.in

install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(pkgdatadir); \
        $(INSTALL_DATA) *.py $(DESTDIR)$(pkgdatadir)

pychecker:
	@for i in *.py; do pychecker -Q $$i; done

clean:
	rm -f *~ *.pyc *.pyo
