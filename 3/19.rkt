#lang sicp

(define (compare p1 p2)
  (cond ((or (null? p1) (null? p2) (null? (cdr p2))) #f)
        ((eq? p1 p2) #t)
        (else (set! p1 (cdr p1))
              (set! p2 (cddr p2))
              (compare p1 p2))))

(define (contains-loop? x)
  (if (or (null? x) (null? (cdr x))) #f
      (compare (cdr x) (cddr x))))
         
(define (last-pair x)
  (if (null? (cdr x)) x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z1 (list 'a 'b 'c))
(contains-loop? z1)

(define z-1 (list 'a))
(define z2 (cons z-1 (list z-1)))
(contains-loop? z2)

(define z-2 (cons z-1 z-1))
(define z3 (cons z-2 z-2))
(contains-loop? z3)

(define z4 (make-cycle (list 'a 'b 'c)))
(contains-loop? z4)

(define z5 (cons z3 z4))
(contains-loop? z5)
