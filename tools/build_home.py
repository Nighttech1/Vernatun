from pathlib import Path

root = Path(__file__).resolve().parents[1]
index = (root / "index.html").read_text(encoding="utf-8")
about = (root / "about.html").read_text(encoding="utf-8")
schedule = (root / "schedule.html").read_text(encoding="utf-8")

faq = about.split("<!-- FAQ -->", 1)[1].split("</main>", 1)[0]
faq = faq.replace('src="gallery/', 'src="/gallery/')

cal = schedule.split('x-data="clubCalendar()"', 1)[1]
cal = '        <div class="reveal mt-10 grid items-start gap-6 lg:grid-cols-[minmax(0,1.35fr)_minmax(17rem,22rem)]" x-data="clubCalendar()"' + cal
cal = cal.split("</section>", 1)[0]

hero = r'''
    <section class="film-hero" id="top" aria-label="Заставка клуба">
      <div class="film-reel" aria-hidden="true">
        <img src="/gallery/1.jpg" alt="" />
        <img src="/gallery/2.jpg" alt="" />
        <img src="/gallery/4.jpg" alt="" />
        <img src="/gallery/5.jpg" alt="" />
        <img src="/gallery/6.jpg" alt="" />
      </div>
      <div class="film-scrim"></div>
      <p class="film-quote">«Сказать вслух — уже быть среди своих.»<span>Вернатун · Москва</span></p>
      <div class="film-mark">
        <strong>Vernatun</strong>
        <em>armenian speaking club</em>
      </div>
    </section>

    <section id="club" class="border-b border-mist py-20 sm:py-28">
      <div class="mx-auto grid max-w-6xl gap-12 px-4 sm:px-6 lg:grid-cols-[minmax(0,1.2fr)_minmax(16rem,22rem)] lg:items-end">
        <div class="reveal">
          <p class="text-xs font-bold uppercase tracking-[0.22em] text-terracotta">О нас</p>
          <h1 class="mt-4 font-display text-4xl font-bold leading-tight text-azure sm:text-5xl">О нашем клубе</h1>
          <p class="mt-6 max-w-xl text-lg leading-relaxed text-ink/80">Вернатун — уютное пространство, где говорят на родном языке, обсуждают живые темы и остаются за столом чуть дольше, чем планировали.</p>
          <p class="mt-4 max-w-xl text-base leading-relaxed text-ink/70">Здесь находят друзей, практикуют армянский и выдыхают от города. Без оценок и без сцены.</p>
        </div>
        <div class="reveal space-y-8 border-t border-azure/15 pt-6 lg:border-l lg:border-t-0 lg:pl-8 lg:pt-0">
          <div>
            <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Атмосфера</p>
            <h2 class="mt-2 font-display text-2xl text-azure">Дружеская среда</h2>
            <p class="mt-2 text-sm leading-relaxed text-ink/70">Открытое общение, новые знакомства и поддержка без формальностей.</p>
          </div>
          <div>
            <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Практика</p>
            <h2 class="mt-2 font-display text-2xl text-azure">Живой язык</h2>
            <p class="mt-2 text-sm leading-relaxed text-ink/70">Разговорная практика на армянском — для любого уровня, в спокойном темпе.</p>
          </div>
          <div>
            <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Досуг</p>
            <h2 class="mt-2 font-display text-2xl text-azure">Игры и отдых</h2>
            <p class="mt-2 text-sm leading-relaxed text-ink/70">Настолки, кофе и компания, в которой не нужно спешить уходить.</p>
          </div>
        </div>
      </div>
    </section>

    <section id="formats" class="bg-white/40 py-20 sm:py-28">
      <div class="mx-auto max-w-6xl px-4 sm:px-6">
        <div class="reveal flex items-end justify-between gap-6">
          <div>
            <p class="text-xs font-bold uppercase tracking-[0.22em] text-terracotta">Форматы</p>
            <h2 class="mt-3 font-display text-4xl font-bold text-azure">Как мы встречаемся</h2>
          </div>
          <p class="hidden max-w-xs text-sm leading-relaxed text-ink/65 sm:block">Разные форматы — один и тот же стол: можно говорить, играть, молчать рядом и всё равно быть в компании.</p>
        </div>
        <div class="format-stage mt-12">
          <article class="format-lead">
            <div class="cursor-pointer" role="button" tabindex="0" @click="openLb('/images/format-01.png', 'Разговорные встречи')" @keydown.enter="openLb('/images/format-01.png', 'Разговорные встречи')">
              <img src="/images/format-01.png" alt="Разговорные встречи" />
            </div>
            <div class="p-7">
              <div class="editorial-rule"></div>
              <h3 class="mt-5 font-display text-3xl text-azure">Разговорные встречи</h3>
              <p class="mt-3 max-w-md text-sm leading-relaxed text-ink/75">Живой язык и темы дня. Никакой лекции — только разговор, в котором можно подобрать слово.</p>
            </div>
          </article>
          <div class="format-side">
            <article class="format-tile">
              <div class="cursor-pointer" @click="openLb('/images/format-02.jpg', 'Настольные игры')"><img src="/images/format-02.jpg" alt="Настольные игры" /></div>
              <div class="p-4">
                <h3 class="font-display text-xl text-azure">Настольные игры</h3>
                <p class="mt-2 text-sm leading-relaxed text-ink/70">Смекалка, смех и знакомство без обязательного монолога.</p>
              </div>
            </article>
            <article class="format-tile">
              <div class="cursor-pointer" @click="openLb('/images/format-03.png', 'Неформальное общение')"><img src="/images/format-03.png" alt="Неформальное общение" /></div>
              <div class="p-4">
                <h3 class="font-display text-xl text-azure">Неформальное общение</h3>
                <p class="mt-2 text-sm leading-relaxed text-ink/70">Кофе, люди и разговор без повестки.</p>
              </div>
            </article>
            <article class="format-tile">
              <div class="cursor-pointer" @click="openLb('/images/format-04.jpg', 'Спортивные мероприятия')"><img src="/images/format-04.jpg" alt="Волейбол" /></div>
              <div class="p-4">
                <h3 class="font-display text-xl text-azure">Волейбол</h3>
                <p class="mt-2 text-sm leading-relaxed text-ink/70">Игра вне стен клуба — когда анонсируем в чате.</p>
              </div>
            </article>
          </div>
        </div>
      </div>
    </section>

    <section id="atmosphere" class="border-y border-mist py-20 sm:py-28">
      <div class="mx-auto max-w-6xl px-4 sm:px-6">
        <div class="reveal max-w-xl">
          <p class="text-xs font-bold uppercase tracking-[0.22em] text-terracotta">Атмосфера</p>
          <h2 class="mt-3 font-display text-4xl font-bold text-azure">Обычные наши встречи</h2>
          <p class="mt-3 text-ink/70">Болтаем, смеёмся, знакомимся. Нажмите кадр, если хотите посмотреть крупнее.</p>
        </div>
        <div
          class="reveal mt-10 flex items-center gap-2 sm:gap-4"
          x-data="{
            current: 0,
            slides: [
              { src: '/gallery/1.jpg', caption: 'Атмосфера клуба' },
              { src: '/gallery/2.jpg', caption: 'Атмосфера клуба' },
              { src: '/gallery/3.jpg', caption: 'Атмосфера клуба' },
              { src: '/gallery/4.jpg', caption: 'Атмосфера клуба' },
              { src: '/gallery/5.jpg', caption: 'Атмосфера клуба' },
              { src: '/gallery/6.jpg', caption: 'Атмосфера клуба' }
            ],
            get count() { return this.slides.length; },
            prev() { this.current = this.current === 0 ? this.count - 1 : this.current - 1; },
            next() { this.current = this.current === this.count - 1 ? 0 : this.current + 1; }
          }"
        >
          <button type="button" @click="prev()" class="carousel-nav-btn shrink-0 rounded-full bg-azure/80 p-2 sm:p-3 text-white focus:outline-none focus-visible:ring-2 focus-visible:ring-sungold" aria-label="Предыдущее фото">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path></svg>
          </button>
          <div class="relative min-w-0 flex-1 overflow-hidden rounded-2xl border border-azure/12 bg-ink">
            <div class="flex transition-transform duration-700 ease-out" :style="'transform: translateX(-' + (current * 100) + '%)'">
              <template x-for="(slide, i) in slides" :key="i">
                <div class="w-full flex-shrink-0">
                  <div class="gallery-slide-frame cursor-pointer" @click="openLb(slide.src, slide.caption)">
                    <img :src="slide.src" :alt="'Атмосфера клуба ' + (i + 1)" />
                  </div>
                </div>
              </template>
            </div>
          </div>
          <button type="button" @click="next()" class="carousel-nav-btn shrink-0 rounded-full bg-azure/80 p-2 sm:p-3 text-white focus:outline-none focus-visible:ring-2 focus-visible:ring-sungold" aria-label="Следующее фото">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
          </button>
        </div>
      </div>
    </section>
'''

