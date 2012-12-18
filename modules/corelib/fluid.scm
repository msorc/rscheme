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
 | Owned by module:  corelib
 |
 | Purpose:          Provide fluid variable binding support
 |------------------------------------------------------------------------|
 | Notes:
 |      Completely reimplemented, again
 `------------------------------------------------------------------------|#

(define-syntax fluid-ref 
  (syntax-form (v) v)
  (syntax-form (v alt) 
    (if (eq? v '#uninit)
	alt
	v)))

(define-rewriter (fluid-set! form)
  (cons 'set! (cdr form)))

(define-rewriter (define-fluid form)
  (list 'define 
	(cadr form)  
	(if (null? (cddr form))
	    ''#uninit
	    (caddr form))))

;;;

(define (fluid-letter vars value-vec thunk)
  (let ((ftlc (%make <fluid-tl-contour>
		     vars
		     value-vec
		     (clone value-vec))))
    (dynamic-call-thunk
     (lambda () (wind-fluid-tlv-contour ftlc))
     (lambda () (unwind-fluid-tlv-contour ftlc))
     thunk
     (cons ftlc (get-dynamic-state-reg))
     (get-thread-state-reg))))

;;;

(define-macro (fluid-let bdgs . body)
  (if (null? bdgs)
      `(begin ,@body)
      (let* ((tlv-seq (map (lambda (var)
			     (list '& var))
			   (map car bdgs)))
	     (init-value-seq (map cadr bdgs)))
	`(fluid-letter
	  (%make <vector> ,@tlv-seq)
	  (%make <vector> ,@init-value-seq)
	  (lambda () ,@body)))))


