(define-fluid *interaction* #f)

(define-class <interaction> (<object>)
  unique-id
  frontend
  resumer
  continuation)

(define *pending* (make-symbol-table))

(define (handle-prompt-response json)
  (let* ((k (string->symbol (cdr (assq 'id json))))
         (i (table-lookup *pending* k))
         (v (cdr (assq 'value json))))
    (table-remove! *pending* k)
    (call-with-current-continuation
     (lambda (cc)
       (set-resumer! i cc)
       ((continuation i) v)))))
  

(define (prompt type msg)
  (let ((i *interaction*))
    (let ((value (call-with-current-continuation
                  (lambda (cc)
                    (set-continuation! i cc)
                    (let ((id (gensym)))
                      (send-message-to-front-end 
                       (frontend i)
                       (list '(action . "prompt")
                             (cons 'message msg)
                             (cons 'id (symbol->string id))
                             (cons 'type (symbol->string type))))
                      (table-insert! *pending* id i)
                      ((resumer i)))))))
      (case type
        ((point)
         (make-point (cdr (assq 'x value)) (cdr (assq 'y value))))
        (else
         value)))))

(define (run-interactive name thunk)
  (call-with-current-continuation
   (lambda (cc)
     (let ((f *frontend*)
           (i (make <interaction>
                unique-id: (gensym)
                frontend: *frontend*
                resumer: cc
                continuation: #f)))
       ;;
       (send-message-to-front-end 
        f
        `((action . "start-wizard")
          (id . ,(symbol->string (unique-id i)))
          (name . ,name)))
       ;;
       ;; push this interaction on the front of the interaction stack
       (set-interactions! f (cons i (interactions f)))
       (let ((elab (fluid-let ((*interaction* i))
                     (thunk))))
         (send-message-to-front-end
          f
          `((action . "end-wizard")
            (id . ,(symbol->string (unique-id i)))))
         (elab))))))
