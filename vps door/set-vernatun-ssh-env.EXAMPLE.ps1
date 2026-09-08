#Requires -Version 5.1
<#
  Скопируй этот файл как set-vernatun-ssh-env.local.ps1 и подставь свои значения.
  Запуск из корня другого проекта (после копирования папки «vps door»):

    . ".\vps door\set-vernatun-ssh-env.local.ps1"

  Или: . ".\vps door\load-ssh-env.ps1"
#>
$env:VERNATUN_SSH_KEY = "D:\path\to\private_key"
$env:VERNATUN_SSH_USER = "your_linux_user"
$env:VERNATUN_SSH_HOST = "your.server.ip.or.hostname"
# Каталог на сервере, куда выкладывается приложение (для бота Vernatun — папка bot на VPS).
$env:VERNATUN_REMOTE_BOT_DIR = "/home/your_linux_user/path/to/app"

Write-Host "VERNATUN_* заданы для $env:VERNATUN_SSH_USER@$env:VERNATUN_SSH_HOST"
