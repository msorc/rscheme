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
 * Purpose:          generic (stdio) file access for imageio
 *------------------------------------------------------------------------*/

#include "mapf.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "smemory.h"
#include "osglue.h"

struct image_buffer {
    void *block;
    struct image_buffer *next;
};

static struct image_buffer *image_buffers;
static FILE *image_file;

rs_bool mapf_open( const char *path )
{
    image_file = os_fopen( path, "rb" );
    if (!image_file)
    {
	perror( path );
	return NO;
    }
    image_buffers = NULL;
    return YES;
}

void mapf_seek( UINT_32 offset )
{
int rc;

    rc = fseek( image_file, offset, SEEK_SET );
    assert( rc == 0 );
}

void *mapf_read( UINT_32 bytes )
{
struct image_buffer *b = (struct image_buffer *)malloc( sizeof( struct image_buffer ) );
int n;

    b->next = image_buffers;
    image_buffers = b;
    b->block = malloc_aligned_32( bytes );
    assert( b->block );
    n = fread( b->block, 1, bytes, image_file );
    assert( n == bytes );
    return b->block;
}

void mapf_close( void )
{
struct image_buffer *b, *n;

    for (b=image_buffers; b; b=n)
    {
	n = b->next;
	free_aligned_32( b->block );
	free( b );
    }
}

