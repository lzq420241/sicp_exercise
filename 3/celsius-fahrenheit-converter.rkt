#lang sicp
(#%require "retractor_lib.rkt")

;(define C (make-connector))
;(define F (make-connector))
;
;(define (celsius-fahrenheit-converter c f)
;  (let ((u (make-connector))
;        (v (make-connector))
;        (w (make-connector))
;        (x (make-connector))
;        (y (make-connector)))
;    (multiplier c w u)
;    (multiplier v x u)
;    (adder v y f)
;    (constant 9 w)
;    (constant 5 x)
;    (constant 32 y)
;    'ok))
;
;(celsius-fahrenheit-converter C F)


(define C (make-connector))

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier z y x)
    z))

(define (cv n)
  (let ((z (make-connector)))
    (constant n z)
    z))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define F (celsius-fahrenheit-converter C))


(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)
;(set-value! F 212 'user)
(forget-value! C 'user)
(set-value! F 212 'user)