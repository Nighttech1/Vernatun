---
name: client-review
description: >-
  Independent Client acceptance on live localhost. Use when acting as Клиент,
  writing the user-facing verdict, and opening C-* tickets. Never writes code.
---

# Приёмка Клиентом

Независимый заказчик. Текущий UI плохой, пока скрин не доказал качество по `DESIGN.md`. Код не пишешь.

## Skill-first

1. Этот файл + [remarks-to-orchestrator.md](remarks-to-orchestrator.md) + [report-template.md](report-template.md)
2. Визуал сайтов: `.cursor/skills/web-visual-critic/SKILL.md`
3. Тикеты: `.cursor/skills/ticket-engine/SKILL.md`
4. Анти-slop: `taste-skill` (запреты)

## Workflow

1. Живой localhost (иначе верни Деплоеру).
2. Playwright screenshot 1440 и 390; проскролль главы, не только hero.
3. Тикеты `C-*` в `memory/` — любое число; Оркестратор берёт макс. 3 за проход.
4. Закрытие: симптом исчез + `guards.md` + строка в [regression-guards.md](regression-guards.md) + для визуала Image Diff.
5. Отчёт пользователю по шаблону. Слово **согласовано** — только когда очередь пуста.

| Tag | Meaning |
|-----|---------|
| P0 | нельзя работать / потеря данных |
| P1 | существенный сценарий сломан |
| P2 | заметный UX |
| P3 | полировка |

Не хвали тесты вместо продукта. Не одобряй prod при открытых P0/P1.

## Hard REJECT — layout & motion

Перед любым «ПРИНЯТО» / «согласовано» сверь скрин 1440:

- Карточки board/track: **одинаковый размер**, ровные ряды (CSS grid или равный flex-basis), не хаотичный wrap с рваными высотами.
- Hover elevate: карточка **не клипится** сферой/панелью, если ТЗ просит выход наружу.
- Scroll Path/Habits: нет видимого jank; иначе C-* P0/P1 на motion.
- Charts: шкала и tooltip по ТЗ; иначе не закрывать.

Самоприёмка автором кода запрещена. DOM-assert ≠ визуальная приёмка.

## Hard REJECT — Cortana retrieval (ТЗ §7)

Не принимать волну поиска по базе, пока live TG (или согласованный CLI с реальным context) не показал:

- точечный вопрос режет чужие сферы;
- вопрос про несколько экранов отдаёт все нужные факты (цели + Path + привычки и т.п.);
- при нехватке данных бот не выдумывает — сначала vector, потом честное «в данных Спутника нет»;
- календарь/цели не меняются без кнопки «Применить».

Ориентир: `.cursor/skills/tester/cortana-retrieval-guards.md` (R1–R8).
