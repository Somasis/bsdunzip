BINDIR		?= $(PREFIX)/bin
MANDIR		?= $(PREFIX)/share/man/man1

CC			?= cc

all: clean unzip

clean:
	rm -f unzip unzip_fixed.c

unzip:
	echo '#define FNM_CASEFOLD 0x10' > unzip_fixed.c
	echo 'int optreset;' >> unzip_fixed.c
	cat ./usr.bin/unzip/unzip.c >> unzip_fixed.c
	$(CC) -larchive $(CFLAGS) $(LDFLAGS) -o unzip unzip_fixed.c

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	install unzip $(DESTDIR)$(BINDIR)/unzip
	mkdir -p $(DESTDIR)$(MANDIR)
	install unzip.1 $(DESTDIR)$(MANDIR)/unzip.1

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/unzip $(DESTDIR)$(MANDIR)/unzip.1

sync:
	git stash || true
	( cd ~/git/freebsd/; git log --no-merges --pretty=email --patch-with-stat --reverse -- usr.bin/unzip/ ) | git am
	date=$$(git log --no-merges -pretty='%cI' -n1 usr.bin/unzip/ | cut -d'T' -f1 | tr -d '-')
	git commit -v -s -m "Sync with FreeBSD upstream - $${date}" -e
	git stash pop || true

