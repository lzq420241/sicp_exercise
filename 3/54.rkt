#lang sicp
(#%require "50.rkt")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
(define factorials (cons-stream 1 (mul-streams integers factorials)))

(stream-ref factorials 5)
(stream-ref factorials 6)
(stream-ref factorials 10)
