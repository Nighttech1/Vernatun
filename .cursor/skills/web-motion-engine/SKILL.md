---
name: web-motion-engine
description: >-
  Motion for expensive websites: GSAP, Lenis, WAAPI, CSS, scroll-driven scenes.
  Maps Emil Kowalski rules to marketing pages. Use when adding animations,
  parallax, page transitions, sticky chapters, or hover cinema.
---

# Web Motion Engine

Реализация motion. Критика — `review-animations`. Аудит кода — `improve-animations`. Сборка с нуля по философии Emil — `emil-animate`.

## Стек (дешёвый → дорогой)

1. CSS transition / `@starting-style`
2. CSS animation / WAAPI
3. GSAP (+ ScrollTrigger) — сцены, scrub, pin
4. Lenis — гладкий скролл, не «анимация ради анимации»
5. Motion (`motion.dev`) — springs в React-приложении
6. Three/R3F — только через `three-webgl-craft` и chain

Не ставь Framer Motion + GSAP + AOS + Wow.js сразу.

## Жёсткие правила

- Анимируй **transform/opacity** (и sanctioned `clip-path`). Не width/height/top/left.
- Не `scale(0)`. Старт `0.92–0.98` + fade.
- Не `ease-in` на вход. Выход можно чуть быстрее входа.
- Микро UI: **120–200ms**. Шторки/панели: **220–320ms**. Кино на скролле: scrub, не 2s ease.
- `prefers-reduced-motion: reduce` — мгновенные состояния, без scrub-сцен.
- Скролл-сцены не блокируют контент: текст читается без WebGL.
- Hover-cinema только на маркетинге, не на формах и не на 100+ действий/день.

## Lenis

- `lerp` 0.08–0.12. Не убивай нативный скролл на мобиле без нужды.
- Якоря и focus должны работать.
- Не комбинируй Lenis с `scroll-behavior: smooth` на `html`.

## GSAP / ScrollTrigger

- Один ScrollTrigger на главу, не на каждый абзац.
- `invalidateOnRefresh: true` после шрифтов и картинок.
- Pin-секции: фиксируй высоту, не прыгай CLS.
- Kill/revert при SPA unmount.

## Бюджет

| Страница | JS motion | WebGL |
|----------|-----------|--------|
| Hero + 4 главы | GSAP core + ScrollTrigger | 0 или один canvas |
| Кейс | CSS + 1 scrub | нет |
| Experience | GSAP + Lenis | по спеке Архитектора |

Подробные кривые: `emil-animate` / `RECIPES.md`. Перф: `web-perf-motion`.

## Выход

`🎞️ **MOTION:** [что движется, инструмент, reduced-motion: да]`
