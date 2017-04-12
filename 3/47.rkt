#lang sicp

(define (make-mutex)
  (let ((cell (list false)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)         
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))
(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

(define (make-nMutex n)
  (let ((mutex (make-mutex))
        (num n))
    (define (the-mutex m)
      (let ((cell (list (= num 0))))
        (cond ((eq? m 'acquire)
               (if (test-and-set! cell)
                   (the-mutex 'acquire) ; retry
                   (begin (mutex 'acquire) (set! num (dec num)) (mutex 'release)))) 
              ((eq? m 'release)
               (if (< num n)
                   (begin (mutex 'acquire) (set! num (inc num)) (mutex 'release)))))))
    the-mutex))

(define n3 (make-nMutex 3))
(n3 'release) ; num=3

(n3 'acquire) ; num=2
(n3 'acquire) ; num=1
(n3 'acquire) ; num=0
(n3 'release) ; num=1
(n3 'acquire) ; num=0
;(n3 'release)
(n3 'acquire) ; num=0, retry
