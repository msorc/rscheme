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
 | Owned by module:  codegen
 |
 | Purpose:          lexical address computation
 `------------------------------------------------------------------------|#

(define (find-lex-addr ct-envt var)
  (let loop ((e ct-envt) (i 0))
    (if (null? e)
	#f ;; a chance [cr 617] it might not be found
	(let ((x (memq var (car e))))
	  (if x
	      (cons i (- (length (car e)) (length x)))
	      (loop (cdr e) (add1 i)))))))
