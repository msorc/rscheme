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

#ifndef _H_BACKTRACKING
#define _H_BACKTRACKING

#include "platform.h"

typedef struct {
    UINT_32	gc_ptr;
    UINT_32	offset;
} ptr_location;

typedef ptr_location *ptr_locations_list;

#endif
