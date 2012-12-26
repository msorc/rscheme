,(use graphics.geometry)

;;; The job of an "interaction" is to prompt
;;; for the various parts of the constructor,
;;; and finally to return a thunk which, when
;;; executed, will produce the appropriate object.
;;;
;;; The framework will "end" the wizard when
;;; the interaction returns.  Note that calls
;;; to (prompt ...) will suspend execution of this
;;; call chain until the client responds, perhaps
;;; never resuming if the client disconnects or
;;; cancels the operation

(define (place-box/interaction)
  (let* ((a (prompt 'point "Select first corner"))
         (b (prompt 'point "Select second corner")))
    (lambda () (place-box a b))))

;;; Actually place the box

(define (place-box a b)
  ;;
  (let ((r (make-rect2 a (point- b a))))
    (format #t "place-box ~s\n" r)
    (send-message-to-front-end 
     *frontend*
     `((action . "extend-display-list")
       (args . #(,(origin-x r)
                 ,(origin-y r)
                 ,(size-width r)
                 ,(size-height r)
                 ((fill . "red")
                  (stroke . "navy")
                  (strokeWidth . 3))))
       (primitive . "rect")))))

;;;

