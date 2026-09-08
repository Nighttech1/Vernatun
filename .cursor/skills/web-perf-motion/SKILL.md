---
name: web-perf-motion
description: >-
  Keep luxury motion at 60fps and pass Core Web Vitals. Use when Lighthouse
  fails, scroll jank, WebGL heat, font swap jump, or heavy GSAP pages.
---

# Web Perf × Motion

Люкс, который лагает — не люкс.

## Цели localhost (desktop)

- LCP < 2.5s (hero image/video poster, не canvas)
- CLS < 0.1 (шрифты: `size-adjust` / preload display)
- INP < 200ms
- TBT разумный: не грузи GSAP+Three+Lenis на первый байт, если глава ниже fold

## Правила

- GPU: transform/opacity. `will-change` только на активный элемент, снять после.
- Картинки: AVIF/WebP, `width/height`, `fetchpriority=high` только у LCP.
- Видео: poster + `preload=metadata`; не autoplay 4K.
- Шрифты: preload 1–2 файла, `font-display: swap` + близкий fallback.
- GSAP: не `quickSetter` на 200 DOM-нод каждый скролл. Батч.
- Three: DPR cap, pause offscreen — `three-webgl-craft`.

## Как проверять

1. MCP `lighthouse` по URL localhost
2. Chrome DevTools: Performance + Rendering paint flashing
3. Повтор после фикса — тот же URL

## Выход

`⚡ **PERF:** LCP/CLS/INP; что урезали`
