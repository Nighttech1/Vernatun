#Requires -Version 5.1
<#
  Деплой статического сайта Vernatun на VPS.
  Перед запуском: . ".\vps door\load-ssh-env.ps1"
#>
param(
    [switch]$SkipSsl,
    [switch]$InstallOnly
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$remoteApp = if ($env:VERNATUN_WEBSITE_DIR) { $env:VERNATUN_WEBSITE_DIR } else { "/home/infinity/Vernatun website" }
$remoteWeb = "$remoteApp/web"

if (-not $env:VERNATUN_SSH_USER -or -not $env:VERNATUN_SSH_HOST) {
    throw "Загрузите SSH: . `"$repoRoot\vps door\load-ssh-env.ps1`""
}
if (-not (Test-Path -LiteralPath $env:VERNATUN_SSH_KEY)) {
    throw "SSH-ключ не найден: $($env:VERNATUN_SSH_KEY). Обновите vps door\set-vernatun-ssh-env.local.ps1"
}

$sshTarget = "$($env:VERNATUN_SSH_USER)@$($env:VERNATUN_SSH_HOST)"
$sshArgs = @("-i", $env:VERNATUN_SSH_KEY, "-o", "StrictHostKeyChecking=accept-new")
$scpArgs = @("-i", $env:VERNATUN_SSH_KEY, "-o", "StrictHostKeyChecking=accept-new", "-r")

function Invoke-Ssh([string]$Command) {
    & ssh @sshArgs $sshTarget $Command
    if ($LASTEXITCODE -ne 0) { throw "SSH failed: $Command" }
}

function Invoke-Scp([string[]]$Paths, [string]$RemoteDest) {
    & scp @scpArgs @Paths "${sshTarget}:${RemoteDest}"
    if ($LASTEXITCODE -ne 0) { throw "SCP failed -> $RemoteDest" }
}

Write-Host "==> Deploy Vernatun website -> $sshTarget`:$remoteApp"

Invoke-Ssh "mkdir -p '$remoteWeb' '$remoteApp/vps door/Vernatun website/nginx' '$remoteApp/vps door/Vernatun website/scripts'"

$siteItems = @(
    (Join-Path $repoRoot "index.html"),
    (Join-Path $repoRoot "public\robots.txt"),
    (Join-Path $repoRoot "public\sitemap.xml"),
    (Join-Path $repoRoot "favicon.ico"),
    (Join-Path $repoRoot "images"),
    (Join-Path $repoRoot "gallery")
)
$materials = Join-Path $repoRoot "materials"
if (Test-Path $materials) { $siteItems += $materials }
$videos = Join-Path $repoRoot "videos"
if (Test-Path $videos) { $siteItems += $videos }

Write-Host "==> Upload site files"
Invoke-Scp $siteItems $remoteWeb

Write-Host "==> Upload nginx + install script"
Invoke-Scp @(
    (Join-Path $repoRoot "vps door\Vernatun website\nginx\vernatunspeakclub.com.conf")
) "$remoteApp/vps door/Vernatun website/nginx/"

Invoke-Scp @(
    (Join-Path $repoRoot "vps door\Vernatun website\scripts\install_on_vps.sh")
) "$remoteApp/vps door/Vernatun website/scripts/"

Invoke-Ssh "chmod +x '$remoteApp/vps door/Vernatun website/scripts/install_on_vps.sh'"

if (-not $InstallOnly) {
    Write-Host "==> Run install (nginx + certbot)"
    $sslFlag = if ($SkipSsl) { "SKIP_SSL=1" } else { "" }
    Invoke-Ssh "cd '$remoteApp' && bash 'vps door/Vernatun website/scripts/install_on_vps.sh'"
}

Write-Host "==> Health checks"
Invoke-Ssh "curl -sfI http://127.0.0.1:85/ | head -5 || true"
Invoke-Ssh "curl -sfI https://vernatunspeakclub.com/ | head -5 || true"

Write-Host ""
Write-Host "OK. Site: https://vernatunspeakclub.com/" -ForegroundColor Green
