# $NetBSD: Makefile,v 1.2 2003/01/22 02:56:30 lukem Exp $

PROG=	progress
SRCS=	progress.c progressbar.c strsuftoll.c


CPPFLAGS    +=-Iinclude -DSTANDALONE_PROGRESS
UNAME       ?= $(shell uname)
PREFIX      ?= /usr
PROG_PREFIX ?= bsd-

ifeq ($(UNAME), Linux)
ifeq ($(shell pkg-config libbsd-overlay && echo 1),1)
	CPPFLAGS+=$(shell pkg-config libbsd-overlay --cflags)
	LDFLAGS+=$(shell pkg-config libbsd-overlay --libs)
endif # ($(shell pkg-config libbsd-overlay && echo 1),1)
endif # ($(UNAME), Linux)

all: $(PROG)

$(PROG): $(SRCS:%.c=%.o)
	$(CC) $(LDFLAGS) -o $@ $^

install: $(PROG) progress.1
	install -Dm755 $(PROG) $(DESTDIR)$(PREFIX)/bin/$(PROG_PREFIX)$(PROG)
	install -Dm644 progress.1 $(DESTDIR)$(PREFIX)/share/man/man1/$(PROG_PREFIX)progress.1

clean:
	rm -f *.o $(PROG)

.PHONY: all install clean