schedule_block = '''
    <section id="schedule" class="py-20 sm:py-28">
      <div class="mx-auto max-w-6xl px-4 sm:px-6">
        <div class="reveal">
          <p class="text-xs font-bold uppercase tracking-[0.22em] text-terracotta">Расписание</p>
          <h2 class="mt-3 font-display text-4xl font-bold text-azure">Сентябрь</h2>
          <p class="mt-3 max-w-xl text-ink/70">Нажмите цветную полоску — справа откроется карточка встречи. Списка под календарём нет.</p>
        </div>
''' + cal + '''
      </div>
    </section>
'''

rest = '''
    <section id="materials" class="border-t border-mist py-20 sm:py-28">
      <div class="mx-auto max-w-3xl px-4 sm:px-6">
        <p class="text-xs font-bold uppercase tracking-[0.22em] text-terracotta">Учебные материалы</p>
        <h2 class="mt-3 font-display text-4xl font-bold text-azure">Слушать и следить за текстом</h2>
        <a href="/materials/podcasts/ideal-life/index.html" class="magazine-row group mt-10">
          <p class="text-xs font-bold uppercase tracking-widest text-terracotta">А2–В1</p>
          <div>
            <p class="font-display text-2xl text-azure group-hover:text-terracotta">Культ идеальной жизни и иллюзия соцсетей</p>
            <p class="mt-2 text-sm leading-relaxed text-ink/70">Подкаст на армянском с русским переводом и подсветкой реплик.</p>
          </div>
          <p class="text-sm font-semibold text-azure">Открыть</p>
        </a>
      </div>
    </section>

    <section id="articles" class="border-t border-mist bg-white/35 py-20 sm:py-28">
      <div class="mx-auto max-w-3xl px-4 sm:px-6">
        <p class="text-xs font-bold uppercase tracking-[0.22em] text-terracotta">Статьи</p>
        <h2 class="mt-3 font-display text-4xl font-bold text-azure">Перед первой встречей</h2>
        <a href="/articles/esli-stesnyaeshsya.html" class="magazine-row group">
          <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Новичкам</p>
          <p class="font-display text-2xl text-azure group-hover:text-terracotta">Если стесняешься говорить</p>
          <p class="text-sm text-ink/50">Читать</p>
        </a>
        <a href="/articles/kak-prohodit-vstrecha.html" class="magazine-row group">
          <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Встреча</p>
          <p class="font-display text-2xl text-azure group-hover:text-terracotta">Как проходит встреча</p>
          <p class="text-sm text-ink/50">Читать</p>
        </a>
        <a href="/articles/kakoi-armyanskii.html" class="magazine-row group">
          <p class="text-xs font-bold uppercase tracking-widest text-terracotta">Язык</p>
          <p class="font-display text-2xl text-azure group-hover:text-terracotta">Какой армянский мы говорим</p>
          <p class="text-sm text-ink/50">Читать</p>
        </a>
      </div>
    </section>

    <section id="contact" class="bg-azure py-20 text-white sm:py-28">
      <div class="mx-auto grid max-w-6xl gap-10 px-4 sm:px-6 lg:grid-cols-[1.1fr_0.9fr] lg:items-end">
        <div>
          <p class="text-xs font-bold uppercase tracking-[0.22em] text-sungold">Контакты</p>
          <h2 class="mt-3 font-display text-4xl font-bold">Приходите к нам</h2>
          <p class="mt-4 max-w-md text-sm leading-relaxed text-white/75">Анонсы — в канале и чате. Запись на слот — через бота. Можно написать, даже если идёте впервые и одни.</p>
        </div>
        <div class="space-y-4 text-lg">
          <a class="block border-b border-white/20 pb-3 font-display text-2xl hover:text-sungold" href="https://t.me/+n7clld6EXN9kYjUy" target="_blank" rel="noopener noreferrer">Чат клуба</a>
          <a class="block border-b border-white/20 pb-3 font-display text-2xl hover:text-sungold" href="https://t.me/MASClubb" target="_blank" rel="noopener noreferrer">Канал клуба</a>
          <a class="block border-b border-white/20 pb-3 font-display text-2xl hover:text-sungold" href="https://t.me/vernatunbot" target="_blank" rel="noopener noreferrer">Бот записи</a>
        </div>
      </div>
    </section>
'''

main = "<main id=\"top\">\n" + hero + "\n" + schedule_block + "\n" + rest + "\n" + faq + "\n  </main>\n"
start = index.find("  <main id=\"top\">")
end = index.find("  <div id=\"site-footer\"></div>")
if start < 0 or end < 0:
    raise SystemExit("markers missing")
index = index[:start] + main + index[end:]
(root / "index.html").write_text(index, encoding="utf-8")
print("home rebuilt", index.count("film-hero"), index.count('id="club"'))
