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
 | Purpose:          symbol-table (ie, hash table with symbol keys) implementation
 `------------------------------------------------------------------------|#

(define-class <symbol-table> (<hash-table>))

(define-method table-key-present? ((self <symbol-table>) (key <symbol>))
  (object-table-probe? self (symbol->hash key) key))

(define-method table-lookup ((self <symbol-table>) (key <symbol>))
  (object-table-lookup self (symbol->hash key) key))

(define-method table-remove! ((self <symbol-table>) (key <symbol>))
  (object-table-remove! self (symbol->hash key) key))

(define-method table-insert! ((self <symbol-table>) (key <symbol>) value)
  (object-table-insert! self (symbol->hash key) key value))

;; introspection

(define-method table-hash-function ((self <symbol-table>))
  symbol->hash)
    
(define-method table-equal-function ((self <symbol-table>))
  eq?)
