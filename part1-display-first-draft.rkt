#lang racket

;; cmd:  racket -t part1-display-first-draft.rkt

(define row-0 #f)
(define row-1 #f)
(define row-2 #f)

(define column-0 #t)
(define column-1 #t)
(define column-2 #t)

(define matrix (make-vector 9))


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

(define (reset-rows-colums)
    (set! row-0 #f)
    (set! row-1 #f)
    (set! row-2 #f)

    (set! column-0 #t)
    (set! column-1 #t)
    (set! column-2 #t))

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
        (display (string-append led20-display led21-display led22-display "\n\n"))))




;; input:   a 3x3 binary image in the form of a boolean vector of length 9
;; output:  a function that sets the first row, then prints, then sets the second
;;          row, then prints, then sets the third row, then prints
(define (linear-matrix-to-led)
    (define (set-row-n n)
        (let
            ((column0 (if (= 1 (vector-ref matrix (* 3 n))) #t #f))
            (column1 (if (= 1 (vector-ref matrix (+ 1 (* 3 n)))) #t #f))
            (column2 (if (= 1 (vector-ref matrix (+ 2 (* 3 n)))) #t #f)))
        

        (activate-row n)
        ;(display column0)(display column1)(display column2)
        (if column0 (deactivate-column 0) (void))
        (if column1 (deactivate-column 1) (void))
        (if column2 (deactivate-column 2) (void))
        )
    )

    (set-row-n 0)
    (print-led-matrix)
    (reset-rows-colums)
    (set-row-n 1)
    (print-led-matrix)
    (reset-rows-colums)
    (set-row-n 2)
    (print-led-matrix)
    (reset-rows-colums)
)


;; the matrix can only have one lit pixel
(define (roll-pixel direction)
    (define (find-index-and-set-zero current-index)
        (cond
            ((= 0 (vector-ref matrix current-index)) 
                (find-index-and-set-zero (+ current-index 1)))
            ((= 1 (vector-ref matrix current-index))
                (vector-set! matrix current-index 0)
                current-index)
            (else (display "illegal occupation of matrix: ")(display matrix))      
        )
    )
    (define (find-new-index current-index direction)
        (cond
            ((eq? direction 'up)
                (max (- current-index 3) current-index)) ;; max and min are wrong: just needs an if statement of something
            ((eq? direction 'down)
                (min (+ current-index 3) current-index))
            ((eq? direction 'left)
                (if (= 0 (modulo current-index 3)) current-index (- current-index 1)))
            ((eq? direction 'right)
                (if (= 2 (modulo current-index 3)) current-index (+ current-index 1)))
            (else (display "illegal direction")(display direction))
        )
    )
    (vector-set! matrix (find-new-index (find-index-and-set-zero 0) direction) 1)
)

(define (test-deel-1)
    (set! matrix (vector 1 0 1 0 1 0 1 0 1))

    (display matrix)(display "\n")

    (linear-matrix-to-led)
)

(define (test-roll-pixel)
    (set! matrix (vector 0 0 0 0 1 0 0 0 0))
    (linear-matrix-to-led)
    (display "up\n")
    (roll-pixel 'up)
    (linear-matrix-to-led)
)

(test-roll-pixel)
