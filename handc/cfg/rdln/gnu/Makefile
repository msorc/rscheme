#
# File:    handc/cfg/rdln/gnu/Makefile
#
#          Copyright (C)1995 Donovan Kolbly <donovan@tkg.com>
#          as part of the RScheme project, licensed for free use
#
# Version: %I%
# Date:    %G% %U%
# Build:   %b%
#
#


CFLAGS2=$(CFLAGS) -I$(HOME)/include
CFILES=rdln_gnu.c
PRODUCT=rdln.o

include ../postambl.mak

depend::
	$(CC) $(CFLAGS2) -MM -I. $(CFILES) > depends
.c.o:
	$(CC) $(CFLAGS2) -c $*.c
