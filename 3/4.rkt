#lang sicp
(#%require (only racket error))

(define (call-the-cops)
  "Calling 110..")

(define (make-account balance pass)
  (let ((consecutive-mismatch-times 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance 
                       (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (show-error amount)
      (begin (set! consecutive-mismatch-times
                   (+ consecutive-mismatch-times 1))
             (if (>= consecutive-mismatch-times 3) (call-the-cops))))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (dispatch p m)
      (if (eq? p pass)
          (begin (set! consecutive-mismatch-times 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request: MAKE-ACCOUNT" m))))
          show-error))
    dispatch))

(define acc 
  (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'secret-password 'deposit) 70)