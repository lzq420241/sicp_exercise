#lang sicp
(#%require "50.rkt")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (partial-sums s) (stream-cdr s))))

(define s (partial-sums integers))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

(define ln2-stream
  (partial-sums (ln2-summands 1)))

;(stream-ref integers 4)
;(stream-ref integers 5)
(stream-ref s 0)
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
(stream-ref s 4)
(stream-ref s 5)
(define s1 (accelerated-sequence euler-transform
                                      pi-stream))

(stream-ref s1 7)
(stream-ref s1 8)
(stream-ref s1 9)
; +nan.0 (not-a-number),
(stream-ref s1 10)
;(display-stream ln2-stream)
;(display-stream (euler-transform ln2-stream))
(display-stream (accelerated-sequence euler-transform ln2-stream))
