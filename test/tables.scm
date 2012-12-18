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


,(use tables)

(define-class <point> (<object>)
  (x type: <fixnum>)
  (y type: <fixnum>))

(define (point->hash (self <point>))
  (bitwise-xor (integer->hash (x self))
	       (integer->hash (y self))))

(define (point=? (a <point>) (b <point>))
  (and (eq? (x a) (x b))
       (eq? (y a) (y b))))

(define-method equal? ((a <point>) b)
  (and (instance? b <point>)
       (eq? (x a) (x b))
       (eq? (y a) (y b))))
      
(define *point-table* (make-table point=? point->hash))

(define (pt x y)
  (make <point>
	x: x
	y: y))

(table-insert! *point-table* (pt 0 0) 'origin)
(table-insert! *point-table* (pt 1 0) 'x-unit)
(table-insert! *point-table* (pt 0 1) 'y-unit)

(define-method write-object ((self <point>) port)
  (format port "#[~d,~d]" (x self) (y self)))

(test-section
 (generic-table)
 (check 3 (table-size *point-table*))
 (check 'x-unit (table-lookup *point-table* (pt 1 0)))
 (check 'y-unit (table-lookup *point-table* (pt 0 1)))
 (check 'origin (table-lookup *point-table* (pt 0 0))))


 