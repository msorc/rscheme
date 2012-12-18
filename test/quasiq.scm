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

(define-syntax (expect proc a b)
  (format #t "> ~s\n" (mquote b))
  (assert (proc a b)))

(define x '(1 2 3))
(define z '(p . q))

(check '(1 2 3) `(1 2 3))

(check 	'(1 2 3) `,x)

(check '(x (1 2 3)) `(x ,x))

(check 	'(x (1 2 3) y) `(x ,x y))

(check '(x 1 2 3) `(x ,@x))
(check '(x 1 2 3 y) `(x ,@x y))

(check '#(x (1 2 3) y) `#(x ,x y))
(check '#(x 1 2 3 y) `#(x ,@x y))
(check '#(x 1 2 3 (1 2 3) y) `#(x ,@x ,x y))
(check '#(x (1 2 3) 1 2 3 y) `#(x ,x ,@x y))
(check '#(x (p 1 2 3 q) y) `#(x (p ,@x q) y))
(check '#(x (p 1 2 3) y) `#(x (p ,@x) y))
(check '#(x (1 2 3 q) y) `#(x (,@x q) y))

(check '((1 2 3) (1 2 3)) `(,x ,x))
(check '(1 2 3 1 2 3) `(,@x ,@x))
(check '(1 2 3 p . q) `(,@x ,@z))
