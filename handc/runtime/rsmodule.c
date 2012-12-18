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
 * Purpose:          "RScheme" C module defn, to include runtime and hasht parts
 *------------------------------------------------------------------------*/

#include <rscheme/linktype.h>
#include <rscheme/rsmodule.h>
#include <rscheme/scheme.h>

/****************************************************/

static struct part_descr *(tab[]) = {
    &rscheme_hasht_part,
    &rscheme_runtime_part,
    (struct part_descr *)0 };

struct module_descr module_rscheme = { 
               /* name */  "RScheme", 
              /* parts */  tab,
          /* num_roots */  NUM_RSCHEME_GLOBALS,
        /* root_vector */  rscheme_global,
       /* roots (info) */  NULL,
      /* bc_extensions */  NULL,
  /* num_bc_extensions */  0 };
