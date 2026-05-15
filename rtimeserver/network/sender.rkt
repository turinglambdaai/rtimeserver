#lang racket

(provide send-ptp-packet
         build-ethernet-frame)

(define (send-ptp-packet payload interface-name)
  (error 'send-ptp-packet "not implemented"))

(define (build-ethernet-frame dst-mac src-mac ethertype payload)
  (error 'build-ethernet-frame "not implemented"))
