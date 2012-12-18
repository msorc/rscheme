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


(%strategy ccode

(define (append-2 lst1 lst2)
  (if (pair? lst1)
      (let (((first <pair>) (cons (car lst1) '())))
	(let loop (((prev <pair>) first)
		   (src (cdr lst1)))
	  (if (pair? src)
	      (let* (((s <pair> :trust-me) src)
		     ((c <pair>) (cons (car s) '())))
		(set-cdr! prev c)
		(loop c (cdr s)))
	      (begin
		(set-cdr! prev lst2)
		first))))
      lst2))

(define (append-n list-1 more-lists)
  (if (null? more-lists)
      list-1
      (append-2 list-1 (append-n (car more-lists) (cdr more-lists)))))

(define (append . lists)
  (if (pair? lists)
      (if (pair? (cdr lists))
	  (if (pair? (cddr lists))
	      (append-n (car lists) (cdr lists))
	      (append-2 (car lists) (cadr lists)))
	  (car lists))
      '()))
)