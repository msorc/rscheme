
(define (base64->string encoded)
  (PEM-decode-string encoded))

(define (string->base64 raw)
  (PEM-encode-string raw))

