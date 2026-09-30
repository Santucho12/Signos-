{#/*============================================================================
  #Lista de Participantes y Equipos - Signos Indumentaria
  Área Privada protegida con Contraseña y visualizador conectado a Supabase
==============================================================================*/#}

<div id="sgns-participantes-root" class="sgns-part-page">
    {# Glow ambiental de fondo #}
    <div class="sgns-part-glow"></div>

    {# 1. PANTALLA DE ACCESO RESTRINGIDO (GATE DE CONTRASEÑA) #}
    <div id="sgnsAuthGate" class="sgns-auth-gate">
        <div class="sgns-auth-card">
            <div class="sgns-auth-brand">
                <img src="{{ 'images/logo final monograma blanco_Mesa de trabajo 1_Mesa de trabajo 1.png' | static_url }}" alt="Signos Indumentaria" class="sgns-auth-logo">
            </div>
            
            <div class="sgns-lock-icon-wrap">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
            </div>

            <span class="sgns-part-badge sgns-badge-private">ÁREA PRIVADA</span>
            <h2 class="sgns-auth-title">ACCESO RESTRINGIDO</h2>
            <p class="sgns-auth-subtitle">Ingresá la clave de acceso autorizada para visualizar la lista oficial de equipos y participantes.</p>

            <form id="sgnsAuthForm" class="sgns-auth-form" novalidate autocomplete="off">
                <div class="sgns-auth-field">
                    <div class="sgns-auth-input-wrap">
                        <svg class="sgns-key-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M21 2l-2 2m-1.5 1.5L14 9l-1.5-1.5L11 9l-1.5-1.5L8 9l-1.5-1.5L5 9a7 7 0 1 0 10 10l9-9-3-3z"></path>
                        </svg>
                        <input type="password" id="sgnsPasswordInput" class="sgns-auth-input" placeholder="Ingresá la contraseña..." autocomplete="current-password" autofocus required>
                        <button type="button" id="sgnsTogglePass" class="sgns-pass-toggle" title="Mostrar/Ocultar contraseña" aria-label="Mostrar/Ocultar contraseña">
                            <svg id="eyeOpenIcon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                            <svg id="eyeClosedIcon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: none;">
                                <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                                <line x1="1" y1="1" x2="23" y2="23"></line>
                            </svg>
                        </button>
                    </div>
                    <div id="sgnsAuthError" class="sgns-auth-error-msg" style="display: none;">
                        Contraseña incorrecta. Por favor verificá e intentá nuevamente.
                    </div>
                </div>

                <button type="submit" id="sgnsAuthBtn" class="sgns-auth-submit-btn">
                    <span>INGRESAR AL PANEL</span>
                </button>
            </form>
        </div>
    </div>

    {# 2. CONTENIDO PROTEGIDO (SOLO SE MUESTRA TRAS INGRESAR LA CONTRASEÑA CORRECTA) #}
    <div id="sgnsAuthContent" class="sgns-part-container" style="display: none;">
        
        {# Encabezado #}
        <div class="sgns-part-header">
            <div class="sgns-part-brand">
                <a href="/" title="Signos Indumentaria">
                    <img src="{{ 'images/logo final monograma blanco_Mesa de trabajo 1_Mesa de trabajo 1.png' | static_url }}" alt="Signos Indumentaria" class="sgns-part-logo">
                </a>
            </div>
            <div class="sgns-badge-group">
                <span class="sgns-part-badge">TORNEO EXCLUSIVO</span>
                <span class="sgns-part-badge sgns-badge-live">EN VIVO</span>
            </div>
            <h1 class="sgns-part-title">EQUIPOS Y PARTICIPANTES</h1>
            <p class="sgns-part-subtitle">Nómina oficial de equipos registrados para la competencia</p>

            {# Bloque Fecha y Horario #}
            <div class="sgns-part-datetime">
                <div class="sgns-dt-item">
                    <svg class="sgns-dt-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                    <span>DOMINGO 4/10</span>
                </div>
                <span class="sgns-dt-separator"></span>
                <div class="sgns-dt-item">
                    <svg class="sgns-dt-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 16 14"></polyline>
                    </svg>
                    <span>12:00 HS</span>
                </div>
            </div>

            {# Botones de Acción #}
            <div class="sgns-header-actions">
                <a href="/registroevento" class="sgns-action-btn sgns-btn-primary">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    <span>INSCRIBIR EQUIPO</span>
                </a>
                <button type="button" id="sgnsRefreshBtn" class="sgns-action-btn sgns-btn-secondary" title="Actualizar datos">
                    <svg id="refreshIcon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M23 4v6h-6"></path>
                        <path d="M1 20v-6h6"></path>
                        <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
                    </svg>
                    <span>ACTUALIZAR</span>
                </button>
                <button type="button" id="sgnsExportBtn" class="sgns-action-btn sgns-btn-secondary" title="Descargar en Excel">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                        <polyline points="7 10 12 15 17 10"></polyline>
                        <line x1="12" y1="15" x2="12" y2="3"></line>
                    </svg>
                    <span>DESCARGAR EN EXCEL</span>
                </button>
            </div>
        </div>

        {# Tarjetas de Métricas / Resumen #}
        <div class="sgns-stats-grid">
            <div class="sgns-stat-card">
                <span class="sgns-stat-label">INSCRIPCIONES</span>
                <span class="sgns-stat-val" id="statTotalEquipos">0</span>
            </div>
            <div class="sgns-stat-card">
                <span class="sgns-stat-label">TOTAL JUGADORES</span>
                <span class="sgns-stat-val" id="statTotalJugadores">0</span>
            </div>
            <div class="sgns-stat-card">
                <span class="sgns-stat-label">FÚTBOL</span>
                <span class="sgns-stat-val" id="statFutbol">0</span>
            </div>
            <div class="sgns-stat-card">
                <span class="sgns-stat-label">BÁSQUET</span>
                <span class="sgns-stat-val" id="statBasquet">0</span>
            </div>
            <div class="sgns-stat-card">
                <span class="sgns-stat-label">PING PONG</span>
                <span class="sgns-stat-val" id="statPingPong">0</span>
            </div>
        </div>

        {# Barra de Filtros y Búsqueda #}
        <div class="sgns-toolbar">
            <div class="sgns-search-box">
                <svg class="sgns-search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <input type="text" id="sgnsSearchInput" class="sgns-search-input" placeholder="Buscar por equipo, participante..." autocomplete="off">
                <button type="button" id="sgnsClearSearch" class="sgns-clear-btn" style="display: none;">&times;</button>
            </div>

            <div class="sgns-filter-pills">
                <button type="button" class="sgns-pill active" data-filter="all">Todos</button>
                <button type="button" class="sgns-pill" data-filter="Fútbol">⚽ Fútbol</button>
                <button type="button" class="sgns-pill" data-filter="Básquet">🏀 Básquet</button>
                <button type="button" class="sgns-pill" data-filter="Ping Pong">🏓 Ping Pong</button>
            </div>
        </div>

        {# Contenedor Principal de la Tabla #}
        <div class="sgns-table-wrapper">
            
            {# Estado de Carga #}
            <div id="sgnsLoadingState" class="sgns-state-view">
                <div class="sgns-spinner"></div>
                <p>Cargando registros desde la base de datos...</p>
            </div>

            {# Estado de Error #}
            <div id="sgnsErrorState" class="sgns-state-view" style="display: none;">
                <div class="sgns-state-icon">⚠️</div>
                <h3 class="sgns-state-title">No se pudieron cargar los registros</h3>
                <p id="sgnsErrorMessage" class="sgns-state-desc">Ocurrió un inconveniente al conectar con Supabase.</p>
                <button type="button" id="sgnsRetryBtn" class="sgns-action-btn sgns-btn-secondary" style="margin-top: 12px;">
                    REINTENTAR
                </button>
            </div>

            {# Estado Vacío #}
            <div id="sgnsEmptyState" class="sgns-state-view" style="display: none;">
                <div class="sgns-state-icon">📋</div>
                <h3 class="sgns-state-title">Aún no hay equipos inscriptos</h3>
                <p class="sgns-state-desc">Sé el primero en registrar a tu equipo de 3 integrantes para el torneo.</p>
                <a href="/registroevento" class="sgns-action-btn sgns-btn-primary" style="margin-top: 14px;">
                    REGISTRAR PRIMER EQUIPO
                </a>
            </div>

            {# Estado Sin Resultados de Búsqueda #}
            <div id="sgnsNoResultsState" class="sgns-state-view" style="display: none;">
                <div class="sgns-state-icon">🔍</div>
                <h3 class="sgns-state-title">Sin resultados coincidentes</h3>
                <p class="sgns-state-desc">No encontramos ningún equipo o participante con ese criterio de búsqueda.</p>
            </div>

            {# Tabla de Registros (Desktop/Tablet) #}
            <div id="sgnsTableContainer" class="sgns-table-responsive" style="display: none;">
                <table class="sgns-table">
                    <thead>
                        <tr>
                            <th class="th-num">#</th>
                            <th>EQUIPO</th>
                            <th>JUEGO</th>
                            <th>INTEGRANTES</th>
                            <th>CONTACTO</th>
                            <th class="th-date">REGISTRO</th>
                            <th class="th-del"></th>
                        </tr>
                    </thead>
                    <tbody id="sgnsTableBody">
                        {# Inyectado por JS #}
                    </tbody>
                </table>
            </div>

            {# Lista de Cards (Móvil) #}
            <div id="sgnsCardsContainer" class="sgns-cards-grid" style="display: none;">
                {# Inyectado por JS en pantallas pequeñas #}
            </div>

        </div>

        {# Footer con información #}
        <div class="sgns-part-footer">
            <span>© {{ "now" | date('Y') }} Signos Indumentaria • Lista Oficial del Torneo</span>
        </div>

    </div>
</div>

{# Estilos Scoped de la Tabla y Gate de Contraseña #}
<style>
    /* Reset de seguridad para aislamiento */
    html,
    body,
    .template-page,
    .is-event-page,
    .user-content {
        background: #09090b !important;
        background-color: #09090b !important;
        color: #ffffff !important;
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        max-width: 100vw !important;
        overflow-x: hidden !important;
        box-sizing: border-box !important;
        -webkit-text-size-adjust: 100% !important;
    }

    #sgns-participantes-root,
    #sgns-participantes-root * {
        box-sizing: border-box !important;
    }

    /* Ocultar elementos de Tiendanube */
    header,
    .section-header,
    .js-head-main,
    .main-header,
    .nav-bar,
    footer,
    .section-footer,
    .footer,
    .js-footer,
    #whatsapp-btn,
    .whatsapp-bubble,
    .header-island {
        display: none !important;
    }

    /* Contenedor Raíz */
    .sgns-part-page {
        min-height: 100vh;
        width: 100%;
        background-color: #09090b;
        background-image: 
            radial-gradient(at 0% 0%, rgba(255, 255, 255, 0.04) 0px, transparent 50%),
            radial-gradient(at 100% 100%, rgba(255, 255, 255, 0.03) 0px, transparent 50%);
        font-family: 'Outfit', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        color: #ffffff;
        position: relative;
        padding: 30px 16px 60px;
    }

    .sgns-part-glow {
        position: absolute;
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100%;
        max-width: 900px;
        height: 380px;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.07) 0%, rgba(255, 255, 255, 0) 70%);
        pointer-events: none;
        z-index: 1;
    }

    /* =========================================================================
       GATE DE CONTRASEÑA / BLOQUEO
       ========================================================================= */
    .sgns-auth-gate {
        position: relative;
        z-index: 10;
        min-height: 75vh;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        padding: 20px 10px;
    }

    .sgns-auth-card {
        width: 100%;
        max-width: 420px;
        background: rgba(17, 17, 20, 0.95);
        border: 1px solid rgba(255, 255, 255, 0.12);
        box-shadow: 
            0 30px 60px -15px rgba(0, 0, 0, 0.9),
            inset 0 1px 0 rgba(255, 255, 255, 0.1);
        border-radius: 22px;
        padding: 34px 26px;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 12px;
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        animation: sgnsFadeUp 0.35s ease-out;
    }
    @keyframes sgnsFadeUp {
        from { opacity: 0; transform: translateY(12px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .sgns-auth-brand {
        margin-bottom: 2px;
    }
    .sgns-auth-logo {
        height: 110px;
        width: auto;
        display: block;
        margin: 0 auto;
        filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.2));
    }

    .sgns-lock-icon-wrap {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.15);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ffffff;
        margin: 4px auto 0;
        box-shadow: 0 0 20px rgba(255, 255, 255, 0.1);
    }
    .sgns-lock-icon-wrap svg {
        width: 22px;
        height: 22px;
    }

    .sgns-badge-private {
        color: #f59e0b;
        background: rgba(245, 158, 11, 0.1);
        border-color: rgba(245, 158, 11, 0.3);
    }

    .sgns-auth-title {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 24px;
        letter-spacing: 2px;
        color: #ffffff;
        margin: 2px 0 0;
        line-height: 1.2;
    }

    .sgns-auth-subtitle {
        font-size: 13px;
        color: #a1a1aa;
        line-height: 1.45;
        margin: 0 0 6px;
    }

    .sgns-auth-form {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 12px;
        margin-top: 4px;
    }

    .sgns-auth-field {
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .sgns-auth-input-wrap {
        position: relative;
        width: 100%;
        display: flex;
        align-items: center;
    }

    .sgns-key-icon {
        position: absolute;
        left: 14px;
        width: 16px;
        height: 16px;
        color: #71717a;
        pointer-events: none;
    }

    .sgns-auth-input {
        width: 100%;
        background: #141418;
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 12px;
        padding: 14px 44px 14px 40px;
        font-size: 14px;
        color: #ffffff;
        font-family: inherit;
        outline: none;
        transition: all 0.2s ease;
        letter-spacing: 1px;
        text-transform: none !important;
    }
    .sgns-auth-input:focus {
        border-color: #ffffff;
        background: #18181c;
        box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.12);
    }
    .sgns-auth-input.has-error {
        border-color: #ef4444 !important;
        box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.15) !important;
    }

    .sgns-pass-toggle {
        position: absolute;
        right: 12px;
        background: transparent;
        border: none;
        color: #a1a1aa;
        cursor: pointer;
        padding: 4px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: color 0.15s ease;
    }
    .sgns-pass-toggle:hover {
        color: #ffffff;
    }
    .sgns-pass-toggle svg {
        width: 18px;
        height: 18px;
    }

    .sgns-auth-error-msg {
        color: #fca5a5;
        font-size: 12px;
        text-align: left;
        line-height: 1.35;
        padding-left: 2px;
    }

    .sgns-auth-submit-btn {
        width: 100%;
        background: #ffffff;
        color: #000000;
        border: none;
        padding: 14px 20px;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 2px;
        text-transform: uppercase !important;
        font-family: 'Outfit', sans-serif !important;
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.2s cubic-bezier(0.2, 0.8, 0.2, 1);
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: 4px;
    }
    .sgns-auth-submit-btn:hover {
        background: #f4f4f5;
        transform: translateY(-2px);
        box-shadow: 0 10px 24px -6px rgba(255, 255, 255, 0.35);
    }
    .sgns-auth-submit-btn:active {
        transform: translateY(0);
    }

    /* =========================================================================
       PANEL PRINCIPAL DE PARTICIPANTES (PROTEGIDO)
       ========================================================================= */
    .sgns-part-container {
        position: relative;
        z-index: 2;
        width: 100%;
        max-width: 1100px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: 22px;
        animation: sgnsFadeIn 0.3s ease-out;
    }
    @keyframes sgnsFadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    /* Encabezado */
    .sgns-part-header {
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 12px;
        padding: 10px 0 6px;
    }

    .sgns-part-brand {
        display: block;
        margin-bottom: 2px;
    }
    .sgns-part-logo {
        height: 110px;
        width: auto;
        display: block;
        margin: 0 auto;
        filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.2));
        transition: transform 0.3s ease;
    }
    .sgns-part-logo:hover {
        transform: scale(1.03);
    }

    .sgns-badge-group {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    .sgns-part-badge {
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 2px;
        text-transform: uppercase !important;
        color: #a1a1aa;
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.12);
        padding: 4px 14px;
        border-radius: 999px;
    }
    .sgns-badge-live {
        color: #22c55e;
        border-color: rgba(34, 197, 94, 0.3);
        background: rgba(34, 197, 94, 0.08);
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }
    .sgns-badge-live::before {
        content: '';
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background: #22c55e;
        box-shadow: 0 0 8px #22c55e;
        animation: sgnsPulse 1.8s infinite;
    }
    @keyframes sgnsPulse {
        0%, 100% { opacity: 1; transform: scale(1); }
        50% { opacity: 0.4; transform: scale(0.85); }
    }

    .sgns-part-title {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 32px;
        letter-spacing: 3px;
        margin: 0;
        color: #ffffff;
        text-transform: uppercase !important;
        line-height: 1.15;
    }

    .sgns-part-subtitle {
        font-size: 14px;
        color: #a1a1aa;
        margin: 0;
        line-height: 1.45;
        max-width: 500px;
    }

    /* Fecha y Horario */
    .sgns-part-datetime {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 14px;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.08) 0%, rgba(255, 255, 255, 0.03) 100%);
        border: 1px solid rgba(255, 255, 255, 0.22);
        box-shadow: 0 4px 22px rgba(0, 0, 0, 0.55), inset 0 1px 0 rgba(255, 255, 255, 0.2);
        padding: 8px 20px;
        border-radius: 999px;
        margin-top: 4px;
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
    }
    .sgns-dt-item {
        display: flex;
        align-items: center;
        gap: 7px;
        color: #ffffff;
        font-size: 12.5px;
        font-weight: 800;
        letter-spacing: 1.5px;
        text-transform: uppercase !important;
    }
    .sgns-dt-icon {
        width: 15px;
        height: 15px;
        color: #ffffff;
        flex-shrink: 0;
        filter: drop-shadow(0 0 6px rgba(255, 255, 255, 0.45));
    }
    .sgns-dt-separator {
        width: 1px;
        height: 14px;
        background: rgba(255, 255, 255, 0.25);
    }

    /* Botones de Acción del Header */
    .sgns-header-actions {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: center;
        gap: 10px;
        margin-top: 10px;
    }

    .sgns-action-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 10px 18px;
        border-radius: 10px;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 1.5px;
        text-transform: uppercase !important;
        cursor: pointer;
        text-decoration: none !important;
        transition: all 0.2s cubic-bezier(0.2, 0.8, 0.2, 1);
        font-family: 'Outfit', sans-serif !important;
    }
    .sgns-action-btn svg {
        width: 15px;
        height: 15px;
    }

    .sgns-btn-primary {
        background: #ffffff;
        color: #000000 !important;
        border: none;
    }
    .sgns-btn-primary:hover {
        background: #f4f4f5;
        transform: translateY(-2px);
        box-shadow: 0 10px 24px -6px rgba(255, 255, 255, 0.3);
    }

    .sgns-btn-secondary {
        background: rgba(255, 255, 255, 0.05);
        color: #ffffff !important;
        border: 1px solid rgba(255, 255, 255, 0.15);
    }
    .sgns-btn-secondary:hover {
        background: rgba(255, 255, 255, 0.1);
        border-color: rgba(255, 255, 255, 0.3);
        transform: translateY(-2px);
    }

    .sgns-btn-lock {
        background: rgba(239, 68, 68, 0.08);
        color: #f87171 !important;
        border: 1px solid rgba(239, 68, 68, 0.25);
    }
    .sgns-btn-lock:hover {
        background: rgba(239, 68, 68, 0.16);
        border-color: rgba(239, 68, 68, 0.4);
        transform: translateY(-2px);
    }

    /* Grilla de Métricas / KPI */
    .sgns-stats-grid {
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 12px;
    }
    .sgns-stat-card {
        background: rgba(17, 17, 20, 0.9);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 14px;
        padding: 14px 16px;
        display: flex;
        flex-direction: column;
        gap: 4px;
        transition: transform 0.2s ease, border-color 0.2s ease;
    }
    .sgns-stat-card:hover {
        border-color: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }
    .sgns-stat-label {
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 1.5px;
        color: #71717a;
        text-transform: uppercase;
    }
    .sgns-stat-val {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 26px;
        font-weight: 800;
        color: #ffffff;
        letter-spacing: 1px;
    }

    /* Toolbar de Búsqueda y Filtros */
    .sgns-toolbar {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
        gap: 14px;
        background: rgba(17, 17, 20, 0.9);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 14px;
        padding: 12px 16px;
    }

    .sgns-search-box {
        position: relative;
        flex: 1;
        min-width: 240px;
    }
    .sgns-search-icon {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        width: 16px;
        height: 16px;
        color: #71717a;
        pointer-events: none;
    }
    .sgns-search-input {
        width: 100%;
        background: #141418;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 10px;
        padding: 10px 36px 10px 38px;
        font-size: 13px;
        color: #ffffff;
        font-family: inherit;
        outline: none;
        transition: all 0.2s ease;
    }
    .sgns-search-input:focus {
        border-color: #ffffff;
        background: #18181c;
        box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
    }
    .sgns-clear-btn {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        background: transparent;
        border: none;
        color: #a1a1aa;
        font-size: 18px;
        line-height: 1;
        cursor: pointer;
        padding: 0;
    }

    .sgns-filter-pills {
        display: flex;
        gap: 8px;
        overflow-x: auto;
        padding-bottom: 2px;
    }
    .sgns-pill {
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #a1a1aa;
        padding: 8px 14px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        white-space: nowrap;
        font-family: inherit;
    }
    .sgns-pill:hover {
        background: rgba(255, 255, 255, 0.08);
        color: #ffffff;
    }
    .sgns-pill.active {
        background: #ffffff;
        color: #000000;
        border-color: #ffffff;
        font-weight: 700;
    }

    /* Envoltorio de la Tabla */
    .sgns-table-wrapper {
        background: rgba(17, 17, 20, 0.95);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 18px;
        overflow: hidden;
        box-shadow: 0 24px 48px -12px rgba(0, 0, 0, 0.8);
        min-height: 280px;
        position: relative;
    }

    /* Estados de Carga / Vacío / Error */
    .sgns-state-view {
        padding: 50px 20px;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .sgns-spinner {
        width: 32px;
        height: 32px;
        border: 3px solid rgba(255, 255, 255, 0.1);
        border-top-color: #ffffff;
        border-radius: 50%;
        animation: sgnsRotate 0.8s linear infinite;
        margin-bottom: 14px;
    }
    @keyframes sgnsRotate {
        to { transform: rotate(360deg); }
    }
    .sgns-state-icon {
        font-size: 38px;
        margin-bottom: 10px;
    }
    .sgns-state-title {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 20px;
        letter-spacing: 1.5px;
        color: #ffffff;
        margin: 0 0 6px;
    }
    .sgns-state-desc {
        font-size: 13.5px;
        color: #71717a;
        margin: 0;
        max-width: 420px;
        line-height: 1.45;
    }

    /* Tabla Desktop */
    .sgns-table-responsive {
        width: 100%;
        overflow-x: auto;
    }
    .sgns-table {
        width: 100%;
        border-collapse: collapse;
        text-align: left;
        font-size: 13px;
    }
    .sgns-table thead th {
        background: #141418;
        color: #71717a;
        font-size: 10.5px;
        font-weight: 700;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 14px 18px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        white-space: nowrap;
    }
    .sgns-table tbody tr {
        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        transition: background 0.15s ease;
    }
    .sgns-table tbody tr:hover {
        background: rgba(255, 255, 255, 0.03);
    }
    .sgns-table tbody tr:last-child {
        border-bottom: none;
    }
    .sgns-table tbody td {
        padding: 14px 18px;
        vertical-align: middle;
        color: #d4d4d8;
    }

    .th-del, .td-del {
        width: 116px;
        text-align: center;
    }
    .sgns-row-actions {
        display: inline-flex;
        gap: 6px;
        align-items: center;
    }
    .sgns-act-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        padding: 0;
        border-radius: 8px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        background: transparent;
        color: #a1a1aa;
        cursor: pointer;
        text-decoration: none !important;
        transition: color 0.15s ease, border-color 0.15s ease, background 0.15s ease;
    }
    .sgns-act-btn:hover {
        color: #ffffff;
        border-color: rgba(255, 255, 255, 0.35);
        background: rgba(255, 255, 255, 0.08);
    }
    .sgns-wa-btn:hover {
        color: #25D366;
        border-color: #25D366;
        background: rgba(37, 211, 102, 0.1);
    }
    .sgns-p-item {
        flex-wrap: wrap;
    }
    .sgns-p-edad {
        flex-basis: 100%;
        margin-left: 18px;
        font-size: 11px;
        color: #71717a;
    }
    .sgns-p-edad.falta {
        color: #f59e0b;
    }
    .sgns-edit-overlay {
        position: fixed;
        inset: 0;
        background: rgba(0, 0, 0, 0.75);
        z-index: 999;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }
    .sgns-edit-box {
        width: 100%;
        max-height: 90vh;
        overflow-y: auto;
        max-width: 440px;
        background: #141418;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 18px;
        padding: 24px 20px;
    }
    .sgns-edit-title {
        font-size: 16px;
        font-weight: 800;
        letter-spacing: 1px;
        margin: 0 0 16px;
        color: #ffffff;
    }
    .sgns-edit-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        margin-bottom: 12px;
    }
    .sgns-edit-name {
        font-size: 13px;
        color: #e4e4e7;
        flex: 1;
        word-break: break-word;
    }
    .sgns-edit-input {
        width: 84px;
        background: #0f0f12;
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 10px;
        padding: 9px 10px;
        font-size: 16px;
        color: #ffffff;
        font-family: inherit;
        outline: none;
    }
    .sgns-edit-field {
        margin-bottom: 12px;
    }
    .sgns-edit-label {
        display: block;
        font-size: 10.5px;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase;
        color: #71717a;
        margin-bottom: 5px;
    }
    .sgns-edit-pair {
        display: flex;
        gap: 8px;
    }
    .sgns-edit-wide {
        flex: 1;
        width: 100%;
    }
    .sgns-edit-input:focus {
        border-color: #ffffff;
    }
    .sgns-edit-actions {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
        margin-top: 18px;
    }
    .sgns-edit-error {
        color: #fca5a5;
        font-size: 12px;
        margin-top: 4px;
    }
    .sgns-del-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 32px;
        height: 32px;
        padding: 0;
        border-radius: 8px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        background: transparent;
        color: #a1a1aa;
        cursor: pointer;
        transition: color 0.15s ease, border-color 0.15s ease, background 0.15s ease;
    }
    .sgns-del-btn:hover {
        color: #E60000;
        border-color: #E60000;
        background: rgba(230, 0, 0, 0.1);
    }
    .sgns-del-btn:disabled {
        opacity: 0.4;
        cursor: not-allowed;
    }

    .th-num {
        width: 44px;
        text-align: center;
    }
    .td-num {
        font-family: monospace;
        color: #71717a;
        font-size: 11.5px;
        text-align: center;
    }
    .td-team-name {
        font-weight: 700;
        color: #ffffff;
        font-size: 14.5px;
        letter-spacing: 0.5px;
    }

    .sgns-sport-tag {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 11.5px;
        font-weight: 600;
        letter-spacing: 0.5px;
    }
    .sport-futbol {
        background: rgba(34, 197, 94, 0.12);
        color: #4ade80;
        border: 1px solid rgba(34, 197, 94, 0.25);
    }
    .sport-basquet {
        background: rgba(249, 115, 22, 0.12);
        color: #fb923c;
        border: 1px solid rgba(249, 115, 22, 0.25);
    }
    .sport-pingpong {
        background: rgba(59, 130, 246, 0.12);
        color: #60a5fa;
        border: 1px solid rgba(59, 130, 246, 0.25);
    }
    .sport-otro {
        background: rgba(255, 255, 255, 0.08);
        color: #d4d4d8;
        border: 1px solid rgba(255, 255, 255, 0.15);
    }

    .sgns-participants-list {
        display: flex;
        flex-direction: column;
        gap: 3px;
    }
    .sgns-p-item {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 12.5px;
    }
    .sgns-p-num {
        color: #71717a;
        font-size: 10.5px;
        font-family: monospace;
    }
    .sgns-p-name {
        color: #e4e4e7;
        font-weight: 500;
    }

    .sgns-contact-info {
        display: flex;
        flex-direction: column;
        gap: 2px;
        font-size: 12px;
    }
    .sgns-c-tel {
        color: #ffffff;
        font-weight: 500;
    }
    .sgns-c-email {
        color: #71717a;
        font-size: 11.5px;
    }
    .td-date {
        color: #71717a;
        font-size: 11.5px;
        white-space: nowrap;
    }

    /* Cards para Móviles */
    .sgns-cards-grid {
        display: none;
        flex-direction: column;
        gap: 12px;
        padding: 14px;
    }
    .sgns-card-row {
        background: #141418;
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 14px;
        padding: 14px;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }
    .sgns-card-head {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 8px;
    }
    .sgns-card-title {
        font-size: 15px;
        font-weight: 700;
        color: #ffffff;
    }
    .sgns-card-body {
        background: rgba(255, 255, 255, 0.02);
        border-radius: 8px;
        padding: 10px;
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    .sgns-card-foot {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 11.5px;
        color: #71717a;
        border-top: 1px solid rgba(255, 255, 255, 0.05);
        padding-top: 8px;
    }

    /* Footer */
    .sgns-part-footer {
        text-align: center;
        padding: 20px 0 0;
        color: #52525b;
        font-size: 12px;
    }

    /* Icono de rotación al refrescar */
    .is-spinning {
        animation: sgnsRotate 0.7s linear infinite;
    }

    /* Responsive */
    @media (max-width: 900px) {
        .sgns-stats-grid {
            grid-template-columns: repeat(3, 1fr);
        }
    }

    @media (max-width: 768px) {
        .sgns-part-page {
            padding: 20px 12px 40px;
        }
        .sgns-part-logo {
            height: 90px;
        }
        .sgns-part-title {
            font-size: 24px;
            letter-spacing: 2px;
        }
        .sgns-stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
        .sgns-stat-card:last-child {
            grid-column: span 2;
        }
        .sgns-table-responsive {
            display: none !important;
        }
        .sgns-cards-grid {
            display: flex !important;
        }
        .sgns-toolbar {
            flex-direction: column;
            align-items: stretch;
        }
    }
</style>

{# Supabase SDK #}
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<script>
(function() {
    // =========================================================================
    // CONFIGURACIÓN DE SEGURIDAD (PASSWORD GATE)
    // =========================================================================
    const REQUIRED_PASS = '1005Nicolas';
    const AUTH_STORAGE_KEY = 'sgns_part_auth_v2';

    const authGate = document.getElementById('sgnsAuthGate');
    const authContent = document.getElementById('sgnsAuthContent');
    const authForm = document.getElementById('sgnsAuthForm');
    const passInput = document.getElementById('sgnsPasswordInput');
    const authError = document.getElementById('sgnsAuthError');
    const togglePassBtn = document.getElementById('sgnsTogglePass');
    const eyeOpen = document.getElementById('eyeOpenIcon');
    const eyeClosed = document.getElementById('eyeClosedIcon');
    const lockBtn = document.getElementById('sgnsLockBtn');

    // Configuración de Supabase
    const SUPABASE_CONFIG = {
        url: 'https://byuqwgvjdymypthqpzig.supabase.co',
        anonKey: 'sb_publishable_k5U9eRBSGEeMyu-bCBjKAQ_N56holGK',
        table: 'registros_evento'
    };

    let allRegistros = [];
    let currentFilter = 'all';
    let searchQuery = '';
    let isDataLoaded = false;

    // Elementos del DOM del Panel
    const loadingState = document.getElementById('sgnsLoadingState');
    const errorState = document.getElementById('sgnsErrorState');
    const emptyState = document.getElementById('sgnsEmptyState');
    const noResultsState = document.getElementById('sgnsNoResultsState');
    const errorMessage = document.getElementById('sgnsErrorMessage');
    const tableContainer = document.getElementById('sgnsTableContainer');
    const cardsContainer = document.getElementById('sgnsCardsContainer');
    const tableBody = document.getElementById('sgnsTableBody');

    const searchInput = document.getElementById('sgnsSearchInput');
    const clearSearchBtn = document.getElementById('sgnsClearSearch');
    const filterPills = document.querySelectorAll('.sgns-pill');
    const refreshBtn = document.getElementById('sgnsRefreshBtn');
    const refreshIcon = document.getElementById('refreshIcon');
    const exportBtn = document.getElementById('sgnsExportBtn');
    const retryBtn = document.getElementById('sgnsRetryBtn');

    // Métricas
    const statTotalEquipos = document.getElementById('statTotalEquipos');
    const statTotalJugadores = document.getElementById('statTotalJugadores');
    const statFutbol = document.getElementById('statFutbol');
    const statBasquet = document.getElementById('statBasquet');
    const statPingPong = document.getElementById('statPingPong');

    // Inicializar cliente Supabase
    let supabaseClient = null;
    if (window.supabase && SUPABASE_CONFIG.url) {
        try {
            supabaseClient = window.supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
        } catch (e) {
            console.warn('[Supabase Client Error]', e);
        }
    }

    // Funciones de Bloqueo / Desbloqueo
    function unlockPanel() {
        authGate.style.display = 'none';
        authContent.style.display = 'flex';
        sessionStorage.setItem(AUTH_STORAGE_KEY, REQUIRED_PASS);
        if (!isDataLoaded) {
            loadData();
        }
    }

    function lockPanel() {
        sessionStorage.removeItem(AUTH_STORAGE_KEY);
        authContent.style.display = 'none';
        authGate.style.display = 'flex';
        passInput.value = '';
        passInput.classList.remove('has-error');
        authError.style.display = 'none';
        passInput.focus();
    }

    // Manejador del Formulario de Contraseña (acepta mayúsculas y minúsculas indistintamente)
    authForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const entered = passInput.value.trim();

        if (entered.toLowerCase() === REQUIRED_PASS.toLowerCase()) {
            passInput.classList.remove('has-error');
            authError.style.display = 'none';
            unlockPanel();
        } else {
            passInput.classList.add('has-error');
            authError.style.display = 'block';
            passInput.select();
        }
    });

    // Limpiar error al escribir
    passInput.addEventListener('input', function() {
        passInput.classList.remove('has-error');
        authError.style.display = 'none';
    });

    // Botón Mostrar/Ocultar Contraseña
    togglePassBtn.addEventListener('click', function() {
        if (passInput.type === 'password') {
            passInput.type = 'text';
            eyeOpen.style.display = 'none';
            eyeClosed.style.display = 'block';
        } else {
            passInput.type = 'password';
            eyeOpen.style.display = 'block';
            eyeClosed.style.display = 'none';
        }
    });

    // Botón de Bloquear (Cerrar sesión)
    if (lockBtn) {
        lockBtn.addEventListener('click', lockPanel);
    }

    // Helper: Formato de Fecha
    function formatDate(dateStr) {
        if (!dateStr) return '-';
        try {
            const d = new Date(dateStr);
            if (isNaN(d.getTime())) return dateStr;
            return d.toLocaleDateString('es-AR', {
                day: '2-digit',
                month: '2-digit',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return dateStr;
        }
    }

    // Helper: Estilo de Badge según el Deporte
    function getSportBadge(sport) {
        const s = (sport || '').toLowerCase();
        if (s.includes('fút') || s.includes('fut')) {
            return '<span class="sgns-sport-tag sport-futbol">⚽ Fútbol</span>';
        }
        if (s.includes('bás') || s.includes('bas')) {
            return '<span class="sgns-sport-tag sport-basquet">🏀 Básquet</span>';
        }
        if (s.includes('ping') || s.includes('pong') || s.includes('tenis')) {
            return '<span class="sgns-sport-tag sport-pingpong">🏓 Ping Pong</span>';
        }
        return `<span class="sgns-sport-tag sport-otro">🏆 ${sport || 'Sin definir'}</span>`;
    }

    // Ping Pong es individual (1 jugador); el resto son equipos de 3
    function esIndividual(item) {
        const j = (item.juego || '').toLowerCase();
        return j.includes('ping') || j.includes('pong');
    }

    function getMiembros(item) {
        if (esIndividual(item)) return [item.participante_1 || '-'];
        return [item.participante_1 || '-', item.participante_2 || '-', item.participante_3 || '-'];
    }

    function getEdad(item, i) {
        const e = item['edad_' + (i + 1)];
        return (e === null || e === undefined || e === '') ? null : e;
    }

    function miembrosHtml(item) {
        return getMiembros(item).map((nombre, i) => {
            const edad = getEdad(item, i);
            const edadHtml = edad !== null
                ? `<span class="sgns-p-edad">${escapeHtml(edad)} años</span>`
                : `<span class="sgns-p-edad falta">Edad sin cargar</span>`;
            return `<div class="sgns-p-item"><span class="sgns-p-num">${i + 1}.</span> <span class="sgns-p-name">${escapeHtml(nombre)}</span>${edadHtml}</div>`;
        }).join('');
    }

    // Actualizar Estadísticas
    function updateStats(data) {
        const total = data.length;
        statTotalEquipos.textContent = total;
        statTotalJugadores.textContent = data.reduce((sum, item) => sum + getMiembros(item).length, 0);

        let futbol = 0;
        let basquet = 0;
        let pingpong = 0;

        data.forEach(item => {
            const j = (item.juego || '').toLowerCase();
            if (j.includes('fút') || j.includes('fut')) futbol++;
            else if (j.includes('bás') || j.includes('bas')) basquet++;
            else if (j.includes('ping') || j.includes('pong')) pingpong++;
        });

        statFutbol.textContent = futbol;
        statBasquet.textContent = basquet;
        statPingPong.textContent = pingpong;
    }

    function trashBtnHtml(item) {
        return `<button type="button" class="sgns-del-btn" data-id="${escapeHtml(item.id)}" aria-label="Eliminar inscripción" title="Eliminar inscripción">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"></path><path d="M10 11v6"></path><path d="M14 11v6"></path><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"></path></svg>
        </button>`;
    }

    function waUrl(item) {
        let tel = String(item.telefono || '').replace(/\D/g, '');
        if (!tel) return null;
        tel = tel.replace(/^0+/, '');
        if (!tel.startsWith('54')) tel = '549' + tel;
        const pedido = esIndividual(item)
            ? '¿Nos podrías pasar tu edad?'
            : '¿Nos podrías pasar la edad de cada integrante?';
        const msg = `¡Hola! Somos del equipo de Signos y estamos organizando el torneo del domingo 4/10. Muchas gracias por anotarte. Para terminar de armar todo necesitamos un dato: ${pedido} ¡Gracias, nos vemos en la cancha!`;
        return `https://wa.me/${tel}?text=${encodeURIComponent(msg)}`;
    }

    function deleteBtnHtml(item) {
        const url = waUrl(item);
        const wa = url
            ? `<a class="sgns-act-btn sgns-wa-btn" href="${url}" target="_blank" rel="noopener" aria-label="Pedir edad por WhatsApp" title="Pedir edad por WhatsApp"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.4 8.4 0 0 1-12.4 7.4L3 20.500l1.700-5.400A8.400 8.400 0 1 1 21 11.500z"></path><path d="M9 8.500c0 3.500 3 6.500 6.500 6.500l1-1.500-2-1-1 .8c-.9-.4-1.700-1.200-2.100-2.100l.8-1-1-2z"></path></svg></a>`
            : '';
        const edit = `<button type="button" class="sgns-act-btn sgns-edit-btn" data-id="${escapeHtml(item.id)}" aria-label="Editar inscripción" title="Editar inscripción"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"></path><path d="M16.500 3.500a2.100 2.100 0 0 1 3 3L7 19l-4 1 1-4z"></path></svg></button>`;
        return `<span class="sgns-row-actions">${edit}${wa}${trashBtnHtml(item)}</span>`;
    }

    // Editar la inscripción completa
    function openEditModal(id) {
        const item = allRegistros.find(r => String(r.id) === String(id));
        if (!item) return;
        const val = v => escapeHtml(v === null || v === undefined ? '' : v);
        const juegoActual = (item.juego || '');
        const opciones = ['Fútbol', 'Básquet', 'Ping Pong'].map(j =>
            `<option value="${j}"${juegoActual === j ? ' selected' : ''}>${j}</option>`).join('');
        const jugadorRow = n => `
            <div class="sgns-edit-field" data-player="${n}">
                <label class="sgns-edit-label">${n === 1 ? 'Participante 1' : 'Participante ' + n}</label>
                <div class="sgns-edit-pair">
                    <input type="text" class="sgns-edit-input sgns-edit-wide" data-f="participante_${n}" placeholder="Nombre y Apellido" value="${val(item['participante_' + n])}">
                    <input type="number" class="sgns-edit-input" data-f="edad_${n}" min="5" max="99" inputmode="numeric" placeholder="Edad" value="${val(item['edad_' + n])}">
                </div>
            </div>`;
        const overlay = document.createElement('div');
        overlay.className = 'sgns-edit-overlay';
        overlay.innerHTML = `
            <div class="sgns-edit-box">
                <h3 class="sgns-edit-title">EDITAR INSCRIPCIÓN</h3>
                <div class="sgns-edit-field">
                    <label class="sgns-edit-label">Juego</label>
                    <select class="sgns-edit-input sgns-edit-wide" data-f="juego">${opciones}</select>
                </div>
                <div class="sgns-edit-field" data-team>
                    <label class="sgns-edit-label">Nombre del equipo</label>
                    <input type="text" class="sgns-edit-input sgns-edit-wide" data-f="equipo" value="${val(item.equipo)}">
                </div>
                ${jugadorRow(1)}${jugadorRow(2)}${jugadorRow(3)}
                <div class="sgns-edit-field">
                    <label class="sgns-edit-label">Correo electrónico</label>
                    <input type="email" class="sgns-edit-input sgns-edit-wide" data-f="email" value="${val(item.email)}">
                </div>
                <div class="sgns-edit-field">
                    <label class="sgns-edit-label">Teléfono</label>
                    <input type="tel" class="sgns-edit-input sgns-edit-wide" data-f="telefono" value="${val(item.telefono)}">
                </div>
                <div class="sgns-edit-error" style="display:none;"></div>
                <div class="sgns-edit-actions">
                    <button type="button" class="sgns-action-btn sgns-btn-secondary" data-act="cancel">Cancelar</button>
                    <button type="button" class="sgns-action-btn sgns-btn-primary" data-act="save">Guardar</button>
                </div>
            </div>`;
        document.body.appendChild(overlay);

        const errEl = overlay.querySelector('.sgns-edit-error');
        const field = f => overlay.querySelector(`[data-f="${f}"]`);
        const close = () => overlay.remove();

        // Ping Pong es individual: sin equipo ni participantes 2 y 3
        const aplicarModo = () => {
            const ind = /ping|pong/i.test(field('juego').value);
            overlay.querySelector('[data-team]').style.display = ind ? 'none' : '';
            overlay.querySelector('[data-player="2"]').style.display = ind ? 'none' : '';
            overlay.querySelector('[data-player="3"]').style.display = ind ? 'none' : '';
            overlay.querySelector('[data-player="1"] .sgns-edit-label').textContent = ind ? 'Nombre y Apellido' : 'Participante 1';
        };
        field('juego').addEventListener('change', aplicarModo);
        aplicarModo();

        overlay.addEventListener('click', async (ev) => {
            if (ev.target === overlay || ev.target.dataset.act === 'cancel') return close();
            if (ev.target.dataset.act !== 'save') return;

            const juego = field('juego').value;
            const ind = /ping|pong/i.test(juego);
            const txt = f => field(f).value.trim();
            const edad = f => {
                const v = txt(f);
                if (v === '') return null;
                const n = parseInt(v, 10);
                return (Number.isInteger(n) && n >= 5 && n <= 99) ? n : NaN;
            };

            const p1 = txt('participante_1');
            const p2 = ind ? '' : txt('participante_2');
            const p3 = ind ? '' : txt('participante_3');
            const equipo = ind ? p1 : txt('equipo');
            const e1 = edad('edad_1');
            const e2 = ind ? null : edad('edad_2');
            const e3 = ind ? null : edad('edad_3');
            const email = txt('email').toLowerCase();

            let msg = '';
            if (!p1) msg = 'Ingresá el nombre del participante.';
            else if (!ind && (!equipo || !p2 || !p3)) msg = 'Completá el nombre del equipo y los 3 participantes.';
            else if ([e1, e2, e3].some(Number.isNaN)) msg = 'Ingresá edades válidas (5 a 99).';
            else if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) msg = 'Ingresá un correo válido.';
            if (msg) {
                errEl.textContent = msg;
                errEl.style.display = 'block';
                return;
            }

            const patch = {
                juego, equipo,
                participante_1: p1, participante_2: p2, participante_3: p3,
                edad_1: e1, edad_2: e2, edad_3: e3,
                email, telefono: txt('telefono'),
                // Campos de compatibilidad, igual que en el formulario de registro
                nombre: `${equipo} (${juego})`,
                apellido: ind ? p1 : `${p1} / ${p2} / ${p3}`
            };

            const saveBtn = ev.target;
            saveBtn.disabled = true;
            try {
                const { data, error } = await supabaseClient
                    .from(SUPABASE_CONFIG.table)
                    .update(patch)
                    .eq('id', item.id)
                    .select();
                if (error) throw error;
                if (!data || data.length === 0) {
                    throw new Error('No se pudo guardar: falta la política de UPDATE en Supabase para la tabla ' + SUPABASE_CONFIG.table + '.');
                }
                Object.assign(item, patch);
                updateStats(allRegistros);
                close();
                render();
            } catch (err) {
                console.error('[Error al editar inscripción]', err);
                errEl.textContent = err.message || 'No se pudo guardar.';
                errEl.style.display = 'block';
                saveBtn.disabled = false;
            }
        });
    }

    document.addEventListener('click', function(e) {
        const b = e.target.closest('.sgns-edit-btn');
        if (b) openEditModal(b.dataset.id);
    });

    // Eliminar una inscripción
    async function deleteRegistro(id, btn) {
        const item = allRegistros.find(r => String(r.id) === String(id));
        if (!item) return;
        if (!confirm(`¿Eliminar la inscripción de "${item.equipo || 'Equipo Sin Nombre'}"? Esta acción no se puede deshacer.`)) return;

        btn.disabled = true;
        try {
            let deleted = [];
            if (supabaseClient) {
                const { data, error } = await supabaseClient
                    .from(SUPABASE_CONFIG.table)
                    .delete()
                    .eq('id', id)
                    .select();
                if (error) throw error;
                deleted = data || [];
            } else {
                const res = await fetch(`${SUPABASE_CONFIG.url}/rest/v1/${SUPABASE_CONFIG.table}?id=eq.${encodeURIComponent(id)}`, {
                    method: 'DELETE',
                    headers: {
                        'apikey': SUPABASE_CONFIG.anonKey,
                        'Authorization': `Bearer ${SUPABASE_CONFIG.anonKey}`,
                        'Prefer': 'return=representation'
                    }
                });
                if (!res.ok) throw new Error(`HTTP Error ${res.status}`);
                deleted = await res.json();
            }
            // Con RLS sin permiso de DELETE, Supabase responde OK pero no borra nada
            if (deleted.length === 0) {
                throw new Error('No se pudo eliminar: falta la política de DELETE en Supabase para la tabla ' + SUPABASE_CONFIG.table + '.');
            }
            allRegistros = allRegistros.filter(r => String(r.id) !== String(id));
            updateStats(allRegistros);
            render();
        } catch (err) {
            console.error('[Error al eliminar registro]', err);
            alert(err.message || 'No se pudo eliminar la inscripción.');
            btn.disabled = false;
        }
    }

    document.addEventListener('click', function(e) {
        const btn = e.target.closest('.sgns-del-btn');
        if (btn) deleteRegistro(btn.dataset.id, btn);
    });

    // Filtrar y Renderizar
    function render() {
        const q = searchQuery.toLowerCase().trim();
        const filtered = allRegistros.filter(item => {
            // Filtro por deporte
            if (currentFilter !== 'all') {
                const j = (item.juego || '').toLowerCase();
                const f = currentFilter.toLowerCase();
                if (!j.includes(f)) return false;
            }

            // Filtro por búsqueda
            if (q) {
                const haystack = [
                    item.equipo || '',
                    item.juego || '',
                    item.participante_1 || '',
                    item.participante_2 || '',
                    item.participante_3 || '',
                    item.email || '',
                    item.telefono || ''
                ].join(' ').toLowerCase();

                if (!haystack.includes(q)) return false;
            }

            return true;
        });

        // Ocultar todos los estados antes de mostrar el correcto
        loadingState.style.display = 'none';
        errorState.style.display = 'none';
        emptyState.style.display = 'none';
        noResultsState.style.display = 'none';
        tableContainer.style.display = 'none';
        cardsContainer.style.display = 'none';

        if (allRegistros.length === 0) {
            emptyState.style.display = 'flex';
            return;
        }

        if (filtered.length === 0) {
            noResultsState.style.display = 'flex';
            return;
        }

        // Renderizado en Tabla Desktop
        let tableHtml = '';
        let cardsHtml = '';

        filtered.forEach((item, index) => {
            const miembros = miembrosHtml(item);
            const fecha = formatDate(item.created_at || item.fecha);
            const sportBadge = getSportBadge(item.juego);

            // Fila de Tabla
            tableHtml += `
                <tr>
                    <td class="td-num">${index + 1}</td>
                    <td>
                        <div class="td-team-name">${escapeHtml(item.equipo || 'Equipo Sin Nombre')}</div>
                    </td>
                    <td>${sportBadge}</td>
                    <td>
                        <div class="sgns-participants-list">
                            ${miembros}
                        </div>
                    </td>
                    <td>
                        <div class="sgns-contact-info">
                            <span class="sgns-c-tel">${escapeHtml(item.telefono || 'Sin teléfono')}</span>
                            <span class="sgns-c-email">${escapeHtml(item.email || 'Sin correo')}</span>
                        </div>
                    </td>
                    <td class="td-date">${fecha}</td>
                    <td class="td-del">${deleteBtnHtml(item)}</td>
                </tr>
            `;

            // Card Móvil
            cardsHtml += `
                <div class="sgns-card-row">
                    <div class="sgns-card-head">
                        <div>
                            <span style="font-size: 11px; color: #71717a; font-family: monospace;">#${index + 1}</span>
                            <div class="sgns-card-title">${escapeHtml(item.equipo || 'Equipo Sin Nombre')}</div>
                        </div>
                        <div>${sportBadge}</div>
                    </div>
                    <div class="sgns-card-body">
                        ${miembros}
                    </div>
                    <div class="sgns-card-foot">
                        <span>📞 ${escapeHtml(item.telefono || '-')}</span>
                        <span>${fecha}</span>
                        ${deleteBtnHtml(item)}
                    </div>
                </div>
            `;
        });

        tableBody.innerHTML = tableHtml;
        cardsContainer.innerHTML = cardsHtml;

        // Mostrar contenedores según viewport
        if (window.innerWidth <= 768) {
            cardsContainer.style.display = 'flex';
        } else {
            tableContainer.style.display = 'block';
        }
    }

    function escapeHtml(str) {
        if (!str) return '';
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }

    // Cargar datos desde Supabase
    async function loadData() {
        loadingState.style.display = 'flex';
        errorState.style.display = 'none';
        emptyState.style.display = 'none';
        noResultsState.style.display = 'none';
        tableContainer.style.display = 'none';
        cardsContainer.style.display = 'none';

        refreshIcon.classList.add('is-spinning');

        try {
            let data = [];

            // 1. Consulta a Supabase
            if (supabaseClient) {
                const { data: sbData, error } = await supabaseClient
                    .from(SUPABASE_CONFIG.table)
                    .select('*')
                    .order('created_at', { ascending: false });

                if (error) {
                    console.warn('[Supabase Select Warning]:', error);
                    throw error;
                }
                if (sbData) {
                    data = sbData;
                }
            } else {
                // Fallback vía REST fetch directo
                const res = await fetch(`${SUPABASE_CONFIG.url}/rest/v1/${SUPABASE_CONFIG.table}?select=*&order=created_at.desc`, {
                    headers: {
                        'apikey': SUPABASE_CONFIG.anonKey,
                        'Authorization': `Bearer ${SUPABASE_CONFIG.anonKey}`
                    }
                });
                if (!res.ok) throw new Error(`HTTP Error ${res.status}`);
                data = await res.json();
            }

            allRegistros = data;
            isDataLoaded = true;
            updateStats(allRegistros);
            render();

        } catch (err) {
            console.error('[Error al cargar registros]', err);
            loadingState.style.display = 'none';
            errorMessage.textContent = err.message || 'Verificá tu conexión a internet o los permisos de lectura en Supabase.';
            errorState.style.display = 'flex';
        } finally {
            refreshIcon.classList.remove('is-spinning');
        }
    }

    // Exportar a Excel con formato profesional, columnas autoajustadas y codificación UTF-8 perfecta
    function exportToExcel() {
        if (!allRegistros || allRegistros.length === 0) {
            alert('No hay registros disponibles para exportar.');
            return;
        }

        const rowsHtml = allRegistros.map((item, idx) => {
            const num = idx + 1;
            const equipo = escapeHtml(item.equipo || 'Equipo Sin Nombre');
            const juego = escapeHtml(item.juego || 'A definir');
            const p1 = escapeHtml(item.participante_1 || '-');
            const p2 = escapeHtml(item.participante_2 || '-');
            const p3 = escapeHtml(item.participante_3 || '-');
            const ed = i => { const e = getEdad(item, i); return e === null ? '-' : e; };
            const tel = escapeHtml(item.telefono || '-');
            const email = escapeHtml(item.email || '-');

            let fechaLegible = '-';
            if (item.created_at || item.fecha) {
                try {
                    const d = new Date(item.created_at || item.fecha);
                    if (!isNaN(d.getTime())) {
                        fechaLegible = d.toLocaleDateString('es-AR', {
                            day: '2-digit',
                            month: '2-digit',
                            year: 'numeric'
                        }) + ' ' + d.toLocaleTimeString('es-AR', {
                            hour: '2-digit',
                            minute: '2-digit'
                        });
                    }
                } catch(e) {
                    fechaLegible = item.created_at || item.fecha;
                }
            }

            const rowBg = (idx % 2 === 0) ? '#ffffff' : '#f8fafc';

            return `
                <tr style="background-color: ${rowBg};">
                    <td style="text-align: center; border: 1px solid #cbd5e1; padding: 10px; font-weight: bold; color: #64748b;">${num}</td>
                    <td style="border: 1px solid #cbd5e1; padding: 10px; font-weight: bold; color: #0f172a;">${equipo}</td>
                    <td style="text-align: center; border: 1px solid #cbd5e1; padding: 10px; font-weight: 600;">${juego}</td>
                    <td style="border: 1px solid #cbd5e1; padding: 10px; color: #1e293b;">${p1} (${ed(0)})</td>
                    <td style="border: 1px solid #cbd5e1; padding: 10px; color: #1e293b;">${p2} (${ed(1)})</td>
                    <td style="border: 1px solid #cbd5e1; padding: 10px; color: #1e293b;">${p3} (${ed(2)})</td>
                    <td style="mso-number-format:'\\@'; text-align: center; border: 1px solid #cbd5e1; padding: 10px; color: #0f172a; font-family: monospace;">${tel}</td>
                    <td style="border: 1px solid #cbd5e1; padding: 10px; color: #475569;">${email}</td>
                    <td style="text-align: center; border: 1px solid #cbd5e1; padding: 10px; white-space: nowrap; color: #64748b;">${fechaLegible}</td>
                </tr>
            `;
        }).join('');

        const excelTemplate = `
            <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <!--[if gte mso 9]>
                <xml>
                    <x:ExcelWorkbook>
                        <x:ExcelWorksheets>
                            <x:ExcelWorksheet>
                                <x:Name>Torneo Signos</x:Name>
                                <x:WorksheetOptions>
                                    <x:DisplayGridlines/>
                                </x:WorksheetOptions>
                            </x:ExcelWorksheet>
                        </x:ExcelWorksheets>
                    </x:ExcelWorkbook>
                </xml>
                <![endif]-->
                <style>
                    body { font-family: Calibri, 'Segoe UI', Arial, sans-serif; }
                    table { border-collapse: collapse; width: 100%; }
                    th { font-family: Calibri, 'Segoe UI', Arial, sans-serif; font-size: 11pt; font-weight: bold; }
                    td { font-family: Calibri, 'Segoe UI', Arial, sans-serif; font-size: 10.5pt; }
                </style>
            </head>
            <body>
                <table border="1">
                    <thead>
                        <tr>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 50px;">N°</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 220px;">EQUIPO</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 130px;">JUEGO</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 190px;">PARTICIPANTE 1</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 190px;">PARTICIPANTE 2</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 190px;">PARTICIPANTE 3</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 150px;">TELÉFONO</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 250px;">EMAIL</th>
                            <th style="background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155; width: 170px;">FECHA Y HORA</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${rowsHtml}
                    </tbody>
                </table>
            </body>
            </html>
        `;

        const blob = new Blob(['\uFEFF' + excelTemplate], { type: 'application/vnd.ms-excel;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = `torneo_signos_inscriptos_${new Date().toISOString().slice(0, 10)}.xls`;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        setTimeout(() => URL.revokeObjectURL(url), 1000);
    }

    // Event Listeners del Panel
    searchInput.addEventListener('input', function() {
        searchQuery = this.value;
        clearSearchBtn.style.display = searchQuery ? 'block' : 'none';
        render();
    });

    clearSearchBtn.addEventListener('click', function() {
        searchInput.value = '';
        searchQuery = '';
        this.style.display = 'none';
        searchInput.focus();
        render();
    });

    filterPills.forEach(pill => {
        pill.addEventListener('click', function() {
            filterPills.forEach(p => p.classList.remove('active'));
            this.classList.add('active');
            currentFilter = this.getAttribute('data-filter');
            render();
        });
    });

    refreshBtn.addEventListener('click', loadData);
    retryBtn.addEventListener('click', loadData);
    exportBtn.addEventListener('click', exportToExcel);

    window.addEventListener('resize', () => {
        if (allRegistros.length > 0) {
            render();
        }
    });

    // =========================================================================
    // INICIALIZACIÓN CON VERIFICACIÓN DE SESIÓN PREVIA
    // =========================================================================
    if (sessionStorage.getItem(AUTH_STORAGE_KEY) === REQUIRED_PASS) {
        unlockPanel();
    } else {
        authGate.style.display = 'flex';
        authContent.style.display = 'none';
    }

})();
</script>
