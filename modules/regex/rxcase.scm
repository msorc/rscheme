#|------------------------------------------------------------*-Scheme-*--|
 | File:    %p%
 |
 |          Copyright (C) 2003 Joerg F. Wittenberger <joerg.wittenberger@pobox.com>
 |          as part of the RScheme project, licensed for free use.
 |          See <http://www.rscheme.org/> for the latest information.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 | Owned by module:  regex
 |
 | Purpose:          Provide nice interface to reg-expr->proc
 +--------------------------------------------------------------------------
 | ,(use regex)
 | (define rxa (reg-exp->proc "a"))
 | (define rxb (reg-exp->proc "b"))
 | (reg-expr-case "sowas" (rxa a a) (else #f))
 | => ((3 . 4))
 | (reg-expr-case "sowas" (rxb a a) (else #f))
 | => #f
 `------------------------------------------------------------------------|#

(define-macro (reg-expr-case str . clauses)
  (let ((tmp (gensym)))
    `(let ((,tmp ,str))
       ,(let fold ((clauses clauses))
	    (if (null? clauses)
		      '(no-values)
		            (let ((args (gensym))
                    (start (gensym))
                    (end (gensym))
                    (rest (gensym))
		        (c (car clauses)) )
			      (if (eq? 'else (car c))
				      `(let () ,@(cdr c))
				          `(call-with-values
                      (lambda () (,(car c) ,tmp))
                      (lambda ,args
                        (let ((,start (and (pair? ,args) (car ,args)))
                              (,end (and (pair? ,args) (cadr ,args)))
                              (,rest (and (pair? ,args) (cddr ,args)))) 
                          (if ,start
                              (apply (lambda ,(cadr c) ,@(cddr c))
                                     (cons ,start ,end) ,rest)
                              ,(fold (cdr clauses)))))))))))))
