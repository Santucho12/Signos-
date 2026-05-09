/* REDESIGN.JS V3 - CACHE BUSTED */
console.log("Redesign JS V3: Loading...");

var Redesign = {
    $$: function(selector, context) {
        return Array.prototype.slice.call((context || document).querySelectorAll(selector));
    },
    addClass: function(el, className, delay) {
        if (!el) return;
        setTimeout(function() {
            requestAnimationFrame(function() {
                el.classList.add(className);
            });
        }, delay || 0);
    },
    onVisible: function(elements, callback) {
        if (!elements || elements.length === 0) return;
        if (!window.IntersectionObserver) {
            elements.forEach(function(el, i) { callback(el, i); });
            return;
        }
        var obs = new IntersectionObserver(function(entries) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) {
                    callback(entry.target, elements.indexOf(entry.target));
                    obs.unobserve(entry.target);
                }
            });
        }, { rootMargin: '0px 0px -10% 0px' });
        elements.forEach(function(el) { obs.observe(el); });
    },
    initElements: function() {
        var items = this.$$('[data-redesign-animate]');
        var self = this;
        this.onVisible(items, function(el) {
            var type = el.getAttribute('data-redesign-animate') || 'fadeUp';
            var delay = parseInt(el.getAttribute('data-redesign-delay') || 0, 10);
            self.addClass(el, 'redesign-animate-' + type, delay);
        });
    },
    initCarousel: function() {
        var dots = this.$$('.novedades-dot');
        if (!dots.length) return;
        var cur = 0;
        setInterval(function() {
            dots[cur].classList.remove('active');
            cur = (cur + 1) % dots.length;
            dots[cur].classList.add('active');
        }, 5000);
    },
    initParallax: function() {
        var cards = this.$$('.categoria-card');
        if (!cards.length) return;
        var handle = function() {
            var h = window.innerHeight;
            cards.forEach(function(c) {
                var img = c.querySelector('.categoria-bg-img');
                if (!img) return;
                var r = c.getBoundingClientRect();
                if (r.top < h && r.bottom > 0) {
                    var move = ((r.top + r.height/2 - h/2) / h) * 35;
                    img.style.transform = 'translate3d(0, ' + move + 'px, 0)';
                }
            });
        };
        window.addEventListener('scroll', handle, { passive: true });
        handle();
    },
    init: function() {
        // ACTIVACIÓN TOTAL: Hacer que el rediseño sea el oficial para todos
        document.documentElement.classList.add('redesign-active');
        
        console.log("Redesign JS V3: Initializing (Production Mode)...");
        
        this.initElements();
        this.initCarousel();
        this.initParallax();

        // Safety Reveal: Si algo falla, mostrar todo en 3 segundos
        var self = this;
        setTimeout(function() {
            var all = self.$$('[data-redesign-animate]');
            all.forEach(function(el) {
                var type = el.getAttribute('data-redesign-animate') || 'fadeUp';
                el.classList.add('redesign-animate-' + type);
            });
            console.log("Redesign JS V3: Safety Reveal triggered.");
        }, 3000);
    }
};

// Auto-start
if (document.readyState === 'complete' || document.readyState === 'interactive') {
    Redesign.init();
} else {
    document.addEventListener('DOMContentLoaded', function() { Redesign.init(); });
}

