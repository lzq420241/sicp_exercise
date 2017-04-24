#lang sicp
(#%require "stream_lib.rkt")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x)) t)
   (pairs (stream-cdr s) (stream-cdr t))))

; recusive call on interleave will NOT delay the computation,
; only cons-stream will do that.
; so the pairs function will NOT return.
(stream-car (stream-map (lambda (x) (list (stream-car integers) x)) integers))
(stream-ref (pairs integers integers) 0)
