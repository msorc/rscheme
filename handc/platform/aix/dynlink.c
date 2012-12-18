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
 * Purpose:          AIX dynamic linking interface
 *------------------------------------------------------------------------*/

#include <stdio.h>
#include <dlfcn.h>

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


