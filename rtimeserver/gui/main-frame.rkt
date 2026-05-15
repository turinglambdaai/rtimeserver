#lang racket/gui

(require "../config.rkt"
         "../i18n.rkt"
         "nav-panel.rkt"
         "config-panel.rkt"
         "monitor-panel.rkt"
         "log-panel.rkt"
         "settings-panel.rkt")

(provide launch-gui)

(define (launch-gui)
  (define frame
    (new frame%
         [label "rtimeserver - PTP Time Server"]
         [width *window-width*]
         [height *window-height*]
         [style '(no-resize-border)]))

  (define main-panel
    (new horizontal-panel%
         [parent frame]
         [spacing 5]
         [border 5]))

  (define content-panel
    (new vertical-panel%
         [parent main-panel]
         [spacing 5]
         [border 5]))

  ;; Create all content panels
  (define config-panel (make-config-panel content-panel))
  (define monitor-panel (make-monitor-panel content-panel))
  (define log-panel (make-log-panel content-panel))
  (define settings-panel (make-settings-panel content-panel))

  (define content-panels
    (list config-panel monitor-panel log-panel settings-panel))

  ;; Switch panel visibility
  (define (switch-to-panel index)
    (for ([panel content-panels]
          [i (in-naturals)])
      (send panel show (= i index))))

  ;; Create navigation
  (make-nav-panel main-panel switch-to-panel)

  ;; Show first panel
  (switch-to-panel 0)

  (send frame center)
  (send frame show #t))
