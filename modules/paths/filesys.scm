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
 | Purpose:          User-level interface to the file system
 |------------------------------------------------------------------------|
 | Notes:
 |      These functions take <*-name> arguments and translate them
 |      for use by the underlying OS
 `------------------------------------------------------------------------|#

(define (file-exists? file)
  (os-file-exists? (relative-file file)))

(define (chdir path)
  (os-setwd! path)
  ;; flush the "getwd" cache
  (set! *process-dir* #f)
  path)

(define (within-directory (dir <directory-name>) thunk)
  (thread-let ((*current-dir* (append-dirs (current-directory) dir)))
    (thunk)))




