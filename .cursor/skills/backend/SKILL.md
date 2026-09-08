---
name: backend
description: >-
  Backend and data reliability: API, SQLite/Postgres, isolation, zero-data-loss,
  read-only MCP. Use when acting as Backend or fixing API/data tickets, schema,
  sync, or storage.
---

# Backend (Data Reliability)

## Skill-first

1. Этот файл + [zero-data-loss.md](zero-data-loss.md)
2. Схема/DDL: `.cursor/skills/safe-db-migrations/SKILL.md`
3. Правило: `.cursor/rules/backend.mdc`
4. Схемы Python: `.cursor/skills/pydantic-v2/SKILL.md` при FastAPI/Pydantic
5. Запрос/ответ LLM (клиент API, премодерация, parse JSON) → `.cursor/skills/prompt-engineering/SKILL.md` (текст промпта правит AI Bridge)
6. Vector / ingest: `.cursor/skills/rag-stack/SKILL.md` → `pgvector-semantic-search` / `chroma-*` / `pinecone-*` / `llamaparse` + `plugins/backend/PLUGINS.md`
7. **Cortana entity index:** при тикетах Шага 8 ТЗ — hook upsert чанков сущностей на sync/save dump (AI Bridge пишет indexer; Backend — триггер/API безопасности). Читать `cortana-retrieval`. Не смешивать с dialog Chroma.

## Zero Data Loss

1. **Изоляция:** записи сущности — scoped id (workspace/tenant/project). Никаких глобальных перезаписей чужих данных.
2. **Премодерация:** прямая запись от LLM запрещена. Мутации ИИ — через подтверждённый executor + audit log (Undo).
3. **SQLite:** один пишущий процесс, WAL. MCP sqlite — только read-only.
4. **Миграции:** additive; DROP только после двухэтапного депрекейта — `safe-db-migrations`.
5. **Идемпотентность:** `actionId` (или эквивалент) на mutating-запросах.

Не трогай живые файлы БД пользователя без явной команды.

## MCP

- **sqlite:** `scripts/mcp/sqlite-readonly.mjs` — SELECT / PRAGMA / `integrity_check`. Писать через MCP запрещено.
- **postgres:** `scripts/mcp/postgres-gate.mjs` — read-only после URI в `.cursor/postgres.env`.

## Порядок

1. `chain.md` — только свои paths.
2. Инспекция MCP sqlite (если файл есть).
3. Код API / store / миграции.
4. Не переписывай UI. Текст промптов — AI Bridge + `prompt-engineering`; ты только транспорт/схема/хранилище.

`🔌 **BACKEND:** [эндпоинты/хранилище; риски для данных]`
