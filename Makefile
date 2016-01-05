TARBALL	?= "el7-rsyslog-framework.tar.gz"

all:	dist

dist:
	@ tar czvf $(TARBALL) rsyslog.* >/dev/null

clean:	
	@ rm -f $(TARBALL)

.PHONY:	clean

# vi:ft=make
