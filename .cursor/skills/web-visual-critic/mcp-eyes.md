# Глаза Клиента — MCP (сайты)

Конфиг: `.cursor/mcp.json`. Node: `D:\Applications\Tools\node`.

| Сервер | Зачем |
|--------|--------|
| `playwright` | клики, screenshot, vision |
| `chrome-devtools` | bounding box, computed styles, сеть |
| `image-compare` | before/after, красная diff-маска |
| `a11y` | контраст WCAG AA |
| `lighthouse` | LCP, CLS, INP, TBT |

Имена в Cursor могут быть с префиксом `user-`.

## Ритуал

1. Localhost жив (URL из спеки проекта).
2. Playwright: 1440×900 и 390×844. Подожди шрифты/Lenis (не скелетон).
3. Скролл: hero, вторая глава, футер.
4. Контраст текста на фото/видео — отдельно, не верь общему axe-URL.
5. Тикеты через ticket-engine. После фикса — `compare_images` + lighthouse повторно.

Курсор/часы на diff — ложное срабатывание. Сдвиг сетки — нет.
