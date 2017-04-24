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
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (interleave (stream-map (lambda (x) (list (stream-car t) x))
                (stream-cdr s))
                (stream-map (lambda (x) (list x (stream-car t)))
                (stream-cdr s)))
    (pairs (stream-cdr s) (stream-cdr t)))))

(display-stream (pairs integers integers))