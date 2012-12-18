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

#ifdef _H_GCXVERSE
#define _H_GCXVERSE

#ifdef INLINES
#include "gcxverse.ci"
#endif

LINK_TYPE void gc_next_object( pos_ptr_addr p, gc_obj_addr ptr_to_object );

#endif
