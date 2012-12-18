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
 * Purpose:          IRIX dynamic linking interface
 *------------------------------------------------------------------------*/

#include <stdio.h>
#include <dlfcn.h>
#include <rscheme/linktype.h>

void *resolve_link_symbol( void *dlhandle, const char *sym )
{
  void *fct;

  fct = dlsym(dlhandle, sym);
  
  if (fct == NULL) {
    /* couldn't find symbol */
    return NULL;
  } else
    return fct;
  
}

void *dynamic_link_file( const char *path )
{
  void *dlhandle;

  dlhandle = dlopen(path, RTLD_LAZY);

  if (dlhandle == NULL) {
    /* couldn't open DSO */
    return NULL;
  } else
    return dlhandle;

}

void done_resolving( void *dlhandle )
{
  dlclose(dlhandle);
}

void init_dynamic_link( const char *argv0 )
{
}

const char *dynamic_link_errors( void )
{
  return NULL;
}
