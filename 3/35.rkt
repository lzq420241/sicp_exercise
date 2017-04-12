#lang sicp
(#%require "retractor_lib.rkt")


(define A (make-connector))
(define B (make-connector))
(squarer A B)

(probe "data 1" A)
(probe "sq" B)

(set-value! A 8 'user)
(forget-value! A 'user)
(set-value! B 256 'user)
