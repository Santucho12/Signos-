/**
 * redesign.js
 * ═══════════════════════════════════════════════════════════════════════════
 * JS del nuevo diseño. Solo carga cuando estás en modo preview.
 * (layout.tpl lo inyecta dinámicamente: <script src="redesign.js">)
 *
 * INSTRUCCIONES:
 *   - Separar la lógica del rediseño en secciones claras.
 *   - Todo lo que modifique el DOM va dentro de Redesign.init()
 *   - Los event listeners van en Redesign.bindEvents()
 *   - Usar `document.querySelectorAll` o la función $ helper de abajo.
 *
 * GO LIVE:
 *   Copiar las funciones necesarias a store.js.tpl eliminando el guard
 *   del if (!isRedesign) al inicio.
 * ═══════════════════════════════════════════════════════════════════════════
 */

(function () {
  'use strict';

  var isRedesign = document.documentElement.classList.contains('redesign-active');
  if (!isRedesign) return; // Safety guard — nunca ejecuta en el sitio real

  /* ─── Helpers ─────────────────────────────────────────────────────────── */

  /** Shortcut de querySelectorAll retornando Array */
  function $$(selector, context) {
    return Array.prototype.slice.call((context || document).querySelectorAll(selector));
  }

  /** Agrega clase con animación suave usando doble rAF + delay
   *  El doble rAF garantiza que el navegador PINTE el estado inicial
   *  (opacity:0) ANTES de disparar la transición hacia opacity:1.
   *  Sin esto, el navegador colapsa inicio y fin en un solo frame → sin transición.
   */
  function addClassAnimated(el, className, delay) {
    var apply = function () {
      requestAnimationFrame(function () {      // Frame 1: navegador registra la lectura del estado actual
        requestAnimationFrame(function () {   // Frame 2: ahora sí dispara la transición
          if (delay) {
            setTimeout(function () { el.classList.add(className); }, delay);
          } else {
            el.classList.add(className);
          }
        });
      });
    };
    apply();
  }

  /** Intersection Observer factory — llama a callback cuando el elemento entra en viewport */
  function onVisible(elements, callback, options) {
    if (!window.IntersectionObserver) {
      elements.forEach(function (el) { callback(el); });
      return;
    }
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          callback(entry.target);
          observer.unobserve(entry.target);
        }
      });
    }, Object.assign({ threshold: 0.15 }, options || {}));
    elements.forEach(function (el) { observer.observe(el); });
  }

  /* ─── Módulo principal ────────────────────────────────────────────────── */

  var Redesign = {

    /* ── 1. Animaciones de scroll (Intersection Observer)
    ─────────────────────────────────────────────────────────────────────────
    Agrega data-redesign-animate="fadeUp|fadeIn|slideLeft" a cualquier
    elemento en el HTML (en los .tpl con {% if is_redesign %}) y esta
    función le aplica la animación cuando entra al viewport.
    ──────────────────────────────────────────────────────────────────────── */
    initScrollAnimations: function () {
      var animated = $$('[data-redesign-animate]');
      if (!animated.length) return;

      onVisible(animated, function (el) {
        var type  = el.dataset.redesignAnimate || 'fadeUp';
        var delay = parseInt(el.dataset.redesignDelay || 0, 10);
        addClassAnimated(el, 'redesign-animate-' + type, delay);
      });
    },

    /* ── 1b. Animación de la sección Novedades al hacer scroll
    ─────────────────────────────────────────────────────────────────────────
    Observa la sección completa. Cuando el usuario scrollea y la sección entra
    al viewport, añade la clase .is-visible. Los CSS @keyframes definidos en
    style-redesign.scss esperan esa clase para dispararse en cascada.
    ──────────────────────────────────────────────────────────────────────── */
    initNovedadesAnimation: function () {
      var section = document.querySelector('.redesign-novedades');
      if (!section) return;

      if (!window.IntersectionObserver) {
        // Fallback: mostrar todo sin animación si el browser es muy viejo
        section.classList.add('is-visible');
        return;
      }

      var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            section.classList.add('is-visible');
            observer.unobserve(section); // Solo se dispara una vez
          }
        });
      }, { threshold: 0.1 }); // Dispara cuando el 10% de la sección es visible

      observer.observe(section);
    },

    /* ── 1c. Carrusel automático de la sección Novedades
    ─────────────────────────────────────────────────────────────────────────
    Auto-play con crossfade entre slides cada 4 segundos.
    Actualiza los puntos indicadores (dots) sin usar flechas.
    ──────────────────────────────────────────────────────────────────────── */
    initNovedadesCarousel: function () {
      var dots  = $$('.novedades-dot');
      if (!dots.length) return;

      var current = 0;
      var total   = dots.length;

      // Sincroniza los dots con el ciclo CSS (4s por slide = 12s total)
      setInterval(function () {
        dots[current].classList.remove('active');
        current = (current + 1) % total;
        dots[current].classList.add('active');
      }, 4000);
    },

    /* ── 2. Animaciones de hover en tarjetas de producto
    ─────────────────────────────────────────────────────────────────────────
    Aplica efectos extra de hover que requieren JS (ej. parallax de imagen).
    ──────────────────────────────────────────────────────────────────────── */
    initProductCardEffects: function () {
      var items = $$('.redesign-active .item');
      items.forEach(function (item) {

        var img = item.querySelector('.item-image img');
        if (!img) return;

        item.addEventListener('mouseenter', function () {
          img.style.transform = 'scale(1.06)';
          img.style.transition = 'transform .5s cubic-bezier(.25,.8,.25,1)';
        });

        item.addEventListener('mouseleave', function () {
          img.style.transform = 'scale(1)';
        });

      });
    },

    /* ── 3. Header: efecto scroll (cambia opacidad / tamaño al scrollear)
    ──────────────────────────────────────────────────────────────────────── */
    initHeaderScroll: function () {
      var header = document.querySelector('.head-main');
      if (!header) return;

      var lastScroll = 0;

      window.addEventListener('scroll', function () {
        var currentScroll = window.pageYOffset;

        if (currentScroll > 80) {
          header.classList.add('redesign-header-scrolled');
        } else {
          header.classList.remove('redesign-header-scrolled');
        }

        // Auto-hide header al scrollear hacia abajo, mostrar al subir
        if (currentScroll > lastScroll && currentScroll > 200) {
          header.classList.add('redesign-header-hidden');
        } else {
          header.classList.remove('redesign-header-hidden');
        }

        lastScroll = currentScroll;
      }, { passive: true });
    },

    /* ── 4. Modificaciones DOM: HTML extra que querés inyectar sin Twig
    ─────────────────────────────────────────────────────────────────────────
    Útil para PROBAR elementos antes de agregarlos definitivamente al .tpl.
    Cuando funcione bien, moverlos al archivo .tpl con {% if is_redesign %}.
    ──────────────────────────────────────────────────────────────────────── */
    initDOMInjections: function () {

      /* ---- Ejemplo: banner ancho debajo del header (eliminá si no lo usás) */
      /*
      var header = document.querySelector('.head-main');
      if (header && !document.getElementById('redesign-top-banner')) {
        var banner = document.createElement('div');
        banner.id = 'redesign-top-banner';
        banner.innerHTML = '<div class="container-fluid"><p>🔥 Envío gratis en compras mayores a $X</p></div>';
        header.insertAdjacentElement('afterend', banner);
      }
      */

      /* ---- Ejemplo: sticky CTA en mobile */
      /*
      if (window.innerWidth < 768 && !document.getElementById('redesign-sticky-cta')) {
        var cta = document.createElement('div');
        cta.id = 'redesign-sticky-cta';
        cta.innerHTML = '<a href="/carrito" class="btn btn-primary w-100">Ver carrito</a>';
        document.body.appendChild(cta);
      }
      */

    },

    /* ── 5. Animación de entrada para secciones del home
    ──────────────────────────────────────────────────────────────────────── */
    initHomeSections: function () {
      var sections = $$('.home-sections-container > .row, .home-sections-container > section');

      onVisible(sections, function (section, index) {
        addClassDelayed(section, 'redesign-animate-fadeUp', (index || 0) * 80);
      });
    },

    /* ── 6. Smooth scroll para links internos
    ──────────────────────────────────────────────────────────────────────── */
    initSmoothScroll: function () {
      $$('a[href^="#"]').forEach(function (link) {
        link.addEventListener('click', function (e) {
          var target = document.querySelector(this.getAttribute('href'));
          if (!target) return;
          e.preventDefault();
          target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
      });
    },




    /* ── INIT: punto de entrada ─────────────────────────────────────────── */
    init: function () {
      // Esperar a que el DOM esté listo
      var self = this;
      function run() {
        self.initScrollAnimations();
        self.initNovedadesAnimation();
        self.initNovedadesCarousel();
        self.initProductCardEffects();
        self.initHeaderScroll();
        self.initDOMInjections();
        self.initHomeSections();
        self.initSmoothScroll();

        console.log('%c🎨 Redesign activo — modo preview', 'color:#FFD700;font-weight:bold;font-size:14px;');
      }

      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', run);
      } else {
        run();
      }
    }

  };

  /* ─── Arrancar ─────────────────────────────────────────────────────────── */
  Redesign.init();

})();
