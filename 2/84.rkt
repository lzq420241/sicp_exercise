#lang sicp
(#%require (only racket error))
(#%require "83.rkt")

; for practice 84
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (get 'prio (car type-tags)))
                    (type2 (get 'prio (cadr type-tags)))
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

(define n (make-integer-number 3))
(define (raise n) (apply-generic 'raise n))
(define (add x y) (apply-generic 'add x y))

(raise (raise (raise n)))
(add (raise (raise n)) n)
(add n (raise (raise n)))
