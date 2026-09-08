# Vernatun static site verification
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$html = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $root 'index.html')

$vernatunRu = [string]([char]0x0412 + [char]0x0435 + [char]0x0440 + [char]0x043D + [char]0x0430 + [char]0x0442 + [char]0x0443 + [char]0x043D)
$armyanskii = [string]([char]0x0430 + [char]0x0440 + [char]0x043C + [char]0x044F + [char]0x043D + [char]0x0441 + [char]0x043A + [char]0x0438 + [char]0x0439)
$razgovorny = [string]([char]0x0440 + [char]0x0430 + [char]0x0437 + [char]0x0433 + [char]0x043E + [char]0x0432 + [char]0x043E + [char]0x0440 + [char]0x043D + [char]0x044B + [char]0x0439)
$armyanskiiRazgovorny = "$armyanskii $razgovorny"
$atmosphereLine = [string]([char]0x0423 + [char]0x0020 + [char]0x043D + [char]0x0430 + [char]0x0441 + [char]0x0020 + [char]0x043F + [char]0x043E + [char]0x002D + [char]0x043F + [char]0x0440 + [char]0x043E + [char]0x0441 + [char]0x0442 + [char]0x043E + [char]0x043C + [char]0x0443 + [char]0x0020 + [char]0x043A + [char]0x043B + [char]0x0430 + [char]0x0441 + [char]0x0441 + [char]0x043D + [char]0x043E)
$aboutVernatun = "$vernatunRu $([char]0x2014) $([char]0x044D + [char]0x0442 + [char]0x043E + [char]0x0020 + [char]0x0443 + [char]0x044E + [char]0x0442 + [char]0x043D + [char]0x043E + [char]0x0435 + [char]0x0020 + [char]0x043F + [char]0x0440 + [char]0x043E + [char]0x0441 + [char]0x0442 + [char]0x0440 + [char]0x0430 + [char]0x043D + [char]0x0441 + [char]0x0442 + [char]0x0432 + [char]0x043E)"
$klub = [string]([char]0x043A + [char]0x043B + [char]0x0443 + [char]0x0431)
$yazyka = [string]([char]0x044F + [char]0x0437 + [char]0x044B + [char]0x043A + [char]0x0430)
$armyanskogo = [string]([char]0x0430 + [char]0x0440 + [char]0x043C + [char]0x044F + [char]0x043D + [char]0x0441 + [char]0x043A + [char]0x043E + [char]0x0433 + [char]0x043E)
$zanyatiya = [string]([char]0x0417 + [char]0x0430 + [char]0x043D + [char]0x044F + [char]0x0442 + [char]0x0438 + [char]0x044F)
$seoTitle = "$([char]0x0420 + [char]0x0430 + [char]0x0437 + [char]0x0433 + [char]0x043E + [char]0x0432 + [char]0x043E + [char]0x0440 + [char]0x043D + [char]0x044B + [char]0x0439) $klub $armyanskogo $yazyka Vernatun $([char]0x2014) $zanyatiya"
$seoDescription = "$([char]0x0420 + [char]0x0430 + [char]0x0437 + [char]0x0433 + [char]0x043E + [char]0x0432 + [char]0x043E + [char]0x0440 + [char]0x043D + [char]0x044B + [char]0x0439) $klub $armyanskogo $yazyka Vernatun"
$seoH1 = "$([char]0x0410 + [char]0x0440 + [char]0x043C + [char]0x044F + [char]0x043D + [char]0x0441 + [char]0x043A + [char]0x0438 + [char]0x0439) $razgovorny $klub Vernatun"
$razgovornyKlubArmyanskogo = " $klub $armyanskogo"

$checks = @(
    'format-photo-wrap',
    'zoom-badge',
    'gallery-slide-frame',
    'object-fit: contain',
    '#000000',
    'images/logo-transparent.png',
    'images/favicon-192.png',
    'rel="icon"',
    'og:title',
    'og:description',
    'og:site_name',
    '@type": "WebSite"',
    'Московский армянский разговорный клуб Вернатун',
    'vernatunspeakclub.com',
    'Vernatun Armenian Club',
    $vernatunRu,
    $armyanskiiRazgovorny,
    'application/ld+json',
    'gallery/5.jpg',
    'gallery/6.jpg',
    'openLb(',
    'carousel-nav-btn',
    $atmosphereLine,
    'google-site-verification',
    'fUAk3aBJcRq__YDAcLFdEFHH3WnN0DGO5Lfhr29kkPs',
    $seoTitle,
    $seoDescription,
    $seoH1,
    '2026-8-3',
    '2026-8-12',
    '2026-8-19',
    '2026-8-26',
    '2026-8-8',
    '2026-8-22',
    'День клуба в Циферблате',
    'Субботние мероприятия',
    'faq-item',
    'faq-chevron',
    'FAQPage',
    'id="faq"',
    'id="materials"',
    'materials-heading',
    'materials/podcasts/ideal-life/index.html',
    'Культ идеальной жизни',
    'А2–В1',
    'vernatunbot',
    't.me/vernatunbot'
)

