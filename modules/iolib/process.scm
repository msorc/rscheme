#|------------------------------------------------------------*-Scheme-*--|
 | File:	    %p%
 |
 |          Copyright (C)1998 Donovan Kolbly <d.kolbly@rscheme.org>
 |          as part of the RScheme project, licensed for free use.
 |	    See <http://www.rscheme.org/> for the latest info.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 | Owned by module:  iolib
 |
 | Purpose:          Hook layer for substituting new open-*-process impls
 `------------------------------------------------------------------------|#

;;; initial (default) implementations for open-*-process
;;;
;;;  the threads library, if installed, will redirect these
;;;  to be thread-aware procedures

(define *open-input-process* open-input-process/popen)
(define *open-output-process* open-output-process/popen)

(define (set-process-io-proc! which proc)
  (case which
    ((open-input-process)
     (set! *open-input-process* proc))
    ((open-output-process)
     (set! *open-output-process* proc))))

;;; the reason for these indirection is that some initial
;;; environments actually copy the bindings (e.g., the r4rs envt,
;;; though to be sure, these aren't in there anyway)
;;;
;;; nevertheless, it is late in the release cycle so I'm being
;;; conservative!  I even allow some additional arguments, just in
;;; case.

(define (open-input-process str . opts)
  (apply *open-input-process* str opts))

(define (open-output-process str . opts)
  (apply *open-output-process* str opts))
				   
