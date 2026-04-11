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

  /** Agrega clase con delay opcional */
  function addClassDelayed(el, className, delay) {
    setTimeout(function () { el.classList.add(className); }, delay || 0);
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
        var type    = el.dataset.redesignAnimate || 'fadeUp';
        var delay   = el.dataset.redesignDelay   || 0;
        el.style.opacity = '0'; // initial hidden state
        addClassDelayed(el, 'redesign-animate-' + type, parseInt(delay, 10));
      });
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
