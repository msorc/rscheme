#|------------------------------------------------------------*-Scheme-*--|
 | File:	    %p%
 |
 |          Copyright (C)1998 Donovan Kolbly <d.kolbly@rscheme.org>
 |          as part of the RScheme project, licensed for free use.
 |	    See <http://www.rscheme.org/> for the latest info.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 | Owned by module:  highscm
 |
 | Purpose:          Provide generic support for sequences of hook thunks
 `------------------------------------------------------------------------|#

(define-macro (define-hook name)
  (let ((var (symbol-append "*" name "-hook*"))
	(adder (symbol-append "add-" name "-hook!"))
	(remover (symbol-append "remove-" name "-hook!")))
    `(begin
       (define ,var '#())
       (define (,adder thunk . opt)
	 (if (and (pair? opt) (car opt)) ;; append mode?
	     (set! ,var (vector-append ,var (vector thunk)))
	     (set! ,var (vector-append (vector thunk) ,var))))
       (define (,remover thunk)
	 (set! ,var (delq thunk ,var))))))

(define (run-hooks vec)
  (vector-for-each 
   (lambda (thunk)
     (thunk))
   vec))

;;;
;;;  define a hook for use when a system image 
;;;  is about to be saved
;;;

(define-hook image-save)
