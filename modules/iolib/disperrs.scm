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
 | Owned by module:  iolib
 |
 | Purpose:          rendition functions for <condition>'s
 |------------------------------------------------------------------------|
 | Notes:
 |      These rendition functions are for <condition>'s defined
 |      in earlier modules
 `------------------------------------------------------------------------|#

(define-method display-object ((self <excess-initializers>) port)
  (format port "excess initializers supplied to `make' of a ~s\n"
	  (class-name (object-class (object self))))
  (let loop ((x (excess self)))
    (if (pair? x)
	(if (pair? (cdr x))
	    (begin
	      (format port "    ~s ~#*@55s\n" (car x) (cadr x))
	      (loop (cddr x)))
	    (format port "   ~s (value missing)\n" (car x)))
	(values))))
