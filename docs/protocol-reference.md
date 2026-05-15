# PTP/gPTP Protocol Reference

## Message Types

Based on IEEE 1588-2008 and IEEE 802.1AS.

| Value | Name                    | Category  | Description                     |
|-------|-------------------------|-----------|---------------------------------|
| 0x0   | Sync                    | Event     | Time sync from master           |
| 0x1   | Delay_Req               | Event     | Delay measurement (not in gPTP) |
| 0x2   | PDelay_Req              | Event     | Peer delay measurement          |
| 0x3   | PDelay_Resp             | Event     | Peer delay response             |
| 0x8   | Follow_Up               | General   | Precise timestamp for Sync      |
| 0x9   | Delay_Resp              | General   | Delay response (not in gPTP)    |
| 0xA   | PDelay_Resp_Follow_Up   | General   | Peer delay follow-up            |
| 0xB   | Announce                | General   | Master clock announcement       |
| 0xC   | Signalling              | General   | Interval negotiation            |
| 0xD   | Management              | General   | Node management                 |

## PTP Common Header (34 bytes)

```
Offset  Size  Field
------  ----  -----
0       1     MessageType (4 bits transport-specific + 4 bits message type)
1       1     PTP Version (always 2)
2       2     Message Length (total PTP message length)
4       1     Domain Number
5       1     Reserved
6       2     Flags (bits: leap61, leap59, currentUTC, ptpTimescale, ...)
8       8     Correction Field (signed nanoseconds)
16      4     Reserved
20      8     Source Port Identity (ClockIdentity + PortNumber)
28      2     Source Port Number (part of above)
30      2     Sequence ID
32      1     Control Field
33      1     Log Message Interval
```

## Ethernet Header (14 bytes)

```
Offset  Size  Field
------  ----  -----
0       6     Destination MAC
6       6     Source MAC
12      2     Ethertype (0x88F7 for PTP)
```

## Sync Message Body (10 bytes after header)

```
Offset  Size  Field
------  ----  -----
34      10    Origin Timestamp (48-bit sec + 32-bit nsec, may be zero)
```

## Follow_Up Message Body (gPTP extended, 28 bytes after header)

```
Offset  Size  Field
------  ----  -----
34      10    Precise Origin Timestamp
44      4     Reserved
48      4     Cumulative Scaled Rate Offset
52      2     GM Time Base Indicator
54      4     Scaled Last GM Phase Change
58      4     Reserved
62      4     Scaled Last GM Frequency Change
```

## Announce Message Body (30 bytes after header)

```
Offset  Size  Field
------  ----  -----
34      2     Current UTC Offset
36      1     Reserved
37      1     Grandmaster Priority1
38      1     Grandmaster Clock Class
39      1     Grandmaster Clock Accuracy
40      2     Grandmaster Offset Scaled Log Variance
42      1     Grandmaster Priority2
43      8     Grandmaster Identity
51      2     Steps Removed
53      1     Time Source
```

## PDelay_Req Message Body (20 bytes after header)

```
Offset  Size  Field
------  ----  -----
34      10    Origin Timestamp (usually zero)
44      10    Reserved
```

## PDelay_Resp Message Body (20 bytes after header)

```
Offset  Size  Field
------  ----  -----
34      10    Request Receipt Timestamp
44      10    Requesting Port Identity
```

## PDelay_Resp_Follow_Up Message Body (20 bytes after header)

```
Offset  Size  Field
------  ----  -----
34      10    Response Origin Timestamp
44      10    Requesting Port Identity
```

## Port States (IEEE 802.1AS)

| Value | State         | Description                       |
|-------|---------------|-----------------------------------|
| 7     | Master        | Port is grandmaster or master     |
| 9     | Slave         | Port synchronizes to master       |
| 11    | Disabled      | Port is disabled                  |
| 13    | Initializing  | Port is initializing              |

## Clock Class Values (IEEE 1588 Table 11)

| Class | Description                                   |
|-------|-----------------------------------------------|
| 6     | Locked to primary reference (e.g. GPS)        |
| 7     | Locked to application-specific source         |
| 13    | Locked to IEEE 1588 grandmaster               |
| 14-52 | Application-specific ranges                   |
| 248   | Default                                       |
| 255   | Slave-only clock                              |
