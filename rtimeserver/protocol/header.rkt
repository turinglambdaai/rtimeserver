#lang racket

(require "types.rkt"
         "constants.rkt")

(provide (struct-out ptp-header)
         parse-ptp-header
         build-ptp-header)

(struct ptp-header
  (transport-specific    ; 4 bits
   message-type          ; msg-type?
   ptp-version           ; byte?
   message-length        ; uint16
   domain-number         ; byte?
   flags                 ; 2 bytes
   correction-field      ; int64 (nanoseconds)
   source-port-identity  ; port-identity?
   sequence-id           ; uint16
   control-field         ; byte?
   log-message-interval) ; int8
  #:transparent)

(define (parse-ptp-header bs)
  (error 'parse-ptp-header "not implemented"))

(define (build-ptp-header hdr)
  (error 'build-ptp-header "not implemented"))
