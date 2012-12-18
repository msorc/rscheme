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
 | Purpose:          Implement local module scopes
 `------------------------------------------------------------------------|#

(define-class <with-envt> (<scope-record>)
  table
  lexical-enclosing
  dynamic-enclosing)

(define-method lookup ((self <with-envt>) (name <symbol>))
  (or (table-lookup (table self) name)
      (lookup (lexical-enclosing self) name)))

(define (compile/with-module sf form lxe dye mode)
  (let ((e (make <with-envt>
                 table: (module-exports (get-module (cadr form)))
                 lexical-enclosing: lxe
                 dynamic-enclosing: dye)))
    (compile/body (cddr form) e e mode)))
