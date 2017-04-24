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

(define (stream-limit s t)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1)))
    (if (> t (abs (- s1 s0))) s1
        (stream-limit (stream-cdr s) t))))
        
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(sqrt 2 0.001)