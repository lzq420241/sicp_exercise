#lang sicp
(#%require "50.rkt")

(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define ones (cons-stream 1 ones))
(define neg-ones (cons-stream -1 neg-ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (integrate-series s)
  (div-streams s integers))

;(define s (integrate-series integers))
;(stream-ref s 0)
;(stream-ref s 1)
;(stream-ref s 2)
;(stream-ref s 3)
;(stream-ref s 4)
;(stream-ref s 5)


;(define exp-series
;  (cons-stream 1 (integrate-series exp-series)))
;(stream-ref exp-series 0)
;(stream-ref exp-series 1)
;(stream-ref exp-series 2)
;(stream-ref exp-series 3)
;(stream-ref exp-series 4)
;(stream-ref exp-series 5)

(define cosine-series
  (cons-stream 1 (integrate-series (div-streams sine-series neg-ones))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
(stream-ref cosine-series 0)
(stream-ref cosine-series 1)
(stream-ref cosine-series 2)
(stream-ref cosine-series 3)
(stream-ref cosine-series 4)
(stream-ref cosine-series 5)
(newline)
(stream-ref sine-series 0)
(stream-ref sine-series 1)
(stream-ref sine-series 2)
(stream-ref sine-series 3)
(stream-ref sine-series 4)
(stream-ref sine-series 5)

