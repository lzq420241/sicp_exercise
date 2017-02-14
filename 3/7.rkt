#lang sicp
(#%require (only racket error))

(define (show-error amount)
  "Incorrect password")
(define (make-account balance pass)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (cond ((not (eq? p pass)) show-error)
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
  dispatch)

(define peter-acc 
  (make-account 100 'open-sesame))

(define (make-joint acc pwd newp)
  (define (dispatch p m)
    (if (not (eq? p newp)) show-error
        (acc pwd m)))
  dispatch)

(define paul-acc
  (make-joint peter-acc 
              'open-sesame 
              'rosebud))

((peter-acc 'open-sesame 'withdraw) 40)
((paul-acc 'rosebud 'withdraw) 40)
