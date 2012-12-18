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

(define (idle)
  (let loop ((i 0))
    ;;
    (if (eq? (cdr *ready-queue*) *ready-queue*)
	(sleep-process-until-thread-awakens)
	(thread-yield))
    (loop (+ i 1))))

