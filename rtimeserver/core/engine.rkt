#lang racket

(provide (struct-out engine-config)
         (struct-out sync-status)
         start-engine
         send-test-packet)

(struct engine-config
  (interface-name      ; string?
   transport-type      ; symbol? ('ieee802-3 | 'udp-ipv4)
   profile             ; symbol? ('gptp | 'ptpv2)
   domain-number       ; byte?
   announce-interval   ; exact-integer? (log2 seconds)
   sync-interval       ; exact-integer? (log2 seconds)
   work-mode)          ; symbol? ('master | 'slave | 'debug-listen-only)
  #:transparent)

(struct sync-status
  (master-offset       ; exact-integer? (nanoseconds)
   path-delay          ; exact-integer? (nanoseconds)
   neighbor-rate-ratio ; real?
   is-synced?          ; boolean?
   last-sync-time      ; ptp-timestamp?
   port-state)         ; symbol?
  #:transparent)

(define (start-engine config on-status-change on-packet-received on-log-message)
  (error 'start-engine "not implemented"))

(define (send-test-packet config msg-type)
  (error 'send-test-packet "not implemented"))
