/* El hero se va oscureciendo a medida que se scrollea: el velo que ya está
   sobre el video sube de opacidad según cuánto del hero quedó arriba de la
   pantalla. Al volver arriba, aclara de nuevo. */
(function() {
    'use strict';

    var MIN = 0.32; // el velo que tiene el hero cuando estás arriba de todo
    var MAX = 0.94; // cuánto llega a oscurecerse al salir del hero

    function init() {
        var hero = document.querySelector('.redesign-hero');
        if (!hero) { return; }

        var pendiente = false;

        function actualizar() {
            pendiente = false;
            var alto = hero.offsetHeight || 1;
            var y = window.pageYOffset || document.documentElement.scrollTop || 0;
            var avance = Math.min(Math.max(y / (alto * 0.85), 0), 1); // oscurece un poco más rápido
            hero.style.setProperty('--sgns-hero-velo', (MIN + (MAX - MIN) * avance).toFixed(3));
        }

        window.addEventListener('scroll', function() {
            if (!pendiente) { pendiente = true; requestAnimationFrame(actualizar); }
        }, { passive: true });
        window.addEventListener('resize', actualizar);
        actualizar();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
