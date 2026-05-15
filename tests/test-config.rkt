#lang racket

(require rackunit
         "../rtimeserver/config.rkt")

(check-equal? *app-version* "0.2.0")
(check-equal? *default-profile* 'gptp)
(check-equal? *default-transport* 'ieee802-3)
(check-equal? *default-ptp-domain* 0)
(check-equal? *window-width* 800)
(check-equal? *window-height* 600)
