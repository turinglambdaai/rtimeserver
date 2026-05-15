#lang racket

(require "types.rkt"
         "header.rkt")

(provide (struct-out ptp-announce-msg)
         parse-announce-body
         build-announce-msg)

(struct ptp-announce-msg
  (header
   current-utc-offset               ; int16
   grandmaster-priority1            ; byte
   grandmaster-clock-quality        ; clock-quality?
   grandmaster-priority2            ; byte
   grandmaster-identity             ; clock-identity?
   steps-removed                    ; uint16
   time-source)                     ; byte
  #:transparent)

(define (parse-announce-body bs hdr)
  (error 'parse-announce-body "not implemented"))

(define (build-announce-msg msg)
  (error 'build-announce-msg "not implemented"))
