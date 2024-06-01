#lang racket

(require "raspi-gpio.rkt")

(println "setting up")
(gpio-setup)

(println "set pin mode")
(gpio-set-pin-mode 4 'output)

(println "led on")
(gpio-digital-write 4 1)

(println "wait 5s")
(gpio-delay-seconds 5)

(println "led off")
(gpio-digital-write 4 0)

