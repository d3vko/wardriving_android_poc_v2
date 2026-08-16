# Permisos (Flutter / Android)

La app solicita permisos según versión de Android y scanners habilitados.

La ubicación es obligatoria porque: resultados Wi‑Fi/BLE son location-derived, el GPS geoposiciona muestras, y LTE necesita coordenadas.

## Declarados en Manifest

- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
- `FOREGROUND_SERVICE`
- `FOREGROUND_SERVICE_LOCATION`
- `FOREGROUND_SERVICE_CONNECTED_DEVICE`
- `FOREGROUND_SERVICE_DATA_SYNC`
- `BLUETOOTH_SCAN`
- `BLUETOOTH_CONNECT`
- `ACCESS_WIFI_STATE`
- `CHANGE_WIFI_STATE`
- `NEARBY_WIFI_DEVICES`
- `READ_PHONE_STATE`
- `ACCESS_NETWORK_STATE`
- `INTERNET`
- `POST_NOTIFICATIONS`

Feature opcional: `android.hardware.bluetooth_le` (`required=false`).

## Runtime (paridad `WardrivingPermissions`)

Siempre:

- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
- `ACCESS_WIFI_STATE`
- `READ_PHONE_STATE`

API 31+ (S):

- `BLUETOOTH_SCAN`
- `BLUETOOTH_CONNECT`

API 33+ (Tiramisu):

- `NEARBY_WIFI_DEVICES`
- `POST_NOTIFICATIONS`

## No solicitar en MVP

`ACCESS_BACKGROUND_LOCATION` — la recolección inicia desde UI visible y continúa con FGS + notificación persistente.

## Flutter

Usar **permission_handler**. Solicitar el conjunto faltante antes de `start` de sesión. Si faltan permisos, no arrancar el FGS.

## Play Store (futuro)

Si se publica, Google Play puede exigir justificación de ubicación en segundo plano; el diseño actual evita background location explícito.
