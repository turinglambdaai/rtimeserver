#lang racket

(provide start-ptp-timer
         reschedule-timer)

(define (start-ptp-timer log2-interval callback-thunk)
  (error 'start-ptp-timer "not implemented"))

(define (reschedule-timer cancel-proc new-log2-interval)
  (error 'reschedule-timer "not implemented"))
