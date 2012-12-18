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

(test-section
 (scanner)
 ;;
 (check (integer->char 129) (read (open-input-string "#\\C-M-a")))
 (check (integer->char 129) (read (open-input-string "#\\c-m-a")))
 (check (integer->char 129) (read (open-input-string "#\\c-M-A")))
 (check (integer->char 129) (read (open-input-string "#\\c-m-A")))

 (check (integer->char 225) (read (open-input-string "#\\M-a")))
 (check (integer->char 1) (read (open-input-string "#\\C-a")))
 (check (integer->char 1) (read (open-input-string "#\\C-A"))))

