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
 | Purpose:          object tables
 |------------------------------------------------------------------------|
 | Notes:
 |      the USER (application developer) is responsible for
 |      ONLY using object tables for real transient data
 `------------------------------------------------------------------------|#

(define-class <object-table> (<hash-table>))

(define-method table-key-present? ((self <object-table>) key)
  (object-table-probe? self (transient->hash key) key))

(define-method table-lookup ((self <object-table>) key)
  (object-table-lookup self (transient->hash key) key))

(define-method table-remove! ((self <object-table>) key)
  (object-table-remove! self (transient->hash key) key))

(define-method table-insert! ((self <object-table>) key value)
  (object-table-insert! self (transient->hash key) key value))

;; introspection

(define-method table-hash-function ((self <object-table>))
  transient->hash)

(define-method table-equal-function ((self <object-table>))
  eq?)

(define (make-object-table . args)
  (let ((weak-keys? #f)
	(weak-values? #f))
    (if (not (null? args))
	(begin
	  (set! weak-keys? (car args))
	  (set! args (cdr args))
	  (if (not (null? args))
	      (set! weak-values? (car args)))))
    (assert (not weak-keys?))    
    (assert (not weak-values?))
    (make <object-table>)))

