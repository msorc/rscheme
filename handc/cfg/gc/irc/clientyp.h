/*-----------------------------------------------------------------*-C-*---
 * File:    %p%
 *
 *          Copyright (C)1997 Donovan Kolbly <d.kolbly@rscheme.org>
 *          as part of the RScheme project, licensed for free use.
 *          See <http://www.rscheme.org/> for the latest information.
 *
 * File version:     %I%
 * File mod date:    %E% %U%
 * System build:     %b%
 *
 *------------------------------------------------------------------------*/

#ifndef _H_CLIENTYP
#define _H_CLIENTYP

/* types that the client is obligated to provide */

#include <rscheme/obj.h>
#include <rscheme/linktype.h>

typedef struct _stableRI {
  obj                      *last_ptr;
  struct unit_root_iterator uri;
} IRC_clientStableRootIterator;

typedef unsigned IRC_clientQuasistableRootIterator;

typedef struct _unstableRI {
  obj      *stack_cache;
  unsigned sig_queue;
} IRC_clientUnstableRootIterator;

#endif /* _H_CLIENTYP */
