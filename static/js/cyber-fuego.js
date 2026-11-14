/* CYBER SALE EXTENDIDO "POTENCIADO": el Cyber se activa el jueves 5/11 a las 22:00 (INICIO) y dura 48 horas, hasta el
   sábado 7/11 a las 22:00 (FIN48). Ahí se extiende 24 horas más, hasta el domingo 8/11 a las 22:00 (FIN). Los
   contadores de la promoción (cartel de la portada y de la construcción, franja de arriba, botón del inicio) cuentan
   hasta FIN48 y, al llegar a cero, vuelven a 24 horas y cuentan hasta FIN ("termina en"). Solo el botón del inicio tiene una espera antes: bloqueado
   y "Se activa en" hasta INICIO. Mientras tanto la tienda se prende fuego, con el neón rojo del Cyber:
   - Página en construcción (templates/password.tpl) y portada de la categoría del Cyber: un infierno. Llamas que
     suben por el piso y por los costados, el cartel CYBER SALE prendido fuego por arriba y chispas por toda la
     pantalla (WebGL; sin WebGL queda un resplandor de fuego en CSS). El contador va en un cartel de neón.
   - Inicio: el botón CYBER SALE, bloqueado con candado hasta INICIO (lo maneja templates/home.tpl con
     data-drop-unlock), con llamas que salen de su borde de arriba. Desde INICIO lleva a la categoría del Cyber y
     cuenta hasta FIN.
   - Tarjetas de los productos del Cyber (en su categoría y en toda la tienda): llamas en el borde de arriba
     (un solo fuego en WebGL que se copia en cada tarjeta visible).
   - Franja negra de beneficios de arriba (static/js/header-island.js): suma "Cyber extendido · termina en ...".
   El fuego se ve aunque Windows o el celular tengan desactivadas las animaciones (pedido explícito), un poco más lento.
   Se apaga solo al llegar a FIN. Para cambiar las fechas: INICIO acá, data-drop-unlock y data-drop-cierre del botón
   del Cyber en templates/home.tpl, y RESPALDO.cyber en static/js/drop-lock.js. El fuego usa el rojo de la marca
   (#E60000) con naranja y amarillo para que parezca fuego de verdad. */
