#lang racket

(require "types.rkt"
         "header.rkt")

(provide (struct-out ptp-signalling-msg)
         parse-signalling-body
         build-signalling-msg)

(struct ptp-signalling-msg
  (header
   target-port-identity     ; port-identity?
   link-delay-interval      ; int8 (log2 seconds)
   time-sync-interval       ; int8
   announce-interval)       ; int8
  #:transparent)

(define (parse-signalling-body bs hdr)
  (error 'parse-signalling-body "not implemented"))

(define (build-signalling-msg msg)
  (error 'build-signalling-msg "not implemented"))
