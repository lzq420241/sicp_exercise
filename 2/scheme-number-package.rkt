#lang sicp
(#%require "usr_lib.rkt")
(#%require (only racket provide))
(#%require "rational-package.rkt")
(provide make-scheme-number)
(provide install-scheme-number-package)

(define (install-scheme-number-package)
  ;(define (scheme-number->scheme-number n) n)
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
  (put 'raise '(scheme-number)
       (lambda (s) (make-rational s 1)))
;  (put 'scheme-number 'scheme-number
;       scheme-number->scheme-number)
  ;; following added to Scheme-number package
  (put 'exp '(scheme-number scheme-number)
       (lambda (x y) (tag (expt x y)))) ; using primitive expt
  'scheme-number-install-done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
