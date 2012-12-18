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
 | Owned by module:  (rsc)
 |
 `------------------------------------------------------------------------|#

(define (aml-stub . args)
  (error "aml-stub: used before filled in"))

(define emit-unbind aml-stub)
(define emit-jump aml-stub)
(define emit-bjump aml-stub)
(define emit-pop aml-stub)
(define emit-check= aml-stub)
(define emit-check>= aml-stub)
(define emit-collect> aml-stub)
(define emit-set-false< aml-stub)
(define emit-use-empty-envt aml-stub)
(define emit-use-function-envt aml-stub)
(define emit-branch-if-false aml-stub)
(define emit-bind-first-regs aml-stub)
(define emit-bind aml-stub)
(define emit-save aml-stub)
(define emit-restore aml-stub)
(define emit-return aml-stub)
(define emit-apply aml-stub)
(define emit-applyg aml-stub)
(define emit-reg-xfer aml-stub)
(define emit-reg-set aml-stub)
(define emit-lex-set aml-stub)
(define emit-tl-set aml-stub)
(define emit-literal aml-stub)
(define emit-closure aml-stub)
(define emit-this-function aml-stub)
(define emit-reg-ref aml-stub)
(define emit-lex-ref aml-stub)
(define emit-tl-ref aml-stub)
(define emit-immob aml-stub)
(define emit-raw-int aml-stub)
(define emit-raw-bool aml-stub)
(define emit-fixnum aml-stub)
(define emit-gvec-load aml-stub)
(define emit-gvec-store aml-stub)
(define emit-special-primop aml-stub)
