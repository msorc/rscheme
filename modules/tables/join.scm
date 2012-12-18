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
 | Owned by module:  tables
 |
 | Purpose:          hash join function for tables
 `------------------------------------------------------------------------|#

(define (table-join a b a-only b-only a-and-b)
  (if (not (and (eq? (table-equal-function a)
		     (table-equal-function b))
		(eq? (table-hash-function a)
		     (table-hash-function b))))
      (error "table-join: incommensurate tables given: ~s and ~s" a b)
      (let* ((eq-fn (table-equal-function a))
	     (union (make-table eq-fn (table-hash-function a))))
	(table-for-each
	 a
	 (lambda (h k v)
	   (let ((bv (table-lookup b k)))
	     (if bv
		 (begin
		   (if a-and-b
		       (a-and-b k v k bv))
		   (table-insert! union k #t))
		 (begin
		   (if a-only
		       (a-only k v)))))))
	(table-for-each
	 b
	 (lambda (h k v)
	   (if (not (table-lookup union k))
	       (begin
		 (if b-only
		     (b-only k v)))))))))
