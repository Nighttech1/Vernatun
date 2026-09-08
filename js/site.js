(function () {
  var root = document.documentElement.getAttribute('data-root') || '/';

  function href(path) {
    if (!path) return root;
    if (path.indexOf('http') === 0 || path.indexOf('#') === 0) return path;
    if (path.charAt(0) === '/') return path;
    return root.replace(/\/$/, '') + '/' + path;
  }

  var items = [
    {
      id: 'about',
      label: 'О нас',
      href: '/#club',
      links: [
        { href: '/#club', label: 'О клубе' },
        { href: '/#formats', label: 'Форматы встреч' },
        { href: '/#atmosphere', label: 'Атмосфера' },
        { href: '/#faq', label: 'Вопросы' },
      ],
    },
    {
      id: 'schedule',
      label: 'Расписание',
      href: '/#schedule',
      links: [
        { href: '/#schedule', label: 'Календарь сентября' },
        { href: 'https://t.me/vernatunbot', label: 'Запись на встречу' },
      ],
    },
    {
      id: 'materials',
      label: 'Учебные материалы',
      href: '/#materials',
      links: [
        { href: '/#materials', label: 'Все материалы' },
        { href: '/materials/podcasts/ideal-life/index.html', label: 'Культ идеальной жизни' },
      ],
    },
    {
      id: 'articles',
      label: 'Статьи',
      href: '/#articles',
      links: [
        { href: '/#articles', label: 'Все статьи' },
        { href: '/articles/esli-stesnyaeshsya.html', label: 'Если стесняешься говорить' },
        { href: '/articles/kak-prohodit-vstrecha.html', label: 'Как проходит встреча' },
        { href: '/articles/kakoi-armyanskii.html', label: 'Какой армянский мы говорим' },
      ],
    },
    {
      id: 'contacts',
      label: 'Контакты',
      href: '/#contact',
      links: [
        { href: '/#contact', label: 'Как с нами связаться' },
        { href: 'https://t.me/+n7clld6EXN9kYjUy', label: 'Чат клуба' },
        { href: 'https://t.me/MASClubb', label: 'Канал клуба' },
        { href: 'https://t.me/vernatunbot', label: 'Бот записи' },
      ],
    },
  ];

  function linkAttrs(link) {
    var external = link.href.indexOf('http') === 0;
    return external ? ' target="_blank" rel="noopener noreferrer"' : '';
  }

  function menuLinks(item, extraClass) {
    return item.links.map(function (link) {
      return (
        '<li><a href="' + link.href + '"' + linkAttrs(link) +
        ' class="' + extraClass + '" @click="closeAll()">' + link.label + '</a></li>'
      );
    }).join('');
  }

  function headerHtml() {
    var desktop = items.map(function (item) {
      return (
        '<div class="relative" @mouseenter="openPanel(\'' + item.id + '\')" @mouseleave="scheduleClose()">' +
          '<a href="' + item.href + '" class="site-nav-link inline-flex items-center gap-1 rounded-md px-3 py-2 text-sm font-semibold text-azure/90 transition hover:bg-white/70 hover:text-azure" ' +
          ':class="open === \'' + item.id + '\' ? \'bg-white text-azure shadow-sm\' : \'\'" ' +
          '@click="closeAll()" @focus="openPanel(\'' + item.id + '\')">' +
            '<span>' + item.label + '</span>' +
            '<svg class="h-3.5 w-3.5 text-azure/50 transition" :class="open === \'' + item.id + '\' ? \'rotate-180\' : \'\'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M6 9l6 6 6-6"/></svg>' +
          '</a>' +
          '<div class="absolute left-0 top-full z-50 min-w-[15rem] pt-2" x-show="open === \'' + item.id + '\'" x-cloak x-transition.opacity.duration.160ms @mouseenter="cancelClose()" @mouseleave="scheduleClose()">' +
            '<ul class="overflow-hidden rounded-xl border border-azure/12 bg-parchment py-2 shadow-lift">' +
              menuLinks(item, 'block px-4 py-2.5 text-sm font-semibold text-azure transition hover:bg-white') +
            '</ul>' +
          '</div>' +
        '</div>'
      );
    }).join('');

    var mobile = items.map(function (item) {
      return (
        '<div class="rounded-lg border border-azure/10 bg-white/50">' +
          '<a href="' + item.href + '" class="block px-3 py-3 font-semibold text-azure" @click="closeAll()">' + item.label + '</a>' +
          '<ul class="border-t border-mist/80 px-3 pb-2">' +
            menuLinks(item, 'block py-2 text-sm font-semibold text-azure/90') +
          '</ul>' +
        '</div>'
      );
    }).join('');

    return (
      '<header class="relative sticky top-0 z-50 border-b border-mist/80 bg-parchment/95 backdrop-blur-md" x-data="siteHeader()" @keydown.escape.window="closeAll()">' +
        '<div class="mx-auto flex max-w-6xl items-center justify-between gap-3 px-4 py-2.5 sm:px-6">' +
          '<a href="/" class="flex min-w-0 items-center gap-3" @click="closeAll()">' +
            '<img src="/images/favicon-192.png" alt="Эмблема Вернатун" class="h-10 w-10 shrink-0 object-contain" width="40" height="40" />' +
            '<div class="min-w-0">' +
              '<p class="font-display text-sm font-bold leading-tight text-azure sm:text-base">Вернатун</p>' +
              '<p class="truncate text-[11px] text-ink/60 sm:text-xs">Armenian Club · Москва</p>' +
            '</div>' +
          '</a>' +
          '<nav class="relative hidden items-center gap-0.5 lg:flex" aria-label="Разделы сайта">' + desktop + '</nav>' +
          '<div class="flex items-center gap-2">' +
            '<a href="/#schedule" class="hidden items-center rounded bg-terracotta px-3.5 py-2 text-xs font-semibold uppercase tracking-wider text-white transition hover:bg-terracotta/90 sm:inline-flex" @click="closeAll()">В расписание</a>' +
            '<button type="button" class="inline-flex h-10 w-10 items-center justify-center rounded-md border border-azure/15 text-azure lg:hidden" @click="mobile = !mobile" :aria-expanded="mobile ? \'true\' : \'false\'" aria-label="Открыть разделы">' +
              '<svg x-show="!mobile" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" d="M4 7h16M4 12h16M4 17h16"/></svg>' +
              '<svg x-show="mobile" x-cloak class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 6l12 12M18 6L6 18"/></svg>' +
            '</button>' +
          '</div>' +
        '</div>' +
        '<div id="mobile-nav" class="border-t border-mist bg-parchment lg:hidden" x-show="mobile" x-cloak>' +
          '<div class="mx-auto max-w-6xl space-y-1 px-4 py-3">' + mobile + '</div>' +
        '</div>' +
      '</header>'
    );
  }

  function footerHtml() {
    return (
      '<footer class="border-t border-mist bg-azure text-white">' +
        '<div class="mx-auto flex max-w-6xl flex-col items-center gap-3 px-4 py-8 text-center sm:px-6">' +
          '<p class="text-sm text-white/80">Московский армянский разговорный клуб Вернатун</p>' +
          '<a href="/#contact" class="text-sm font-semibold text-white underline decoration-sungold/70 underline-offset-4">Контакты и запись</a>' +
          '<p class="text-[11px] text-white/45">© Vernatun Armenian Club</p>' +
        '</div>' +
      '</footer>'
    );
  }

  function lightboxHtml() {
    return (
      '<div x-show="active" x-transition.opacity.duration.200ms class="fixed inset-0 z-[60] flex items-center justify-center bg-ink/80 p-4 backdrop-blur-sm" style="display: none;" @click.self="close()" role="dialog" aria-modal="true" :aria-label="caption || \'Просмотр изображения\'">' +
        '<button type="button" class="absolute right-4 top-4 rounded-full border border-white/30 bg-white/10 p-2 text-white transition hover:bg-white/20" @click="close()" aria-label="Закрыть">' +
          '<svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 6l12 12M18 6L6 18"/></svg>' +
        '</button>' +
        '<figure class="max-h-[90vh] max-w-5xl">' +
          '<img :src="src" :alt="caption" class="max-h-[80vh] w-auto max-w-full rounded-md border border-white/10 object-contain" width="1200" height="800" />' +
          '<figcaption class="mt-3 text-center text-sm text-white/80" x-text="caption"></figcaption>' +
        '</figure>' +
      '</div>'
    );
  }

  function mount(id, html) {
    var slot = document.getElementById(id);
    if (slot) slot.innerHTML = html;
  }

  mount('site-header', headerHtml());

  function bindFilmHeader() {
    var header = document.querySelector('#site-header header');
    if (!header || !document.querySelector('.film-hero')) return;
    header.classList.add('is-film');
    function onScroll() {
      header.classList.toggle('is-solid', window.scrollY > 48);
    }
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindFilmHeader);
  } else {
    bindFilmHeader();
  }

  document.addEventListener('alpine:init', function () {
    Alpine.data('lightbox', function () {
      return {
        active: false,
        src: '',
        caption: '',
        openLb: function (src, caption) {
          this.src = src;
          this.caption = caption || '';
          this.active = true;
          document.body.style.overflow = 'hidden';
        },
        close: function () {
          this.active = false;
          this.src = '';
          this.caption = '';
          document.body.style.overflow = '';
        },
      };
    });

    Alpine.data('siteHeader', function () {
      return {
        open: null,
        mobile: false,
        closeTimer: null,
        openPanel: function (id) {
          this.cancelClose();
          this.open = id;
        },
        scheduleClose: function () {
          var self = this;
          this.cancelClose();
          this.closeTimer = setTimeout(function () { self.open = null; }, 180);
        },
        cancelClose: function () {
          if (this.closeTimer) {
            clearTimeout(this.closeTimer);
            this.closeTimer = null;
          }
        },
        closeAll: function () {
          this.open = null;
          this.mobile = false;
        },
      };
    });

    Alpine.data('clubCalendar', function () {
      var monthNames = [
        'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
        'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
      ];
      var img = function (name) { return '/images/' + name; };
      var events = [
        { id: 'talk-5', date: '2026-9-5', kind: 'talk', kindLabel: 'Разговорный', title: 'Игровой формат', time: '15:00', image: img('format-02.jpg'), description: 'Играем в «Бункер» и вичель/зичель. Слова всплывают сами — без учебника и оценок, можно ошибаться и смеяться.' },
        { id: 'talk-10', date: '2026-9-10', kind: 'talk', kindLabel: 'Разговорный', title: 'Что если…', time: '20:00', image: img('format-01.png'), description: 'Много вопросов «а что если?». Фантазируем, спорим и пробуем сформулировать мысль на армянском.' },
        { id: 'talk-12', date: '2026-9-12', kind: 'talk', kindLabel: 'Разговорный', title: 'Еда', time: '15:00', image: img('format-03.png'), description: 'Любимые блюда, семейные рецепты и места, куда зовём друзей поесть. Говорим просто, как за столом.' },
        { id: 'talk-17', date: '2026-9-17', kind: 'talk', kindLabel: 'Разговорный', title: 'В другом месте трава зеленее', time: '20:00', image: img('format-01.png'), description: 'Сравниваем города, привычки и мечты о «другой жизни». Можно не соглашаться — так интереснее.' },
        { id: 'talk-19', date: '2026-9-19', kind: 'talk', kindLabel: 'Разговорный', title: 'Лень и прокрастинация', time: '15:00', image: img('format-01.png'), description: 'Честно говорим, почему откладываем дела. Тема уже всплывала — продолжим с новых углов, без нотаций.' },
        { id: 'talk-24', date: '2026-9-24', kind: 'talk', kindLabel: 'Разговорный', title: 'Спорт', time: '20:00', image: img('format-04.jpg'), description: 'Как двигаемся, за чем следим и что бесит в зале. Разговор, не тренировка.' },
        { id: 'talk-26', date: '2026-9-26', kind: 'talk', kindLabel: 'Разговорный', title: 'География и путешествия', time: '15:00', image: img('format-01.png'), description: 'Карты, маршруты и места, куда хочется вернуться. Рассказываем своими словами.' },
        { id: 'ethnic-12', date: '2026-9-12', kind: 'ethnic', kindLabel: 'Этника', title: 'Этника', time: '19:00', image: img('format-03.png'), description: 'Встреча про культуру, традиции и свои истории. Отдельный вечерний формат — можно прийти после дневного разговорного.' },
        { id: 'ethnic-26', date: '2026-9-26', kind: 'ethnic', kindLabel: 'Этника', title: 'Этника', time: '19:00', image: img('format-03.png'), description: 'Вечер про корни, обычаи и то, что хочется передать дальше. Говорим тепло и без лекции.' },
        { id: 'volley-5', date: '2026-9-5', kind: 'volley', kindLabel: 'Волейбол', title: 'Волейбол', time: '17:00', image: img('format-04.jpg'), description: 'Играем в волейбол: разминка, подачи и командный дух. Языковой экзамен не сдаём — просто играем вместе.' },
        { id: 'volley-12', date: '2026-9-12', kind: 'volley', kindLabel: 'Волейбол', title: 'Волейбол', time: '17:00', image: img('format-04.jpg'), description: 'Субботняя игра. Подойдёт и тем, кто давно не выходил на площадку — главное настроение.' },
        { id: 'volley-19', date: '2026-9-19', kind: 'volley', kindLabel: 'Волейбол', title: 'Волейбол', time: '17:00', image: img('format-04.jpg'), description: 'Волейбол вне стен клуба. Если тема дня уже обсудили днём — вечером можно просто поиграть.' },
        { id: 'volley-26', date: '2026-9-26', kind: 'volley', kindLabel: 'Волейбол', title: 'Волейбол', time: '17:00', image: img('format-04.jpg'), description: 'Закрываем сентябрь игрой. Приходите в удобной обуви, мяч и компания уже будут.' },
      ];
      events.forEach(function (ev) {
        var parts = ev.date.split('-');
        ev.dateLabel = parts[2].replace(/^0/, '') + ' сентября';
      });
      var byDate = {};
      events.forEach(function (ev) {
        if (!byDate[ev.date]) byDate[ev.date] = [];
        byDate[ev.date].push(ev);
      });
      Object.keys(byDate).forEach(function (key) {
        byDate[key].sort(function (a, b) { return a.time.localeCompare(b.time); });
      });
      function dateKey(d) {
        return d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate();
      }
      return {
        year: 2026,
        month: 8,
        monthNames: monthNames,
        weekDays: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'],
        get title() { return this.monthNames[this.month] + ' ' + this.year; },
        get weeks() {
          var first = new Date(this.year, this.month, 1);
          var start = new Date(first);
          var mondayOffset = (first.getDay() + 6) % 7;
          start.setDate(1 - mondayOffset);
          var weeks = [];
          var cursor = new Date(start);
          for (var w = 0; w < 6; w++) {
            var week = [];
            for (var d = 0; d < 7; d++) {
              var cellDate = new Date(cursor);
              var cellEvents = byDate[dateKey(cellDate)] || [];
              var selectedId = this.selectedId;
              week.push({
                date: cellDate.getDate(),
                inMonth: cellDate.getMonth() === this.month,
                isToday: this.isToday(cellDate),
                events: cellEvents,
                hasSelection: cellEvents.some(function (ev) { return ev.id === selectedId; }),
              });
              cursor.setDate(cursor.getDate() + 1);
            }
            weeks.push(week);
          }
          return weeks;
        },
        isToday: function (d) {
          var t = new Date();
          return d.getDate() === t.getDate() && d.getMonth() === t.getMonth() && d.getFullYear() === t.getFullYear();
        },
        selectedId: 'talk-10',
        get selected() {
          for (var i = 0; i < events.length; i++) {
            if (events[i].id === this.selectedId) return events[i];
          }
          return null;
        },
        get siblings() {
          if (!this.selected) return [];
          return byDate[this.selected.date] || [];
        },
        selectId: function (id) {
          this.selectedId = id;
          var ev = this.selected;
          if (!ev) return;
          var parts = ev.date.split('-');
          this.year = Number(parts[0]);
          this.month = Number(parts[1]) - 1;
        },
        selectDay: function (cell) {
          if (!cell.events.length) return;
          var already = cell.events.some(function (ev) { return ev.id === this.selectedId; }, this);
          this.selectedId = already ? this.selectedId : cell.events[0].id;
        },
        barClass: function (kind, active) {
          var base = kind === 'talk' ? 'bg-azure' : (kind === 'ethnic' ? 'bg-sungold' : 'bg-terracotta');
          return active ? base + ' ring-2 ring-ink/30 ring-offset-1' : base;
        },
        kindClass: function (kind) {
          if (kind === 'talk') return 'bg-azure text-white';
          if (kind === 'ethnic') return 'bg-sungold text-ink';
          return 'bg-terracotta text-white';
        },
        prevMonth: function () {
          if (this.month === 0) { this.month = 11; this.year -= 1; }
          else this.month -= 1;
        },
        nextMonth: function () {
          if (this.month === 11) { this.month = 0; this.year += 1; }
          else this.month += 1;
        },
      };
    });
  });

  window.VernatunChrome = {
    href: href,
    mountRest: function () {
      mount('site-footer', footerHtml());
      if (!document.getElementById('site-lightbox')) {
        var box = document.createElement('div');
        box.id = 'site-lightbox';
        box.innerHTML = lightboxHtml();
        document.body.appendChild(box);
      }
      var els = document.querySelectorAll('.reveal');
      if (!('IntersectionObserver' in window)) {
        els.forEach(function (el) { el.classList.add('reveal-visible'); });
        return;
      }
      var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (en) {
          if (en.isIntersecting) {
            en.target.classList.add('reveal-visible');
            io.unobserve(en.target);
          }
        });
      }, { rootMargin: '0px 0px -8% 0px', threshold: 0.08 });
      els.forEach(function (el) { io.observe(el); });
    },
  };
})();
