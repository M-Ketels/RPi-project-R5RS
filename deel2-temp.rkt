#lang racket

(require "raspi-gpio-taak.rkt")
(gpio-setup)

(define fd (gpio-i2c-setup #x1d))

;(gpio-i2c-read-reg8 fd addr)
;(gpio-i2c-write-reg8 fd addr data)

(define TEMP_OUT_L #x05)
(define TEMP_OUT_H #x06)

(lsm303d-setup fd)

(define (convert-temperature temp-out-l temp-out-h)
    (define (combine-bits temp-out-l temp-out-h)
        (let
            ((MSB (modulo temp-out-h 16)))

            (+ temp-out-l (* 256 MSB))
        )
    )
    (let
        ((combined-temp (combine-bits temp-out-l temp-out-h)))

        (if (< combined-temp 2048)
            (+ 25 (* combined-temp 0.125))
            (+ 25 (* (- combined-temp 4096) 0.125))
        )
    )
)

(define (round-to-decimals number decimals)
  (let ([factor (expt 10 decimals)])
    (/ (round (* number factor)) factor)))


(define (sm303d-temperature)
    (displayln (round-to-decimals (convert-temperature (gpio-i2c-read-reg8 fd TEMP_OUT_L) (gpio-i2c-read-reg8 fd TEMP_OUT_H)) 2))
    ;(gpio-delay-ms 100)
    (sm303d-temperature)
)


(sm303d-temperature)