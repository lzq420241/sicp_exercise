#lang sicp

(define (make-accumulator sum)
  (lambda (adder)
    (begin (set! sum (+ sum adder)) sum)))

(define A (make-accumulator 5))
(A 10)
(A 10)
