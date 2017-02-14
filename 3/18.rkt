#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (contains-loop? x)
  (let ((traversed-set '()))
    (define (check-list x)
      (cond ((null? x) #f)
            ((element-of-set? x traversed-set) #t)
            (else (set! traversed-set (cons x traversed-set))
                  (check-list (cdr x)))))
    (check-list x)))

(define (last-pair x)
  (if (null? (cdr x))
      x
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