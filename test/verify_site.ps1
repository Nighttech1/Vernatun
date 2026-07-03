# Vernatun static site verification
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$html = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $root 'index.html')

$checks = @(
    'format-photo-wrap',
    'zoom-badge',
    'gallery-slide-frame',
    'object-fit: contain',
    '#000000',
    'images/icon.png',
    'og:title',
    'og:description',
    'Vernatun Armenian Club',
    'gallery/5.jpg',
    'gallery/6.jpg',
    'openLb(',
    'carousel-nav-btn'
)

$mustNot = @(
    'gallery/7.jpg',
    'http://127.0.0.1',
    '#region agent log'
)

$failed = 0
foreach ($pattern in $checks) {
    if ($html -notmatch [regex]::Escape($pattern)) {
        Write-Host "FAIL: missing $pattern" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: $pattern" -ForegroundColor Green
    }
}

foreach ($pattern in $mustNot) {
    if ($html -match [regex]::Escape($pattern)) {
        Write-Host "FAIL: should not contain $pattern" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: removed $pattern" -ForegroundColor Green
    }
}

$galleryFiles = 1..6 | ForEach-Object { Join-Path $root "gallery\$_.jpg" }
foreach ($file in $galleryFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "FAIL: missing $file" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: exists $(Split-Path $file -Leaf)" -ForegroundColor Green
    }
}

$formatFiles = @('format-01.png', 'format-02.jpg', 'format-03.png', 'format-04.jpg', 'icon.png')
foreach ($name in $formatFiles) {
    $file = Join-Path $root "images\$name"
    if (-not (Test-Path $file)) {
        Write-Host "FAIL: missing images/$name" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: images/$name" -ForegroundColor Green
    }
}

if ($failed -gt 0) {
    throw "Verification failed: $failed check(s)"
}
Write-Host 'All site verification checks passed.' -ForegroundColor Green
