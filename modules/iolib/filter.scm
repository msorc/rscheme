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
 | Purpose:          provide output-port filters
 `------------------------------------------------------------------------|#

(define-class <output-filter> (<output-port>)
  filter-proc
  destination-port)

(define-method output-port-write-char ((self <output-filter>) ch)
  (let ((f ((filter-proc self) (string ch)))
	(n (destination-port self)))
    (if (char? f)
	(output-port-write-char n f)
	(if (string? f)
	    (write-string n f)
	    (error "filter port: filter proc returned invalid ~s" f)))))

(define-method write-string ((self <output-filter>) str)
   (let ((f ((filter-proc self) str))
	(n (destination-port self)))
    (if (char? f)
	(output-port-write-char n f)
	(if (string? f)
	    (write-string n f)
	    (error "filter port: filter proc returned invalid ~s" f)))))
 
(define (make-output-filter port proc)
  (make <output-filter>
	filter-proc: proc
	destination-port: port))

