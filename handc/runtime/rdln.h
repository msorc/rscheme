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
 * Purpose:          define the interface to the rdln subsystem
 *------------------------------------------------------------------------*/

#ifndef _H_RSEDITINP_RDLN
#define _H_RSEDITINP_RDLN

#include <rscheme/obj.h>

rs_bool rdln_isa_tty( void );
rs_bool rdln_enabled( void );
void rdln_add_history( obj str );
obj read_console_line( obj completions_list, const char *prompt );

#endif /* _H_RSEDITINP_RDLN */
