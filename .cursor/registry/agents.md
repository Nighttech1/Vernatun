# Реестр команды агентов — Sputnik Life OS / Cortana

## Базовая команда

| Роль | Правило | Скилл | MCP / плагины |
|------|---------|-------|----------------|
| Клиент | `client.mdc` | `client-review`, `web-visual-critic`, `ticket-engine`, `taste-skill` | Playwright, Image Diff, A11y, Lighthouse |
| Оркестратор | `orchestrator.mdc` | реестр + team-org | |
| Архитектор | `architect.mdc` | `architect`; LLM → `prompt-engineering`; RAG → `rag-stack`; Cortana retrieval → **`cortana-retrieval`** | `plugins/architect` |
| Фронтендер | `frontend.mdc` | **A:** `image-to-luxury-ui`, `luxury-web-craft`, `create-design-md`, `design-token-guardian` · **B:** `flutter-motion-engine`, `flutter-dense-datagrid` | `plugins/frontend` |
| Motion | `motion.mdc` | `web-motion-engine`, `emil-animate`, `review-animations`, `web-perf-motion` | `plugins/motion` |
| WebGL | chain only | `three-webgl-craft` | |
| Бекендер | `backend.mdc` | `backend`, `safe-db-migrations`, `pydantic-v2`, `pgvector-semantic-search`; Cortana index upsert → `cortana-retrieval` | sqlite RO, postgres; `plugins/backend` |
| AI Bridge (Cortana) | `ai-bridge.mdc` | `ai-bridge`, **`cortana-stack`**, **`cortana-retrieval`**, `sputnik-data-schema`, `prompt-engineering`, `rag-stack`, LangGraph HITL | `plugins/ai-bridge` |
| Кодер | `coder.mdc` | `coder`; graphs → LangGraph skills; Cortana context → `cortana-retrieval` | маршрутизатор |
| Тестировщик | `tester.mdc` | `tester` + **`cortana-retrieval-guards`** | Lighthouse, anti_slop_scan, sqlite RO |
| Фиксер | `fixer.mdc` | `fixer` | `plugins/fixer` |
| Деплоер | `deployer.mdc` | `deployer` | VPS gate после Клиента |

## Профили Frontend

| Задача | Стек | Агенты в chain |
|--------|------|----------------|
| Одна картинка → premium UI + люкс-анимации | Next/React + GSAP/Lenis | Frontend (A) → **Motion** → Клиент |
| Life OS таблицы, sync, offline | Flutter | Frontend (B) |

**Flutter не тянет luxury scroll/motion уровня Lusion/Active Theory.** Для premium visual — web-стек.

## RAG / Cortana stack

| Пакет | Роли |
|-------|------|
| `cortana-stack` | AI Bridge (маршрутизатор Cortana: TG, GCal, HITL) |
| **`cortana-retrieval`** | AI Bridge + Архитектор + Backend (filter-first → sufficiency → entity vector) |
| `sputnik-data-schema` | AI Bridge (канон целей) |
| LangGraph HITL | AI Bridge |
| chroma-local | AI Bridge — **entity collection** отдельно от dialog `cortana_rag/` |
| pgvector-semantic-search | Backend (альтернатива индекса по spec Архитектора) |

### Типовой chain — Cortana Retrieval (ТЗ шаги 5–9)

`Архитектор → AI Bridge → Backend (sync upsert индекса) → Тестировщик → Фиксер → Деплоер → Клиент`

Frontend / Motion / WebGL — **не** подключать. GraphRAG — не default.

## MCP

playwright, chrome-devtools, image-compare, a11y, lighthouse, sqlite (RO), postgres (gate).

## Не включены

Geo-аналитик, Mapbox/OSM, Pinecone (пока), отдельный агент «Retrieval Engineer» (зона AI Bridge).
