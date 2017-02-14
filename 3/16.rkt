#lang sicp

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z1 (list 'a 'b 'c))
(count-pairs z1)


(define z-1 (list 'a))
(define z2 (cons z-1 (list z-1)))
(count-pairs z2)


(define z-2 (cons z-1 z-1))
(define z3 (cons z-2 z-2))
(count-pairs z3)

(define z4 (make-cycle (list 'a 'b 'c)))
;(count-pairs z4)