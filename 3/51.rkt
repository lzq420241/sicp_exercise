#lang sicp
(#%require "stream_lib.rkt")

(define (show x)
  (display-line x)
  x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
(newline)
;(display-stream (stream-enumerate-interval 0 10))
(display-stream x)
(stream-ref x 5)
(stream-ref x 7)
;(stream-ref x 10)