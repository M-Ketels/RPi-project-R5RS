#lang racket

(require "raspi-gpio-taak.rkt")
(gpio-setup)

(define fd (gpio-i2c-setup #x1d))

;(gpio-i2c-read-reg8 fd addr)
;(gpio-i2c-write-reg8 fd addr data)

(define OUT_X_L_A #x28) ; LSB voor de X-as
(define OUT_X_H_A #x29) ; MSB voor de X-as
(define OUT_Y_L_A #x2A) ; LSB voor de Y-as
(define OUT_Y_H_A #x2B) ; MSB voor de Y-as
(define OUT_Z_L_A #x2C) ; LSB voor de Z-as
(define OUT_Z_H_A #x2D) ; MSB voor de Z-as

(lsm303d-setup fd)

(define (convert-value LSB MSB)
    (define (combine-bits LSB MSB)
        (+ LSB (* 256 MSB))
    )
    (let
        ((combined-value (combine-bits LSB MSB)))

        (if (< combined-value 32768)
            (/ combined-value 16384.0)
            (/ (- combined-value 32768) 16384.0)
        )
    )
)

(define (round-to-decimals number decimals)
  (let ([factor (expt 10 decimals)])
    (/ (round (* number factor)) factor)))

(define (sm303d-acceleration)
    (let
        (
            (x-val (convert-value (gpio-i2c-read-reg8 fd OUT_X_L_A) (gpio-i2c-read-reg8 fd OUT_X_H_A)))
            (y-val (convert-value (gpio-i2c-read-reg8 fd OUT_Y_L_A) (gpio-i2c-read-reg8 fd OUT_Y_H_A)))
            (z-val (convert-value (gpio-i2c-read-reg8 fd OUT_Z_L_A) (gpio-i2c-read-reg8 fd OUT_Z_H_A)))
        )
        (displayln (string-append
            "x: "
            (number->string (round-to-decimals x-val 2))
            "; y: "
            (number->string (round-to-decimals y-val 2))
            "; z: "
            (number->string (round-to-decimals z-val 2))
        ))
        (sm303d-acceleration)
    )
)



(sm303d-acceleration)