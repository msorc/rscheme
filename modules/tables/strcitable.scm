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
 | Purpose:          string (case insensitive) table
 `------------------------------------------------------------------------|#

(define-class <string-ci-table> (<hash-table>))

(define-method table-key-present? ((self <string-ci-table>) (key <string>))
  (string-ci-table-probe? self (string-ci->hash key) key))

(define-method table-lookup ((self <string-ci-table>) (key <string>))
  (string-ci-table-lookup self (string-ci->hash key) key))

(define-method table-remove! ((self <string-ci-table>) (key <string>))
  (string-ci-table-remove! self (string-ci->hash key) key))

(define-method table-insert! ((self <string-ci-table>) (key <string>) value)
  (string-ci-table-insert! self (string-ci->hash key) key value))

;; introspection

(define-method table-hash-function ((self <string-ci-table>))
  string-ci->hash)
    
(define-method table-equal-function ((self <string-ci-table>))
  string-ci=?)

(define (get-system-symbol-table)
  (rscheme-global-ref 2))
