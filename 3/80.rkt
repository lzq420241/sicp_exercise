#lang racket
(#%require "stream_lib.rkt")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (RLC R L C dt)
  (define (int vC0 iL0)
    ; consider why can not replace dvC with scale-stream
    (define vC (integral (delay dvC) vC0 dt))
    (define iL (integral (delay diL) iL0 dt))
    (define dvC (scale-stream iL (/ -1 C)))
    (define diL (add-streams (scale-stream vC (/ 1 L)) (scale-stream iL (/ (- 0 R) L))))
    (define s (stream-map cons vC iL))
    s)
  int)

(display-stream ((RLC 1 1 0.2 0.1) 10 0))