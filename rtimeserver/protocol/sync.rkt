#lang racket

(require "types.rkt"
         "header.rkt")

(provide (struct-out ptp-sync-msg)
         parse-sync-body
         build-sync-msg)

(struct ptp-sync-msg (header origin-timestamp) #:transparent)

(define (parse-sync-body bs hdr)
  (error 'parse-sync-body "not implemented"))

(define (build-sync-msg msg)
  (error 'build-sync-msg "not implemented"))
