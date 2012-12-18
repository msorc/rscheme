#|------------------------------------------------------------*-Scheme-*--|
 | File:    %p%
 |
 |          Copyright (C)1997 Donovan Kolbly <d.kolbly@rscheme.org>
 |          as part of the RScheme project, licensed for free use.
 |          See <http://www.rscheme.org/> for the latest information.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 |
 `------------------------------------------------------------------------|#


;;;======================================================================
;;;  there has been a bug in the reg-alloc up until 0.7.1
;;;  (actually the bug is that <ic-call> doesn't take into
;;;   account it's function or arguments when computing whether
;;;   or not it saves a continuation -- it only checks it's own
;;;   tailness)


(define *result* '())

(define (blah))

(define (quux) 
  (call-with-current-continuation 
   (lambda (q)
     (set! blah q)
     #f)))

(define (emit value)
  (set! *result* (cons value *result*)))

(define *fini* #f)

(define (foo x)
  (emit (begin
	  (set! *fini* (quux))
	  (let ((temp x))
	    (set! x (+ x 1))
	    temp))))

(define (foo-wrap)
  (foo 10)
  (if *fini*
      (*fini*)))

(test-section
 (register-allocation)
 ;;
 (foo-wrap)
 (call-with-current-continuation blah)
 (call-with-current-continuation blah)
 (check *result* '(12 11 10))
 (call-with-current-continuation blah)
 (check *result* '(13 12 11 10)))
