<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style" />
        
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

        {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {# Loads private Tienda Nube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

        {# Theme icons #}

        {% include "snipplets/svg/icons.tpl" %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Page content #}

        {# Página en construcción con la estética original de la tienda (la portada de la home): la foto del hero con
           el velo oscuro, el logo SGNS Studio, la línea fina con "Próximamente" y el formulario en píldoras blancas #}
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700&display=swap" rel="stylesheet">
        <style>
            body.template-password { margin: 0; background: #0d0d0d; overflow: hidden; }
            #sgns-pw { position: fixed; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 44px; padding: 24px 16px; box-sizing: border-box; overflow-y: auto; color: #fff; font-family: 'Outfit', sans-serif; text-align: center; }
            /* De fondo, el video del local de VM Washington 691 (el de la sección de locales de la home);
               la foto del mismo local queda abajo mientras carga o si no arranca */
            #sgns-pw .sgns-pw__fondo { position: fixed; inset: 0; z-index: 0; background: #0d0d0d url('{{ "locales/local-3.webp" | static_url }}') center / cover no-repeat; }
            #sgns-pw .sgns-pw__video { position: fixed; inset: 0; z-index: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0; transition: opacity .8s ease; pointer-events: none; }
            #sgns-pw .sgns-pw__video.is-playing { opacity: 1; }
            #sgns-pw .sgns-pw__velo { position: fixed; inset: 0; z-index: 1; background: linear-gradient(180deg, rgba(0,0,0,.45) 0%, rgba(0,0,0,.5) 55%, rgba(0,0,0,.78) 100%); }
            #sgns-pw .sgns-pw__marca, #sgns-pw .sgns-pw__form { position: relative; z-index: 2; }
            #sgns-pw .sgns-pw__marca { display: flex; flex-direction: column; align-items: center; }
            #sgns-pw .sgns-pw__marca h1 { margin: 0; line-height: 0; }
            #sgns-pw .sgns-pw__marca img { width: clamp(170px, 22vw, 300px); max-width: 64vw; height: auto; filter: drop-shadow(0 4px 20px rgba(0,0,0,.45)); }
            /* Línea fina a los lados, igual que "Temporada 26" en la portada */
            #sgns-pw .sgns-pw__eyebrow { display: flex; align-items: center; gap: 16px; margin-top: 18px; color: rgba(255,255,255,.9); font-size: 11px; font-weight: 500; letter-spacing: .42em; text-transform: uppercase; text-shadow: 0 1px 10px rgba(0,0,0,.35); }
            #sgns-pw .sgns-pw__eyebrow::before, #sgns-pw .sgns-pw__eyebrow::after { content: ''; width: 44px; height: 1px; background: rgba(255,255,255,.6); }
            #sgns-pw .sgns-pw__msg { max-width: 420px; margin: 16px 0 0; color: rgba(255,255,255,.75); font-size: 14px; line-height: 1.5; }
            #sgns-pw .sgns-pw__form { width: min(340px, 100%); }
            #sgns-pw .sgns-pw__form form { margin: 0; }
            #sgns-pw .sgns-pw__form label { display: block; margin-bottom: 10px; color: rgba(255,255,255,.75) !important; font-family: 'Outfit', sans-serif !important; font-size: 11px !important; font-weight: 500; letter-spacing: .24em; text-transform: uppercase; }
            #sgns-pw .sgns-pw__form .form-group { position: relative; margin-bottom: 12px; }
            #sgns-pw .sgns-pw__form input { width: 100%; height: 48px; box-sizing: border-box; background: rgba(255,255,255,.08) !important; color: #fff !important; border: 1px solid rgba(255,255,255,.6) !important; border-radius: 999px !important; font-family: 'Outfit', sans-serif !important; font-size: 14px; text-align: center; -webkit-backdrop-filter: blur(8px); backdrop-filter: blur(8px); transition: border-color .25s ease, background-color .25s ease; }
            #sgns-pw .sgns-pw__form input::placeholder { color: rgba(255,255,255,.55); opacity: 1; letter-spacing: .04em; }
            #sgns-pw .sgns-pw__form input:focus { border-color: #fff !important; background: rgba(255,255,255,.14) !important; box-shadow: none !important; outline: none; }
            #sgns-pw .sgns-pw__form input.js-password-input { padding-left: 46px !important; padding-right: 46px !important; }
            /* Celular: con letra de menos de 16px el iPhone hace zoom al tocar el campo */
            @media (max-width: 767px), (hover: none) and (pointer: coarse) { #sgns-pw .sgns-pw__form input { font-size: 16px !important; } }
            #sgns-pw .sgns-pw__form .form-toggle-eye { color: #fff !important; background: none !important; box-shadow: none !important; width: auto !important; cursor: pointer; z-index: 2; }
            #sgns-pw .sgns-pw__form .form-toggle-eye svg, #sgns-pw .sgns-pw__form .form-toggle-eye .svg-icon-text { fill: rgba(255,255,255,.85) !important; }
            #sgns-pw .sgns-pw__form .form-toggle-eye:focus-visible { outline: 2px solid #fff; outline-offset: -4px; border-radius: 999px; }
            #sgns-pw .sgns-pw__form .btn-link, #sgns-pw .sgns-pw__form .mt-4 { display: none !important; }
            #sgns-pw .sgns-pw__form .alert-danger { margin: 10px 0 0; padding: 8px 14px; border: 0; border-radius: 999px; background: rgba(230,0,0,.18); color: #fff; font-size: 13px; }
            /* El botón como "Desbloquear" en blanco lleno, igual a los de la portada */
            #sgns-pw .sgns-pw__form button[type="submit"] { width: 100%; height: 48px; border: 1px solid #fff !important; border-radius: 999px !important; background: #fff !important; color: #111 !important; font-family: 'Outfit', sans-serif !important; font-size: 12.5px !important; font-weight: 700; letter-spacing: .16em; text-transform: uppercase; box-shadow: none !important; transition: background-color .25s ease, color .25s ease, transform .25s ease; }
            #sgns-pw .sgns-pw__form button[type="submit"]:hover { background: #111 !important; border-color: #111 !important; color: #fff !important; transform: scale(1.03); }
            #sgns-pw .sgns-pw__form button[type="submit"]:focus-visible { outline: 2px solid #fff; outline-offset: 3px; }
            @media (prefers-reduced-motion: reduce) { #sgns-pw .sgns-pw__form button[type="submit"]:hover { transform: none; } }
        </style>

        <section id="sgns-pw">
                    <div class="sgns-pw__fondo" aria-hidden="true"></div>
                    <video class="sgns-pw__video" src="{{ 'locales/local-3-v2.mp4' | static_url }}" muted loop playsinline autoplay preload="auto" aria-hidden="true"></video>
                    <script>
                    (function() {
                        var v = document.querySelector('#sgns-pw .sgns-pw__video');
                        if (!v) { return; }
                        v.muted = true;
                        function mostrar() { v.classList.add('is-playing'); }
                        v.addEventListener('playing', mostrar);
                        if (!v.paused && v.readyState > 2) { mostrar(); }
                        var p = v.play();
                        if (p && p.catch) { p.catch(function() {}); }
                    })();
                    </script>
                    <div class="sgns-pw__velo" aria-hidden="true"></div>
                    <div class="sgns-pw__marca">
                        <h1><img src="{{ 'images/sgns-studio-intro.png' | static_url }}" alt="SGNS Studio" width="900" height="407" fetchpriority="high" /></h1>
                        <span class="sgns-pw__eyebrow">Próximamente</span>
                        {% if message %}<p class="sgns-pw__msg">{{ message }}</p>{% endif %}
                    </div>
                    <div class="sgns-pw__form">
                        {% embed "snipplets/forms/form.tpl" with{form_id: 'password-form', submit_text: 'Desbloquear' | translate } %}
                            {% block form_body %}

                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'password', type_password: true, input_name: 'password', input_placeholder: 'Escribí la contraseña', input_help: true, input_help_link: store.customer_reset_password_url, input_label_text: 'Contraseña de acceso' | translate } %}
                                    {% block input_form_alert %}
                                        {% if invalid_password == true %}
                                            <div class="alert alert-danger">{{ 'La contraseña es incorrecta.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                            {% endblock %}
                        {% endembed %}
                    </div>
        </section>

        {# Ojo para ver la contraseña. El de la tienda vive en static/js/store.js.tpl, que esta página no carga #}
        <script id="sgns-pw-ojo">
        (function() {
            var ojo = document.querySelector('#sgns-pw .js-password-view');
            var campo = ojo ? ojo.parentNode.querySelector('.js-password-input') : null;
            if (!ojo || !campo) { return; }
            ojo.setAttribute('role', 'button');
            ojo.setAttribute('tabindex', '0');
            ojo.setAttribute('aria-pressed', 'false');
            campo.setAttribute('autocapitalize', 'off');
            campo.setAttribute('autocorrect', 'off');
            campo.setAttribute('spellcheck', 'false');
            function cambiar(e) {
                e.preventDefault();
                var ver = campo.type === 'password';
                campo.type = ver ? 'text' : 'password';
                ojo.classList.toggle('password-view', ver);
                ojo.setAttribute('aria-pressed', ver ? 'true' : 'false');
                ojo.setAttribute('aria-label', ver ? 'Ocultar contraseña' : 'Ver contraseña');
                var abierto = ojo.querySelector('.js-eye-open'), cerrado = ojo.querySelector('.js-eye-closed');
                if (abierto) { abierto.style.display = ver ? '' : 'none'; }
                if (cerrado) { cerrado.style.display = ver ? 'none' : ''; }
            }
            ojo.addEventListener('click', cambiar);
            ojo.addEventListener('keydown', function(e) { if (e.key === 'Enter' || e.key === ' ') { cambiar(e); } });
        })();
        </script>

        {# Javascript needed to footer logos lazyload #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

        </script>

        {# Google survey JS for Tienda Nube Survey #}

        {{ component('google-survey') }}


    </body>
</html>
