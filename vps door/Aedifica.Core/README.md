# Aedifica.Core на VPS (aedificacore.nighttech.ru)

Браузерная версия с **общими данными** на сервере: Flutter web + `local_api` (SQLite) на порту **84**, nginx + HTTPS.

## Структура на сервере

```
/home/infinity/Aedifica.Core/
├── deploy/
│   ├── web/          ← Flutter web (index.html, main.dart.js, …)
│   └── data/         ← aedifica.core.sqlite + attachments/ (не перезаписывать!)
├── local_api/        ← Dart HTTP-сервер
└── vps door/         ← этот каталог (конфиги nginx/systemd)
```

На VPS каталог лежит **рядом** с `Wealth`, `BoardGames`, `Sputnik`, `TG bot my channel` и др.

## Порты

| Порт | Назначение |
|------|------------|
| **84** | `local_api` (только 127.0.0.1) |
| **443** | nginx → HTTPS → proxy на :84 |

## Первичная установка на VPS

```bash
# На сервере (после первого deploy с Windows):
cd ~/Aedifica.Core
bash "vps door/Aedifica.Core/scripts/install_on_vps.sh"
```

Скрипт: `dart pub get` в `local_api`, systemd unit, nginx site, reload.

## SSL (certbot)

```bash
sudo certbot --nginx -d aedificacore.nighttech.ru
sudo nginx -t && sudo systemctl reload nginx
```

DNS: A-запись `aedificacore.nighttech.ru` → `155.212.187.181`.

## Деплой с Windows

```powershell
cd E:\Applications\Aedifica.Core
.\scripts\deploy_aedifica_to_vps.ps1
```

## Проверка

```bash
curl -s http://127.0.0.1:84/health
curl -s https://aedificacore.nighttech.ru/health
```

В приложении справа в шапке: индикатор облака и кнопка **«На сервер»**.
