#lang racket

(provide *app-version*
         *default-ptp-domain*
         *default-announce-interval*
         *default-sync-interval*
         *default-profile*
         *default-transport*
         *default-language*
         *window-width*
         *window-height*
         load-config-from-file
         save-config-to-file)

(define *app-version* "0.2.0")

(define *default-ptp-domain* 0)
(define *default-announce-interval* 1)   ; log2 seconds
(define *default-sync-interval* -3)      ; log2 seconds (125ms for gPTP)
(define *default-profile* 'gptp)         ; 'gptp or 'ptpv2
(define *default-transport* 'ieee802-3)  ; 'ieee802-3 | 'udp-ipv4 | 'both
(define *default-language* 'zh)          ; 'zh or 'en

(define *window-width* 800)
(define *window-height* 600)

(define (load-config-from-file path)
  (hash))

(define (save-config-to-file config path)
  (void))
