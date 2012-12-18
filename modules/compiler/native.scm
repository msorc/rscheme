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
 | Owned by module:  compiler
 |
 `------------------------------------------------------------------------|#

;;;
;;;  this file has definitions appropriate for compiling "natively"
;;;  that is, it provides definitions that the cross-compiler provides
;;;  in compiler/target.scm
;;;

(define-constant <<target-class>> <<standard-class>>)

(define-constant <target-getter> <getter>)
(define-constant <target-setter> <setter>)

(define-constant <target-closure> <closure>)
(define-constant <target-gf1> <single-dispatch-gf>)
(define-constant <target-function> <function>)
(define-constant <target-method> <method>)

(define-syntax (target-class? x)
  (class? x))
