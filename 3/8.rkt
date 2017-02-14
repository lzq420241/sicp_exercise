#lang sicp

;(define setted nil)
;(define (f n)
;  (if (or (null? setted) (< n setted)) (begin (set! setted n) n)
;      (begin (set! setted n) n)))


;(define f
;  (let ((setted nil))
;    (lambda (n) (if (or (null? setted) (< n setted))
;                    (begin (set! setted n) n)
;                    setted))))


; return the setted value upon first set,
; return 0 upon second set and clear set status
(define f
  (let ((setted #f))
    (lambda (n) (if setted
                    (begin (set! setted #f) 0)
                    (begin (set! setted #t) n)))))

(+ (f 0) (f 1))
(+ (f 1) (f 0))
