#lang sicp
(#%require (only racket provide))
(#%require "stream_lib.rkt")
(provide scale-stream)
(provide stream-car)
(provide stream-cdr)
(provide cons-stream)
(provide stream-ref)
(provide euler-transform)
(provide accelerated-sequence)
(provide display-stream)
(provide pi-summands)
(provide ln2-summands)
(provide stream-map)
(provide add-streams)

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))