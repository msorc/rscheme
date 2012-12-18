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


;;
;; these are the `special' primops, which are emitted specially
;; during code generation
;;

(define-primop (%make <<class>> . <obj>) => <obj>
  (bytecode 'make)
  (ccode make))

(define-primop (cons <obj> <obj>) => <pair>
  (bytecode 'cons)
  (ccode "cons"))

(define-primop (car <obj>) => <obj>
  (bytecode 'car)
  (ccode "checked_car"))

(define-primop (cdr <obj>) => <obj>
  (bytecode 'cdr)
  (ccode "checked_cdr"))
