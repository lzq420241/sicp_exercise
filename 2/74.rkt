#lang sicp

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum) (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

(define (install-dept1-package)
  (put 'get-record 'dept1
       (lambda (e) (get-record e)))
  (put 'get-salary 'dept1
       (lambda (e) (get-salary e)))
  'done)

(define (get-record dept employee-name)
  (attach-tag dept ((get 'get-record dept) employee-name)))

(define (find-employee-record employee-name dept-names)
  (if (null? dept-names) nil
      (if (null? (get-record (car dept-names) employee-name))
          (find-employee-record (cdr dept-names) employee-name)
          get-record (car dept-names) employee-name)))

(define (get-salary employee-name dept-names)
  ((get 'get-salary
        (type-tag (find-employee-record employee-name dept-names)))
   employee-name))