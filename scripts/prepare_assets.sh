#!/usr/bin/env bash
# Copia iconos y brand desde la app Kotlin v1 hacia assets/ de este repo.
# Ejecutar desde la raíz del repo o desde scripts/.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MF_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$MF_ROOT/../wardriving_poc_v1_android" && pwd)"

RES="$REPO_ROOT/app/src/main/res"
MEDIA="$REPO_ROOT/media"
ICONS="$MF_ROOT/assets/icons"
BRAND="$MF_ROOT/assets/brand"

mkdir -p \
  "$ICONS/launcher/mdpi" \
  "$ICONS/launcher/hdpi" \
  "$ICONS/launcher/xhdpi" \
  "$ICONS/launcher/xxhdpi" \
  "$ICONS/launcher/xxxhdpi" \
  "$ICONS/nav" \
  "$ICONS/notification" \
  "$BRAND"

echo "==> Launcher mipmap densidades"
for density in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
  src="$RES/mipmap-${density}/ic_launcher.png"
  if [[ -f "$src" ]]; then
    cp -f "$src" "$ICONS/launcher/${density}/ic_launcher.png"
    echo "  copied $density"
  else
    echo "  WARN: missing $src" >&2
  fi
done

echo "==> Nav icons (drawable + media)"
for name in live dashboard sessions export settings; do
  if [[ -f "$RES/drawable/${name}.png" ]]; then
    cp -f "$RES/drawable/${name}.png" "$ICONS/nav/${name}.png"
  elif [[ -f "$MEDIA/${name}.png" ]]; then
    cp -f "$MEDIA/${name}.png" "$ICONS/nav/${name}.png"
  else
    echo "  WARN: missing nav icon $name" >&2
  fi
done

echo "==> Brand / notification sources"
if [[ -f "$MEDIA/icon_app.png" ]]; then
  cp -f "$MEDIA/icon_app.png" "$BRAND/icon_app.png"
fi
if [[ -f "$RES/drawable/ic_app_logo.xml" ]]; then
  cp -f "$RES/drawable/ic_app_logo.xml" "$ICONS/notification/ic_app_logo.xml"
  cp -f "$RES/drawable/ic_app_logo.xml" "$BRAND/ic_app_logo.xml"
fi

# También sincronizar a android/app/src/main/res del esqueleto Flutter si existe
FLUTTER_RES="$MF_ROOT/android/app/src/main/res"
if [[ -d "$MF_ROOT/android" ]]; then
  echo "==> Sync launcher + notification into android/app res"
  for density in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
    mkdir -p "$FLUTTER_RES/mipmap-${density}"
    if [[ -f "$ICONS/launcher/${density}/ic_launcher.png" ]]; then
      cp -f "$ICONS/launcher/${density}/ic_launcher.png" \
        "$FLUTTER_RES/mipmap-${density}/ic_launcher.png"
    fi
  done
  mkdir -p "$FLUTTER_RES/drawable"
  if [[ -f "$ICONS/notification/ic_app_logo.xml" ]]; then
    cp -f "$ICONS/notification/ic_app_logo.xml" "$FLUTTER_RES/drawable/ic_app_logo.xml"
  fi
fi

echo "Listo. Adaptive icons: configurar flutter_launcher_icons con assets/brand/icon_app.png (ver MIGRATION_GUIDE.md)."
