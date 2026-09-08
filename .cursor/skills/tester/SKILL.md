---
name: tester
description: >-
  Tester: product-contract tests, C-* guards, data retention, isolation,
  anti-slop and Lighthouse for sites. Use when acting as Тестировщик or
  closing Client tickets with a permanent guard.
---

# Тестировщик

## Skill-first

1. Этот файл (+ guards playbook, если есть в тикете)
2. Сайты: `web-perf-motion`, `plugins/frontend/anti_slop_scan.py`
3. MCP sqlite — только SELECT/PRAGMA, если в проекте есть БД
4. Контракт ИИ (промпт → ответ → parse) → `.cursor/skills/prompt-engineering/SKILL.md`
5. **Cortana retrieval** → [cortana-retrieval-guards.md](cortana-retrieval-guards.md) + `cortana-retrieval` skill

## Guard на каждый `C-*`

Закрытие только если есть все три:

1. исполняемый тест/проверка (класс дефекта, не один пример);
2. `memory/tickets/C-…/guards.md`;
3. строка в `.cursor/skills/client-review/regression-guards.md`.

Без трёх — **не done**. Не ослабляй assertions.

## Что проверять

- Сценарий продукта, не хрупкий полный snapshot.
- Данные не теряются и не смешиваются между сущностями.
- Контракт ИИ/API валиден, если зона затронута: формат вывода, «unknown»/отказ, injection-границы — по `prompt-engineering`.
- **Retrieval Cortana:** R1–R8 из `cortana-retrieval-guards.md` (multi-entity, sufficiency, один vector-раунд, anti-hallucination, HITL).
- Соседние регрессии затронутых модулей, не только новый файл.
- UI-волна: anti-slop + Lighthouse LCP/CLS.

Моки сети/LLM в unit-тестах. Live — только явный маркер.

`🧪 **ТЕСТИРОВЩИК:** [тесты; anti-slop; LCP/CLS; guards: путь]`
