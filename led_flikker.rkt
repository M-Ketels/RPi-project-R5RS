#lang racket

(require "raspi-gpio.rkt")

(gpio-setup)

(gpio-set-pin-mode 4 'output)

(define (iter iters-left)
  (if (> iters-left 0)
      (gpio-digital-write 4 1)
      (gpio-delay-seconds 1)
      (gpio-digital-write 4 0)
      (gpio-delay-seconds 1)
      (iter (- iters-left 1))))


(iter 15)