#lang sicp
(#%require "usr_lib.rkt")
(#%require (only racket provide))
(provide make-scheme-number)
(provide add)

(define (install-scheme-number-package)
  (define (scheme-number->scheme-number n) n)
  (define (exp x y) (apply-generic 'exp x y))
  (define (tag x)
    (attach-tag 'scheme-number x))    
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  (put 'scheme-number 'scheme-number
       scheme-number->scheme-number)
  ;; following added to Scheme-number package
  (put 'exp '(scheme-number scheme-number)
       (lambda (x y) (tag (expt x y)))) ; using primitive expt
  'scheme-number-install-done)

(install-scheme-number-package)
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))