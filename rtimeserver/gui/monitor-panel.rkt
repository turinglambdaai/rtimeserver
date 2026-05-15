#lang racket/gui

(provide make-monitor-panel)

(define (make-monitor-panel parent)
  (define panel (new vertical-pane% [parent parent]))
  ;; TODO: implement sync monitoring UI
  (new message%
       [parent panel]
       [label "状态监控 - 待实现"]
       [stretchable-width #t])
  panel)
