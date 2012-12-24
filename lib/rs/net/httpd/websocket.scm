
;;; Check to see if a request is a websocket upgrade request

(define (websocket-protocol-upgrade? h)
  (dm 950 "websocket? ~s" h)
  (let ((up (assq 'upgrade h)))
    (and up (string=? (cdr up) "websocket"))))

;;; process a websocket

(define (websocket-connection-loop c space h)
  (let* ((key (cdr (assq 'sec-websocket-key h)))
         ;(protocol (cdr (assq 'sec-websocket-protocol h)))
         (version (cdr (assq 'sec-websocket-version h)))
         (p (open-input-process (~ "websocket-accept ~a" key)))
         (ack (read-line (open-input-process (~ "websocket-accept ~a" key))))
         (sock (underlying-http-socket c))
         (inp (input-port sock))
         (out (output-port sock)))
    ;;
    (write-string out "HTTP/1.1 101 Switching Protocols\r\n")
    (write-string out "Upgrade: websocket\r\n")
    (write-string out "Connection: Upgrade\r\n")
    (write-string out "Sec-WebSocket-Accept: ")
    (write-string out ack)
    (write-string out "\r\n")
    ;(write-string out "Sec-WebSocket-Protocol: ")
    ;(write-string out protocol)
    (write-string out "\r\n")
    (flush-output-port out)
    ;;
    (let loop ((j 0))
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
                  (websocket-send out (~ "Hi Lane ~d!" j))
                  (loop (+ j 1))))))))))


(define (websocket-send out buf)
  (let ((hdr (bvec-alloc <string> 3)))
    (bvec-set! hdr 0 #x81)
    (bvec-set! hdr 1 (string-length buf))
    (write-string out hdr)
    (write-string out buf)
    (flush-output-port out)))


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


