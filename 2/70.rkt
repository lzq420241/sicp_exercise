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

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (define (build nodes result-list)
    (if (null? (cdr nodes))
        result-list
        (let ((first-node (car nodes))
              (second-node (cadr nodes))
              (rest-nodes (cddr nodes)))
          (let ((tree (make-code-tree
                       first-node second-node)))
            (build (adjoin-set tree rest-nodes) tree)))))
  (build leaf-set '()))

(define pairs (list (list 'A 2) (list 'NA 16) (list 'BOOM 1) (list 'SHA 3)
                    (list 'GET 2) (list 'YIP 9) (list 'JOB 2) (list 'WAH 1)))

(define sample-tree (generate-huffman-tree pairs))
(define sample-message '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM))
(display (encode sample-message sample-tree))