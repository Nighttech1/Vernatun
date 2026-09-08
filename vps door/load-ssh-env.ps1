#Requires -Version 5.1
<#
  Подгружает переменные SSH в текущую сессию PowerShell.
  Ищет set-vernatun-ssh-env.local.ps1 рядом с этим скриптом; если нет — сообщает, что делать.

  Запуск (обязательно с точкой в начале — чтобы переменные остались в сессии):

    . ".\vps door\load-ssh-env.ps1"
#>
$ErrorActionPreference = "Stop"
$here = $PSScriptRoot
$local = Join-Path $here "set-vernatun-ssh-env.local.ps1"

if (-not (Test-Path -LiteralPath $local)) {
  Write-Host @"
Не найден файл с доступами:
  $local

Сделайте так:
  1) Скопируйте set-vernatun-ssh-env.EXAMPLE.ps1 в set-vernatun-ssh-env.local.ps1
  2) Откройте local-файл и впишите путь к ключу, пользователя, хост и каталог на сервере
  3) Снова выполните: . "$here\load-ssh-env.ps1"

В репозитории Vernatun готовый пример лежит в scripts\set-vernatun-ssh-env.ps1 — можно скопировать оттуда строки с `$env:VERNATUN_*` в свой local-файл (и не коммитить local).
"@
  exit 1
}

. $local
Write-Host "Загружено: $local"
