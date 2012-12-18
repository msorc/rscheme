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
 * Purpose:          interface to dynamic linking feature
 *------------------------------------------------------------------------*/

/*
 *  dynamic linking is an optional feature,
 *  but the functions are always present (they
 *  may be stubbed out)
 */

void init_dynamic_link( const char *argv0 );
void done_resolving( void *info );
void *dynamic_link_file( const char *path );
void *resolve_link_symbol( void *info, const char *sym );
const char *dynamic_link_errors( void );
