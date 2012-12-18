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
 | Owned by module:  paths
 |
 | Purpose:          pathname class definitions
 `------------------------------------------------------------------------|#

(define-class <file-name> (<object>)
    file-directory
    filename
    extension)

(define-class <directory-name> (<object>)
    rooted-at
    steps)

(define-class <root-dir> (<object>)
    root-name
    expanded-name)

(define (root-dir? x)
    (instance? x <root-dir>))

(define-generic-function pathname->string)
