#lang sicp

; suppose S to be a list which its length equals to A
; and all element set to zero.

(define (ripple-carry-adder A B S C)
  (let ((c (make-wire)))
    (if ((null? (cdr A)))
        (set-signal! c 0)
        (ripple-carry-adder (cdr A) (cdr B) (cdr S) c))
    (full-adder (car A) (car B) c (car S) C)))
