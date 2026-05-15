#lang racket

(require "types.rkt"
         "header.rkt")

(provide (struct-out ptp-pdelay-req-msg)
         (struct-out ptp-pdelay-resp-msg)
         (struct-out ptp-pdelay-resp-follow-up-msg)
         parse-pdelay-req-body
         parse-pdelay-resp-body
         parse-pdelay-resp-followup-body
         build-pdelay-req-msg
         build-pdelay-resp-msg
         build-pdelay-resp-followup-msg)

(struct ptp-pdelay-req-msg (header origin-timestamp) #:transparent)

(struct ptp-pdelay-resp-msg
  (header request-receipt-timestamp requesting-port-identity)
  #:transparent)

(struct ptp-pdelay-resp-follow-up-msg
  (header response-origin-timestamp requesting-port-identity)
  #:transparent)

(define (parse-pdelay-req-body bs hdr)
  (error 'parse-pdelay-req-body "not implemented"))

(define (parse-pdelay-resp-body bs hdr)
  (error 'parse-pdelay-resp-body "not implemented"))

(define (parse-pdelay-resp-followup-body bs hdr)
  (error 'parse-pdelay-resp-followup-body "not implemented"))

(define (build-pdelay-req-msg msg)
  (error 'build-pdelay-req-msg "not implemented"))

(define (build-pdelay-resp-msg msg)
  (error 'build-pdelay-resp-msg "not implemented"))

(define (build-pdelay-resp-followup-msg msg)
  (error 'build-pdelay-resp-followup-msg "not implemented"))
