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
 | Purpose:          miscellaneous functions
 `------------------------------------------------------------------------|#

(define-method key-sequence ((self <hash-table>))
  (table-keys->list self))

(define-method value-sequence ((self <hash-table>))
  (table-values->list self))

(define (table-replace! table key proc new-value)
    (let* ((old-value (table-lookup table key))
    	   (new-value (proc old-value new-value)))
	(if (not (eq? old-value new-value))
	    (table-insert! table key new-value))
	new-value))
