#lang sicp
(#%require "stream_lib.rkt")

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0 (stream-map (lambda (guess)
                                   (sqrt-improve guess x))
                                 guesses)))
  guesses)

(define (sqrt-stream1 x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream1 x))))

(define s (sqrt-stream 2))
;(stream-ref s 2)
;(stream-ref s 3)
;(stream-ref s 4)
(stream-ref s 2000)
(define s1 (sqrt-stream1 3))
(stream-ref s1 2000)