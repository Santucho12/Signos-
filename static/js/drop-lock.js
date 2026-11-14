/* Drops del menú/pie (Drop 01, Drop 02, ...): cada uno bloqueado mientras su botón del hero esté bloqueado,
   y se desbloquea junto con él. Fecha: la del botón del hero con el mismo número (data-drop-unlock en home.tpl)
   si estamos en el inicio; si no, la fecha de respaldo de ese número. */
(function() {
    var RESPALDO = { '01': '2026-10-03T20:00:00-03:00', '02': '2026-10-10T21:00:00-03:00', '03': '2026-11-01T00:00:00-03:00', '04': '2026-11-09T22:00:00-03:00', 'cyber': '2026-11-05T22:00:00-03:00', 'saqueo': '2026-11-13T20:00:00-03:00' };
    // Número del drop según el link o el texto ("drop-02-signos", "Drop 02"); sin número, el 01
    function numero(a) {
        var texto = (a.getAttribute('href') || '') + ' ' + (a.textContent || '');
        if (/cyber/i.test(texto)) { return 'cyber'; }
        if (/saqueo/i.test(texto)) { return 'saqueo'; } // botón SAQUEO del hero: no es un Drop numerado
        var m = texto.match(/drop[\s-]*0*(\d+)/i);
        return m ? ('0' + m[1]).slice(-2) : '01';
    }
    function fin(n) {
        var hero = Array.prototype.find.call(document.querySelectorAll('.sgns-hero-btn--drop[data-drop-unlock]'), function(b) { return numero(b) === n; });
        return new Date(hero ? hero.getAttribute('data-drop-unlock') : (RESPALDO[n] || RESPALDO['01'])).getTime();
    }
    function bloqueado(a) { return Date.now() < fin(numero(a)); }
    function esDrop(a) {
        if (a.classList.contains('sgns-hero-btn--drop')) { return false; } // el del hero se maneja solo
        if (a.hasAttribute('data-drop-propio')) { return false; } // las tarjetas de la hoja DROPS del inicio, también
        var href = a.getAttribute('href') || '';
        var txt = (a.textContent || '').replace(/\s+/g, ' ').trim();
        // Solo los Drops con número (Drop 01, Drop 02, ...): "Drop Gorras" es una categoría común
        return /^\/(p\/)?drop-?\d[a-z0-9-]*\/?$/i.test(href) || /^drop\s*\d/i.test(txt) || /\/cyber[a-z0-9-]*\/?$/i.test(href) || /^cyber/i.test(txt)
            || /\/saqueo[a-z0-9-]*\/?$/i.test(href) || /^saqueo/i.test(txt); // SAQUEO WEB del menú/pie: bloqueado hasta las 20:00 junto con el botón del hero
    }
    document.addEventListener('click', function(e) {
        var a = e.target.closest && e.target.closest('a');
        if (a && esDrop(a) && bloqueado(a)) { e.preventDefault(); e.stopPropagation(); }
    }, true);
    var CANDADO = '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="#E60000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" style="display:block"><rect x="5" y="11" width="14" height="10" rx="2.5"/><path d="M8 11V8a4 4 0 0 1 8 0v3"/><circle cx="12" cy="16" r="1.2" fill="#E60000" stroke="none"/></svg>';
    function marcar() {
        document.querySelectorAll('a').forEach(function(a) {
            if (!esDrop(a)) { return; }
            var lock = bloqueado(a);
            var icono = a.querySelector('.js-drop-candado');
            if (lock) {
                a.setAttribute('aria-disabled', 'true'); a.style.cursor = 'not-allowed'; a.style.setProperty('color', '#9a9a9a', 'important');
                if (!icono) {
                    var host = a.querySelector('.nav-item-text-wrapper') || a;
                    icono = document.createElement('span');
                    icono.className = 'js-drop-candado';
                    icono.style.cssText = 'display:inline-flex;vertical-align:middle;margin-left:8px;';
                    icono.innerHTML = CANDADO;
                    host.appendChild(icono);
                }
            } else {
                a.removeAttribute('aria-disabled'); a.style.cursor = ''; a.style.removeProperty('color');
                if (icono) { icono.remove(); }
            }
        });
    }
    marcar();
    document.addEventListener('DOMContentLoaded', marcar);
    new MutationObserver(marcar).observe(document.documentElement, { childList: true, subtree: true });
    setInterval(marcar, 1000); // se desbloquea en vivo junto con el hero
})();
