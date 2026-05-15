#lang racket

(provide (struct-out net-interface)
         enumerate-interfaces
         find-interface-by-name)

(struct net-interface
  (name            ; string? (e.g. "eth0", "Ethernet 2")
   display-name    ; string? (human-friendly)
   mac-address     ; (bytes 6)
   ip-addresses    ; (listof string?)
   is-up?          ; boolean?
   index)          ; exact-nonnegative-integer?
  #:transparent)

(define (enumerate-interfaces)
  (error 'enumerate-interfaces "not implemented"))

(define (find-interface-by-name name)
  (error 'find-interface-by-name "not implemented"))
