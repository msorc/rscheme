/*-----------------------------------------------------------------*-C-*---
 * File:    %p%
 *
 *          Contributed by HIROSHI OOTA <oota@POBoxes.com>
 *          as part of the RScheme project, licensed for free use.
 *          See <http://www.rscheme.org/> for the latest info.
 *
 * File version:     %I%
 * File mod date:    %E% %U%
 * System build:     %b%
 *
 * Purpose:          FreeBSD dynamic linking interface
 *------------------------------------------------------------------------*/

#include <stdio.h>
#include <dlfcn.h>

#ifndef	RTLD_NOW
#define	RTLD_NOW	DL_LAZY
#endif
void *resolve_link_symbol( void *info, const char *sym )
{
  return dlsym( info, sym );
}

void *dynamic_link_file( const char *path )
{
  return dlopen( path, RTLD_NOW );
}

const char *dynamic_link_errors( void )
{
  return dlerror();
}

void done_resolving( void *info )
{
}

void init_dynamic_link( const char *argv0 )
{
}


