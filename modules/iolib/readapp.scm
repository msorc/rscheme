#|------------------------------------------------------------*-Scheme-*--|
 | File:    %p%
 |
 |          Copyright (C) 2003 Donovan Kolbly <donovan@rscheme.org>
 |          as part of the RScheme project, licensed for free use
 |
 | Version: %I%
 | Date:    %E% %U%
 | Build:   %b%
 |
 | Purpose: Provide primary functionality to support read-time application
 |          as described in SRFI-10
 |          (called from read.scm, when a <hash-comma-token> is found)
 |
 `------------------------------------------------------------------------|#

(define *read-time-constructors* (make-symbol-table))

;;;

(define (eval-hash-comma-datum form start-line)
  (let ((f (table-lookup *read-time-constructors* (car form))))
    (if f
        (apply f (cdr form))
        (read:error start-line "Unknown read-time ctor: ~s" form))))

;;;
;;;  This is how the user extends the set of applicators
;;;

(define (define-reader-ctor (head <symbol>) (proc <function>))
  (table-insert! *read-time-constructors* head proc))
