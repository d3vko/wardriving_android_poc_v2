# Guía de migración Kotlin/Android → Flutter

Equivalencias y decisiones fijas para la v2 en este repo. Estado por defecto: **Riverpod** + **Drift**.

## Tabla de equivalencias

| Android v1 | Flutter v2 |
|---|---|
| Jetpack Compose + Hilt + ViewModel | Widgets + **Riverpod** |
| Room | **Drift** |
| EncryptedSharedPreferences (JWT) | **flutter_secure_storage** |
| DataStore Preferences | **shared_preferences** (o Hive si se necesita más estructura) |
| ForegroundService tipado | **flutter_foreground_task** + tipos en `AndroidManifest.xml` |
| MapLibre `AndroidView` | **maplibre_gl** |
| FileProvider + SAF | **path_provider** + **share_plus** + **file_picker** |
| Retrofit / OkHttp | **dio** |
| BuildConfig / `.env` Gradle | **flutter_dotenv** + opcional `--dart-define` |
| Coroutines / Flow | `async` / `Stream` / Riverpod `AsyncNotifier` |
| Módulo `:core` vs `:app` | `lib/core/` vs `lib/features/*/…` (data/domain/presentation) |

## Arquitectura sugerida

Feature-first bajo `lib/features/`, con capas internas:

```text
features/<nombre>/
  data/          # repos, datasources, DTOs
  domain/        # modelos puros, casos de uso
  presentation/  # pantallas, providers Riverpod
```

Espejo de `:core` (escaneo, CSV, DB, API) → `lib/core/` + `features/scanning/`.
Espejo de `:app` (UI, FGS orchestration, nav) → features de UI + `features/scanning/`.

## Iconos y marca

### Launcher

La v1 solo tiene `mipmap-*/ic_launcher.png` (sin adaptive icon).

En Flutter:

1. Usar PNGs en `assets/icons/launcher/` (copiados por `scripts/prepare_assets.sh`).
2. Generar adaptive icons con [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons):

```yaml
# pubspec.yaml (dev_dependency + config)
flutter_launcher_icons:
  android: true
  image_path: "assets/brand/icon_app.png"
  adaptive_icon_background: "#101820"
  adaptive_icon_foreground: "assets/brand/icon_app.png"
```

Luego: `dart run flutter_launcher_icons`.

### Notificación (small icon)

Debe ser **monocromo** (silueta blanca sobre transparente). Fuente v1: vector `ic_app_logo.xml` (ondas + mástil en `#00A676` / blanco). En Flutter/Android, el small icon de la notificación FGS debe ir en `android/app/src/main/res/drawable/` como vector o PNG blanco.

### Navegación

PNGs de tabs: `live`, `dashboard`, `sessions`, `export`, `settings` en `assets/icons/nav/` (también en `media/`).

### Tema

Accent fijo: **`#00A676`**. Secundarios v1: light `#006D77` / `#264653`; dark `#83C5BE` / `#A8DADC`.

## Permisos runtime por API level

Alinear con `WardrivingPermissions` v1:

| Permiso | Desde |
|---------|-------|
| `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` | siempre |
| `ACCESS_WIFI_STATE`, `READ_PHONE_STATE` | siempre (declarados; Wi‑Fi scan vía bridge) |
| `BLUETOOTH_SCAN`, `BLUETOOTH_CONNECT` | API 31+ |
| `NEARBY_WIFI_DEVICES`, `POST_NOTIFICATIONS` | API 33+ |

No solicitar `ACCESS_BACKGROUND_LOCATION` en la paridad MVP.

Usar **permission_handler** + checklist en `docs/PERMISSIONS.md`.

## Foreground Service

1. Declarar permisos `FOREGROUND_SERVICE*` y `foregroundServiceType="location|connectedDevice|dataSync"`.
2. Integrar **flutter_foreground_task** (o servicio Kotlin propio si el plugin no cubre los tres tipos).
3. Notificación persistente visible mientras corre la sesión.
4. Comandos: start / pause / resume / stop (paridad con intents del FGS v1).

## Puentes nativos

Ver `docs/NATIVE_BRIDGES.md`:

- **BLE / GPS / permisos / FGS / mapa / storage**: plugins maduros.
- **Wi‑Fi scan** y **Telephony/LTE**: **MethodChannel** (plugin Kotlin local reutilizando `WifiScanner.kt` / `TelephonyScanner.kt`).

## device_source

Mantener strings de upload:

- `wifi_ble_android`
- `lte_android`

Solo introducir `*_flutter` si el backend lo exige explícitamente.

## Configuración

Copiar `.env.example` → `.env` en la raíz del repo. Cargar con `flutter_dotenv` en bootstrap. Valores críticos: `API_*`, `APP_ACCENT_COLOR`, `MAPLIBRE_STYLE_URL`.

## iOS (nota mínima)

El escaneo RF (Wi‑Fi/Telephony) es **Android-centric**. iOS queda fuera de esta entrega; no hay paridad de scanners internos.

## Orden de implementación recomendado (v2)

1. Env + tema + routing stub
2. Auth + secure storage
3. Drift schema (5 tablas)
4. Permisos + FGS vacío
5. MethodChannels Wi‑Fi/LTE + plugins GPS/BLE
6. Loop de sesión + dedupe 20 s
7. Export CSV/ZIP + share
8. Upload 201+hash
9. Mapa pines
10. Settings + delete data
