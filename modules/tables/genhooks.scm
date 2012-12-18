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
 | Purpose:          generic-table hooks
 `------------------------------------------------------------------------|#

(define generic-hash-table-lookup
  (well-known-function
   code: ("RScheme" 9502 0)))

(define generic-hash-table-remove!
  (well-known-function
   code: ("RScheme" 9502 1)))

(define generic-hash-table-insert!
  (well-known-function
   code: ("RScheme" 9502 2)))

(define generic-hash-table-probe?
  (well-known-function
   code: ("RScheme" 9502 3)))
