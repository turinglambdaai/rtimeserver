#lang racket

(require "types.rkt"
         "header.rkt")

(provide (struct-out ptp-follow-up-msg)
         parse-follow-up-body
         build-follow-up-msg)

(struct ptp-follow-up-msg
  (header
   precise-origin-timestamp         ; ptp-timestamp?
   cumulative-scaled-rate-offset    ; int64 (gPTP specific)
   gm-time-base-indicator           ; uint16 (gPTP specific)
   scaled-last-gm-phase-change      ; int64 (gPTP specific)
   scaled-last-gm-freq-change)      ; int64 (gPTP specific)
  #:transparent)

(define (parse-follow-up-body bs hdr)
  (error 'parse-follow-up-body "not implemented"))

(define (build-follow-up-msg msg)
  (error 'build-follow-up-msg "not implemented"))
