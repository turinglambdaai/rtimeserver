#lang racket

(provide socket-handle?
         open-raw-socket
         close-raw-socket
         raw-socket-send
         raw-socket-receive)

(struct socket-handle (fd interface-name) #:transparent)

(define (open-raw-socket interface-name)
  (error 'open-raw-socket "not implemented"))

(define (close-raw-socket handle)
  (error 'close-raw-socket "not implemented"))

(define (raw-socket-send handle data)
  (error 'raw-socket-send "not implemented"))

(define (raw-socket-receive handle)
  (error 'raw-socket-receive "not implemented"))
