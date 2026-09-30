(function () {
  var root = document.querySelector('.sgns-drop');

  // Video de portada: se carga solo el que corresponde al viewport
  var vid = document.querySelector('.drop-hero__video[data-src-desktop]');
  if (vid) {
    vid.src = window.matchMedia('(max-width: 767px)').matches ? vid.getAttribute('data-src-mobile') : vid.getAttribute('data-src-desktop');
    vid.load();
    var pl = vid.play();
    if (pl && pl.catch) { pl.catch(function () {}); }
  }

  if (root) {
    // Cuenta regresiva
    var fecha = new Date(root.getAttribute('data-drop-fecha')).getTime();
    var cel = {};
    ['d', 'h', 'm', 's'].forEach(function (k) { cel[k] = root.querySelector('[data-c="' + k + '"]'); });
    var pad = function (n) { return String(n).padStart(2, '0'); };
    (function tick() {
      var t = Math.max(0, fecha - Date.now());
      cel.d.textContent = pad(Math.floor(t / 864e5));
      cel.h.textContent = pad(Math.floor(t / 36e5) % 24);
      cel.m.textContent = pad(Math.floor(t / 6e4) % 60);
      cel.s.textContent = pad(Math.floor(t / 1e3) % 60);
      if (t > 0) { setTimeout(tick, 1000); }
    })();

    // Aparición al scrollear
    var els = root.querySelectorAll('[data-reveal]');
    if ('IntersectionObserver' in window) {
      var io = new IntersectionObserver(function (es) {
        es.forEach(function (e) { if (e.isIntersecting) { e.target.classList.add('is-in'); io.unobserve(e.target); } });
      }, { threshold: 0.15 });
      els.forEach(function (el) { io.observe(el); });
    } else {
      els.forEach(function (el) { el.classList.add('is-in'); });
    }
  }

  // Regla de identificación: todo ítem de menú cuyo nombre empiece con "Drop"
  document.querySelectorAll('.nav-list-link').forEach(function (a) {
    if (/^\s*drop\b/i.test(a.textContent)) { a.classList.add('is-drop'); }
  });
})();
