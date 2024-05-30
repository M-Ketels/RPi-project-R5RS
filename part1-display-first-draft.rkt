#lang racket

;; cmd:  racket -t part1-display-first-draft.rkt

(define row-0 #f)
(define row-1 #f)
(define row-2 #f)

(define column-0 #t)
(define column-1 #t)
(define column-2 #t)


(define (activate-row row-number)
    (cond 
        ((= row-number 0) (set! row-0 #t))
        ((= row-number 1) (set! row-1 #t))
        ((= row-number 2) (set! row-2 #t))))

(define (deactivate-column column-number)
    (cond 
        ((= column-number 0) (set! column-0 #f))
        ((= column-number 1) (set! column-1 #f))
        ((= column-number 2) (set! column-2 #f))))

(define (print-led-matrix) ;; very ugly but works so whatever
    (let* 
        (
            (led00 (and row-0 (not column-0)))
            (led01 (and row-0 (not column-1)))
            (led02 (and row-0 (not column-2)))
            (led10 (and row-1 (not column-0)))
            (led11 (and row-1 (not column-1)))
            (led12 (and row-1 (not column-2)))
            (led20 (and row-2 (not column-0)))
            (led21 (and row-2 (not column-1)))
            (led22 (and row-2 (not column-2)))

            (led00-display (if led00 "[X]" "[ ]"))
            (led01-display (if led01 "[X]" "[ ]"))
            (led02-display (if led02 "[X]" "[ ]"))
            (led10-display (if led10 "[X]" "[ ]"))
            (led11-display (if led11 "[X]" "[ ]"))
            (led12-display (if led12 "[X]" "[ ]"))
            (led20-display (if led20 "[X]" "[ ]"))
            (led21-display (if led21 "[X]" "[ ]"))
            (led22-display (if led22 "[X]" "[ ]"))
        )
        (display (string-append led00-display led01-display led02-display "\n"))
        (display (string-append led10-display led11-display led12-display "\n"))
        (display (string-append led20-display led21-display led22-display "\n"))
    )
)

(activate-row 0)
(deactivate-column 0)
(deactivate-column 2)

(print-led-matrix)