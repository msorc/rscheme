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

#ifndef _H_BCEXTEND
#define _H_BCEXTEND

#include <rscheme/obj.h>

typedef union _RS_bc_datum {
    obj      	obj_val;
    IEEE_64  	raw_float_val;
    char     	*raw_str_val;
    rs_bool    raw_bool_val;
    INT_32   	raw_int_val;
    void	*raw_ptr_val;
    INT_64      raw_int_64_val;
    IEEE_32     raw_float_32_val;
} RS_bc_datum;

/*
   on entry
                       +-------------+
                       |  first arg  |
                       +-------------+
                       | second arg  |
                       +-------------+
                       |    ...      |
                       +-------------+
                       |  last arg   |
           args   ---> +-------------+

  on exit:
                       +-------------+
                       |    result   |
           args   ---> +-------------+
*/

typedef UINT_8 *RS_bc_extension_fn( UINT_8 *pc, RS_bc_datum **args );

/*  standard BCI extension codes  */

#define BCI_NO_EXTN     (0)
#define BCI_STDIO_EXTN  (10)     /* iolib (base system) */
#define BCI_OS_EXTN     (11)     /* syscalls (standard package) */
#define BCI_X11_EXTN    (12)     /* x11 (package) */

#define BCI_TKG_EXTN    (80)     /* from here to BCI_GNU_EXTN reserved for
				    TKG packages */
#define BCI_GNU_EXTN    (100)    /* from here to BCI_USER_EXTN reserved
				   for GNU packages */
#define BCI_USER_EXTN   (200)    /* everything from here on is reserved for
				   the user */

#endif /* _H_BCEXTEND */
