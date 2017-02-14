#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (count-unique-pairs x)
  (let ((traversed-set '()))
    (define (count-pairs x)
      (cond ((or (not (pair? x)) (element-of-set? x traversed-set)) 0)
            (else (set! traversed-set (cons x traversed-set))
                  (+ (count-pairs (car x))
                     (count-pairs (cdr x))
                     1))))
    (count-pairs x)))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z1 (list 'a 'b 'c))
(count-unique-pairs z1)


(define z-1 (list 'a))
(define z2 (cons z-1 (list z-1)))
(count-unique-pairs z2)


(define z-2 (cons z-1 z-1))
(define z3 (cons z-2 z-2))
(count-unique-pairs z3)

(define z4 (make-cycle (list 'a 'b 'c)))
(count-unique-pairs z4)