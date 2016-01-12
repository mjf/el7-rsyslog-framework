TARBALL	?= "el7-rsyslog-framework.tar.gz"
MANPAGE ?= "el7-rsyslog-framework.8"

all:	dist

man:
	@ rst2man README.rst >$(MANPAGE)

dist:
	@ tar czvf $(TARBALL) --owner=root --group=root --mode=0600 rsyslog.* >/dev/null

clean:	
	@ rm -f $(TARBALL)
	@ rm -f $(MANPAGE)

.PHONY:	clean

# vi:ft=make
