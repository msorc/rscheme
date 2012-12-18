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

#ifndef _H_MAPF
#define _H_MAPF

#include <rscheme/obj.h>

rs_bool mapf_open( const char *path );
void mapf_seek( UINT_32 offset );
void *mapf_read( UINT_32 bytes );
void mapf_close( void );

#endif /* _H_MAPF */

