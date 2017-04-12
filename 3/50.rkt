#lang sicp
(#%require (only racket provide))
(#%require "stream_lib.rkt")
(provide stream-map)
(provide stream-car)
(provide stream-cdr)
(provide cons-stream)
(provide stream-ref)

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))