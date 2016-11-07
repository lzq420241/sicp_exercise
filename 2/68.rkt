#lang sicp
(#%require (only racket error))
(#%require "huffman-tree.rkt")

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      (let ((lb (left-branch tree))
            (rb (right-branch tree)))
        (cond ((element-of-set? symbol (symbols lb)) (cons '0 (encode-symbol symbol lb)))
              ((element-of-set? symbol (symbols rb)) (cons '1 (encode-symbol symbol rb)))
              (else (error "bad symbol -- NOT IN TREE" symbol))))))
 
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(display sample-tree)
(newline)

(define sample-message '(A D A B B C A))

(display (encode sample-message sample-tree))
