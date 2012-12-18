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
 | Purpose:          equality predicates (generic functions)
 `------------------------------------------------------------------------|#

;;
;; these predicates are available...
;;
;; the default behavior (defined in objsys/object.scm) is
;; that of eq?, but they are specialized later (in highscm/equiv?)

(define-generic-function equal?)
(define-generic-function eqv?)
