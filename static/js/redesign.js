/**
 * redesign.js 
 * ═══════════════════════════════════════════════════════════════════════════
 * JS del nuevo diseño. Solo carga cuando estás en modo preview.
 * ═══════════════════════════════════════════════════════════════════════════
 */

(function () {
  'use strict';

  var isRedesign = document.documentElement.classList.contains('redesign-active');
  if (!isRedesign) return; 

  /* ─── Helpers ─────────────────────────────────────────────────────────── */

  function $$(selector, context) {
    return Array.prototype.slice.call((context || document).querySelectorAll(selector));
  }

  function addClassAnimated(el, className, delay) {
    if (!el) return;
    setTimeout(function() {
      requestAnimationFrame(function() {
        el.classList.add(className);
      });
    }, delay || 0);
  }

  /** Intersection Observer robusto con detección de visibilidad inicial */
  function onVisible(elements, callback, options) {
    if (!elements || elements.length === 0) return;
    
    var observerOptions = {
        root: null, // viewport
        rootMargin: '0px 0px -10% 0px', // Gatilla cuando entra un 10% del viewport
        threshold: [0, 0.1]
    };

    if (options && typeof options === 'object') {
        for (var key in options) { observerOptions[key] = options[key]; }
    }

    if (!window.IntersectionObserver) {
      elements.forEach(function (el, index) { callback(el, index); });
      return;
    }

    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        // isIntersecting es verdadero si CUALQUIER parte del elemento es visible
        if (entry.isIntersecting || entry.intersectionRatio > 0) {
          var index = elements.indexOf(entry.target);
          callback(entry.target, index);
          observer.unobserve(entry.target);
        }
      });
    }, observerOptions);

    elements.forEach(function (el) { 
      observer.observe(el); 
      
      // Verificación manual inmediata con un pequeño delay para dejar que el layout asiente
      setTimeout(function() {
          var rect = el.getBoundingClientRect();
          var windowHeight = window.innerHeight || document.documentElement.clientHeight;
          // Si el tope del elemento ya pasó el 90% de la pantalla (ya entró)
          if (rect.top < windowHeight * 0.9) {
             var index = elements.indexOf(el);
             callback(el, index);
             observer.unobserve(el);
          }
      }, 100);
    });
  }

  /* ─── Módulo principal ────────────────────────────────────────────────── */

  var Redesign = {

    /** Reveal de elementos individuales */
    initElementReveals: function () {
      var items = $$('[data-redesign-animate]');
      onVisible(items, function (el, index) {
        var type = el.dataset.redesignAnimate || 'fadeUp';
        var delay = parseInt(el.dataset.redesignDelay || 0, 10);
        addClassAnimated(el, 'redesign-animate-' + type, delay);
      });
    },

    /** Carrusel Novedades */
    initNovedadesCarousel: function () {
      var dots = $$('.novedades-dot');
      if (!dots.length) return;
      var current = 0;
      setInterval(function () {
        dots[current].classList.remove('active');
        current = (current + 1) % dots.length;
        dots[current].classList.add('active');
      }, 5000);
    },


    /** Efecto hover imágenes y CTA */
    initCardEffects: function () {
      $$('.redesign-active .item, .redesign-active .categoria-card, .redesign-active .offer-card-premium').forEach(function (item) {
        var img = item.querySelector('.categoria-bg-img, .offer-bg-img, img');
        if (!img) return;
        
        // El CSS ahora maneja la mayoría de los efectos de hover,
        // pero podemos agregar refinamientos aquí si es necesario.
      });
    },

    /** Parallax suave para categorías */
    initParallax: function () {
      var cards = $$('.categoria-card');
      if (!cards.length) return;

      var handleParallax = function () {
        var windowHeight = window.innerHeight;
        var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        cards.forEach(function (card) {
          var img = card.querySelector('.categoria-bg-img');
          if (!img) return;

          var rect = card.getBoundingClientRect();
          var cardCenter = rect.top + rect.height / 2;
          var viewCenter = windowHeight / 2;
          
          // Calculamos el desplazamiento relativo al centro de la pantalla
          var diff = (cardCenter - viewCenter) / windowHeight;
          var move = diff * 35; // Intensidad del efecto (en px o %)
          
          // Aplicamos el movimiento (solo si es visible para performance)
          if (rect.top < windowHeight && rect.bottom > 0) {
            img.style.transform = 'translate3d(0, ' + move + 'px, 0) scale(1.1)';
          }
        });
      };

      window.addEventListener('scroll', handleParallax, { passive: true });
      handleParallax();
    },

    /** Header scroll */
    initHeaderScroll: function () {
      var header = document.querySelector('.head-main, [data-store="header"]');
      if (!header) return;

      var lastScroll = 0;
      var handleScroll = function () {
        var currentScroll = window.pageYOffset || document.documentElement.scrollTop;
        
        // Sincronizado con las clases de style-redesign.scss (.scrolled)
        header.classList.toggle('scrolled', currentScroll > 80);
        header.classList.toggle('redesign-header-hidden', currentScroll > lastScroll && currentScroll > 200);
        
        lastScroll = currentScroll;
      };

      window.addEventListener('scroll', handleScroll, { passive: true });
      handleScroll(); // Ejecutar inmediatamente para detectar posición inicial
    },

    /** Init */
    init: function () {
      var self = this;
      function run() {
        self.initElementReveals();
        self.initNovedadesCarousel();
        self.initCardEffects();
        self.initParallax(); // <--- Agregado
        self.initHeaderScroll();
        
        // Backup: Reveal forzado si el usuario scrollea mucho o pasa tiempo
        setTimeout(function() {
            $$('.redesign-categorias, .redesign-novedades, .redesign-offers, .redesign-social-feed').forEach(function(s) {
                s.classList.add('is-visible');
            });
        }, 5000);
      }

      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', run);
      } else {
        run();
      }
    }
  };

  Redesign.init();

})();
