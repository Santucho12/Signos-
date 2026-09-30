/* HEADER "ISLA" AL SCROLLEAR
   Arriba de todo el header queda como siempre. Al bajar más de 50px se convierte
   en una píldora flotante de vidrio (logo · menú · íconos en una sola fila) y
   aparece arriba una barra negra con los beneficios. Al volver arriba, vuelve al
   header normal. Los estilos están en style-redesign.scss (html.sgns-island). */
(function() {
    'use strict';

    if (window.__sgnsIsland) { return; }
    if (window.location.pathname.indexOf('registroevento') !== -1) { return; }
    window.__sgnsIsland = true;

    var UMBRAL = 0; // la barra arranca con la estética de isla, sin esperar el scroll
    var BENEFICIOS = ['20% OFF transferencia', 'Envíos gratis (+80K)', '3 y 6 cuotas sin interés'];

    // El logo vive al lado de este script, en static/images (igual en la tienda y en el preview)
    var scriptSrc = (document.currentScript && document.currentScript.src) || '';
    var LOGO = /js\/header-island\.js/.test(scriptSrc)
        ? scriptSrc.split('?')[0].replace(/js\/header-island\.js$/, 'images/logo%20final%20monograma_Mesa%20de%20trabajo%201.png')
        : '';

    function init() {
        var header = document.querySelector('.js-head-main, .head-main');
        if (!header) { return; }
        var root = document.documentElement;
        var esHome = document.body.classList.contains('template-home');

        // Logo de la píldora: se agrega al lugar del logo del header
        var slot = header.querySelector('.logo-img-container') || header.querySelector('.logo-center');
        if (slot && LOGO && !header.querySelector('.sgns-island-logo')) {
            var a = document.createElement('a');
            a.className = 'sgns-island-logo';
            a.href = '/';
            a.setAttribute('aria-label', 'Signos · Inicio');
            var img = document.createElement('img');
            img.src = LOGO;
            img.alt = '';
            a.appendChild(img);
            slot.appendChild(a);
        }

        // Buscador con forma de pastilla, a la izquierda (como en la referencia).
        // Al tocarlo se abre el buscador que ya trae la tienda.
        var botonBuscar = header.querySelector('.js-search-button');
        if (botonBuscar && !header.querySelector('.sgns-nav-buscar')) {
            var pill = document.createElement('button');
            pill.type = 'button';
            pill.className = 'sgns-nav-buscar';
            pill.innerHTML = '<span>Buscar</span>'
                + '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"></circle><path d="m20 20-3.5-3.5"></path></svg>';
            pill.addEventListener('click', function() { botonBuscar.click(); });
            var fila = header.querySelector('.container-fluid > .row');
            if (fila) { fila.appendChild(pill); }
        }

        // Franja de beneficios de arriba: se mueve de costado, así que los textos
        // van dos veces para que el loop no corte
        var bar = document.createElement('div');
        bar.className = 'sgns-island-bar';
        bar.setAttribute('aria-hidden', 'true');
        var pista = document.createElement('div');
        pista.className = 'sgns-island-pista';
        for (var vuelta = 0; vuelta < 2; vuelta++) {
            BENEFICIOS.concat(BENEFICIOS).forEach(function(txt) {
                var s = document.createElement('span');
                s.textContent = txt;
                pista.appendChild(s);
            });
        }
        bar.appendChild(pista);
        document.body.appendChild(bar);

        // Fuera del home el header ocupa lugar en la página: al volverse flotante
        // se deja un espaciador del mismo alto para que el contenido no salte.
        var spacer = null;
        if (!esHome) {
            spacer = document.createElement('div');
            spacer.className = 'sgns-island-spacer';
            header.parentNode.insertBefore(spacer, header.nextSibling);
        }

        var activo = false;
        var bajando = null;
        function actualizar() {
            var on = true; // la barra fija y la franja de promos siempre están
            if (on !== activo) {
                if (on && spacer) { spacer.style.height = header.offsetHeight + 'px'; }
                activo = on;
                root.classList.toggle('sgns-island', on);
            }
            // La barra se encoge en píldora recién al pasar el 40% del hero
            // (fuera del home, apenas se scrollea)
            var y = window.pageYOffset || document.documentElement.scrollTop || 0;
            var hero = document.querySelector('.redesign-hero');
            var esMobile = window.innerWidth <= 767;
            var corte = esMobile ? 15 : (hero ? hero.offsetHeight * 0.4 : 50);
            var scroll = y > corte;
            if (scroll !== bajando) {
                bajando = scroll;
                root.classList.toggle('sgns-island-scrolled', scroll);
            }

            // La franja de promos se va poniendo negra de a poco (0 a 1 en 320px)
            root.style.setProperty('--sgns-scroll', Math.min(y / 320, 1).toFixed(3));
        }

        window.addEventListener('scroll', actualizar, { passive: true });

    // Alternar desplegable del menú hamburguesa (abrir / cerrar al clickear de nuevo)
    document.addEventListener('click', function(e) {
        var toggle = e.target.closest('.js-toggle-menu-panel');
        if (!toggle) return;
        var panel = toggle.nextElementSibling;
        if (!panel || !panel.classList.contains('js-menu-panel')) return;
        
        e.preventDefault();
        e.stopPropagation();
        
        if (panel.classList.contains('nav-list-panel-show')) {
            panel.classList.remove('nav-list-panel-show');
            setTimeout(function() {
                panel.style.display = 'none';
            }, 350);
        } else {
            panel.style.display = 'block';
            // Forzar reflow para animación CSS
            void panel.offsetHeight;
            panel.classList.add('nav-list-panel-show');
        }
    }, true);

        actualizar();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();

