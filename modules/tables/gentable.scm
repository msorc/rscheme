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
 | Purpose:          generic hash tables -- any hash & key functions
 `------------------------------------------------------------------------|#

(define-class <generic-table> (<hash-table>)
  (table-hash-function type: <function>)
  (table-equal-function type: <function>))

(define-method table-key-present? ((self <generic-table>) key)
  (let (((hash <fixnum>) ((table-hash-function self) key)))
    (generic-hash-table-probe? self hash key)))

(define-method table-lookup ((self <generic-table>) key)
  (let (((hash <fixnum>) ((table-hash-function self) key)))
    (generic-hash-table-lookup self hash key)))

(define-method table-remove! ((self <generic-table>) key)
  (let (((hash <fixnum>) ((table-hash-function self) key)))
    (generic-hash-table-remove! self hash key)))

(define-method table-insert! ((self <generic-table>) key value)
  (let (((hash <fixnum>) ((table-hash-function self) key)))
    (generic-hash-table-insert! self hash key value)))
