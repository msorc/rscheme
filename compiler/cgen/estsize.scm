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
 | Owned by module:  (rsc)
 |
 `------------------------------------------------------------------------|#


;; estimating the size of code...

(define (count-vinsn vi)
    (case (car vi)
	((if)
	    (+ 1 (count-vinsn (caddr vi))
	         (count-vinsn (cadddr vi))))
	((seq)
	    (+ 1 (count-vinsns (cdr vi))))
	(else
	    1)))
	
(define (count-vinsns vinsns)
    (let loop ((i vinsns) (n 0))
	(if (null? i)
	    n
	    (loop (cdr i)
	    	  (+ (count-vinsn (car vinsns))
		     n)))))

(define (count-literal-bytes lc)
    (if (pair? lc)
	(+ (count-literal-bytes (car lc))
	   (count-literal-bytes (cdr lc)))
	(if (string? lc)
	    (string-length lc)
	    0)))
	    
