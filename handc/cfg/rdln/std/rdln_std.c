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
 * Purpose:          interface to stdio to serve role of readline library
 *------------------------------------------------------------------------*/

#include <rscheme/obj.h>
#include <rscheme/rdln.h>

rs_bool rdln_isa_tty( void )
{
  return YES;
}

rs_bool rdln_enabled( void )
{
  return NO;
}

void rdln_add_history( obj str )
{
}

obj read_console_line( obj completions, const char *prompt )
{
  return ZERO;
}
