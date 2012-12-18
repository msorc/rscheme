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

#include <string.h>
#include <ConditionalMacros.h>

#define JCG_FIX 1

/*
#define DEBUG_0 1
#define STEP_DUMP 1
#define DEBUG_BCI 1
#define TYPECHECK_EVAL_STACK 1
*/

#ifndef TRUE
#define FALSE 0
#define TRUE !FALSE
#endif
