# Funcionalidad v1 (Kotlin) — RF Village MX Wardriving

Resumen de la PoC/MVP nativa a preservar en la v2 Flutter. Fuente: módulos `:app` + `:core`.

## Visión general

App Android de wardriving/investigación RF que:

1. Autentica operadores contra una API JWT.
2. Ejecuta una sesión de campo en un **Foreground Service** tipado.
3. Escanea GPS, Wi‑Fi, BLE y LTE (Telephony público, sin AT).
4. Persiste sesiones y muestras en Room.
5. Muestra pines en mapa MapLibre.
6. Exporta CSV (Wigle Wi‑Fi/BLE + LTE), ZIP, Share y Save As (SAF).
7. Sube multipart a la API (deshabilitado por defecto hasta login).

## Pantallas y navegación

Tras autenticación, la ruta inicial es **Live**. Navegación inferior de campo:

| Ruta | Pantalla | Rol |
|------|----------|-----|
| `live` | Live | Controles start/pause/resume/stop, contadores Wi‑Fi/BLE/LTE/GPS |
| `dashboard` | Dashboard | Mapa MapLibre con pines Wi‑Fi / BLE / LTE |
| `sessions` | Sessions | Historial de sesiones, detalle, upload |
| `export` | Export | Generar CSV/ZIP, compartir, guardar |
| `settings` | Settings | Intervalo, toggles scanners, upload, borrar datos |

Pantallas de auth (sin sesión JWT): login, registro, recuperación de contraseña.

## Auth

- **Login** `POST auth/login/`: si el identificador contiene `@` se envía como `email`; si no, como `username`.
- **Register** `POST auth/register/`.
- **Password recovery** `POST auth/password/reset/`.
- Se persiste solo el JWT `access` (EncryptedSharedPreferences). `refresh` se acepta pero no se usa.
- Header: `Authorization: Bearer <access>`.
- Tras el primer login exitoso se puede activar `uploadAfterSession` por defecto (flag one-shot).

## Sesión de campo (FGS)

`WardrivingForegroundService` con acciones:

- `START` — crea o reanuda sesión activa, `startForeground`, loop de muestreo.
- `PAUSE` / `RESUME` — pausa lógica del loop (GPS puede seguir).
- `STOP` — cierra sesión, detiene servicio.

Tipos FGS en Manifest: `location|connectedDevice|dataSync`.

Notificación persistente (canal propio, small icon monocromo). **No** se pide `ACCESS_BACKGROUND_LOCATION` en el MVP: la recolección arranca desde UI visible.

Intervalo por defecto: **20 000 ms** (`sampleIntervalMillis`).

## Escáneres

| Sensor | API v1 | Notas |
|--------|--------|-------|
| GPS | `FusedLocationProviderClient` | Fix más reciente se asocia a muestras RF |
| Wi‑Fi | `WifiManager` | Throttling posible por Android |
| BLE | `BluetoothLeScanner` | MACs pueden ser aleatorias (privacy) |
| LTE | `TelephonyManager` / `CellInfoLte` | Sin comandos AT; campos varían por dispositivo |

### Deduplicación

`DuplicateFilter` con ventana de **20 s**:

- Wi‑Fi: `wifi:<mac>`
- BLE: `ble:<mac>`
- LTE: `lte:<mcc>:<mnc>:<lac>:<cellId>`

## Persistencia local (Room v3)

Cinco tablas:

1. **`wardriving_sessions`** — id, started/ended, status, deviceSource, toggles, uploaded, export path.
2. **`location_samples`** — GPS por sesión (único por sessionId+timestamp).
3. **`wifi_ble_samples`** — WIFI/BLE + coords (único por sessionId+type+mac+timestamp).
4. **`lte_samples`** — celda LTE + coords (único por sessionId+timestamp+mcc+mnc+lac+cellId).
5. **`pending_uploads`** — cola local por sessionId+uploadType; guarda respuesta remota (`remoteId`, `hash_sha256`, etc.).

## Export

- CSV Wi‑Fi/BLE estilo Wigle: `wifi_ble_<session_id>_<timestamp>.csv`
- CSV LTE: `lte_<session_id>_<timestamp>.csv`
- ZIP opcional, Share (FileProvider) y Save As (SAF).
- Ver `docs/CSV_FORMATS.md`.

## Upload

- Multipart: `files` + `device_source`.
- `device_source`: **`wifi_ble_android`** / **`lte_android`** (paridad v1; no cambiar a `*_flutter` salvo que el backend lo exija).
- Éxito: HTTP **201** + body con `hash_sha256` que coincida con SHA-256 local del archivo.
- Pendientes en Room hasta éxito o limpieza futura.

## Settings (DataStore)

- Intervalo de muestreo
- Toggles Wi‑Fi / BLE / LTE
- Upload tras sesión (default false)
- Export CSV local (default true)
- Keep screen awake
- Filtro de sesiones en UI
- Borrar datos locales

## Mapa

MapLibre con `MAPLIBRE_STYLE_URL` desde `.env` (default demotiles). Pines combinados Wi‑Fi/BLE/LTE.

## Gaps conocidos (v1)

- Anonimización SSID/BLE mencionada en README/privacidad: **no implementada** en código.
- Módulo AT modem USB OTG: **solo documentación** (`docs/EXTERNAL_AT_MODEM.md`).
- Sin adaptive icons (solo mipmap densidades).
- Escaneo RF centrado en Android físico (emulador poco útil).

## Fuera de alcance de este repo `wardriving_poc_v2`

Implementación real de escaneo, pantallas pixel-perfect y publicación en store. Aquí solo docs + esqueleto Flutter con stubs/TODOs.
