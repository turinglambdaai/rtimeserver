#lang racket

(provide (struct-out ptp-timestamp)
         (struct-out clock-identity)
         (struct-out port-identity)
         (struct-out clock-quality)
         ptp-timestamp->nanoseconds
         nanoseconds->ptp-timestamp
         ptp-timestamp-difference
         clock-identity->string
         clock-identity-from-mac)

;; 48-bit seconds + 32-bit nanoseconds PTP timestamp
(struct ptp-timestamp (seconds-ms seconds-ls nanoseconds) #:transparent)

;; 8-byte clock identity
(struct clock-identity (bytes) #:transparent)

;; Port identity: clock + port number
(struct port-identity (clock-id port-number) #:transparent)

;; Clock quality per IEEE 1588
(struct clock-quality (clock-class clock-accuracy offset-scaled-log-variance) #:transparent)

(define (ptp-timestamp->nanoseconds ts)
  (+ (* (+ (arithmetic-shift (ptp-timestamp-seconds-ms ts) 32)
           (ptp-timestamp-seconds-ls ts))
        1000000000)
     (ptp-timestamp-nanoseconds ts)))

(define (nanoseconds->ptp-timestamp ns)
  (define secs (quotient ns 1000000000))
  (define nsec (remainder ns 1000000000))
  (ptp-timestamp (arithmetic-shift secs -32)
                 (bitwise-and secs #xFFFFFFFF)
                 nsec))

(define (ptp-timestamp-difference ts1 ts2)
  (- (ptp-timestamp->nanoseconds ts1)
     (ptp-timestamp->nanoseconds ts2)))

(define (clock-identity->string ci)
  (string-join
   (for/list ([b (in-bytes (clock-identity-bytes ci))])
     (~a b #:min-width 2 #:pad-string "0" #:align 'right #:base 16))
   ":"))

(define (clock-identity-from-mac mac-bytes)
  (clock-identity (bytes-append mac-bytes #"\xFF\xFE")))
