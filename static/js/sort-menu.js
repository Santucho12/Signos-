/* Menú de "Ordenar" propio en productos, categorías y búsqueda.
   Reemplaza al select nativo (queda oculto en la página como respaldo):
   - En la barra de la grilla: botón "Ordenar: Novedades" que abre una tarjeta.
   - Dentro del modal de filtros (mobile): la lista va abierta, sin botón.
   Ordenar y filtrar no recargan la página: se pide el resultado por detrás y se
   cambian en el lugar la barra, los filtros y la grilla (la dirección no cambia).
   Si el pedido falla, se navega como antes.
   También marca en el modal la categoría en la que estás. */
(function() {
    'use strict';

    var ICONOS = {
        star: '<path d="M12 3.5l2.6 5.3 5.9.9-4.3 4.1 1 5.8-5.2-2.7-5.2 2.7 1-5.8-4.3-4.1 5.9-.9z"/>',
        up: '<path d="M12 19V5M6 11l6-6 6 6"/>',
        down: '<path d="M12 5v14M6 13l6 6 6-6"/>',
        az: '<path d="M4 7h16M4 12h10M4 17h6"/>',
        pin: '<path d="M12 21s-6-5.3-6-10a6 6 0 0112 0c0 4.7-6 10-6 10z"/><circle cx="12" cy="11" r="2"/>'
    };

    // Orden en que se muestran, con nombre corto. "Más viejo" y "Destacado"
    // solo aparecen si son el orden actual.
    var OPCIONES = [
        { v: 'created-descending', t: 'Novedades', i: 'star' },
        { v: 'best-selling', t: 'Más vendidos', i: 'up' },
        { v: 'price-ascending', t: 'Menor precio', i: 'down' },
        { v: 'price-descending', t: 'Mayor precio', i: 'up' },
        { v: 'alpha-ascending', t: 'A – Z', i: 'az' },
        { v: 'alpha-descending', t: 'Z – A', i: 'az' },
        { v: 'created-ascending', t: 'Más viejo', i: 'down', solo: true },
        { v: 'user', t: 'Destacado', i: 'pin', solo: true }
    ];

    function icono(nombre) {
        return '<svg class="sgns-sort__icon" viewBox="0 0 24 24" aria-hidden="true">' + ICONOS[nombre] + '</svg>';
    }

    // Dirección "virtual": el orden y los filtros aplicados, sin tocar la barra del navegador
    var urlActual = new URL(location.href);
    var cargando = false, enSitio = false, pagina = 1, hayMas = false, cargandoMas = false, conScroll = false;
    // Lo que se reemplaza con el resultado: la barra (con el modal de filtros), los filtros
    // aplicados del celular y el cuerpo con la grilla
    var ZONAS = ['.js-category-controls', 'div.container-fluid.visible-when-content-ready.d-md-none', '.js-category-body'];

    function limpiarPagina(url) {
        url.pathname = url.pathname.replace(/\/page\/\d+\/?$/, '/');
        url.searchParams.delete('page');
        url.searchParams.delete('mpage');
        return url;
    }

    function ordenar(valor) {
        var url = new URL(urlActual);
        url.searchParams.set('sort_by', valor);
        cargar(url);
    }

    function cargar(url) {
        if (cargando) { return; }
        cargando = true;
        limpiarPagina(url);
        document.documentElement.classList.add('sgns-grid-cargando');
        fetch(url.toString(), { credentials: 'same-origin' }).then(function(r) {
            if (!r.ok) { throw new Error(r.status); }
            return r.text();
        }).then(function(html) {
            var doc = new DOMParser().parseFromString(html, 'text/html');
            if (!doc.querySelector('.js-category-body')) { throw new Error('sin grilla'); }
            // Si el modal de filtros está abierto, se cierra como lo cierra la tienda
            var modal = document.getElementById('nav-filters');
            var cerrar = modal && modal.classList.contains('modal-show') && modal.querySelector('.js-modal-close');
            if (cerrar) { cerrar.click(); }
            ZONAS.forEach(function(sel) {
                var nuevos = doc.querySelectorAll(sel);
                document.querySelectorAll(sel).forEach(function(viejo, i) {
                    if (!nuevos[i]) { return; }
                    var nuevo = document.importNode(nuevos[i], true);
                    // La barra conserva su estado (fija arriba, etc.)
                    if (sel === ZONAS[0]) { nuevo.className = viejo.className; }
                    viejo.parentNode.replaceChild(nuevo, viejo);
                });
            });
            urlActual = url;
            enSitio = true;
            pagina = 1;
            hayMas = !!doc.querySelector('.js-load-more');
            document.querySelectorAll('.js-load-more').forEach(function(b) { b.style.display = 'none'; });
            init();
            despuesDeCargar();
            if (!conScroll) { conScroll = true; window.addEventListener('scroll', masProductos, { passive: true }); }
        }).catch(function() {
            location.href = url.toString();
        }).then(function() {
            cargando = false;
            document.documentElement.classList.remove('sgns-grid-cargando');
        });
    }

    function despuesDeCargar() {
        document.querySelectorAll('.js-item-product').forEach(function(p) { p.classList.add('is-inViewport'); });
        if (window.LS && typeof LS.productItemSlider === 'function') { try { LS.productItemSlider(); } catch (e) { /* sin slider */ } }
        document.dispatchEvent(new CustomEvent('sgns:grilla'));
    }

    // Después de ordenar o filtrar en el lugar, las páginas siguientes las trae este script
    // (el scroll infinito de la tienda sigue atado a la grilla anterior)
    function masProductos() {
        if (!enSitio || !hayMas || cargandoMas || cargando) { return; }
        var grilla = document.querySelector('.js-product-table');
        if (!grilla || grilla.getBoundingClientRect().bottom > window.innerHeight * 2) { return; }
        cargandoMas = true;
        var url = new URL(urlActual);
        url.pathname = url.pathname.replace(/\/$/, '') + '/page/' + (pagina + 1) + '/';
        url.searchParams.set('results_only', 'true');
        url.searchParams.set('limit', '12');
        if (window.LS && LS.theme && LS.theme.code) { url.searchParams.set('theme', LS.theme.code); }
        var pedido = urlActual.toString();
        fetch(url.toString(), { credentials: 'same-origin', headers: { Accept: 'application/json' } }).then(function(r) {
            return r.json();
        }).then(function(d) {
            if (pedido !== urlActual.toString()) { return; }
            if (d.has_results) {
                grilla.insertAdjacentHTML('beforeend', d.html);
                pagina++;
                despuesDeCargar();
            }
            hayMas = !!d.has_next;
        }).catch(function() {
            hayMas = false;
        }).then(function() {
            cargandoMas = false;
        });
    }

    // Filtros: los clics no llegan al código de la tienda (que recarga la página)
    function filtrar(e) {
        var el = e.target.closest ? e.target.closest('.js-apply-filter, .js-remove-filter, .js-remove-all-filters') : null;
        if (!el || !document.querySelector('.js-category-body')) { return; }
        e.preventDefault();
        e.stopPropagation();
        var url = new URL(urlActual);
        if (el.classList.contains('js-remove-all-filters')) {
            var queda = new URLSearchParams();
            ['sort_by', 'q'].forEach(function(k) { if (url.searchParams.has(k)) { queda.set(k, url.searchParams.get(k)); } });
            url.search = queda.toString();
        } else {
            var nombre = el.getAttribute('data-filter-name');
            var valor = el.getAttribute('data-filter-value');
            if (!nombre) { return; }
            // El filtro de precio aplicado viene como "min_price|max_price": se quitan los dos
            if (nombre.indexOf('|') !== -1) {
                nombre.split('|').forEach(function(k) { url.searchParams.delete(k); });
                cargar(url);
                return;
            }
            // Varios valores del mismo filtro van juntos, separados por "|"
            var valores = (url.searchParams.get(nombre) || '').split('|').filter(Boolean);
            if (el.classList.contains('js-apply-filter')) {
                if (valores.indexOf(valor) === -1) { valores.push(valor); }
            } else {
                // Sin valor: se quita el filtro entero
                valores = valor ? valores.filter(function(v) { return v !== valor; }) : [];
            }
            valores.sort();
            if (valores.length) { url.searchParams.set(nombre, valores.join('|')); } else { url.searchParams.delete(nombre); }
        }
        cargar(url);
    }

    // Filtro de precio (Desde / Hasta): el formulario tampoco recarga la página
    function filtrarPrecio(e) {
        // Llega por el envío del formulario o por el clic en "Aplicar" (que la tienda atiende por su cuenta)
        var form = e.target;
        if (e.type === 'click') {
            var aplicar = form.closest ? form.closest('.js-price-filter-btn') : null;
            form = aplicar && aplicar.closest('form');
            if (!form) { return; }
        }
        if (!form.closest || !form.closest('.js-price-filter-container') || !document.querySelector('.js-category-body')) { return; }
        e.preventDefault();
        e.stopPropagation();
        var url = new URL(urlActual);
        ['min_price', 'max_price'].forEach(function(k) {
            var campo = form.querySelector('[name="' + k + '"]');
            var v = campo ? campo.value.trim() : '';
            if (v) { url.searchParams.set(k, v); } else { url.searchParams.delete(k); }
        });
        cargar(url);
    }

    function armar(select, idx) {
        if (select.getAttribute('data-sgns-sort')) { return; }
        select.setAttribute('data-sgns-sort', '1');

        var existentes = {};
        Array.prototype.forEach.call(select.options, function(o) { existentes[o.value] = true; });
        var actual = select.value;
        var enModal = !!select.closest('#nav-filters');

        var lista = OPCIONES.filter(function(o) {
            return existentes[o.v] && (!o.solo || o.v === actual);
        });
        var elegida = lista.filter(function(o) { return o.v === actual; })[0];

        var box = document.createElement('div');
        box.className = 'sgns-sort' + (enModal ? ' sgns-sort--inline' : '');

        var menuId = 'sgns-sort-menu-' + idx;
        var html = '';
        if (!enModal) {
            html += '<button type="button" class="sgns-sort__btn" aria-haspopup="listbox" aria-expanded="false" aria-controls="' + menuId + '">' +
                '<span>Ordenar: <b>' + (elegida ? elegida.t : 'Elegir') + '</b></span>' +
                '<svg class="sgns-sort__chev" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 9l6 6 6-6"/></svg></button>';
        }
        html += '<div class="sgns-sort__menu" id="' + menuId + '" role="listbox" aria-label="Ordenar por"' + (enModal ? '' : ' hidden') + '>';
        lista.forEach(function(o) {
            var on = o.v === actual;
            html += '<button type="button" role="option" class="sgns-sort__opt' + (on ? ' is-on' : '') + '" aria-selected="' + on + '" data-v="' + o.v + '">' +
                icono(o.i) + '<span>' + o.t + '</span>' +
                (on ? '<svg class="sgns-sort__check" viewBox="0 0 24 24" aria-hidden="true"><path d="M5 12.5l4.5 4.5L19 7.5"/></svg>' : '') +
                '</button>';
        });
        html += '</div>';
        box.innerHTML = html;

        var grupo = select.closest('.form-group') || select.parentNode;
        grupo.classList.add('sgns-sort-native');
        grupo.parentNode.insertBefore(box, grupo);

        var btn = box.querySelector('.sgns-sort__btn');
        var menu = box.querySelector('.sgns-sort__menu');
        var opts = Array.prototype.slice.call(box.querySelectorAll('.sgns-sort__opt'));

        opts.forEach(function(op, i) {
            op.addEventListener('click', function() {
                var v = op.getAttribute('data-v');
                if (v === actual) { cerrar(); return; }
                ordenar(v);
            });
            op.addEventListener('keydown', function(e) {
                if (e.key === 'ArrowDown') { e.preventDefault(); (opts[i + 1] || opts[0]).focus(); }
                if (e.key === 'ArrowUp') { e.preventDefault(); (opts[i - 1] || opts[opts.length - 1]).focus(); }
            });
        });

        if (!btn) { return; }

        function abrir() {
            menu.hidden = false;
            btn.setAttribute('aria-expanded', 'true');
            box.classList.add('is-open');
            (box.querySelector('.sgns-sort__opt.is-on') || opts[0]).focus();
        }
        function cerrar() {
            if (!btn || menu.hidden) { return; }
            menu.hidden = true;
            btn.setAttribute('aria-expanded', 'false');
            box.classList.remove('is-open');
        }

        btn.addEventListener('click', function() { if (menu.hidden) { abrir(); } else { cerrar(); } });
        document.addEventListener('click', function(e) { if (!box.contains(e.target)) { cerrar(); } });
        box.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') { cerrar(); btn.focus(); }
        });
    }

    // En el modal de filtros, la categoría en la que estás queda marcada
    function marcarCategoria() {
        var aqui = location.pathname.replace(/\/+$/, '');
        document.querySelectorAll('#nav-filters .js-accordion-container a.btn-link').forEach(function(a) {
            a.classList.add('sgns-cat-link');
            var ruta = new URL(a.href, location.href).pathname.replace(/\/+$/, '');
            if (ruta === aqui) { a.classList.add('is-current'); a.setAttribute('aria-current', 'page'); }
        });
    }

    // Modal de filtros: clase para su estilo propio y categorías en minúscula
    // (en Tiendanube están cargadas en mayúsculas: "JEANS" -> "Jeans")
    function modalFiltros() {
        var modal = document.getElementById('nav-filters');
        if (!modal) { return; }
        modal.classList.add('sgns-filters');
        modal.querySelectorAll('a.sgns-cat-link').forEach(function(a) {
            var t = a.textContent.trim();
            if (t && t === t.toUpperCase()) {
                a.textContent = t.charAt(0) + t.slice(1).toLocaleLowerCase('es');
            }
        });
    }

    // Botón "Filtrar" con el mismo estilo que "Ordenar", y cuántos filtros hay aplicados
    function botonFiltrar() {
        var visto = {};
        var n = 0;
        document.querySelectorAll('.js-remove-filter.chip').forEach(function(chip) {
            if (chip.closest('#nav-filters')) { return; }
            var k = chip.getAttribute('data-filter-name') + '|' + chip.getAttribute('data-filter-value');
            if (!visto[k]) { visto[k] = true; n++; }
        });
        document.querySelectorAll('.js-modal-open[data-toggle="#nav-filters"]').forEach(function(btn) {
            if (btn.classList.contains('sgns-filter-btn')) { return; }
            btn.classList.add('sgns-filter-btn');
            btn.setAttribute('aria-label', 'Filtrar' + (n ? ' (' + n + ' aplicados)' : ''));
            btn.innerHTML = '<svg class="sgns-filter-btn__icon" viewBox="0 0 24 24" aria-hidden="true">' +
                '<path d="M4 7h9M17 7h3M4 17h3M11 17h9"/><circle cx="15" cy="7" r="2"/><circle cx="9" cy="17" r="2"/></svg>' +
                '<span>Filtrar</span>' + (n ? '<em>' + n + '</em>' : '');
        });
    }

    function init() {
        if (!document.querySelector('.template-category, .template-search')) { return; }
        document.querySelectorAll('select[data-component="sort-by"]').forEach(armar);
        botonFiltrar();
        marcarCategoria();
        modalFiltros();
    }

    document.addEventListener('click', filtrar, true);
    document.addEventListener('submit', filtrarPrecio, true);
    document.addEventListener('click', filtrarPrecio, true);
    // Tras cambiar la grilla en el lugar, el formulario de precio es nuevo: "Aplicar" se habilita al escribir
    document.addEventListener('input', function(e) {
        var caja = e.target.closest ? e.target.closest('.js-price-filter-container') : null;
        var btn = caja && caja.querySelector('.js-price-filter-btn');
        if (!btn) { return; }
        var hay = Array.prototype.some.call(caja.querySelectorAll('.js-price-filter-input'), function(c) { return c.value.trim(); });
        btn.disabled = !hay;
        btn.classList.toggle('disabled', !hay);
    });

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
