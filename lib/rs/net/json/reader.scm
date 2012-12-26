
(define (scan-json/number port ch)
  ;; this is not an exact parser, but I think every
  ;; valid json number will be read
  (let loop ((l (list ch)))
    (let ((ch (input-port-peek-char port)))
      (if (memq ch '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9
                     #\. #\e #\E #\+ #\-))
          (loop (cons (input-port-read-char port) l))
          (string->number (list->string (reverse! l)))))))

;; weird... I can't find these functions either

(define (make-unicode-string (len <fixnum>))
  (let ((b (bvec-alloc <unicode-string> (mul2 (add1 len)))))
    (bvec-write-unsigned-16 b len 0)
    b))

(define (all-ascii? chars)
  (let loop ((l chars))
    (if (null? l)
        #t
        (if (< (char->integer (car l)) 128)
            (loop (cdr l))
            #f))))

(define (list->string-generic chars)
  (if (all-ascii? chars)
      (list->string chars)
      (list->unicode-string chars)))

(define (list->unicode-string chars)
  (let ((s (make-unicode-string (length chars))))
    (let loop ((i 0)
               (l chars))
      (if (null? l)
          s
          (begin
            (unicode-string-set! s i (car l))
            (loop (+ i 1) (cdr l)))))))

(define (scan-json/string port)
  (let loop ((l '()))
    (let ((ch (input-port-read-char port)))
      (case ch
        ((#\")
         (list->string (reverse! l)))
        ((#\\)
         (let ((ch (input-port-read-char port)))
           (case ch
             ((#\") (loop (cons #\" l)))
             ((#\\) (loop (cons #\\ l)))
             ((#\/) (loop (cons #\/ l)))
             ((#\b) (loop (cons #\bs l)))
             ((#\f) (loop (cons #\ff l)))
             ((#\n) (loop (cons #\nl l)))
             ((#\r) (loop (cons #\cr l)))
             ((#\t) (loop (cons #\tab l)))
             ((#\u) 
              (let* ((x1 (input-port-read-char port))
                     (x2 (input-port-read-char port))
                     (x3 (input-port-read-char port))
                     (x4 (input-port-read-char port)))
                (loop (cons (integer->char (string->number 
                                            (string x1 x2 x3 x4)
                                            16))
                            l))))
             (else
              (error "JSON: bad string escape ~s" ch)))))
        (else
         (loop (cons ch l)))))))
  
(define (scan-json port)
  (let ((ch (input-port-read-char port)))
    (case ch
      ((#\{) 'start-object)
      ((#\}) 'end-object)
      ((#\[) 'start-array)
      ((#\]) 'end-array)
      ((#\:) 'colon)
      ((#\,) 'comma)
      ((#\") (scan-json/string port))
      ((#\- #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)
       (scan-json/number port ch))
      ((#\space #\tab #\cr #\lf) (scan-json port))
      (else
       (if (eof-object? ch)
           ch
           (error "invalid json character: ~s" ch))))))

(define (read-json* port token)
  (case token
    ((start-object)
     (read-json/object port))
    ((start-array)
     (read-json/array port))
    (else
     (if (symbol? token)
         (error "JSON: expected VALUE found token ~s" token)
         token))))

(define (read-json #optional port)
  (read-json* (or port (current-input-port))
              (scan-json port)))

(define (read-json/array port)
  (letrec ((initial (lambda ()
                      (let ((t (scan-json port)))
                        (if (eq? t 'end-array)
                            '#()
                            (let ((v (read-json* port t)))
                              (succ (list v)))))))
           (succ (lambda (l)
                   (let ((t (scan-json port)))
                     (if (eq? t 'end-array)
                         (list->vector (reverse! l))
                         (succ (cons (read-json port) l)))))))
    (initial)))
                        
                        
(define (read-json/object port)
  (letrec ((initial (lambda ()
                      (let ((k (scan-json port)))
                        (if (eq? k 'end-object)
                            '()
                            (if (string? k)
                                (postkey '() k)
                                (error "JSON: expected STRING or CLOSE-BRACE"))))))
           (postkey (lambda (alist k)
                      (let ((t (scan-json port)))
                        (if (eq? t 'colon)
                            (ex-value alist k)
                            (error "JSON: expected COLON, got ~s" t)))))
           (ex-value (lambda (alist k)
                       (let ((o (read-json port)))
                         (if (eof-object? o)
                             (error "JSON: EOF while reading object VALUE")
                             (inter (cons (cons (string->symbol k) o) 
                                          alist))))))
           (inter (lambda (alist)
                    (let ((t (scan-json port)))
                      (if (eq? t 'end-object)
                          (reverse! alist)
                          (if (eq? t 'comma)
                              (let ((k (scan-json port)))
                                (if (string? k)
                                    (postkey alist k)
                                    (error "JSON didn't get STRING after COMMA")))
                              (error "JSON: didn't get COMMA or CLOSE-BRACE")))))))
    (initial)))

                                    
                

      
