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
 | Owned by module:  high-scheme
 |
 | Purpose:          high-level profiling functions
 `------------------------------------------------------------------------|#

(define (call-with-profiling (path <string>) thunk)
  (%profile-start path #f #t)
  (bind ((#rest r (thunk)))
    (done-with-profiling path)
    (list->values r)))

(define (done-with-profiling path)
  (%profile-stop)
  ;;
  (let ((tbl (make-object-table)))
    (%profile-objects path tbl)
    (%profile-start path #t #t)
    (table-for-each
     tbl
     (lambda (h k v)
       (%profile-append-defn 
	k
	(let ((nm (name k)))
	 (if (symbol? nm)
	     (symbol->string nm)
	     nm)))
       (values)))
    (%profile-stop)))

