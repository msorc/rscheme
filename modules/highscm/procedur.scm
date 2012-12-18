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
 | Owned by module:  high-scheme
 |
 | Purpose:          meta-procedures
 `------------------------------------------------------------------------|#

#|
  (reduce bin-op initial-value list)

  bin-op is a binary function used to combine the 
  elements of list into a single value.
|#

(define (reduce (bin-op <function>) initial-value list)
  (let loop ((i initial-value)
	     (l list))
    (if (pair? l)
	(loop (bin-op i (car l)) (cdr l))
	i)))

(define (reduce1 (bin-op <function>) (list <pair>))
  (reduce bin-op (car list) (cdr list)))

(define (curry function . curried-args)
  (case (length curried-args)
    ((0) (lambda args
	   (apply* args function)))
    ((1) (let ((arg-0 (car curried-args)))
	   (lambda args
	     (apply* arg-0 args function))))
    ((2) (let ((arg-0 (car curried-args))
	       (arg-1 (cadr curried-args)))
	   (lambda args
	     (apply* arg-0 arg-1 args function))))
    (else
     (lambda args
       (apply function (append curried-args args))))))

(define (rcurry function . curried-args)
  (lambda args
    (apply function (append args curried-args))))
