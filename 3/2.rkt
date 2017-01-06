#lang sicp

(define (make-monitored f)
  (let ((counter 0))
    (define (dispatch m)
      (cond ((eq? m 'how-many-calls?) counter)
            ((eq? m 'reset-count) (set! counter 0))
            (else (begin (set! counter (inc counter)) (f m)))))
    dispatch))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 100)
(s 'how-many-calls?)
(s 'reset-count)
(s 'how-many-calls?)