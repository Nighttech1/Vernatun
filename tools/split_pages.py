# One-off splitter used by the frontend pass. Safe to re-run.
from pathlib import Path

root = Path(__file__).resolve().parents[1]
index = (root / "index.html").read_text(encoding="utf-8")

chunk_start = index.find("    <!-- О клубе -->")
chunk_end = index.find("  <!-- Lightbox -->")
chunk = index[chunk_start:chunk_end]

def between(src, start, end):
    a = src.find(start)
    b = src.find(end, a)
    if a < 0 or b < 0:
        raise SystemExit(f"missing markers {start!r} {end!r}")
    return src[a:b]

about_body = between(chunk, "    <!-- О клубе -->", "    <!-- Форматы -->")
formats = between(chunk, "    <!-- Форматы -->", "    <!-- Медиа -->")
atmosphere = between(chunk, "    <!-- Медиа -->", "    <!-- Расписание -->")
schedule = between(chunk, "    <!-- Расписание -->", "    <!-- Учебные материалы -->")
materials = between(chunk, "    <!-- Учебные материалы -->", "    <!-- FAQ -->")
faq = between(chunk, "    <!-- FAQ -->", "    <!-- Контакты -->")

about_body = about_body.replace('id="about"', 'id="club"', 1)
about_body = about_body.replace("<h2 ", "<h1 ", 1).replace("</h2>", "</h1>", 1)
schedule = schedule.replace("<h2 ", "<h1 ", 1).replace("</h2>", "</h1>", 1)
schedule = schedule.replace('id="schedule"', 'id="calendar"', 1)
materials = materials.replace("<h2 ", "<h1 ", 1).replace("</h2>", "</h1>", 1)
materials = materials.replace('href="materials/', 'href="/materials/')

ASSETS = """  <script src="/js/tailwind-config.js"></script>
  <script src="https://cdn.tailwindcss.com"></script>
  <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.14.3/dist/cdn.min.js"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Libre+Caslon+Text:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="/css/site.css" />
  <link rel="icon" href="/favicon.ico" sizes="any" />
  <link rel="icon" type="image/png" sizes="32x32" href="/images/favicon-32.png" />
  <link rel="icon" type="image/png" sizes="192x192" href="/images/favicon-192.png" />
  <link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />
"""

def page(title, description, canonical, body, extra_head=""):
    return f"""<!DOCTYPE html>
<html class="scroll-smooth" lang="ru" data-root="/">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="{description}" />
  <title>{title}</title>
  <link rel="canonical" href="{canonical}" />
{ASSETS}{extra_head}</head>
<body class="paper-grain min-h-screen antialiased text-ink" x-data="lightbox()" @keydown.escape.window="close()">
  <div id="site-header"></div>
  <script src="/js/site.js"></script>
  <main>
{body}
  </main>
  <div id="site-footer"></div>
  <script>VernatunChrome.mountRest();</script>
</body>
</html>
"""

about_html = page(
    "О нас — Вернатун",
    "О московском армянском разговорном клубе Вернатун: форматы встреч, атмосфера и ответы на вопросы.",
    "https://vernatunspeakclub.com/about.html",
    about_body + "\n" + formats + "\n" + atmosphere + "\n" + faq,
)
(root / "about.html").write_text(about_html, encoding="utf-8")

schedule_html = page(
    "Расписание — Вернатун",
    "Календарь встреч клуба Вернатун на сентябрь 2026: разговорный, этника и волейбол.",
    "https://vernatunspeakclub.com/schedule.html",
    schedule,
)
(root / "schedule.html").write_text(schedule_html, encoding="utf-8")

materials_html = page(
    "Учебные материалы — Вернатун",
    "Подкасты и разборы для практики армянского языка в клубе Вернатун.",
    "https://vernatunspeakclub.com/materials.html",
    materials,
)
(root / "materials.html").write_text(materials_html, encoding="utf-8")

