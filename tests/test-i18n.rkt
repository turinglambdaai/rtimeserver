#lang racket

(require rackunit
         "../rtimeserver/i18n.rkt")

;; Default language is Chinese
(check-equal? (current-language) 'zh)
(check-equal? (t 'nav-config) "参数设置")
(check-equal? (t 'config-title) "参数配置")

;; Switch to English
(parameterize ([current-language 'en])
  (check-equal? (t 'nav-config) "Parameters")
  (check-equal? (t 'config-title) "Configuration"))

;; Unknown key returns symbol as string
(check-equal? (t 'nonexistent-key) "nonexistent-key")

;; Plain string passes through
(check-equal? (t "hello") "hello")
