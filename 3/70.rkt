#lang sicp
(#%require (only racket provide))
(#%require "stream_lib.rkt")
(provide integers)
(provide pairs)


(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (merge s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< (weight s1car) (weight s2car))
                  (cons-stream s1car (merge (stream-cdr s1) s2 weight)))
                 (else
                  (cons-stream s2car (merge s1 (stream-cdr s2) weight))))))))

(define (weight1 p)
  (+ (car p) (cadr p)))

(define (divide? n)
  (= 0 (* (remainder n 2) (remainder n 3) (remainder n 5))))

(define (weight2 p)
  (let ((i (car p))
        (j (cadr p)))
  (if (or (divide? i) (divide? j))
      (+ (* 2 i) (* 3 j) (* 5 i j))
      0)))

(define (pairs s t w)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t) w)
    w)))

;(display-stream (stream-cdr (pairs integers integers weight2)))
;(display-stream (stream-cdr (pairs integers integers weight2)))