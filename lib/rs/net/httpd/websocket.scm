
;;; Check to see if a request is a websocket upgrade request

(define (websocket-protocol-upgrade? h)
  (dm 950 "websocket? ~s" h)
  (let ((up (assq 'upgrade h)))
    (and up (string=? (cdr up) "websocket"))))

;;; process a websocket

(define-class <websocket-close> (<condition>))
  
(define-class <websocket-connection> (<object>)
  (properties   type: <vector>          init-value: '#())
  (space type: <web-space>)
  (origin type: <http-connection>)
  headers
  input-port
  output-port
  (reassembly-opcode init-value: #f)
  (reassembly-buffer init-value: '()))

;; I can't seem to find one of these already...

(define (assoc-list->vector alist)
  (let (((v <vector>) (make-vector (* 2 (length alist)))))
    (let loop ((i 0)
               (l alist))
      (if (pair? l)
          (begin
            (vector-set! v i (caar l))
            (vector-set! v (add1 i) (cdar l))
            (loop (+ i 2) (cdr l)))
          (if (= i (vector-length v))
              v
              (error "malformed assoc-list"))))))

(define (websocket-connection-upgrade c space h)
  (let* ((version (string->number (cdr (assq 'sec-websocket-version h)))))
    ;; we only support version 13
    (if (not (= version 13))
        (httpd-bail 500 "Unsupported WebSocket version"))
    (let ((key (cdr (assq 'sec-websocket-key h)))
          (protocol (assq 'sec-websocket-protocol h))
          (ws-server (get-property space 'websocket-server #f)))
      (if (not ws-server)
          (httpd-bail 500 "WebSocket not supported in this space"))
      ;; the server hook should return #f or an alist of properties
      (let ((props (ws-server h)))
        (if (not props)
            (httpd-bail 500 "Not willing to accept connection"))
        ;; generate the response
        (let* ((ack (string->base64
                     (sha1-binary-digest
                      (string-append key *WEBSOCKET-MAGIC*))))
               (sock (underlying-http-socket c))
               (cnx (make <websocket-connection>
                      properties: (assoc-list->vector props)
                      origin: c
                      space: space
                      headers: h
                      input-port: (input-port sock)
                      output-port: (output-port sock))))
          ;;
          (write-string (output-port cnx)
                        (string-append
                         "HTTP/1.1 101 Switching Protocols\r\n"
                         "Upgrade: websocket\r\n"
                         "Connection: Upgrade\r\n"
                         "Sec-WebSocket-Accept: "
                         ack
                         "\r\n"
                         (if (get-property cnx 'protocol #f)
                             (string-append "Sec-WebSocket-Protocol: "
                                            (get-property cnx 'protocol)
                                            "\r\n")
                             "")
                         "\r\n"))
          (flush-output-port (output-port cnx))
          ;;
          (websocket-connection-loop cnx))))))


(define *WEBSOCKET-MAGIC* "258EAFA5-E914-47DA-95CA-C5AB0DC85B11")
        
(define (websocket-process-frame (cnx <websocket-connection>) 
                                 (fin? <boolean>)
                                 (opcode <fixnum>)
                                 (payload <string>))
  (case opcode
    ((0)
     (let ((b (reassembly-buffer cnx)))
       (if (not (pair? b))
           (error "websocket error; expected opcode=0 while reassembling")
           ;; push this payload onto the reassembly stack
           (let ((b (cons payload b)))
             (if fin?
                 (let ((op (reassembly-opcode cnx)))
                   (dm 951 "complete message received, ~d frames" (length b))
                   (set-reassembly-buffer! cnx '())
                   (set-reassembly-opcode! cnx #f)
                   (websocket-process-data cnx
                                           op
                                           (string-join "" (reverse! b)))))))))
    ((1 2)
     (dm 981 "Received DATA")
     (assert (null? (reassembly-buffer cnx)))
     (if fin?
         ;; it's the one-and-only frame
         (websocket-process-data cnx opcode payload)
         ;; otherwise, start reassembly
         (begin
           (set-reassembly-buffer! cnx (cons payload '()))
           (set-reassembly-opcode! cnx opcode))))
    ((8)
     ;; CLOSE control message
     (dm 988 "Received CLOSE")
     (websocket-send/close cnx)
     (signal (make <websocket-close>)))
    ((9)
     ;; PING
     (dm 989 "Received PING")
     (websocket-send/pong cnx payload))
    ((10)
     ;; PONG
     (dm 989 "Received PONG"))
    (else
     (websocket-send/close cnx 1003)
     (signal (make <websocket-close>)))))

(define (websocket-process-data cnx op msg)
  (websocket-send/text cnx "Hi Lane :-)"))

(define (websocket-read-payload-length inp b1)
  (let* ((l0 (bitwise-and b1 #x7F)))
    (cond
     ((< l0 126)
      l0)
     ((= l0 126)
      (bvec-read-unsigned-16 (read-string inp 2) 0))
     ((= l0 127)
      (let* ((l (read-string inp 8))
             (hi (bvec-read-signed-32 l 0))
             (lo (bvec-read-signed-32 l 4)))
        (if (or (not (= hi 0))
                (< lo 65536) 
                (> lo 100000000))
            (error "8-byte websocket length too big: ~s ~s" hi lo)
            lo))))))
  
(define (websocket-read-frame (cnx <websocket-connection>))
  (let* ((inp (input-port cnx))
         (header (read-string inp 2)))
    (format #t "==> ~s\n" header)
    (if (eof-object? header)
        (values)
        (let ((b0 (bvec-ref header 0))
              (b1 (bvec-ref header 1)))
          (format #t "0x~02x FIN=~d RSV1=~d RSV2=~d RSV3=~d OP=~d\n"
                  b0
                  (if (eq? 0 (bitwise-and b0 #x80)) 0 1)
                  (if (eq? 0 (bitwise-and b0 #x40)) 0 1)
                  (if (eq? 0 (bitwise-and b0 #x20)) 0 1)
                  (if (eq? 0 (bitwise-and b0 #x10)) 0 1)
                  (bitwise-and b0 #x0f))
          (format #t "0x~02x MASK=~d LEN=~d\n"
                  b1
                  (if (eq? 0 (bitwise-and b1 #x80)) 0 1)
                  (bitwise-and b1 #x7F))
          (let* ((payload-length (websocket-read-payload-length inp b1))
                 ;; read the payload data and mask key [TODO, if any]
                 ;; Pull out the masking key
                 (mask (if (eq? 0 (bitwise-and b1 #x80))
                           "\0\0\0\0"
                           (read-string inp 4)))
                 (buf (read-string inp payload-length)))
            (let ((data (unmask-payload buf payload-length mask)))
              (format #t "UNMASKED DATA=~s\n" data)
              (values (bitwise-and b0 #x0f)
                      (not (eq? 0 (bitwise-and b0 #x80)))
                      data)))))))

(define (websocket-connection-loop (cnx <websocket-connection>))
  (handler-case
   (let ((inp (input-port cnx)))
     (set-reassembly-buffer! cnx '())
     (let loop ((j 0))
       (format #t "Waiting for ~d\n" j)
       (bind ((op fin? data (websocket-read-frame cnx)))
             (if op
                 (begin
                   (websocket-process-frame cnx fin? op data)
                   (loop (+ j 1)))))))
   ((<websocket-close>)
    (dm 953 "close"))))


(define (websocket-send/text (cnx <websocket-connection>) buf)
  (websocket-send* cnx buf 1))

(define (websocket-send/pong (cnx <websocket-connection>) msg)
  (websocket-send* cnx msg 10))

(define (websocket-send/close (cnx <websocket-connection>) #optional code)
  (websocket-send* cnx
                   (if code
                       (let ((m (make-string 2)))
                         (bvec-write-unsigned-16 m 0 code)
                         m)
                       "")
                   8))

(define (websocket-send* (cnx <websocket-connection>) buf op)
  (let ((hdr (bvec-alloc <string> 3)))
    (bvec-set! hdr 0 (+ #x80 op))
    (bvec-set! hdr 1 (string-length buf))
    (let ((out (output-port cnx)))
      (write-string out hdr)
      (write-string out buf)
      (flush-output-port out))))


(define (unmask-payload (buf <string>) len (mask <string>))
  (let ((unm (bvec-alloc <string> (+ len 1))))
    (bvec-set! unm len 0)
    (let loop (((i <fixnum>) 0))
      (if (eq? i len)
          unm
          (begin
            (bvec-set! unm
                       i
                       (bitwise-xor (bvec-ref buf i)
                                    (bvec-ref mask (bitwise-and i 3))))
            (loop (add1 i)))))))


