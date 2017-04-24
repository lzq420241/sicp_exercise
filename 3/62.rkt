#lang sicp
(#%require (only racket error))
(#%require "50.rkt")

(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (integrate-series s)
  (div-streams s integers))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series s2 (stream-cdr s1)))))

(define (reciprocal-series s)
  (let ((c (stream-car s)))
    (if (eq? c 0) (error "constant term is zero.")
        (cons-stream (/ 1 c) (mul-series
                              (scale-stream (stream-cdr s) (/ -1 c))
                              (reciprocal-series s))))))

(define (div-series s1 s2)
  (mul-series s1 (reciprocal-series s2)))

(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
(define s (div-series sine-series cosine-series))

(stream-ref s 0)
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
(stream-ref s 4)
(stream-ref s 5)
