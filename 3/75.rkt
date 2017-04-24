#lang sicp
(#%require "50.rkt")

(define (sign-change-detector a b)
  (if (< (* a b) 0)
      (if (> b 0) 1 -1)
      0))

(define (smooth s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1)))
    (cons-stream (/ (+ s0 s1) 2) (smooth (stream-cdr s)))))

(define (make-zero-crossings smooth input-stream last-value)
  (define (inner is lv)
    (cons-stream (sign-change-detector (stream-car is) lv)
                 (inner (stream-cdr is) (stream-car is))))
  (inner (smooth input-stream) last-value))
