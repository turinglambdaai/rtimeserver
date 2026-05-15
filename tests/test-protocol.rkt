#lang racket

(require rackunit
         "../rtimeserver/protocol/types.rkt"
         "../rtimeserver/protocol/constants.rkt"
         "../rtimeserver/protocol/header.rkt"
         "../rtimeserver/protocol/sync.rkt"
         "../rtimeserver/protocol/follow-up.rkt"
         "../rtimeserver/protocol/announce.rkt"
         "../rtimeserver/protocol/pdelay.rkt"
         "../rtimeserver/protocol/signalling.rkt"
         "../rtimeserver/protocol/parser.rkt")

;; Test protocol types and constants

(check-equal? (msg-type-value MSG-SYNC) #x0)
(check-equal? (msg-type-value MSG-ANNOUNCE) #xB)
(check-equal? (msg-type-name MSG-FOLLOW-UP) "Follow_Up")

(check-equal? (msg-type-from-byte #x0) MSG-SYNC)
(check-equal? (msg-type-from-byte #xB) MSG-ANNOUNCE)
(check-false (msg-type-from-byte #xFF))

(check-equal? PTP-ETHERTYPE #x88F7)
(check-equal? PTP-COMMON-HEADER-LEN 34)

;; Timestamp conversion round-trip
(define ts (ptp-timestamp 0 1 500000000))
(check-equal? (ptp-timestamp-nanoseconds ts) 500000000)

(define ns (ptp-timestamp->nanoseconds ts))
(define ts2 (nanoseconds->ptp-timestamp ns))
(check-equal? (ptp-timestamp->nanoseconds ts) (ptp-timestamp->nanoseconds ts2))

;; Clock identity from MAC
(define ci (clock-identity-from-mac #"\xAA\xBB\xCC\xDD\xEE\xFF"))
(check-equal? (bytes-length (clock-identity-bytes ci)) 8)
