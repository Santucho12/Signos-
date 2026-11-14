/* Tarjetas especiales en toda la tienda (inicio, búsqueda, otras categorías), porque en esos listados Tiendanube
   no dice en qué categorías está cada producto. Se consultan las categorías y se marcan las tarjetas:
   - Cyber (CYBER SGNS): la tarjeta azul noche del Cyber (.sgns-cyber-card, style-redesign.scss), si no es dorada.
   - Prenda dorada: la carta de oro, que cada tarjeta ya trae oculta (snipplets/grid/item.tpl, .sgns-dorada--latente).
   Los productos con las etiquetas CYBER SGNS / PRENDA DORADA ya vienen marcados desde el servidor (snipplets/grid/item.tpl);
   esto cubre a los que no la tienen y le saca la del Cyber a los que dejaron de estar en la categoría.
   Las listas se guardan 10 minutos en la sesión para no pedirlas en cada página. */
(function() {
    var CYBER = '/cyber-sgns/';
    var DORADA = '/prenda-dorada-1rdpi/';
    // Todos los productos de una categoría: se piden sus páginas de a 100 (/page/N/?results_only=true, lo mismo que
    // usa "mostrar más"; ?mpage=N devuelve siempre la primera) hasta una que venga sin productos nuevos
    function pedirIds(url, fresco, fn) {
        var lista = [];
        function pagina(n) {
            fetch(url + 'page/' + n + '/?results_only=true&limit=100' + (fresco ? '&sgns=' + Date.now() : ''), { credentials: 'same-origin', cache: fresco ? 'no-store' : 'default' }).then(function(r) {
                // Categoría borrada u oculta: lista vacía (completa)
                if (r.status === 404) { return ''; }
                if (!r.ok) { throw r.status; }
                return r.text();
            }).then(function(h) {
                var m, nuevos = 0, re = /data-store="product-item-info-(\d+)"/g;
                while ((m = re.exec(h))) { if (lista.indexOf(m[1]) === -1) { lista.push(m[1]); nuevos++; } }
                if (nuevos && n < 20) { return pagina(n + 1); }
                fn(lista, true);
            }).catch(function() { fn(lista, false); });
        }
        pagina(1);
    }
    var enCurso = {};
    function ids(url, fn) {
        var clave = 'sgnsIds3' + url;
        try {
            var g = JSON.parse(sessionStorage.getItem(clave) || 'null');
            if (g && Date.now() - g.t < 6e5) { return fn(g.ids, true); }
        } catch (e) {}
        // Un solo pedido por categoría aunque se vuelva a llamar mientras tanto
        if (enCurso[url]) { return enCurso[url].push(fn); }
        enCurso[url] = [fn];
        pedirIds(url, false, function(lista, completa) {
            // Si falló alguna página no se guarda, para no quedarse 10 minutos con una lista a medias
            if (completa) { try { sessionStorage.setItem(clave, JSON.stringify({ t: Date.now(), ids: lista })); } catch (e) {} }
            var esperando = enCurso[url];
            delete enCurso[url];
            esperando.forEach(function(f) { f(lista, completa); });
        });
    }
    function idDe(card) {
        var info = card.querySelector('[data-store^="product-item-info-"]');
        return info ? info.getAttribute('data-store').replace('product-item-info-', '') : null;
    }
    function aplicar(cyber, dorada, cyberCompleta) {
        // En la página del Cyber ya se ven todas con la tarjeta del Cyber (snipplets/drop-hero.tpl)
        var enCyber = /cyber/i.test(location.pathname);
        // En la página de Prenda dorada todas son doradas, también las que se cargan con "mostrar más"
        var enDorada = /dorad/i.test(location.pathname);
        document.querySelectorAll('.js-item-product').forEach(function(card) {
            var id = idDe(card);
            if (!id) { return; }
            // La carta de oro manda siempre, también sobre el Cyber
            var esDorada = enDorada || dorada.indexOf(id) !== -1 || !!card.querySelector('.sgns-dorada:not(.sgns-dorada--latente)');
            var oro = card.querySelector('.sgns-dorada--latente');
            if (oro && esDorada) { oro.classList.remove('sgns-dorada--latente'); }
            if (cyber.indexOf(id) !== -1 && !esDorada && !enCyber) { card.classList.add('sgns-cyber-card'); }
            // La que vino marcada por etiqueta se desmarca si es dorada o si ya no está en el Cyber (solo con la lista entera)
            else if (card.classList.contains('sgns-cyber-card') && (esDorada || (cyberCompleta && cyber.indexOf(id) === -1))) { card.classList.remove('sgns-cyber-card'); }
        });
    }
    function revisar() {
        if (!document.querySelector('.js-item-product')) { return; }
        // Las dos listas se piden a la vez
        var c, d, cOk;
        ids(CYBER, function(l, ok) { c = l; cOk = ok; if (d) { aplicar(c, d, cOk); } });
        ids(DORADA, function(l) { d = l; if (c) { aplicar(c, d, cOk); } });
    }
    if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', revisar); } else { revisar(); }
    // Grillas que se cargan después (mostrar más, ordenar, filtrar)
    var espera;
    new MutationObserver(function() { clearTimeout(espera); espera = setTimeout(revisar, 300); }).observe(document.documentElement, { childList: true, subtree: true });
})();
