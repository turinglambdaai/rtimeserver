# rtimeserver

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

gPTP (IEEE 802.1AS) 跨平台调试上位机，基于 [Racket](https://racket-lang.org/) 开发。

## 概述

rtimeserver 是一个面向时间敏感网络（TSN）工程师的 gPTP 调试工具。它提供图形化界面，用于配置 PTP 参数、监控时间同步状态、抓取和分析 PTP 报文，以及查看运行日志和同步精度统计。支持通过真实网卡收发 gPTP/PTP 报文，覆盖 Windows、macOS 和 Linux 平台。

## 功能

- **参数配置** — 工作模式（IEEE 802.3 / UDP IPv4）、Profile（gPTP / PTPv2）、Domain 编号、Announce/Sync 发送周期
- **同步监控** — 实时显示 Master-Slave 同步状态、时钟偏移量、路径延迟、邻居速率比
- **报文分析** — 抓取并解析 PTP 报文（Sync、Follow_Up、Announce、PDelay 等），逐字段展示
- **日志统计** — 运行日志记录、同步精度滑动窗口统计（均值/极值/标准差）

## 架构

```
┌─────────────────────────────────────────┐
│              GUI (Racket/gui)            │
│  ┌────────┬────────┬────────┬─────────┐ │
│  │Config  │Monitor │Capture │  Log     │ │
│  │Panel   │Panel   │Panel   │  Panel   │ │
│  └────────┴────────┴────────┴─────────┘ │
├─────────────────────────────────────────┤
│             Core Engine                 │
│  State · Timer · Stats · i18n          │
├───────────────────┬─────────────────────┤
│    Protocol       │      Network        │
│  Types · Parser   │  Socket · Capture   │
│  Constants        │  Interface · Sender │
└───────────────────┴─────────────────────┘
```

详细架构设计见 [docs/architecture.md](docs/architecture.md)。

## 项目结构

```
rtimeserver/
├── main.rkt               # 入口
├── info.rkt               # 包元数据
├── rtimeserver/
│   ├── config.rkt         # 全局配置
│   ├── i18n.rkt           # 中英双语
│   ├── gui/               # 界面层
│   ├── protocol/          # PTP/gPTP 协议解析
│   ├── network/           # 网络收发
│   └── core/              # 核心引擎
├── tests/                 # 测试
└── docs/                  # 文档
```

## 快速开始

### 前置条件

- [Racket](https://download.racket-lang.org/) 8.x
- Windows: [Npcap](https://npcap.com/)（网络抓包用）
- Linux: `libpcap-dev`
- macOS: 系统自带 libpcap

### 运行

```bash
git clone https://github.com/jrtxio/rtimeserver.git
cd rtimeserver
racket main.rkt
```

### 安装为 Racket 包

```bash
raco pkg install ./rtimeserver
```

### 运行测试

```bash
raco test tests/
```

## 开发

参见 [docs/development.md](docs/development.md) 了解开发环境搭建、模块接口规范和贡献流程。

## 路线图

参见 [docs/roadmap.md](docs/roadmap.md)。

## 许可证

[Apache License 2.0](LICENSE)

---

# rtimeserver

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

A cross-platform gPTP (IEEE 802.1AS) debugging tool built with [Racket](https://racket-lang.org/).

## Overview

rtimeserver is a graphical debugging tool for engineers working with Time-Sensitive Networking (TSN). It provides a GUI for configuring PTP parameters, monitoring time sync status, capturing and analyzing PTP packets, and viewing runtime logs and sync accuracy statistics. It supports sending and receiving real gPTP/PTP packets via network interfaces across Windows, macOS, and Linux.

## Features

- **Parameter Configuration** — Transport mode (IEEE 802.3 / UDP IPv4), Profile (gPTP / PTPv2), Domain number, Announce/Sync intervals
- **Sync Monitoring** — Real-time Master-Slave sync status, clock offset, path delay, neighbor rate ratio
- **Packet Analysis** — Capture and parse PTP packets (Sync, Follow_Up, Announce, PDelay, etc.) with per-field display
- **Logs & Statistics** — Runtime logging, sliding-window sync accuracy stats (mean/min/max/stddev)

## Quick Start

### Prerequisites

- [Racket](https://download.racket-lang.org/) 8.x
- Windows: [Npcap](https://npcap.com/)
- Linux: `libpcap-dev`
- macOS: libpcap (built-in)

### Run

```bash
git clone https://github.com/jrtxio/rtimeserver.git
cd rtimeserver
racket main.rkt
```

### Install as Racket package

```bash
raco pkg install ./rtimeserver
```

### Run tests

```bash
raco test tests/
```

## License

[Apache License 2.0](LICENSE)
