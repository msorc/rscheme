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

#define NUM_GENS	(3)
#define NUM_SIZES	(10)
#define NUM_COLORS	(4)

typedef struct _DataRecord {
    unsigned short count[NUM_GENS][NUM_SIZES][NUM_COLORS];
} DataRecord;
