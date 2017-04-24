#lang sicp
(#%require "50.rkt")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (define (int v0 si)
    (cons-stream v0
                 (add-streams (scale-stream (integral si 0 dt) (/ 1 C))
                             (scale-stream si R))))
  int)