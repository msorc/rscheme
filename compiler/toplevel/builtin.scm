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

(define (builtin-modules)
  (list (cons '*scheme*
	      (let* ((envt (make-top-level-contour)))
		(for-each (lambda (bdg)
			    (table-insert! (table envt)
					   (name bdg)
					   bdg))
			  (append 
			   (make-special-forms)
			   (make-top-level-forms)
			   (make-objsys-forms)))
		(make <module>
		      name: '*scheme*
		      top-level-envt: envt
		      module-exports: (table envt))))))

