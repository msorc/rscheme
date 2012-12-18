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

#ifdef TIMEPOINT
#include <time.h>
#include <stdio.h>
#include <rscheme/scheme.h>
#include <rscheme/smemory.h>
#endif
#include <rscheme/timeprof.h>

#ifdef TIMEPOINT

struct timepoint {
  struct timeval t;
  int id;
};

static struct timepoint *timepoints, *time_pt_lim, *time_pt;

void timepoint( int id )
{
  if (time_pt)
    {
      if (time_pt < time_pt_lim)
	{
	  time_pt->id = id;
	  gettimeofday( &time_pt->t, NULL );
	  time_pt++;
	}
      else
	time_pt = NULL;
    }
}

void start_timepoints( unsigned cap )
{
  timepoints = malloc( sizeof( struct timepoint ) * cap );
  time_pt_lim = timepoints + cap;
  time_pt = timepoints;
}


void flush_timepoints( const char *file )
{
  struct timepoint *p;
  extern unsigned insn_count;
  FILE *out = fopen( file, "w" );
  if (!out)
    {
      perror( file );
      return;
    }
  
  for (p=timepoints; p<time_pt; p++)
    {
      if (p->id < 0)
	fprintf( out, "--------- " );
      else
	fprintf( out, "%9d ", p->id );
      fprintf( out, "%9u.%06u", p->t.tv_sec, p->t.tv_usec );
      if (p+1 < time_pt)
	{
	  fprintf( out," (delta %6u us)", 
		  (p[1].t.tv_sec - p[0].t.tv_sec) * 1000000 
		  + (p[1].t.tv_usec - p[0].t.tv_usec));
	}
      if (p->id < 0)
	{
	  obj lit = OBJ(p->id - 0x80000000);
	  if (OBJ_ISA_PTR(lit))
	    fprintf( out, " [%s]", procedure_name(lit) ); 
	  else
	    fprintf( out, " <%08x>", lit );
	}
      fprintf( out, "\n" );
    }
  fprintf( out, "%u instructions (monotones)\n", insn_count );
  fprintf( out, "total time = %u us\n",
	  (time_pt[-1].t.tv_sec - timepoints[0].t.tv_sec) * 1000000
	  + (time_pt[-1].t.tv_usec - timepoints[0].t.tv_usec) );
  fclose(out);
}
#else

void start_timepoints( unsigned cap )
{
}

void flush_timepoints( const char *file )
{
}

#endif
