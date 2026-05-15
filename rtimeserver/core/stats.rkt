#lang racket

(require "../protocol/types.rkt")

(provide (struct-out sync-stats)
         make-stats-collector
         stats-collector?
         stats-add-sample!
         stats-get-report
         stats-reset!
         stats-offset-history
         stats-delay-history)

(struct sync-stats
  (sample-count        ; exact-nonnegative-integer?
   mean-offset-ns      ; real?
   max-offset-ns       ; exact-integer?
   min-offset-ns       ; exact-integer?
   std-dev-offset-ns   ; real?
   mean-delay-ns       ; real?
   max-delay-ns        ; exact-integer?
   min-delay-ns        ; exact-integer?
   window-start        ; ptp-timestamp?
   window-end)         ; ptp-timestamp?
  #:transparent)

(struct stats-collector
  ([window-size #:mutable]
   [offsets #:mutable]  ; (listof exact-integer?)
   [delays #:mutable])  ; (listof exact-integer?)
  #:transparent)

(define (make-stats-collector window-size)
  (stats-collector window-size '() '()))

(define (stats-add-sample! collector offset-ns delay-ns)
  (error 'stats-add-sample! "not implemented"))

(define (stats-get-report collector)
  (error 'stats-get-report "not implemented"))

(define (stats-reset! collector)
  (set-stats-collector-offsets! collector '())
  (set-stats-collector-delays! collector '()))

(define (stats-offset-history collector)
  (stats-collector-offsets collector))

(define (stats-delay-history collector)
  (stats-collector-delays collector))
