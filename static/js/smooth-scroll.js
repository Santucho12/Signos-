/* SMOOTH SCROLL (Lenis) — scroll suave y pesado en toda la tienda.
   Funciona con rueda del mouse, trackpad y teclado (flechas, PageUp/Down,
   Espacio, Inicio/Fin). En celulares y tablets se deja el scroll nativo:
   el del sistema ya es suave y así no se pierde rendimiento.
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

        var lenis = new window.Lenis({
            // lerp bajo = más inercia: la sensación "pesada" que se busca
            lerp: 0.075,
            wheelMultiplier: 0.9,
            smoothWheel: true,
            syncTouch: isTouch, // en touch, el dedo también pasa por Lenis
            syncTouchLerp: 0.09,
            touchMultiplier: 1,
            autoRaf: true,      // Lenis corre su propio requestAnimationFrame
            overscroll: true,
            prevent: inPrevented,
        });

        window.lenis = lenis; // por si otro script lo necesita

        // Carruseles de scroll lateral (Novedades y Ofertas): cada uno con su propio
        // Lenis horizontal. Solo toma los gestos laterales; el vertical sigue siendo
        // de la página. Con Lenis manda él, así que el "snap" del CSS se apaga.
        window.__sgnsCarruseles = [];
        document.querySelectorAll('.novedades-grid-premium').forEach(function(el) {
            // Con el dedo el carrusel usa su scroll nativo (con inercia propia y "snap"):
            // Lenis ahí no lo movía bien. Se le avisa a Lenis de la página que no se meta.
            if (isTouch) {
                el.setAttribute('data-lenis-prevent-touch', '');
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
        // En dispositivos táctiles (móviles y tablets), dejamos el scroll 100% nativo
        // acelerado por hardware a 60/120Hz sin intercepciones de JavaScript.
        if (isTouch) { return; }
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
