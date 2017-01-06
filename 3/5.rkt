#lang sicp
(#%require (only racket random))

(define (sicp-random n)
  (if (and (exact? n) (integer? n))
      (random n)
      (* n (random))))

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (sicp-random range))))

(define (estimate-integral trials x1 x2 y1 y2)
  (define (cesaro-test)
    (let ((rand-x (random-in-range x2 x1))
          (rand-y (random-in-range y2 y1))
          (center-x (average x1 x2))
          (center-y (average y1 y2)))
      (<= (+ (square (- rand-x center-x))
             (square (- rand-y center-y)))
          (square (/ (- x1 x2) 2)))))
  (* (monte-carlo trials cesaro-test) 4.0))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) 
                 trials-passed))))
  (iter trials 0))

(estimate-integral 1000000 8.01 2.01 10.01 4.01)