(function() {
    'use strict';
    var INICIO = new Date('2026-11-05T22:00:00-03:00').getTime();   // jueves 5/11 a las 22:00: se activa el Cyber
    var FIN48 = INICIO + 48 * 36e5;                                  // dura 48 horas: sábado 7/11 a las 22:00...
    var FIN = FIN48 + 24 * 36e5;                                     // ...y se extiende 24 horas más: domingo 8/11 a las 22:00
    if (Date.now() >= FIN || window.__sgnsFuego) { return; }
    window.__sgnsFuego = true;

    var root = document.documentElement;
    var lento = !!(window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches);
    var VEL = lento ? 0.75 : 1;
    function esCel() { return window.innerWidth < 768; }
    root.classList.add('sgns-fuego');

    function pad(n) { return String(n).padStart(2, '0'); }
    function resto() {
        var ahora = Date.now();
        // Los contadores cuentan hasta el sábado 22:00 (FIN48); al llegar a cero vuelven a 24 horas y cuentan hasta
        // el domingo 22:00 (FIN). espera solo la usa el botón del inicio
        var extra = ahora >= FIN48;
        var t = Math.max(0, (extra ? FIN : FIN48) - ahora);
        return { h: pad(Math.floor(t / 36e5)), m: pad(Math.floor(t / 6e4) % 60), s: pad(Math.floor(t / 1e3) % 60), t: t, espera: ahora < INICIO, extra: extra };
    }

    /* ---------- Llamita (ícono): degradados definidos una sola vez en la página ---------- */
    var DEFS = '<svg id="sgns-fuego-defs" width="0" height="0" style="position:absolute;width:0;height:0;overflow:hidden" aria-hidden="true" focusable="false"><defs>'
        + '<linearGradient id="sgnsFuegoGrad" x1="0" y1="1" x2="0" y2="0"><stop offset="0" stop-color="#FFB000"/><stop offset=".45" stop-color="#FF5A00"/><stop offset="1" stop-color="#E60000"/></linearGradient>'
        + '<linearGradient id="sgnsFuegoNucleo" x1="0" y1="1" x2="0" y2="0"><stop offset="0" stop-color="#FFF6C8"/><stop offset="1" stop-color="#FFC400"/></linearGradient>'
        + '</defs></svg>';
    var LLAMA = '<svg class="sgns-fuego-llama" viewBox="0 0 24 32" aria-hidden="true">'
        + '<path fill="url(#sgnsFuegoGrad)" d="M12 31C5.5 31 2.5 26.2 3.6 20.6 4.6 15.7 8.4 13.1 9.4 8.2c2 2 2.5 4.4 2.2 6.6 2.3-2.5 3.3-7.2 2-13.3 5.2 3.1 8.4 10.1 7.6 17.7C20.6 26.1 17.2 31 12 31Z"/>'
        + '<path fill="url(#sgnsFuegoNucleo)" d="M12 31c-3.1 0-4.6-2.4-4.1-5.2.5-2.5 2.4-3.8 2.9-6.2 1 1 1.3 2.2 1.1 3.4 1.2-1.3 1.7-3.7 1-6.7 2.6 1.5 4.2 5 3.8 8.8C16.4 28.6 14.6 31 12 31Z"/></svg>';

    /* Sin WebGL, las tarjetas llevan una fila de llamas dibujada (SVG que se repite de costado) */
    var PERFIL = 'M0 24C2 19 4 17 5 13c1.5 3 2.5 4 3.5 2.5C9.5 11 12 8 13 3c2 5 3.5 9 5 11.5 1-2 1.5-3.5 1.5-6 2.5 4.5 4.5 7.5 6 9.5 1-2.5 2.5-4.5 2.5-7.5 3 4.5 5 7.5 6.5 8 1-4.5 3.5-7.5 4.5-12.5 2 5 4 9 6 11 1-2 2-3.5 2.5-6 2.5 4.5 4.5 7 6 8 1-2 2.5-3.5 3-6 2 4 3.5 7 3.5 11Z';
    function filaDeLlamas(paradas) {
        var svg = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 60 24' preserveAspectRatio='none'><defs><linearGradient id='g' x1='0' y1='1' x2='0' y2='0'>"
            + paradas.map(function(p) { return "<stop offset='" + p[0] + "' stop-color='" + p[1] + "'" + (p[2] !== undefined ? " stop-opacity='" + p[2] + "'" : '') + '/>'; }).join('')
            + "</linearGradient></defs><path fill='url(#g)' d='" + PERFIL + "'/></svg>";
        return 'url("data:image/svg+xml,' + encodeURIComponent(svg) + '")';
    }

    /* ---------- Estilos ----------
       Todo va con el prefijo H (con ids): el tema le pone su tipografía a absolutamente todo con una regla muy fuerte */
    var H = 'html.sgns-fuego:not(#f1):not(#f2) body:not(#f1):not(#f2)';
    var HC = 'html.sgns-fuego.sgns-fuego-cat:not(#f1):not(#f2) body:not(#f1):not(#f2)';
    var HS = 'html.sgns-fuego.sgns-fuego-sin-gl:not(#f1):not(#f2) body:not(#f1):not(#f2)';
    var T = H + ' ';
    // Tarjetas con fuego: las del Cyber en toda la tienda y todas las de la categoría del Cyber (menos las doradas)
    var SIN_DORADA = ':not(:has(> .sgns-dorada:not(.sgns-dorada--latente)))';
    function tarjeta(pre, sufijo) {
        return [pre + ' .js-item-product.sgns-cyber-card' + SIN_DORADA + sufijo,
            pre.replace('html.sgns-fuego', 'html.sgns-fuego.sgns-fuego-cat') + ' .js-product-table .js-item-product' + SIN_DORADA + sufijo].join(', ');
    }
    var css = [
        /* Llamita */
        T + '.sgns-fuego-llama { display: inline-block; width: .8em; height: 1.05em; vertical-align: -.18em; flex: none; overflow: visible; transform-origin: 50% 100%; filter: drop-shadow(0 0 3px rgba(255,90,0,.85)); animation: sgnsFuegoLlama .9s ease-in-out infinite; }',
        '@keyframes sgnsFuegoLlama { 0%, 100% { transform: scale(1, 1) skewX(0deg); } 25% { transform: scale(.93, 1.08) skewX(-4deg); } 50% { transform: scale(1.04, .94) skewX(3deg); } 75% { transform: scale(.96, 1.06) skewX(-2deg); } }',

        /* Contador: números en cian neón, dos puntos y etiquetas en rosa (como el cartel) */
        T + '.sgns-fuego-reloj { display: inline-flex; align-items: flex-start; gap: .18em; font-family: "Orbitron", sans-serif !important; font-weight: 800 !important; font-style: normal !important; font-variant-numeric: tabular-nums; line-height: 1 !important; color: #ffe5e5 !important; letter-spacing: 0 !important; text-transform: none !important; }',
        T + '.sgns-fuego-reloj > span { display: inline-flex; flex-direction: column; align-items: center; gap: .3em; }',
        T + '.sgns-fuego-reloj b { font-family: "Orbitron", sans-serif !important; font-weight: 800 !important; font-size: 1em !important; color: #ffe5e5 !important; text-shadow: 0 0 .2em #E60000, 0 0 .6em #E60000, 0 0 1.2em rgba(230,0,0,.5) !important; }',
        T + '.sgns-fuego-reloj small { font-family: "Orbitron", sans-serif !important; font-size: .22em !important; font-weight: 700 !important; letter-spacing: .2em !important; text-transform: uppercase !important; color: #ffe5e5 !important; text-shadow: 0 0 6px #E60000; }',
        T + '.sgns-fuego-reloj i { font-family: "Orbitron", sans-serif !important; font-weight: 800 !important; font-style: normal !important; color: #E60000 !important; text-shadow: 0 0 .4em #E60000; animation: sgnsFuegoLatido 1s steps(1) infinite; }',
        '@keyframes sgnsFuegoLatido { 50% { opacity: .25; } }',

        /* Cartel de neón del contador (construcción y portada del Cyber): tapa el fuego de atrás para que se lea */
        T + '.sgns-fuego-cartel { display: inline-flex; flex-direction: column; align-items: center; gap: 9px; padding: 11px 24px 12px; border-radius: 18px; background: rgba(8,6,10,.86); border: 1.5px solid #E60000; box-shadow: 0 0 10px rgba(230,0,0,.55), inset 0 0 12px rgba(230,0,0,.22), 0 0 34px rgba(255,90,0,.35); }',
        T + '.sgns-fuego-cartel p { margin: 0 !important; padding: 0 !important; display: inline-flex; align-items: center; gap: 8px; font-family: "Orbitron", sans-serif !important; font-size: 11px !important; font-weight: 800 !important; letter-spacing: .24em !important; line-height: 1 !important; text-transform: uppercase !important; color: #ffe5e5 !important; text-shadow: 0 0 6px #E60000 !important; white-space: nowrap; }',
        T + '.sgns-fuego-cartel p .sgns-fuego-llama { font-size: 15px; }',
        T + '.sgns-fuego-cartel .sgns-fuego-reloj { font-size: 36px; }',
        '@media (max-width: 767px) { ' + T + '.sgns-fuego-cartel { padding: 10px 18px 11px; gap: 8px; } ' + T + '.sgns-fuego-cartel p { font-size: 9.5px !important; letter-spacing: .16em !important; } ' + T + '.sgns-fuego-cartel .sgns-fuego-reloj { font-size: 30px; } }',

        /* Infierno: el canvas va arriba del cartel y debajo del contador y la contraseña */
        T + '.sgns-fuego-infierno { position: absolute; left: 0; top: 0; width: 100%; height: 100%; pointer-events: none; z-index: 3; opacity: 0; transition: opacity .6s ease; }',
        T + '.sgns-fuego-infierno.is-on { opacity: 1; }',
        /* Sin WebGL: resplandor de fuego en CSS */
        T + '.sgns-fuego-sin-gl::after { content: ""; position: absolute; left: 0; right: 0; bottom: 0; height: 45%; z-index: 3; pointer-events: none; background: radial-gradient(70% 100% at 50% 100%, rgba(255,176,0,.75) 0%, rgba(255,90,0,.55) 25%, rgba(230,0,0,.4) 50%, transparent 78%); animation: sgnsFuegoCalor 1.6s ease-in-out infinite; }',
        '@keyframes sgnsFuegoCalor { 0%, 100% { opacity: .8; } 50% { opacity: 1; } }',

        /* Portada de la categoría del Cyber: contador abajo, arriba del fuego */
        T + '.sgns-drop-hero .sgns-fuego-cuenta { position: absolute; left: 50%; bottom: 26px; transform: translateX(-50%); z-index: 4; }',
        /* Celular: el hero es más alto que la pantalla (snipplets/drop-hero.tpl le suma un margen por debajo para la barra
           del navegador y publica en --sgns-alto-oculto cuánto queda fuera de la pantalla). El contador se sube esa altura:
           pegado al fondo del hero quedaba fuera de la pantalla y no se veía */
        '@media (max-width: 767px) { ' + T + '.sgns-drop-hero .sgns-fuego-cuenta { bottom: calc(42px + var(--sgns-alto-oculto, 0px)); } }',
        /* Escritorio: toda la portada un poco más arriba, para que el contador respire debajo del 70% OFF */
        '@media (min-width: 768px) and (min-aspect-ratio: 4/5) { ' + T + '.sgns-drop-hero .sgns-cyber-portada__centro { top: 51%; } ' + T + '.sgns-drop-hero .sgns-fuego-cuenta { bottom: 46px; } }',

        /* Construcción: contador y contraseña en un mismo panel de neón, que tapa el fuego de atrás. El cartel sube */
        H + '.template-password #sgns-pw .sgns-pw__form { z-index: 6; width: min(420px, 90vw); padding: 16px 22px 18px; border-radius: 22px; background: rgba(8,6,10,.88); border: 1.5px solid #E60000; box-shadow: 0 0 12px rgba(230,0,0,.5), inset 0 0 14px rgba(230,0,0,.18), 0 0 46px rgba(255,90,0,.45); }',
        H + '.template-password #sgns-pw .sgns-fuego-cuenta { display: flex; margin: 0 0 14px; padding: 0 0 14px; background: none; border: 0; border-bottom: 1px solid rgba(230,0,0,.28); border-radius: 0; box-shadow: none; }',
        '@media (max-width: 767px) { ' + H + '.template-password #sgns-pw .sgns-pw__form { padding: 14px 16px 16px; bottom: 16px; background: rgba(8,6,10,.8); } }',
        'html:not(#f1):not(#f2) #sgns-pw .sgns-cyber-portada__centro { top: calc(57% - 160px) !important; }',
        '@media (max-width: 767px) { html:not(#f1):not(#f2) #sgns-pw .sgns-cyber-portada__centro { top: calc(50% - 130px) !important; } }',

        /* Botón del inicio: el mismo neón, con llamas que salen de su borde de arriba */
        T + '.sgns-hero-btn--cyber { overflow: visible !important; }',
        T + '.sgns-hero-btn--cyber .sgns-drop-label, ' + T + '.sgns-hero-btn--cyber:not(.is-locked) .sgns-drop-label { display: inline-flex !important; }',
        T + '.sgns-hero-btn--cyber .sgns-drop-count { display: flex !important; }',
        T + '.sgns-hero-btn--cyber::after { display: none !important; }',
        T + '.sgns-hero-btn--cyber .sgns-fuego-infierno { left: 9%; width: 82%; top: auto; bottom: calc(100% - 6px); height: 52px; z-index: 0; }',
        '@media (max-width: 767px) { ' + T + '.sgns-hero-btn--cyber .sgns-fuego-infierno { height: 40px; } }',
        T + '.sgns-hero-btn--cyber .sgns-fuego-chip { position: absolute; top: -11px; right: -8px; z-index: 2; display: inline-flex; align-items: center; gap: 3px; padding: 3px 8px 3px 6px; border-radius: 999px; background: #07060d; border: 1.5px solid #E60000; color: #ffe5e5 !important; font-family: "Orbitron", sans-serif !important; font-size: 9px !important; font-weight: 800 !important; letter-spacing: .1em !important; line-height: 1 !important; box-shadow: 0 0 10px rgba(230,0,0,.7); }',
        T + '.sgns-hero-btn--cyber .sgns-fuego-chip .sgns-fuego-llama { font-size: 11px; }',
        '@media (max-width: 767px) { ' + T + '.sgns-hero-btn--cyber .sgns-fuego-chip { top: -17px; right: -4px; font-size: 8px !important; padding: 3px 6px 3px 5px; } }',

        /* Tarjetas: el mismo diseño azul noche, con llamas que salen del borde de arriba */
        T + '.sgns-fuego-borde { position: absolute !important; z-index: 0 !important; left: 20px !important; top: -31px !important; width: calc(100% - 40px) !important; height: 36px !important; pointer-events: none; -webkit-mask-image: linear-gradient(90deg, transparent, #000 9%, #000 91%, transparent); mask-image: linear-gradient(90deg, transparent, #000 9%, #000 91%, transparent); }',
        '@media (max-width: 767px) { ' + T + '.sgns-fuego-borde { left: 12px !important; top: -17px !important; width: calc(100% - 24px) !important; height: 21px !important; } }',
        tarjeta(HS, '::after') + ' { content: ""; position: absolute; left: 22px; right: 22px; top: -17px; height: 21px; z-index: 0; pointer-events: none; background-image: '
            + filaDeLlamas([[0, '#FFF1B8'], [0.3, '#FFB000'], [0.65, '#FF5A00'], [1, '#E60000', 0.9]]) + ', ' + filaDeLlamas([[0, '#FF7A00'], [0.5, '#E60000'], [1, '#E60000', 0]])
            + '; background-size: 46px 100%, 64px 130%; background-repeat: repeat-x; background-position: 0 100%, 0 100%; transform-origin: 50% 100%; animation: sgnsFuegoCorre 1.5s linear infinite, sgnsFuegoTiembla .32s ease-in-out infinite alternate; }',
        '@keyframes sgnsFuegoCorre { to { background-position: 46px 100%, -64px 100%; } }',
        '@keyframes sgnsFuegoTiembla { from { transform: scaleY(.82); } to { transform: scaleY(1.06); } }',

        /* Franja negra de beneficios: el aviso del Cyber con el contador */
        T + '.sgns-island-bar .sgns-island-pista > span.sgns-fuego-aviso { display: inline-flex; align-items: center; gap: 8px; color: #ffe5e5 !important; }',
        T + '.sgns-fuego-aviso .sgns-fuego-llama { font-size: 13px; }',
        T + '.sgns-fuego-aviso .sgns-fuego-reloj { font-size: 12px; margin-left: 2px; }'
    ].join('\n');
    var style = document.createElement('style');
    style.id = 'sgns-fuego-css';
    style.textContent = css;
    (document.head || root).appendChild(style);

    /* ---------- Contadores ---------- */
    var relojes = [];
    function reloj(conEtiquetas) {
        var el = document.createElement('span');
        el.className = 'sgns-fuego-reloj';
        el.innerHTML = '<span><b data-k="h">--</b>' + (conEtiquetas ? '<small>Horas</small>' : '') + '</span><i>:</i>'
            + '<span><b data-k="m">--</b>' + (conEtiquetas ? '<small>Min</small>' : '') + '</span><i>:</i>'
            + '<span><b data-k="s">--</b>' + (conEtiquetas ? '<small>Seg</small>' : '') + '</span>';
        relojes.push(el);
        return el;
    }
    function cartel() {
        var c = document.createElement('div');
        c.className = 'sgns-fuego-cuenta sgns-fuego-cartel';
        c.setAttribute('role', 'timer');
        c.innerHTML = '<p>' + LLAMA + 'Extendido · termina en' + LLAMA + '</p>';
        c.appendChild(reloj(true));
        return c;
    }
    var botonHome = null, chipHome = null;
    function tick() {
        var r = resto();
        if (r.t <= 0) { location.reload(); return; }
        // En las 24 horas extra el chip del botón pasa de "+48 HS" a "+24 HS"
        if (r.extra && chipHome && !chipHome.__extra) { chipHome.__extra = true; chipHome.innerHTML = LLAMA + '+24 HS'; }
        relojes.forEach(function(el) {
            el.querySelectorAll('b').forEach(function(b) { b.textContent = r[b.getAttribute('data-k')]; });
        });
        document.querySelectorAll('.sgns-fuego-cuenta').forEach(function(c) {
            c.setAttribute('aria-label', 'El Cyber extendido termina en ' + Number(r.h) + ' horas y ' + Number(r.m) + ' minutos');
        });
        // Botón del inicio: hasta INICIO lo maneja templates/home.tpl (bloqueado, con candado y "Se activa en");
        // desde INICIO se desbloquea, lleva al Cyber y cuenta hasta FIN
        if (botonHome && !r.espera) {
            botonHome.classList.remove('is-locked', 'is-final');
            botonHome.removeAttribute('aria-disabled');
            var d = Math.floor(r.t / 864e5);
            var vals = [pad(d), pad(Math.floor(r.t / 36e5) % 24), r.m, r.s];
            botonHome.querySelectorAll('.js-drop-count span i').forEach(function(el, i) { el.textContent = vals[i]; });
            var lab = botonHome.querySelector('.js-drop-label');
            if (lab && lab.textContent !== 'Termina en') { lab.textContent = 'Termina en'; }
        }
        fuegos.forEach(function(f) { f.medir(); });
    }

    /* ---------- Fuego en WebGL ---------- */
    var VERT = 'attribute vec2 a; void main() { gl_Position = vec4(a, 0., 1.); }';
    var FRAG = [
        '#ifdef GL_FRAGMENT_PRECISION_HIGH',
        'precision highp float;',
        '#else',
        'precision mediump float;',
        '#endif',
        'uniform vec2 uRes; uniform float uT; uniform float uAlto; uniform float uLados; uniform float uLadosDesde; uniform float uEsc;',
        'uniform float uChispas; uniform float uBrillo; uniform float uEncendido; uniform float uBordes; uniform float uTecho;',
        'uniform vec3 uMarco; uniform float uMarcoAlto; uniform float uMarcoK;',
        'float hash(vec2 p) { vec3 q = fract(vec3(p.xyx) * .1031); q += dot(q, q.yzx + 33.33); return fract((q.x + q.y) * q.z); }',
        'float noise(vec2 p) { vec2 i = floor(p); vec2 f = fract(p); vec2 u = f * f * (3. - 2. * f);',
        '  return mix(mix(hash(i), hash(i + vec2(1., 0.)), u.x), mix(hash(i + vec2(0., 1.)), hash(i + vec2(1., 1.)), u.x), u.y); }',
        'float fbm(vec2 p) { float v = 0.; float a = .5; mat2 m = mat2(1.6, 1.2, -1.2, 1.6);',
        '  for (int i = 0; i < 5; i++) { v += a * noise(p); p = m * p; a *= .5; } return v; }',
        // Intensidad de un fuego cuya altura es "alto" (1 en la base, 0 arriba), con lenguas que suben
        'float llamas(float y, vec2 p, float alto, float t, float s, float esc, float base) {',
        '  vec2 q = vec2(p.x * 2.4, p.y) * esc;',
        '  float tv = t * (.6 + .4 * esc);',
        '  float n = fbm(q * 2.6 + vec2(s, -tv * 1.7));',
        '  float n2 = fbm(q * 5.3 + vec2(n * 1.4 + s, -tv * 3.));',
        '  float turb = n * .6 + n2 * .4;',
        '  float h = y / max(alto, .001);',
        '  return clamp((1. - h) * base + (turb - .5) * (1.15 + h * .9), 0., 1.); }',
        // Color del fuego: rojo de la marca en las puntas, naranja, amarillo y amarillo claro en la base
        'vec3 rampa(float c) {',
        '  vec3 col = mix(vec3(.35, 0., 0.), vec3(.902, 0., 0.), smoothstep(0., .3, c));',
        '  col = mix(col, vec3(1., .42, .02), smoothstep(.3, .58, c));',
        '  col = mix(col, vec3(1., .8, .26), smoothstep(.58, .8, c));',
        '  return mix(col, vec3(1., .93, .6), smoothstep(.82, 1., c)); }',
        // Chispas que suben: tres capas de celdas que se desplazan hacia arriba
        'float chispas(vec2 p, float t) {',
        '  float s = 0.;',
        '  for (int k = 0; k < 3; k++) {',
        '    float fk = float(k);',
        '    vec2 g = p * (8. + fk * 7.);',
        '    g.y -= t * (1.5 + fk * .7);',
        '    g.x += sin(g.y * .4 + fk * 2.1 + t * .5) * .5;',
        '    vec2 id = floor(g); vec2 f = fract(g) - .5;',
        '    float r = hash(id + fk * 31.7);',
        '    vec2 o = (vec2(hash(id + 5.1), hash(id + 9.3)) - .5) * .6;',
        '    float tam = .045 + .05 * hash(id + 2.9);',
        '    float d = length((f - o) * vec2(1., .5));',
        '    float on = step(.74, r) * (.55 + .45 * sin(t * (5. + r * 9.) + r * 40.));',
        '    s += on * smoothstep(tam, tam * .15, d) / (1. + fk * .5); }',
        '  return s; }',
        'void main() {',
        '  vec2 uv = gl_FragCoord.xy / uRes;',
        '  vec2 p = vec2(uv.x * uRes.x / uRes.y, uv.y);',
        '  float t = uT;',
        '  float dx = abs(uv.x - .5) * 2.;',
        '  float perfil = (uAlto + uLados * smoothstep(uLadosDesde, 1., dx)) * (.78 + .44 * noise(vec2(p.x * 2.2, t * .4))) * uEncendido;',
        '  float lados = smoothstep(0., .4, uv.x) * smoothstep(1., .6, uv.x);',
        '  perfil *= mix(1., .2 + .8 * lados, uBordes);',
        '  float bordes = mix(1., sqrt(lados) * smoothstep(0., .12, uv.y), uBordes) * mix(1., smoothstep(1., .7, uv.y), uTecho);',
        '  float c = llamas(uv.y, p, perfil, t, 0., uEsc, 1.) * bordes;',
        // Las llamas del cartel: lenguas finas que salen de la línea de arriba del marco, por tramos
        '  if (uMarco.y > uMarco.x && uMarcoK > 0.) {',
        '    float yy = uv.y - uMarco.z;',
        '    float dentro = smoothstep(uMarco.x, uMarco.x + .1, uv.x) * smoothstep(uMarco.y, uMarco.y - .1, uv.x);',
        '    float tramos = .25 + .75 * smoothstep(.28, .68, noise(vec2(p.x * 3.2 + 4., t * .22)));',
        '    float altoM = uMarcoAlto * (.5 + .7 * noise(vec2(p.x * 5., t * .6))) * tramos * mix(.15, 1., dentro) * uMarcoK;',
        '    float cm = llamas(max(yy, 0.), vec2(p.x, yy), altoM, t, 7.3, 2.8, .9) * dentro * smoothstep(.002, .02, yy);',
        '    c = max(c, cm); }',
        '  float a = smoothstep(.05, .34, c);',
        '  vec3 col = rampa(c) * a;',
        // Resplandor del fuego sobre la escena, solo cerca de las llamas (arriba sigue el azul noche)
        '  float glow = exp(-uv.y / max(perfil, .01)) * .42 * uBrillo * bordes * smoothstep(perfil * 2.4, perfil * .7, uv.y);',
        '  col += vec3(.9, .22, .02) * glow * (1. - a);',
        '  float ch = chispas(p, t) * uChispas * smoothstep(1.05, .1, uv.y) * uEncendido * bordes;',
        '  col += vec3(1., .62, .2) * ch;',
        '  gl_FragColor = vec4(col, clamp(a + glow * .35 + ch * .5, 0., 1.)); }'
    ].join('\n');

    var fuegos = [];
    function crearInfierno(canvas, o) {
        var gl = null;
        try {
            var attrs = { alpha: true, premultipliedAlpha: true, antialias: false, depth: false, stencil: false, powerPreference: 'low-power' };
            gl = canvas.getContext('webgl', attrs) || canvas.getContext('experimental-webgl', attrs);
        } catch (e) { gl = null; }
        if (!gl) { return null; }
        function compilar(tipo, src) {
            var s = gl.createShader(tipo);
            gl.shaderSource(s, src);
            gl.compileShader(s);
            return gl.getShaderParameter(s, gl.COMPILE_STATUS) ? s : null;
        }
        var vs = compilar(gl.VERTEX_SHADER, VERT), fs = compilar(gl.FRAGMENT_SHADER, FRAG);
        if (!vs || !fs) { return null; }
        var prog = gl.createProgram();
        gl.attachShader(prog, vs); gl.attachShader(prog, fs); gl.linkProgram(prog);
        if (!gl.getProgramParameter(prog, gl.LINK_STATUS)) { return null; }
        gl.useProgram(prog);
        gl.bindBuffer(gl.ARRAY_BUFFER, gl.createBuffer());
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 3, -1, -1, 3]), gl.STATIC_DRAW);
        var loc = gl.getAttribLocation(prog, 'a');
        gl.enableVertexAttribArray(loc);
        gl.vertexAttribPointer(loc, 2, gl.FLOAT, false, 0, 0);
        var U = {};
        ['uRes', 'uT', 'uAlto', 'uLados', 'uLadosDesde', 'uEsc', 'uChispas', 'uBrillo', 'uEncendido', 'uBordes', 'uTecho', 'uMarco', 'uMarcoAlto', 'uMarcoK'].forEach(function(n) { U[n] = gl.getUniformLocation(prog, n); });

        var f = { canvas: canvas, escala: 1, marco: [0, 0, 0], libre: 0, inicio: performance.now(), marcoDesde: 0, visible: true, perdido: false, lentos: 0, cuadros: 0 };
        canvas.addEventListener('webglcontextlost', function(e) { e.preventDefault(); f.perdido = true; if (o.alPerder) { o.alPerder(); } });

        f.medir = function() {
            if (o.fijo) { return; }
            var r = canvas.getBoundingClientRect();
            if (!r.width || !r.height) { return; }
            var dpr = Math.min(window.devicePixelRatio || 1, 2);
            var tope = o.maxAncho || (esCel() ? 440 : 880);
            var k = Math.min(dpr, tope / r.width) * f.escala;
            var w = Math.max(1, Math.round(r.width * k)), h = Math.max(1, Math.round(r.height * k));
            if (canvas.width !== w || canvas.height !== h) { canvas.width = w; canvas.height = h; }
            // Borde de arriba del marco del cartel, en coordenadas del canvas (y desde abajo)
            if (o.marco) {
                var m = o.marco.getBoundingClientRect();
                if (m.width && m.height) {
                    f.marco = [(m.left - r.left) / r.width + 0.012, (m.right - r.left) / r.width - 0.012, 1 - (m.top - r.top + m.height * 0.016) / r.height];
                }
            }
            // Lugar libre debajo de "70% OFF": el fuego del centro no lo tapa
            if (o.tope) {
                var tb = o.tope.getBoundingClientRect();
                if (tb.height) { f.libre = Math.max(0.06, (r.bottom - tb.bottom) / r.height); }
            }
        };

        f.paso = function(ahora) {
            if (f.perdido) { return; }
            var seg = (ahora - f.inicio) / 1000;
            var t = (seg * VEL + (o.desfase || 0)) % 3600;
            // Se prende de a poco: las llamas crecen desde el piso
            var enc = Math.min(1, seg / 1.6);
            enc = 1 - Math.pow(1 - enc, 3);
            // El cartel se prende fuego cuando terminó de dibujarse (y después de la intro)
            var mk = 0;
            if (o.marco) {
                if (!f.marcoDesde && !root.classList.contains('sgns-intro-on')) { f.marcoDesde = ahora + (o.marcoDemora || 1900); }
                if (f.marcoDesde && ahora > f.marcoDesde) { mk = Math.min(1, (ahora - f.marcoDesde) / 1200); }
            }
            var cel = esCel();
            var alto = cel ? o.altoCel : o.alto;
            if (f.libre) { alto = Math.min(alto, f.libre * (o.libreK || 0.55)); }
            gl.viewport(0, 0, canvas.width, canvas.height);
            gl.uniform2f(U.uRes, canvas.width, canvas.height);
            gl.uniform1f(U.uT, t);
            gl.uniform1f(U.uAlto, alto);
            gl.uniform1f(U.uLados, cel ? o.ladosCel : o.lados);
            gl.uniform1f(U.uLadosDesde, cel ? (o.ladosDesdeCel || 0.3) : 0.3);
            gl.uniform1f(U.uEsc, o.esc || 1.25);
            gl.uniform1f(U.uChispas, o.chispas);
            gl.uniform1f(U.uBrillo, o.brillo);
            gl.uniform1f(U.uEncendido, enc);
            gl.uniform1f(U.uBordes, o.bordes ? 1 : 0);
            gl.uniform1f(U.uTecho, o.techo ? 1 : 0);
            gl.uniform3f(U.uMarco, f.marco[0], f.marco[1], f.marco[2]);
            gl.uniform1f(U.uMarcoAlto, o.marco ? (cel ? o.marcoAltoCel : o.marcoAlto) : 0);
            gl.uniform1f(U.uMarcoK, mk);
            gl.clearColor(0, 0, 0, 0);
            gl.clear(gl.COLOR_BUFFER_BIT);
            gl.drawArrays(gl.TRIANGLES, 0, 3);
            if (!o.fijo) { canvas.classList.add('is-on'); }
        };
        f.medir();
        if (!o.suelto) { fuegos.push(f); }
        return f;
    }

    /* Llamas de las tarjetas: un solo fuego en WebGL (una tira ancha, fuera de la página) que se copia en un canvas
       chico arriba de cada tarjeta que está en pantalla, cada una con un tramo distinto de la tira */
    var tira = null, bordes = [], sinGL = false;
    var ioBordes = 'IntersectionObserver' in window ? new IntersectionObserver(function(es) {
        es.forEach(function(e) { bordes.forEach(function(b) { if (b.canvas === e.target) { b.visible = e.isIntersecting; } }); });
    }, { rootMargin: '40px 0px' }) : null;
    function laTira() {
        if (tira || sinGL) { return tira; }
        var c = document.createElement('canvas');
        c.width = 1536; c.height = 64;
        tira = crearInfierno(c, { fijo: true, suelto: true, alto: 0.62, lados: 0, altoCel: 0.62, ladosCel: 0, esc: 0.42, chispas: 0.35, brillo: 0.3, techo: true, desfase: 37 });
        if (!tira) { sinGL = true; root.classList.add('sgns-fuego-sin-gl'); }
        return tira;
    }
    function dibujarBordes(ahora) {
        var hay = false;
        for (var i = 0; i < bordes.length; i++) { if (bordes[i].visible) { hay = true; break; } }
        if (!hay || !tira) { return; }
        tira.paso(ahora);
        var dpr = Math.min(window.devicePixelRatio || 1, 2);
        var tw = tira.canvas.width, th = tira.canvas.height;
        bordes.forEach(function(b) {
            if (!b.visible || !b.canvas.isConnected) { return; }
            var r = b.canvas.getBoundingClientRect();
            if (!r.width || !r.height) { return; }
            var w = Math.round(r.width * dpr), h = Math.round(r.height * dpr);
            if (b.canvas.width !== w || b.canvas.height !== h) { b.canvas.width = w; b.canvas.height = h; }
            var sw = Math.min(tw, Math.round(th * r.width / r.height));
            var sx = b.sx % Math.max(1, tw - sw);
            b.ctx.clearRect(0, 0, w, h);
            b.ctx.drawImage(tira.canvas, sx, 0, sw, th, 0, 0, w, h);
        });
    }

    // Un solo ciclo para todos los fuegos; solo dibuja los que están en pantalla. Si el equipo no llega,
    // baja la resolución del fuego (queda igual, un poco más borroso)
    var anterior = 0;
    function animar(ahora) {
        if (!document.hidden) {
            var dt = anterior ? ahora - anterior : 16;
            fuegos.forEach(function(f) {
                if (!f.visible || (f.tapado && f.tapado())) { return; }
                f.paso(ahora);
                f.cuadros++;
                if (f.cuadros > 20 && dt > 26) { f.lentos++; } else if (f.lentos > 0) { f.lentos--; }
                if (f.lentos > 25 && f.escala > 0.45) { f.escala *= 0.8; f.lentos = 0; f.medir(); }
            });
            dibujarBordes(ahora);
        }
        anterior = ahora;
        requestAnimationFrame(animar);
    }
    var io = 'IntersectionObserver' in window ? new IntersectionObserver(function(es) {
        es.forEach(function(e) { fuegos.forEach(function(f) { if (f.canvas === e.target) { f.visible = e.isIntersecting; } }); });
    }) : null;
    window.addEventListener('resize', function() { fuegos.forEach(function(f) { f.medir(); }); });

    function infierno(host, antesDe, o) {
        if (!host || host.querySelector(':scope > .sgns-fuego-infierno')) { return null; }
        var c = document.createElement('canvas');
        c.className = 'sgns-fuego-infierno';
        c.setAttribute('aria-hidden', 'true');
        host.insertBefore(c, antesDe || null);
        o.alPerder = function() { c.remove(); host.classList.add('sgns-fuego-sin-gl'); };
        var f = crearInfierno(c, o);
        if (!f) { c.remove(); host.classList.add('sgns-fuego-sin-gl'); return null; }
        if (io) { io.observe(c); }
        return f;
    }

    /* ---------- Piezas ---------- */
    function construccion() {
        var pw = document.getElementById('sgns-pw');
        if (!pw) { return; }
        var portada = pw.querySelector('.sgns-cyber-portada');
        // Piso en llamas, costados más altos, el borde de arriba del cartel prendido fuego y chispas por toda la pantalla
        infierno(pw, portada ? portada.nextSibling : null, {
            alto: 0.25, lados: 0.45, altoCel: 0.4, ladosCel: 0.24,
            chispas: 1, brillo: 1,
            marco: portada ? portada.querySelector('.sgns-cyber-portada__marco') : null, marcoAlto: 0.1, marcoAltoCel: 0.1
        });
        var form = pw.querySelector('.sgns-pw__form');
        if (form && !form.querySelector('.sgns-fuego-cuenta')) { form.insertBefore(cartel(), form.firstChild); }
    }

    function portadaDelCyber() {
        var hero = document.querySelector('.sgns-drop-hero');
        if (!hero) { return; }
        var portada = hero.querySelector('.sgns-cyber-portada');
        // Acá el cartel está más abajo que en la construcción: el fuego del centro se queda debajo de "70% OFF"
        // y en el celular solo crecen las puntas de los costados
        var f = infierno(hero, portada ? portada.nextSibling : null, {
            alto: 0.25, lados: 0.45, altoCel: 0.4, ladosCel: 0.12, ladosDesdeCel: 0.55,
            chispas: 1, brillo: 1,
            marco: portada ? portada.querySelector('.sgns-cyber-portada__marco') : null, marcoAlto: 0.1, marcoAltoCel: 0.1,
            tope: portada ? portada.querySelector('.sgns-cyber-portada__oferta') : null, libreK: 0.55
        });
        // Cuando lo que sigue ya tapó la portada (queda fija atrás), el fuego deja de dibujarse
        var siguiente = hero.nextElementSibling;
        if (f && siguiente) { f.tapado = function() { return siguiente.getBoundingClientRect().top <= 0; }; }
        if (!hero.querySelector('.sgns-fuego-cuenta')) { hero.appendChild(cartel()); }
    }

    function botonDelInicio() {
        var b = document.querySelector('.sgns-hero-btn--cyber');
        if (!b || b.classList.contains('sgns-fuego-btn')) { return; }
        b.classList.add('sgns-fuego-btn');
        var chip = document.createElement('span');
        chip.className = 'sgns-fuego-chip';
        chip.innerHTML = LLAMA + '+48 HS';
        b.appendChild(chip);
        chipHome = chip;
        infierno(b, b.firstChild, { alto: 0.78, lados: 0, altoCel: 0.78, ladosCel: 0, esc: 0.75, chispas: 0.6, brillo: 0.35, bordes: true, techo: true, maxAncho: 320 });
        botonHome = b;
    }

    var nTarjeta = 0;
    function tarjetas() {
        var sel = (root.classList.contains('sgns-fuego-cat') ? '.js-product-table .js-item-product, ' : '') + '.js-item-product.sgns-cyber-card';
        document.querySelectorAll(sel).forEach(function(card) {
            if (card.querySelector(':scope > .sgns-dorada:not(.sgns-dorada--latente)')) { return; }
            if (!card.querySelector(':scope > .sgns-fuego-borde') && laTira()) {
                var c = document.createElement('canvas');
                c.className = 'sgns-fuego-borde';
                c.setAttribute('aria-hidden', 'true');
                card.appendChild(c);
                var b = { canvas: c, ctx: c.getContext('2d'), sx: (nTarjeta++ * 389) % 1400, visible: !ioBordes };
                bordes.push(b);
                if (ioBordes) { ioBordes.observe(c); }
            }
        });
        bordes = bordes.filter(function(b) { return b.canvas.isConnected; });
    }

    // Aviso en la franja negra de beneficios (la arma static/js/header-island.js). La franja corre en loop con los
    // textos dos veces: el aviso va al principio de cada mitad y se alarga la vuelta para que no corra más rápido
    function avisoEnLaFranja() {
        var pista = document.querySelector('.sgns-island-bar .sgns-island-pista');
        if (!pista || pista.querySelector('.sgns-fuego-aviso')) { return !!pista; }
        var hijos = Array.prototype.slice.call(pista.children);
        var mitad = Math.floor(hijos.length / 2);
        var antes = pista.scrollWidth;
        [hijos[0], hijos[mitad]].forEach(function(ref) {
            if (!ref) { return; }
            var s = document.createElement('span');
            s.className = 'sgns-fuego-aviso';
            s.innerHTML = LLAMA + 'Cyber extendido · termina en';
            s.appendChild(reloj(false));
            pista.insertBefore(s, ref);
        });
        var despues = pista.scrollWidth;
        var dur = parseFloat(getComputedStyle(pista).animationDuration) || 0;
        if (dur && antes) { pista.style.animationDuration = (dur * despues / antes).toFixed(2) + 's'; }
        return true;
    }

    function iniciar() {
        var body = document.body;
        if (!document.getElementById('sgns-fuego-defs')) { body.insertAdjacentHTML('afterbegin', DEFS); }
        if (body.classList.contains('template-password')) {
            construccion();
        } else {
            if (/cyber/i.test(location.pathname) && body.classList.contains('sgns-drop-cat')) {
                root.classList.add('sgns-fuego-cat');
                portadaDelCyber();
            }
            botonDelInicio();
            tarjetas();
            // Tarjetas que llegan después ("cargar más", filtros, sliders) y la franja, que se arma más tarde
            var franjaLista = avisoEnLaFranja();
            var pendiente = false;
            new MutationObserver(function() {
                if (pendiente) { return; }
                pendiente = true;
                requestAnimationFrame(function() {
                    pendiente = false;
                    tarjetas();
                    if (!franjaLista) { franjaLista = avisoEnLaFranja(); }
                });
            }).observe(body, { childList: true, subtree: true });
        }
        tick();
        setInterval(tick, 1000);
        requestAnimationFrame(animar);
    }
    if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', iniciar); } else { iniciar(); }
})();
