#lang sicp
(#%require (only racket error))

(define (make-table same-key?)
  (let ((local-table (list '*table*))
        ; how to write recursive procedure with lambda
        (assoc ((lambda (f) (lambda (k r) (f f k r)))
                (lambda (my-assoc key records)
                  (cond ((null? records) false)
                        ((same-key? key (caar records)) (car records))
                        (else (my-assoc my-assoc key (cdr records))))))))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
(define (same-key? k1 k2) (< (abs (- k1 k2)) 2))
(define operation-table (make-table same-key?))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 1 3 'v2)
(put 5 5 'v1)
(get 2 2)