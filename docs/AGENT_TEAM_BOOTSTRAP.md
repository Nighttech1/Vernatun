# Bootstrap: команда агентов Cursor (перенос в другой проект)

**Практическая инструкция «что копировать»:** [`COPY_TO_NEW_PROJECT.md`](../COPY_TO_NEW_PROJECT.md).

Этот файл — длинный шаблон оргмодели. Для старта нового сайта достаточно COPY-файла.

---

## Промпт для первого сообщения в новом проекте

Скопируйте в чат Cursor (Agent mode):

```
Ты внедряешь у нас ту же оргмодель агентов, что в файле docs/AGENT_TEAM_BOOTSTRAP.md
(если файла ещё нет — я вставлю его содержимое ниже / он уже в репо).

Стек проекта: {{STACK — например Flutter+local_api+Python / FastAPI / …}}
Продукт: {{PRODUCT_NAME}}
Localhost URL приёмки: {{LOCAL_URL — например http://127.0.0.1:8000/}}
Деплой prod/VPS: {{как деплоим или «пока только localhost»}}

Сделай:
1. .cursor/rules/: orchestrator, team-org, architect, frontend|backend|… под стек,
   tester, fixer, client (+ coder как маршрутизатор если нужен).
2. .cursor/skills/: коротко skill-first для каждой роли + client-review + deploy.
3. knowledge/: README, _index, engineering/roles + engineering/sources/<agent>/,
   area_* под наши продуктовые зоны с roles/client.md и roles/agent.md раздельно.
4. docs/TEAM_ARCHITECTURE.md по шаблону из bootstrap.
5. В orchestrator: Архитектор = спека в memory; Оркестратор = диспетчер;
   skill-first; макс. 3 тикета Клиента C-* за проход → стоп «готов продолжить»;
   инженеров звать только при chain.md; prod/VPS только после Клиента без P0/P1
   и явного согласования пользователя.
6. memory/ — журнал тикетов (шаблоны, waves, _index) по docs/AGENT_TEAM_BOOTSTRAP.md § memory.

Не пиши код продукта — только каркас ролей/KB/memory/доков.
```

---

## Роли (минимальный набор)

| Роль | Назначение |
|------|------------|
| **Оркестратор** | Диспетчер пайплайна, лимит 3 `C-*`, localhost, gate на prod |
| **Архитектор** | Спеки и границы слоёв; не менеджер бэклога |
| **Инженеры по стеку** | Frontend / Backend / AI Bridge — или свои роли из реестра |
| **Тестировщик** | Один этап; режимы KB по стеку в `sources/tester/…` |
| **Фиксер** | Один этап; runbooks в `sources/fixer/…` |
| **Клиент** | Единственный вердикт пользователю; тикеты `C-*` |

Не плодить Архитектора/Кодера/Тестера «на каждый модуль продукта» — доменные зоны живут в `knowledge/area_*`, инженеры общие.

---

## Пайплайн

1. Клиент → `memory/tickets/C-xx-slug/` + `_index.md`  
2. Оркестратор → `memory/waves/` (≤3) + `before_sha`  
3. Архитектор → `architect-spec.md` + `chain.md` (**до кода**)  
4. Инженеры строго по chain  
5. Тестер + `guards.md` + regression-guards  
6. Фиксер до зелёного  
7. Localhost → Клиент  
8. Стоп, если остались `C-*` сверх лимита 3  
9. Prod — только после приёмки + «согласовано»  

---

## memory/ — журнал тикетов (обязателен)

Скопируйте промпт ниже **вторым** сообщением в целевой репо, если memory ещё нет — или включите в первый прогон.

### Промпт: создать `memory/`

```
Добавь в этот репозиторий журнал memory/ для тикетов агентной команды.

Сделай структуру:

memory/
  README.md
  _index.md
  _templates/
    ticket.md
    architect-spec.md
    chain.md
    decisions.md
    guards.md
    status.md
    wave.md
  tickets/README.md
  waves/README.md

Шаблоны по смыслу:
- ticket.md — ID, P0–P3, area, repro, expected/actual, [MKT] опционально
- architect-spec.md — goal, in/out scope, layers, contracts, AC, risks; эскалация mid-flight
- chain.md — упорядоченные шаги Role + paths + checkbox; запрет параллели на пересекающихся путях
- decisions.md — before_sha, лог ролей, план rollback
- guards.md — что закрывает тикет; дубль в regression-guards скилла Клиента
- status.md — open | in_wave | done | rolled_back
- wave.md — до 3 тикетов за проход, before_sha волны

Обнови правила:
1. orchestrator — перед волной waves/; инженеров только при chain.md;
   mid-flight → стоп → Архитектор; закрытие C-* через memory + guard.
2. architect — architect-spec.md + chain.md ДО кода.
3. client — каждый C-* = папка tickets/C-xx-slug/ + строка в _index.md.
4. coder/fixer/инженеры — не параллелить overlapping paths; не менять архитектуру без chain.
5. TEAM_ARCHITECTURE — секция memory/.

Параллелизм: один чат по chain — норма; overlapping paths без merge-плана Архитектора — нельзя;
параллель только research.

Откат: git (before_sha); memory не удалять после done.
Не пиши код продукта — только memory/ + org-docs/rules.
Префикс тикетов: C-*.
```

