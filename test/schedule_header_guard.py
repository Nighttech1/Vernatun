"""Guard: header sections are separate pages; dropdown is links only."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

PAGES = [
    "about.html",
    "schedule.html",
    "materials.html",
    "contacts.html",
    "articles.html",
    "articles/esli-stesnyaeshsya.html",
    "articles/kak-prohodit-vstrecha.html",
    "articles/kakoi-armyanskii.html",
]
for name in PAGES:
    path = ROOT / name
    assert path.is_file(), name
    text = path.read_text(encoding="utf-8")
    assert 'src="/js/site.js"' in text, name

home = (ROOT / "index.html").read_text(encoding="utf-8")
assert "film-hero" in home
assert 'id="club"' in home
assert 'id="formats"' in home
assert "armenian speaking club" in home

nav = (ROOT / "js" / "site.js").read_text(encoding="utf-8")
for label in ["О нас", "Расписание", "Учебные материалы", "Статьи", "Контакты"]:
    assert label in nav, label
assert "item.blurb" not in nav
assert "item.kicker" not in nav
assert "/#club" in nav
assert "/#schedule" in nav
assert "/#articles" in nav
assert "/#contact" in nav

schedule_js = nav
for needle in ["Игровой формат", "2026-9-12", "Волейбол", "Этника"]:
    assert needle in schedule_js, needle

print("ok: separate pages, articles, link-only menu")
