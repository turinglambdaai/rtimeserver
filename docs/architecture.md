# Architecture

## Layered Design

```
┌─────────────────────────────────────────────────────┐
│                    GUI Layer                         │
│         (Racket/gui — platform-native widgets)       │
│                                                     │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐ │
│  │ Config   │ │ Monitor  │ │ Capture  │ │  Log   │ │
│  │ Panel    │ │ Panel    │ │ Panel    │ │ Panel  │ │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └───┬────┘ │
│       │            │            │            │       │
│  ┌────┴────────────┴────────────┴────────────┴────┐ │
│  │              Main Frame (orchestration)         │ │
│  └─────────────────────┬───────────────────────────┘ │
├────────────────────────┼────────────────────────────-┤
│                   Core Engine                        │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐ │
│  │ State    │ │ Timer    │ │ Stats    │ │ i18n   │ │
│  │ (thread- │ │ (log₂    │ │ (sliding │ │        │ │
│  │  safe)   │ │  interval│ │  window) │ │        │ │
│  └──────────┘ └──────────┘ └──────────┘ └────────┘ │
├────────────────────────┼────────────────────────────-┤
│      Protocol Layer    │      Network Layer          │
│  ┌──────────────────┐  │  ┌──────────────────────┐  │
│  │ Types            │  │  │ Interface (NIC enum)  │  │
│  │ Constants        │  │  │ Socket (raw, FFI)    │  │
│  │ Header parser    │  │  │ Capture (filter PT)  │  │
│  │ Message parsers  │  │  │ Sender (raw frames)  │  │
│  │ Message builders │  │  │                      │  │
│  └──────────────────┘  │  └──────────────────────┘  │
├────────────────────────┼────────────────────────────-┤
│              Hardware / OS                            │
│   NIC → Raw Socket → Ethernet Frame → PTP Payload    │
└─────────────────────────────────────────────────────-┘
```

## Data Flow

### Inbound (Packet Capture)

```
NIC → raw socket → Ethernet frame
                         │
                    filter by ethertype 0x88F7
                         │
                    strip Ethernet header (14 bytes)
                         │
                    parse PTP common header (34 bytes)
                         │
                dispatch by message type byte
                    ╱    ╲      ╲
              Sync  Follow_Up  Announce  PDelay
                │       │        │         │
           parse body fields → typed struct
                              │
                    push to GUI via callback
```

### Outbound (Packet Sending)

```
GUI parameters → engine-config struct
                      │
           build typed message struct
                      │
              serialize to bytes
                      │
         prepend Ethernet header
                      │
              send via raw socket
                      │
                    NIC
```

## Module Dependencies

```
main.rkt
  └── gui/main-frame.rkt
        ├── gui/nav-panel.rkt
        ├── gui/config-panel.rkt
        ├── gui/monitor-panel.rkt
        ├── gui/capture-panel.rkt
        ├── gui/log-panel.rkt
        └── gui/settings-panel.rkt

core/engine.rkt
  ├── core/state.rkt
  ├── core/timer.rkt
  ├── core/stats.rkt
  ├── protocol/parser.rkt
  │     ├── protocol/header.rkt
  │     ├── protocol/sync.rkt
  │     ├── protocol/follow-up.rkt
  │     ├── protocol/announce.rkt
  │     ├── protocol/pdelay.rkt
  │     └── protocol/signalling.rkt
  ├── network/capture.rkt
  ├── network/sender.rkt
  └── network/interface.rkt

protocol/* → protocol/types.rkt, protocol/constants.rkt
network/*  → network/socket.rkt
core/*     → protocol/types.rkt
gui/*      → config.rkt, i18n.rkt
```

## Thread Model

```
Main Thread (GUI event loop)
  ├── User interactions
  └── Callbacks from engine

Engine Thread (started by start-engine)
  ├── Capture thread (reads from NIC)
  │     └── posts captured-packet to async-channel
  ├── Timer threads (Sync/Announce/PDelay intervals)
  └── State updates (semaphore-protected)
```

All shared state in `core/state.rkt` is protected by a semaphore. GUI reads state on timer tick or event callback. Engine threads write state on packet receive.

## Cross-Platform Strategy

| Component  | Linux            | macOS             | Windows           |
|------------|------------------|-------------------|-------------------|
| Raw socket | `AF_PACKET`      | `AF_NDRV` / BPF   | Npcap (`wpcap.dll`) |
| NIC enum   | `getifaddrs`     | `getifaddrs`      | Npcap             |
| Binding    | FFI → libc       | FFI → libc        | FFI → wpcap.dll   |
| GUI        | Racket/Gtk       | Racket/Cocoa      | Racket/Win32      |

The `network/socket.rkt` module encapsulates all platform differences behind a uniform interface.
