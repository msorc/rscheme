#
# File:    handc/rshell/Makefile
#
#          Copyright (C)1995 Donovan Kolbly <donovan@tkg.com>
#          as part of the RScheme project, licensed for free use
#
# Version: %I%
# Date:    %G% %U%
# Build:   %b%
#
#

FINAL_INSTALL_DIR=$(INSTALL_DIR)
XCFLAGS='-DINSTALL_DIR="$(FINAL_INSTALL_DIR)"'

include $(INSTALL_DIR)/resource/buildenv/preamble.mak

CFILES=shell.c
PRODUCT=rs
INSTALL=cp -p

OFILES=$(CFILES:.c=.o)
LIB_RS=$(INSTALL_DIR)/lib/librs.a

$(PRODUCT): $(OFILES) $(LIB_RS)
	$(CC) $(CFLAGS) $(OFILES) -o $(PRODUCT) $(LDX_FLAGS)

install:: $(INSTALL_DIR)/bin
	$(INSTALL) $(PRODUCT) $(INSTALL_DIR)/bin

$(INSTALL_DIR)/bin:
	mkdir $(INSTALL_DIR)/bin

clean::
	rm -f $(OFILES) $(PRODUCT)

depend::
	$(CC) $(CFLAGS) -MM -I. $(CFILES) > depends
