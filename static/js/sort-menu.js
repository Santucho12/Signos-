/* Menú de "Ordenar" propio en productos, categorías y búsqueda.
   Reemplaza al select nativo (queda oculto en la página como respaldo):
   - En la barra de la grilla: botón "Ordenar: Novedades" que abre una tarjeta.
   - Dentro del modal de filtros (mobile): la lista va abierta, sin botón.
   Elegir una opción recarga la página con ?sort_by=, conservando los filtros.
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

    function ordenar(valor) {
        var url = new URL(location.href);
        url.searchParams.set('sort_by', valor);
        url.searchParams.delete('page');
        location.href = url.toString();
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

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
