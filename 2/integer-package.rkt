#lang sicp
(#%require "usr_lib.rkt")
(#%require (only racket provide))
(#%require "rational-package.rkt")
(provide make-integer)
(provide install-integer-package)

(define (install-integer-package)
  (define (tag x)
    (attach-tag 'integer x))    
  (put 'add '(integer integer)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(integer integer)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(integer integer)
       (lambda (x y) (tag (* x y))))
  (put 'div '(integer integer)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'integer
       (lambda (x) (tag x)))
  (put 'raise '(integer)
       (lambda (s) (make-rational s 1)))

  'integer-install-done)

(define (make-integer n)
  ((get 'make 'integer) n))
