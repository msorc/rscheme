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
 | Purpose:          function to help check for correct syntax
 `------------------------------------------------------------------------|#

;;
;;  returns values as matched in the template
;;
;;  NOTE:  the car of the template is not matched -- it is taken
;;         to be the canonical name of the form
;;
;;  item ::= name
;;           (name :: category)

(define (usage-check form template envt)
  (let ((canonical-name (car template))
	(result '()))
    ;;
    (define (check-rec actual formal)
      ;(format #t "check-rec: ~s <==> ~s\n" actual formal)
      (if (list? formal)
	  (if (and (eq? (length formal) 3)
		   (eq? (cadr formal) '::))
	      (case (caddr formal)
		((<name>)
		 (if (symbol? actual)
		     (set! result (cons actual result))
		     (error/syntax* form
				    "expected a <name> for ~s, saw: ~s\nusage: ~s"
				    (car formal)
				    actual
				    template)))
		(else
		 (error/internal "unknown template category: ~s" formal)))
	      (if (list? actual)
		  (if (eq? (length formal) (length actual))
		      (for-each check-rec
				actual
				formal)
		      (error/syntax* 
		       form
		       "too ~a syntactic elements (~d expected, ~d given)\nfor ~s\nusage: ~s"
		       (if (< (length actual) (length formal))
			   "few"
			   "many")
		       (length formal)
		       (length actual)
		       formal
		       template))
		  (error/syntax*
		   form
		   "expecting a list of syntactic elements\nfor ~s\nusage: ~s"
		   formal
		   template)))
	  ;; match anything
	  (set! result (cons actual result))))
    ;;
    (check-rec (cdr form) (cdr template))
    ;;
    (list->values (reverse result))))
