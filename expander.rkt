#lang racket


(require "raspi-gpio.rkt")
(gpio-setup)
(gpio-mcp23017-setup 100 #x20)
(define PIN (+ 100 0))
(gpio-set-pin-mode PIN 'output)
(gpio-digital-write PIN 1)
(gpio-delay-seconds 5)
(gpio-digital-write PIN 0)