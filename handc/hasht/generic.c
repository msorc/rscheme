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
 * Purpose:          code for "generic" hash tables (any hash-fn, any eq-fn)
 *------------------------------------------------------------------------*/

#include <rscheme/hashmain.h>
#include <rscheme/runtime.h>
#include <rscheme/vinsns.h>
#include <rscheme/rsmodule.h>
#include "htstruct.h"

#ifndef NULL
#ifdef __cplusplus
#define NULL (0)
#else
#define NULL ((void *)0)
#endif
#endif

#include "generic.ci"

static struct function_descr *(fn_tab[]) = {
    &generic_lookup_descr,
    &generic_remove_descr,
    &generic_insert_descr,
    &generic_probe_descr,
    NULL };

struct part_descr rscheme_hasht_part = { 
    9502, 
    &module_rscheme, 
    fn_tab,
    "rscheme-hasht" };
