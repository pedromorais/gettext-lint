SUBDIRS = src etc

EXTRA_DIST = $(PACKAGE).spec

RPMDIR = $(shell [ -z "$$RPMDIR" ] && echo "../rpm" || echo "$$RPMDIR")
rpm: dist
	mkdir -p $(RPMDIR)/BUILD $(RPMDIR)/RPMS $(RPMDIR)/SRPMS $(RPMDIR)/SPECS
	rpmbuild --define="_topdir $(shell pwd)/$(RPMDIR)" --clean -ta $(distdir).tar.gz
