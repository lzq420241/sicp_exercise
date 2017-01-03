#lang sicp
(#%require (only racket provide))
(#%require "usr_lib.rkt")
(#%require "integer-package.rkt")
(#%require "rational-package.rkt")
(#%require "real-package.rkt")
(#%require "complex-package.rkt")

(install-integer-package)
(install-rational-package)
(install-real-package)
(install-complex-package)

(define (install-level-package)
  (put 'level 'scheme-number 0)
  (put 'level 'rational 1)
  (put 'level 'real 2)
  (put 'level 'complex 3)
  'level-install-done)

(install-level-package)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (get 'level (car type-tags)))
                    (type2 (get 'level (cadr type-tags)))
                    (a1 (car args))
                    (a2 (cadr args)))
                (cond ((= type1 type2)
                       (error "No method for these types"
                              (list op type-tags)))
                      ((< type1 type2)
                       (apply-generic op (apply-generic 'raise a1) a2))
                      (else (apply-generic op a1 (apply-generic 'raise a2)))))
              (error "No method for these types"
                     (list op type-tags)))))))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (raise x) (apply-generic 'raise x))
(define r (make-real 3.14))
(define n (make-complex-from-real-imag 3 4))
(inexact->exact 0.333333333333333333333333333333333333)
r