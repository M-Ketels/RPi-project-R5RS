#lang racket


(require "raspi-gpio-taak.rkt")
(gpio-setup)
(gpio-mcp23017-setup 100 #x20)
(define PIN_RIJ_0 (+ 100 7)) ;; gpa7
(define PIN_RIJ_1 (+ 100 6)) ;; gpa6
(define PIN_RIJ_2 (+ 100 5)) ;; gpa5

(define PIN_KOLOM_0 (+ 100 8 0)) ;; gpb0
(define PIN_KOLOM_1 (+ 100 8 1)) ;; gpb1
(define PIN_KOLOM_2 (+ 100 8 2)) ;; gpb2

(gpio-set-pin-mode PIN_RIJ_0 'output)
(gpio-set-pin-mode PIN_RIJ_1 'output)
(gpio-set-pin-mode PIN_RIJ_2 'output)

(gpio-set-pin-mode PIN_KOLOM_0 'output)
(gpio-set-pin-mode PIN_KOLOM_1 'output)
(gpio-set-pin-mode PIN_KOLOM_2 'output)

(define matrix (vector 1 0 1 0 1 0 1 0 1))

(define (activate-row row-number)
    (cond 
        ((= row-number 0) (gpio-digital-write PIN_RIJ_0 1))
        ((= row-number 1) (gpio-digital-write PIN_RIJ_1 1))
        ((= row-number 2) (gpio-digital-write PIN_RIJ_2 1))))

(define (deactivate-column column-number)
    (cond 
        ((= column-number 0) (gpio-digital-write PIN_KOLOM_0 0))
        ((= column-number 1) (gpio-digital-write PIN_KOLOM_1 0))
        ((= column-number 2) (gpio-digital-write PIN_KOLOM_2 0))))

(define (reset-rij-kolom)
    (gpio-digital-write PIN_RIJ_0 0)
    (gpio-digital-write PIN_RIJ_1 0)
    (gpio-digital-write PIN_RIJ_2 0)

    (gpio-digital-write PIN_KOLOM_0 1)
    (gpio-digital-write PIN_KOLOM_1 1)
    (gpio-digital-write PIN_KOLOM_2 1))


(define (linear-matrix-to-led delay-ms)
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

    (reset-rij-kolom)
    (set-row-n 0)
    (gpio-delay-ms delay-ms)
    (reset-rij-kolom)
    (set-row-n 1)
    (gpio-delay-ms delay-ms)
    (reset-rij-kolom)
    (set-row-n 2)
    (gpio-delay-ms delay-ms)
)
(define (display-image duration refresh-time-ms)
    (define (display-image-loop duration-ms refresh-time-ms start-time)
        (linear-matrix-to-led refresh-time-ms)
        (if (< (gpio-elapsed-ms) (+ start-time duration-ms))
            (display-image-loop duration refresh-time-ms start-time)
            (void)
        )
    )
    (display-image-loop duration refresh-time-ms (gpio-elapsed-ms))
)

(define (animation-showcase)
    (set! matrix (vector 0 0 0 0 0 0 0 0 0))
    (display-image 300 3)
    (set! matrix (vector 1 0 0 0 0 0 0 0 0))
    (display-image 300 3)
    (set! matrix (vector 1 1 0 0 0 0 0 0 0))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 0 0 0 0 0 0))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 0 0 1 0 0 0))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 0 0 1 0 0 1))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 0 0 1 0 1 1))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 0 0 1 1 1 1))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 1 0 1 1 1 1))
    (display-image 300 3)
    (set! matrix (vector 1 1 1 1 1 1 1 1 1))
    (display-image 300 3)
)


(set! matrix (vector 1 0 1 0 1 0 1 0 1))

(display-image 3000 3)

(set! matrix (vector 0 1 0 1 0 1 0 1 0))

(display-image 3000 3)

(set! matrix (vector 1 0 0 1 1 0 1 1 1))

(display-image 3000 3)

(animation-showcase)

(reset-rij-kolom)


