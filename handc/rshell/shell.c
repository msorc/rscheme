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
 * Purpose:          Trivial "shell" application
 *------------------------------------------------------------------------*/

#include <stdlib.h>
#include <stdio.h>
#include <rscheme/api.h>
#include <rscheme/stdmodul.h>
#include <rscheme/rlseconf.h>

#ifdef PLATFORM_MAC_CODEWARRIOR
#include <stdio.h>
#include <sioux.h>
#endif

struct module_descr *(std_modules[]) = { STD_MODULES_DECL };

int main( int argc, const char **argv )
{
#ifdef PLATFORM_MAC_CODEWARRIOR
  /* configure the I/O window */
  SIOUXSettings.autocloseonquit = TRUE;
  SIOUXSettings.asktosaveonclose = TRUE;
#endif

  rs_install_dir = getenv( "RS_INSTALL_DIR" );
  if (!rs_install_dir)
    rs_install_dir = INSTALL_DIR;

#ifdef PLATFORM_MAC
  return rscheme_std_main( argc, argv, std_modules, "install/system.img" );
#else
  {
    char temp[1024];

    sprintf( temp, "%s/resource/system.img", rs_install_dir );
    return rscheme_std_main( argc, argv, std_modules, temp );
  }
#endif
}
