;;;
;;;     A JSON parser and printer for RScheme
;;;
;;;     Copyright (C) 2012 Donovan Kolbly

(define-module rs.net.json ()
  (&module
   (import usual-inlines)
   (load "reader.scm")
   (load "writer.scm")
   ;;
   (export read-json
           write-json)))
