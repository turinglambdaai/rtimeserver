#lang racket

(require racket/async-channel
         "../protocol/types.rkt")

(provide (struct-out captured-packet)
         start-capture)

(struct captured-packet
  (timestamp      ; ptp-timestamp? (capture time)
   interface      ; string? (interface name)
   data           ; bytes? (raw packet including Ethernet header)
   length)        ; exact-nonnegative-integer?
  #:transparent)

;; Start capturing PTP packets on the given interface.
;; Returns (values cancel-procedure async-channel-of-captured-packet).
(define (start-capture interface-name)
  (error 'start-capture "not implemented"))
