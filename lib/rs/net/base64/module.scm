(define-module rs.net.base64 ()
  (&module 
   (import usual-inlines)
   (load "rfc-1421.scm")
   (load "base64.scm")
   (export base64->string
           string->base64)))
