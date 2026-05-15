#lang racket/gui

(provide make-settings-panel)

(define (make-settings-panel parent)
  (define panel (new vertical-panel% [parent parent]))
  ;; TODO: implement settings UI
  (new message%
       [parent panel]
       [label "系统设置 - 待实现"]
       [stretchable-width #t])
  panel)
