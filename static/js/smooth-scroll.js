/* SMOOTH SCROLL (Lenis) — scroll suave y pesado en toda la tienda.
   Funciona con rueda del mouse, trackpad y teclado (flechas, PageUp/Down,
   Espacio, Inicio/Fin). En celulares y tablets también pasa por Lenis
   (syncTouch), para que el scroll tenga un tope de velocidad.
   La librería se carga desde static/js/lenis.min.js (sin CDN externo). */
(function() {
    'use strict';

    if (window.__sgnsSmoothScroll) { return; } // evita doble inicialización
    window.__sgnsSmoothScroll = true;

    // También en celulares y tablets (syncTouch): el gesto del dedo pasa por Lenis
    var isTouch = window.matchMedia('(pointer: coarse)').matches;

    // Contenedores con scroll propio (carrito, modales, menú): ahí no interviene
    var PREVENT = '[data-lenis-prevent], .modal, .js-modal, .js-modal-container, .fullscreen-modal,' +
        ' .js-cart-sidebar, .js-ajax-cart-container, #modal-cart, #nav-hamburger, #nav-search,' +
        ' .ruleta-container, .probador-container, .js-side-menu';

    function inPrevented(node) {
        return !!(node && node.closest && node.closest(PREVENT));
    }

    // ¿Hay un modal/carrito abierto? Entonces el scroll de fondo queda quieto.
    // Ojo: varios modales quedan en el DOM con tamaño pero ocultos con
    // visibility/opacity (el del probador, por ejemplo), así que se revisan las tres.
    function overlayOpen() {
        var els = document.querySelectorAll(PREVENT);
        for (var i = 0; i < els.length; i++) {
            var el = els[i];
            if (el.offsetParent === null) { continue; }
            var r = el.getBoundingClientRect();
            if (r.width <= 0 || r.height <= 0) { continue; }
            var c = window.getComputedStyle(el);
            if (c.visibility === 'hidden' || c.display === 'none' || parseFloat(c.opacity) < 0.05) { continue; }
            return true;
        }
        return false;
    }

    function init() {
        if (typeof window.Lenis === 'undefined') { return; }

        var gesto = null; // dirección del gesto sobre un carrusel: 'h' (de costado) o 'v'
        var lenis = new window.Lenis({
            // lerp bajo = más inercia: la sensación "pesada" que se busca
            lerp: 0.075,
            wheelMultiplier: 0.9,
            smoothWheel: true,
            // Celular: el dedo también pasa por Lenis, con sus valores de fábrica (sin topes
            // ni multiplicadores propios)
            syncTouch: isTouch,
            autoRaf: true,      // Lenis corre su propio requestAnimationFrame
            overscroll: true,
            prevent: inPrevented,
            // Tope de velocidad: el destino del scroll nunca se adelanta más de TOPE px a lo
            // que se ve en pantalla. Con el lerp de arriba, la velocidad máxima queda en
            // unos 4,5 × TOPE px por segundo, por más rápido que se gire la rueda.
            virtualScroll: function(d) {
                if (!lenis) { return; }
                // Celular: Lenis tal cual, sin ajustes de velocidad. Lo único: en los carruseles
                // (Novedades y Ofertas), si el gesto arranca de costado lo mueve el carrusel con
                // su scroll nativo; si arranca vertical, es scroll de la página con Lenis
                if (isTouch) {
                    var tipo = d.event && d.event.type;
                    var objetivo = d.event && d.event.target && d.event.target.closest ? d.event.target : null;
                    if (tipo === 'touchstart') { gesto = null; }
                    if (objetivo && objetivo.closest('[data-sgns-carrusel]')) {
                        if (tipo === 'touchmove' && gesto === null) {
                            gesto = Math.abs(d.deltaX) > Math.abs(d.deltaY) ? 'h' : 'v';
                        }
                        if (gesto === 'h') { return false; }
                    }
                    // Página del Drop:
                    // - Zoom del nombre: el dedo mueve la página un 7% menos; al soltar, el envión llega
                    //   más lejos (exponente 1,9 en vez de 1,7 de fábrica) pero frena despacio (0,044 en
                    //   vez de 0,075). Casi no se usa: el zoom se reproduce solo (drop-hero.tpl).
                    // - Mensajes: el scroll avanza más y va un poco más rápido. El dedo mueve la página
                    //   un 10% más y el envión llega más lejos (exponente 1,97) con el mismo frenado
                    //   (0,044), así recorre más en el mismo tiempo.
                    // - Resto de la página: la página sigue al dedo 1 a 1 (moverla menos que el dedo
                    //   se sentía a los tirones) y, al soltar, el envión es más largo (exponente 1,85)
                    //   y frena más suave (0,05): con el de fábrica se frenaba de golpe en el celular.
                    // Fuera del Drop, Lenis de fábrica (exponente 1,7 y frenado 0,075).
                    var enDropPag = document.body.classList.contains('sgns-drop-cat');
                    var enZoomM = false, enMsjs = false;
                    if (enDropPag) {
                        var fin = document.querySelector('.sgns-drop-cabecera');
                        if (fin && fin.getBoundingClientRect().top > window.innerHeight * 0.5) {
                            var zm = document.querySelector('.sgns-drop-nombre');
                            var ds = document.querySelector('.sgns-drop-dice');
                            var rzm = zm && zm.getBoundingClientRect();
                            // Los mensajes empiezan cuando su sección llega arriba (el zoom todavía
                            // la cubre un poco más, por eso se mira primero)
                            enMsjs = !!(ds && ds.getBoundingClientRect().top <= 0);
                            enZoomM = !enMsjs && !!(rzm && rzm.top < window.innerHeight && rzm.bottom > 0);
                        }
                    }
                    var restoDrop = enDropPag && !enZoomM && !enMsjs;
                    if (tipo === 'touchmove') {
                        if (enZoomM) { d.deltaY *= 0.93; }
                        if (enMsjs) { d.deltaY *= 1.1; }
                    }
                    lenis.options.touchInertiaExponent = enMsjs ? 1.97 : (enZoomM ? 1.9 : (restoDrop ? 1.85 : 1.7));
                    lenis.options.syncTouchLerp = (enMsjs || enZoomM) ? 0.044 : (restoDrop ? 0.05 : 0.075);
                    return;
                }
                // En las secciones del Drop (hasta donde empiezan los productos) el tope es más bajo,
                // porque sus efectos van atados al scroll; en el resto de la web es más alto
                var finDrop = document.querySelector('.sgns-drop-cabecera');
                var enDrop = finDrop && finDrop.getBoundingClientRect().top > window.innerHeight * 0.5;
                var tope = enDrop ? Math.min(window.innerHeight * 0.5, 500) : Math.min(window.innerHeight * 0.8, 800);
                // Pasado el zoom del nombre (la sección de mensajes ya llegó arriba) y hasta los
                // productos, el scroll va apenas más rápido: la rueda en la computadora, y el dedo
                // y su envión en el celular
                var dice = enDrop && document.querySelector('.sgns-drop-dice');
                var trasZoom = !!(dice && dice.getBoundingClientRect().top <= 0);
                if (trasZoom && !isTouch) {
                    d.deltaY *= 3.72;
                    tope = Math.min(window.innerHeight * 0.8, 800);
                }
                // En el zoom del nombre: cada gesto avanza un poco más (velocidad promedio más alta),
                // pero con tope, así un ruedazo o un deslizón fuerte no la pasa de largo
                var zoomSec = enDrop && !trasZoom && document.querySelector('.sgns-drop-nombre');
                var rz = zoomSec && zoomSec.getBoundingClientRect();
                var enZoom = !!(rz && rz.top < window.innerHeight && rz.bottom > 0);
                if (enZoom && !isTouch) {
                    d.deltaY *= 4;
                    // Tope más bajo que en el resto del Drop (0,5): cada giro avanza más, pero con
                    // giros fuertes la velocidad máxima queda por debajo de la de antes
                    tope = Math.min(window.innerHeight * 0.62, 620);
                }
                // Zoom y mensajes: en la computadora más pesado (la página tarda más en llegar a
                // donde va); para compensar, cada gesto avanza más y el tope es algo más alto
                lenis.options.lerp = enZoom ? 0.066 : (trasZoom ? 0.086 : 0.075);
                var adelanto = lenis.targetScroll - lenis.animatedScroll;
                var nuevo = adelanto + d.deltaY;
                if (nuevo > tope) { d.deltaY = Math.max(tope - adelanto, 0); }
                else if (nuevo < -tope) { d.deltaY = Math.min(-tope - adelanto, 0); }
            },
        });

        window.lenis = lenis; // por si otro script lo necesita

        // Carruseles de scroll lateral (Novedades y Ofertas): cada uno con su propio
        // Lenis horizontal. Solo toma los gestos laterales; el vertical sigue siendo
        // de la página. Con Lenis manda él, así que el "snap" del CSS se apaga.
        window.__sgnsCarruseles = [];
        document.querySelectorAll('.novedades-grid-premium').forEach(function(el) {
            // Con el dedo el carrusel usa su scroll nativo (con inercia propia y "snap"):
            // Lenis ahí no lo movía bien. Los gestos de costado quedan para el carrusel y los
            // verticales para la página (ver "Carruseles" en virtualScroll).
            if (isTouch) {
                el.setAttribute('data-sgns-carrusel', '');
                return;
            }
            var l = new window.Lenis({
                wrapper: el,
                content: el,
                orientation: 'horizontal',
                gestureOrientation: 'horizontal',
                lerp: 0.12,             // menos pesado que la página (0,075)
                wheelMultiplier: 2.2,   // el gesto lateral recorre más camino
                smoothWheel: true,
                syncTouch: isTouch,
                syncTouchLerp: 0.09,
                autoRaf: true,
                overscroll: false,
            });
            el.classList.add('sgns-lenis-h');
            window.__sgnsCarruseles.push(l);
        });

        // Intro cinematográfica: la página no se mueve hasta que termina.
        // (overflow:hidden no alcanza: Lenis mueve el scroll por código.)
        var root = document.documentElement;
        function introActiva() { return root.classList.contains('sgns-intro-lock'); }
        function sincronizarIntro() {
            if (introActiva()) { lenis.stop(); }
            else if (!overlayOpen()) { lenis.start(); }
        }
        sincronizarIntro();
        if (window.MutationObserver) {
            new MutationObserver(sincronizarIntro).observe(root, { attributes: true, attributeFilter: ['class'] });
        }

        // --- Teclado -------------------------------------------------------
        // Lenis no maneja teclas: sin esto el navegador salta de golpe y pelea
        // con la animación. Se traduce cada tecla a un scrollTo de Lenis.
        var EDITABLE = 'input, textarea, select, [contenteditable=""], [contenteditable="true"]';

        document.addEventListener('keydown', function(e) {
            if (e.defaultPrevented || e.ctrlKey || e.metaKey || e.altKey) { return; }
            var t = e.target;
            if (t && t.closest && (t.closest(EDITABLE) || inPrevented(t))) { return; }
            if (wasOpen) { return; } // hay un modal abierto: lo maneja el navegador
            if (introActiva()) { return; } // la intro bloquea el scroll

            var page = window.innerHeight * 0.9;
            var step = 120;
            var to = null;
            var opts = { duration: 0.9 };

            switch (e.key) {
                case 'ArrowDown': to = lenis.targetScroll + step; opts.duration = 0.6; break;
                case 'ArrowUp': to = lenis.targetScroll - step; opts.duration = 0.6; break;
                case 'PageDown': to = lenis.targetScroll + page; break;
                case 'PageUp': to = lenis.targetScroll - page; break;
                case ' ': // Espacio: baja; con Shift, sube
                case 'Spacebar':
                    to = lenis.targetScroll + (e.shiftKey ? -page : page);
                    break;
                case 'Home': to = 0; opts.duration = 1.4; break;
                case 'End': to = lenis.limit; opts.duration = 1.4; break;
                default: return;
            }

            e.preventDefault();
            lenis.scrollTo(to, opts);
        }, { passive: false });

        // --- Links internos (#seccion) --------------------------------------
        document.addEventListener('click', function(e) {
            var a = e.target && e.target.closest ? e.target.closest('a[href^="#"]') : null;
            if (!a) { return; }
            var id = a.getAttribute('href');
            if (!id || id === '#' || a.hasAttribute('data-toggle')) { return; } // '#' y modales: no tocar
            var target = document.querySelector(id);
            if (!target) { return; }
            e.preventDefault();
            lenis.scrollTo(target, { offset: -90, duration: 1.2 });
        });

        // --- Modales y carrito ----------------------------------------------
        // Mientras hay uno abierto, el fondo no se mueve.
        // Se revisa solo cuando el DOM cambia (y nunca durante el scroll):
        // hacerlo con un temporizador fijo recalculaba estilos y trababa el scroll.
        var wasOpen = false;
        var checkTimer = null;

        function check() {
            checkTimer = null;
            var open = overlayOpen();
            if (open === wasOpen) { return; }
            wasOpen = open;
            if (open) { lenis.stop(); } else { lenis.start(); }
        }

        function scheduleCheck() {
            if (checkTimer) { return; }
            // requestIdleCallback: corre en un hueco libre, no en pleno scroll
            checkTimer = (window.requestIdleCallback || window.setTimeout)(check, { timeout: 400 });
        }

        if (window.MutationObserver) {
            new MutationObserver(scheduleCheck).observe(document.body, {
                attributes: true,
                attributeFilter: ['class', 'style'],
                subtree: true,
            });
        }
        document.addEventListener('click', scheduleCheck, true);
        document.addEventListener('keyup', function(e) { if (e.key === 'Escape') { scheduleCheck(); } });

        // Lenis ya vigila solo los cambios de alto de la página (autoResize),
        // así que no se agrega otro observador encima.

    }

    function load() {
        // En celulares y tablets también corre Lenis (syncTouch), para poder ponerle un tope
        // de velocidad al scroll. Para volver al scroll nativo: if (isTouch) { return; }
        if (typeof window.Lenis !== 'undefined') { return init(); }
        var s = document.createElement('script');
        // La ruta la deja layout.tpl en esta variable (static_url del theme)
        s.src = window.__sgnsLenisUrl || '/js/lenis.min.js';
        s.async = true;
        s.onload = init;
        document.head.appendChild(s);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', load);
    } else {
        load();
    }
})();

