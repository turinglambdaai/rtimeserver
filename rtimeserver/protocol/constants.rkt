#lang racket

(provide ;; Ethertype
         PTP-ETHERTYPE
         ETHERNET-HEADER-LEN

         ;; PTP version
         PTP-VERSION
         PTP-COMMON-HEADER-LEN

         ;; Message type enum
         (struct-out msg-type)
         MSG-SYNC
         MSG-DELAY-REQ
         MSG-PDELAY-REQ
         MSG-PDELAY-RESP
         MSG-FOLLOW-UP
         MSG-DELAY-RESP
         MSG-PDELAY-RESP-FOLLOW-UP
         MSG-ANNOUNCE
         MSG-SIGNALLING
         MSG-MANAGEMENT
         msg-type-from-byte

         ;; Port state (IEEE 802.1AS)
         PORT-MASTER
         PORT-SLAVE
         PORT-DISABLED
         PORT-INITIALIZING

         ;; Header field offsets
         HDR-OFFSET-MSG-TYPE
         HDR-OFFSET-VERSION
         HDR-OFFSET-MSG-LENGTH
         HDR-OFFSET-DOMAIN
         HDR-OFFSET-FLAGS
         HDR-OFFSET-CORRECTION
         HDR-OFFSET-SOURCE-CLOCK
         HDR-OFFSET-SOURCE-PORT
         HDR-OFFSET-SEQUENCE-ID
         HDR-OFFSET-CONTROL
         HDR-OFFSET-LOG-INTERVAL

         ;; Profiles
         PROFILE-PTPV2
         PROFILE-GPTP)

;; ============================================================
;; Ethertype
;; ============================================================

(define PTP-ETHERTYPE #x88F7)
(define ETHERNET-HEADER-LEN 14)

;; ============================================================
;; PTP common header
;; ============================================================

(define PTP-VERSION 2)
(define PTP-COMMON-HEADER-LEN 34)

;; ============================================================
;; Message types (IEEE 1588-2008 Clause 13.3.2.2)
;; ============================================================

(struct msg-type (value name) #:transparent)

(define MSG-SYNC                 (msg-type #x0 "Sync"))
(define MSG-DELAY-REQ            (msg-type #x1 "Delay_Req"))
(define MSG-PDELAY-REQ           (msg-type #x2 "PDelay_Req"))
(define MSG-PDELAY-RESP          (msg-type #x3 "PDelay_Resp"))
(define MSG-FOLLOW-UP            (msg-type #x8 "Follow_Up"))
(define MSG-DELAY-RESP           (msg-type #x9 "Delay_Resp"))
(define MSG-PDELAY-RESP-FOLLOW-UP (msg-type #xA "PDelay_Resp_Follow_Up"))
(define MSG-ANNOUNCE             (msg-type #xB "Announce"))
(define MSG-SIGNALLING           (msg-type #xC "Signalling"))
(define MSG-MANAGEMENT           (msg-type #xD "Management"))

(define *msg-type-table*
  (hasheq #x0 MSG-SYNC
          #x1 MSG-DELAY-REQ
          #x2 MSG-PDELAY-REQ
          #x3 MSG-PDELAY-RESP
          #x8 MSG-FOLLOW-UP
          #x9 MSG-DELAY-RESP
          #xA MSG-PDELAY-RESP-FOLLOW-UP
          #xB MSG-ANNOUNCE
          #xC MSG-SIGNALLING
          #xD MSG-MANAGEMENT))

(define (msg-type-from-byte b)
  (hash-ref *msg-type-table* (bitwise-and b #xF) #f))

;; ============================================================
;; Port states (IEEE 802.1AS Table 10-4)
;; ============================================================

(define PORT-MASTER        7)
(define PORT-SLAVE         9)
(define PORT-DISABLED      11)
(define PORT-INITIALIZING  13)

;; ============================================================
;; PTP header field offsets
;; ============================================================

(define HDR-OFFSET-MSG-TYPE      0)
(define HDR-OFFSET-VERSION       1)
(define HDR-OFFSET-MSG-LENGTH    2)
(define HDR-OFFSET-DOMAIN        4)
(define HDR-OFFSET-FLAGS         6)
(define HDR-OFFSET-CORRECTION    8)
(define HDR-OFFSET-SOURCE-CLOCK  20)
(define HDR-OFFSET-SOURCE-PORT   28)
(define HDR-OFFSET-SEQUENCE-ID   30)
(define HDR-OFFSET-CONTROL       32)
(define HDR-OFFSET-LOG-INTERVAL  33)

;; ============================================================
;; Profiles
;; ============================================================

(define PROFILE-PTPV2 'ptpv2)
(define PROFILE-GPTP  'gptp)
