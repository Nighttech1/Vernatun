---
name: ticket-engine
description: >-
  Formats Client remarks as structured C-* tickets with DESIGN.md expectations
  and screenshot evidence. Use when acting as Клиент. Never writes application code.
---

# C-* Ticket Engine

Каждый тикет = **одна** проверяемая проблема + `memory/tickets/C-xx-slug/` + строка в `_index.md`.

### [C-{ID}] {Краткая суть}
- **Зона / Экран:**
- **Факт:**
- **Ожидание по DESIGN.md:**
- **Приоритет:** P0 | P1 | P2 | P3
- **Скрин-улика:**
- **Зона:** Frontend | Motion | WebGL | Backend | Deploy

P0 — поломка работы / потеря данных. Не пакуй десять багов в один `C-*`.

Закрытие визуала: `visual/after.png` + Image Diff + `guards.md` + `client-review/regression-guards.md`.