/* SLIDERS (Swiper) CON TRACKPAD Y ARRASTRE
   Los sliders de la tienda (productos similares, etc.) solo se movían con las
   flechas: la versión de Swiper que carga Tiendanube no trae el módulo de rueda.
   Deslizar de lado con dos dedos en el trackpad, o Shift + rueda del mouse,
   pasa las slides; y con el mouse se pueden arrastrar (cursor de "manito"). */
(function() {
    'use strict';

    if (window.__sgnsSwiperWheel) { return; }
    window.__sgnsSwiperWheel = true;

    var acumulado = 0;
    var bloqueado = false;

    document.addEventListener('wheel', function(e) {
        var el = e.target && e.target.closest ? e.target.closest('.swiper-container, .swiper') : null;
        var sw = el && el.swiper;
        if (!sw) { return; }

        // Gesto lateral (trackpad) o Shift + rueda; el scroll vertical sigue normal
        var dx = Math.abs(e.deltaX) > Math.abs(e.deltaY) ? e.deltaX : (e.shiftKey ? e.deltaY : 0);
        if (!dx) { return; }

        // Que no lo tome el scroll suave de la página
        e.preventDefault();
        e.stopPropagation();

        if (bloqueado) { return; }
        acumulado += dx;
        if (Math.abs(acumulado) < 40) { return; }

        if (acumulado > 0) { sw.slideNext(); } else { sw.slidePrev(); }
        acumulado = 0;
        bloqueado = true;
        setTimeout(function() { bloqueado = false; }, (sw.params.speed || 300) + 150);
    }, { capture: true, passive: false });

    // Arrastre con el mouse: se activa el cursor de "manito" en cada slider
    function manito() {
        document.querySelectorAll('.swiper-container, .swiper').forEach(function(el) {
            var sw = el.swiper;
            if (!sw || sw.__sgnsGrab) { return; }
            sw.__sgnsGrab = true;
            sw.params.simulateTouch = true;
            sw.params.grabCursor = true;
            if (sw.setGrabCursor) { sw.setGrabCursor(); }
        });
    }

    // Los sliders se crean después de cargar: se revisa unas veces al principio
    var vueltas = 0;
    var t = setInterval(function() { manito(); if (++vueltas > 10) { clearInterval(t); } }, 800);
})();

