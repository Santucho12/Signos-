{#/*============================================================================
  #Preview / Redesign System
  - PRODUCCIÓN: El rediseño está ACTIVO en todas las páginas EXCEPTO el Home.
  - PREVIEW: En el Home, se puede previsualizar con ?redesign=mi_redesign_2026
  - Desactivar preview: ?redesign=off
==============================================================================*/#}

{% set _redesign_key = 'mi_redesign_2026' %}
{% set _is_redesign_production = (template != 'home') or params.preview %}

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
                font-display: block; /* 'block' evita que se vea la fuente vieja antes que la nueva */
            }
            .redesign-active body { opacity: 0; } /* Evita parpadeo inicial del diseño viejo */
            .redesign-active.visible-when-content-ready body { opacity: 1; transition: opacity 0.3s ease; }
            
            /* Banner Superior Crítico (Para que no salte) */
            .redesign-top-banner {
                background: #000;
                height: 44px;
                display: flex;
                align-items: center;
                overflow: hidden;
            }
            .redesign-top-banner img { height: 100%; width: auto; }
        </style>

        {# Script Global de Detección de Preview (Evita parpadeos y permite desarrollo seguro) #}
        <script>
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

                {# Seguridad de visibilidad: Fuerza la aparición del rediseño apenas el DOM es procesado #}
                document.addEventListener('DOMContentLoaded', function() {
                    document.documentElement.classList.add('visible-when-content-ready');
                });

                {% if template == 'home' %}
                    {# En el Home, el diseño completo (redesign-active) solo se activa en Preview #}
                    if (isPreview) {
                        document.documentElement.classList.add('redesign-active');
                        document.write('<link rel="stylesheet" href="{{ "css/style-redesign.scss" | static_url }}">');
                    }
                {% endif %}
            })();
        </script>

        {% if _is_redesign_production %}
            {# PRODUCCIÓN (Categorías/Productos/Preview Admin): El diseño base ya es activo #}
            <link rel="stylesheet" href="{{ 'css/style-redesign.scss' | static_url }}">
        {% endif %}

        {# Optimización de Video Hero (Carga Prioritaria Máxima) #}
        {% if template == 'home' %}
            <link rel="preload" href="{{ 'recortado-7026828-uhd_4096_2160_25fps.mp4' | static_url }}" as="video" type="video/mp4" fetchpriority="high">
        {% endif %}

        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
        {# Fuentes Premium para el Rediseño 2026 #}
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Outfit:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
        
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

    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

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

        {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

        {% snipplet "header/header.tpl" %}

        {% if settings.show_tab_nav %}
            {% snipplet "navigation/navigation-tabs.tpl" %}
        {% endif %}

        {# Page content #}

        {% template_content %}

        {# Quickshop modal #}

        {% snipplet "grid/quick-shop.tpl" %}

        {# WhatsApp chat button #}

        {% snipplet "whatsapp-chat.tpl" %}

        {# Footer #}

        {% snipplet "footer/footer.tpl" %}

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

            if (!document.documentElement.classList.contains('redesign-active')) return;

            // ── Inyectar SEO metadata (solo en preview real) ────────────────
            if (isPreview) {
                var meta = document.createElement('meta');
                meta.name = 'robots';
                meta.content = 'noindex, nofollow';
                document.head.appendChild(meta);
            }

            // ── Cargar redesign.js con cache-buster ──────────────────────────
            var script = document.createElement('script');
            script.src = JS_URL + '?v=' + new Date().getTime();
            document.body.appendChild(script);

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

            // ── Probador Virtual Modal ──────────────────────────────────────
            var MODAL_ID = 'redesign-probador-modal';
            var IFRAME_URL = 'https://probador-virtual-signosindumentaria.vercel.app/';

            if (!document.getElementById(MODAL_ID)) {
                var modal = document.createElement('div');
                modal.id = MODAL_ID;

                var container = document.createElement('div');
                container.className = 'probador-container';

                var closeBtn = document.createElement('button');
                closeBtn.className = 'close-btn';
                closeBtn.innerHTML = '&#10005;';

                var iframe = document.createElement('iframe');

                container.appendChild(closeBtn);
                container.appendChild(iframe);
                modal.appendChild(container);
                document.body.appendChild(modal);

                var openModal = function() {
                    iframe.src = IFRAME_URL;
                    modal.classList.add('is-open');
                    document.body.style.overflow = 'hidden';
                };

                var closeModal = function() {
                    modal.classList.remove('is-open');
                    document.body.style.overflow = '';
                    setTimeout(function() {
                        if (!modal.classList.contains('is-open')) {
                            iframe.src = 'about:blank';
                        }
                    }, 400);
                };

                closeBtn.onclick = function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    closeModal();
                };
                modal.onclick = function(e) { 
                    if(e.target === modal) {
                        e.preventDefault();
                        closeModal(); 
                    }
                };

                document.addEventListener('click', function(e) {
                    var btn = e.target.closest('.js-probador-btn');
                    if (btn) {
                        e.preventDefault();
                        if (modal.classList.contains('is-open')) {
                            closeModal();
                        } else {
                            openModal();
                        }
                    }
                });
            }
        })();
        </script>
    </body>
</html>
