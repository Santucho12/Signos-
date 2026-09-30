/* Drop 01 del menú/pie: bloqueado mientras el botón Drop del hero esté bloqueado, y se desbloquea junto con él.
   Fecha: la del hero (data-drop-unlock en home.tpl) si estamos en el inicio; si no, la misma fecha de respaldo. */
(function() {
    var RESPALDO = '2026-10-02T22:00:00-03:00';
    function fin() {
        var hero = document.querySelector('.sgns-hero-btn--drop[data-drop-unlock]');
        return new Date(hero ? hero.getAttribute('data-drop-unlock') : RESPALDO).getTime();
    }
    function bloqueado() { return Date.now() < fin(); }
    function esDrop(a) {
        if (a.classList.contains('sgns-hero-btn--drop')) { return false; } // el del hero se maneja solo
        var href = a.getAttribute('href') || '';
        var txt = (a.textContent || '').replace(/\s+/g, ' ').trim();
        return /^\/(p\/)?drop[a-z0-9-]*\/?$/i.test(href) || /^drop\b/i.test(txt);
    }
    document.addEventListener('click', function(e) {
        var a = e.target.closest && e.target.closest('a');
        if (a && esDrop(a) && bloqueado()) { e.preventDefault(); e.stopPropagation(); }
    }, true);
    function marcar() {
        var lock = bloqueado();
        document.querySelectorAll('a').forEach(function(a) {
            if (!esDrop(a)) { return; }
            if (lock) { a.setAttribute('aria-disabled', 'true'); a.style.cursor = 'not-allowed'; a.style.opacity = '.45'; }
            else { a.removeAttribute('aria-disabled'); a.style.cursor = ''; a.style.opacity = ''; }
        });
    }
    marcar();
    document.addEventListener('DOMContentLoaded', marcar);
    new MutationObserver(marcar).observe(document.documentElement, { childList: true, subtree: true });
    setInterval(marcar, 1000); // se desbloquea en vivo junto con el hero
})();
