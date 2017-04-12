#lang sicp
(#%require "50.rkt")

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define s (cons-stream 1 (add-streams s s)))

(stream-ref s 5)
(stream-ref s 10)