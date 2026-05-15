#lang racket

(provide current-language
         t
         supported-languages)

(define current-language (make-parameter 'zh))

(define supported-languages '(zh en))

(define *string-table*
  (hasheq
   ;; Navigation
   'nav-config        (cons "参数设置"       "Parameters")
   'nav-monitor       (cons "状态监控"       "Monitor")
   'nav-capture       (cons "报文分析"       "Capture")
   'nav-log           (cons "日志统计"       "Logs")
   'nav-settings      (cons "系统设置"       "Settings")

   ;; Config panel
   'config-title      (cons "参数配置"       "Configuration")
   'config-transport  (cons "工作模式配置:"  "Transport:")
   'config-profile    (cons "Profile:"       "Profile:")
   'config-domain     (cons "Domain编号:"    "Domain:")
   'config-announce   (cons "Announce发送周期:" "Announce Interval:")

   ;; Transport choices
   'transport-ieee    (cons "IEEE802.3"      "IEEE 802.3")
   'transport-udp     (cons "UDPV4"          "UDP/IPv4")
   'transport-both    (cons "UDPV4+IEEE802.3" "UDP/IPv4 + IEEE 802.3")

   ;; Profile choices
   'profile-ptpv2     (cons "PTPV2"          "PTPv2")
   'profile-gptp      (cons "gPTP"           "gPTP")

   ;; Monitor panel
   'monitor-title     (cons "同步状态监控"    "Sync Monitor")
   'monitor-offset    (cons "主从偏移:"       "Master Offset:")
   'monitor-delay     (cons "路径延迟:"       "Path Delay:")
   'monitor-rate      (cons "邻居速率比:"     "Neighbor Rate Ratio:")
   'monitor-state     (cons "端口状态:"       "Port State:")
   'monitor-synced    (cons "已同步"          "Synced")
   'monitor-unsynced  (cons "未同步"          "Unsynced")

   ;; Capture panel
   'capture-title     (cons "报文抓取与分析"  "Packet Capture & Analysis")
   'capture-start     (cons "开始抓包"        "Start Capture")
   'capture-stop      (cons "停止抓包"        "Stop Capture")
   'capture-clear     (cons "清空"            "Clear")

   ;; Log panel
   'log-title         (cons "运行日志"        "Runtime Logs")
   'log-clear         (cons "清空日志"        "Clear Logs")

   ;; Settings panel
   'settings-title    (cons "系统设置"        "Settings")
   'settings-language (cons "界面语言:"       "Language:")
   'settings-nic      (cons "网络接口:"       "Network Interface:")
   'settings-lang-zh  (cons "中文"            "Chinese")
   'settings-lang-en  (cons "English"         "English")

   ;; Common
   'btn-start         (cons "启动"            "Start")
   'btn-stop          (cons "停止"            "Stop")
   'btn-apply         (cons "应用"            "Apply")
   'unit-ns           (cons "ns"              "ns")
   'unit-sec          (cons "秒"              "sec")
   'unit-log2         (cons "(log₂ 秒)"      "(log₂ sec)")))

(define (t key)
  (if (symbol? key)
      (let ([entry (hash-ref *string-table* key #f)])
        (if entry
            (if (eq? (current-language) 'zh)
                (car entry)
                (cdr entry))
            (symbol->string key)))
      key))
