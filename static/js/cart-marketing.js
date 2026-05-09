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

        // Activado para todos en Producción
        console.log('CartMarketing: Sistema inicializado.');
        
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
            <div class="banner-content">
                <div class="banner-icon">🎯</div>
                <div class="banner-text">
                    ¡Estás a <span class="js-cart-remaining-amount">$0</span> de desbloquear tu 
                    <strong>TIRO EXTRA!</strong>
                </div>
                <div class="banner-progress-container">
                    <div class="banner-progress-bar js-cart-progress-bar" style="width: 0%"></div>
                </div>
            </div>
            <button class="banner-close" aria-label="Cerrar">&times;</button>
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
        const alreadyPlayed = (() => { 
            try { 
                const played = localStorage.getItem(CONFIG.PLAYED_KEY);
                if (played) console.log('CartMarketing: Usuario ya jugó (detectado en LS: ' + played + ')');
                return !!played; 
            } catch(e) { return false; } 
        })();

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
        // Doble chequeo: si ya jugó, nunca mostrar
        try { if (localStorage.getItem(CONFIG.PLAYED_KEY)) return; } catch(e) {}

        const banner = document.querySelector('.cart-progress-banner');
        if (!banner) {
            console.log('CartMarketing: Banner no encontrado, intentando inicializar...');
            createBannerElement();
            return;
        }

        isUpdating = true;
        
        const subtotal = getCartSubtotal();
        const progress = ((subtotal - CONFIG.THRESHOLD_PROGRESS) / (CONFIG.THRESHOLD_TIRO_EXTRA - CONFIG.THRESHOLD_PROGRESS)) * 100;
        
        const amountSpan = bannerElement.querySelector('.js-cart-remaining-amount');
        const progressBar = bannerElement.querySelector('.js-cart-progress-bar');
        
        if (amountSpan) amountSpan.textContent = formatMoney(remaining);
        if (progressBar) progressBar.style.width = `${Math.min(100, Math.max(0, progress))}%`;
        
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

        console.log('CartMarketing: ¡Umbral alcanzado! Preparando Tiro Extra en 2.2s...');
        
        setTimeout(() => {
            // Re-chequeo de sesión: si ya lo vio en esta sesión, no hacer nada
            try { if (sessionStorage.getItem(CONFIG.SESSION_KEY)) return; } catch(e) {}

            const modalElement = document.getElementById(CONFIG.MODAL_ID);
            
            if (!modalElement) {
                // Primera vez: crear e inicializar el modal
                window.MarketingModals.init({
                    id: CONFIG.MODAL_ID,
                    url: CONFIG.MODAL_URL,
                    delay: 0,
                    sessionKey: CONFIG.SESSION_KEY, // Guardar en sesión al abrir
                    isPreviewOnly: true
                });
            } else if (!modalElement.classList.contains('is-open')) {
                // Re-chequeo de anti-solapamiento justo antes de abrir
                if (document.querySelector('.marketing-modal.is-open')) return;

                // Modal ya existe pero está cerrado → reabrirlo (si la lógica de sesión lo permite)
                // Nota: Si queremos que sea ESTRICTAMENTE 1 vez por sesión, 
                // el return de arriba (sessionStorage.getItem) ya se encargó.
                
                const iframe = modalElement.querySelector('iframe');
                if (iframe) {
                    const separator = CONFIG.MODAL_URL.indexOf('?') !== -1 ? '&' : '?';
                    iframe.src = `${CONFIG.MODAL_URL}${separator}cb=${new Date().getTime()}`;
                }
                modalElement.classList.add('is-open');
                document.body.style.overflow = 'hidden';
                
                // Marcar como visto en sesión por si acaso no se marcó antes
                try { sessionStorage.setItem(CONFIG.SESSION_KEY, 'true'); } catch(e) {}
            }
        }, 2200);
    };

    // Escuchar cuando el usuario juega (postMessage desde el iframe)
    window.addEventListener('message', function(event) {
        const allowedOrigins = [
            'https://ruleta-signos.vercel.app',
            'https://probador-virtual-signosindumentaria.vercel.app'
        ];
        if (!allowedOrigins.includes(event.origin)) return;

        // Caso 1: Evento específico de tiro extra
        const isTiroExtraPlayed = event.data && event.data.type === 'tiroextra_played';
        
        // Caso 2: Evento de ruleta genérico pero el modal de tiro extra está abierto
        const isRuletaResult = event.data && event.data.type === 'ruleta_resultado';
        const isTiroExtraOpen = document.getElementById(CONFIG.MODAL_ID)?.classList.contains('is-open');

        // 1. Registro de jugada (para ocultar el banner de progreso)
        if (isTiroExtraPlayed || (isRuletaResult && isTiroExtraOpen)) {
            console.log('CartMarketing: Tiro Extra registrado como jugado.');
            try { 
                localStorage.setItem(CONFIG.PLAYED_KEY, Date.now().toString()); 
            } catch(e) {}
            hideBanner();
        }

        // 2. Cierre explícito (cuando el usuario cierra el premio en la ruleta)
        if (event.data && (event.data.type === 'tiroextra_close' || event.data.type === 'close_modal')) {
            if (isTiroExtraOpen) {
                console.log('CartMarketing: Cerrando modal por orden del iframe.');
                const m = document.getElementById(CONFIG.MODAL_ID);
                if (m) {
                    m.classList.remove('is-open');
                    document.body.style.overflow = '';
                }
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
