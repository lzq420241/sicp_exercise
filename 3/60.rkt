#lang sicp
(#%require "50.rkt")

(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define ones (cons-stream 1 ones))
(define neg-ones (cons-stream -1 neg-ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (integrate-series s)
  (div-streams s integers))

(define cosine-series
  (cons-stream 1 (integrate-series (div-streams sine-series neg-ones))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series s2 (stream-cdr s1)))))

(define cos2 (mul-series cosine-series cosine-series))
(define sin2 (mul-series sine-series sine-series))
(define s (add-streams cos2 sin2))

(stream-ref s 0)
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
(stream-ref s 4)
