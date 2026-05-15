# Roadmap

## Phase 0 — Foundation (current)

- [x] Project restructuring and module layout
- [x] GUI refactored from single file to modular panels
- [x] Protocol type definitions and constants
- [x] i18n (Chinese/English) string table
- [x] Architecture and protocol reference documentation
- [ ] Verify GUI runs correctly after refactor

## Phase 1 — Protocol Layer

- [ ] Implement PTP common header parser/builder
- [ ] Implement Sync message parser/builder
- [ ] Implement Follow_Up message parser/builder (gPTP extended fields)
- [ ] Implement Announce message parser/builder
- [ ] Implement PDelay messages (Req/Resp/Follow_Up)
- [ ] Implement Signalling message parser/builder
- [ ] Implement top-level parser dispatcher
- [ ] Unit tests with handcrafted byte fixtures for each message type

## Phase 2 — Network Layer

- [ ] NIC enumeration (cross-platform)
- [ ] Raw socket FFI bindings (Linux `AF_PACKET`, macOS `AF_NDRV`, Windows Npcap)
- [ ] Packet capture with ethertype 0x88F7 filter
- [ ] Raw Ethernet frame sending
- [ ] Integration test with loopback or test packets

## Phase 3 — Core Engine

- [ ] Runtime state management (thread-safe)
- [ ] PTP interval timers (log₂-based)
- [ ] Sync accuracy statistics (sliding window)
- [ ] Engine: wire together network + protocol + state
- [ ] Debug listen-only mode (passive packet capture + analysis)

## Phase 4 — GUI Panels

- [ ] Monitor panel: real-time offset/delay display
- [ ] Capture panel: packet list with detail view
- [ ] Log panel: scrollable log with severity levels
- [ ] Settings panel: language toggle, NIC selection

## Phase 5 — Polish

- [ ] Sync accuracy charts/graphs
- [ ] Export logs to file
- [ ] Configuration persistence (save/load)
- [ ] Standalone executable packaging per platform
- [ ] Master mode (send Sync/Announce)
- [ ] gPTP BMCA (Best Master Clock Algorithm) visualization
