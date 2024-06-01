#lang racket

;; should deactivate gpb0-1-2 and activate gpa0-1-2

(require "raspi-gpio.rkt")
(gpio-setup)
(gpio-mcp23017-setup 100 #x20)
(define PIN_RIJ_0 (+ 100 7))
(define PIN_RIJ_1 (+ 100 6))
(define PIN_RIJ_2 (+ 100 5))

(define PIN_KOLOM_0 (+ 100 8 0))
(define PIN_KOLOM_1 (+ 100 8 1))
(define PIN_KOLOM_2 (+ 100 8 2))

(gpio-set-pin-mode PIN_RIJ_0 'output)
(gpio-set-pin-mode PIN_RIJ_1 'output)
(gpio-set-pin-mode PIN_RIJ_2 'output)

(gpio-set-pin-mode PIN_KOLOM_0 'output)
(gpio-set-pin-mode PIN_KOLOM_1 'output)
(gpio-set-pin-mode PIN_KOLOM_2 'output)




(gpio-digital-write PIN_RIJ_0 1)
(gpio-digital-write PIN_RIJ_1 0)
(gpio-digital-write PIN_RIJ_2 1)

;(gpio-digital-write PIN_KOLOM_0 0)
(gpio-digital-write PIN_KOLOM_1 1)
;(gpio-digital-write PIN_KOLOM_2 0)

(gpio-delay-seconds 2)

(gpio-digital-write PIN_RIJ_0 0)
(gpio-digital-write PIN_RIJ_1 0)
(gpio-digital-write PIN_RIJ_2 0)

(gpio-digital-write PIN_KOLOM_0 0)
(gpio-digital-write PIN_KOLOM_1 0)
(gpio-digital-write PIN_KOLOM_2 0)