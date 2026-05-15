#lang racket

(provide make-runtime-state
         runtime-state?
         runtime-state-port-state
         runtime-state-set-port-state!
         runtime-state-master-offset
         runtime-state-set-master-offset!
         runtime-state-path-delay
         runtime-state-set-path-delay!
         runtime-state-sequence-id
         runtime-state-next-sequence-id!
         runtime-state-sync-count
         runtime-state-incr-sync-count!
         runtime-state-reset!)

(struct runtime-state
  (sema                              ; semaphore for thread safety
   [port-state #:mutable]            ; symbol?
   [master-offset #:mutable]         ; exact-integer?
   [path-delay #:mutable]            ; exact-integer?
   [sequence-id #:mutable]           ; exact-nonnegative-integer?
   [sync-count #:mutable])           ; exact-nonnegative-integer?
  #:transparent)

(define (make-runtime-state)
  (runtime-state (make-semaphore 1)
                 'initializing
                 0
                 0
                 0
                 0))

(define (runtime-state-set-port-state! rs val)
  (call-with-semaphore (runtime-state-sema rs)
    (lambda () (set-runtime-state-port-state! rs val))))

(define (runtime-state-set-master-offset! rs val)
  (call-with-semaphore (runtime-state-sema rs)
    (lambda () (set-runtime-state-master-offset! rs val))))

(define (runtime-state-set-path-delay! rs val)
  (call-with-semaphore (runtime-state-sema rs)
    (lambda () (set-runtime-state-path-delay! rs val))))

(define (runtime-state-next-sequence-id! rs)
  (call-with-semaphore (runtime-state-sema rs)
    (lambda ()
      (let ([id (runtime-state-sequence-id rs)])
        (set-runtime-state-sequence-id! rs (modulo (+ id 1) 65536))
        id))))

(define (runtime-state-incr-sync-count! rs)
  (call-with-semaphore (runtime-state-sema rs)
    (lambda () (set-runtime-state-sync-count! rs (+ 1 (runtime-state-sync-count rs))))))

(define (runtime-state-reset! rs)
  (call-with-semaphore (runtime-state-sema rs)
    (lambda ()
      (set-runtime-state-port-state! rs 'initializing)
      (set-runtime-state-master-offset! rs 0)
      (set-runtime-state-path-delay! rs 0)
      (set-runtime-state-sequence-id! rs 0)
      (set-runtime-state-sync-count! rs 0))))
