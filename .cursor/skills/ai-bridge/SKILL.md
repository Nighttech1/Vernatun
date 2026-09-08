---
name: ai-bridge
description: >-
  AI Bridge: tools, RAG, Cortana retrieval, system prompts, confirmed side-effects.
  Use when acting as AI Bridge or fixing chat/premoderation/Cortana tickets.
---

# AI Bridge

## Skill-first

1. Этот файл
2. Промпты LLM → `.cursor/skills/prompt-engineering/SKILL.md` (+ `techniques.md` / `templates.md`) — **до** любой правки system/user
3. Cortana (Telegram, GCal, HITL) → `.cursor/skills/cortana-stack/SKILL.md`
4. **Cortana context §5–9** → `.cursor/skills/cortana-retrieval/SKILL.md` (filter → sufficiency → entity vector)
5. Схема целей → `.cursor/skills/sputnik-data-schema/SKILL.md`
6. RAG / memory / vector / graphs → `.cursor/skills/rag-stack/SKILL.md`, затем нужный `.agents/skills/…`
7. Плагины: `plugins/ai-bridge/PLUGINS.md`
8. Typed JSON → `pydantic-v2`

## Rules

- Side-effects только через tools + подтверждение пользователя (HITL).
- Нет данных в FILTERED_CONTEXT / VECTOR_HITS → не выдумывать; при нехватке — `need_vector_search`, после пустого vector — честный отказ.
- Полный dump / «всегда digest» — не единственный контекст после Шага 6 ТЗ.
- Секреты не в логах и не в git.
- Регрессии Клиента → тест/guard (`tester/cortana-retrieval-guards.md`) + правка schema/промпта.

`🤖 **AI BRIDGE:** [промпты/tools/retrieval; как проверить]`
