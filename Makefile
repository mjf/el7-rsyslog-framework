TARBALL	?= "el7-rsyslog-framework.tar.gz"
MANPAGE ?= "el7-rsyslog-framework.8"

all:	man dist

man:
	@ rst2man README.rst >$(MANPAGE)

dist:
	@ tar czvf $(TARBALL) rsyslog.* >/dev/null

clean:	
	@ rm -f $(TARBALL)
	@ rm -f $(MANPAGE)

.PHONY:	clean

# vi:ft=make
