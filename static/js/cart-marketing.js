/**
 * Cart Marketing Logic
 * Handles the "Tiro Extra" popup and the dynamic progress banner.
 */

const CartMarketing = (() => {
    const CONFIG = {
        THRESHOLD_PROGRESS: 60000,
        THRESHOLD_TIRO_EXTRA: 110000,
        MODAL_ID: 'redesign-tiroextra-modal',
        MODAL_URL: 'https://ruleta-signos.vercel.app/tiroextra',
        SESSION_KEY: 'tiroextra_visto',   // sessionStorage: modal visto esta sesión
        PLAYED_KEY: 'tiroextra_played',   // localStorage: usuario ya jugó (permanente)
        BANNER_ID: 'cart-progress-banner'
    };

    let bannerElement = null;
    let isUpdating = false;

    const init = () => {
        // Log para depuración en consola
        console.log('CartMarketing: Iniciando chequeo...');

        // Validar modo preview (clase en HTML o parámetro en URL)
        const isPreview = document.documentElement.classList.contains('redesign-preview') || 
                          window.location.search.indexOf('redesign=') !== -1;
                          
        if (!isPreview) {
            console.log('CartMarketing: No es modo preview, cancelando.');
            return;
        }

        createBannerElement();
        setupEventListeners();
        checkCartStatus();
    };

    const createBannerElement = () => {
        if (document.getElementById(CONFIG.BANNER_ID)) return;

        bannerElement = document.createElement('div');
        bannerElement.id = CONFIG.BANNER_ID;
        bannerElement.className = 'cart-progress-banner';
        bannerElement.innerHTML = `
            <div class="banner-icon">🎡</div>
            <div class="banner-text">
                ¡Te faltan <span class="js-cart-remaining-amount">$0</span> para ganarte un 
                <strong>TIRO EXTRA en la ruleta!</strong>
            </div>
            <button class="banner-close">&times;</button>
        `;

        document.body.appendChild(bannerElement);

        bannerElement.querySelector('.banner-close').addEventListener('click', () => {
            bannerElement.classList.remove('is-visible');
        });
    };

    const setupEventListeners = () => {
        console.log('CartMarketing: Configurando listeners...');
        
        // Función de chequeo simplificada
        const runCheck = () => {
            if (isUpdating) return;
            checkCartStatus();
        };

        // 1. Escuchar eventos de Tienda Nube (JS y jQuery)
        document.addEventListener('cart.updated', runCheck);
        if (window.jQueryNuvem) {
            window.jQueryNuvem(document).on('cart.updated', runCheck);
        }

        // 2. Observador de cambios en el DOM
        try {
            const bodyObserver = new MutationObserver(runCheck);
            bodyObserver.observe(document.body, { 
                childList: true, 
                subtree: true, 
                characterData: true 
            });
        } catch(e) {
            console.warn('CartMarketing: MutationObserver no soportado o falló', e);
        }

        // 3. Polling constante (cada 1.5 segundos) - El más confiable
        setInterval(runCheck, 1500);
    };

    const getCartSubtotal = () => {
        const subtotalElement = document.querySelector('.js-cart-subtotal');
        if (!subtotalElement) return 0;

        // Tienda Nube siempre guarda data-priceraw en CENTAVOS
        // $10.000 ARS → data-priceraw = "1000000" → dividimos siempre por 100
        let raw = subtotalElement.getAttribute('data-priceraw');
        if (raw) {
            let val = parseFloat(raw);
            if (!isNaN(val) && val > 0) {
                return val / 100; // Siempre en centavos
            }
        }
        
        // Fallback al texto visible ($ 100.587,00)
        // Ejemplo: "$ 100.587,00" → "100587.00"
        let text = subtotalElement.textContent || "0";
        let clean = text.replace(/\./g, '').replace(/,/g, '.').replace(/[^\d.]/g, '');
        return parseFloat(clean) || 0;
    };

    const formatMoney = (amount) => {
        return '$' + Math.floor(amount).toLocaleString('es-AR');
    };

    const checkCartStatus = () => {
        const subtotal = getCartSubtotal();
        
        // Solo logueamos si hay algo en el carrito (evitar spam)
        if (subtotal > 0) console.log('CartMarketing: Subtotal = $' + subtotal);

        // Si el usuario ya jugó → ocultar todo permanentemente
        const alreadyPlayed = (() => { try { return !!localStorage.getItem(CONFIG.PLAYED_KEY); } catch(e) { return false; } })();
        if (alreadyPlayed) {
            hideBanner();
            return;
        }

        if (subtotal >= CONFIG.THRESHOLD_TIRO_EXTRA) {
            hideBanner();
            triggerTiroExtraModal();
        } 
        else if (subtotal >= CONFIG.THRESHOLD_PROGRESS && subtotal < CONFIG.THRESHOLD_TIRO_EXTRA) {
            const remaining = CONFIG.THRESHOLD_TIRO_EXTRA - subtotal;
            showBanner(remaining);
        } 
        else {
            hideBanner();
        }
    };

    const showBanner = (remaining) => {
        if (!bannerElement) return;
        isUpdating = true;
        const amountSpan = bannerElement.querySelector('.js-cart-remaining-amount');
        if (amountSpan) amountSpan.textContent = formatMoney(remaining);
        bannerElement.classList.add('is-visible');
        setTimeout(() => { isUpdating = false; }, 100);
    };

    const hideBanner = () => {
        if (!bannerElement) return;
        isUpdating = true;
        bannerElement.classList.remove('is-visible');
        setTimeout(() => { isUpdating = false; }, 100);
    };

    const triggerTiroExtraModal = () => {
        if (!window.MarketingModals) return;

        // Si ya jugó (localStorage permanente) → nunca más mostrar
        try { if (localStorage.getItem(CONFIG.PLAYED_KEY)) return; } catch(e) {}

        // ANTI-SOLAPAMIENTO: No abrir si hay un modal abierto (ej: ruleta principal)
        if (document.querySelector('.marketing-modal.is-open')) {
            console.log('CartMarketing: Modal abierto detectado, esperando...');
            return;
        }

        console.log('CartMarketing: ¡Umbral alcanzado! Disparando Tiro Extra...');
        const modalElement = document.getElementById(CONFIG.MODAL_ID);
        
        if (!modalElement) {
            // Primera vez: crear e inicializar el modal
            window.MarketingModals.init({
                id: CONFIG.MODAL_ID,
                url: CONFIG.MODAL_URL,
                delay: 0,
                sessionKey: null, // Sin sessionKey → puede reaparecer
                isPreviewOnly: true // Solo en preview
            });
        } else if (!modalElement.classList.contains('is-open')) {
            // Modal ya existe pero está cerrado → reabrirlo
            const iframe = modalElement.querySelector('iframe');
            if (iframe) {
                const separator = CONFIG.MODAL_URL.indexOf('?') !== -1 ? '&' : '?';
                iframe.src = `${CONFIG.MODAL_URL}${separator}cb=${new Date().getTime()}`;
            }
            modalElement.classList.add('is-open');
            document.body.style.overflow = 'hidden';
        }
    };

    // Escuchar cuando el usuario juega (postMessage desde el iframe)
    window.addEventListener('message', function(event) {
        if (event.data && event.data.type === 'tiroextra_played') {
            console.log('CartMarketing: Usuario jugó el Tiro Extra. Ocultando banner permanentemente.');
            try { localStorage.setItem(CONFIG.PLAYED_KEY, Date.now().toString()); } catch(e) {}
            hideBanner();
            // Cerrar el modal suavemente
            const m = document.getElementById(CONFIG.MODAL_ID);
            if (m) {
                setTimeout(() => { m.classList.remove('is-open'); document.body.style.overflow = ''; }, 3000);
            }
        }
    });

    return { init };
})();

// Inicializar
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', CartMarketing.init);
} else {
    CartMarketing.init();
}
