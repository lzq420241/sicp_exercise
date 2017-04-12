#lang sicp
(#%require "retractor_lib.rkt")

(define (averager a b c)
  (let ((s (make-connector))
        (x (make-connector)))
    (adder a b s)
    (multiplier x c s)
    (constant 2 x)
    'ok))

(define A (make-connector))
(define B (make-connector))
(define C (make-connector))
(averager A B C)

(probe "data 1" A)
(probe "data 2" B)
(probe "avg" C)

(set-value! C 25 'user)
(set-value! B 41 'user)

; In this case, the informant of A is the object create at line 7,
; other informant to forget will be ignored. 
;(forget-value! A A)

(forget-value! B 'user)
(set-value! A 49 'user)