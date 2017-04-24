#lang sicp
(#%require "stream_lib.rkt")

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

(define s (expand 1 7 10))
;(define s (expand 3 8 10))

(stream-ref s 0)
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
(stream-ref s 4)
(stream-ref s 5)
(stream-ref s 6)
(stream-ref s 7)
(stream-ref s 8)
(stream-ref s 9)
(stream-ref s 10)
(stream-ref s 11)
(stream-ref s 12)