### Чеклист memory в другом проекте

- [ ] Есть `memory/_index.md` и `_templates/`
- [ ] Orchestrator/Architect/Client знают про папку
- [ ] В README: chain обязателен до инженеров
- [ ] Понятен откат: git + `decisions.md`

---

## Skill-first

1. `.cursor/rules/<role>.mdc`  
2. `.cursor/skills/<prefix>-<role>/SKILL.md` — **часто стоп**  
3. `knowledge/engineering/roles/<role>.md`  
4. `knowledge/area_*/roles/agent.md` (Клиент → `client.md`)  
5. Толстые `sources/` — только при пробеле  

---

## Дерево файлов для копирования

```
.cursor/
  rules/
    orchestrator.mdc      # alwaysApply: true
    team-org.mdc          # alwaysApply: true
    client.mdc            # alwaysApply: true
    architect.mdc
    frontend.mdc          # или ваши имена
    backend.mdc
    ai-bridge.mdc         # опционально
    coder.mdc             # маршрутизатор «не монолит»
    tester.mdc
    fixer.mdc
    # плюс ваши sync/deploy rules
  skills/
    {{prefix}}-architect/SKILL.md
    {{prefix}}-frontend/SKILL.md
    {{prefix}}-backend/SKILL.md
    {{prefix}}-ai-bridge/SKILL.md
    {{prefix}}-tester/SKILL.md
    {{prefix}}-fixer/SKILL.md
    {{prefix}}-client-review/
      SKILL.md
      checklist-acceptance.md
      remarks-to-orchestrator.md
      report-template.md
      regression-guards.md
    {{prefix}}-deploy/SKILL.md
docs/
  TEAM_ARCHITECTURE.md
  AGENT_TEAM_BOOTSTRAP.md   # этот файл
knowledge/
  README.md
  _index.md
  engineering/
    roles/   # тонкие оболочки
    shared/
    sources/
      architect/
      frontend/
      backend/
      ai_bridge/
      tester/{frontend,backend,ai_bridge,shared}/
      fixer/{frontend,backend,ai_bridge,shared}/
  area_{{zone}}/
    _index.md
    sources/
    shared/
    roles/client.md
    roles/agent.md
memory/
  README.md
  _index.md
  _templates/…
  tickets/
  waves/
```

---

## Обязательные правила в orchestrator.mdc (вставить смыстом)

- Не писать финальный код до Шага архитектора.  
- Архитектор не диспетчер; пишет `architect-spec.md` + `chain.md` в `memory/tickets/…`.  
- Инженеров звать **только** при наличии `chain.md`.  
- Skill-first.  
- Тикет `C-*` закрыт только с **guard** (`memory/…/guards.md` + regression-guards).  
- **Макс. 3** `C-*` за проход → стоп-блок «Готов дальше…».  
- Перед волной — файл в `memory/waves/` + `before_sha`.  
- Prod/VPS запрещён при открытых P0/P1 и без явного «да» пользователя.  
- Итоговый вердикт волны — роль **Клиент**.

Шаблон стоп-блока:

```
⏸️ **ОРКЕСТРАТОР — СТОП ПРОХОДА (лимит 3 тикета)**
**Закрыто:** …
**Осталось:** …
**Готов дальше отрабатывать оставшиеся тикеты — напишите «продолжить».**
```

---

## Клиент (кратко для client.mdc)

- Не пишет код.  
- Смотрит {{LOCAL_URL}}, сценарии, придирки к UX/логике.  
- Каждый `C-xx` → `memory/tickets/C-xx-slug/` + `_index.md`.  
- Может выписать >3 тикетов; Оркестратор режет волну до 3.

---

## Один чат vs Multitask Cursor

- **Один чат + роли-баннеры** — основной режим оркестрации; лимит 3 тикета защищает контекст.  
- **Multitask / несколько агентов** — имеет смысл для *независимого* исследования или параллельных несвязанных задач; сводку и приёмку Клиента всё равно ведёт один Оркестратор-чат, иначе два «источника правды».  
Подробнее — в `TEAM_ARCHITECTURE.md` целевого проекта после копирования.

---

## Чеклист переноса

- [ ] Скопированы rules + skills + knowledge skeleton  
- [ ] Есть `memory/` (_index, _templates, tickets, waves)  
- [ ] Префикс скиллов `{{prefix}}-` уникален для проекта  
- [ ] Подставлены LOCAL_URL, стек, зоны `area_*`  
- [ ] `TEAM_ARCHITECTURE.md` актуален (секция memory)  
- [ ] Первый прогон: мелкая задача → Клиент → папка C-* → chain до кода → стоп-отчёт  
- [ ] VPS/prod gate проверен на «не деплоить без согласования»