$mustNot = @(
    'gallery/7.jpg',
    'http://127.0.0.1',
    '#region agent log',
    'bg-white shadow-card flex items-center justify-center p-6 sm:p-8',
    'Вторник, 20:00',
    'ГЭС-2',
    'English',
    'форму на сайте',
    'openPodcast()',
    'podcastOpen',
    'Загрузить .m4a'
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

$englishRu = [string]([char]0x0430 + [char]0x043D + [char]0x0433 + [char]0x043B + [char]0x0438 + [char]0x0439 + [char]0x0441 + [char]0x043A)
if ($html -match $englishRu) {
    Write-Host "FAIL: HTML still mentions English language (RU stem)" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: no English language mentions (RU)" -ForegroundColor Green
}

$h1Count = ([regex]::Matches($html, '<h1\b', 'IgnoreCase')).Count
if ($h1Count -ne 1) {
    Write-Host "FAIL: expected exactly 1 h1, found $h1Count" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: single h1" -ForegroundColor Green
}

$faqHeading = [string](
    [char]0x0427 + [char]0x0430 + [char]0x0441 + [char]0x0442 + [char]0x043E + [char]0x0020 +
    [char]0x0437 + [char]0x0430 + [char]0x0434 + [char]0x0430 + [char]0x0432 + [char]0x0430 + [char]0x0435 + [char]0x043C + [char]0x044B + [char]0x0435 + [char]0x0020 +
    [char]0x0432 + [char]0x043E + [char]0x043F + [char]0x0440 + [char]0x043E + [char]0x0441 + [char]0x044B
)
if ($html -notmatch [regex]::Escape($faqHeading)) {
    Write-Host "FAIL: missing FAQ h2 heading" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: FAQ heading" -ForegroundColor Green
}

$detailsCount = ([regex]::Matches($html, '<details\b', 'IgnoreCase')).Count
if ($detailsCount -ne 10) {
    Write-Host "FAIL: expected 10 FAQ details, found $detailsCount" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: 10 FAQ details" -ForegroundColor Green
}

$summaryCount = ([regex]::Matches($html, '<summary\b', 'IgnoreCase')).Count
if ($summaryCount -ne 10) {
    Write-Host "FAIL: expected 10 FAQ summaries, found $summaryCount" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: 10 FAQ summaries" -ForegroundColor Green
}

$bareCount = 0
$rx = [regex]::new([regex]::Escape($razgovorny), [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
foreach ($m in $rx.Matches($html)) {
    $prefixOk = $false
    $suffixOk = $false
    $prefixLen = $armyanskii.Length + 1
    if ($m.Index -ge $prefixLen) {
        $prefix = $html.Substring($m.Index - $prefixLen, $prefixLen)
        if ($prefix.ToLowerInvariant() -eq ($armyanskii + ' ').ToLowerInvariant()) { $prefixOk = $true }
    }
    $afterStart = $m.Index + $m.Length
    if ($afterStart + $razgovornyKlubArmyanskogo.Length -le $html.Length) {
        $after = $html.Substring($afterStart, $razgovornyKlubArmyanskogo.Length)
        if ($after.ToLowerInvariant() -eq $razgovornyKlubArmyanskogo.ToLowerInvariant()) { $suffixOk = $true }
    }
    if (-not $prefixOk -and -not $suffixOk) { $bareCount++ }
}
if ($bareCount -gt 0) {
    Write-Host "FAIL: found bare razgovorny without armyanskii ($bareCount)" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: no bare razgovorny" -ForegroundColor Green
}

if ($html -notmatch [regex]::Escape($aboutVernatun)) {
    Write-Host "FAIL: about section should use Vernatun RU" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: about section Vernatun RU" -ForegroundColor Green
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

$formatFiles = @(
    'format-01.png', 'format-02.jpg', 'format-03.png', 'format-04.jpg',
    'icon.png', 'logo-transparent.png', 'favicon-192.png', 'favicon-32.png',
    'apple-touch-icon.png', 'favicon.ico'
)
foreach ($name in $formatFiles) {
    $file = Join-Path $root "images\$name"
    if (-not (Test-Path $file)) {
        Write-Host "FAIL: missing images/$name" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: images/$name" -ForegroundColor Green
    }
}

foreach ($name in @('robots.txt', 'sitemap.xml', 'favicon.ico')) {
    $file = Join-Path $root $name
    if (-not (Test-Path $file)) {
        Write-Host "FAIL: missing $name" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: $name" -ForegroundColor Green
    }
}

foreach ($name in @('robots.txt', 'sitemap.xml')) {
    $file = Join-Path $root "public\$name"
    if (-not (Test-Path $file)) {
        Write-Host "FAIL: missing public/$name" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: public/$name" -ForegroundColor Green
    }
}

$robots = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $root 'public\robots.txt')
if ($robots -notmatch 'Sitemap:\s*https://vernatunspeakclub\.com/sitemap\.xml') {
    Write-Host "FAIL: public/robots.txt missing sitemap" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: public/robots.txt sitemap" -ForegroundColor Green
}
if ($robots -notmatch 'User-agent:\s*\*') {
    Write-Host "FAIL: public/robots.txt missing User-agent" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: public/robots.txt User-agent" -ForegroundColor Green
}
if ($robots -notmatch 'Allow:\s*/') {
    Write-Host "FAIL: public/robots.txt missing Allow" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: public/robots.txt Allow" -ForegroundColor Green
}

$sitemap = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $root 'public\sitemap.xml')
if ($sitemap -notmatch 'https://vernatunspeakclub\.com/') {
    Write-Host "FAIL: public/sitemap.xml missing site URL" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: public/sitemap.xml URL" -ForegroundColor Green
}

$podcastDir = Join-Path $root 'materials\podcasts\ideal-life'
$podcastHtmlPath = Join-Path $podcastDir 'index.html'
$podcastAudioPath = Join-Path $podcastDir 'audio.m4a'
$podcastPdfPath = Join-Path $podcastDir 'handout.pdf'
if (-not (Test-Path $podcastHtmlPath)) {
    Write-Host "FAIL: missing materials/podcasts/ideal-life/index.html" -ForegroundColor Red
    $failed++
} else {
    Write-Host "OK: podcast index.html" -ForegroundColor Green
    $podcastHtml = Get-Content -Raw -Encoding UTF8 -Path $podcastHtmlPath
    foreach ($p in @(
        'src="audio.m4a"',
        'handout.pdf',
        'id="handout"',
        'id="podcast"',
        'transcriptData',
        'setActiveReplica',
        'timeupdate',
        'parchment',
        '#2A5A84',
        'bg-azure',
        '../../../index.html',
        'max-w-[1600px]',
        'seekToReplica',
        'findReplicaAt',
        'applySeek',
        'prepareSeekableAudio'
    )) {
        if ($podcastHtml -notmatch [regex]::Escape($p)) {
            Write-Host "FAIL: podcast missing $p" -ForegroundColor Red
            $failed++
        } else {
            Write-Host "OK: podcast has $p" -ForegroundColor Green
        }
    }
    foreach ($name in @('Тигран', 'Ани')) {
        if ($podcastHtml -notmatch [regex]::Escape($name)) {
            Write-Host "FAIL: podcast missing speaker name $name" -ForegroundColor Red
            $failed++
        } else {
            Write-Host "OK: podcast speaker $name" -ForegroundColor Green
        }
    }
    foreach ($badGender in @('Мужчина', 'Женщина')) {
        if ($podcastHtml -match [regex]::Escape($badGender)) {
            Write-Host "FAIL: podcast still has $badGender" -ForegroundColor Red
            $failed++
        } else {
            Write-Host "OK: podcast removed $badGender" -ForegroundColor Green
        }
    }
    foreach ($bad in @('audioFile', 'Загрузить .m4a', 'class="dark"', 'bg-slate-950', 'bg-blue-600', 'max-w-5xl', '7429/ingest', '#region agent log', 'function dbg')) {
        if ($podcastHtml -match [regex]::Escape($bad)) {
            Write-Host "FAIL: podcast should not contain $bad" -ForegroundColor Red
            $failed++
        } else {
            Write-Host "OK: podcast removed $bad" -ForegroundColor Green
        }
    }
    $replicaCount = ([regex]::Matches($podcastHtml, '\{ id: \d+')).Count
    if ($replicaCount -lt 140) {
        Write-Host "FAIL: expected many transcript replicas, found $replicaCount" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: podcast replicas ($replicaCount)" -ForegroundColor Green
    }
}

if (-not (Test-Path $podcastAudioPath)) {
    Write-Host "FAIL: missing materials/podcasts/ideal-life/audio.m4a" -ForegroundColor Red
    $failed++
} else {
    $audioLen = (Get-Item $podcastAudioPath).Length
    if ($audioLen -lt 1MB) {
        Write-Host "FAIL: audio.m4a too small ($audioLen bytes)" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: audio.m4a ($([math]::Round($audioLen/1MB,1)) MB)" -ForegroundColor Green
    }
}

if (-not (Test-Path $podcastPdfPath)) {
    Write-Host "FAIL: missing materials/podcasts/ideal-life/handout.pdf" -ForegroundColor Red
    $failed++
} else {
    $pdfLen = (Get-Item $podcastPdfPath).Length
    if ($pdfLen -lt 10KB) {
        Write-Host "FAIL: handout.pdf too small ($pdfLen bytes)" -ForegroundColor Red
        $failed++
    } else {
        Write-Host "OK: handout.pdf ($([math]::Round($pdfLen/1KB,1)) KB)" -ForegroundColor Green
    }
}

if ($failed -gt 0) {
    throw "Verification failed: $failed check(s)"
}
Write-Host 'All site verification checks passed.' -ForegroundColor Green
