#!/usr/bin/env bash
# Первичная установка Aedifica.Core на VPS (nginx + systemd).
set -euo pipefail

APP_ROOT="${APP_ROOT:-$HOME/Aedifica.Core}"
PORT="${LOCAL_API_PORT:-84}"

echo "==> Aedifica.Core install at $APP_ROOT (port $PORT)"

echo "==> system packages (libsqlite3)"
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -qq
  sudo apt-get install -y libsqlite3-0 libsqlite3-dev
fi

mkdir -p "$APP_ROOT/deploy/data" "$APP_ROOT/deploy/web"

if [[ -d "$APP_ROOT/local_api" ]]; then
  echo "==> dart pub get (local_api)"
  cd "$APP_ROOT/local_api"
  dart pub get
fi

NGINX_CONF="$APP_ROOT/vps door/Aedifica.Core/nginx/aedificacore.nighttech.ru.conf"
SYSTEMD_UNIT="$APP_ROOT/vps door/Aedifica.Core/systemd/aedificacore.service"

if [[ -f "$NGINX_CONF" ]]; then
  echo "==> nginx site"
  sudo cp "$NGINX_CONF" /etc/nginx/sites-available/aedificacore.nighttech.ru
  sudo ln -sf /etc/nginx/sites-available/aedificacore.nighttech.ru /etc/nginx/sites-enabled/
  sudo nginx -t
  sudo systemctl reload nginx
fi

if [[ -f "$SYSTEMD_UNIT" ]]; then
  echo "==> systemd aedificacore.service"
  sudo cp "$SYSTEMD_UNIT" /etc/systemd/system/aedificacore.service
  sudo systemctl daemon-reload
  sudo systemctl enable aedificacore.service
  sudo systemctl restart aedificacore.service
  sudo systemctl status aedificacore.service --no-pager || true
fi

echo "==> health"
sleep 2
curl -sf "http://127.0.0.1:${PORT}/health" && echo || echo "WARN: health check failed (is dart running?)"

echo "OK. Next: sudo certbot --nginx -d aedificacore.nighttech.ru"
