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

#ifndef _H_HEAPI_SAVEQ
#define _H_HEAPI_SAVEQ

#include <rscheme/scheme.h>

/* a very primitive SaveQueue implementation */

struct queue_entry {
  obj    thing;
  obj    orig_class;
};

typedef struct {
  struct queue_entry *contents;
  UINT_32  count, cap;
  UINT_32  ptr;
} SaveQueue;

void hi_init_queue( SaveQueue *q );
void hi_init_queue_n( SaveQueue *q, UINT_32 init_cap );
void hi_enqueue_item( SaveQueue *q, obj item );
void hi_enqueue_item2( SaveQueue *q, obj item, obj orig_class );
struct queue_entry *hi_dequeue_item( SaveQueue *q );
void hi_free_queue( SaveQueue *q );

#endif /* _H_HEAPI_SAVEQ */
