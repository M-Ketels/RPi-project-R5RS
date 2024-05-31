#lang racket

(define (loop-function)
  (display "hello\n")
  (sleep 0.5)  ; Wait for 500 milliseconds
  (loop-function))

(loop-function)
;; use ctrl + c
;; to stop procedure from running for ever

;; racket -t file.rkt -i
;; for a read-eval-print-loop