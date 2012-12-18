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

#ifndef _H_RS_TIMEPOINT
#define _H_RS_TIMEPOINT

#ifdef TIMEPOINT
void timepoint( int id );
#else
#define timepoint(id) do {} while (0)
#endif

void start_timepoints( unsigned cap );
void flush_timepoints( const char *file );

#endif /* _H_RS_TIMEPOINT */
