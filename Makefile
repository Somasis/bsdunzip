BINDIR		?= $(PREFIX)/bin
MANDIR		?= $(PREFIX)/share/man/man1

CC			?= cc

all: bsdunzip.c bsdunzip

clean:
	rm -f bsdunzip bsdunzip.c bsdunzip.1

bsdunzip.c:
	echo '#define FNM_CASEFOLD 0x10' > bsdunzip.c
	echo 'int optreset;' >> bsdunzip.c
	cat ./usr.bin/unzip/unzip.c >> bsdunzip.c

bsdunzip: bsdunzip.c
	$(CC) -larchive -std=gnu99 $(CFLAGS) $(LDFLAGS) -o bsdunzip bsdunzip.c

man:
	cp ./usr.bin/unzip/unzip.1 bsdunzip.1

install: bsdunzip man
	mkdir -p $(DESTDIR)$(BINDIR)
	install bsdunzip $(DESTDIR)$(BINDIR)/bsdunzip
	mkdir -p $(DESTDIR)$(MANDIR)
	install bsdunzip.1 $(DESTDIR)$(MANDIR)/bsdunzip.1

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/bsdunzip $(DESTDIR)$(MANDIR)/bsdunzip.1

sync:
	git stash || true
	( cd ~/git/freebsd/; git log --no-merges --pretty=email --patch-with-stat --reverse -- usr.bin/unzip/ ) | git am
	date=$$(git log --no-merges -pretty='%cI' -n1 usr.bin/unzip/ | cut -d'T' -f1 | tr -d '-')
	git commit -v -s -m "Sync with FreeBSD upstream - $${date}" -e
	git stash pop || true

