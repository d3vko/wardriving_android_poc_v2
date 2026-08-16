# Puentes nativos (plugins vs MethodChannel)

Guía para implementar scanners en Flutter Android sin reinventar la lógica Kotlin de `:core`.

## Resumen

| Capacidad | Enfoque v2 | Notas |
|-----------|------------|-------|
| GPS | Plugin: `geolocator` / `location` | Equivalente a FusedLocation |
| BLE | Plugin: `flutter_blue_plus` | Revisar permisos API 31+ |
| Wi‑Fi scan | **MethodChannel** | No hay plugin maduro 1:1 con `WifiManager.startScan` |
| LTE / Telephony | **MethodChannel** | Reutilizar `TelephonyScanner` / mappers |
| FGS | `flutter_foreground_task` (+ Manifest tipado) | Verificar soporte de los 3 tipos |
| Mapa | `maplibre_gl` | Style URL desde `.env` |
| Permisos | `permission_handler` | Ver `PERMISSIONS.md` |
| Secure JWT | `flutter_secure_storage` | |
| Settings | `shared_preferences` | |
| Share / files | `share_plus`, `path_provider`, `file_picker`, `archive` | FileProvider en Manifest |
| HTTP | `dio` | |

## MethodChannel propuesto

Nombre sugerido: `com.d3vk0.wardriving/rf_scanners`

### Wi‑Fi

Métodos:

- `wifi.startScan` → dispara scan (respetar throttling Android).
- `wifi.getScanResults` → lista de maps: `bssid`, `ssid`, `capabilities`, `frequency`, `level`, `timestamp`.

Implementación Kotlin: portar/adaptar `core/.../wifi/WifiScanner.kt`.

### LTE

Métodos:

- `telephony.getCellInfo` → lista de maps alineados a columnas LTE CSV / entidad Drift.
- Opcional: `telephony.requestCellInfoUpdate` si se necesita refresh activo.

Implementación: `TelephonyScanner.kt`, `TelephonyMapper.kt`, `LteBandMapper.kt`.

### Contrato de datos (ejemplo)

```json
{
  "bssid": "aa:bb:cc:dd:ee:ff",
  "ssid": "Example",
  "capabilities": "[WPA2-PSK-CCMP]",
  "frequency": 2412,
  "level": -67,
  "timestamp": 1710000000000
}
```

```json
{
  "technology": "LTE",
  "state": "...",
  "mcc": "334",
  "mnc": "020",
  "lac": 12345,
  "cellId": 67890,
  "pci": 100,
  "earfcn": 1850,
  "band": "B3",
  "rssi": -80,
  "rsrp": -100,
  "rsrq": -10,
  "sinr": 5,
  "operator": "…",
  "timestamp": 1710000000000
}
```

## Ubicación del código nativo

Preferible: `android/app/src/main/kotlin/.../scanners/` como plugin embebido, o un plugin local `packages/rf_scanners_android/`.

**No** acoplar el path LTE interno a comandos AT. El módem USB OTG sigue siendo documentación futura (`EXTERNAL_AT_MODEM` en el repo v1).

## Deduplicación

La ventana de 20 s puede vivir en Dart (`DuplicateFilter` port) tras recibir resultados del bridge/plugins — no hace falta en el canal nativo.

## Stubs actuales

En este esqueleto, `features/scanning/` solo declara TODOs e interfaces; **no** hay escaneo real ni MethodChannel registrado aún.
