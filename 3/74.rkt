#lang sicp
(#%require "50.rkt")

(define zero-crossings
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))
