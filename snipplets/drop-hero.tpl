{# HERO DROP: video a pantalla completa arriba de los productos, igual que el hero del inicio
   (con la misma intro cinematográfica, pero con el nombre del Drop en blanco en lugar del logo),
   debajo una fila con tres veces el video de escritorio y después el nombre del Drop en grande,
   que entra animado al aparecer en pantalla, antes de los productos.
   Lo incluye templates/category.tpl en las categorías que tienen "drop" en la URL (Drop 01, Drop 02, ...).
   Usa las clases del hero del inicio; lo propio está en style-redesign.scss (body.sgns-drop-cat).
   Para cambiar los videos: static/drop-hero-mobile-v2.mp4 (celular) y static/drop-hero-desktop.mp4 (escritorio),
   con sus portadas drop-hero-mobile-poster.webp y drop-hero-desktop-poster.webp (el primer fotograma de cada video).
   Versión corta (Drop 02 en adelante): solo el hero y los tres videos, y después los productos.
   Cyber Monday (categoría con "cyber" en la URL) usa esta versión corta, con los videos del Drop 02 hasta tener los propios.
   La versión completa (historia, zoom del nombre y "Lo que se dice") queda solo para el Drop 01. #}
{# El Drop 01 también usa la versión corta, con sus propios videos (es_drop1) #}
{% set es_drop1 = 'drop-01' in category.url | lower %}
{% set drop_largo = false %}
{# Drop 03: videos de DROP03_REEL (hero 0-9 s; clips 1,6-5,1 · 4,5-8 · 9-12,5 s).
   sin_video: hero negro sin la fila de clips, para un Drop que todavía no tenga videos #}
{% set es_drop3 = 'drop-03' in category.url | lower or 'drop-3-' in category.url | lower %}
{# Drop 04: videos de DROP04_REEL, solo del segundo 1 al 13 (hero 1-13 s; clips 1-4 · 4-7 · 9,5-12,5 s) #}
{% set es_drop4 = 'drop-04' in category.url | lower or 'drop-4-' in category.url | lower or 'drop-4/' in category.url | lower %}
{% set sin_video = false %}
{# CYBER SGNS: portada con imagen fija (cyber-hero-desktop.webp y cyber-hero-mobile.webp), sin video ni título:
   el nombre ya está en la imagen #}
{% set portada_cyber = 'cyber' in category.url | lower %}
{# Nombre a mostrar: siempre con dos cifras ("DROP 3" en la tienda se ve "DROP 03") #}
{% set nombre_drop = category.name %}
{% if nombre_drop | lower == 'drop 3' %}{% set nombre_drop = 'DROP 03' %}{% endif %}
{% if nombre_drop | lower == 'drop 4' %}{% set nombre_drop = 'DROP 04' %}{% endif %}
{# Video del hero: uno para celular y otro para escritorio. El Drop 02 usa el mismo video (los primeros
   9 segundos) en los dos: vertical en celular y la franja del medio en escritorio, así no se estira #}
{% set hero_video_pc = es_drop1 ? 'drop-hero-desktop.mp4' : (es_drop4 ? 'drop04-hero-desktop.mp4' : (es_drop3 ? 'drop03-hero-desktop.mp4' : 'drop02-hero-v3-desktop.mp4')) %}
{% set hero_video_movil = es_drop1 ? 'drop-hero-mobile-v2.mp4' : (es_drop4 ? 'drop04-hero-mobile.mp4' : (es_drop3 ? 'drop03-hero-mobile.mp4' : 'drop02-hero-v3-mobile.mp4')) %}
{% set hero_poster_pc = es_drop1 ? 'drop-hero-desktop-poster.webp' : (es_drop4 ? 'drop04-hero-desktop-poster.webp' : (es_drop3 ? 'drop03-hero-desktop-poster.webp' : 'drop02-hero-v3-desktop-poster.webp')) %}
{% set hero_poster_movil = es_drop1 ? 'drop-hero-mobile-poster.webp' : (es_drop4 ? 'drop04-hero-mobile-poster.webp' : (es_drop3 ? 'drop03-hero-mobile-poster.webp' : 'drop02-hero-v3-mobile-poster.webp')) %}
{# La página arranca siempre arriba de todo: al recargar, el navegador volvía a la posición anterior
   durante la intro y al terminar aparecía la grilla a mitad de pantalla #}
<script>(function(){var r=document.documentElement;document.body.classList.add("sgns-drop-cat");if(window.__sgnsVuelta){return;}if("scrollRestoration" in history){history.scrollRestoration="manual";}r.classList.add("sgns-intro-on","sgns-intro-lock");setTimeout(function(){r.classList.remove("sgns-intro-on","sgns-intro-lock");},5000);})();</script>
{% if portada_cyber %}
<section class="redesign-hero sgns-drop-hero sgns-drop-hero--imagen" style="background: #08060a;">
    {% include 'snipplets/cyber-portada.tpl' %}
{% elseif not sin_video %}
<link rel="preload" as="image" href="{{ hero_poster_pc | static_url }}" media="(min-width: 768px)" fetchpriority="high" />
<link rel="preload" as="image" href="{{ hero_poster_movil | static_url }}" media="(max-width: 767px)" fetchpriority="high" />
<section class="redesign-hero sgns-drop-hero video-loading" style="--sgns-poster-escritorio: url('{{ hero_poster_pc | static_url }}'); --sgns-poster-movil: url('{{ hero_poster_movil | static_url }}');">
{% else %}
<section class="redesign-hero sgns-drop-hero" style="background: #000;">
{% endif %}
    {% if not sin_video and not portada_cyber %}
    <video class="redesign-hero-video d-none d-md-block" muted loop playsinline preload="none" poster="{{ hero_poster_pc | static_url }}" data-hero-src="{{ hero_video_pc | static_url }}" data-hero-media="(min-width: 768px)" aria-hidden="true"></video>
    <video class="redesign-hero-video d-block d-md-none" muted loop playsinline preload="none" poster="{{ hero_poster_movil | static_url }}" data-hero-src="{{ hero_video_movil | static_url }}" data-hero-media="(max-width: 767px)" aria-hidden="true"></video>
    {% endif %}
    {% if not portada_cyber %}<div class="redesign-hero-overlay"></div>{% endif %}
    <div class="sgns-intro" id="sgns-intro" aria-hidden="true"><div class="sgns-intro__veil"></div></div>
    <div class="redesign-hero-content-box">
        <div class="sgns-hero-marca">
            <p class="redesign-hero-title sgns-drop-hero__titulo" aria-hidden="true"{% if portada_cyber %} style="visibility: hidden;"{% endif %}>{{ nombre_drop }}</p>
        </div>
    </div>
</section>
{# Tres clips del video de escritorio, en una fila, entre el hero y los productos: drop-trio-1/2/3.mp4
   (escritorio) y drop-trio-1/2/3-mobile.mp4 (celular, más livianos).
   Drop 02: drop02-trio-1/2/3-v3, cortes de 3,5 segundos del video del hero (4-7,5, 1-4,5 y 6-9,5), en ese orden #}
{% set trio = es_drop1 ? ['drop-trio-1', 'drop-trio-3', 'drop-trio-2'] : (es_drop4 ? ['drop04-trio-1', 'drop04-trio-2', 'drop04-trio-3'] : (es_drop3 ? ['drop03-trio-1', 'drop03-trio-2', 'drop03-trio-3'] : ['drop02-trio-1-v3', 'drop02-trio-2-v3', 'drop02-trio-3-v3'])) %}
{% if portada_cyber %}
{# CYBER SGNS: en lugar de los tres videos, tres tarjetas con los beneficios, sobre negro y con neón rojo #}
<section class="sgns-cyber-beneficios" id="sgns-cyber-beneficios">
    <style>
    /* Tres tarjetas oscuras con borde de tubo de neón rojo y el ícono en un círculo que sale por arriba del borde.
       Texto centrado. La sección sube sobre la portada con un filo de neón */
    html body.sgns-drop-cat .sgns-cyber-beneficios { position: relative; z-index: 1; background: #08060a; padding: 96px 32px 64px; border-radius: 28px 28px 0 0; box-shadow: 0 -2px 0 #E60000, 0 -14px 44px rgba(230,0,0,.5); }
    .sgns-cyber-beneficios__fila { max-width: 1480px; margin: 0 auto; display: grid; grid-template-columns: repeat(3, 1fr); gap: 28px; }
    #sgns-cyber-beneficios .sgns-cyber-beneficio { --n: #E60000; position: relative; border-radius: 28px; padding: 74px 34px 40px; text-align: center; background: radial-gradient(120% 90% at 50% 120%, rgba(230,0,0,.28), #14080a 62%, #0a0405 100%); border: 2px solid #E60000; box-shadow: 0 0 14px rgba(230,0,0,.6), inset 0 0 18px rgba(230,0,0,.2); transition: transform .3s ease, box-shadow .3s ease; }
    #sgns-cyber-beneficios .sgns-cyber-beneficio:hover { transform: translateY(-5px); box-shadow: 0 0 22px rgba(230,0,0,.9), inset 0 0 22px rgba(230,0,0,.3); }
    #sgns-cyber-beneficios .sgns-cyber-beneficio__icono { position: absolute; left: 50%; top: -44px; transform: translateX(-50%); width: 88px; height: 88px; border-radius: 50%; display: flex; align-items: center; justify-content: center; background: radial-gradient(70% 70% at 50% 40%, #2a0d10 0%, #14080a 60%, #08060a 100%); border: 2px solid #E60000; margin: 0; box-shadow: 0 0 0 6px #08060a, 0 0 22px #E60000; }
    #sgns-cyber-beneficios .sgns-cyber-beneficio__icono svg { width: 40px; height: 40px; filter: drop-shadow(0 0 6px currentColor); }
    #sgns-cyber-beneficios p.sgns-cyber-beneficio__dato { margin: 0 !important; font-family: 'Exo 2', sans-serif !important; font-style: italic !important; font-weight: 900 !important; text-transform: uppercase !important; font-size: clamp(30px, 2.8vw, 54px) !important; line-height: 1 !important; letter-spacing: -.01em !important; padding-right: .15em !important; white-space: nowrap; background: none; color: #ffe5e5 !important; -webkit-text-fill-color: #ffe5e5 !important; text-shadow: 0 0 6px #E60000, 0 0 18px rgba(230,0,0,.8), 0 0 36px rgba(230,0,0,.5) !important; }
    #sgns-cyber-beneficios p.sgns-cyber-beneficio__titulo { margin: 16px 0 0 !important; font-family: 'Outfit', sans-serif !important; font-weight: 800 !important; font-size: 15px !important; letter-spacing: .2em !important; text-transform: uppercase !important; color: #ffe5e5 !important; background: none; padding: 0; border: 0; box-shadow: none; }
    #sgns-cyber-beneficios p.sgns-cyber-beneficio__texto { margin: 14px auto 0 !important; max-width: 34ch; font-family: 'Outfit', sans-serif !important; font-weight: 400 !important; text-transform: none !important; letter-spacing: 0 !important; font-size: 18px !important; line-height: 1.5 !important; color: rgba(255,255,255,.72) !important; }
    @media (min-width: 768px) and (max-width: 1100px) { #sgns-cyber-beneficios p.sgns-cyber-beneficio__dato { white-space: normal; } }
    @media (max-width: 767px) {
        html body.sgns-drop-cat .sgns-cyber-beneficios { padding: 70px 16px 40px; border-radius: 22px 22px 0 0; }
        .sgns-cyber-beneficios__fila { grid-template-columns: 1fr; gap: 58px; }
        #sgns-cyber-beneficios .sgns-cyber-beneficio { padding: 56px 22px 28px; border-radius: 22px; }
        #sgns-cyber-beneficios .sgns-cyber-beneficio__icono { width: 70px; height: 70px; top: -35px; }
        #sgns-cyber-beneficios .sgns-cyber-beneficio__icono svg { width: 32px; height: 32px; }
        #sgns-cyber-beneficios p.sgns-cyber-beneficio__dato { font-size: 34px !important; }
        #sgns-cyber-beneficios p.sgns-cyber-beneficio__texto { font-size: 15px !important; }
    }
    </style>
    <div class="sgns-cyber-beneficios__fila">
        <div class="sgns-cyber-beneficio">
            <span class="sgns-cyber-beneficio__icono" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="#E60000" color="#E60000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.6 13.4 13.4 20.6a2 2 0 0 1-2.8 0L3 13V3h10l7.6 7.6a2 2 0 0 1 0 2.8Z"/><circle cx="7.5" cy="7.5" r="1.5" fill="#E60000"/></svg></span>
            <p class="sgns-cyber-beneficio__dato">Hasta 70% OFF</p>
            <p class="sgns-cyber-beneficio__titulo">Descuentos Cyber</p>
            <p class="sgns-cyber-beneficio__texto">Precios especiales en prendas seleccionadas, solo durante el Cyber.</p>
        </div>
        <div class="sgns-cyber-beneficio">
            <span class="sgns-cyber-beneficio__icono" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="#E60000" color="#E60000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="5" width="20" height="14" rx="2.5"/><path d="M2 10h20M6 15h4"/></svg></span>
            <p class="sgns-cyber-beneficio__dato">3 y 6 cuotas</p>
            <p class="sgns-cyber-beneficio__titulo">Sin interés</p>
            <p class="sgns-cyber-beneficio__texto">Pagá en 3 o 6 cuotas sin interés con tarjeta.</p>
        </div>
        <div class="sgns-cyber-beneficio">
            <span class="sgns-cyber-beneficio__icono" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="#E60000" color="#E60000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 4h13v12H1zM14 8h4l4 4v4h-8z"/><circle cx="5.5" cy="18.5" r="2" fill="#0d0c14"/><circle cx="17.5" cy="18.5" r="2" fill="#0d0c14"/></svg></span>
            <p class="sgns-cyber-beneficio__dato">Envío gratis</p>
            <p class="sgns-cyber-beneficio__titulo">En compras desde $50.000</p>
            <p class="sgns-cyber-beneficio__texto">Superando los $50.000, el envío corre por nuestra cuenta.</p>
        </div>
    </div>
</section>
{% elseif not sin_video %}
<section class="sgns-drop-trio" aria-hidden="true">
    <div class="sgns-drop-trio__fila">
        {% for clip in trio %}
        <video class="sgns-drop-trio__video" muted loop playsinline preload="none" poster="{{ (clip ~ '-poster.webp') | static_url }}" data-src-escritorio="{{ (clip ~ '.mp4') | static_url }}" data-src-movil="{{ (clip ~ '-mobile.mp4') | static_url }}"></video>
        {% endfor %}
    </div>
</section>
{% endif %}
{% if drop_largo %}
{# La historia del Drop (fondo negro), antes del zoom: tres filas que aparecen de a una #}
<section class="sgns-drop-historia">
    <div class="sgns-drop-historia__texto">
        <p class="sgns-drop-historia__fila">Todo empezó con un sueño: una colección que no existiera en ningún otro lado.</p>
        <p class="sgns-drop-historia__fila">Meses de muestras y un contenedor cruzando el océano para llegar hasta acá.</p>
        <p class="sgns-drop-historia__fila">Una tanda corta, pensada para pocos. <b>Cuando se agote, no vuelve.</b></p>
    </div>
</section>
{# El nombre del Drop en grande y en blanco: entra letra por letra, subiendo, cuando aparece en pantalla #}
<section class="sgns-drop-nombre" aria-hidden="true">
    {# Queda fija mientras se scrollea: la palabra se agranda hasta que el blanco llena la pantalla #}
    <div class="sgns-drop-nombre__fijo">
        <p class="redesign-hero-title sgns-drop-nombre__texto" data-logo="{{ 'images/drop-monograma-blanco.webp' | static_url }}" data-fecha="Sábado 03.10 · 20 hs">{{ nombre_drop }}</p>
        <div class="sgns-drop-nombre__blanco"></div>
    </div>
</section>
{# "Lo que se dice": queda fija mientras se scrollea; en el centro el título y el monograma,
   y a los costados van entrando mensajes a medida que se avanza #}
<section class="sgns-drop-dice" aria-hidden="true">
    <div class="sgns-drop-dice__fijo">
        <div class="sgns-drop-dice__centro">
            <p class="sgns-drop-dice__kicker">{{ nombre_drop }}</p>
            <img class="sgns-drop-dice__collage" src="{{ 'images/drop-collage-v2.webp' | static_url }}" alt="" loading="lazy">
        </div>
        {# Computadora: 5 mensajes (Mica, Tomi, Juli, Lucas, Agus). Celular: 4 (Mica, Agus, Juli, Lucas).
           --corre fija el corrimiento lateral de cada uno en la computadora (en el celular es 0) #}
        <div class="sgns-drop-dice__msg sgns-drop-dice__msg--izq" style="--k: 0; --corre: 3vw;"><b>Mica</b>¿Cuándo sale el drop?? 😭</div>
        <div class="sgns-drop-dice__msg sgns-drop-dice__msg--der sgns-solo-pc" style="--k: 1; --corre: 1vw;"><b>Tomi</b>Me dijeron que lo trajeron de China</div>
        <div class="sgns-drop-dice__msg sgns-drop-dice__msg--der sgns-solo-movil" style="--k: 1;"><b>Agus</b>Dicen que son pocas unidades 👀</div>
        <div class="sgns-drop-dice__msg sgns-drop-dice__msg--izq" style="--k: 2; --corre: 0vw;"><b>Juli</b>¿Cuánto falta? No aguanto más</div>
        <div class="sgns-drop-dice__msg sgns-drop-dice__msg--der" style="--k: 3; --corre: 2vw;"><b>Lucas</b>Vi un adelanto, está buenísimo 🔥</div>
        <div class="sgns-drop-dice__msg sgns-drop-dice__msg--izq sgns-solo-pc" style="--k: 4; --corre: 4vw;"><b>Agus</b>Dicen que son pocas unidades 👀</div>
    </div>
</section>
{% endif %}
{# Cyber Monday: mismos textos de la cinta que un Drop, con los datos del evento #}
{% set es_cyber = 'cyber' in category.url | lower %}
{# CYBER SGNS: la sección de productos va en blanco (el hero y la fila de videos siguen igual) y las tarjetas
   llevan los colores de neón del evento: etiqueta de descuento como cartel de neón rosa, cuotas en píldora negra
   con el texto en cian y el precio con transferencia en rosa. Cian y rosa más oscuros para los textos chicos #}
{% if es_cyber %}
<style>
/* CYBER SALE: la página del Cyber en negro con neón rojo, como el cartel de la portada: encabezado, filtros, grilla y
   tarjetas. El rojo es siempre #E60000 (tubo y brillo) y las letras llevan el núcleo claro #ffe5e5 */
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-cabecera, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-cabecera__cinta, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls-prev, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls.is-sticky, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-cabecera ~ section.container-fluid.d-md-none, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-hero ~ .js-category-body { background: #08060a !important; color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-cabecera { box-shadow: 0 2px 0 #08060a !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls { box-shadow: 0 -2px 0 #08060a, 0 2px 0 #08060a !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-cabecera__cinta, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-drop-cabecera__kicker { display: none !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls .sgns-sort__btn { background: transparent !important; border-color: rgba(255,255,255,.6) !important; color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls .sgns-sort__btn * { color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-modal-open.btn-default.btn-medium.form-select.sgns-filter-btn { background: #E60000 !important; border-color: #E60000 !important; color: #fff !important; box-shadow: 0 0 16px rgba(230,0,0,.55) !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-filter-btn__icon { stroke: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-body h2, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-body .svg-icon-text { color: #fff !important; fill: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-body .js-load-more { background: #E60000 !important; border-color: #E60000 !important; color: #fff !important; box-shadow: 0 0 16px rgba(230,0,0,.55) !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls .chip { background: rgba(230,0,0,.14) !important; border-color: rgba(230,0,0,.6) !important; color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-category-controls .js-remove-all-filters { color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-precio .sgns-precio__actual { color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-precio .sgns-precio__antes { color: rgba(255,255,255,.5) !important; text-decoration-color: #E60000 !important; -webkit-text-decoration-color: #E60000 !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-precio .sgns-precio__cuotas { background: rgba(255,255,255,.08) !important; border: 1px solid rgba(230,0,0,.55) !important; color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-precio .sgns-precio__cuotas b { color: #ffe5e5 !important; -webkit-text-fill-color: #ffe5e5 !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-precio .sgns-precio__transf, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .sgns-precio .sgns-precio__transf * { color: #ffe5e5 !important; -webkit-text-fill-color: #ffe5e5 !important; text-shadow: 0 0 10px rgba(230,0,0,.7); }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-discount-badge, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .label-accent, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-offer-label { background: #14080a !important; color: #ffe5e5 !important; border: 1.5px solid #E60000 !important; box-shadow: 0 0 10px rgba(230,0,0,.8), inset 0 0 8px rgba(230,0,0,.45) !important; text-shadow: 0 0 6px #E60000 !important; }
/* Tarjetas de producto: cada producto dentro de una tarjeta oscura con borde de tubo de neón rojo, la foto con bordes
   redondeados adentro, letras claras y el -% arriba a la derecha como cartel de neón */
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product { position: relative; padding: 0 8px 20px !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product::before { content: ""; position: absolute; left: 8px; right: 8px; top: 0; bottom: 20px; border-radius: 22px; background: radial-gradient(90% 70% at 50% 30%, #2a0d10 0%, #14080a 60%, #08060a 100%); box-shadow: 0 0 0 2px #E60000, 0 0 14px rgba(230,0,0,.75), inset 0 0 18px rgba(230,0,0,.22), 0 18px 40px -18px rgba(230,0,0,.8); pointer-events: none; z-index: 0; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product > * { position: relative; z-index: 1; }
/* Las prendas doradas van con la carta de oro, sin el fondo oscuro */
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product:has(> .sgns-dorada:not(.sgns-dorada--latente))::before { display: none; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product .item-image { margin: 10px 10px 0 !important; border-radius: 14px !important; overflow: hidden; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .item-description { padding: 4px 18px 18px !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .item-name.nov-card__name, html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .item-product:hover .item-name.nov-card__name { color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-precio .sgns-precio__actual { color: #fff !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-precio .sgns-precio__antes { color: #9a98b8 !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-item-badges { top: 22px !important; right: 22px !important; left: auto !important; align-items: flex-end !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-discount-badge { background: #14080a !important; color: #ffe5e5 !important; border: 1.5px solid #E60000 !important; box-shadow: 0 0 10px rgba(230,0,0,.8), inset 0 0 8px rgba(230,0,0,.45) !important; text-shadow: 0 0 6px #E60000 !important; font-family: 'Orbitron', sans-serif !important; font-weight: 800 !important; font-size: 17px !important; padding: 7px 15px !important; letter-spacing: .06em !important; }
html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-bolsa { right: 22px !important; bottom: 12px !important; }
@media (max-width: 767px) {
  html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product { padding: 0 5px 12px !important; }
  html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product::before { left: 5px; right: 5px; bottom: 12px; border-radius: 16px; }
  html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .js-item-product .item-image { margin: 6px 6px 0 !important; border-radius: 11px !important; }
  html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .item-description { padding: 2px 10px 12px !important; }
  html:not(#sgns) body.sgns-drop-cat:not(#sgns) .js-product-table .sgns-item-badges { top: 14px !important; right: 14px !important; }
}
</style>
{% endif %}
{% set cinta_1 = es_cyber ? 'CYBER SALE' : 'Edición limitada' %}
{% set cinta_2 = es_cyber ? '2 al 4 de noviembre' : 'Desde China' %}
{# Encabezado de los productos: cinta negra que corre y el nombre del Drop con la cantidad de piezas #}
<section class="sgns-drop-cabecera">
    <div class="sgns-drop-cabecera__cinta" aria-hidden="true"><div class="sgns-drop-cabecera__pista"><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span><span><i></i>{{ cinta_1 }}</span><span><i></i>{{ cinta_2 }}</span><span><i></i>SGNS Studio</span><span><i></i>{{ nombre_drop }}</span></div></div>
    <div class="sgns-drop-cabecera__titulo">
        <span class="sgns-drop-cabecera__kicker"><i></i>La colección<span class="js-drop-piezas"></span></span>
        {% if es_cyber %}
        {# CYBER SGNS: el nombre como cartel de neón (solo borde), CYBER en cian y SGNS en rosa, en una sola fila #}
        <p class="sgns-drop-cabecera__nombre sgns-cyber-nombre" id="sgns-cyber-nombre"><span class="sgns-cyber-nombre__p sgns-cyber-nombre__p--cyber">CYBER<span>CYBER</span></span> <span class="sgns-cyber-nombre__p sgns-cyber-nombre__p--sgns">SALE<span>SALE</span></span></p>
        <style>
        #sgns-cyber-nombre { display: flex; flex-wrap: wrap; gap: 0 .35em; align-items: baseline; font-style: normal !important; color: transparent !important; }
        #sgns-cyber-nombre .sgns-cyber-nombre__p { position: relative; font-family: 'Orbitron', sans-serif !important; font-weight: 800 !important; font-style: normal !important; text-transform: uppercase !important; letter-spacing: .02em !important; line-height: 1 !important; color: transparent !important; -webkit-text-fill-color: transparent !important; -webkit-text-stroke: .055em var(--neon) !important; filter: drop-shadow(.05em .05em 0 rgba(230,0,0,.5)) drop-shadow(0 0 1px var(--neon)) drop-shadow(0 0 6px var(--neon-suave)) drop-shadow(0 0 16px var(--neon-suave)); }
        #sgns-cyber-nombre .sgns-cyber-nombre__p > span { position: absolute; inset: 0; font: inherit !important; letter-spacing: inherit !important; -webkit-text-stroke: .02em var(--nucleo) !important; }
        #sgns-cyber-nombre .sgns-cyber-nombre__p--cyber { --neon: #E60000; --neon-suave: rgba(230,0,0,.55); --nucleo: #ffe5e5; }
        #sgns-cyber-nombre .sgns-cyber-nombre__p--sgns { --neon: #E60000; --neon-suave: rgba(230,0,0,.5); --nucleo: #ffe5e5; }
        /* Celular: un poco más chico para que CYBER SGNS entre en una sola fila */
        @media (max-width: 767px) { html body #sgns-cyber-nombre.sgns-drop-cabecera__nombre { font-size: calc(10.1vw - 4px) !important; flex-wrap: nowrap; gap: 0 .3em; } }
        </style>
        {% else %}
        <p class="sgns-drop-cabecera__nombre">{{ nombre_drop }}</p>
        {% endif %}
    </div>
</section>
<script>
(function() {
    var hero = document.querySelector('.sgns-drop-hero');
    if (!hero) { return; }

    // Solo se carga el video que corresponde a la pantalla (como en el inicio)
    var videos = hero.querySelectorAll('.redesign-hero-video');
    function listo() { hero.classList.remove('video-loading'); }
    videos.forEach(function(v) {
        var mq = v.getAttribute('data-hero-media');
        if (mq && !window.matchMedia(mq).matches) { return; }
        v.addEventListener('loadeddata', function() {
            var p = v.play();
            if (p && p.catch) { p.catch(function() {}); }
            listo();
        });
        v.addEventListener('error', listo);
        v.src = v.getAttribute('data-hero-src');
        v.load();
    });
    setTimeout(listo, 5000);
    // Si el celular bloqueó la reproducción automática, arranca con el primer toque
    document.addEventListener('touchstart', function() {
        videos.forEach(function(v) {
            if (!v.currentSrc) { return; }
            var p = v.play();
            if (p && p.catch) { p.catch(function() {}); }
        });
    }, { once: true });

    // Los tres videos de abajo: se cargan recién al acercarse y se pausan fuera de pantalla
    var fila = document.querySelector('.sgns-drop-trio');
    var trio = fila ? fila.querySelectorAll('.sgns-drop-trio__video') : [];
    var trioCargado = false;
    var escritorio = window.matchMedia('(min-width: 768px)').matches;
    function trioPlay(on) {
        trio.forEach(function(v) {
            if (!on) { v.pause(); return; }
            if (!trioCargado) { v.src = v.getAttribute(escritorio ? 'data-src-escritorio' : 'data-src-movil'); v.load(); }
            var p = v.play();
            if (p && p.catch) { p.catch(function() {}); }
        });
        if (on) { trioCargado = true; }
    }
    if (fila && 'IntersectionObserver' in window) {
        new IntersectionObserver(function(entradas) {
            trioPlay(entradas[0].isIntersecting);
        }, { rootMargin: '300px 0px' }).observe(fila);
    } else if (fila) {
        trioPlay(true);
    }

    // El nombre grande entra letra por letra, subiendo, cuando aparece en pantalla (una sola vez)
    var nombre = document.querySelector('.sgns-drop-nombre__texto');
    // Solo una vez: si el script corre de nuevo, la fecha ya está adentro y se sumaría a la palabra
    if (nombre && !nombre.dataset.armado) {
        nombre.dataset.armado = '1';
        var texto = nombre.textContent.trim();
        nombre.textContent = '';
        var palabra = 0;
        // Arriba el monograma, en el medio la palabra y abajo la fecha
        var linea = document.createElement('span');
        linea.className = 'sgns-drop-nombre__palabra';
        texto.split('').forEach(function(letra, n) {
            if (letra === ' ') { palabra++; }
            var span = document.createElement('span');
            // La primera palabra entra desde la izquierda y el resto desde la derecha
            span.className = 'sgns-drop-letra' + (palabra > 0 ? ' sgns-drop-letra--derecha' : '');
            span.style.setProperty('--n', n);
            span.textContent = letra === ' ' ? '\u00a0' : letra;
            linea.appendChild(span);
        });
        if (nombre.dataset.logo) {
            var logo = document.createElement('img');
            logo.src = nombre.dataset.logo;
            logo.alt = '';
            logo.className = 'sgns-drop-nombre__logo';
            nombre.appendChild(logo);
        }
        nombre.appendChild(linea);
        if (nombre.dataset.fecha) {
            var fecha = document.createElement('span');
            fecha.className = 'sgns-drop-nombre__fecha';
            fecha.innerHTML = '<i></i>';
            fecha.appendChild(document.createTextNode(nombre.dataset.fecha));
            nombre.appendChild(fecha);
        }
        if ('IntersectionObserver' in window) {
            var observador = new IntersectionObserver(function(entradas) {
                // También si ya quedó arriba (la página arrancó más abajo): así nunca queda oculto
                if (!entradas[0].isIntersecting && entradas[0].boundingClientRect.top > 0) { return; }
                nombre.classList.add('is-visible');
                observador.disconnect();
            }, { threshold: 0.3 });
            // Se observa la sección: la palabra arranca corrida a la izquierda, fuera de pantalla
            observador.observe(nombre.closest('.sgns-drop-nombre') || nombre);
        } else {
            nombre.classList.add('is-visible');
        }
    }

    // Zoom con scroll: mientras la sección pasa, la palabra se agranda desde el trazo de la
    // primera letra hasta que el blanco ocupa toda la pantalla
    var zoomSec = document.querySelector('.sgns-drop-nombre');
    var zoomTxt = zoomSec && zoomSec.querySelector('.sgns-drop-nombre__texto');
    var zoomBlanco = zoomSec && zoomSec.querySelector('.sgns-drop-nombre__blanco');
    var zoomFijo = zoomSec && zoomSec.querySelector('.sgns-drop-nombre__fijo');
    if (zoomSec && zoomTxt) {
        var zoomPend = false;
        // Posición de un elemento en la página según el diseño, sin transformaciones
        var posicion = function(el) {
            var x = 0, y = 0;
            while (el) { x += el.offsetLeft; y += el.offsetTop; el = el.offsetParent; }
            return { x: x, y: y };
        };
        var zoom = function() {
            zoomPend = false;
            var r = zoomSec.getBoundingClientRect();
            var recorrido = r.height - window.innerHeight;
            var p = recorrido > 0 ? Math.min(Math.max(-r.top / recorrido, 0), 1) : 0;
            // Punto de apoyo: un punto del trazo del monograma (el centro del trazo más grueso de la imagen: 51% del ancho,
            // 66,8% del alto; así el zoom termina siempre en blanco), así todo se agranda hacia el logo.
            // Se mide en cada cuadro con la posición del diseño (offsetLeft/Top, que no cuentan las
            // animaciones de entrada ni el propio zoom): antes se medía una sola vez en pantalla y, si la
            // tipografía terminaba de cargar después o la entrada seguía en curso, el zoom iba a un costado
            var logo = zoomTxt.querySelector('.sgns-drop-nombre__logo');
            if (logo && logo.offsetWidth) {
                var pl = posicion(logo), pt = posicion(zoomTxt);
                var origen = (pl.x - pt.x + logo.offsetWidth * 0.51).toFixed(1) + 'px ' + (pl.y - pt.y + logo.offsetHeight * 0.668).toFixed(1) + 'px';
                if (zoomTxt.style.transformOrigin !== origen) { zoomTxt.style.transformOrigin = origen; }
            }
            zoomTxt.style.transform = 'scale(' + (1 + Math.pow(Math.min(p / 0.7, 1), 3) * 120).toFixed(3) + ')';
            if (zoomBlanco) { zoomBlanco.style.opacity = Math.min(Math.max((p - 0.5) / 0.2, 0), 1).toFixed(3); }
            // Con la pantalla ya blanca, todo el bloque se desvanece y deja ver la sección de abajo
            // (en el celular apenas el blanco llena la pantalla, para que casi no quede tramo en blanco)
            var movil = window.innerWidth <= 767;
            if (zoomFijo) { zoomFijo.style.opacity = (1 - Math.min(Math.max((p - (movil ? 0.7 : 0.84)) / (movil ? 0.08 : 0.14), 0), 1)).toFixed(3); }
        };
        window.addEventListener('scroll', function() { if (!zoomPend) { zoomPend = true; requestAnimationFrame(zoom); } }, { passive: true });
        window.addEventListener('resize', zoom);
        // Cuando termina de cargar la tipografía el texto cambia de ancho: se recalcula
        if (document.fonts && document.fonts.ready) { document.fonts.ready.then(zoom); }
        // El punto del logo se calcula apenas la imagen termina de cargar
        var logoZoom = zoomTxt.querySelector('.sgns-drop-nombre__logo');
        if (logoZoom) { logoZoom.addEventListener('load', zoom); }
        zoom();
    }

    // La historia: cada fila aparece cuando entra en pantalla
    var filas = document.querySelectorAll('.sgns-drop-historia__fila');
    var ultimaFila = 0;
    if (filas.length && 'IntersectionObserver' in window) {
        var obsFilas = new IntersectionObserver(function(entradas) {
            entradas.forEach(function(e) {
                if (!(e.isIntersecting || e.boundingClientRect.top < 0)) { return; }
                obsFilas.unobserve(e.target);
                // De a una: cada fila espera 200 ms después de la anterior
                var ahora = Date.now(), turno = Math.max(ahora, ultimaFila + 200);
                ultimaFila = turno;
                setTimeout(function() { e.target.classList.add('is-visible'); }, turno - ahora);
            });
        }, { threshold: 0.15 });
        filas.forEach(function(f) { obsFilas.observe(f); });
    } else {
        filas.forEach(function(f) { f.classList.add('is-visible'); });
    }

    // "Lo que se dice": según cuánto se avanzó en la sección, cada mensaje entra desde su costado
    var dice = document.querySelector('.sgns-drop-dice');
    // Celular: cuánto se scrollea (en pantallas) desde que la sección de mensajes llega arriba
    // hasta que arranca el primer mensaje. Si cambia, cambiar también el alto en style-redesign.scss
    var ESPERA_MOVIL = 0.2;
    if (dice) {
        var todos = dice.querySelectorAll('.sgns-drop-dice__msg');
        var msgs = todos;
        var centro = dice.querySelector('.sgns-drop-dice__centro');
        var dicePend = false;
        var diceScroll = function() {
            dicePend = false;
            var r = dice.getBoundingClientRect();
            // Los mensajes esperan a que el zoom de arriba termine de desvanecerse (la sección
            // ya está debajo desde antes): recién ahí empieza su recorrido
            // Antes entra el centro (el nombre y el collage): con el scroll, apareciendo y subiendo
            var alto = window.innerHeight;
            // En el celular el collage y los mensajes entran antes (tramo en blanco más corto
            // después del zoom); la sección también es más corta (style-redesign.scss)
            var movil = window.innerWidth <= 767;
            if (centro) {
                var c = Math.min(Math.max((-r.top - alto * (movil ? 0 : 0.4)) / (alto * (movil ? 0.18 : 0.35)), 0), 1);
                centro.style.opacity = c.toFixed(3);
                centro.style.transform = 'translateY(' + ((1 - c) * 70).toFixed(1) + 'px)';
            }
            // Solo los mensajes visibles (5 en la computadora, 4 en el celular)
            msgs = Array.prototype.filter.call(todos, function(m) { return getComputedStyle(m).display !== 'none'; });
            var espera = alto * (movil ? ESPERA_MOVIL : 0.8);
            var recorrido = r.height - window.innerHeight - espera;
            var p = recorrido > 0 ? Math.min(Math.max((-r.top - espera) / recorrido, 0), 1) : 0;
            msgs.forEach(function(m, k) {
                // Cada mensaje tiene su tramo del recorrido; al pasarlo sigue subiendo despacio
                var inicio = k / (msgs.length + 1);
                var entrada = Math.min(Math.max((p - inicio) * (msgs.length + 1) * 1.6, 0), 1);
                m.style.setProperty('--entrada', entrada.toFixed(3));
                m.style.setProperty('--subida', Math.max(p - inicio, 0).toFixed(3));
            });
        };
        window.addEventListener('scroll', function() { if (!dicePend) { dicePend = true; requestAnimationFrame(diceScroll); } }, { passive: true });
        window.addEventListener('resize', diceScroll);
        diceScroll();
    }

    // Celular: el zoom del logo y los mensajes se reproducen solos, seguidos. Con un gesto para
    // abajo al llegar al zoom (o a los mensajes), la página baja sola a velocidad fija (con el
    // scroll bloqueado) y encadena los tramos hasta el final; ahí se devuelve el control.
    //  1. Zoom: desde el inicio del zoom hasta donde empiezan los mensajes (collage a la vista).
    //     Al final va frenando hasta la velocidad de los mensajes.
    //  2. Mensajes: hasta que entra el último, a velocidad pareja (ritmo de lectura).
    //  3. Final: hasta que asoma la cabecera de productos, frenando cada vez más suave. Acá ya
    //     se devuelve el control: sigue deslizándose sola, pero si se toca la pantalla, manda el dedo.
    // Cada tramo empalma con la velocidad del anterior. Si se vuelve a quedar arriba de un
    // tramo, la próxima vez que se baje se reproduce de nuevo.
    var DURACION_ZOOM = 1.1;      // segundos
    var DURACION_MENSAJES = 1.75; // segundos (unos 0,45 s por mensaje)
    // El final no tiene duración fija: arranca a la velocidad de los mensajes y solo frena;
    // dura lo que necesita para frenar suave (FRENADO más alto = arranca a frenar más fuerte
    // y dura menos; más bajo = más parejo y largo)
    var FRENADO = 1.5;
    if (zoomSec && dice && window.matchMedia('(pointer: coarse)').matches) {
        var reproduciendo = false, yPrevia = window.pageYOffset;
        var inicioMensajes = function(y) { return y + dice.getBoundingClientRect().top + window.innerHeight * ESPERA_MOVIL; };
        // Donde termina de entrar el último mensaje (misma cuenta que diceScroll)
        var ultimoMensaje = function(y) {
            var n = Array.prototype.filter.call(dice.querySelectorAll('.sgns-drop-dice__msg'), function(m) { return getComputedStyle(m).display !== 'none'; }).length || 1;
            var recorrido = dice.offsetHeight - window.innerHeight - window.innerHeight * ESPERA_MOVIL;
            var pFull = (n - 1) / (n + 1) + 1 / ((n + 1) * 1.6);
            return inicioMensajes(y) + recorrido * pFull;
        };
        // tipo: 'hacia' (termina a la velocidad del tramo siguiente), 'lineal' (velocidad pareja)
        // o 'frena' (arranca a la velocidad del anterior y frena hasta 0)
        var tramos = [
            { duracion: DURACION_ZOOM, tipo: 'hacia', visto: false,
              inicio: function(y) { return y + zoomSec.getBoundingClientRect().top; },
              fin: inicioMensajes },
            { duracion: DURACION_MENSAJES, tipo: 'lineal', visto: false,
              inicio: inicioMensajes,
              fin: ultimoMensaje },
            { duracion: 1.2, tipo: 'frena', visto: false,
              inicio: ultimoMensaje,
              // sigue un 35% de pantalla después de la sección de mensajes, así ya asoma la cabecera de productos
              fin: function(y) { return y + dice.getBoundingClientRect().bottom - window.innerHeight * 0.65; } },
        ];
        var vAnterior = 0; // velocidad (px/s) con la que terminó el tramo anterior
        // Curvas (x de 0 a 1 → avance de 0 a 1). s = velocidad inicial y e = velocidad final,
        // ambas relativas a la velocidad promedio del tramo
        var curva = function(tipo, s, e) {
            if (tipo === 'lineal') { return function(x) { return x; }; }
            if (tipo === 'hacia') {
                // cúbica: f'(0) = a, f'(1) = e; arranca algo más rápido que el promedio y frena hasta e
                e = Math.min(Math.max(e, 0.2), 1.5);
                var a = 1.3, b = 3 - 2 * a - e, c = a + e - 2;
                return function(x) { return x * (a + x * (b + x * c)); };
            }
            // 'frena': arranca a FRENADO × la velocidad promedio y solo frena, hasta 0
            return function(x) { return 1 - Math.pow(1 - x, FRENADO); };
        };
        // Reproduce el tramo i desde la posición actual y, al terminar, sigue con el próximo
        var tocar = function(i, encadenado) {
            var t = tramos[i];
            var y = window.pageYOffset;
            var ini = t.inicio(y), fin = t.fin(y);
            if (y >= fin - 2) { return tramos[i + 1] ? tocar(i + 1, encadenado) : terminar(); }
            t.visto = true;
            reproduciendo = true;
            // Si entró con envión y ya pasó parte del tramo, el resto dura en proporción
            var resto = (fin - y) / Math.max(fin - ini, 1);
            var dur = Math.max(t.duracion * resto, 0.4);
            var dist = Math.max(fin - y, 1);
            // 'frena' encadenado: la duración sale de la velocidad que trae, para arrancar igual
            if (t.tipo === 'frena' && encadenado && vAnterior) {
                dur = Math.min(Math.max(FRENADO * dist / vAnterior, 0.8), 9);
            }
            var promedio = dist / dur;
            var s = encadenado && vAnterior ? vAnterior / promedio : 1;
            // 'hacia': termina a la velocidad promedio del tramo siguiente
            var e = 1, sig = tramos[i + 1];
            if (t.tipo === 'hacia' && sig) {
                e = ((sig.fin(y) - sig.inicio(y)) / sig.duracion) / promedio;
            }
            // velocidad con la que termina este tramo, para empalmar el próximo
            vAnterior = t.tipo === 'frena' ? 0 : promedio * (t.tipo === 'hacia' ? Math.min(Math.max(e, 0.2), 1.5) : 1);
            var libre = t.tipo === 'frena'; // el frenado final no bloquea el scroll
            window.lenis.scrollTo(fin, {
                duration: dur,
                easing: curva(t.tipo, s, e),
                lock: !libre,
                force: true,
                onComplete: function() { if (tramos[i + 1]) { tocar(i + 1, true); } else if (!libre) { terminar(); } },
            });
            // Libre: la reproducción ya terminó para el script, aunque la página siga deslizándose
            if (libre) { terminar(); yPrevia = fin; }
        };
        var terminar = function() { reproduciendo = false; vAnterior = 0; yPrevia = window.pageYOffset; };
        var reproducir = function() {
            var y = window.pageYOffset;
            var bajando = y > yPrevia;
            yPrevia = y;
            if (reproduciendo || window.innerWidth > 767 || !window.lenis) { return; }
            for (var i = 0; i < tramos.length; i++) {
                var t = tramos[i];
                var ini = t.inicio(y), fin = t.fin(y);
                // Arriba del tramo: queda listo para reproducirse otra vez
                if (y < ini - window.innerHeight * 0.1) { t.visto = false; continue; }
                if (t.visto || !bajando || y < ini - 2 || y >= fin - 2) { continue; }
                tocar(i, false);
                return;
            }
        };
        window.addEventListener('scroll', reproducir, { passive: true });
    }

    // Cantidad real de piezas en el encabezado de los productos
    var piezas = document.querySelector('.js-drop-piezas');
    if (piezas) {
        var contar = function() { var n = document.querySelectorAll('.js-product-table .js-item-product').length; piezas.textContent = n ? ' · ' + n + (n === 1 ? ' pieza' : ' piezas') : ''; };
        contar();
        document.addEventListener('DOMContentLoaded', contar);
        // Al ordenar o filtrar sin recargar (static/js/sort-menu.js) la grilla cambia
        document.addEventListener('sgns:grilla', contar);
    }

    // Alto fijo en el celular: se mide al cargar y solo se vuelve a medir si cambia el ancho,
    // así la barra del navegador (Instagram, etc.) no lo agranda ni achica al scrollear
    var ancho = document.documentElement.clientWidth, espera;
    // La sección del nombre grande usa el mismo alto que el hero
    var seccionNombre = document.querySelector('.sgns-drop-nombre');
    var fijos = seccionNombre ? [hero, seccionNombre] : [hero];
    function fijar() {
        // Nunca más bajo que la pantalla visible: algunos navegadores del celular (Instagram, etc.)
        // calculan 100lvh más chico y debajo asomaba la sección siguiente
        // En el celular se suma un margen: la barra flotante de Safari (iPhone) queda encima de la página
        // y por debajo asomaba la sección siguiente
        var extra = window.matchMedia('(pointer: coarse)').matches && window.innerWidth <= 767 ? 110 : 0;
        var vv = window.visualViewport ? window.visualViewport.height : 0;
        var altoPx = Math.max(parseFloat(getComputedStyle(hero).height) || 0, window.innerHeight, document.documentElement.clientHeight, vv) + extra;
        var alto = altoPx + 'px';
        // Lo que se ve de la pantalla ahora, con las barras del navegador a la vista. El hero es más alto (el margen de
        // arriba y, en el celular, 100lvh es más que lo visible): esa parte queda por debajo de la pantalla
        var visible = Math.min(window.innerHeight, vv || window.innerHeight);
        var oculto = (visible > 0 ? Math.max(altoPx - visible, 0) : extra) + 'px';
        fijos.forEach(function(el) {
            el.style.setProperty('--sgns-alto-fijo', alto);
            // Lo que va pegado al borde de abajo del hero (el contador del Cyber, static/js/cyber-fuego.js) se sube
            // esa altura: si no, queda fuera de la pantalla
            el.style.setProperty('--sgns-alto-oculto', oculto);
            el.classList.add('sgns-alto-fijo');
        });
    }
    fijar();
    window.addEventListener('resize', function() {
        var w = document.documentElement.clientWidth;
        if (w === ancho) { return; }
        ancho = w;
        fijos.forEach(function(el) { el.classList.remove('sgns-alto-fijo'); });
        clearTimeout(espera);
        espera = setTimeout(fijar, 300);
    });
})();
</script>
{# La intro cinematográfica y el velo que se oscurece al scrollear, como en el inicio #}
<script src="{{ 'js/intro.js' | static_url }}?v=20261003" defer></script>
<script src="{{ 'js/hero-scroll.js' | static_url }}?v=20261001" defer></script>
