/**
 * COUPON COUNTDOWN SYSTEM (Self-contained — no external CSS needed)
 * Muestra un contador regresivo de 6 horas cuando el usuario gana un premio en la ruleta.
 * Los estilos se inyectan directamente desde este archivo para evitar problemas de carga.
 */

const CouponCountdown = (() => {
    const LS_KEY_EXPIRATION = 'ruleta_cupon_expiracion';
    const LS_KEY_CODE = 'ruleta_cupon_codigo';
    const SIX_HOURS_MS = 6 * 60 * 60 * 1000;
    
    let timerInterval = null;
    let countdownElement = null;
    let stylesInjected = false;

    // ── Inyectar estilos directamente en el <head> ──────────────
    const injectStyles = () => {
        if (stylesInjected) return;
        stylesInjected = true;

        const style = document.createElement('style');
        style.id = 'coupon-countdown-styles';
        style.textContent = `
            @keyframes slideUpCountdown {
                from { transform: translate(-50%, 100px); opacity: 0; }
                to { transform: translate(-50%, 0); opacity: 1; }
            }
            @keyframes pulseUrgency {
                from { text-shadow: 0 0 0px rgba(255, 77, 77, 0); }
                to { text-shadow: 0 0 10px rgba(255, 77, 77, 0.8); }
            }
            #coupon-countdown-bar {
                position: fixed !important;
                bottom: 30px !important;
                left: 50% !important;
                transform: translateX(-50%) !important;
                z-index: 10000000 !important;
                background: rgba(10, 10, 10, 0.92) !important;
                backdrop-filter: blur(12px) saturate(180%) !important;
                -webkit-backdrop-filter: blur(12px) saturate(180%) !important;
                padding: 10px 10px 10px 20px !important;
                border-radius: 100px !important;
                border: 1px solid rgba(255, 255, 255, 0.15) !important;
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.5), 0 0 0 1px rgba(255, 255, 255, 0.05) !important;
                display: flex !important;
                align-items: center !important;
                gap: 12px !important;
                font-family: 'Outfit', sans-serif !important;
                color: #fff !important;
                transition: all 0.5s cubic-bezier(0.19, 1, 0.22, 1) !important;
                animation: slideUpCountdown 0.8s cubic-bezier(0.19, 1, 0.22, 1) !important;
                max-width: 90vw !important;
                width: auto !important;
                visibility: visible !important;
                opacity: 1 !important;
                pointer-events: auto !important;
            }
            #coupon-countdown-bar.hide {
                transform: translate(-50%, 100px) !important;
                opacity: 0 !important;
            }
            #coupon-countdown-bar .countdown-content {
                display: flex !important;
                align-items: center !important;
                gap: 15px !important;
            }
            #coupon-countdown-bar .countdown-label {
                font-size: 10px !important;
                font-weight: 700 !important;
                letter-spacing: 1.5px !important;
                color: rgba(255, 255, 255, 0.6) !important;
                white-space: nowrap !important;
                transition: color 0.3s ease !important;
            }
            #coupon-countdown-bar .countdown-timer {
                font-family: 'Blunt Semiconit', monospace !important;
                font-size: 18px !important;
                font-weight: 400 !important;
                color: #fff !important;
                min-width: 85px !important;
                text-align: center !important;
                letter-spacing: 1px !important;
            }
            #coupon-countdown-bar .countdown-timer.urgent {
                color: #ff4d4d !important;
                animation: pulseUrgency 1s infinite alternate !important;
            }
            #coupon-countdown-bar .countdown-divider {
                width: 1px !important;
                height: 24px !important;
                background: rgba(255, 255, 255, 0.15) !important;
            }
            #coupon-countdown-bar .countdown-coupon {
                background: #fff !important;
                color: #000 !important;
                padding: 8px 16px !important;
                border-radius: 50px !important;
                display: flex !important;
                align-items: center !important;
                gap: 8px !important;
                cursor: pointer !important;
                font-weight: 700 !important;
                font-size: 14px !important;
                transition: all 0.3s ease !important;
                box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2) !important;
            }
            #coupon-countdown-bar .countdown-coupon:hover {
                transform: translateY(-2px) !important;
                box-shadow: 0 6px 20px rgba(255, 255, 255, 0.3) !important;
                background: #f0f0f0 !important;
            }
            #coupon-countdown-bar .coupon-code {
                letter-spacing: 0.5px !important;
            }
            #coupon-countdown-bar .copy-icon {
                display: flex !important;
                align-items: center !important;
                opacity: 0.5 !important;
            }
            #coupon-countdown-bar .countdown-close {
                background: rgba(255, 255, 255, 0.1) !important;
                border: none !important;
                color: #fff !important;
                width: 28px !important;
                height: 28px !important;
                border-radius: 50% !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                cursor: pointer !important;
                font-size: 18px !important;
                transition: all 0.3s ease !important;
                line-height: 1 !important;
                padding: 0 !important;
            }
            #coupon-countdown-bar .countdown-close:hover {
                background: rgba(255, 255, 255, 0.2) !important;
                transform: rotate(90deg) !important;
            }
            @media (max-width: 768px) {
                #coupon-countdown-bar {
                    bottom: 20px !important;
                    padding: 8px 8px 8px 15px !important;
                    gap: 8px !important;
                }
                #coupon-countdown-bar .countdown-content {
                    gap: 8px !important;
                }
                #coupon-countdown-bar .countdown-label {
                    font-size: 8px !important;
                    letter-spacing: 1px !important;
                }
                #coupon-countdown-bar .countdown-timer {
                    font-size: 15px !important;
                    min-width: 70px !important;
                }
                #coupon-countdown-bar .countdown-coupon {
                    padding: 6px 12px !important;
                    font-size: 12px !important;
                }
                #coupon-countdown-bar .countdown-divider {
                    height: 18px !important;
                }
            }
        `;
        document.head.appendChild(style);
        console.log('CouponCountdown: Estilos inyectados en <head>.');
    };

    // ── Inicialización ──────────────────────────────────────────
    const init = () => {
        console.log('CouponCountdown: Inicializando sistema...');

        // 1. Escuchar mensajes de la ruleta (postMessage desde el iframe)
        window.addEventListener('message', (event) => {
            const allowedOrigins = [
                'https://ruleta-signos.vercel.app',
                'https://probador-virtual-signosindumentaria.vercel.app'
            ];
            if (!allowedOrigins.includes(event.origin)) return;

            if (event.data && event.data.type === 'ruleta_resultado') {
                const { premio, codigo } = event.data;
                console.log('CouponCountdown: Mensaje recibido de la ruleta. Premio: ' + premio + ', Código: ' + codigo);
                
                // Si el premio es válido (no es "Suerte la próxima" o similar)
                if (codigo && premio && !premio.toLowerCase().includes('suerte')) {
                    console.log('CouponCountdown: ¡Premio válido! Guardando y mostrando contador.');
                    var expiration = Date.now() + SIX_HOURS_MS;
                    localStorage.setItem(LS_KEY_EXPIRATION, expiration.toString());
                    localStorage.setItem(LS_KEY_CODE, codigo);
                    
                    // Esperar 8.5 segundos para no arruinar la sorpresa de la animación
                    setTimeout(() => {
                        showCountdown(expiration, codigo);
                    }, 8500);
                } else {
                    console.log('CouponCountdown: Premio no válido ("Suerte la próxima" o sin código). Ignorando.');
                }
            }
        });

        // 2. Verificar si ya hay un cupón activo al cargar la página
        var savedExpiration = localStorage.getItem(LS_KEY_EXPIRATION);
        var savedCode = localStorage.getItem(LS_KEY_CODE);

        if (savedExpiration && savedCode) {
            var now = Date.now();
            if (now < parseInt(savedExpiration)) {
                console.log('CouponCountdown: Cupón activo encontrado. Código: ' + savedCode + '. Mostrando barra.');
                showCountdown(parseInt(savedExpiration), savedCode);
            } else {
                console.log('CouponCountdown: El cupón guardado ya expiró. Limpiando.');
                localStorage.removeItem(LS_KEY_EXPIRATION);
                localStorage.removeItem(LS_KEY_CODE);
            }
        } else {
            console.log('CouponCountdown: No hay cupones activos. Esperando a que el usuario juegue la ruleta.');
        }
    };

    // ── Mostrar la barra flotante ───────────────────────────────
    const showCountdown = (expiration, code) => {
        if (countdownElement) {
            console.log('CouponCountdown: La barra ya está visible. No se creará otra.');
            return;
        }

        // Inyectar estilos antes de crear el elemento
        injectStyles();

        console.log('CouponCountdown: Creando barra flotante con código ' + code);
        
        // Crear contenedor
        countdownElement = document.createElement('div');
        countdownElement.id = 'coupon-countdown-bar';
        countdownElement.innerHTML = 
            '<div class="countdown-content">' +
                '<span class="countdown-label">¡TU PREMIO EXPIRA EN!</span>' +
                '<div class="countdown-timer" id="countdown-timer-val">06:00:00</div>' +
                '<div class="countdown-divider"></div>' +
                '<div class="countdown-coupon" id="countdown-copy-trigger">' +
                    '<span class="coupon-code">' + code + '</span>' +
                    '<span class="copy-icon">' +
                        '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>' +
                    '</span>' +
                '</div>' +
            '</div>' +
            '<button class="countdown-close" id="countdown-close-btn">&times;</button>';

        document.body.appendChild(countdownElement);
        console.log('CouponCountdown: Barra inyectada en el DOM. Debería ser visible ahora.');

        // Evento para copiar el código
        var copyTrigger = document.getElementById('countdown-copy-trigger');
        if (copyTrigger) {
            copyTrigger.onclick = function() {
                navigator.clipboard.writeText(code).then(function() {
                    var label = countdownElement.querySelector('.countdown-label');
                    if (label) {
                        var originalText = label.innerText;
                        label.innerText = '¡CUPÓN COPIADO!';
                        label.style.color = '#4ade80';
                        console.log('CouponCountdown: Código copiado al portapapeles.');
                        setTimeout(function() {
                            label.innerText = originalText;
                            label.style.color = '';
                        }, 2000);
                    }
                }).catch(function(err) {
                    console.warn('CouponCountdown: No se pudo copiar, intentando fallback...', err);
                    // Fallback para navegadores que no soportan clipboard API
                    var ta = document.createElement('textarea');
                    ta.value = code;
                    ta.style.position = 'fixed';
                    ta.style.left = '-9999px';
                    document.body.appendChild(ta);
                    ta.select();
                    document.execCommand('copy');
                    document.body.removeChild(ta);
                });
            };
        }

        // Evento para cerrar
        var closeBtn = document.getElementById('countdown-close-btn');
        if (closeBtn) {
            closeBtn.onclick = function() {
                console.log('CouponCountdown: El usuario cerró la barra.');
                countdownElement.classList.add('hide');
                setTimeout(function() {
                    if (countdownElement) {
                        countdownElement.remove();
                        countdownElement = null;
                    }
                    clearInterval(timerInterval);
                }, 500);
            };
        }

        // Actualizar timer inmediatamente y luego cada segundo
        updateTimer(expiration);
        timerInterval = setInterval(function() { updateTimer(expiration); }, 1000);
    };

    // ── Actualizar el reloj ─────────────────────────────────────
    const updateTimer = (expiration) => {
        var now = Date.now();
        var distance = expiration - now;

        if (distance < 0) {
            console.log('CouponCountdown: ¡Tiempo expirado! Removiendo barra.');
            clearInterval(timerInterval);
            if (countdownElement) {
                countdownElement.remove();
                countdownElement = null;
            }
            localStorage.removeItem(LS_KEY_EXPIRATION);
            localStorage.removeItem(LS_KEY_CODE);
            return;
        }

        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        var timerVal = document.getElementById('countdown-timer-val');
        if (timerVal) {
            timerVal.innerText = 
                String(hours).padStart(2, '0') + ":" + 
                String(minutes).padStart(2, '0') + ":" + 
                String(seconds).padStart(2, '0');
            
            // Efecto de urgencia cuando queda menos de 1 hora
            if (distance < 60 * 60 * 1000) {
                timerVal.classList.add('urgent');
            }
        }
    };

    // ── Función de prueba (usar desde la consola del navegador) ──
    const testSimulateWin = (codigoPrueba) => {
        codigoPrueba = codigoPrueba || 'TEST15OFF';
        console.log('CouponCountdown: SIMULANDO premio con código ' + codigoPrueba + '...');
        var expiration = Date.now() + SIX_HOURS_MS;
        localStorage.setItem(LS_KEY_EXPIRATION, expiration.toString());
        localStorage.setItem(LS_KEY_CODE, codigoPrueba);
        showCountdown(expiration, codigoPrueba);
    };

    return { init: init, testSimulateWin: testSimulateWin };
})();

// Exponer globalmente para pruebas desde la consola
if (typeof window !== 'undefined') {
    window.CouponCountdown = CouponCountdown;
}

// Auto-iniciar
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() { CouponCountdown.init(); });
} else {
    CouponCountdown.init();
}
