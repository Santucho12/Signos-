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
            isPreviewOnly = true,
            containerClass = 'ruleta-container'
        } = options;

        // 1. Validaciones iniciales
        if (document.getElementById(id)) return null;
        if (isPreviewOnly && !document.documentElement.classList.contains('redesign-preview')) return null;

        // 2. Creación de Estructura DOM
        const modal = document.createElement('div');
        modal.id = id;
        modal.classList.add('marketing-modal');
        
        const container = document.createElement('div');
        container.className = containerClass;

        const closeBtn = document.createElement('button');
        closeBtn.className = 'close-btn';
        closeBtn.innerHTML = '&#10005;';

        const iframe = document.createElement('iframe');
        iframe.src = 'about:blank';
        iframe.setAttribute('frameborder', '0');

        container.appendChild(closeBtn);
        container.appendChild(iframe);
        modal.appendChild(container);
        document.body.appendChild(modal);

        // 3. Funciones de Control
        const open = () => {
            iframe.src = url;
            modal.classList.add('is-open');
            document.body.style.overflow = 'hidden';
            console.log(`MarketingModal [${id}]: Opened`);
        };

        const close = () => {
            modal.classList.remove('is-open');
            document.body.style.overflow = '';
            setTimeout(() => {
                if (!modal.classList.contains('is-open')) {
                    iframe.src = 'about:blank';
                }
            }, 400);
            console.log(`MarketingModal [${id}]: Closed`);
        };

        // 4. Eventos
        closeBtn.onclick = (e) => {
            e.preventDefault();
            e.stopPropagation();
            close();
        };

        modal.onclick = (e) => {
            if (e.target === modal) {
                e.preventDefault();
                close();
            }
        };

        // 5. Lógica de Apertura Automática
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
