# wardriving_poc_v2 — docs + app Flutter v2

Documentación en español y app Android-first para portar **RF Village MX Wardriving** de Kotlin a Flutter.

## Contenido

| Ruta | Descripción |
|------|-------------|
| [FUNCTIONALITY.md](FUNCTIONALITY.md) | Funcionalidad v1 a preservar |
| [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) | Equivalencias Kotlin → Flutter |
| [CHECKLIST.md](CHECKLIST.md) | Paridad feature-by-feature |
| [docs/API_CONTRACT.md](docs/API_CONTRACT.md) | Auth + upload (201 + hash) |
| [docs/CSV_FORMATS.md](docs/CSV_FORMATS.md) | CSV Wigle / LTE |
| [docs/PERMISSIONS.md](docs/PERMISSIONS.md) | Manifest + runtime |
| [docs/NATIVE_BRIDGES.md](docs/NATIVE_BRIDGES.md) | Plugins vs MethodChannel |
| [assets/](assets/) | Launcher, nav, brand |
| [lib/](lib/), [android/](android/), [test/](test/) | App Flutter (MVP implementado) |
| [scripts/prepare_assets.sh](scripts/prepare_assets.sh) | Copia iconos desde v1 |

## Setup rápido

1. Instalar [Flutter](https://docs.flutter.dev/get-started/install) (stable) y JDK 17.
2. Configurar API — editar `.env.example` o copiar a `.env`.
3. Dependencias (desde la raíz del repo):

   ```bash
   flutter pub get
   dart run build_runner build
   dart run flutter_launcher_icons
   flutter analyze
   flutter test
   ```

4. Ejecutar en dispositivo físico:

   ```bash
   flutter run
   ```

## Decisiones fijas

- Android-first, **minSdk 26**, target 34+
- Estado: **Riverpod**; DB: **Drift**; JWT: **flutter_secure_storage**
- FGS: **flutter_foreground_task** + tipos `location|connectedDevice|dataSync`
- Wi‑Fi + Telephony: **MethodChannel** (ver NATIVE_BRIDGES)
- `device_source`: `wifi_ble_android` / `lte_android`
- Accent: `#00A676`

## Nota iOS

El escaneo RF es Android-centric; iOS queda fuera de esta entrega.
