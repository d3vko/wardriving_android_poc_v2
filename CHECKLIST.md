# Checklist de paridad v1 → v2

Marcar cada ítem al completar la implementación real en este repo.

## Auth

- [x] Login (username vs email por `@`)
- [x] Register (`password` + `password_confirm`)
- [x] Password recovery
- [x] Persistir JWT `access` en secure storage
- [x] Header `Authorization: Bearer …` en Dio
- [x] `refresh` ignorado hasta endpoint definido
- [x] Activar upload-by-default one-shot tras primer login

## Foreground Service

- [x] Start / pause / resume / stop
- [x] Notificación persistente + canal
- [x] Small icon monocromo
- [x] Tipos Manifest: `location|connectedDevice|dataSync`
- [x] Sin `ACCESS_BACKGROUND_LOCATION`
- [x] `START_STICKY` / reinicio razonable

## Escáneres

- [x] GPS (geolocator / fused equivalent)
- [x] Wi‑Fi vía MethodChannel
- [x] BLE vía flutter_blue_plus (o bridge)
- [x] LTE vía MethodChannel (Telephony)
- [x] Intervalo configurable (default 20 s)
- [x] Toggles Wi‑Fi / BLE / LTE por sesión/settings
- [x] Dedupe 20 s (claves wifi/ble/lte como v1)

## Persistencia (Drift ≈ Room v3)

- [x] `wardriving_sessions`
- [x] `location_samples` (+ índice único)
- [x] `wifi_ble_samples` (+ índice único)
- [x] `lte_samples` (+ índice único)
- [x] `pending_uploads` (único sessionId+uploadType + campos remotos)

## Export

- [x] CSV Wigle Wi‑Fi/BLE (nombre + header)
- [x] CSV LTE (nombre + header)
- [x] ZIP
- [x] Share
- [x] Save As / picker de destino

## Upload

- [x] Multipart `files` + `device_source`
- [x] `device_source=wifi_ble_android` / `lte_android`
- [x] Validar HTTP **201**
- [x] Validar `hash_sha256` coincide con SHA-256 local
- [x] Guardar pending + respuesta remota
- [x] Upload desde detalle de sesión / export

## Mapa

- [x] MapLibre con style URL de `.env`
- [x] Pines Wi‑Fi / BLE / LTE
- [x] Actualización desde samples de sesión

## Settings / datos

- [x] Intervalo, toggles, upload, export local, keep awake
- [x] Filtro de sesiones
- [x] Borrar datos locales
- [ ] (Opcional futuro) anonimizar SSID / BLE — gap v1

## Permisos y UX

- [x] Runtime permissions por API level
- [x] Flujo de denegación / reintento
- [x] Rutas: auth → live; nav live/dashboard/sessions/export/settings
- [x] Accent `#00A676`
- [x] Launcher + adaptive icons documentados/generados
- [x] Iconos de navegación

## Calidad

- [x] Tests unitarios: CSV, dedupe, upload 201+hash, band mapper LTE
- [ ] Device físico (no solo emulador)
- [x] Logs de endpoint upload + `device_source`
