
,(use rs.net.json)

(define (rjs s)
  (let ((rc (read-json (open-input-string s))))
    (format #t "~s ==> ~s\n" s rc)
    rc))

(assert (equal? (rjs "{}") '()))
(assert (equal? (rjs "{\"a\":3}") '((a . 3))))
(assert (equal? (rjs "{\"a\":3,\"b\":9}") '((a . 3) (b . 9))))

(assert (equal? (rjs "[]") '#()))
(assert (equal? (rjs "[ ]") '#()))
(assert (equal? (rjs "[3]") '#(3)))
(assert (equal? (rjs "[3,4]") '#(3 4)))

(assert (equal? (rjs "[3,4,{},{\"a\":3}]") '#(3 4 () ((a . 3)))))