contacts_body = """
    <section class="py-16 sm:py-20">
      <div class="mx-auto max-w-3xl px-4 sm:px-6">
        <div class="reveal text-center">
          <h1 class="font-display text-3xl font-bold text-azure sm:text-4xl">Контакты</h1>
          <p class="mx-auto mt-4 max-w-xl text-lg leading-relaxed text-ink/75">Подписывайтесь на наши социальные сети, чтобы не пропустить анонсы новых встреч и мероприятий. Запись — через бота.</p>
        </div>
        <div class="reveal mt-10 grid gap-4">
          <a class="rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30" href="https://t.me/+n7clld6EXN9kYjUy" target="_blank" rel="noopener noreferrer">
            <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Чат</p>
            <p class="mt-2 font-display text-2xl text-azure">Telegram — чат клуба</p>
          </a>
          <a class="rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30" href="https://t.me/MASClubb" target="_blank" rel="noopener noreferrer">
            <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Канал</p>
            <p class="mt-2 font-display text-2xl text-azure">Telegram — канал клуба</p>
          </a>
          <a class="rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30" href="https://t.me/vernatunbot" target="_blank" rel="noopener noreferrer">
            <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Запись</p>
            <p class="mt-2 font-display text-2xl text-azure">Бот @vernatunbot</p>
          </a>
        </div>
      </div>
    </section>
"""
(root / "contacts.html").write_text(page(
    "Контакты — Вернатун",
    "Как связаться с московским армянским разговорным клубом Вернатун и записаться на встречу.",
    "https://vernatunspeakclub.com/contacts.html",
    contacts_body,
), encoding="utf-8")

doors = """
    <section class="border-t border-mist py-16 sm:py-20">
      <div class="mx-auto max-w-6xl px-4 sm:px-6">
        <div class="reveal text-center">
          <h2 class="font-display text-3xl font-bold text-azure sm:text-4xl">Куда зайти дальше</h2>
          <p class="mx-auto mt-3 max-w-2xl text-ink/70">Разделы открываются отдельными страницами — выберите, что нужно сейчас.</p>
        </div>
        <div class="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          <a href="/about.html" class="reveal rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30">
            <p class="font-display text-2xl text-azure">О нас</p>
            <p class="mt-2 text-sm text-ink/70">Клуб, форматы встреч, фото и вопросы.</p>
          </a>
          <a href="/schedule.html" class="reveal rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30">
            <p class="font-display text-2xl text-azure">Расписание</p>
            <p class="mt-2 text-sm text-ink/70">Календарь сентября и карточка встречи.</p>
          </a>
          <a href="/materials.html" class="reveal rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30">
            <p class="font-display text-2xl text-azure">Учебные материалы</p>
            <p class="mt-2 text-sm text-ink/70">Подкасты и разборы для практики.</p>
          </a>
          <a href="/articles.html" class="reveal rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30">
            <p class="font-display text-2xl text-azure">Статьи</p>
            <p class="mt-2 text-sm text-ink/70">Короткие тексты о том, как у нас говорят.</p>
          </a>
          <a href="/contacts.html" class="reveal rounded-xl border border-azure/12 bg-white p-6 shadow-card transition hover:border-azure/30">
            <p class="font-display text-2xl text-azure">Контакты</p>
            <p class="mt-2 text-sm text-ink/70">Чат, канал и запись на встречу.</p>
          </a>
        </div>
      </div>
    </section>
"""

hero_end = index.find("    <!-- О клубе -->")
head_end = index.find("  <script src=\"https://cdn.tailwindcss.com\"></script>")
head = index[:head_end]
head = head.replace('<html class="scroll-smooth" lang="ru">', '<html class="scroll-smooth" lang="ru" data-root="/">', 1)

hero = index[index.find("  <main id=\"top\">"):hero_end]
hero = hero.replace('href="#contact"', 'href="/contacts.html"')
hero = hero.replace('href="#about"', 'href="/about.html"')
hero = hero.replace('src="images/', 'src="/images/')

home = (
    head
    + "  <script src=\"/js/tailwind-config.js\"></script>\n"
    + "  <script src=\"https://cdn.tailwindcss.com\"></script>\n"
    + "  <script defer src=\"https://cdn.jsdelivr.net/npm/alpinejs@3.14.3/dist/cdn.min.js\"></script>\n"
    + "  <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\" />\n"
    + "  <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin />\n"
    + "  <link href=\"https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Libre+Caslon+Text:ital,wght@0,400;0,700;1,400&display=swap\" rel=\"stylesheet\" />\n"
    + "  <link rel=\"stylesheet\" href=\"/css/site.css\" />\n"
    + "</head>\n"
    + "<body class=\"paper-grain min-h-screen antialiased text-ink\" x-data=\"lightbox()\" @keydown.escape.window=\"close()\">\n"
    + "  <div id=\"site-header\"></div>\n"
    + "  <script src=\"/js/site.js\"></script>\n"
    + hero
    + doors
    + "  </main>\n"
    + "  <div id=\"site-footer\"></div>\n"
    + "  <script>VernatunChrome.mountRest();</script>\n"
    + "</body>\n</html>\n"
)
# head already includes everything up to tailwind script, which started inside head.
# Avoid duplicating </head> if head still has open head tag — head_end is before tailwind, so head has no closing head. Good.

(root / "index.html").write_text(home, encoding="utf-8")
print("wrote pages", len(about_html), len(schedule_html), len(materials_html))
