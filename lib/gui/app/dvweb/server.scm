,(use rs.sys.threads.manager 
      rs.net.httpd
      rs.net.console
      rs.net.json
      tables
      graphics.geometry)

#|
(define *config*
  '(config
    (console
     (listen "127.0.0.1:1078")
     (spaces
      (space (@ (id "www:dv.rscheme.org"))
             (source "webspace.xml")))
     (http
      (service
       (@ (name "dv.rscheme.org"))
       (port "8080")
       (uri "http://localhost:8080/")
       (space "www:dv.rscheme.org")
       (verbose))))))


(define *web-spaces* (make-string-table))
|#

(define *space* (make-web-space))
(define *root* (make-uri-directory))
(define *resources* (make-uri-directory))
(define *3rd-party* (make-uri-directory))
,(use rs.util.properties)

;; TODO, we should have a way of binding into the URI tree

(define-class <client-connection> (<object>)
  headers
  websocket
  (interactions init-value: '()))

(define (send-message-to-front-end (self <client-connection>) json)
  (let ((tmp (open-output-string)))
    (format #t "sending to front end: ~s\n" json)
    (write-json json tmp)
    (write-string (websocket self) (close-output-port tmp))))
  
(define (execute-message-from-front-end (self <client-connection>) json)
  (format #t "execute ~s\n" json)
  (case (string->symbol (cdr (assq 'action json)))
    ;;  invoke a command
    ((invoke-command)
     (let ((cmd-name (cdr (assq 'name json))))
       (format #t "Running command: ~s" cmd-name)
       (run-interactive cmd-name place-box/interaction)))
    ;; a response to a prompt
    ((prompt-response)
     (handle-prompt-response json))))

(define-thread-var *frontend* #f)

(define-method process-message ((self <client-connection>) ws msg)
  (let ((msg (payload msg)))
    (set-websocket! self ws)
    (format #t "message => ~s\n" msg)
    (if (and (> (string-length msg) 0)
             (char=? (string-ref msg 0) #\{))
        (let ((j (read-json (open-input-string msg))))
          (thread-let ((*frontend* self))
            (execute-message-from-front-end self j)))
        (write-string ws "Merry Christmas!"))))

(define (dvweb-accept h)
  (format #t "dvweb ==> ~s\n" h)
  (let ((c (make <client-connection>
             headers: h
             websocket: #f)))
    (list (cons 'message-receiver (lambda (ws msg)
                                    (process-message c ws msg))))))


(set-property! *space* 'websocket-server dvweb-accept)

(uri-link-add! *space* "" *root*)

;;(uri-link-add! *space* "" (make-uri-complete-script foo))
(uri-link-add! *root* "" (make-uri-disk-node "static/index.html"))
(uri-link-add! *root* "illus" (make-uri-disk-node "static/illus.html"))
(uri-link-add! *root* "wstest" (make-uri-disk-node "static/wstest.html"))

(uri-link-add! *root* "rsrc" *resources*)
(uri-link-add! *resources* "3p" *3rd-party*)

(uri-link-add! *3rd-party* "jquery.js" 
               (make-uri-disk-node "3rdparty/jquery-1.8.3.min.js"
                                   mime-type: "application/javascript"))
(uri-link-add! *3rd-party* "jquery.svg.js" 
               (make-uri-disk-node "3rdparty/u/jquery.svg.js"
                                   mime-type: "application/javascript"))
(uri-link-add! *3rd-party* "jquery.treeview.js" 
               (make-uri-disk-node "3rdparty/u/jquery.treeview.js"
                                   mime-type: "application/javascript"))
(uri-link-add! *3rd-party* "jquery.treeview.css" 
               (make-uri-disk-node "3rdparty/u/jquery.treeview.css"
                                   mime-type: "text/css"))
(uri-link-add! *3rd-party* "images" 
               (make-uri-disk-dir "3rdparty/u/images"))

(uri-link-add! *resources* "frontend.js"
               (make-uri-disk-node "rsrc/frontend.js"
                                   mime-type: "application/javascript"))
(uri-link-add! *resources* "websocket.js"
               (make-uri-disk-node "rsrc/websocket.js"
                                   mime-type: "application/javascript"))
(uri-link-add! *resources* "wizard.css"
               (make-uri-disk-node "rsrc/wizard.css"
                                   mime-type: "text/css"))
(uri-link-add! *resources* "wizard.js"
               (make-uri-disk-node "rsrc/wizard.js"
                                   mime-type: "application/javascript"))

(load "interaction.scm")
(load "scripts.scm")

(start-http-server (list (list "dvweb" 8112 *space* 'stdout 'verbose #t)))
