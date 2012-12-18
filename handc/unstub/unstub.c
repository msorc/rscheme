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

#include <rscheme/scheme.h>
#include <rscheme/linktype.h>
#include <rscheme/smemory.h>

jump_addr template_unstub( obj the_template )
{
  /* no stubbing, so it's already unstubbed */
  return OBJ_TO_JUMP_ADDR( gvec_ref( the_template, SLOT(0) ) );
}
