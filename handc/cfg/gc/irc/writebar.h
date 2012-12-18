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

#define WB_NONE  (0)		/* write is safe */
#define WB_COLOR (1)    	/* could violate color invariant */
#define WB_GENERATION (2)	/* could violate generation invariant */
#define WB_GLOBAL (3)		/* writing into a global object */
#define WB_PERSISTENT (4)       /* writing into a persistent object */
