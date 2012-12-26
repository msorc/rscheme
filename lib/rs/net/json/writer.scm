
(define (write-json object #optional port)
  (json-write-object object (or port (current-output-port))))

(define-method json-write-object ((self <number>) port)
  (write-object self port))

(define-method json-write-object ((self <string>) port)
  (output-port-write-char port #\")
  (let loop ((i 0))
    (if (< i (string-length self))
        (let* ((ch (string-ref self i))
               (k (char->integer ch)))
          (if (or (< k 32) (>= k 127) (eq? ch #\\) (eq? ch #\"))
              (let ((a (assq ch '((#\nl . #\n)
                                  (#\ff . #\f)
                                  (#\bs . #\b)
                                  (#\cr . #\r)
                                  (#\tab . #\t)
                                  (#\" . #\")
                                  (#\\ . #\\)))))
                (output-port-write-char port #\\)
                (if a
                    (output-port-write-char port (cdr a))
                    (format port "u~04x" k)))
              (output-port-write-char port ch))
          (loop (+ i 1)))
        (output-port-write-char port #\"))))
          

(define-method json-write-object ((self <vector>) port)
  (output-port-write-char port #\[)
  (let loop ((i 0))
    (if (< i (vector-length self))
        (begin
          (if (> i 0)
              (output-port-write-char port #\,))
          (json-write-object (vector-ref self i) port)
          (loop (+ i 1)))
        (output-port-write-char port #\]))))

(define-method json-write-object ((self <list>) port)
  (output-port-write-char port #\{)
  (let loop ((l self)
             (succ? #f))
    (if (null? l)
        (output-port-write-char port #\})
        (begin
          (if succ?
              (output-port-write-char port #\,))
          (json-write-object (symbol->string (caar l)) port)
          (output-port-write-char port #\:)
          (json-write-object (cdar l) port)
          (loop (cdr l) #t)))))

