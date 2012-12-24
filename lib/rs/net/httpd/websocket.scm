
;;; Check to see if a request is a websocket upgrade request

(define (websocket-protocol-upgrade? h)
  (dm 950 "websocket? ~s" h)
  (let ((up (assq 'upgrade h)))
    (and up (string=? (cdr up) "websocket"))))

;;; process a websocket

(define-class <websocket-connection> (<object>)
  (properties   type: <vector>          init-value: '#())
  (space type: <web-space>)
  (origin type: <http-connection>)
  headers
  input-port
  output-port)

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
        
  
(define (websocket-connection-loop (cnx <websocket-connection>))
  (let ((inp (input-port cnx)))
    (let loop ((j 0))
      (format #t "Waiting for ~d\n" j)
      (let ((header (read-string inp 2)))
        (format #t "==> ~s\n" header)
        (if (not (eof-object? header))
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
              (let* ((payload-length (bitwise-and b1 #x7F))
                     ;; TODO, eat the extended payload length
                     ;; read the payload data and mask key [TODO, if any]
                     (buf (read-string inp (+ 4 payload-length)))
                     ;; Pull out the masking key
                     (mask (if (eq? 0 (bitwise-and b1 #x80))
                               "\0\0\0\0"
                               (substring buf 0 4))))
                (format #t "MASK DATA=~s\n" mask)
                (let ((data (unmask-payload buf 4 payload-length mask)))
                  (format #t "UNMASKED DATA=~s\n" data)
                  (websocket-send cnx (~ "Hi Lane ~d!" j))
                  (loop (+ j 1))))))))))


(define (websocket-send (cnx <websocket-connection>) buf)
  (let ((hdr (bvec-alloc <string> 3)))
    (bvec-set! hdr 0 #x81)
    (bvec-set! hdr 1 (string-length buf))
    (let ((out (output-port cnx)))
      (write-string out hdr)
      (write-string out buf)
      (flush-output-port out))))


(define (unmask-payload (buf <string>) (offset <fixnum>) len (mask <string>))
  (let ((unm (bvec-alloc <string> (+ len 1))))
    (bvec-set! unm len 0)
    (let loop (((i <fixnum>) 0))
      (if (eq? i len)
          unm
          (begin
            (bvec-set! unm
                       i
                       (bitwise-xor (bvec-ref buf (fixnum+ offset i))
                                    (bvec-ref mask (bitwise-and i 3))))
            (loop (add1 i)))))))


