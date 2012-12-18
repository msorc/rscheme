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

#define GSTATE_IDLE		(0)
#define GSTATE_STABLE_SCAN	(1)
#define GSTATE_TRAVERSE_1	(2)
#define GSTATE_IGP_SCAN		(3)
#define GSTATE_TRAVERSE_2	(4)
#define GSTATE_QUASISTABLE_SCAN	(5)
#define GSTATE_TRAVERSE_3	(6)
#define GSTATE_UNSTABLE_SCAN	(7)
#define GSTATE_TRAVERSE_4	(8)
#define GSTATE_PHASE2		(9)
#define GSTATE_TRAVERSE_5	(10)


#define GSTATE_TERMINATE	(11)

#define GSTATE_REBLACKEN        (12)
#define GSTATE_XHEAP_SCAN       (13)
#define GSTATE_TRAVERSE_6       (14)
