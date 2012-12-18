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


(define (object->string o)
  (call-with-output-string
   (lambda (p)
     (write o p))))

(define-fluid *source-dir*)
(define-fluid *strategy*)
(define-fluid *code-descriptors*)

(define *package-mode* #f)

(define (mkdir p)
  (close-output-port (open-output-process (string-append "mkdir " p))))

(define (path=? a b)
  (string=? (pathname->string a) (pathname->string b)))

(define (ic-const? ic)
  (instance? ic <ic-const>))

(define (c-text? x)
  (instance? x <curly-braced>))

(define (c-text->string (x <curly-braced>))
  (text x))
