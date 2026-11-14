/* Intro del inicio (estilo landing DG/VMAX): el hero arranca con el video
   desenfocado y el logo SGNS Studio con "Temporada 26" se revela de izquierda
   a derecha, suave, en su mismo lugar y tamaño. Después el fondo se enfoca y
   entran el menú y los botones. Estilos: style-redesign.scss (INTRO v4).
   También la usa el hero de las categorías Drop (snipplets/drop-hero.tpl). */
(function() {
    'use strict';

    var REVELADO = 1200; // barrido ágil del logo (1.2s)
    var PAUSA = 80;      // pausa breve antes de aclarar
    var SALIDA = 500;    // fundido de salida del velo (0.5s)

    function init() {
        var velo = document.getElementById('sgns-intro');
        if (!velo) { return; }

        // Se volvió con "atrás": nada de intro, la página queda donde estaba
        if (window.__sgnsVuelta) {
            if (velo.parentNode) { velo.parentNode.removeChild(velo); }
            return;
        }

        var root = document.documentElement;
        root.classList.add('sgns-intro-lock');
        root.classList.add('sgns-intro-on');

        if (!window.location.hash) { window.scrollTo(0, 0); }

        // Celular (iOS incluido): el gesto de arrastrar no mueve la página mientras dura la intro
        document.addEventListener('touchmove', function(e) {
            if (root.classList.contains('sgns-intro-lock')) { e.preventDefault(); }
        }, { passive: false });

        var logo = document.querySelector('.redesign-hero-title--img img');

        // Arranca con el logo listo: si no, el barrido pasa sobre un hueco
        var arrancado = false;
        function arrancar() {
            if (arrancado) { return; }
            arrancado = true;
            velo.classList.add('is-ready');
            root.classList.add('sgns-intro-run');
            correr(velo, root);
        }

        if (logo && logo.decode) {
            logo.decode().then(arrancar).catch(arrancar);
            setTimeout(arrancar, 400);
        } else if (document.fonts && document.fonts.load) {
            // Hero de las categorías Drop: el título es texto, se espera su tipografía
            document.fonts.load('1em "Blunt Semiconit"').then(arrancar, arrancar);
            setTimeout(arrancar, 400);
        } else {
            arrancar();
        }
    }

    // El video visible del hero (desktop o mobile), ya reproduciendo
    function videoListo() {
        var vids = document.querySelectorAll('.redesign-hero-video');
        for (var i = 0; i < vids.length; i++) {
            if (vids[i].getBoundingClientRect().width > 0) {
                return vids[i].readyState >= 2 && vids[i].currentTime > 0.01;
            }
        }
        return true;
    }

    function correr(velo, root) {
        var inicio = Date.now();
        var minimo = REVELADO + PAUSA;

        function esperar() {
            var t = Date.now() - inicio;
            // Si el video ya corre o ya pasaron 1.6s, salimos de inmediato (sin esperas de 4.5s)
            if (t >= minimo && (videoListo() || t >= 1600)) {
                salir();
            } else {
                setTimeout(esperar, 50);
            }
        }

        function salir() {
            velo.classList.add('is-exiting');

            // El resto del hero entra con suavidad
            setTimeout(function() {
                root.classList.add('sgns-hero-in');
                root.classList.remove('sgns-intro-on');
            }, 100);

            setTimeout(function() {
                root.classList.remove('sgns-intro-lock');
                root.classList.remove('sgns-intro-run');
                if (velo.parentNode) { velo.parentNode.removeChild(velo); }
            }, SALIDA + 50);

            setTimeout(function() { root.classList.remove('sgns-hero-in'); }, 1200);
        }

        esperar();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
