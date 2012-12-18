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

(check #t (> (expt 2 30) 100))
(check #t (> (expt 2.0 30) 100))
(check #t (> (expt 2 30.0) 100))
(check #t (> (expt 2.0 30.0) 100))

(check 1024 (expt 2 10))
(check 1024.0 (expt 2 10.0))
