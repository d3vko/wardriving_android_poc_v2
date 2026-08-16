# Formatos CSV

Contrato de export idéntico a la v1 Kotlin.

## Timestamps

- `FirstSeen` (Wi‑Fi/BLE) y `Timestamp` (LTE) usan la **hora local del dispositivo** (`yyyy-MM-dd HH:mm:ss`).
- Si el timestamp de la muestra es anterior al inicio de la sesión (p. ej. residual de ms-desde-boot en LTE), se sustituye por `session.startedAt`.
- En captura LTE el timestamp es siempre wall clock del sistema (`System.currentTimeMillis()`), no `CellInfo.timestampMillis`.

## Coordenadas y lecturas no factibles

Si falta GPS válido **o** la lectura RF no es factible, se escriben coordenadas `0.0000000` (lat y lon) para que la plataforma no las procese. Las filas se conservan en el CSV.

| Tecnología | No factible si |
|------------|----------------|
| Wi‑Fi / BLE | MAC vacío, o lat/lon null/NaN/Inf |
| LTE | MCC vacío/`0`, o MNC vacío/`0`, o CellID null/sentinel (`268435455`), o LAC null/sentinel (`65535`), o GPS inválido |

## Wi‑Fi / BLE (estilo Wigle)

Nombre de archivo:

```text
wifi_ble_<session_id>_<timestamp>.csv
```

Header:

```text
MAC,SSID,AuthMode,FirstSeen,Channel,RSSI,CurrentLatitude,CurrentLongitude,AltitudeMeters,AccuracyMeters,Type
```

### Mapeo Wi‑Fi

| Origen | Columna |
|--------|---------|
| BSSID | MAC |
| SSID | SSID |
| capabilities | AuthMode |
| frequency → canal | Channel |
| level | RSSI |
| último fix GPS (o `0.0000000` si inválido) | CurrentLatitude / CurrentLongitude / AltitudeMeters / AccuracyMeters |
| constante | Type = `WIFI` |

### Mapeo BLE

| Origen | Columna |
|--------|---------|
| dirección Bluetooth | MAC |
| nombre o `""` | SSID |
| constante `BLE` | AuthMode |
| vacío (salvo mapper futuro) | Channel |
| ScanResult.rssi | RSSI |
| último fix GPS (o `0.0000000` si inválido) | coordenadas |
| constante | Type = `BLE` |

## LTE

Nombre de archivo:

```text
lte_<session_id>_<timestamp>.csv
```

Header:

```text
Timestamp,Tecnología,TipoCelda,Estado,MCC,MNC,LAC,CellID,eNodeB,Sector,PCI,Banda,EARFCN,FreqDL_MHz,FreqUL_MHz,RSSI,RSRP,RSRQ,SINR,Operador,Longitud,Latitud
```

### Mapeo Telephony Android

| Origen | Columna |
|--------|---------|
| CellInfoLte | Tecnología / TipoCelda = `LTE` |
| cellConnectionStatus | Estado |
| mccString / mncString | MCC / MNC |
| tac | LAC |
| ci | CellID |
| ci / 256 | eNodeB |
| ci % 256 | Sector |
| pci | PCI |
| earfcn + band mapper | EARFCN, Banda, FreqDL_MHz, FreqUL_MHz |
| dbm / rsrp / rsrq / rssnr | RSSI / RSRP / RSRQ / SINR |
| networkOperatorName | Operador |
| último fix GPS (o `0.0000000` si inválido) | Longitud / Latitud |

Valores no disponibles → cadena vacía en el CSV:

- `CellInfo.UNAVAILABLE` / `Int.MAX_VALUE` / `Int.MIN_VALUE`
- TAC sentinel `65535` (16-bit all ones)
- CI sentinel `268435455` (28-bit all ones)

## ZIP

Empaquetar uno o ambos CSV de una sesión. Compartir vía share_plus / FileProvider; guardar con file_picker (SAF).