/* FOTOS NÍTIDAS EN LAS CARDS DE PRODUCTO
   La card es vertical y la foto se recorta para llenarla (object-fit: cover). La tienda (lazysizes,
   con data-sizes="auto") elige el tamaño de la foto según el ANCHO de la card, pero una foto
   horizontal recortada necesita mucho más ancho para llenar el alto: bajaba una versión chica y se
   veía borrosa. Acá se corrige el ancho que usa lazysizes para elegir: el necesario para cubrir
   el ALTO de la card con la proporción real de la foto (más el zoom del hover). */
(function() {
    'use strict';

    if (window.__sgnsFotoNitida) { return; }
    window.__sgnsFotoNitida = true;

    var ZOOM = 1.06;

    function caja(img) { return img.closest && img.closest('.item-image, .nov-card__media'); }

    // Proporción ancho/alto de la foto: la real si ya cargó; si no, para la segunda foto se
    // supone horizontal (3:2), que es el peor caso; la primera suele ser vertical
    function proporcion(img) {
        if (img.dataset.sgnsProp) { return parseFloat(img.dataset.sgnsProp); }
        return /item-image-secondary/.test(img.className) ? 1.5 : 0;
    }

    function anchoNecesario(img, anchoBase) {
        var c = caja(img);
        if (!c || !c.offsetHeight) { return anchoBase; }
        var prop = proporcion(img);
        return Math.ceil(Math.max(anchoBase, c.offsetWidth, c.offsetHeight * prop) * ZOOM);
    }

    // lazysizes avisa antes de calcular el 'sizes': se le corrige el ancho
    document.addEventListener('lazybeforesizes', function(e) {
        var img = e.target;
        if (!img || img.tagName !== 'IMG' || !caja(img) || !e.detail) { return; }
        e.detail.width = anchoNecesario(img, e.detail.width || 0);
    });

    // Al cargar se guarda la proporción real y, si la versión bajada no alcanza, se recalcula
    document.addEventListener('load', function(e) {
        var img = e.target;
        if (!img || img.tagName !== 'IMG' || !caja(img) || !img.naturalWidth || img.naturalWidth < 20) { return; }
        var prop = img.naturalWidth / img.naturalHeight;
        if (img.dataset.sgnsProp && Math.abs(parseFloat(img.dataset.sgnsProp) - prop) < 0.02) { return; }
        img.dataset.sgnsProp = prop.toFixed(3);
        var necesario = anchoNecesario(img, 0);
        if (img.getAttribute('data-sizes') === 'auto' && window.lazySizes && lazySizes.autoSizer) {
            lazySizes.autoSizer.updateElem(img);
        } else if (img.getAttribute('srcset')) {
            img.setAttribute('sizes', necesario + 'px');
        }
    }, true);
})();
