#lang sicp
(#%require "usr_lib.rkt")

(define (types-convert ts t1)
  (define (type-convert t1 t2)
    (if (eq? t1 t2) (lambda (x) x)
        (get t1 t2)))
  (map (lambda (t) (type-convert t t1)) ts))

(define (all-true items)
  (if (null? items) #t
      (if (car items) (all-true (cdr items))
          #f)))

(define (same-type ts)
  (all-true (map (lambda (x) (eq? x (car ts))) ts)))
(define (apply-convert fns ts)
  (if (null? fns) nil
      (cons ((car fns) (car ts))
            (apply-convert (cdr fns) (cdr ts)))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (define (get-applied ts)
      (if (null? ts) (error "No method for the2se types"
                            (list op type-tags))
          (let ((converters (types-convert type-tags (car ts))))
            (if (all-true converters)
                (apply apply-generic (cons op (apply-convert converters args)))
                (get-applied (cdr ts))))))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (same-type type-tags)
              (error "No method for the1se types"
                     (list op type-tags))
              (get-applied type-tags))))))