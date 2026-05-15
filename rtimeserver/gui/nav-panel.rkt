#lang racket/gui

(provide make-nav-panel)

(define (make-nav-panel parent on-switch)
  (define nav-panel
    (new vertical-panel%
         [parent parent]
         [min-width 120]
         [spacing 5]
         [border 5]))

  (define current-selection 0)
  (define nav-buttons '())

  (define (create-nav-button label index)
    (new button%
         [parent nav-panel]
         [label label]
         [min-width 120]
         [min-height 30]
         [stretchable-width #f]
         [stretchable-height #f]
         [callback (lambda (button event)
                     (set! current-selection index)
                     (on-switch index)
                     (update-nav-buttons))]))

  (define (update-nav-buttons)
    (for ([btn nav-buttons]
          [i (in-naturals)])
      (send btn enable (not (= i current-selection)))))

  ;; Create buttons (labels passed in from main-frame via i18n)
  ;; For now, use fixed labels matching original code
  (set! nav-buttons
        (list (create-nav-button "⚙️ 参数设置" 0)
              (create-nav-button "📊 状态监控" 1)
              (create-nav-button "📝 日志统计" 2)
              (create-nav-button "🔧 系统设置" 3)))

  (update-nav-buttons)
  nav-panel)
