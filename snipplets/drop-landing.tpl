{# DROP: landing para cualquier página cuyo nombre empiece con "Drop" (Drop 1, Drop 2, ...).
   La elige templates/page.tpl. Para cada drop se cambian solo estas dos líneas. #}
{% set drop_fecha = '2026-10-15T20:00:00-03:00' %}
{% set drop_whatsapp = '5492915092667' %}
{% set drop_numero = page.name | lower | replace('drop', '') | replace(' ', '') %}
<link rel="stylesheet" href="{{ 'css/style-drop.scss' | static_url }}">
<script>document.documentElement.classList.add('is-drop-page');</script>

<div class="sgns-drop" data-drop-fecha="{{ drop_fecha }}">

  <!-- 1. HERO -->
  <section class="drop-hero">
    <video class="drop-hero__video" muted loop playsinline preload="none" poster="{{ 'hero-desktop-poster-v2.webp' | static_url }}" data-src-desktop="{{ 'hero-desktop-new.mp4' | static_url }}" data-src-mobile="{{ 'hero-mobile-new.mp4' | static_url }}"></video>
    <div class="drop-hero__shade"></div>
    <div class="drop-hero__grain"></div>

    <div class="drop-hero__inner">
      <span class="drop-eyebrow"><i></i>SGNS Studio · Edición limitada</span>
      <h1 class="drop-title" aria-label="{{ page.name }}">
        <span class="drop-title__word">DROP</span>
        <span class="drop-title__num">{{ drop_numero }}</span>
      </h1>
      <p class="drop-hero__lead">Una tanda corta de piezas. Cuando se agotan, no vuelven.</p>

      <div class="drop-count" role="timer" aria-label="Cuenta regresiva">
        <div class="drop-count__cell"><b data-c="d">00</b><span>Días</span></div>
        <div class="drop-count__cell"><b data-c="h">00</b><span>Horas</span></div>
        <div class="drop-count__cell"><b data-c="m">00</b><span>Min</span></div>
        <div class="drop-count__cell"><b data-c="s">00</b><span>Seg</span></div>
      </div>

      <div class="drop-hero__cta">
        <a class="drop-btn drop-btn--solid" href="https://wa.me/{{ drop_whatsapp }}?text=Quiero%20que%20me%20avisen%20cuando%20salga%20el%20drop" target="_blank" rel="noopener">Avisame cuando salga</a>
        <a class="drop-btn drop-btn--line" href="#drop-piezas">Ver las piezas</a>
      </div>
    </div>

    <a class="drop-scroll" href="#drop-manifiesto" aria-label="Bajar"><span></span></a>
  </section>

  <!-- 2. CINTA -->
  <div class="drop-marquee" aria-hidden="true">
    <div class="drop-marquee__track">
      <span>{{ page.name }} ✦ Edición limitada ✦ Sin reposición ✦ Temporada 26 ✦ Solo en Signos ✦</span>
      <span>{{ page.name }} ✦ Edición limitada ✦ Sin reposición ✦ Temporada 26 ✦ Solo en Signos ✦</span>
      <span>{{ page.name }} ✦ Edición limitada ✦ Sin reposición ✦ Temporada 26 ✦ Solo en Signos ✦</span>
      <span>{{ page.name }} ✦ Edición limitada ✦ Sin reposición ✦ Temporada 26 ✦ Solo en Signos ✦</span>
    </div>
  </div>

  <!-- 3. MANIFIESTO -->
  <section class="drop-manifiesto" id="drop-manifiesto">
    <div class="drop-wrap">
      <span class="drop-kicker" data-reveal>01 — El concepto</span>
      <p class="drop-manifiesto__text" data-reveal>
        No es una colección más. Es una <em>tirada corta</em>, pensada pieza por pieza, que sale una vez y se va.
        Sin stock infinito. Sin segunda vuelta.
      </p>
      <div class="drop-stats">
        <div class="drop-stat" data-reveal><b>04</b><span>Piezas en esta tanda</span></div>
        <div class="drop-stat" data-reveal><b>100</b><span>Unidades por modelo, máximo</span></div>
        <div class="drop-stat" data-reveal><b>0</b><span>Reposiciones</span></div>
      </div>
    </div>
  </section>

  <!-- 4. PIEZAS -->
  <section class="drop-piezas" id="drop-piezas">
    <div class="drop-wrap">
      <div class="drop-head" data-reveal>
        <span class="drop-kicker">02 — Las piezas</span>
        <h2 class="drop-h2">Lo que trae<br>el {{ page.name }}</h2>
      </div>
      <div class="drop-grid">
        <article class="drop-card drop-card--a" data-reveal>
          <img src="{{ 'categoria-buzos.webp' | static_url }}" alt="Buzo del {{ page.name }}" loading="lazy">
          <div class="drop-card__info"><span>Pieza 01</span><h3>Buzo</h3><em>Próximamente</em></div>
        </article>
        <article class="drop-card drop-card--b" data-reveal>
          <img src="{{ 'categoria-remeras.webp' | static_url }}" alt="Remera del {{ page.name }}" loading="lazy">
          <div class="drop-card__info"><span>Pieza 02</span><h3>Remera</h3><em>Próximamente</em></div>
        </article>
        <article class="drop-card drop-card--c" data-reveal>
          <img src="{{ 'categoria-jeans.webp' | static_url }}" alt="Jean del {{ page.name }}" loading="lazy">
          <div class="drop-card__info"><span>Pieza 03</span><h3>Jean</h3><em>Próximamente</em></div>
        </article>
        <article class="drop-card drop-card--d" data-reveal>
          <img src="{{ 'categoria-joggings.webp' | static_url }}" alt="Jogging del {{ page.name }}" loading="lazy">
          <div class="drop-card__info"><span>Pieza 04</span><h3>Jogging</h3><em>Próximamente</em></div>
        </article>
      </div>
    </div>
  </section>

  <!-- 5. CÓMO FUNCIONA -->
  <section class="drop-pasos">
    <div class="drop-wrap">
      <div class="drop-head" data-reveal>
        <span class="drop-kicker">03 — Cómo funciona</span>
        <h2 class="drop-h2">Tres pasos.<br>Nada más.</h2>
      </div>
      <ol class="drop-steps">
        <li data-reveal><b>01</b><h3>Pedí el aviso</h3><p>Escribinos por WhatsApp y te avisamos minutos antes de que abra.</p></li>
        <li data-reveal><b>02</b><h3>Entrá al drop</h3><p>Se habilita todo junto, a la hora indicada. Web y locales al mismo tiempo.</p></li>
        <li data-reveal><b>03</b><h3>Llevate la tuya</h3><p>Cada modelo tiene unidades contadas. Lo que se agota, no se repone.</p></li>
      </ol>
    </div>
  </section>

  <!-- 6. CIERRE -->
  <section class="drop-cierre">
    <div class="drop-wrap">
      <h2 class="drop-cierre__big" data-reveal>No hay<br>reposición.</h2>
      <p class="drop-cierre__p" data-reveal>El {{ page.name }} sale una sola vez. Que no te lo cuenten.</p>
      <div class="drop-hero__cta" data-reveal>
        <a class="drop-btn drop-btn--solid" href="https://wa.me/{{ drop_whatsapp }}?text=Quiero%20que%20me%20avisen%20cuando%20salga%20el%20drop" target="_blank" rel="noopener">Avisame cuando salga</a>
        <a class="drop-btn drop-btn--line" href="/productos/">Mientras tanto, ver productos</a>
      </div>
    </div>
  </section>

</div>

<script src="{{ 'js/drop.js' | static_url }}" defer></script>
