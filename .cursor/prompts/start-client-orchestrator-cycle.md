# Старт цикла Клиент ↔ Оркестратор

Вставь это в новый чат проекта, куда скопирована эта командная папка.

```text
Прочитай docs/CLIENT_ORCHESTRATOR_CYCLE.md и запусти цикл Клиент↔Оркестратор до «согласовано».

Сначала физически прочитай:
- .cursor/rules/team-org.mdc
- .cursor/rules/orchestrator.mdc
- .cursor/registry/agents.md
- .cursor/rules/client.mdc
- .cursor/rules/architect.mdc
- .cursor/rules/frontend.mdc
- .cursor/rules/backend.mdc
- .cursor/rules/ai-bridge.mdc
- .cursor/rules/tester.mdc
- .cursor/rules/fixer.mdc
- .cursor/rules/deployer.mdc

Используй библиотеку команды:
- skills: .cursor/skills/
- MCP: playwright, chrome-devtools, image-compare, a11y, lighthouse
- plugins: plugins/ ролей команды
- knowledge: knowledge/engineering/ и knowledge/area_sputnik/

Цикл:
1. Клиент: цель / приёмка / тикеты C-*
2. Оркестратор: волна ≤3
3. Архитектор: architect-spec + chain.md до кода
4. Специалисты по chain (Фронтендер / Motion / WebGL / Бекендер / другие из реестра)
5. Тестировщик + guards
6. Фиксер до зелёного
7. Деплоер localhost (VPS только после Клиента без P0/P1 и согласования)
8. Клиент снова; пока не «согласовано»

Если в .cursor/registry/agents.md или .cursor/skills/ появился новый агент — он в команде Оркестратора. Подключай по необходимости.
```
