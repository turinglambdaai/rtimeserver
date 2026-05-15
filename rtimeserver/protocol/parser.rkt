#lang racket

(require "types.rkt"
         "constants.rkt"
         "header.rkt"
         "sync.rkt"
         "follow-up.rkt"
         "announce.rkt"
         "pdelay.rkt"
         "signalling.rkt")

(provide ptp-message?
         parse-ptp-message
         build-ptp-message)

(define (ptp-message? v)
  (or (ptp-sync-msg? v)
      (ptp-follow-up-msg? v)
      (ptp-announce-msg? v)
      (ptp-pdelay-req-msg? v)
      (ptp-pdelay-resp-msg? v)
      (ptp-pdelay-resp-follow-up-msg? v)
      (ptp-signalling-msg? v)))

(define (parse-ptp-message bs)
  (error 'parse-ptp-message "not implemented"))

(define (build-ptp-message msg)
  (error 'build-ptp-message "not implemented"))
