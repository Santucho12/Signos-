/**
 * Cart Notes Auto-Fill - Amazonas/Modern Version
 * Maneja la inyección de premios incluso en temas con modales (como Amazonas).
 */

const CartNotes = (() => {
    const LS_KEY = 'ruleta_premio_nota';
    
    const init = () => {
        // 1. Escuchar mensajes de las ruletas
        window.addEventListener('message', (event) => {
            const allowedOrigins = [
                'https://ruleta-signos.vercel.app',
                'https://probador-virtual-signosindumentaria.vercel.app'
            ];
            if (!allowedOrigins.includes(event.origin)) return;

            if (event.data && event.data.type === 'ruleta_resultado') {
                const { premio, codigo } = event.data;
                if (premio && premio !== 'Suerte la próxima') {
                    const mensaje = `🎁 PREMIO RULETA: Ganó "${premio}" con el cupón [${codigo}]`;
                    
                    let premiosPrevios = localStorage.getItem(LS_KEY) || "";
                    if (!premiosPrevios.includes(codigo)) {
                        const nuevoMensaje = premiosPrevios 
                            ? premiosPrevios + "\n" + mensaje 
                            : mensaje;
                        localStorage.setItem(LS_KEY, nuevoMensaje);
                        console.log('CartNotes: Premio guardado en persistencia.');
                    }
                }
            }
        });

        // 2. Ejecutar carga inicial y observar el DOM (MutationObserver)
        checkAndFillNote();
        setupObserver();
    };

    const checkAndFillNote = () => {
        const mensaje = localStorage.getItem(LS_KEY);
        if (!mensaje) return;

        // Selectores específicos para Amazonas y temas modernos
        const noteSelectors = [
            'textarea[name="note"]',
            'textarea.js-cart-note',
            '.js-cart-note-textarea',
            '#cart-note',
            '.cart-note-container textarea'
        ];

        let noteField = null;
        for (const selector of noteSelectors) {
            noteField = document.querySelector(selector);
            if (noteField) break;
        }

        if (noteField) {
            // Si el campo existe (aunque esté en un modal recién abierto)
            if (!noteField.value.includes('PREMIO RULETA')) {
                const separator = noteField.value.trim() ? '\n\n' : '';
                noteField.value = noteField.value + separator + mensaje;
                
                // Disparar eventos para que Tiendanube detecte el cambio
                noteField.dispatchEvent(new Event('input', { bubbles: true }));
                noteField.dispatchEvent(new Event('change', { bubbles: true }));
                
                console.log('CartNotes: Nota inyectada con éxito.');
            }
        }
    };

    const setupObserver = () => {
        // Observamos el body para detectar cuando se abre el modal de notas
        const observer = new MutationObserver((mutations) => {
            for (const mutation of mutations) {
                if (mutation.addedNodes.length) {
                    checkAndFillNote();
                }
            }
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    };

    return { init };
})();

// Iniciar sistema
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => CartNotes.init());
} else {
    CartNotes.init();
}
