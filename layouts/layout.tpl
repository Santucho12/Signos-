{#/*============================================================================
  #Preview / Redesign System
  - PRODUCCIÓN: El rediseño está ACTIVO en todas las páginas EXCEPTO el Home.
  - PREVIEW: En el Home, se puede previsualizar con ?redesign=mi_redesign_2026
  - Desactivar preview: ?redesign=off
==============================================================================*/#}

{% set _redesign_key = 'mi_redesign_2026' %}
{% set _is_redesign_production = true %}

{#/*============================================================================
  #Ruletas (interruptor maestro)
  - true  → aparecen la ruleta principal, el Tiro Extra y el banner de progreso.
  - false → no se carga nada de eso (ni scripts, ni modales, ni carteles).
  Cambiar solo esta linea para activar/desactivar.
==============================================================================*/#}
{% set _ruletas_activas = false %}
{% set _is_event_page = (page.handle == 'registroevento' or page.handle == 'registro-evento' or page.handle == 'evento' or page.handle == 'registroeventoparticipantes' or page.handle == 'registro-evento-participantes') %}

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}" {% if _is_redesign_production %}class="redesign-active"{% endif %}>
    <head>
        {# 1. PRE-CARGA DE ACTIVOS CRÍTICOS (Soluciona parpadeos y saltos) #}
        <link rel="preload" href="{{ 'fonts/Fontspring-DEMO-blunt-semiconit.otf' | static_url }}" as="font" type="font/otf" crossorigin>
        <link rel="preload" href="{{ 'images/sgns-studio-logo.png' | static_url }}" as="image" fetchpriority="high">
        <link rel="preload" href="{{ 'images/logo final monograma_Mesa de trabajo 1.png' | static_url }}" as="image" fetchpriority="high">

        {# 2. CSS CRÍTICO DEL REDISEÑO (Inyectado directamente para que sea INSTANTÁNEO) #}
        <style>
            /* Reglas base que DEBEN cargar antes de cualquier archivo externo */
            @font-face {
                font-family: 'Blunt Semiconit';
                src: url('{{ "fonts/Fontspring-DEMO-blunt-semiconit.otf" | static_url }}') format('opentype');
                font-weight: normal;
                font-style: normal;
                font-display: swap; /* 'swap' pinta el texto de inmediato con la fuente de respaldo */
            }
            {# El body ya NO se oculta: ocultarlo hasta DOMContentLoaded dejaba la
               pantalla en blanco mientras se parseaban ~360 KB de JS inline. #}

            /* Lenis Smooth Scroll Setup */
            html.lenis {
              height: auto;
            }
            .lenis-smooth {
              scroll-behavior: auto !important;
            }
            .lenis-smooth [data-lenis-prevent] {
              overscroll-behavior: contain;
            }
            .lenis-stopped {
              overflow: hidden;
            }
            .lenis-scrolling iframe {
              pointer-events: none;
            }

            /* Banner Superior Crítico (Para que no salte) */
            .redesign-top-banner {
                background: #000;
                height: 44px;
                display: flex;
                align-items: center;
                overflow: hidden;
            }
            .redesign-top-banner img { height: 100%; width: auto; }

            /* Evita que se vea la home original o salte antes de la intro */
            .redesign-active .original-home-content {
                display: none !important;
            }
        </style>

        {# Script Global de Detección de Preview (Evita parpadeos y permite desarrollo seguro) #}
        <script>
            {# Interruptor de ruletas disponible antes de que cargue cualquier script #}
            window.RULETAS_ACTIVAS = {% if _ruletas_activas %}true{% else %}false{% endif %};

            (function(){
                var KEY = '{{ _redesign_key }}';
                var COOKIE = 'redesign_preview';
                var urlParam = new URLSearchParams(window.location.search).get('redesign');
                var isPreview = false;

                if (urlParam === KEY) {
                    document.cookie = COOKIE + '=1;path=/;SameSite=Lax';
                    isPreview = true;
                } else if (urlParam === 'off') {
                    document.cookie = COOKIE + '=;path=/;expires=Thu, 01 Jan 1970 00:00:00 GMT';
                    isPreview = false;
                } else if (document.cookie.indexOf(COOKIE + '=1') !== -1) {
                    isPreview = true;
                }

                if (isPreview) {
                    document.documentElement.classList.add('redesign-preview');
                }

{# Home ya no requiere preview: redesign-active se aplica desde el HTML server-side #}
            })();
        </script>

        {# style-redesign.scss se carga una sola vez, mas abajo. Estaba duplicado aca. #}

        {# Sin preload del video del hero: el <video> usa preload="none" y lo pide
           por JS despues del primer pintado. Precargarlo solo robaba ancho de banda
           al CSS critico (1,2 MB en mobile / 6,6 MB en desktop). #}

<link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        {# Favicon Circular Oficial #}
        <link rel="icon" type="image/png" href="{{ 'favicon.png' | static_url }}" />
        <link rel="shortcut icon" type="image/png" href="{{ 'favicon.png' | static_url }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
        {# Fuentes Premium para el Rediseño 2026 #}
        {# Cormorant Garamond no se usa en el CSS: se quito (eran 6 variantes al pedo).
           Outfit se pide solo en los pesos realmente usados (300-900): antes faltaban
           800 y 900, que el navegador tenia que sintetizar. #}
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        
        <style>
            @font-face {
                font-family: 'Blunt Semiconit';
                src: url('{{ "fonts/Fontspring-DEMO-blunt-semiconit.otf" | static_url }}') format('opentype');
                font-weight: normal;
                font-style: normal;
                font-display: swap;
            }
        </style>
        
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style" />

        {# Preload LCP home, category and product page elements #}
        
        {% snipplet 'preload-images.tpl' %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>
            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '400,700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}

        </style>

        {# Critical CSS #}

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        {# Estilos del Rediseño 2026 #}
        <link rel="stylesheet" href="{{ 'css/style-redesign.scss' | static_url }}">

        <style>
            /* FIX MAESTRO: Notificación de Carrito — Aparece SOLO centrada */
            .notification-cart-container,
            .notification-fixed,
            .js-alert-added-to-cart {
                position: fixed !important;
                top: 100px !important;
                left: 50% !important;
                right: auto !important;
                transform: translateX(-50%) !important;
                width: 92% !important;
                max-width: 420px !important;
                margin: 0 auto !important;
                z-index: 9999999 !important;
                opacity: 0 !important;
                visibility: hidden !important;
                pointer-events: none !important;
                transition: none !important; /* Sin transición = sin flash */
                box-shadow: 0 15px 45px rgba(0,0,0,0.3) !important;
                background: #fff !important;
                border-radius: 20px !important;
            }
            .notification-cart-container.notification-visible,
            .notification-fixed.notification-visible,
            .js-alert-added-to-cart.notification-visible {
                opacity: 1 !important;
                visibility: visible !important;
                pointer-events: auto !important;
                display: flex !important;
                animation: fadeInCenter 0.3s ease forwards !important;
            }
            @keyframes fadeInCenter {
                from { opacity: 0; }
                to { opacity: 1; }
            }
        </style>

        {# Redesign preview: CSS conditionally loaded via JS at the end of the body #}

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>



        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {% if load_jquery %}

            {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {% endif %}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data-organization') }}
        {{ component('structured-data') }}

        {% if template == 'home' %}
            {# Bloqueo y velo inmediato para que el primer fotograma ya tenga la intro y no parpadee nada #}
            <script>(function(){document.documentElement.classList.add("sgns-intro-on","sgns-intro-lock");})();</script>
        {% endif %}

    </head>
    <body class="redesign-active {% if _is_event_page %}is-event-page{% endif %} {% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

        {# Theme icons #}

        {% include "snipplets/svg/icons.tpl" %}

        {# Facebook comments on product page #}

        {% if template == 'product' %}

            {# Facebook comment box JS #}
            {% if settings.show_product_fb_comment_box %}
                {{ fb_js }}
            {% endif %}

            {# Pinterest share button JS #}
            {{ pin_js }}

        {% endif %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {% if not _is_event_page %}
            {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

            {% snipplet "header/header.tpl" %}

            {% if settings.show_tab_nav %}
                {% snipplet "navigation/navigation-tabs.tpl" %}
            {% endif %}
        {% endif %}

        {# Page content #}

        {% template_content %}

        {% if not _is_event_page %}
            {# Quickshop modal #}

            {% snipplet "grid/quick-shop.tpl" %}

            {# WhatsApp chat button #}

            {% snipplet "whatsapp-chat.tpl" %}

            {# Footer #}

            {% snipplet "footer/footer.tpl" %}
        {% endif %}

        {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

            {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

            <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
            <span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
            <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
            <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
        {% endif %}

        {#/*============================================================================
            #Javascript: Needed after HTML loads
        ==============================================================================*/#}

        {# Javascript used in the store #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Libraries that requires Jquery to work #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}

                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {# Google reCAPTCHA on register page #}

        {% if template == 'account.register' %}
            {% if not store.hasContactFormsRecaptcha() %}
                {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
            {% endif %}
            <script type="text/javascript">
                var recaptchaCallback = function() {
                    jQueryNuvem('.js-recaptcha-button').prop('disabled', false);
                };
            </script>
        {% endif %}

        {# Google survey JS for Tiendanube Survey #}

        {{ component('google-survey') }}

        {# Store external codes added from admin #}

        {% if store.assorted_js %}
            <script>
                LS.ready.then(function() {
                    var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
                    jQueryNuvem('body').append(trackingCode);
                });
            </script>
        {% endif %}
        {# Redesign Preview: JS + badge + cookie management #}
        <script>
        (function(){
            var isPreview = document.documentElement.classList.contains('redesign-preview');
            var JS_URL   = '{{ "js/redesign.js" | static_url }}';

            // ── Cargar utilidades (SIEMPRE en producción) ───────────────
            // Sin '?v=' + timestamp: ese parametro rompia el cache en cada visita
            // y obligaba a re-descargar los 5 scripts en cada pagina.
            var loadScript = function(url) {
                var s = document.createElement('script');
                s.src = url;
                s.async = true;
                document.body.appendChild(s);
            };

            var loadMarketing = function() {
                loadScript('{{ "js/modals-marketing.js" | static_url }}');
                {% if _ruletas_activas %}
                loadScript('{{ "js/cart-marketing.js" | static_url }}');
                {% endif %}
                loadScript('{{ "js/cart-notes.js" | static_url }}');
                loadScript('{{ "js/coupon-countdown.js" | static_url }}');
            };

            var isHome = {{ template == 'home' ? 'true' : 'false' }};
            if (isHome) {
                window.addEventListener('load', function() {
                    setTimeout(loadMarketing, 1200);
                });
            } else {
                loadMarketing();
            }

            // ── Pre-calentamiento de Vercel ──
            // Se difiere hasta despues del load: hacerlo durante la carga critica
            // gastaba DNS+TLS de dos dominios extra compitiendo con el render.
            window.addEventListener('load', function() {
                setTimeout(function() {
                    [
                        {% if _ruletas_activas %}
                        'https://ruleta-signos.vercel.app/',
                        'https://ruleta-signos.vercel.app/tiroextra',
                        {% endif %}
                        'https://probador-virtual-signosindumentaria.vercel.app/'
                    ].forEach(function(url) {
                        fetch(url, { method: 'GET', mode: 'no-cors' }).catch(function(){});
                    });
                }, 2000);
            });

            // ── Inicialización de Ruleta Principal (PÚBLICO) ──────────────
            window.addEventListener('load', function() {
                if (typeof MarketingModals !== 'undefined') {
                    // 1. Probador Virtual (Manual)
                    MarketingModals.init({
                        id: 'redesign-probador-modal',
                        url: 'https://probador-virtual-signosindumentaria.vercel.app/',
                        delay: -1,
                        containerClass: 'probador-container',
                        isPreviewOnly: false
                    });

                    // Trigger del Probador: abrir al hacer click en el botón
                    document.addEventListener('click', function(e) {
                        var btn = e.target.closest('.js-probador-btn');
                        if (btn) {
                            e.preventDefault();
                            var m = document.getElementById('redesign-probador-modal');
                            if (m) {
                                var separator = 'https://probador-virtual-signosindumentaria.vercel.app/'.indexOf('?') !== -1 ? '&' : '?';
                                m.querySelector('iframe').src = 'https://probador-virtual-signosindumentaria.vercel.app/' + separator + 'cb=' + new Date().getTime();
                                m.classList.add('is-open');
                                document.body.style.overflow = 'hidden';
                            }
                        }
                    });

                    // 2. Ruleta Principal (solo si el interruptor esta encendido)
                    {% if _ruletas_activas %}
                    MarketingModals.init({
                        id: 'redesign-ruleta-modal',
                        url: 'https://ruleta-signos.vercel.app/',
                        delay: 1300,
                        sessionKey: 'ruleta_visto',
                        isPreviewOnly: false // LIBERADO
                    });
                    {% endif %}
                }
            });

            // ── Filtro de Preview para el resto del sitio ──────────────────
            if (!document.documentElement.classList.contains('redesign-active')) return;

            // ── Inyectar SEO metadata (solo en preview real) ────────────────
            if (isPreview) {
                var meta = document.createElement('meta');
                meta.name = 'robots';
                meta.content = 'noindex, nofollow';
                document.head.appendChild(meta);
            }

            // ── Cargar utilidades de rediseño ──────────────────────────
            var loadScriptRedesign = function(url) {
                var s = document.createElement('script');
                s.src = url;
                s.async = true;
                document.body.appendChild(s);
            };

            loadScriptRedesign(JS_URL);

            // ── Badge de preview ──────────────────────────────────────────────
            if (isPreview) {
                var badge = document.createElement('div');
                badge.id = 'redesign-badge';
                badge.innerHTML = '&#127912; PREVIEW MODE <button id="redesign-exit-btn">&#10005; Salir</button>';
                badge.style.cssText = [
                    'position:fixed',
                    'bottom:20px',
                    'left:20px',
                    'z-index:99999',
                    'background:linear-gradient(135deg,#e74c3c,#c0392b)',
                    'color:#fff',
                    'padding:10px 18px',
                    'border-radius:10px',
                    'font-family:monospace',
                    'font-size:13px',
                    'font-weight:bold',
                    'box-shadow:0 4px 20px rgba(0,0,0,.4)',
                    'display:flex',
                    'align-items:center',
                    'gap:10px',
                    'letter-spacing:.5px'
                ].join(';');
                document.body.appendChild(badge);

                var exitBtn = document.getElementById('redesign-exit-btn');
                exitBtn.style.cssText = [
                    'background:rgba(255,255,255,.2)',
                    'color:#fff',
                    'border:none',
                    'border-radius:5px',
                    'padding:3px 10px',
                    'cursor:pointer',
                    'font-family:monospace',
                    'font-size:12px'
                ].join(';');
                exitBtn.onclick = function(){
                    window.location.href = window.location.pathname + '?redesign=off';
                };
            }

            // ── #6: Botón "Volver Arriba" flotante (Solo en Productos/Categorías) ──────────────────────────
            if (document.body.classList.contains('template-category') || document.body.classList.contains('template-product')) {
                var scrollBtn = document.createElement('button');
                scrollBtn.className = 'redesign-scroll-top-btn';
                scrollBtn.innerHTML = '&#8593;';
                scrollBtn.setAttribute('aria-label', 'Volver arriba');
                document.body.appendChild(scrollBtn);

                scrollBtn.addEventListener('click', function() {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                });

                window.addEventListener('scroll', function() {
                    if (window.scrollY > 400) {
                        scrollBtn.classList.add('visible');
                    } else {
                        scrollBtn.classList.remove('visible');
                    }
                });
            }

            // El bloque de inicialización fue movido arriba para permitir producción.
        })();
        </script>
        <!-- Scroll suave (Lenis): libreria local + init con teclado, links y modales -->
        <script>
            window.__sgnsLenisUrl = '{{ "js/lenis.min.js" | static_url }}';
        </script>
        <script src="{{ "js/smooth-scroll.js" | static_url }}" defer></script>
        <script src="{{ "js/whatsapp-bubble.js" | static_url }}" defer></script>
        <script src="{{ "js/header-island.js" | static_url }}" defer></script>
        {% if template == 'home' %}
            {# Intro cinematográfica del inicio #}
            <script src="{{ "js/intro.js" | static_url }}" defer></script>
            {# El hero se oscurece al scrollear #}
            <script src="{{ "js/hero-scroll.js" | static_url }}" defer></script>
        {% endif %}
        {% if template == 'category' or template == 'search' %}
            {# Menú de "Ordenar" propio (reemplaza al select nativo) #}
            <script src="{{ "js/sort-menu.js" | static_url }}" defer></script>
        {% endif %}

        {# Drop 01 bloqueado en todos los links (menú, pie, etc.) hasta el viernes 2/10/2026 22:00 #}
        <script src="{{ "js/drop-lock.js" | static_url }}" defer></script>

    </body>
</html>
