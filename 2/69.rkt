#lang sicp
(#%require "huffman-tree.rkt")

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

(define pairs (list (list 'A 4) (list 'B 2) (list 'C 1) (list 'D 1)))

(display (generate-huffman-tree pairs))