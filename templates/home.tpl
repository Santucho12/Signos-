{# Detect presence of features that remove empty placeholders #}

<!-- FORZADO DE ESTILOS SOLO PARA EL PREVIEW DEL HOME -->
<style>
  /* Ocultar contenido original de Tienda Nube de inmediato para evitar cualquier flash */
  .original-home-content {
      display: none !important;
  }
  /* Fuerza bruta: todos los svg, rutas y usos dentro del header serán blancos solo en preview */
  .redesign-active .head-main .utilities-container svg,
  .redesign-active .head-main .utilities-container svg path,
  .redesign-active .head-main .utilities-container svg use,
  .redesign-active .head-main .cart-summary svg,
  .redesign-active .head-main .cart-summary svg path,
  .redesign-active .head-main .cart-summary svg use,
  .redesign-active .head-main .utilities-icon {
      fill: #ffffff !important;
      stroke: transparent !important;
      color: #ffffff !important;
  }
  
  /* El número del carrito (badge) debe ser blanco sin fondo */
  .redesign-active .head-main .cart-summary .badge-amount {
      background-color: transparent !important;
      color: #ffffff !important;
      fill: #ffffff !important;
      stroke: none !important;
  }
</style>

{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_video = settings.video_embed %}
{% set has_main_categories = settings.main_categories and settings.slider_categories and settings.slider_categories is not empty %}
{% set has_banners = settings.banner and settings.banner is not empty %}
{% set has_promotional_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
{% set has_news_banners = settings.banner_news and settings.banner_news is not empty %}
{% set has_image_and_text_module = settings.module and settings.module is not empty %}
{% set has_informative_banners = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_01_description or settings.banner_services_02_description or settings.banner_services_03_description) %}
{% set has_instafeed = settings.show_instafeed and store.instagram and store.hasInstagramToken() %}
{% set has_welcome_message = settings.welcome_message or settings.welcome_text %}
{% set has_institutional_message = settings.institutional_message or settings.institutional_text %}
{% set has_testimonial_01 = settings.testimonial_01_description or settings.testimonial_01_name or "testimonial_01.jpg" | has_custom_image %}
{% set has_testimonial_02 = settings.testimonial_02_description or settings.testimonial_02_name or "testimonial_02.jpg" | has_custom_image %}
{% set has_testimonial_03 = settings.testimonial_03_description or settings.testimonial_03_name or "testimonial_03.jpg" | has_custom_image %}
{% set has_testimonials = has_testimonial_01 or has_testimonial_02 or has_testimonial_03 %}
{% set has_brands = settings.brands and settings.brands is not empty %}

{% set show_help = not (has_main_slider or has_mobile_slider or has_video or has_main_categories or has_banners or has_promotional_banners or has_news_banners or has_image_and_text_module or has_informative_banners or has_instafeed or has_welcome_message or has_institutional_message or has_testimonials or has_brands) and not has_products %}

{% set show_component_help = params.preview %}

{% if show_component_help %}
	{% include "snipplets/svg/empty-placeholders.tpl" %}
{% endif %}

{% if not params.preview %}
    {% set admin_link = is_theme_draft ? '/admin/themes/settings/draft/' : '/admin/themes/settings/active/' %}
{% endif %}

{% set newArray = [] %}

<!-- ========================================== -->
<!-- ORIGINAL HOME CONTENT (Hidden in Redesign) -->
<!-- ========================================== -->
<div class="original-home-content">
<div class="js-home-sections-container home-sections-container">
	{% for i in 1..18 %}
        {% set section = 'home_order_position_' ~ i %}
        {% set section_select = attribute(settings, section) %}

        {% if section_select not in newArray %}
            {% include 'snipplets/home/home-section-switch.tpl' %}
            {% set newArray = newArray|merge([section_select]) %}
        {% endif %}

    {% endfor %}

    {#  **** Hidden Sections ****  #}
    {% if show_component_help %}
        <div style="display:none">
            {% for section_select in ['slider', 'main_categories', 'products', 'informatives', 'categories', 'new', 'video', 'sale', 'main_product', 'instafeed', 'promotional', 'news_banners', 'newsletter', 'welcome', 'testimonials', 'brands', 'modules', 'institutional'] %}
                {% if section_select not in newArray %}
                    {% include 'snipplets/home/home-section-switch.tpl' %}
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
</div>

{% if settings.home_promotional_popup and ("home_popup_image.jpg" | has_custom_image or settings.home_popup_title or settings.home_popup_txt or settings.home_news_box or (settings.home_popup_btn and settings.home_popup_url)) %}
	{% include 'snipplets/home/home-popup.tpl' %}
{% endif %}
</div>

<!-- ========================================== -->
<!-- REDESIGN HOME CONTENT (Visible in Redesign)-->
<!-- ========================================== -->
<style>
    /* REDISEÑO EN VIVO: Visible para todos los clientes */
    .redesign-home-content {
        display: block !important;
    }
    /* Ocultar contenido original en producción */
    .original-home-content {
        display: none !important;
    }
</style>
{# Intro cinematográfica: el velo y el texto van acá, con sus estilos, para que
   valgan desde el primer cuadro. Los tiempos los maneja static/js/intro.js #}
<script>(function(){var r=document.documentElement;r.classList.add("sgns-intro-on","sgns-intro-lock");setTimeout(function(){r.classList.remove("sgns-intro-on","sgns-intro-lock");},5000);})();</script>

{# La foto del hero se pide antes que nada: es el primer fotograma del video real, evitando cualquier cambio de imagen #}
<link rel="preload" as="image" href="{{ 'hero-desktop-poster-v2.webp' | static_url }}" media="(min-width: 768px)" fetchpriority="high" />
<link rel="preload" as="image" href="{{ 'hero-mobile-poster-v2.webp' | static_url }}" media="(max-width: 767px)" fetchpriority="high" />
<style>
.sgns-intro{position:absolute;inset:0;z-index:2}
.sgns-intro__veil{position:absolute;inset:0;background:rgba(15,17,20,.15);backdrop-filter:blur(26px);-webkit-backdrop-filter:blur(26px)}
/* El hero muestra el fotograma real del video mientras arranca: base oscura idéntica a la tienda */
.redesign-hero{background-color:#0d0d0d;background-image:url('{{ "hero-desktop-poster-v2.webp" | static_url }}');background-size:cover;background-position:center}
@media (max-width:767px){.redesign-hero{background-image:url('{{ "hero-mobile-poster-v2.webp" | static_url }}')}}
</style>

<div class="redesign-home-content">
    
    <!-- 1. HERO VIDEO -->
    <section class="redesign-hero video-loading">
        {# Los src se asignan por JS segun viewport: un <video> oculto con display:none
           igual se descarga si tiene preload/autoplay, y en mobile eso bajaba tambien el de desktop. #}
        <!-- Video de fondo Desktop -->
        <video class="redesign-hero-video d-none d-md-block" muted loop playsinline preload="none" poster="{{ 'hero-desktop-poster-v2.webp' | static_url }}" data-hero-src="{{ 'hero-desktop-new.mp4' | static_url }}" data-hero-media="(min-width: 768px)" aria-label="SGNS Studio"></video>
        <!-- Video de fondo Mobile -->
        <video class="redesign-hero-video d-block d-md-none" muted loop playsinline preload="none" poster="{{ 'hero-mobile-poster-v2.webp' | static_url }}" data-hero-src="{{ 'hero-mobile-new.mp4' | static_url }}" data-hero-media="(max-width: 767px)" aria-label="SGNS Studio"></video>

        <script>
            (function() {
                var medias = document.querySelectorAll('.redesign-hero-video');
                var heroSection = document.querySelector('.redesign-hero');

                if (medias.length > 0 && heroSection) {
                    var onMediaReady = function(media) {
                        if (media.tagName === 'VIDEO') {
                            var p = media.play();
                            if (p && p.catch) { p.catch(function(){}); }
                        }
                        heroSection.classList.remove('video-loading');
                    };

                    medias.forEach(function(media) {
                        // Solo cargamos el video que corresponde al viewport actual.
                        var src = media.getAttribute('data-hero-src');
                        var mq = media.getAttribute('data-hero-media');
                        if (!src || (mq && !window.matchMedia(mq).matches)) { return; }

                        media.addEventListener('loadeddata', function() { onMediaReady(media); });
                        media.addEventListener('error', function() { heroSection.classList.remove('video-loading'); });
                        media.src = src;
                        media.load();
                    });

                    // Fallback para quitar loading
                    setTimeout(function() { heroSection.classList.remove('video-loading'); }, 5000);

                    // Forzar reproducción en mobile si el navegador lo bloquea inicialmente
                    document.addEventListener('touchstart', function() {
                        medias.forEach(function(media) {
                            if (media.tagName === 'VIDEO' && media.currentSrc) {
                                var p = media.play();
                                if (p && p.catch) { p.catch(function(){}); }
                            }
                        });
                    }, {once:true});
                }
            })();
        </script>
        
        <div class="redesign-hero-overlay"></div>
        <div class="sgns-intro" id="sgns-intro" aria-hidden="true"><div class="sgns-intro__veil"></div></div>

        <div class="redesign-hero-content-box">
            <div class="sgns-hero-marca">
            <h1 class="redesign-hero-title redesign-hero-title--img" data-redesign-animate="fadeUp" data-redesign-delay="200">
                <img src="{{ 'images/sgns-studio-intro.png' | static_url }}" alt="SGNS Studio" width="900" height="407" fetchpriority="high" />
            </h1>
            <span class="sgns-hero-eyebrow">Temporada 26</span>
        </div>
            <div class="redesign-scroll-indicator">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 5V19M12 19L5 12M12 19L19 12" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div class="redesign-hero-btn-wrapper sgns-hero-botones">
                {# Botón Drop 01 (reemplaza a Productos): bloqueado con candado hasta el viernes 2/10/2026 a las 22:00
                   (hora Argentina). Para el próximo drop se cambian la fecha, el nombre y el link. #}
                <a href="/drop01/" class="sgns-hero-btn sgns-hero-btn--drop is-locked" aria-disabled="true" data-drop-unlock="2026-10-02T22:00:00-03:00">
                    <span class="sgns-drop-lock" aria-hidden="true">
                        <svg class="sgns-drop-lock__closed" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="10" rx="2.5"/><path d="M8 11V8a4 4 0 0 1 8 0v3"/><circle cx="12" cy="16" r="1.2" fill="currentColor" stroke="none"/></svg>
                        <svg class="sgns-drop-lock__open" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="10" rx="2.5"/><path d="M8 11V8a4 4 0 0 1 7.6-1.7"/><circle cx="12" cy="16" r="1.2" fill="currentColor" stroke="none"/></svg>
                    </span>
                    <span class="sgns-drop-txt">
                        <span class="sgns-drop-top"><b>Drop 01</b><span class="sgns-drop-label"><i></i><span class="js-drop-label">Se desbloquea en</span></span></span>
                        <em class="js-drop-count sgns-drop-count"><svg class="sgns-drop-crono" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="13.5" r="7.5"/><path d="M12 9.5v4l2.6 1.6M9.5 2.5h5M12 2.5v3.5M19 6l1.4-1.4"/></svg><span><i>--</i><u>d</u></span><span><i>--</i><u>h</u></span><span><i>--</i><u>m</u></span><span><i>--</i><u>s</u></span></em>
                    </span>
                </a>

                {# Detección dinámica de la categoría o navegación de Promociones #}
                {% set promo_item = null %}
                {% for item in navigation %}
                    {% if not promo_item and ('promo' in item.name | lower or 'oferta' in item.name | lower or 'promo' in item.url | lower) %}
                        {% set promo_item = item %}
                    {% endif %}
                {% endfor %}
                {% if not promo_item %}
                    {% for cat in categories %}
                        {% if not promo_item and ('promo' in cat.name | lower or 'oferta' in cat.name | lower or 'promo' in cat.url | lower) %}
                            {% set promo_item = cat %}
                        {% endif %}
                    {% endfor %}
                {% endif %}

                {% set promo_url = promo_item ? (promo_item.url | setting_url | default(promo_item.url)) : '/jeans-2x70k/' %}
                {% set promo_subitems = promo_item ? (promo_item.subitems | default(promo_item.subcategories)) : null %}

                {% if promo_subitems and promo_subitems is not empty %}
                    <div class="sgns-hero-promos">
                        <button type="button" class="sgns-hero-btn sgns-hero-btn--linea js-promos-toggle" aria-haspopup="true" aria-expanded="false" aria-controls="sgns-promos-menu">
                            {{ promo_item.name | default('Promociones') }}
                        </button>
                        <ul class="sgns-hero-promos__menu" id="sgns-promos-menu">
                            {% for sub in promo_subitems %}
                                <li><a href="{{ sub.url | setting_url | default(sub.url) }}">{{ sub.name }}</a></li>
                            {% endfor %}
                        </ul>
                    </div>
                    <script>
                    (function() {
                        var caja = document.querySelector(".sgns-hero-promos");
                        if (!caja) { return; }
                        var boton = caja.querySelector(".js-promos-toggle");
                        function abrir(v) {
                            caja.classList.toggle("is-open", v);
                            boton.setAttribute("aria-expanded", v ? "true" : "false");
                        }
                        var conHover = window.matchMedia("(hover: hover)").matches;
                        boton.addEventListener("click", function(e) { e.stopPropagation(); abrir(conHover ? true : !caja.classList.contains("is-open")); });
                        document.addEventListener("click", function(e) { if (!caja.contains(e.target)) { abrir(false); } });
                        document.addEventListener("keyup", function(e) { if (e.key === "Escape") { abrir(false); } });
                        if (conHover) {
                            caja.addEventListener("mouseenter", function() { abrir(true); });
                            caja.addEventListener("mouseleave", function() { abrir(false); });
                        }
                    })();
                    </script>
                {% else %}
                    <a href="{{ promo_url }}" class="sgns-hero-btn sgns-hero-btn--linea">
                        {{ promo_item ? promo_item.name : 'Promociones' }}
                    </a>
                {% endif %}
            </div>

            <style>
            /* Botón Drop: mismo tamaño que Promociones (220x58 en escritorio, 155x50 en celular; los fija el tema).
               Pill oscuro con borde rojo, candado en la esquina inferior izquierda (mitad dentro, mitad fuera),
               "DROP 01 + Se desbloquea en" arriba y el cronómetro con el tiempo en rojo abajo. */
            @layer sgnsdrop {
                .sgns-drop-txt b, .sgns-drop-count i { font-weight: 700 !important; }
                .sgns-drop-count u, .sgns-drop-label { font-weight: 500 !important; }
            }
            .redesign-active .sgns-hero-btn--drop { position: relative; justify-content: flex-start !important; gap: 0; padding: 0 10px 0 36px !important; white-space: nowrap; text-align: left; color: #fff;
                background: linear-gradient(180deg, rgba(34,34,34,.78), rgba(10,10,10,.82)) !important;
                border: 1px solid rgba(230,0,0,.6) !important;
                backdrop-filter: blur(14px) saturate(140%); -webkit-backdrop-filter: blur(14px) saturate(140%);
                box-shadow: 0 0 0 0 rgba(230,0,0,.5), 0 14px 30px -14px rgba(0,0,0,.7), inset 0 1px 0 rgba(255,255,255,.08); }
            .redesign-active .sgns-hero-btn--drop::before { display: none !important; }
            .redesign-active .sgns-hero-btn--drop.is-locked { animation: sgnsDropLatido 1.8s ease-in-out infinite; cursor: not-allowed; }
            .redesign-active .sgns-hero-btn--drop.is-final { animation-duration: .9s; }
            @keyframes sgnsDropLatido { 0%, 100% { box-shadow: 0 0 0 0 rgba(230,0,0,.45), 0 14px 30px -14px rgba(0,0,0,.7), inset 0 1px 0 rgba(255,255,255,.08); } 50% { box-shadow: 0 0 0 7px rgba(230,0,0,0), 0 14px 30px -12px rgba(230,0,0,.55), inset 0 1px 0 rgba(255,255,255,.08); } }

            /* Candado: esquina inferior izquierda, mitad dentro y mitad fuera */
            .sgns-drop-lock { position: absolute; left: -13px; bottom: -13px; z-index: 3; width: 38px; height: 38px; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff; background: radial-gradient(circle at 32% 24%, #303030 0%, #151515 55%, #090909 100%); border: 0; box-shadow: 0 0 0 3px rgba(8,8,8,.7), 0 8px 18px rgba(0,0,0,.65), inset 0 1.5px 0 rgba(255,255,255,.2), inset 0 -3px 6px rgba(0,0,0,.65); }
            .sgns-drop-lock svg { width: 17px; height: 17px; }
            .sgns-drop-lock__open { display: none; }
            .sgns-hero-btn--drop.is-locked .sgns-drop-lock { animation: sgnsDropSacudida 5s ease-in-out infinite; }
            @keyframes sgnsDropSacudida { 0%, 86%, 100% { transform: rotate(0); } 89% { transform: rotate(-12deg); } 92% { transform: rotate(10deg); } 95% { transform: rotate(-6deg); } 98% { transform: rotate(3deg); } }

            .sgns-drop-txt { display: flex; flex-direction: column; gap: 7px; line-height: 1; min-width: 0; }
            .sgns-drop-top { display: flex; align-items: center; gap: 6px; }
            .sgns-drop-top b { font-size: 11px; letter-spacing: .17em; color: #fff; }
            .sgns-drop-label { display: inline-flex; align-items: center; gap: 4px; font-size: 7.5px; letter-spacing: .05em; text-transform: uppercase; color: rgba(255,255,255,.72); white-space: nowrap; }
            .sgns-drop-label i { flex: none; width: 4px; height: 4px; border-radius: 50%; background: #E60000; animation: sgnsDropPunto 1s steps(2, jump-none) infinite; }
            @keyframes sgnsDropPunto { 0% { opacity: 1; } 100% { opacity: .15; } }

            /* Cronómetro + tiempo en rojo */
            .sgns-drop-count { display: flex; align-items: center; gap: 7px; font-style: normal; font-variant-numeric: tabular-nums; }
            .sgns-drop-crono { flex: none; width: 13px; height: 13px; color: #E60000; filter: drop-shadow(0 0 6px rgba(230,0,0,.85)); animation: sgnsDropCrono 1s ease-in-out infinite; }
            @keyframes sgnsDropCrono { 0%, 100% { opacity: 1; filter: drop-shadow(0 0 7px rgba(230,0,0,.95)); } 50% { opacity: .12; filter: drop-shadow(0 0 0 rgba(230,0,0,0)); } }
            .sgns-drop-count span { display: inline-flex; align-items: baseline; gap: 1px; }
            .sgns-drop-count i { font-style: normal; font-size: 15px; line-height: 1; color: #E60000; text-shadow: 0 0 14px rgba(230,0,0,.8); }
            .sgns-drop-count u { text-decoration: none; font-size: 6.5px; line-height: 1; text-transform: uppercase; color: rgba(230,0,0,.75); }
            .sgns-drop-count span:last-child i { animation: sgnsDropSeg 1s ease-in-out infinite; }
            @keyframes sgnsDropSeg { 0%, 100% { opacity: 1; } 50% { opacity: .55; } }

            /* Desbloqueado */
            .sgns-hero-btn--drop:not(.is-locked) { background: #fff !important; border-color: #fff !important; color: #111 !important; animation: none; }
            .sgns-hero-btn--drop:not(.is-locked):hover { transform: translateY(-3px) !important; }
            .sgns-hero-btn--drop:not(.is-locked) .sgns-drop-lock { background: #111; }
            .sgns-hero-btn--drop:not(.is-locked) .sgns-drop-lock__closed { display: none; }
            .sgns-hero-btn--drop:not(.is-locked) .sgns-drop-lock__open { display: block; }
            .sgns-hero-btn--drop:not(.is-locked) .sgns-drop-top b { color: #111; }
            .sgns-hero-btn--drop:not(.is-locked) .sgns-drop-label { color: #444; }
            .sgns-hero-btn--drop:not(.is-locked) .sgns-drop-count { display: none; }

            @media (max-width: 767px) {
                .redesign-active .sgns-hero-btn--drop { padding: 0 8px 0 27px !important; }
                .sgns-drop-lock { width: 32px; height: 32px; left: -10px; bottom: -10px; }
                .sgns-drop-lock svg { width: 15px; height: 15px; }
                .sgns-drop-txt { gap: 6px; }
                .sgns-drop-top b { font-size: 10.5px; letter-spacing: .18em; }
                .sgns-drop-label { display: none; }
                .sgns-drop-count { gap: 5px; }
                .sgns-drop-crono { width: 11px; height: 11px; }
                .sgns-drop-count i { font-size: 12.5px; }
                .sgns-drop-count u { font-size: 5.5px; }
            }
            @media (max-width: 360px) {
                .redesign-active .sgns-hero-btn--drop { padding-left: 24px !important; }
                .sgns-drop-crono { display: none; }
                .sgns-drop-count { gap: 4px; }
            }
            /* Tamaño de los dos botones del hero (Drop 01 y Promociones): un poco más grandes que el original del tema
               (220x58 / 155x50). Van los dos iguales. */
            .redesign-active .sgns-hero-botones > .sgns-hero-btn,
            .redesign-active .sgns-hero-botones > .sgns-hero-promos { width: 254px !important; min-width: 254px !important; max-width: 254px !important; flex: 0 0 254px !important; }
            .redesign-active .sgns-hero-btn { height: 66px; font-size: 14px !important; }
            .redesign-active .sgns-hero-promos .sgns-hero-btn { width: 100% !important; min-width: 100% !important; max-width: 100% !important; flex: 1 1 100% !important; }
            .redesign-active .sgns-hero-btn--drop { padding: 0 12px 0 41px !important; }
            .sgns-drop-lock { width: 42px; height: 42px; left: -14px; bottom: -14px; }
            .sgns-drop-lock svg { width: 19px; height: 19px; }
            .sgns-drop-txt { gap: 8px; }
            .sgns-drop-top { gap: 7px; }
            .sgns-drop-top b { font-size: 12.5px; letter-spacing: .18em; }
            .sgns-drop-label { font-size: 8px; letter-spacing: .05em; gap: 4px; }
            .sgns-drop-label i { width: 4.5px; height: 4.5px; }
            .sgns-drop-count { gap: 8px; }
            .sgns-drop-crono { width: 18px; height: 18px; }
            .sgns-drop-count i { font-size: 17px; }
            .sgns-drop-count u { font-size: 7px; }
            @media (max-width: 767px) {
                .redesign-active .sgns-hero-botones > .sgns-hero-btn,
                .redesign-active .sgns-hero-botones > .sgns-hero-promos { width: min(42vw, 164px) !important; min-width: min(42vw, 164px) !important; max-width: min(42vw, 164px) !important; flex: 0 0 min(42vw, 164px) !important; }
                .redesign-active .sgns-hero-btn { height: 55px; font-size: 12.5px !important; }
                .redesign-active .sgns-hero-promos .sgns-hero-btn { width: 100% !important; min-width: 100% !important; max-width: 100% !important; flex: 1 1 100% !important; }
                .redesign-active .sgns-hero-btn--drop { padding: 0 8px 0 28px !important; }
                .sgns-drop-lock { width: 34px; height: 34px; left: -10px; bottom: -10px; }
                .sgns-drop-lock svg { width: 15px; height: 15px; }
                .sgns-drop-txt { gap: 6px; }
                .sgns-drop-top b { font-size: 11px; letter-spacing: .15em; }
                .sgns-drop-count { gap: 5px; }
                .sgns-drop-crono { width: 13px; height: 13px; }
                .sgns-drop-count i { font-size: 13px; }
                .sgns-drop-count u { font-size: 6px; }
            }
            @media (max-width: 360px) {
                .redesign-active .sgns-hero-btn--drop { padding-left: 25px !important; }
                .sgns-drop-top b { font-size: 10.5px; }
                .sgns-drop-count i { font-size: 12px; }
                .sgns-drop-count { gap: 3px; }
            }
            /* Cronómetro y tiempo titilan juntos: todo el grupo se apaga y se prende al mismo ritmo */
            .sgns-hero-btn--drop.is-locked .sgns-drop-count { animation: sgnsDropTitila 1s ease-in-out infinite; }
            .sgns-hero-btn--drop.is-final .sgns-drop-count { animation-duration: .6s; }
            .sgns-drop-crono, .sgns-drop-count span:last-child i { animation: none !important; }
            @keyframes sgnsDropTitila { 0%, 100% { opacity: 1; } 50% { opacity: .18; } }
            @media (prefers-reduced-motion: reduce) {
                .sgns-hero-btn--drop.is-locked, .sgns-hero-btn--drop.is-locked .sgns-drop-lock, .sgns-drop-label i { animation: none !important; }
                /* El titileo del cronómetro es pedido explícito: se mantiene, solo más suave */
                .sgns-hero-btn--drop.is-locked .sgns-drop-count { animation: sgnsDropTitila 1.4s ease-in-out infinite !important; }
            }
            </style>
            <script>
            (function() {
                var btn = document.querySelector('.sgns-hero-btn--drop');
                if (!btn) { return; }
                var cont = btn.querySelector('.js-drop-count');
                var label = btn.querySelector('.js-drop-label');
                var nums = cont.querySelectorAll('i');
                var fin = new Date(btn.getAttribute('data-drop-unlock')).getTime();
                var pad = function(n) { return String(n).padStart(2, '0'); };

                // Bloqueado: el clic no hace nada
                btn.addEventListener('click', function(e) { if (btn.classList.contains('is-locked')) { e.preventDefault(); } });

                function tick() {
                    var t = fin - Date.now();
                    if (t <= 0) {
                        btn.classList.remove('is-locked', 'is-final');
                        btn.removeAttribute('aria-disabled');
                        label.textContent = 'Ya disponible';
                        return;
                    }
                    var d = Math.floor(t / 864e5), h = Math.floor(t / 36e5) % 24, m = Math.floor(t / 6e4) % 60, s = Math.floor(t / 1e3) % 60;
                    var vals = [pad(d), pad(h), pad(m), pad(s)];
                    nums.forEach(function(el, i) { el.textContent = vals[i]; });
                    // Última hora: el botón late más rápido y el texto cambia
                    var ultima = t < 36e5;
                    btn.classList.toggle('is-final', ultima);
                    label.textContent = ultima ? '¡Última hora!' : 'Se desbloquea en';
                    setTimeout(tick, 1000);
                }
                tick();
            })();
            </script>
        </div>

</section>

    <!-- 1.5 CATEGORÍAS SECTION -->
    <section class="redesign-categorias">
        <!-- Header -->
        <div class="categorias-header" data-redesign-animate="fadeUp">
            <span class="categorias-header-left">SGNS <span>STUDIO</span> <span>TEMP 26</span></span>
            <span class="categorias-header-right">LO MAS VENDIDO</span>
        </div>

        <!-- Grid de Categorías -->
        <div class="categorias-grid">
            <!-- Card 1: BUZOS -->
            <a href="/buzos/" class="categoria-card" data-redesign-animate="fadeUp" data-redesign-delay="0">
                <img src="{{ 'categoria-buzos.webp' | static_url }}" alt="Buzos" class="categoria-bg-img">
                <div class="categoria-overlay"></div>
                <span class="categoria-sub">ESSENTIALS</span>
                <span class="categoria-name">BUZOS</span>
                <span class="categoria-cta">Ver colección →</span>
            </a>

            <!-- Card 2: REMERAS -->
            <a href="/remeras" class="categoria-card" data-redesign-animate="fadeUp" data-redesign-delay="150">
                <img src="{{ 'categoria-remeras.webp' | static_url }}" alt="Remeras" class="categoria-bg-img">
                <div class="categoria-overlay"></div>
                <span class="categoria-sub">BÁSICAS Y ESTAMPADAS</span>
                <span class="categoria-name">REMERAS</span>
                <span class="categoria-cta">Ver colección →</span>
            </a>

            <!-- Card 3: JEANS -->
            <a href="/jeans" class="categoria-card" data-redesign-animate="fadeUp" data-redesign-delay="300">
                <img src="{{ 'categoria-jeans.webp' | static_url }}" alt="Jeans" class="categoria-bg-img">
                <div class="categoria-overlay"></div>
                <span class="categoria-sub">DENIM & MÁS</span>
                <span class="categoria-name">JEANS</span>
                <span class="categoria-cta">Ver colección →</span>
            </a>

            <!-- Card 4: JOGGINS -->
            <a href="/joggings/" class="categoria-card" data-redesign-animate="fadeUp" data-redesign-delay="450">
                <img src="{{ 'categoria-joggings.webp' | static_url }}" alt="Joggins" class="categoria-bg-img">
                <div class="categoria-overlay"></div>
                <span class="categoria-sub">CONFORT</span>
                <span class="categoria-name">JOGGINGS</span>
                <span class="categoria-cta">Ver colección →</span>
            </a>

        </div>

        <!-- Footer -->
        <div class="categorias-footer" data-redesign-animate="fadeUp">
            <span class="categorias-footer-left">SIGNOS INDUMENTARIA — BAHÍA BLANCA</span>
            <a href="/productos" class="categorias-btn-vertodo" style="display:none;">VER TODO</a>
        </div>
    </section>

    <!-- Combined NOVEDADES Y OFERTAS SECTION -->
    <section class="redesign-novedades-v2">
        <!-- Unified Header - OUTSIDE container-wide for extreme positioning -->
        <div class="novedades-header-split" data-redesign-animate="fadeUp">
            <span class="novedades-brand-name">NOVEDADES Y OFERTAS</span>
            <span class="novedades-label-name">LOS NUEVOS INGRESOS Y PROMOCIONES</span>
        </div>

        <div class="container-wide">
            <!-- 1. NOVEDADES CAROUSEL -->
            <div class="novedades-carousel-wrapper" style="position: relative; margin-bottom: 45px;">
                <div class="novedades-grid-premium js-novedades-grid">
                    {% set raw_novedades = sections.new.products | default(sections.primary.products) | default(sections.featured.products) %}
                    {% for product in raw_novedades %}
                    {# Card de producto: foto + 2da foto en hover, precio de lista tachado, % y precio con transferencia en rojo, cuotas sin interés #}
                    {% set transfer_pct = settings.payment_discount_price and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
                    {% set max_free_installments = product.show_installments and product.get_max_installments(false) ? product.get_max_installments(false).installment : 1 %}

                    <a href="{{ product.url }}" class="nov-card" data-redesign-animate="fadeUp" data-redesign-delay="{{ loop.index0 * 100 + 100 }}">
                        <div class="nov-card__media">
                            <span class="sgns-bolsa" aria-hidden="true"><svg viewBox="0 0 565 512" aria-hidden="true"><path d="M528.22,422.85l-37.53-230.4c-6.05-37.16-38.15-64.45-75.8-64.45h-4.65C410.24,57.31,352.93,0,282.24,0S154.24,57.31,154.24,128h-4.65c-37.65,0-69.75,27.29-75.8,64.45l-37.53,230.4c-7.61,46.73,28.46,89.15,75.8,89.15H452.42c47.34,0,83.42-42.42,75.8-89.15ZM282.24,51.2c42.42,0,76.8,34.38,76.8,76.8H205.44c0-42.42,34.38-76.8,76.8-76.8Zm170.18,409.6H112.05c-15.78,0-27.8-14.14-25.27-29.72l37.53-230.4c2.02-12.39,12.72-21.48,25.27-21.48h4.65v51.2h51.2v-51.2h153.6v51.2h51.2v-51.2h4.65c12.55,0,23.25,9.1,25.27,21.48l37.53,230.4c2.54,15.58-9.48,29.72-25.27,29.72Z"/></svg></span>
                            <img src="{{ product.featured_image | product_image_url('huge') }}" alt="{{ product.name }}" class="nov-card__img">
                            {% set hover_image = product.other_images | first %}
                            {% if hover_image %}
                                <img src="{{ hover_image | product_image_url('huge') }}" alt="" aria-hidden="true" loading="lazy" class="nov-card__img nov-card__img--hover">
                            {% endif %}
                            {% if product.compare_at_price and product.compare_at_price > product.price %}
                                {% set discount_percent = (((product.compare_at_price - product.price) / product.compare_at_price) * 100) | round %}
                                <span class="nov-card__badge">-{{ discount_percent }}%</span>
                            {% else %}
                                {% set is_novedad = false %}
                                {% for category in product.categories %}
                                    {% if 'novedad' in category.name | lower %}
                                        {% set is_novedad = true %}
                                    {% endif %}
                                {% endfor %}
                                {% if product.category and ('novedad' in product.category.name | lower) %}
                                    {% set is_novedad = true %}
                                {% endif %}
                                {% if is_novedad %}
                                    <span class="nov-card__badge nov-card__badge--new">NOVEDAD</span>
                                {% endif %}
                            {% endif %}
                        </div>
                        <div class="nov-card__info">
                            <h4 class="nov-card__name">{{ product.name }}</h4>
                            {% if product.display_price %}
                                {% if transfer_pct > 0 %}
                                    <div class="nov-card__list-row">
                                        {% if product.compare_at_price and product.compare_at_price > product.price %}<s class="nov-card__compare">{{ product.compare_at_price | money }}</s>{% endif %}
                                        <s class="nov-card__list">{{ product.price | money }}</s>
                                        <span class="nov-card__chip">-{{ transfer_pct }}% TRANSF.</span>
                                    </div>
                                    <div class="nov-card__transfer">{{ (product.price * (100 - transfer_pct) / 100) | round | money }}</div>
                                {% else %}
                                    <div class="nov-card__transfer nov-card__transfer--plain">{{ product.price | money }}</div>
                                {% endif %}
                                {% if max_free_installments > 1 %}
                                    <div class="nov-card__installments"><b>{{ max_free_installments }}</b> cuotas sin interés de <b>{{ (product.price / max_free_installments) | round | money }}</b></div>
                                {% endif %}
                            {% endif %}
                        </div>
                    </a>
                    {% endfor %}
                </div>

                <!-- Progress bar and Swipe indicator removed -->
            </div>

            <!-- 2. OFERTAS CAROUSEL -->
            {% if sections.sale.products %}
            <div class="novedades-carousel-wrapper" style="position: relative;">
                <div class="novedades-grid-premium js-offers-grid">
                    {% for product in sections.sale.products %}
                    {# Card de producto: foto + 2da foto en hover, precio de lista tachado, % y precio con transferencia en rojo, cuotas sin interés #}
                    {% set transfer_pct = settings.payment_discount_price and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
                    {% set max_free_installments = product.show_installments and product.get_max_installments(false) ? product.get_max_installments(false).installment : 1 %}
                    <a href="{{ product.url }}" class="nov-card" data-redesign-animate="fadeUp" data-redesign-delay="{{ loop.index0 * 100 + 100 }}">
                        <div class="nov-card__media">
                            <span class="sgns-bolsa" aria-hidden="true"><svg viewBox="0 0 565 512" aria-hidden="true"><path d="M528.22,422.85l-37.53-230.4c-6.05-37.16-38.15-64.45-75.8-64.45h-4.65C410.24,57.31,352.93,0,282.24,0S154.24,57.31,154.24,128h-4.65c-37.65,0-69.75,27.29-75.8,64.45l-37.53,230.4c-7.61,46.73,28.46,89.15,75.8,89.15H452.42c47.34,0,83.42-42.42,75.8-89.15ZM282.24,51.2c42.42,0,76.8,34.38,76.8,76.8H205.44c0-42.42,34.38-76.8,76.8-76.8Zm170.18,409.6H112.05c-15.78,0-27.8-14.14-25.27-29.72l37.53-230.4c2.02-12.39,12.72-21.48,25.27-21.48h4.65v51.2h51.2v-51.2h153.6v51.2h51.2v-51.2h4.65c12.55,0,23.25,9.1,25.27,21.48l37.53,230.4c2.54,15.58-9.48,29.72-25.27,29.72Z"/></svg></span>
                            <img src="{{ product.featured_image | product_image_url('huge') }}" alt="{{ product.name }}" class="nov-card__img">
                            {% set hover_image = product.other_images | first %}
                            {% if hover_image %}
                                <img src="{{ hover_image | product_image_url('huge') }}" alt="" aria-hidden="true" loading="lazy" class="nov-card__img nov-card__img--hover">
                            {% endif %}
                            {% if product.compare_at_price and product.compare_at_price > product.price %}
                                {% set discount_percent = (((product.compare_at_price - product.price) / product.compare_at_price) * 100) | round %}
                                <span class="nov-card__badge">-{{ discount_percent }}%</span>
                            {% else %}
                                {% set is_novedad = false %}
                                {% for category in product.categories %}
                                    {% if 'novedad' in category.name | lower %}
                                        {% set is_novedad = true %}
                                    {% endif %}
                                {% endfor %}
                                {% if product.category and ('novedad' in product.category.name | lower) %}
                                    {% set is_novedad = true %}
                                {% endif %}
                                {% if is_novedad %}
                                    <span class="nov-card__badge nov-card__badge--new">NOVEDAD</span>
                                {% endif %}
                            {% endif %}
                        </div>
                        <div class="nov-card__info">
                            <h4 class="nov-card__name">{{ product.name }}</h4>
                            {% if product.display_price %}
                                {% if transfer_pct > 0 %}
                                    <div class="nov-card__list-row">
                                        {% if product.compare_at_price and product.compare_at_price > product.price %}<s class="nov-card__compare">{{ product.compare_at_price | money }}</s>{% endif %}
                                        <s class="nov-card__list">{{ product.price | money }}</s>
                                        <span class="nov-card__chip">-{{ transfer_pct }}% TRANSF.</span>
                                    </div>
                                    <div class="nov-card__transfer">{{ (product.price * (100 - transfer_pct) / 100) | round | money }}</div>
                                {% else %}
                                    <div class="nov-card__transfer nov-card__transfer--plain">{{ product.price | money }}</div>
                                {% endif %}
                                {% if max_free_installments > 1 %}
                                    <div class="nov-card__installments"><b>{{ max_free_installments }}</b> cuotas sin interés de <b>{{ (product.price / max_free_installments) | round | money }}</b></div>
                                {% endif %}
                            {% endif %}
                        </div>
                    </a>
                    {% endfor %}
                </div>

                <!-- Progress bar and Swipe indicator removed -->
            </div>
            {% endif %}
        </div>
    </section>

    <script>
        /* Scroll lateral de Novedades y Ofertas con Lenis: suave y pesado, igual que la página.
           Con mouse se mueve con el trackpad, con Shift + rueda o arrastrando (al soltar sigue
           deslizando). En celular queda el swipe nativo del sistema. */
        (function() {
            if (window.matchMedia('(pointer: coarse)').matches) { return; }

            function setup(grid) {
                if (grid.__sgnsLenis) { return; }
                // El snap nativo pelea con la animación de Lenis
                grid.style.scrollSnapType = 'none';

                var lenis = new window.Lenis({
                    wrapper: grid,
                    content: grid,
                    orientation: 'horizontal',
                    gestureOrientation: 'horizontal', // la rueda vertical sigue bajando la página
                    lerp: 0.075,
                    wheelMultiplier: 0.9,
                    smoothWheel: true,
                    autoRaf: true,
                });
                grid.__sgnsLenis = lenis;

                // Arrastre con inercia
                var down = false, moved = false, startX = 0, startScroll = 0, lastX = 0, lastT = 0, speed = 0;

                grid.addEventListener('mousedown', function(e) {
                    if (e.button !== 0) { return; }
                    down = true; moved = false;
                    startX = lastX = e.clientX;
                    startScroll = lenis.animatedScroll;
                    lastT = performance.now(); speed = 0;
                    grid.style.cursor = 'grabbing';
                    e.preventDefault();
                });

                window.addEventListener('mousemove', function(e) {
                    if (!down) { return; }
                    var dx = e.clientX - startX;
                    if (Math.abs(dx) > 4) { moved = true; }
                    var now = performance.now();
                    speed = (e.clientX - lastX) / Math.max(1, now - lastT);
                    lastX = e.clientX; lastT = now;
                    lenis.scrollTo(startScroll - dx, { lerp: 0.18 });
                });

                window.addEventListener('mouseup', function() {
                    if (!down) { return; }
                    down = false;
                    grid.style.cursor = '';
                    // Al soltar sigue deslizando según la velocidad del arrastre
                    if (moved) { lenis.scrollTo(lenis.targetScroll - speed * 380, { lerp: 0.06 }); }
                });

                // Si hubo arrastre, el clic no abre el producto
                grid.addEventListener('click', function(e) {
                    if (moved) { e.preventDefault(); e.stopPropagation(); moved = false; }
                }, true);

                grid.style.cursor = 'grab';
            }

            function init() {
                if (typeof window.Lenis === 'undefined') { return false; }
                document.querySelectorAll('.js-novedades-grid, .js-offers-grid').forEach(setup);
                return true;
            }

            // Lenis lo carga smooth-scroll.js de forma asíncrona: se espera a que esté
            var tries = 0;
            (function wait() {
                if (init() || ++tries > 60) { return; }
                setTimeout(wait, 150);
            })();
        })();
    </script>

    <!-- OFFERS SECTION REMOVED BY OWNER REQUEST -->

    <!-- BANDA DE PROMOCIONES (se mueve de costado; el contenido va dos veces para que el loop no corte) -->
    {# Oculta por ahora: poner show_promo_band en true para volver a mostrarla #}
    {% set show_promo_band = false %}
    {% if show_promo_band %}
    {% set promos = ['20% OFF pagando por transferencia', '3 cuotas sin interés', 'Envíos a todo el país', 'Nueva temporada 26'] %}
    <div class="sgns-marquee" aria-label="Promociones">
        <div class="sgns-marquee-track">
            {% for copy in 1..2 %}
                <ul class="sgns-marquee-group" {% if copy == 2 %}aria-hidden="true"{% endif %}>
                    {% for i in 1..2 %}
                        {% for promo in promos %}
                            <li class="sgns-marquee-item">{{ promo }}</li>
                        {% endfor %}
                    {% endfor %}
                </ul>
            {% endfor %}
        </div>
    </div>
    {% endif %}

    <!-- 4. SOCIAL EXPERIENCE SECTION (Instagram & TikTok) -->
    {# Punto donde se ubica "Comprá el look": la sección la inyecta la app Compre
       Junto Pro al final de la página, así que se la trae acá cuando aparece. #}
    <section class="sgns-look-section">
        <div class="js-look-slot"></div>
    </section>
    <script>
        (function() {
            var slot = document.querySelector('.js-look-slot');
            if (!slot) { return; }

            function mover() {
                var look = document.querySelector('.huapps-look');
                if (!look) { return false; }
                if (!slot.contains(look)) { slot.appendChild(look); }
                look.classList.add('sgns-look-listo');
                var titulo = look.querySelector('.huapps-look-title');
                if (titulo && titulo.textContent.trim() !== 'Compra tu look completo') { titulo.textContent = 'Compra tu look completo'; }
                return true;
            }

            if (mover()) { return; }
            // La app la agrega después de cargar: se espera a que aparezca
            var intentos = 0;
            var observer = new MutationObserver(function() {
                if (mover()) { observer.disconnect(); }
            });
            observer.observe(document.body, { childList: true, subtree: true });
            var reloj = setInterval(function() {
                if (mover() || ++intentos > 40) { clearInterval(reloj); observer.disconnect(); }
            }, 500);
        })();
    </script>

    {# LOCALES: solo se ve en localhost (lo decide el script de abajo), no en la tienda publicada.
       Cada local usa static/locales/local-N.webp (foto) y static/locales/local-N.mp4 (video en hover).
       Mientras falte el archivo, la card queda oscura. Alsina ya usa un video existente. #}
    {% if true %}
    {% set locales = [
        {'dir': 'OHIGGINS 191', 'ciudad': 'Bahía Blanca', 'foto': 'locales/local-1.webp', 'video': 'Alsina WEB - VERTICAL.mp4'},
        {'dir': 'ALSINA 226', 'ciudad': 'Bahía Blanca', 'foto': 'locales/local-2.webp', 'video': 'Alsina WEB - VERTICAL.mp4'},
        {'dir': 'VM WASHINGTON 691', 'ciudad': 'Bahía Blanca', 'foto': 'locales/local-3.webp', 'video': 'Alsina WEB - VERTICAL.mp4'},
        {'dir': 'ZELARRAYAN 2250', 'ciudad': 'Bahía Blanca', 'foto': 'locales/local-4.webp', 'video': 'Alsina WEB - VERTICAL.mp4'},
        {'dir': 'PEATONAL DORREGO 38', 'ciudad': 'Monte Hermoso', 'foto': 'locales/local-5.webp', 'video': 'Alsina WEB - VERTICAL.mp4'}
    ] %}
    <section class="sgns-locales">
        <div class="container-wide">
            <div class="social-header-split" data-redesign-animate="fadeUp">
                <span class="social-brand-name">LOCALES</span>
                <span class="social-label-name">Visitanos en Bahía Blanca y Monte Hermoso</span>
            </div>
            <div class="sgns-locales__grid">
                {% for local in locales %}
                <a class="sgns-local" href="https://www.google.com/maps/search/?api=1&query={{ (local.dir ~ ' ' ~ local.ciudad) | url_encode }}" target="_blank" rel="noopener" data-redesign-animate="fadeUp" data-redesign-delay="{{ loop.index0 * 120 }}">
                    <div class="sgns-local__media">
                        <img src="{{ local.foto | static_url }}" alt="Local {{ local.dir }}" class="sgns-local__img" loading="lazy" onerror="this.style.display='none'">
                        <video class="sgns-local__video" muted loop playsinline preload="auto" data-src="{{ local.video | static_url }}"></video>
                        <div class="sgns-local__head">
                            <span class="sgns-local__ciudad">{{ local.ciudad }}</span>
                            <span class="sgns-local__dir">{{ local.dir }}</span>
                            <span class="sgns-local__linea"></span>
                            <span class="sgns-local__hora"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" stroke-width="1.8"/><path d="M12 7v5l3.2 2" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>Todos los días · 09:30 a 20:30 hs</span>
                        </div>
                        {# Botón de ubicación: la card entera es el link a Google Maps #}
                        <span class="sgns-local__pin" aria-hidden="true" title="Cómo llegar"><svg viewBox="0 0 24 24"><path fill="#E60000" d="M12 1.5C7.86 1.5 4.5 4.86 4.5 9c0 5.6 7.5 13.5 7.5 13.5s7.5-7.9 7.5-13.5c0-4.14-3.36-7.5-7.5-7.5z"/><circle cx="12" cy="9" r="2.8" fill="rgba(0,0,0,.4)"/></svg></span>
                    </div>
                </a>
                {% endfor %}
            </div>
        </div>
    </section>
    <style>
    /* Botón de ubicación: vidrio oscuro con el pin rojo; al hover se llena de blanco y el pin salta */
    .sgns-local__pin{position:absolute;right:18px;bottom:20px;z-index:5;width:52px;height:52px;border-radius:50%;display:flex;align-items:center;justify-content:center;background:rgba(255,255,255,.14);backdrop-filter:blur(14px);-webkit-backdrop-filter:blur(14px);border:1px solid rgba(255,255,255,.32);box-shadow:0 8px 22px rgba(0,0,0,.4),inset 0 1px 0 rgba(255,255,255,.25);transition:transform .5s cubic-bezier(.34,1.56,.64,1),background .35s ease,border-color .35s ease,box-shadow .35s ease}
    .sgns-local__pin::before{content:"";position:absolute;inset:-1px;border-radius:50%;border:1px solid rgba(255,255,255,.55);animation:sgnsPinOnda 2.6s ease-out infinite;pointer-events:none}
    @keyframes sgnsPinOnda{0%{transform:scale(1);opacity:.7}70%,100%{transform:scale(1.55);opacity:0}}
    .sgns-local__pin svg{width:24px;height:24px;display:block;filter:drop-shadow(0 2px 3px rgba(0,0,0,.45));transition:transform .5s cubic-bezier(.34,1.56,.64,1)}
    .sgns-local:hover .sgns-local__pin{transform:scale(1.1);background:#fff;border-color:#fff;box-shadow:0 14px 30px rgba(0,0,0,.5)}
    .sgns-local:hover .sgns-local__pin svg{transform:translateY(-3px) scale(1.08);filter:drop-shadow(0 4px 3px rgba(0,0,0,.3))}
    .sgns-local__head{padding-right:82px !important}
    @media (max-width:520px){.sgns-local__head{padding-right:58px !important}.sgns-local__pin{right:10px;bottom:12px;width:38px;height:38px}.sgns-local__pin svg{width:19px;height:19px}}
    </style>
    <style>
    .sgns-locales{display:none;background:#fff;position:relative;z-index:2;padding:80px 0}
    .sgns-locales__grid{display:grid;grid-template-columns:repeat(6,1fr);gap:32px;width:calc(100% - 40px);max-width:1260px;margin:0 auto}
    .sgns-local{grid-column:span 2}
    .sgns-local:nth-child(-n+2){grid-column:span 3}
    .sgns-local:nth-child(-n+2) .sgns-local__media{aspect-ratio:5/4}
    .sgns-local:nth-child(-n+2) .sgns-local__dir{font-size:22px}
    .sgns-local:nth-child(-n+2) .sgns-local__hora{font-size:10.5px}
    .sgns-local:nth-child(-n+2) .sgns-local__ciudad{font-size:10px}
    .sgns-local{display:block;text-decoration:none;color:#fff}
    .sgns-local__media{position:relative;aspect-ratio:3/4;overflow:hidden;background:#161616;border-radius:26px;isolation:isolate;box-shadow:0 10px 30px rgba(0,0,0,.14);transition:transform .5s cubic-bezier(.2,.7,.2,1),box-shadow .5s ease}
    .sgns-local__img,.sgns-local__video{position:absolute;inset:0;width:100%;height:100%;object-fit:cover}
    .sgns-local__video{opacity:0;transition:opacity .35s ease}
    .sgns-local.is-playing .sgns-local__video{opacity:1}
    /* Sombra de abajo hacia arriba: siempre visible, sobre foto y video */
    .sgns-local__media::after{content:"";position:absolute;inset:0;z-index:2;pointer-events:none;background:linear-gradient(to top,#000 0%,rgba(0,0,0,.96) 12%,rgba(0,0,0,.82) 22%,rgba(0,0,0,.5) 33%,rgba(0,0,0,.18) 43%,rgba(0,0,0,0) 52%)}
    .sgns-local__media::before{content:"";position:absolute;inset:0;z-index:4;border-radius:inherit;pointer-events:none;box-shadow:inset 0 0 70px 8px rgba(0,0,0,.65),inset 0 0 0 1px rgba(255,255,255,.14);transition:box-shadow .5s ease}
    .sgns-local:hover .sgns-local__media::before{box-shadow:inset 0 0 70px 8px rgba(0,0,0,.65),inset 0 0 0 1px rgba(255,255,255,.4)}
    .sgns-local__img,.sgns-local__video{transition:transform 1.1s cubic-bezier(.2,.7,.2,1),opacity .35s ease}
    .sgns-local:hover .sgns-local__img,.sgns-local:hover .sgns-local__video{transform:scale(1.06)}
    .sgns-local__head{position:absolute;left:0;right:0;bottom:0;z-index:3;display:flex;flex-direction:column;padding:0 20px 20px;transition:transform .6s cubic-bezier(.2,.7,.2,1)}
    .sgns-local:hover .sgns-local__head{transform:translateY(-4px)}
    .sgns-local__ciudad{font-size:8.5px;font-weight:500;letter-spacing:2.5px;text-transform:uppercase;color:rgba(255,255,255,.6);margin-bottom:6px}
    .sgns-local__dir{font-size:18px;font-weight:700;letter-spacing:.8px;text-transform:uppercase;color:#fff;line-height:1.05}
    .sgns-local__linea{display:block;height:1px;width:34px;margin:12px 0 10px;background:rgba(255,255,255,.7);transition:width .6s cubic-bezier(.2,.7,.2,1)}
    .sgns-local:hover .sgns-local__linea{width:100%}
    .sgns-local__hora{display:flex;align-items:center;gap:6px;font-size:9px;font-weight:500;letter-spacing:1px;text-transform:uppercase;color:rgba(255,255,255,.88)}
    .sgns-local__hora svg{width:11px;height:11px;flex:none}
    .sgns-local:hover .sgns-local__media{transform:translateY(-6px);box-shadow:0 18px 44px rgba(0,0,0,.24)}
    @media (max-width:900px){.sgns-locales__grid{grid-template-columns:repeat(2,1fr);gap:16px}.sgns-local,.sgns-local:nth-child(-n+2){grid-column:span 1}.sgns-local:nth-child(5){grid-column:span 2}.sgns-local:nth-child(-n+2) .sgns-local__media{aspect-ratio:3/4}.sgns-local:nth-child(5) .sgns-local__media{aspect-ratio:16/10}.sgns-local:nth-child(-n+2) .sgns-local__dir{font-size:15px}.sgns-local:nth-child(-n+2) .sgns-local__hora{font-size:9px}.sgns-local:nth-child(-n+2) .sgns-local__ciudad{font-size:8.5px}.sgns-local__dir{font-size:15px}}
    @media (max-width:520px){.sgns-locales{padding:50px 0}.sgns-local__head{padding:0 14px 14px}.sgns-local__dir,.sgns-local:nth-child(-n+2) .sgns-local__dir{font-size:12.5px;letter-spacing:.4px}.sgns-local:nth-child(-n+2) .sgns-local__hora{font-size:7.5px}.sgns-local:nth-child(-n+2) .sgns-local__ciudad{font-size:8px}.sgns-local__ciudad{font-size:8px;letter-spacing:2px;margin-bottom:5px}.sgns-local__linea{margin:10px 0 9px}.sgns-local__hora{font-size:7.5px;letter-spacing:.4px;gap:4px}.sgns-local__hora svg{width:11px;height:11px}.sgns-local__media{border-radius:20px}}
        
    </style>
    <script>
    (function() {
        // Solo se muestra en local (localhost / 127.0.0.1), no en la tienda publicada
        if (['localhost','127.0.0.1'].indexOf(location.hostname) === -1) { return; }
        document.querySelector('.sgns-locales').style.display = 'block';
        var cards = document.querySelectorAll('.sgns-local');
        var conHover = window.matchMedia('(hover: hover)').matches;
        cards.forEach(function(card) {
            var v = card.querySelector('.sgns-local__video');
            // El video se precarga apenas se muestra la sección, así al hover arranca casi al instante
            v.preload = 'auto';
            v.src = encodeURI(decodeURI(v.dataset.src));
            v.load();
            var espera;
            function reproducir() {
                // 0,3 segundos de espera antes de arrancar el video
                clearTimeout(espera);
                espera = setTimeout(function() {
                    var p = v.play();
                    if (p && p.catch) { p.catch(function() {}); }
                    card.classList.add('is-playing');
                }, 300);
            }
            function frenar() { clearTimeout(espera); v.pause(); card.classList.remove('is-playing'); }
            if (conHover) {
                card.addEventListener('mouseenter', reproducir);
                card.addEventListener('mouseleave', frenar);
            } else {
                // En celular no hay hover: un toque alterna el video
                card.addEventListener('click', function(e) { if (!card.classList.contains('is-playing')) { e.preventDefault(); } card.classList.contains('is-playing') ? frenar() : reproducir(); });
            }
        });
    })();
    </script>
    {% endif %}

    <section class="redesign-social-feed">
        <div class="container-wide">
            <div class="social-header-split" data-redesign-animate="fadeUp">
                <span class="social-brand-name">SEGUINOS EN REDES SOCIALES</span>
                <span class="social-label-name">Conectá con nuestra comunidad</span>
            </div>
            
            <div class="social-grid">
                <!-- Instagram Card -->
                <div class="social-card instagram-profile-card" data-redesign-animate="fadeUp" data-redesign-delay="200">
                    <div class="social-profile-header">
                        <div class="profile-pic-container">
                            <img src="{{ 'images/signos-monograma-avatar.png' | static_url }}" alt="Signos Profile" class="profile-pic">
                        </div>
                        <div class="profile-info-text">
                            <div class="profile-username">
                                signos_indumentaria
                                <svg class="verified-badge" viewBox="0 0 24 24"><path fill="#0095f6" d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm-1.9 14.7L6.3 12.9l1.4-1.4 2.4 2.4 5.6-5.6 1.4 1.4-7 7z"/></svg>
                            </div>
                            <div class="profile-full-name">THE SIGNOS COMPANY ®</div>
                        </div>
                        <div class="social-platform-icon"><svg><use xlink:href="#instagram"/></svg></div>
                    </div>
                    
                    <div class="profile-stats">
                        <div class="stat-item"><strong>3127</strong><span>POSTS</span></div>
                        <div class="stat-item"><strong>185K</strong><span>FOLLOWERS</span></div>
                        <div class="stat-item"><strong>5428</strong><span>FOLLOWING</span></div>
                    </div>

                    <div class="profile-bio">
                        <p>📍 OHIGGINS 191</p>
                        <p>📍 ALSINA 226</p>
                        <p>📍 VM WASHINGTON 691</p>
                        <p>📍 ZELARRAYAN 2250</p>
                        <p>📍 PEATONAL DORREGO 38 (MONTE HERMOSO)</p>
                        <p>HORARIO DE CORRIDO: 09:30 A 20:30hs</p>
                    </div>

                    <div class="social-preview-grid">
                        <div class="grid-img">
                            <video muted loop playsinline poster="{{ 'ig/ig-poster-1.webp' | static_url }}" data-src="{{ 'ig/ig-video-1.mp4' | static_url }}" class="grid-video js-lazy-video"></video>
                        </div>
                        <div class="grid-img">
                            <video muted loop playsinline poster="{{ 'ig/ig-poster-2.webp' | static_url }}" data-src="{{ 'ig/ig-video-2.mp4' | static_url }}" class="grid-video js-lazy-video"></video>
                        </div>
                        <div class="grid-img">
                            <video muted loop playsinline poster="{{ 'ig/ig-poster-3.webp' | static_url }}" data-src="{{ 'ig/ig-video-3.mp4' | static_url }}" class="grid-video js-lazy-video"></video>
                        </div>
                    </div>

                    <div class="social-actions-row">
                        <a href="https://www.instagram.com/signos_indumentaria/" target="_blank" class="social-link-btn btn-ig">Seguir en Instagram</a>
                        <button class="social-share-btn"><svg viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/></svg></button>
                    </div>
                </div>
                
                <!-- TikTok Card -->
                <div class="social-card tiktok-profile-card" data-redesign-animate="fadeUp" data-redesign-delay="400">
                    <div class="social-profile-header">
                        <div class="profile-pic-container">
                            <img src="{{ 'images/signos-monograma-avatar.png' | static_url }}" alt="Signos TikTok" class="profile-pic">
                        </div>
                        <div class="profile-info-text">
                            <div class="profile-username">
                                signosindumentaria
                                <svg class="verified-badge" viewBox="0 0 24 24"><path fill="#20D5EC" d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm-1.9 14.7L6.3 12.9l1.4-1.4 2.4 2.4 5.6-5.6 1.4 1.4-7 7z"/></svg>
                            </div>
                            <div class="profile-full-name">Signos Indumentaria</div>
                        </div>
                        <div class="social-platform-icon">
                            <svg viewBox="0 0 448 512">
                                <path d="M448,209.91a210.06,210.06,0,0,1-122.77-39.25V349.38A162.55,162.55,0,1,1,185,188.31V278.2a74.62,74.62,0,1,0,52.23,71.18V0l88,0a121.18,121.18,0,0,0,1.86,22.17h0A122.18,122.18,0,0,0,381,102.39a121.43,121.43,0,0,0,67,20.14Z"/>
                            </svg>
                        </div>
                    </div>

                    <div class="profile-stats">
                        <div class="stat-item"><strong>51.6K</strong><span>LIKES</span></div>
                        <div class="stat-item"><strong>10.1K</strong><span>FOLLOWERS</span></div>
                        <div class="stat-item"><strong>13</strong><span>FOLLOWING</span></div>
                    </div>

                    <div class="profile-bio">
                        <p>🔥 Tendencia y Estilo Masculino</p>
                        <p>📦 Envíos a todo el país</p>
                        <p>⚡ Nueva Colección 2026 ya disponible</p>
                    </div>

                    <div class="social-preview-grid">
                        <div class="grid-img">
                            <video muted loop playsinline poster="{{ 'ig/tk-poster-1.webp' | static_url }}" data-src="{{ 'ig/tk-video-1.mp4' | static_url }}" class="grid-video js-lazy-video"></video>
                        </div>
                        <div class="grid-img">
                            <video muted loop playsinline poster="{{ 'ig/tk-poster-2.webp' | static_url }}" data-src="{{ 'ig/tk-video-2.mp4' | static_url }}" class="grid-video js-lazy-video"></video>
                        </div>
                        <div class="grid-img">
                            <video muted loop playsinline poster="{{ 'ig/tk-poster-3.webp' | static_url }}" data-src="{{ 'ig/tk-video-3.mp4' | static_url }}" class="grid-video js-lazy-video"></video>
                        </div>
                    </div>

                    <div class="social-actions-row">
                        <a href="https://www.tiktok.com/@signosindumentari" target="_blank" class="social-link-btn btn-tk">Seguir en TikTok</a>
                        <button class="social-share-btn"><svg viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/></svg></button>
                    </div>
                </div>
            </div>
        </div>
    </section>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Lógica para la barra de progreso de Novedades
        const novedadesTrack = document.querySelector('.js-infinite-track');
        const novedadesBar = document.querySelector('.novedades-progress-bar');

        if (novedadesTrack && novedadesBar) {
            // Inicializar en el medio para efecto infinito
            const setupInfinite = () => {
                const totalWidth = novedadesTrack.scrollWidth;
                const oneSetWidth = totalWidth / 3;
                novedadesTrack.scrollLeft = oneSetWidth;
            };

            // Ejecutar después de un pequeño delay para asegurar renderizado
            setTimeout(setupInfinite, 100);

            novedadesTrack.addEventListener('scroll', () => {
                const scrollLeft = novedadesTrack.scrollLeft;
                const totalWidth = novedadesTrack.scrollWidth;
                const oneSetWidth = totalWidth / 3;

                // Reposicionamiento infinito (salto instantáneo)
                if (scrollLeft >= oneSetWidth * 2) {
                    novedadesTrack.scrollLeft = scrollLeft - oneSetWidth;
                } else if (scrollLeft <= 0) {
                    novedadesTrack.scrollLeft = oneSetWidth;
                }

                // Barra de progreso (basada solo en un set para que no se vea el salto)
                const relativeScroll = scrollLeft % oneSetWidth;
                const percentage = (relativeScroll / (oneSetWidth - novedadesTrack.clientWidth)) * 100;
                novedadesBar.style.width = `${Math.min(100, Math.max(0, percentage))}%`;
            });

            // Funcionalidad de arrastre para Desktop (Novedades)
            let isDown = false;
            let startX;
            let scrollLeft;

            novedadesTrack.addEventListener('mousedown', (e) => {
                isDown = true;
                novedadesTrack.classList.add('active');
                novedadesTrack.style.scrollSnapType = 'none'; // Desactivar snap durante el drag
                startX = e.pageX - novedadesTrack.offsetLeft;
                scrollLeft = novedadesTrack.scrollLeft;
            });
            novedadesTrack.addEventListener('mouseleave', () => {
                isDown = false;
                novedadesTrack.style.scrollSnapType = 'x mandatory';
            });
            novedadesTrack.addEventListener('mouseup', () => {
                isDown = false;
                novedadesTrack.style.scrollSnapType = 'x mandatory';
            });
            novedadesTrack.addEventListener('mousemove', (e) => {
                if(!isDown) return;
                e.preventDefault();
                const x = e.pageX - novedadesTrack.offsetLeft;
                const walk = (x - startX) * 2;
                novedadesTrack.scrollLeft = scrollLeft - walk;
            });
        }

        // Lógica para la barra de progreso de Ofertas
        const offersTrack = document.querySelector('.js-offers-grid');
        const offersBar = document.querySelector('.js-offers-progress-bar');

        if (offersTrack && offersBar) {
            offersTrack.addEventListener('scroll', () => {
                const scrollLeft = offersTrack.scrollLeft;
                const scrollWidth = offersTrack.scrollWidth - offersTrack.clientWidth;
                const percentage = (scrollLeft / scrollWidth) * 100;
                offersBar.style.width = `${percentage}%`;
            });
        }
    });

    // Lógica de carga para videos de redes sociales
    function initSocialVideos() {
        var videos = [].slice.call(document.querySelectorAll('.js-lazy-video'));
        if (!videos.length) { return; }

        // Se reproduce SOLO lo que está a la vista: con margen de 300px para que
        // cuando el usuario llegue ya esté cargado sin mostrar pantallas negras.
        var obs = new IntersectionObserver(function(entries) {
            entries.forEach(function(entry) {
                var v = entry.target;
                if (entry.isIntersecting) {
                    if (v.dataset.src && !v.src) {
                        // Primera vez: asignamos src y esperamos canplay antes de play()
                        v.src = v.dataset.src;
                        v.muted = true;
                        v.load();
                        var onReady = function() {
                            v.muted = true;
                            var p = v.play();
                            if (p && p.catch) { p.catch(function() {}); }
                        };
                        v.addEventListener('canplay', onReady, { once: true });
                        v.addEventListener('loadedmetadata', onReady, { once: true });
                    } else if (v.src) {
                        // Ya tiene src cargado: play() directo
                        v.muted = true;
                        var p = v.play();
                        if (p && p.catch) { p.catch(function() {}); }
                    }
                } else if (!v.paused) {
                    v.pause();
                }
            });
        }, { rootMargin: '300px 0px', threshold: 0.05 });

        videos.forEach(function(v) {
            v.preload = 'metadata';
            v.muted = true;
            v.removeAttribute('autoplay');
            obs.observe(v);
        });

        // Al cambiar de pestaña también se frenan, para no gastar batería
        document.addEventListener('visibilitychange', function() {
            videos.forEach(function(v) {
                if (document.hidden) {
                    v.pause();
                } else if (v.src && v.getBoundingClientRect().top < window.innerHeight && v.getBoundingClientRect().bottom > 0) {
                    var p = v.play();
                    if (p && p.catch) { p.catch(function() {}); }
                }
            });
        });
    }

    // Ejecución segura
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initSocialVideos);
    } else {
        initSocialVideos();
    }
</script>

