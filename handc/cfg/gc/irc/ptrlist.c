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
 * Purpose:          IRC pointer list implementation
 *------------------------------------------------------------------------*/

#include "irc.h"

void IRC_ptrListAdd( struct IRC_PtrList *list, IRC_Header *item )
{
struct IRC_PtrBucket *b = list->last;

    if (!b || b->ptr == &b->contents[IRC_PTR_BUCKET_SIZE])
    {
	b = MALLOC(struct IRC_PtrBucket);
	b->next = NULL;
	b->ptr = b->contents;
	if (list->first)
	{
	    list->last->next = b;
	}
	else
	{
	    list->first = b;
	}
	list->last = b;
    }
    *(b->ptr)++ = item;
}

void IRC_freePtrList( struct IRC_PtrList *ptrlist )
{
  struct IRC_PtrBucket *b, *next;

  for (b=ptrlist->first; b; b=next) {
    next = b->next;
    free( b );
  }
  ptrlist->first = ptrlist->last = NULL;
}
