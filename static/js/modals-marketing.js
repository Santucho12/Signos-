/**
 * MARKETING MODALS SYSTEM
 * Utilidad para manejar popups de marketing (ruletas, probadores, etc.)
 * con soporte para auto-apertura, sesión y gating de preview.
 */

window.MarketingModals = {
    /**
     * Crea e inicializa un modal de marketing
     * @param {Object} options 
     */
    init: function(options) {
        const {
            id,
            url,
            delay = 3000,
            sessionKey = null,
            isPreviewOnly = false,
            containerClass = 'ruleta-container'
        } = options;

        // 1. Validaciones iniciales
        if (document.getElementById(id)) return null;

        // 2. Creación de Estructura DOM
        const modal = document.createElement('div');
        modal.id = id;
        modal.classList.add('marketing-modal');
        
        const container = document.createElement('div');
        container.className = containerClass;

        const closeBtn = document.createElement('button');
        closeBtn.className = 'close-btn';
        closeBtn.innerHTML = '&times;';

        const reloadBtn = document.createElement('button');
        reloadBtn.className = 'reload-btn';
        reloadBtn.title = 'Recargar ruleta';
        reloadBtn.innerHTML = `
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <path d="M23 4v6h-6"></path>
                <path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"></path>
            </svg>
        `;

        const iframe = document.createElement('iframe');
        iframe.src = 'about:blank';
        iframe.setAttribute('frameborder', '0');
        // Permisos extendidos para el portapapeles
        iframe.setAttribute('allow', 'clipboard-read; clipboard-write');

        container.appendChild(closeBtn);
        container.appendChild(reloadBtn);
        container.appendChild(iframe);
        modal.appendChild(container);
        document.body.appendChild(modal);

        // 3. Funciones de Control
        const open = () => {
            // Agregar un cache-buster para evitar el error de "respuesta no válida"
            const separator = url.indexOf('?') !== -1 ? '&' : '?';
            const freshUrl = `${url}${separator}cb=${new Date().getTime()}`;
            
            iframe.src = freshUrl;
            modal.classList.add('is-open');
            document.body.style.overflow = 'hidden';

            // Mostrar botón de recarga inmediatamente
            reloadBtn.style.opacity = '1';
            reloadBtn.style.visibility = 'visible';

            console.log(`MarketingModal [${id}]: Opened with URL ${freshUrl}`);
        };

        const reload = () => {
            console.log(`MarketingModal [${id}]: Reloading...`);
            const separator = url.indexOf('?') !== -1 ? '&' : '?';
            const freshUrl = `${url}${separator}cb=${new Date().getTime()}`;
            iframe.src = freshUrl;
        };

        const close = (reason = 'unknown') => {
            console.trace(`MarketingModal [${id}]: close() llamado. Razón: ${reason}`);
            modal.classList.remove('is-open');
            document.body.style.overflow = '';
            // No limpiamos el src inmediatamente para evitar parpadeos blancos, 
            // solo si el modal permanece cerrado.
            setTimeout(() => {
                if (!modal.classList.contains('is-open')) {
                    iframe.src = 'about:blank';
                }
            }, 500);
            console.log(`MarketingModal [${id}]: Closed`);
        };

        // 5. Comunicación con el Iframe (para copiado de cupones)
        const messageHandler = (event) => {
            const allowedOrigins = [
                'https://ruleta-signos.vercel.app',
                'https://probador-virtual-signosindumentaria.vercel.app'
            ];
            if (!allowedOrigins.includes(event.origin)) return;
            
            if (event.data && event.data.type === 'copy' && event.data.text) {
                navigator.clipboard.writeText(event.data.text).then(() => {
                    console.log('MarketingModals: Texto copiado desde el parent window');
                }).catch(err => {
                    console.error('MarketingModals: Error al copiar desde el parent', err);
                });
            } else if (event.data && event.data.type === 'close_modal') {
                // Si el iframe explícitamente pide cerrar
                close('iframe_postmessage');
            }
        };
        window.addEventListener('message', messageHandler);

        // 6. Eventos de cierre y recarga
        closeBtn.onclick = (e) => {
            e.preventDefault();
            e.stopPropagation();
            close('close_button_clicked');
        };

        reloadBtn.onclick = (e) => {
            e.preventDefault();
            e.stopPropagation();
            reload();
        };

        modal.onclick = (e) => {
            if (e.target === modal) {
                e.preventDefault();
                close('backdrop_clicked');
            }
        };

        // 5. Lógica de Apertura Automática y Despertado (Warm-up)
        // Intentar despertar el servidor apenas se inicializa el script
        console.log(`MarketingModal [${id}]: Waking up server at ${url}...`);
        fetch(url, { mode: 'no-cors' }).catch(() => {});

        if (delay >= 0) {
            const hasBeenSeen = sessionKey ? sessionStorage.getItem(sessionKey) : false;
            
            if (!hasBeenSeen) {
                setTimeout(() => {
                    open();
                    if (sessionKey) sessionStorage.setItem(sessionKey, 'true');
                }, delay);
            }
        }

        // Retornar instancia para control manual si es necesario
        return { open, close, element: modal };
    }
};
