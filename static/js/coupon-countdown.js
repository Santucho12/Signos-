/**
 * MULTI-COUPON COUNTDOWN SYSTEM
 * Permite gestionar múltiples cupones ganados simultáneamente.
 * Los cupones se apilan en la esquina superior izquierda.
 */

const CouponCountdown = (() => {
    const LS_KEY_DATA = 'ruleta_cupones_data'; // Nuevo formato: Array de objetos
    const SIX_HOURS_MS = 6 * 60 * 60 * 1000;
    
    let coupons = [];
    let stylesInjected = false;
    let containerElement = null;
    let timerInterval = null;

    // ── Inyectar estilos ────────────────────────────────────────
    const injectStyles = () => {
        if (stylesInjected) return;
        stylesInjected = true;

        const style = document.createElement('style');
        style.id = 'coupon-countdown-styles';
        style.textContent = `
            @keyframes slideInCoupon {
                from { transform: translateX(-50px); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            #coupon-stack-container {
                position: fixed !important;
                top: 20px !important;
                left: 20px !important;
                z-index: 9999 !important;
                display: flex !important;
                flex-direction: column !important;
                gap: 12px !important;
                pointer-events: none !important;
                max-width: 350px !important;
            }
            .coupon-countdown-bar {
                background: rgba(10, 10, 10, 0.92) !important;
                backdrop-filter: blur(12px) saturate(180%) !important;
                -webkit-backdrop-filter: blur(12px) saturate(180%) !important;
                padding: 10px 10px 10px 20px !important;
                border-radius: 100px !important;
                border: 1px solid rgba(255, 255, 255, 0.15) !important;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4) !important;
                display: flex !important;
                align-items: center !important;
                gap: 12px !important;
                font-family: 'Outfit', sans-serif !important;
                color: #fff !important;
                pointer-events: auto !important;
                animation: slideInCoupon 0.5s cubic-bezier(0.19, 1, 0.22, 1) forwards !important;
                transition: all 0.3s ease !important;
            }
            .coupon-countdown-bar.hide {
                transform: translateX(-100%) !important;
                opacity: 0 !important;
            }
            .coupon-countdown-bar .countdown-content {
                display: flex !important;
                align-items: center !important;
                gap: 15px !important;
            }
            .coupon-countdown-bar .countdown-label {
                font-size: 9px !important;
                font-weight: 700 !important;
                letter-spacing: 1px !important;
                color: rgba(255, 255, 255, 0.5) !important;
                white-space: nowrap !important;
            }
            .coupon-countdown-bar .countdown-timer {
                font-variant-numeric: tabular-nums !important;
                font-size: 16px !important;
                font-weight: 600 !important;
                min-width: 75px !important;
                text-align: center !important;
            }
            .coupon-countdown-bar .countdown-timer.urgent {
                color: #ff4d4d !important;
            }
            .coupon-countdown-bar .countdown-divider {
                width: 1px !important;
                height: 20px !important;
                background: rgba(255, 255, 255, 0.15) !important;
            }
            .coupon-countdown-bar .countdown-coupon {
                background: #fff !important;
                color: #000 !important;
                padding: 4px 10px !important;
                border-radius: 50px !important;
                display: flex !important;
                align-items: center !important;
                gap: 5px !important;
                cursor: pointer !important;
                font-weight: 800 !important;
                font-size: 10px !important;
                transition: all 0.3s ease !important;
            }
            .coupon-countdown-bar .countdown-coupon:hover {
                background: #f0f0f0 !important;
                transform: scale(1.05) !important;
            }
            .coupon-countdown-bar .countdown-close {
                background: rgba(255, 255, 255, 0.1) !important;
                border: none !important;
                color: #fff !important;
                width: 26px !important;
                height: 26px !important;
                border-radius: 50% !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                cursor: pointer !important;
                font-size: 16px !important;
                transition: all 0.3s ease !important;
                padding: 0 !important;
            }
            .coupon-countdown-bar .countdown-close:hover {
                background: rgba(255, 255, 255, 0.2) !important;
                transform: rotate(90deg) !important;
            }

            @media (max-width: 768px) {
                #coupon-stack-container {
                    top: 95px !important; /* Bajado extra para despejar totalmente el menú hamburguesa */
                    left: 10px !important;
                    gap: 4px !important;
                }
                .coupon-countdown-bar {
                    padding: 3px 6px !important;
                    min-width: 160px !important; /* 30% más pequeña aprox */
                }
                .coupon-countdown-bar .countdown-label {
                    font-size: 7px !important;
                }
                .coupon-countdown-bar .countdown-timer {
                    font-size: 9px !important;
                    min-width: 50px !important;
                }
                .coupon-countdown-bar .countdown-coupon {
                    padding: 2px 5px !important;
                    font-size: 7px !important;
                    gap: 3px !important;
                }
                .coupon-countdown-bar .countdown-divider {
                    height: 12px !important;
                }
                .coupon-countdown-bar .countdown-close {
                    width: 16px !important;
                    height: 16px !important;
                    font-size: 10px !important;
                }
            }
        `;
        document.head.appendChild(style);
    };

    // ── Lógica de Datos ────────────────────────────────────────
    const loadCoupons = () => {
        console.log('CouponCountdown: Cargando cupones...');
        try {
            // 1. Intentar cargar el formato nuevo (Array)
            const data = localStorage.getItem(LS_KEY_DATA);
            if (data) {
                const parsed = JSON.parse(data);
                const now = Date.now();
                coupons = parsed.filter(c => c.expiration > now);
            }

            // 2. MIGRACIÓN: Verificar si hay un cupón del formato viejo
            const oldCode = localStorage.getItem('ruleta_cupon_codigo');
            const oldExp = localStorage.getItem('ruleta_cupon_expiracion');
            
            if (oldCode && oldExp) {
                const now = Date.now();
                const expTime = parseInt(oldExp);
                if (expTime > now && !coupons.some(c => c.code === oldCode)) {
                    console.log('CouponCountdown: Migrando cupón viejo encontrado:', oldCode);
                    coupons.push({ code: oldCode, expiration: expTime });
                    // Limpiar viejos para que no se repita
                    localStorage.removeItem('ruleta_cupon_codigo');
                    localStorage.removeItem('ruleta_cupon_expiracion');
                }
            }
            
            saveCoupons();
        } catch (e) {
            console.error('CouponCountdown: Error cargando datos', e);
            coupons = [];
        }
    };

    const saveCoupons = () => {
        localStorage.setItem(LS_KEY_DATA, JSON.stringify(coupons));
    };

    const addCoupon = (code, expiration) => {
        // Evitar duplicados del mismo código
        if (coupons.some(c => c.code === code)) return;
        
        coupons.push({ code, expiration });
        saveCoupons();
        render();
    };

    const removeCoupon = (code) => {
        coupons = coupons.filter(c => c.code !== code);
        saveCoupons();
        render();
    };

    // ── Interfaz ────────────────────────────────────────────────
    const createContainer = () => {
        if (containerElement) return;
        containerElement = document.createElement('div');
        containerElement.id = 'coupon-stack-container';
        document.body.appendChild(containerElement);
    };

    const render = () => {
        injectStyles();
        createContainer();
        
        containerElement.innerHTML = '';
        
        if (coupons.length === 0) {
            if (timerInterval) clearInterval(timerInterval);
            return;
        }

        coupons.forEach(coupon => {
            const bar = document.createElement('div');
            bar.className = 'coupon-countdown-bar';
            bar.dataset.code = coupon.code;
            
            bar.innerHTML = `
                <div class="countdown-content">
                    <span class="countdown-label">EXPIRA EN:</span>
                    <span class="countdown-timer js-timer-${coupon.code.replace(/[^a-z0-9]/gi, '')}">00:00:00</span>
                    <div class="countdown-divider"></div>
                    <div class="countdown-coupon" title="Copiar código">
                        <span class="coupon-code">COPIAR CUPÓN</span>
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                    </div>
                </div>
                <button class="countdown-close">&times;</button>
            `;

            // Evento Copiar
            bar.querySelector('.countdown-coupon').onclick = () => {
                navigator.clipboard.writeText(coupon.code).then(() => {
                    if (typeof toast !== 'undefined') toast.success('Cupón copiado al portapapeles');
                    const timer = bar.querySelector('.countdown-timer');
                    const originalText = timer.innerText;
                    timer.innerText = '¡COPIADO!';
                    timer.style.color = '#4ade80';
                    setTimeout(() => {
                        timer.innerText = originalText;
                        timer.style.color = '';
                    }, 2000);
                });
            };

            // Evento Cerrar
            bar.querySelector('.countdown-close').onclick = () => {
                bar.classList.add('hide');
                setTimeout(() => removeCoupon(coupon.code), 400);
            };

            containerElement.appendChild(bar);
        });

        // Iniciar timers si no están corriendo
        if (!timerInterval) {
            timerInterval = setInterval(updateAllTimers, 1000);
        }
        updateAllTimers();
    };

    const updateAllTimers = () => {
        const now = Date.now();
        let anyExpired = false;

        coupons.forEach(coupon => {
            const distance = coupon.expiration - now;
            const safeCode = coupon.code.replace(/[^a-z0-9]/gi, '');
            const timerEl = document.querySelector(`.js-timer-${safeCode}`);

            if (distance < 0) {
                anyExpired = true;
                return;
            }

            if (timerEl) {
                const hours = Math.floor(distance / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                timerEl.innerText = 
                    String(hours).padStart(2, '0') + ":" + 
                    String(minutes).padStart(2, '0') + ":" + 
                    String(seconds).padStart(2, '0');

                if (distance < 3600000) timerEl.classList.add('urgent');
            }
        });

        if (anyExpired) {
            coupons = coupons.filter(c => c.expiration > now);
            saveCoupons();
            render();
        }
    };

    // ── API Pública ─────────────────────────────────────────────
    const init = () => {
        console.log('CouponCountdown: Inicializando sistema multi-cupón V3...');
        
        loadCoupons();
        render();

        // Escuchar nuevos premios
        window.addEventListener('message', (event) => {
            const allowedOrigins = [
                'https://ruleta-signos.vercel.app',
                'https://probador-virtual-signosindumentaria.vercel.app'
            ];
            if (!allowedOrigins.includes(event.origin)) return;

            if (event.data) {
                const type = event.data.type;
                const d = event.data;
                console.log(`CouponCountdown: [DEBUG] Mensaje: ${type}`, d);

                if (type === 'ruleta_resultado' || type === 'tiroextra_resultado') {
                    const code = d.codigo || d.code || d.coupon;
                    const prize = d.premio || d.prize || d.discount || d.text;
                    
                    console.log(`CouponCountdown: [DEBUG] Procesando -> Code: ${code}, Prize: ${prize}`);

                    if (code && prize && !prize.toLowerCase().includes('suerte')) {
                        console.log('CouponCountdown: ¡Premio detectado y validado!');
                        // Delay de 8s para que coincida con el final de la animación de la ruleta
                        setTimeout(() => {
                            addCoupon(code, Date.now() + SIX_HOURS_MS);
                        }, 8000);
                    } else {
                        console.warn('CouponCountdown: El mensaje no pasó la validación (falta código o es un "seguí participando")');
                    }
                }
            }
        });

        // Sincronizar entre pestañas (si el usuario gana en otra ventana o refresca)
        window.addEventListener('storage', (event) => {
            if (event.key === LS_KEY_DATA) {
                console.log('CouponCountdown: Sincronizando datos desde otra pestaña...');
                loadCoupons();
                render();
            }
        });

        // Re-mostrar al volver a la pestaña
        document.addEventListener('visibilitychange', () => {
            if (!document.hidden) {
                loadCoupons();
                render();
            }
        });
    };

    return { init, addCoupon };
})();

// Auto-inicializar
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', CouponCountdown.init);
} else {
    CouponCountdown.init();
}
