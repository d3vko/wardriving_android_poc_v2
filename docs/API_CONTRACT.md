# Contrato de API (Flutter v2)

Rutas inyectadas por `.env` / `flutter_dotenv` (equivalente a BuildConfig v1).

## Autenticación

### Login

`POST {API_BASE_URL}{API_LOGIN_PATH}`

Request:

```json
{
  "username": "operator",
  "email": null,
  "password": "secret"
}
```

Si el identificador contiene `@`, enviarlo como `email`; si no, como `username`.

Response:

```json
{
  "refresh": "refresh-token",
  "access": "access-jwt",
  "username": "operator"
}
```

Persistir solo `access` con **flutter_secure_storage**. Enviar:

```http
Authorization: Bearer <access>
```

`refresh` se acepta pero no se usa hasta definir endpoint de refresh.

### Register

`POST {API_BASE_URL}{API_REGISTER_PATH}`

```json
{
  "username": "operator",
  "email": "operator@example.com",
  "password": "secret",
  "password_confirm": "secret"
}
```

Misma forma de respuesta que login; persistir solo `access`.

### Recuperación de contraseña

`POST {API_BASE_URL}{API_PASSWORD_RECOVERY_PATH}`

```json
{
  "username": "operator",
  "email": null
}
```

## Upload

`POST {API_BASE_URL}{API_UPLOAD_PATH}`

Ejemplo resuelto:

```http
POST https://wardriving-ctf.rf-village-mx.com/wardriving/api/v1/files-uploaded/
```

Multipart form-data:

| Parte | Valor |
|-------|--------|
| `files` | uno o más CSV |
| `device_source` | `wifi_ble_android` o `lte_android` |

**Paridad v1:** usar exactamente esos strings (no `*_flutter` por defecto).

### Validación de éxito (obligatoria)

1. Código HTTP **201** (200 u otros no bastan).
2. Body lista de archivos remotos con `hash_sha256` (y campos como `id`, `source`, `is_procesed` según backend).
3. Al menos un `hash_sha256` debe coincidir (case-insensitive) con el SHA-256 del archivo local enviado.
4. Persistir en `pending_uploads`: `remoteId`, `remoteSource`, `remoteHashSha256`, `isProcessed`, `responseReceivedAt`, `uploadedAt`.

Los CSV temporales no se borran hasta éxito o un flujo futuro de limpieza confirmada por el usuario.

## Variables de entorno

Ver `.env.example` en la raíz del repo. Claves: `API_BASE_URL`, `API_LOGIN_PATH`, `API_REGISTER_PATH`, `API_PASSWORD_RECOVERY_PATH`, `API_UPLOAD_PATH`, `API_UPLOAD_TYPE_WIFI_BLE`, `API_UPLOAD_TYPE_LTE`.
