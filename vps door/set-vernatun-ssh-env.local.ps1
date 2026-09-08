#Requires -Version 5.1
# Локальные SSH-переменные для деплоя Aedifica.Core (не коммитить).
$env:VERNATUN_SSH_KEY = "D:\Infinity server\.ssh\id_ed25519"
$env:VERNATUN_SSH_USER = "infinity"
$env:VERNATUN_SSH_HOST = "155.212.187.181"
$env:VERNATUN_REMOTE_BOT_DIR = "/home/infinity/Aedifica.Core"
$env:VERNATUN_WEBSITE_DIR = "/home/infinity/Vernatun website"
Write-Host "VERNATUN_* заданы для $env:VERNATUN_SSH_USER@$env:VERNATUN_SSH_HOST -> $env:VERNATUN_REMOTE_BOT_DIR"
