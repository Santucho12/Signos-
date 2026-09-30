/* CARTEL DE WHATSAPP (solo computadora)
   Muestra, cada tanto, un globo con forma de chat arriba del botón flotante.
   Ciclo: aparece a los 4s, queda 15s, descansa 15s y vuelve. Si el visitante
   lo cierra a mano, no vuelve a aparecer hasta que recargue la página.
   El mensaje que se envía incluye desde qué página escribe. */
(function() {
    'use strict';

    if (window.__sgnsWaBubble) { return; }
    if (window.location.pathname.indexOf('registroevento') !== -1) { return; }
    window.__sgnsWaBubble = true;

    // El logo vive al lado de este script, en static/images: sirve igual en la tienda y en el preview
    var scriptSrc = (document.currentScript && document.currentScript.src) || '';
    var LOGO = /js\/whatsapp-bubble\.js/.test(scriptSrc)
        ? scriptSrc.split('?')[0].replace(/js\/whatsapp-bubble\.js$/, 'images/signos-monograma-avatar.png')
        : '';

    // Solo en computadora: en el celular el botón ya ocupa lo suyo
    if (window.matchMedia('(pointer: coarse)').matches || window.innerWidth < 1025) { return; }

    var TEXTOS = {
        nombre: 'Signos Indumentaria',
        estado: 'En línea',
        titulo: '¡Hola! 👋',
        respuesta: 'Consultar',
        input: 'Escribí un mensaje',
        cerrar: 'Cerrar mensaje',
    };

    // El texto cambia según dónde está el visitante
    function texto() {
        var b = document.body.classList;
        if (b.contains('template-product')) { return '¿Querés saber si hay stock de esta prenda o qué talle pedir?'; }
        if (b.contains('template-cart')) { return '¿Te ayudamos a terminar tu pedido?'; }
        return 'Envíos a todo el país y 20% off pagando por transferencia.';
    }

    // Mensaje inicial según la página
    function mensaje() {
        var base = '¡Hola! Te escribo desde la web de Signos. ';
        var b = document.body.classList;
        if (b.contains('template-product')) {
            var t = document.querySelector('h1');
            return base + 'Quería consultar por: ' + (t ? t.textContent.trim() : 'un producto') + ' (' + location.href + ')';
        }
        if (b.contains('template-category')) { return base + 'Quería consultar por los productos de esta categoría.'; }
        if (b.contains('template-cart')) { return base + 'Tengo una consulta con mi pedido.'; }
        return base + 'Quería hacerles una consulta.';
    }

    function hora() {
        return new Date().toLocaleTimeString('es-AR', { hour: '2-digit', minute: '2-digit', hour12: false });
    }

    function init() {
        var btn = document.querySelector('.btn-whatsapp, .js-btn-whatsapp, a[href*="wa.me"]');
        if (!btn) { return; }

        var base = (btn.getAttribute('href') || '').split('?')[0];
        if (!base) { return; }
        var href = base + '?text=' + encodeURIComponent(mensaje());
        var h = hora();

        var wrap = document.createElement('div');
        wrap.className = 'sgns-wa-bubble';
        wrap.innerHTML =
            '<div class="sgns-wa-head">' +
                '<span class="sgns-wa-avatar">' + (LOGO
                    ? '<img class="sgns-wa-logo" src="' + LOGO + '" alt="" aria-hidden="true">'
                    : '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.174.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51l-.57-.01c-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.71.306 1.263.489 1.694.625.712.227 1.36.195 1.872.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347"></path></svg>') + '</span>' +
                '<span class="sgns-wa-id">' +
                    '<span class="sgns-wa-name"></span>' +
                    '<span class="sgns-wa-status"><i></i><span class="sgns-wa-status-text"></span></span>' +
                '</span>' +
                '<button type="button" class="sgns-wa-close"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M18 6 6 18"></path><path d="m6 6 12 12"></path></svg></button>' +
            '</div>' +
            '<a class="sgns-wa-body" target="_blank" rel="noopener">' +
                '<span class="sgns-wa-msg sgns-wa-in">' +
                    '<b class="sgns-wa-title"></b>' +
                    '<span class="sgns-wa-text"></span>' +
                    '<span class="sgns-wa-time"></span>' +
                '</span>' +
                '<span class="sgns-wa-msg sgns-wa-out">' +
                    '<span class="sgns-wa-cta"></span>' +
                    '<span class="sgns-wa-time">' +
                        '<span class="sgns-wa-hour"></span>' +
                        '<svg viewBox="0 0 24 24" fill="none" stroke="#34B7F1" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m2 13 3.5 3.5L13 9"></path><path d="m11 16 1 1 7.5-7.5"></path></svg>' +
                    '</span>' +
                '</span>' +
                '<span class="sgns-wa-input">' +
                    '<span class="sgns-wa-placeholder"></span>' +
                    '<span class="sgns-wa-send"><svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M3.4 20.4 21 12 3.4 3.6 3.4 10l12.6 2-12.6 2z"></path></svg></span>' +
                '</span>' +
            '</a>';

        // Los textos se escriben como texto, no como HTML
        wrap.querySelector('.sgns-wa-name').textContent = TEXTOS.nombre;
        wrap.querySelector('.sgns-wa-status-text').textContent = TEXTOS.estado;
        wrap.querySelector('.sgns-wa-title').textContent = TEXTOS.titulo;
        wrap.querySelector('.sgns-wa-text').textContent = texto();
        wrap.querySelector('.sgns-wa-cta').textContent = TEXTOS.respuesta;
        wrap.querySelector('.sgns-wa-placeholder').textContent = TEXTOS.input;
        wrap.querySelector('.sgns-wa-in .sgns-wa-time').textContent = h;
        wrap.querySelector('.sgns-wa-hour').textContent = h;
        // La regla global del theme fuerza mayúsculas con !important y le gana a
        // cualquier hoja de estilos: en un chat queda mal, así que se pisa acá.
        wrap.querySelectorAll('.sgns-wa-title, .sgns-wa-text, .sgns-wa-placeholder, .sgns-wa-time, .sgns-wa-status-text')
            .forEach(function(el) { el.style.setProperty('text-transform', 'none', 'important'); });

        var close = wrap.querySelector('.sgns-wa-close');
        close.setAttribute('aria-label', TEXTOS.cerrar);
        wrap.querySelector('.sgns-wa-body').setAttribute('href', href);

        document.body.appendChild(wrap);

        var timers = [];
        var cerrado = false;

        function abrir() {
            if (cerrado) { return; }
            var t = hora();
            wrap.querySelector('.sgns-wa-in .sgns-wa-time').textContent = t;
            wrap.querySelector('.sgns-wa-hour').textContent = t;
            wrap.classList.add('is-open');
            timers.push(setTimeout(cerrar, 15000));
        }

        function cerrar() {
            if (cerrado) { return; }
            wrap.classList.remove('is-open');
            timers.push(setTimeout(abrir, 15000));
        }

        // Cierre manual: no vuelve a aparecer en esta visita
        close.addEventListener('click', function() {
            cerrado = true;
            wrap.classList.remove('is-open');
            timers.forEach(clearTimeout);
        });

        wrap.querySelector('.sgns-wa-body').addEventListener('click', function() {
            cerrado = true;
            wrap.classList.remove('is-open');
        });

        timers.push(setTimeout(abrir, 4000));
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
