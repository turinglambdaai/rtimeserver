#lang racket/gui

(provide make-log-panel)

(define (make-log-panel parent)
  (define panel (new vertical-pane% [parent parent]))
  ;; TODO: implement log & statistics UI
  (new message%
       [parent panel]
       [label "日志统计 - 待实现"]
       [stretchable-width #t])
  panel)
