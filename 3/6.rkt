#lang sicp
(#%require (only racket error))

(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

(define rand
  (let ((x 0))
    (define (reset new-value)
      (begin (set! x new-value) new-value))
    (define (generate)
      (begin (set! x (rand-update x)) x))
    (define (dispatch m)
      (cond ((eq? m 'generate) (generate))
            ((eq? m 'reset) reset)
            (else (error "Unknown request:
                 MAKE-ACCOUNT" m))))
    dispatch))

(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
((rand 'reset) 93)
(rand 'generate)
(rand 'generate)