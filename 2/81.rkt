#lang sicp
(#%require "complex-package.rkt")
(#%require "scheme-number-package.rkt")
(define z (make-complex-from-real-imag 1 4))
(define s (make-scheme-number 2))
(define z1 (add s z))
(define z2 (add z s))
z1
z2
;(get 'scheme-number 'complex)
;s
;((get 'scheme-number 'complex) s)
;(apply-generic 'exp s s)
;(apply-generic 'exp z z)