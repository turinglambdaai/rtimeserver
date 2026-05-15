#lang racket/gui

(provide make-config-panel)

(define (make-config-panel parent)
  (define panel (new vertical-pane% [parent parent]))

  (define *input-width* 180)

  (define main-config-group
    (new group-box-panel%
         [label "参数配置"]
         [parent panel]
         [stretchable-height #f]
         [spacing 5]))

  ;; row1: transport + profile
  (define row1
    (new horizontal-panel%
         [parent main-config-group]
         [stretchable-height #f]
         [spacing 40]))

  (define left-panel1
    (new horizontal-panel% [parent row1] [stretchable-width #t] [spacing 0]))
  (new message%
       [parent left-panel1]
       [label "工作模式配置:"]
       [stretchable-width #f])
  (define work-mode-choice
    (new choice%
         [label " "]
         [choices '("IEEE802.3" "UDPV4" "UDPV4+IEEE802.3")]
         [parent left-panel1]
         [selection 0]
         [min-width *input-width*]
         [stretchable-width #f]))

  (define right-panel1
    (new horizontal-panel% [parent row1] [stretchable-width #t] [spacing 0]))
  (new message%
       [parent right-panel1]
       [label "Profile:"]
       [stretchable-width #f])
  (define profile-choice
    (new choice%
         [label ""]
         [choices '("PTPV2" "gPTP")]
         [parent right-panel1]
         [selection 1]
         [min-width *input-width*]
         [stretchable-width #f]))

  ;; row2: domain + announce interval
  (define row2
    (new horizontal-panel%
         [parent main-config-group]
         [stretchable-height #f]
         [spacing 40]))

  (define left-panel2
    (new horizontal-panel% [parent row2] [stretchable-width #t] [spacing 0]))
  (new message%
       [parent left-panel2]
       [label "Domain编号:"]
       [stretchable-width #f])
  (define domain-field
    (new text-field%
         [label ""]
         [parent left-panel2]
         [min-width *input-width*]
         [init-value "0"]))

  (define right-panel2
    (new horizontal-panel% [parent row2] [stretchable-width #t] [spacing 0]))
  (new message%
       [parent right-panel2]
       [label "Announce发送周期:"]
       [stretchable-width #f])
  (define announce-field
    (new text-field%
         [label ""]
         [parent right-panel2]
         [min-width *input-width*]
         [init-value "1"]))

  panel)
