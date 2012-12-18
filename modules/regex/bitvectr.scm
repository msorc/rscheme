#|------------------------------------------------------------*-Scheme-*--|
 | File:    %p%
 |
 |          Copyright (C)1997 Donovan Kolbly <d.kolbly@rscheme.org>
 |          as part of the RScheme project, licensed for free use.
 |          See <http://www.rscheme.org/> for the latest information.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 | Owned by module:  regex
 |
 | Purpose:          bit-vectors as <vector>'s of byte-size fixnums
 `------------------------------------------------------------------------|#

(define (vector-bit? (vec <vector>)
		     (index <fixnum>))
  (let (((byte <fixnum>) (quotient index 8))
	((bit <fixnum>) (remainder index 8)))
    (not (eq? (bitwise-and (vector-ref vec byte)
			   (logical-shift-right #x80 bit))
	      0))))


(define (vector-bit-set! (vec <vector>)
			 (index <fixnum>))
  (let (((byte <fixnum>) (quotient index 8))
	((bit <fixnum>) (remainder index 8)))
    (vector-set! vec
		 byte
		 (bitwise-or (vector-ref vec byte)
			     (logical-shift-right #x80 bit)))))

(define (bit-vector-or (vec1 <vector>)
		       (vec2 <vector>))
  (let ((v (make-vector 32 0)))
    (let loop (((i <fixnum>) 0))
      (if (eq? i 32)
	  v
	  (begin
	    (vector-set! v i (bitwise-or (vector-ref vec1 i)
					 (vector-ref vec2 i)))
	    (loop (add1 i)))))))

	  
(define (bit-vector-not (vec <vector>))
  (let ((v (make-vector 32 0)))
    (let loop (((i <fixnum>) 0))
      (if (eq? i 32)
	  v
	  (begin
	    (vector-set! v i (bitwise-xor (vector-ref vec i) #xFF))
	    (loop (add1 i)))))))
