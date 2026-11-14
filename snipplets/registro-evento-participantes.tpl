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
    {# Franja del modo torneo: solo se ve mientras se arma el torneo #}
    <div class="sgns-t-modo" role="status">
        <span>Modo armar torneo</span>
        <button type="button" id="sgnsTorneoSalir">Volver a inscriptos</button>
    </div>
    {# Franja del modo sorteo: solo se ve mientras se hace el sorteo #}
    <div class="sgns-s-modo" role="status">
        <span>Modo sorteo</span>
        <button type="button" id="sgnsSorteoSalir">Volver a inscriptos</button>
    </div>
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
                <button type="button" id="sgnsTorneoBtn" class="sgns-action-btn sgns-btn-secondary" title="Armar el torneo: asistencia, llaves y horarios">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M8 21h8"></path><path d="M12 17v4"></path><path d="M7 4h10v5a5 5 0 0 1-10 0z"></path><path d="M17 5h3v2a3 3 0 0 1-3 3"></path><path d="M7 5H4v2a3 3 0 0 0 3 3"></path>
                    </svg>
                    <span id="sgnsTorneoBtnTxt">ARMAR TORNEO</span>
                </button>
                <button type="button" id="sgnsSorteoBtn" class="sgns-action-btn sgns-btn-secondary" title="Sorteo con ruleta entre los participantes presentes">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="13" r="8"></circle><path d="M12 13V5"></path><path d="M12 13l6.900 4"></path><path d="M12 13l-6.900 4"></path><path d="M10 2h4l-2 3z"></path>
                    </svg>
                    <span id="sgnsSorteoBtnTxt">HACER SORTEO</span>
                </button>
            </div>
        </div>

        {# Torneo: asistencia, llaves y horarios por deporte (lo arma el script del final) #}
        <div id="sgnsTorneo" class="sgns-torneo" style="display: none;"></div>

        {# Sorteo: ruleta entre los participantes presentes y su lista en Excel (lo arma el script del final) #}
        <div id="sgnsSorteo" class="sgns-sorteo" style="display: none;"></div>

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
        /* Por encima de la franja fija del modo torneo (9999), que también abre esta edición */
        z-index: 10001;
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

    // Puente para el bloque del torneo (más abajo): comparte los inscriptos y la conexión
    window.__sgnsPanel = {
        registros: () => allRegistros,
        sb: supabaseClient,
        tabla: SUPABASE_CONFIG.table,
        render: () => render(),
        escapeHtml: s => escapeHtml(s),
        esIndividual: item => esIndividual(item),
        getEdad: (item, i) => getEdad(item, i),
        editar: id => openEditModal(id)
    };

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
        return `<span class="sgns-row-actions">${confBtnHtml(item)}${edit}${wa}${trashBtnHtml(item)}</span>`;
    }

    // Asistencia: sin responder (null) → viene (true) → no viene (false). La maneja el bloque del torneo
    function confBtnHtml(item) {
        const c = item.confirmado;
        const estado = c === true ? 'si' : (c === false ? 'no' : 'pend');
        const titulo = c === true ? 'Asistencia confirmada' : (c === false ? 'Avisó que no viene' : 'Asistencia sin confirmar');
        const icono = c === true ? '<polyline points="5 12.500 10 17.500 19 7.500"></polyline>'
            : (c === false ? '<line x1="6" y1="6" x2="18" y2="18"></line><line x1="18" y1="6" x2="6" y2="18"></line>'
                : '<path d="M9.500 9a2.500 2.500 0 1 1 3.500 2.300c-.700.400-1 .900-1 1.700"></path><line x1="12" y1="17" x2="12" y2="17.010"></line>');
        return `<button type="button" class="sgns-act-btn sgns-conf-btn is-${estado}" data-conf-id="${escapeHtml(item.id)}" aria-label="${titulo}" title="${titulo} (tocá para cambiar)"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.400" stroke-linecap="round" stroke-linejoin="round">${icono}</svg></button>`;
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
                document.dispatchEvent(new CustomEvent('sgns:registros'));
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
            document.dispatchEvent(new CustomEvent('sgns:registros'));

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

{# ==========================================================================
   TORNEO: asistencia, llaves por edad y horarios, por deporte.
   Se guarda en Supabase: registros_evento.confirmado (asistencia) y la tabla
   torneo_evento (una fila por deporte con su configuración y sus llaves).
   ========================================================================== #}
<style>
    #sgns-participantes-root.is-torneo .sgns-stats-grid,
    #sgns-participantes-root.is-torneo .sgns-toolbar,
    #sgns-participantes-root.is-torneo .sgns-table-wrapper {
        display: none !important;
    }

    /* Modo torneo: franja roja fija arriba, título propio, fondo rojizo y cajas con borde rojo */
    .sgns-t-modo {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 9999;
        align-items: center;
        justify-content: center;
        gap: 14px;
        flex-wrap: wrap;
        padding: 10px 16px;
        background: #E60000;
        color: #ffffff;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 2px;
        text-transform: uppercase;
    }
    .sgns-t-modo button {
        min-height: 32px;
        padding: 6px 14px;
        border-radius: 999px;
        border: 1px solid rgba(255, 255, 255, 0.7);
        background: transparent;
        color: #ffffff;
        font-family: inherit;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase;
        cursor: pointer;
    }
    .sgns-t-modo button:hover { background: #ffffff; color: #E60000; }
    #sgns-participantes-root.is-torneo .sgns-t-modo { display: flex; }
    #sgns-participantes-root.is-torneo { padding-top: 52px !important; }
    #sgns-participantes-root.is-torneo { background: radial-gradient(ellipse at top, rgba(230, 0, 0, 0.16), rgba(230, 0, 0, 0) 60%) #09090b !important; }
    #sgns-participantes-root.is-torneo .sgns-t-caja { border-color: rgba(230, 0, 0, 0.45); }
    #sgns-participantes-root.is-torneo .sgns-part-title { color: #ff5a5a; }
    #sgns-participantes-root.is-torneo #sgnsTorneoBtn { background: #E60000; border-color: #E60000; color: #ffffff !important; }
    #sgns-participantes-root.is-torneo .sgns-header-actions a[href="/registroevento"],
    #sgns-participantes-root.is-torneo #sgnsExportBtn { display: none; }

    .sgns-conf-btn.is-si { color: #22c55e; border-color: rgba(34, 197, 94, 0.5); background: rgba(34, 197, 94, 0.1); }
    .sgns-conf-btn.is-no { color: #ef4444; border-color: rgba(239, 68, 68, 0.5); background: rgba(239, 68, 68, 0.1); }
    .sgns-conf-btn.is-pend { color: #a1a1aa; }
    .sgns-conf-btn[disabled] { opacity: 0.4; }

    .sgns-torneo { flex-direction: column; gap: 14px; }
    .sgns-t-caja {
        background: rgba(17, 17, 20, 0.95);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 14px;
        padding: 16px;
    }
    .sgns-t-titulo { margin: 0 0 12px; font-size: 12px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; color: #a1a1aa; }
    .sgns-t-fila { display: flex; flex-wrap: wrap; gap: 10px; align-items: center; }
    .sgns-t-nums { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 10px; }
    .sgns-t-num { display: flex; flex-direction: column; gap: 2px; padding: 12px; border-radius: 12px; background: rgba(255, 255, 255, 0.04); }
    .sgns-t-num b { font-size: 24px; font-weight: 700; color: #ffffff; }
    .sgns-t-num span { font-size: 10.5px; font-weight: 600; letter-spacing: 1px; text-transform: uppercase; color: #a1a1aa; }
    .sgns-t-num.si b { color: #22c55e; }
    .sgns-t-num.no b { color: #ef4444; }
    .sgns-t-campos { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 12px; }
    .sgns-t-campo { display: flex; flex-direction: column; gap: 6px; }
    .sgns-t-campo label { font-size: 11px; font-weight: 600; letter-spacing: 0.5px; color: #a1a1aa; }
    .sgns-t-campo input, .sgns-t-campo select {
        height: 44px; padding: 0 12px; border-radius: 10px; border: 1px solid rgba(255, 255, 255, 0.15);
        background: #0c0c0f; color: #ffffff; font-size: 15px; font-family: inherit; width: 100%;
    }
    .sgns-t-nota { margin: 10px 0 0; font-size: 12.5px; line-height: 1.5; color: #a1a1aa; }

    /* Arrastrar y soltar equipos (ronda 1) */
    .sgns-t-eq.is-movible, .sgns-t-libre.is-movible { cursor: grab; -webkit-user-select: none; user-select: none; -webkit-touch-callout: none; }
    .sgns-t-libre {
        display: inline-flex; align-items: center; margin: 3px 2px; padding: 4px 10px; border-radius: 999px;
        border: 1px dashed rgba(255, 255, 255, 0.3); background: rgba(255, 255, 255, 0.05); color: #ffffff;
        font-family: inherit; font-size: 12px; font-weight: 600;
    }
    .sgns-t-arrastrando, .sgns-t-arrastrando * { cursor: grabbing !important; -webkit-user-select: none; user-select: none; }
    .is-arrastrado { opacity: 0.35; }
    .is-destino { outline: 2px solid #ffffff; outline-offset: -2px; background: rgba(255, 255, 255, 0.12) !important; }
    .sgns-t-fantasma {
        position: fixed; left: 0; top: 0; z-index: 100000; pointer-events: none; padding: 8px 12px; border-radius: 10px;
        background: #ffffff; color: #09090b; font-size: 13px; font-weight: 700; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    }
    .sgns-t-nota b { color: #ffffff; }
    .sgns-t-aviso { margin: 10px 0 0; padding: 10px 12px; border-radius: 10px; font-size: 12.5px; line-height: 1.45; color: #fde68a; background: rgba(234, 179, 8, 0.1); border: 1px solid rgba(234, 179, 8, 0.3); }
    .sgns-t-pend { display: flex; flex-direction: column; gap: 6px; max-height: 320px; overflow: auto; margin-top: 12px; }
    .sgns-t-pend-item { display: flex; align-items: center; justify-content: space-between; gap: 10px; padding: 8px 10px; border-radius: 10px; background: rgba(255, 255, 255, 0.03); font-size: 13px; }
    .sgns-t-pend-item span { color: #a1a1aa; font-size: 12px; }
    .sgns-t-ronda { margin: 18px 0 8px; font-size: 13px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; color: #ffffff; }
    .sgns-t-ronda small { margin-left: 8px; font-size: 11px; font-weight: 600; letter-spacing: 0.5px; color: #a1a1aa; }
    .sgns-t-partidos { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 10px; }
    .sgns-t-partido { border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 12px; overflow: hidden; background: #0c0c0f; }
    .sgns-t-partido-cab { display: flex; justify-content: space-between; gap: 8px; padding: 7px 10px; font-size: 11px; font-weight: 700; letter-spacing: 0.8px; text-transform: uppercase; color: #a1a1aa; background: rgba(255, 255, 255, 0.04); }
    .sgns-t-partido-cab b { color: #ffffff; }
    .sgns-t-eq {
        display: flex; align-items: center; justify-content: space-between; gap: 8px; width: 100%; min-height: 44px; padding: 8px 10px;
        border: 0; border-top: 1px solid rgba(255, 255, 255, 0.07); background: transparent; color: #ffffff;
        font-family: inherit; font-size: 13.5px; font-weight: 600; text-align: left; cursor: pointer;
    }
    /* Estado de asistencia en la lista */
    .sgns-t-est { margin: 0 6px; padding: 2px 8px; border-radius: 999px; font-size: 10.5px; font-style: normal; font-weight: 700; letter-spacing: 0.5px; color: #a1a1aa; background: rgba(255, 255, 255, 0.06); }
    .sgns-t-est.si { color: #22c55e; background: rgba(34, 197, 94, 0.12); }
    .sgns-t-est.no { color: #ef4444; background: rgba(239, 68, 68, 0.12); }
    .sgns-t-pend .sgns-action-btn.is-on { background: #ffffff; color: #09090b !important; border-color: #ffffff; opacity: 1; }

    /* Buscador de las llaves */
    .sgns-t-buscar { display: flex; align-items: center; gap: 12px; margin-top: 12px; }
    .sgns-t-buscar input {
        flex: 1; height: 44px; padding: 0 14px; border-radius: 10px; border: 1px solid rgba(255, 255, 255, 0.15);
        background: #0c0c0f; color: #ffffff; font-size: 15px; font-family: inherit;
    }
    .sgns-t-buscar-res { flex: none; font-size: 12px; font-weight: 600; color: #a1a1aa; }

    /* Cada ronda (llave) en su propio bloque, con su número; la final resaltada */
    .sgns-t-ronda-bloque {
        margin-top: 16px; padding: 4px 14px 14px; border-radius: 14px;
        background: rgba(255, 255, 255, 0.025); border: 1px solid rgba(255, 255, 255, 0.07);
    }
    .sgns-t-ronda-bloque.es-final { border-color: rgba(234, 179, 8, 0.45); background: rgba(234, 179, 8, 0.06); }
    .sgns-t-ronda-bloque .sgns-t-ronda { display: flex; align-items: center; gap: 10px; margin-top: 12px; }
    .sgns-t-ronda-num {
        display: inline-flex; align-items: center; justify-content: center; width: 26px; height: 26px;
        border-radius: 50%; background: #ffffff; color: #09090b; font-size: 12px; font-weight: 800; letter-spacing: 0;
    }
    .sgns-t-ronda-bloque.es-final .sgns-t-ronda-num { background: #eab308; }

    /* Cada cancha con su color (se repiten a partir de la séptima) */
    .sgns-t-cancha { padding: 3px 9px; border-radius: 999px; font-size: 10.5px; font-weight: 800; letter-spacing: 0.8px; color: #09090b; }
    .sgns-t-cancha.c1 { background: #60a5fa; }
    .sgns-t-cancha.c2 { background: #fb923c; }
    .sgns-t-cancha.c3 { background: #c084fc; }
    .sgns-t-cancha.c4 { background: #2dd4bf; }
    .sgns-t-cancha.c5 { background: #f472b6; }
    .sgns-t-cancha.c6 { background: #facc15; }

    /* Estados de cada llave */
    .sgns-t-ronda-est { margin-left: auto; padding: 4px 10px; border-radius: 999px; font-size: 10.5px; font-weight: 800; letter-spacing: 1px; }
    .sgns-t-ronda-canchas { display: inline-flex; gap: 4px; }
    .sgns-t-ronda-canchas .sgns-t-cancha { font-style: normal; padding: 3px 8px; }
    .sgns-t-ronda-bloque.is-terminada { opacity: 0.6; }
    .sgns-t-ronda-bloque.is-terminada .sgns-t-ronda-num { background: #22c55e; }
    .sgns-t-ronda-bloque.is-terminada .sgns-t-ronda-est { color: #22c55e; background: rgba(34, 197, 94, 0.12); }
    .sgns-t-ronda-bloque.is-en-juego { border-color: rgba(230, 0, 0, 0.7); background: rgba(230, 0, 0, 0.06); box-shadow: 0 0 0 3px rgba(230, 0, 0, 0.12); }
    .sgns-t-ronda-bloque.is-en-juego .sgns-t-ronda-num { background: #E60000; color: #ffffff; }
    .sgns-t-ronda-bloque.is-en-juego .sgns-t-ronda-est { color: #ffffff; background: #E60000; }
    .sgns-t-ronda-bloque.is-proxima { border-style: dashed; }
    .sgns-t-ronda-bloque.is-proxima .sgns-t-ronda-num { background: transparent; color: #a1a1aa; border: 1px dashed #71717a; }
    .sgns-t-ronda-bloque.is-proxima .sgns-t-ronda-est { color: #a1a1aa; background: rgba(255, 255, 255, 0.06); }

    /* Cada partido toma el color de su cancha arriba; los jugados quedan atenuados */
    .sgns-t-partido { border-top-width: 3px; }
    .sgns-t-partido.cancha-1 { border-top-color: #60a5fa; }
    .sgns-t-partido.cancha-2 { border-top-color: #fb923c; }
    .sgns-t-partido.cancha-3 { border-top-color: #c084fc; }
    .sgns-t-partido.cancha-4 { border-top-color: #2dd4bf; }
    .sgns-t-partido.cancha-5 { border-top-color: #f472b6; }
    .sgns-t-partido.cancha-6 { border-top-color: #facc15; }
    /* Más llamativo: cada partido entero con el color de su cancha (borde, fondo y cabecera llena) */
    .sgns-t-partido { --c: #60a5fa; border: 2px solid var(--c) !important; background: color-mix(in srgb, var(--c) 9%, #0c0c0f); }
    .sgns-t-partido.cancha-2 { --c: #fb923c; }
    .sgns-t-partido.cancha-3 { --c: #c084fc; }
    .sgns-t-partido.cancha-4 { --c: #2dd4bf; }
    .sgns-t-partido.cancha-5 { --c: #f472b6; }
    .sgns-t-partido.cancha-6 { --c: #facc15; }
    .sgns-t-partido .sgns-t-partido-cab { align-items: center; padding: 8px 10px; background: var(--c); color: #09090b; }
    .sgns-t-partido .sgns-t-partido-cab b { color: #09090b; font-size: 14px; }
    .sgns-t-partido .sgns-t-cancha { background: #09090b !important; color: var(--c); font-size: 11.5px; }
    .sgns-t-partido .sgns-t-eq-fila { border-top-color: color-mix(in srgb, var(--c) 25%, transparent); }

    /* Cada llave con una cabecera grande, como un separador */
    .sgns-t-ronda-bloque { padding: 0 14px 16px; margin-top: 22px; border-width: 2px; }
    .sgns-t-ronda-bloque .sgns-t-ronda {
        margin: 0 -14px 14px; padding: 14px; border-radius: 12px 12px 0 0;
        font-size: 18px; letter-spacing: 2px; background: rgba(255, 255, 255, 0.06);
    }
    .sgns-t-ronda-bloque .sgns-t-ronda-num { width: 34px; height: 34px; font-size: 15px; }
    .sgns-t-ronda-bloque.is-en-juego .sgns-t-ronda { background: #E60000; color: #ffffff; }
    .sgns-t-ronda-bloque.is-en-juego .sgns-t-ronda small { color: rgba(255, 255, 255, 0.85); }
    .sgns-t-ronda-bloque.is-en-juego .sgns-t-ronda-num { background: #ffffff; color: #E60000; }
    .sgns-t-ronda-bloque.is-en-juego .sgns-t-ronda-est { background: #ffffff; color: #E60000; }
    .sgns-t-ronda-bloque.is-terminada .sgns-t-ronda { background: rgba(34, 197, 94, 0.18); }
    .sgns-t-ronda-bloque.es-final .sgns-t-ronda { background: #eab308; color: #09090b; }
    .sgns-t-ronda-bloque.es-final .sgns-t-ronda small { color: rgba(9, 9, 11, 0.7); }

    .sgns-t-partido.is-jugado { opacity: 0.55; }
    .sgns-t-partido.is-listo { box-shadow: 0 6px 18px -10px rgba(0, 0, 0, 0.8); }

    .sgns-t-eq-fila { display: flex; align-items: stretch; border-top: 1px solid rgba(255, 255, 255, 0.07); }
    .sgns-t-eq-fila .sgns-t-eq { border-top: 0; flex: 1; min-width: 0; background: transparent !important; }
    .sgns-t-eq.is-vacio { color: #52525b !important; font-style: italic; }
    .sgns-t-eq.gano { background: rgba(34, 197, 94, 0.14) !important; }
    .sgns-t-wa {
        flex: none; display: flex; align-items: center; justify-content: center; width: 46px;
        border-left: 1px solid rgba(255, 255, 255, 0.07); color: #25d366; text-decoration: none !important;
    }
    .sgns-t-wa:hover { background: rgba(37, 211, 102, 0.14); }
    .sgns-t-edit {
        flex: none; display: flex; align-items: center; justify-content: center; width: 42px; padding: 0;
        border: 0; border-left: 1px solid rgba(255, 255, 255, 0.07); background: transparent; color: #a1a1aa; cursor: pointer;
    }
    .sgns-t-edit:hover { background: rgba(255, 255, 255, 0.08); color: #ffffff; }

    /* Repechaje: tarjeta con los nombres escritos a mano, y botón "+" al final de cada ronda */
    .sgns-t-mas {
        display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 2px; min-height: 120px;
        border: 2px dashed rgba(255, 255, 255, 0.25); border-radius: 12px; background: transparent; color: #a1a1aa;
        font-family: inherit; cursor: pointer;
    }
    .sgns-t-mas span { font-size: 34px; font-weight: 300; line-height: 1; }
    .sgns-t-mas small { font-size: 11px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; }
    .sgns-t-mas:hover { border-color: #ffffff; color: #ffffff; background: rgba(255, 255, 255, 0.04); }
    .sgns-t-repechaje { border-style: dashed !important; }
    .sgns-t-repechaje .sgns-t-partido-cab { align-items: center; }
    .sgns-t-rep-quitar {
        flex: none; margin-left: 6px; padding: 4px 10px; border: 1px solid rgba(239, 68, 68, 0.5); border-radius: 999px;
        background: rgba(239, 68, 68, 0.12); color: #fca5a5; font-family: inherit; font-size: 11px; font-weight: 700; letter-spacing: 0.5px; cursor: pointer;
    }
    .sgns-t-rep-quitar:hover { background: rgba(239, 68, 68, 0.25); color: #ffffff; }
    .sgns-t-rep-input {
        flex: 1; min-width: 0; min-height: 44px; padding: 8px 10px; border: 0; background: transparent; color: #ffffff;
        font-family: inherit; font-size: 13.5px; font-weight: 600; outline: none;
    }
    .sgns-t-rep-input::placeholder { color: #71717a; font-weight: 500; }
    .sgns-t-rep-input:focus { background: rgba(255, 255, 255, 0.06); }
    .sgns-t-rep-fila.gano .sgns-t-rep-input { color: #86efac; }
    .sgns-t-rep-fila.perdio .sgns-t-rep-input { color: #71717a; text-decoration: line-through; }
    .sgns-t-rep-gana {
        flex: none; width: 46px; border: 0; border-left: 1px solid rgba(255, 255, 255, 0.07); background: transparent;
        color: #a1a1aa; font-size: 16px; cursor: pointer;
    }
    .sgns-t-rep-gana:hover:not([disabled]) { background: rgba(34, 197, 94, 0.14); color: #86efac; }
    .sgns-t-rep-gana.gano { background: rgba(34, 197, 94, 0.2); color: #86efac; }
    .sgns-t-rep-gana[disabled] { cursor: default; opacity: 0.35; }
    .sgns-t-rep-destino { display: flex; flex-wrap: wrap; align-items: center; gap: 6px 8px; padding: 8px 10px; border-top: 1px solid rgba(255, 255, 255, 0.07); }
    .sgns-t-rep-destino label { font-size: 11px; font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase; color: #a1a1aa; }
    .sgns-t-rep-destino select { flex: 1; min-width: 0; height: 34px; padding: 0 8px; border-radius: 8px; border: 1px solid rgba(255, 255, 255, 0.15); background: #0c0c0f; color: #ffffff; font-family: inherit; font-size: 12.5px; }
    .sgns-t-rep-destino small { width: 100%; font-size: 11px; color: #71717a; }
    .sgns-t-eq:hover:not([disabled]) { background: rgba(255, 255, 255, 0.06); }
    .sgns-t-eq[disabled] { cursor: default; color: #71717a; font-weight: 500; }
    .sgns-t-eq small { flex: none; font-size: 11px; font-weight: 600; color: #a1a1aa; }
    .sgns-t-eq.gano { background: rgba(34, 197, 94, 0.14); color: #86efac; }
    .sgns-t-eq.perdio { color: #71717a; text-decoration: line-through; }
    .sgns-t-campeon { margin-top: 18px; padding: 16px; border-radius: 14px; text-align: center; background: rgba(34, 197, 94, 0.12); border: 1px solid rgba(34, 197, 94, 0.4); font-size: 18px; font-weight: 700; color: #86efac; }
    .sgns-t-estado { font-size: 12px; color: #a1a1aa; }

    @media (max-width: 768px) {
        .sgns-t-nums, .sgns-t-campos { grid-template-columns: repeat(2, minmax(0, 1fr)); }
    }
</style>

<script>
(function() {
    var P = window.__sgnsPanel;
    var caja = document.getElementById('sgnsTorneo');
    var boton = document.getElementById('sgnsTorneoBtn');
    var raiz = document.getElementById('sgns-participantes-root');
    if (!P || !caja || !boton) { return; }

    var DEPORTES = ['Fútbol', 'Básquet', 'Ping Pong'];
    var POR_DEFECTO = { inicio: '12:00', duracion: 10, descanso: 2, canchas: 1, incluir: 'confirmados' };
    var deporte = DEPORTES[0];
    var torneos = {};      // juego -> { config, llaves }
    var cargado = false;
    var estado = '';
    var preguntaReinicio = false;
    var filtroAsis = 'pend';
    var esc = P.escapeHtml;

    function sinTildes(s) { return String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
    function delDeporte(item, d) { return sinTildes(item.juego).indexOf(sinTildes(d).split(' ')[0]) !== -1; }
    function inscriptos(d) { return P.registros().filter(function(r) { return delDeporte(r, d); }); }
    function nombre(item) { return item.equipo || item.participante_1 || 'Sin nombre'; }

    // Edad promedio del equipo (o la del jugador en Ping Pong); null si no hay ninguna cargada
    function edadPromedio(item) {
        var n = P.esIndividual(item) ? 1 : 3, suma = 0, hay = 0;
        for (var i = 0; i < n; i++) {
            var e = P.getEdad(item, i);
            if (e !== null && !isNaN(Number(e))) { suma += Number(e); hay++; }
        }
        return hay ? Math.round(suma / hay * 10) / 10 : null;
    }

    function config(d) {
        var t = torneos[d] || {};
        var c = Object.assign({}, POR_DEFECTO, t.config || {});
        return c;
    }

    // ---------------------------------------------------------------------
    // Armado de las llaves (eliminación directa)
    // Se ordena por edad promedio y se cruzan vecinos: en la primera ronda cada equipo
    // juega contra el de edad más parecida. Los que no tienen edad se ubican al azar.
    // Se juega lo más posible: en cada ronda se arman todos los partidos que se puedan y, solo si
    // la cantidad es impar, pasa uno sin jugar. Ese lugar libre va rotando (al final en una ronda,
    // al principio en la siguiente) para que no le toque siempre al mismo.
    // Ej.: 21 equipos → 10 partidos + 1 libre → 11 → 5 + 1 → 6 → 3 → 1 + 1 → 2 → final.
    // El cuadro queda ordenado por edad, así los chicos y los grandes recién se cruzan al final.
    // Cada partido de la ronda 2 en adelante guarda en "de" de qué partidos anteriores salen sus equipos.
    // ---------------------------------------------------------------------
    function armarLlaves(equipos) {
        var conEdad = equipos.filter(function(e) { return e.edad !== null; }).sort(function(a, b) { return a.edad - b.edad; });
        var sinEdad = equipos.filter(function(e) { return e.edad === null; });
        var orden = conEdad.slice();
        sinEdad.forEach(function(e) { orden.splice(Math.floor(Math.random() * (orden.length + 1)), 0, e); });

        var n = orden.length;

        var mapa = {};
        orden.forEach(function(e) { mapa[e.id] = { nombre: e.nombre, edad: e.edad }; });

        // Ronda 1: todos en pares por edad; si son impares, pasa el de más edad
        var rondas = [], primera = [], i;
        for (i = 0; i + 1 < n; i += 2) { primera.push({ a: orden[i].id, b: orden[i + 1].id, ganador: null }); }
        if (n % 2) { primera.push({ a: orden[n - 1].id, b: null, ganador: orden[n - 1].id, libre: true }); }
        rondas.push(primera);
        // Rondas siguientes: los ganadores en pares; si quedan impares, uno libre (alternando la punta)
        var prev = primera, k = 1;
        while (prev.length > 1) {
            var m = prev.length, sig = [], desde = 0;
            if (m % 2 && k % 2) { sig.push({ a: null, b: null, ganador: null, libre: true, de: [0] }); desde = 1; }
            for (i = desde; i + 1 < m; i += 2) { sig.push({ a: null, b: null, ganador: null, de: [i, i + 1] }); }
            if (m % 2 && !(k % 2)) { sig.push({ a: null, b: null, ganador: null, libre: true, de: [m - 1] }); }
            rondas.push(sig);
            prev = sig;
            k++;
        }
        var llaves = { creado: new Date().toISOString(), equipos: mapa, rondas: rondas };
        propagar(llaves);
        return llaves;
    }

    // Lleva a cada ronda los ganadores de la anterior; si cambió un resultado, limpia lo que ya no vale
    // (llaves nuevas: cada partido dice en "de" de dónde salen sus equipos; las armadas antes
    // de ese cambio usan el cuadro clásico: el partido i sale de los partidos 2i y 2i+1)
    function propagar(llaves) {
        (llaves.rondas[0] || []).forEach(function(p) {
            if (p.repechaje && p.ganador && p.ganador !== p.a && p.ganador !== p.b) { p.ganador = null; }
        });
        for (var r = 1; r < llaves.rondas.length; r++) {
            var ant = llaves.rondas[r - 1];
            llaves.rondas[r].forEach(function(p, i) {
                if (p.repechaje) {
                    if (p.ganador && p.ganador !== p.a && p.ganador !== p.b) { p.ganador = null; }
                    return;
                }
                var de = p.de || [i * 2, i * 2 + 1];
                // Partidos eliminados a mano: si se borró un origen, el otro pasa directo;
                // si se borraron todos los orígenes, este partido tampoco existe
                var vivos = de.filter(function(x) { return ant[x] && !ant[x].eliminado; });
                if (!vivos.length && !p.repe) { p.eliminado = true; p.a = p.b = p.ganador = null; return; }
                if (vivos.length < de.length && !p.libre) {
                    var unico = (ant[vivos[0]] && ant[vivos[0]].ganador) || null;
                    if (p.repe) { var rpx = buscarRepechaje(llaves, p.repe); unico = vivos.length ? unico : ((rpx && rpx.p.ganador) || null); }
                    p.libre = true; p.a = unico; p.b = null; p.ganador = unico;
                    delete p.repe;
                    return;
                }
                var a = (ant[de[0]] && ant[de[0]].ganador) || null;
                var b = de.length > 1 ? ((ant[de[1]] && ant[de[1]].ganador) || null) : null;
                if (p.libre) {
                    // Pasa directo el ganador del origen que sigue en pie
                    var fte = vivos[0];
                    var av = fte !== undefined ? ((ant[fte] && ant[fte].ganador) || null) : null;
                    p.a = av; p.b = null; p.ganador = av;
                    return;
                }
                // Lugar que juega contra el ganador de un repechaje
                if (p.repe) { var rp = buscarRepechaje(llaves, p.repe); b = (rp && rp.p.ganador) || null; }
                if (p.a !== a || p.b !== b) {
                    p.a = a; p.b = b;
                    if (p.ganador !== a && p.ganador !== b) { p.ganador = null; }
                    if (!p.ganador) { p.ganador = null; }
                }
            });
        }
    }

    // Mover equipos a mano en la ronda 1 (arrastrar y soltar): se intercambian dos lugares.
    // Solo partidos sin resultado. Los que pasan directo se pueden mover mientras la ronda 2
    // no tenga resultados (si no, se borrarían).
    function libresMovibles(llaves) {
        return llaves.rondas.length < 2 || !llaves.rondas[1].some(function(p) { return !p.libre && p.ganador; });
    }
    function intercambiar(llaves, slotA, slotB) {
        if (slotA === slotB) { return false; }
        var la = slotA.split(':'), lb = slotB.split(':');
        var pa = llaves.rondas[0][+la[1]], pb = llaves.rondas[0][+lb[1]];
        if (!pa || !pb || pa.eliminado || pb.eliminado) { return false; }
        if ((pa.ganador && !pa.libre) || (pb.ganador && !pb.libre)) { return false; }
        if ((pa.libre || pb.libre) && !libresMovibles(llaves)) { return false; }
        var ida = pa[la[2]], idb = pb[lb[2]];
        if (!ida || !idb) { return false; }
        pa[la[2]] = idb;
        pb[lb[2]] = ida;
        if (pa.libre) { pa.ganador = pa.a; }
        if (pb.libre) { pb.ganador = pb.a; }
        propagar(llaves);
        return true;
    }

    // Repechaje: partido agregado a mano al final de una ronda (botón "+"), con los nombres de
    // los equipos escritos a mano. Su ganador puede ir a jugar contra el que pasa directo en una
    // ronda siguiente: ese lugar deja de ser libre y pasa a ser un partido.
    function buscarRepechaje(llaves, mid) {
        for (var r = 0; r < llaves.rondas.length; r++) {
            for (var i = 0; i < llaves.rondas[r].length; i++) {
                if (llaves.rondas[r][i].mid === mid) { return { r: r, i: i, p: llaves.rondas[r][i] }; }
            }
        }
        return null;
    }
    function agregarRepechaje(llaves, r) {
        var mid = 'rep' + Date.now().toString(36);
        llaves.equipos[mid + 'a'] = { nombre: '', edad: null };
        llaves.equipos[mid + 'b'] = { nombre: '', edad: null };
        llaves.rondas[r].push({ a: mid + 'a', b: mid + 'b', ganador: null, repechaje: true, mid: mid, destino: null });
    }
    // Saca al ganador de un repechaje del lugar al que iba: ese lugar vuelve a ser libre
    function soltarDestino(llaves, p) {
        if (!p.destino) { return; }
        var d = p.destino.split(':');
        var t = llaves.rondas[+d[0]] && llaves.rondas[+d[0]][+d[1]];
        if (t && t.repe === p.mid) { delete t.repe; t.libre = true; t.b = null; t.ganador = t.a; }
        p.destino = null;
    }
    function ponerDestino(llaves, p, destino) {
        soltarDestino(llaves, p);
        if (!destino) { return; }
        var d = destino.split(':');
        var t = llaves.rondas[+d[0]] && llaves.rondas[+d[0]][+d[1]];
        if (!t || !t.libre) { return; }
        t.libre = false; t.repe = p.mid; t.ganador = null;
        p.destino = destino;
    }
    function quitarRepechaje(llaves, mid) {
        var rp = buscarRepechaje(llaves, mid);
        if (!rp) { return; }
        soltarDestino(llaves, rp.p);
        llaves.rondas[rp.r].splice(rp.i, 1);
        delete llaves.equipos[mid + 'a'];
        delete llaves.equipos[mid + 'b'];
    }
    // Lugares a los que puede ir el ganador: los que pasan directo en las rondas siguientes
    function destinosRepechaje(llaves, r, mid) {
        var out = [];
        for (var k = r + 1; k < llaves.rondas.length; k++) {
            llaves.rondas[k].forEach(function(t, i) {
                if (!t.eliminado && (t.libre || t.repe === mid)) { out.push({ valor: k + ':' + i, r: k, t: t }); }
            });
        }
        return out;
    }

    // Horarios: cada ronda arranca cuando termina la anterior; por turno entran tantos partidos como canchas
    function horarios(llaves, c) {
        var partes = String(c.inicio || '12:00').split(':');
        var base = (parseInt(partes[0], 10) || 0) * 60 + (parseInt(partes[1], 10) || 0);
        var paso = Math.max(1, Number(c.duracion) || 0) + Math.max(0, Number(c.descanso) || 0);
        var canchas = Math.max(1, parseInt(c.canchas, 10) || 1);
        var turno = 0;
        llaves.rondas.forEach(function(ronda) {
            var k = 0;
            ronda.forEach(function(p) {
                if (p.libre || p.eliminado) { p.hora = null; p.cancha = null; return; }
                var min = base + (turno + Math.floor(k / canchas)) * paso;
                p.hora = ('0' + (Math.floor(min / 60) % 24)).slice(-2) + ':' + ('0' + (min % 60)).slice(-2);
                p.cancha = (k % canchas) + 1;
                k++;
            });
            turno += Math.ceil(k / canchas);
        });
        var fin = base + turno * paso - Math.max(0, Number(c.descanso) || 0);
        llaves.fin = ('0' + (Math.floor(fin / 60) % 24)).slice(-2) + ':' + ('0' + (fin % 60)).slice(-2);
        return llaves;
    }

    // Nombre según los partidos de la ronda (sin contar los que pasan libres): 1 Final, 2
    // Semifinales, 4 Cuartos, 8 Octavos (solo si nadie pasa libre); si no, "Ronda N"
    function nombreRonda(r, total, ronda) {
        if (!ronda) { return r === total - 1 ? 'Final' : 'Ronda ' + (r + 1); }
        var hayLibre = ronda.some(function(p) { return p.libre && !p.eliminado; });
        var partidos = ronda.filter(function(p) { return !p.libre && !p.eliminado; }).length;
        if (r === total - 1) { return 'Final'; }
        if (!hayLibre && partidos === 2) { return 'Semifinales'; }
        if (!hayLibre && partidos === 4) { return 'Cuartos de final'; }
        if (!hayLibre && partidos === 8) { return 'Octavos de final'; }
        return 'Ronda ' + (r + 1);
    }

    // ---------------------------------------------------------------------
    // Base de datos
    // ---------------------------------------------------------------------
    function cargarTorneos() {
        if (!P.sb) { cargado = true; return Promise.resolve(); }
        return P.sb.from('torneo_evento').select('*').then(function(res) {
            if (res.error) { throw res.error; }
            (res.data || []).forEach(function(f) { torneos[f.juego] = { config: f.config || {}, llaves: f.llaves || null }; });
            cargado = true;
        });
    }

    function guardar(d) {
        var t = torneos[d] || {};
        estado = 'Guardando…';
        pintarEstado();
        if (!P.sb) { estado = 'Sin conexión a la base: no se guardó.'; pintarEstado(); return Promise.resolve(); }
        return P.sb.from('torneo_evento').upsert({ juego: d, config: t.config || {}, llaves: t.llaves || null, updated_at: new Date().toISOString() }).then(function(res) {
            estado = res.error ? 'No se pudo guardar: ' + res.error.message : 'Guardado ' + new Date().toLocaleTimeString('es-AR', { hour: '2-digit', minute: '2-digit' });
            pintarEstado();
        });
    }

    function pintarEstado() {
        var e = caja.querySelector('.sgns-t-estado');
        if (e) { e.textContent = estado; }
    }

    // Asistencia: sin responder → viene → no viene → sin responder
    function cambiarAsistencia(id, btn) {
        var item = P.registros().filter(function(r) { return String(r.id) === String(id); })[0];
        if (!item || !P.sb) { return; }
        var nuevo = item.confirmado === true ? false : (item.confirmado === false ? null : true);
        if (btn) { btn.disabled = true; }
        P.sb.from(P.tabla).update({ confirmado: nuevo }).eq('id', item.id).select().then(function(res) {
            if (res.error || !res.data || !res.data.length) {
                alert('No se pudo guardar la asistencia.' + (res.error ? ' ' + res.error.message : ''));
            } else {
                item.confirmado = nuevo;
            }
            P.render();
            if (raiz.classList.contains('is-torneo')) { pintar(); }
        });
    }

    function telWa(item, msg) {
        var tel = String(item.telefono || '').replace(/\D/g, '').replace(/^0+/, '');
        if (!tel) { return null; }
        if (tel.indexOf('54') !== 0) { tel = '549' + tel; }
        return 'https://wa.me/' + tel + '?text=' + encodeURIComponent(msg);
    }

    // ---------------------------------------------------------------------
    // Pantalla
    // ---------------------------------------------------------------------
    function pintar() {
        var lista = inscriptos(deporte);
        var si = lista.filter(function(r) { return r.confirmado === true; });
        var no = lista.filter(function(r) { return r.confirmado === false; });
        var pend = lista.filter(function(r) { return r.confirmado !== true && r.confirmado !== false; });
        var c = config(deporte);
        var t = torneos[deporte] || {};
        var entran = c.incluir === 'todos' ? si.concat(pend) : si;
        var sinEdad = entran.filter(function(r) { return edadPromedio(r) === null; }).length;
        var h = '';

        h += '<div class="sgns-t-caja"><div class="sgns-t-fila" style="justify-content: space-between">' +
            '<div class="sgns-filter-pills">' + DEPORTES.map(function(d) {
                return '<button type="button" class="sgns-pill' + (d === deporte ? ' active' : '') + '" data-t-deporte="' + esc(d) + '">' + esc(d) + '</button>';
            }).join('') + '</div><span class="sgns-t-estado">' + esc(estado) + '</span></div></div>';

        // 1. Asistencia
        h += '<div class="sgns-t-caja"><p class="sgns-t-titulo">1 · Asistencia · ' + esc(deporte) + '</p>' +
            '<div class="sgns-t-nums">' +
            '<div class="sgns-t-num"><b>' + lista.length + '</b><span>Inscriptos</span></div>' +
            '<div class="sgns-t-num si"><b>' + si.length + '</b><span>Confirmados</span></div>' +
            '<div class="sgns-t-num"><b>' + pend.length + '</b><span>Sin responder</span></div>' +
            '<div class="sgns-t-num no"><b>' + no.length + '</b><span>No vienen</span></div></div>';
        // Lista por grupo: sin responder, presentes, ausentes o todos; desde cualquiera se puede cambiar el estado
        var grupos = { pend: pend, si: si, no: no, todos: lista };
        var nombresGrupo = { pend: 'Sin responder', si: 'Presentes', no: 'No vienen', todos: 'Todos' };
        var grupo = grupos[filtroAsis] || pend;
        h += '<div class="sgns-t-buscar"><input type="search" id="tBuscarAsis" placeholder="Buscar por nombre, apellido o equipo…" autocomplete="off" value="' + esc(busquedaAsis) + '" aria-label="Buscar en la asistencia"><span class="sgns-t-buscar-res" id="tBuscarAsisRes"></span></div>';
        h += '<div class="sgns-filter-pills" style="margin-top: 14px">' + ['pend', 'si', 'no', 'todos'].map(function(k) {
            return '<button type="button" class="sgns-pill' + (k === filtroAsis ? ' active' : '') + '" data-t-asis="' + k + '">' + nombresGrupo[k] + ' (' + grupos[k].length + ')</button>';
        }).join('') + '</div>';
        if (grupo.length) {
            h += '<div class="sgns-t-pend">' + grupo.map(function(r) {
                var c = r.confirmado;
                var est = c === true ? '<em class="sgns-t-est si">Presente</em>' : (c === false ? '<em class="sgns-t-est no">No viene</em>' : '<em class="sgns-t-est">Sin responder</em>');
                var wa = c === true || c === false ? null : telWa(r, '¡Hola! Somos del equipo de Signos. Te escribimos por el torneo del domingo 4/10: ¿nos confirmás si ' + (P.esIndividual(r) ? 'venís' : 'viene tu equipo "' + nombre(r) + '"') + ' a jugar ' + deporte + '? Así armamos las llaves. ¡Gracias!');
                var btn = function(valor, txt) {
                    var activo = c === valor;
                    return '<button type="button" class="sgns-action-btn sgns-btn-secondary' + (activo ? ' is-on' : '') + '" style="padding: 8px 12px" data-t-marcar="' + esc(r.id) + '" data-t-valor="' + (valor === null ? 'null' : valor) + '"' + (activo ? ' disabled' : '') + '>' + txt + '</button>';
                };
                return '<div class="sgns-t-pend-item" data-buscar="' + esc(sinTildes([nombre(r), r.equipo, r.participante_1, r.participante_2, r.participante_3, r.nombre, r.apellido].join(' '))) + '"><div><b>' + esc(nombre(r)) + '</b> ' + est + ' <span>' + esc(r.telefono || 'sin teléfono') + '</span></div><div class="sgns-t-fila" style="gap: 6px">' +
                    (wa ? '<a class="sgns-action-btn sgns-btn-secondary" style="padding: 8px 12px" href="' + wa + '" target="_blank" rel="noopener">WhatsApp</a>' : '') +
                    btn(true, 'Presente') + btn(false, 'No viene') + btn(null, 'Sin responder') + '</div></div>';
            }).join('') + '</div>';
        } else {
            h += '<p class="sgns-t-nota">' + (filtroAsis === 'pend' && lista.length ? 'Todos respondieron.' : 'No hay ninguno en este grupo.') + '</p>';
        }
        h += '</div>';

        // 2. Configuración
        h += '<div class="sgns-t-caja"><p class="sgns-t-titulo">2 · Horarios y canchas · ' + esc(deporte) + '</p><div class="sgns-t-campos">' +
            '<div class="sgns-t-campo"><label for="tInicio">Hora del primer partido</label><input type="time" id="tInicio" data-t-campo="inicio" value="' + esc(c.inicio) + '"></div>' +
            '<div class="sgns-t-campo"><label for="tDur">Duración del partido (min)</label><input type="number" id="tDur" data-t-campo="duracion" min="1" max="120" inputmode="numeric" value="' + esc(c.duracion) + '"></div>' +
            '<div class="sgns-t-campo"><label for="tDesc">Descanso entre partidos (min)</label><input type="number" id="tDesc" data-t-campo="descanso" min="0" max="60" inputmode="numeric" value="' + esc(c.descanso) + '"></div>' +
            '<div class="sgns-t-campo"><label for="tCanchas">' + (deporte === 'Ping Pong' ? 'Mesas' : 'Canchas') + ' a la vez</label><input type="number" id="tCanchas" data-t-campo="canchas" min="1" max="20" inputmode="numeric" value="' + esc(c.canchas) + '"></div>' +
            '<div class="sgns-t-campo" style="grid-column: 1 / -1"><label for="tIncluir">Quiénes entran en las llaves</label><select id="tIncluir" data-t-campo="incluir">' +
            '<option value="confirmados"' + (c.incluir !== 'todos' ? ' selected' : '') + '>Solo los confirmados (' + si.length + ')</option>' +
            '<option value="todos"' + (c.incluir === 'todos' ? ' selected' : '') + '>Confirmados y los que no respondieron (' + (si.length + pend.length) + ')</option></select></div></div>';
        if (entran.length >= 2) {
            var previa = horarios({ rondas: armarLlaves(entran.map(function(r) { return { id: String(r.id), nombre: nombre(r), edad: edadPromedio(r) }; })).rondas }, c);
            h += '<p class="sgns-t-nota">Con <b>' + entran.length + '</b> ' + (deporte === 'Ping Pong' ? 'jugadores' : 'equipos') + ' son <b>' + (entran.length - 1) + '</b> partidos en <b>' + previa.rondas.length + '</b> rondas. Empieza ' + esc(c.inicio) + ' y termina cerca de las <b>' + previa.fin + '</b>.</p>';
        }
        if (sinEdad) { h += '<p class="sgns-t-aviso">' + sinEdad + ' de los que entran no tienen edad cargada: se ubican al azar en el cuadro.</p>'; }
        h += '<div class="sgns-t-fila" style="margin-top: 14px">' +
            '<button type="button" class="sgns-action-btn sgns-btn-primary" data-t-armar' + (entran.length < 2 ? ' disabled' : '') + '>' + (t.llaves ? 'Volver a armar las llaves' : 'Armar las llaves') + '</button>' +
            (t.llaves ? '<button type="button" class="sgns-action-btn sgns-btn-secondary" data-t-horarios>Recalcular solo los horarios</button>' : '') +
            '<button type="button" class="sgns-action-btn sgns-btn-lock" data-t-reiniciar>Reiniciar</button>' +
            '</div>';
        if (preguntaReinicio) {
            h += '<div class="sgns-t-aviso" style="margin-top: 14px"><b>¿Qué querés reiniciar de ' + esc(deporte) + '?</b><br>Las llaves incluyen los cruces, los resultados cargados y los horarios. La asistencia vuelve a todos a "sin responder".' +
                '<div class="sgns-t-fila" style="margin-top: 12px">' +
                '<button type="button" class="sgns-action-btn sgns-btn-secondary" data-t-reinicio="llaves">Solo las llaves</button>' +
                '<button type="button" class="sgns-action-btn sgns-btn-lock" data-t-reinicio="todo">Llaves y asistencia</button>' +
                '<button type="button" class="sgns-action-btn sgns-btn-secondary" data-t-reinicio="cancelar">Cancelar</button>' +
                '</div></div>';
        }
        h += '</div>';

        // 3. Llaves
        if (t.llaves) {
            var ll = t.llaves, total = ll.rondas.length;
            var eq = function(id) {
                var base = ll.equipos[id] || { nombre: '?', edad: null };
                var reg = P.registros().filter(function(x) { return String(x.id) === String(id); })[0];
                if (!reg && base.nombre === '') { return { nombre: 'Equipo sin nombre', edad: null }; }
                return reg ? { nombre: nombre(reg), edad: base.edad } : base;
            };
            h += '<div class="sgns-t-caja"><div class="sgns-t-fila" style="justify-content: space-between"><p class="sgns-t-titulo" style="margin: 0">3 · Llaves y fixture · ' + esc(deporte) + '</p>' +
                '<button type="button" class="sgns-action-btn sgns-btn-secondary" data-t-copiar>Copiar fixture</button></div>' +
                '<p class="sgns-t-nota">Tocá al ganador de cada partido y pasa solo a la ronda siguiente. En la ronda 1 podés arrastrar un equipo sobre otro para intercambiarlos (en el celular, mantené apretado y mové).</p>' +
                '<div class="sgns-t-buscar"><input type="search" id="tBuscar" placeholder="Buscar por equipo o jugador…" autocomplete="off" value="' + esc(busqueda) + '" aria-label="Buscar en el torneo"><span class="sgns-t-buscar-res" id="tBuscarRes"></span></div>';
            // Texto para buscar en cada partido: nombres de los equipos y de sus jugadores
            var buscable = function(id) {
                if (!id) { return ''; }
                var reg = P.registros().filter(function(x) { return String(x.id) === String(id); })[0] || {};
                return [eq(id).nombre, reg.participante_1, reg.participante_2, reg.participante_3].join(' ');
            };
            ll.rondas.forEach(function(ronda, r) {
                var jugables = ronda.filter(function(p) { return !p.libre && !p.eliminado; });
                var libres = ronda.filter(function(p) { return p.libre && !p.eliminado; });
                // Estado de la llave: terminada (todos con ganador), en juego (hay partidos listos) o próxima
                var jugados = jugables.filter(function(p) { return p.ganador; }).length;
                var listos = jugables.filter(function(p) { return p.a && p.b; }).length;
                var est = jugables.length && jugados === jugables.length ? 'terminada' : (listos ? 'en-juego' : 'proxima');
                var etiqueta = { terminada: 'Terminada', 'en-juego': 'En juego · ' + jugados + '/' + jugables.length, proxima: 'Próxima' }[est];
                var canchasRonda = [];
                jugables.forEach(function(p) { if (canchasRonda.indexOf(p.cancha || 1) === -1) { canchasRonda.push(p.cancha || 1); } });
                canchasRonda.sort(function(a, b) { return a - b; });
                h += '<section class="sgns-t-ronda-bloque is-' + est + (r === total - 1 ? ' es-final' : '') + '"><p class="sgns-t-ronda"><span class="sgns-t-ronda-num">' + (est === 'terminada' ? '✓' : (r + 1)) + '</span>' + nombreRonda(r, total, ronda) +
                    '<small>' + jugables.length + (jugables.length === 1 ? ' partido' : ' partidos') + '</small><span class="sgns-t-ronda-est">' + etiqueta + '</span>' +
                    (canchasRonda.length > 1 ? '<span class="sgns-t-ronda-canchas">' + canchasRonda.map(function(n) { return '<i class="sgns-t-cancha c' + ((n - 1) % 6 + 1) + '">' + n + '</i>'; }).join('') + '</span>' : '') +
                    '</p><div class="sgns-t-partidos">';
                ronda.forEach(function(p, i) {
                    if (p.libre || p.eliminado) { return; }
                    if (p.repechaje) {
                        var ncR = ((p.cancha || 1) - 1) % 6 + 1;
                        var filaR = function(id, lado) {
                            var nom = (ll.equipos[id] || {}).nombre || '';
                            var cls = p.ganador ? (p.ganador === id ? ' gano' : ' perdio') : '';
                            var listoR = ((ll.equipos[p.a] || {}).nombre || '') && ((ll.equipos[p.b] || {}).nombre || '');
                            return '<div class="sgns-t-eq-fila sgns-t-rep-fila' + cls + '"><input type="text" class="sgns-t-rep-input" data-t-rep-nombre="' + esc(p.mid) + ':' + lado + '" placeholder="Equipo ' + (lado === 'a' ? '1' : '2') + '" value="' + esc(nom) + '" autocomplete="off">' +
                                '<button type="button" class="sgns-t-rep-gana' + cls + '" data-t-gana="' + r + ':' + i + ':' + esc(id) + '"' + (listoR ? '' : ' disabled') + ' title="Marcar ganador" aria-label="Marcar ganador">✓</button></div>';
                        };
                        var dests = destinosRepechaje(ll, r, p.mid);
                        var selDest = '<div class="sgns-t-rep-destino"><label>El ganador va a</label><select data-t-rep-destino="' + esc(p.mid) + '"><option value="">Ningún lugar por ahora</option>' +
                            dests.map(function(d) {
                                var quien = d.t.a ? eq(d.t.a).nombre : 'el que pasa directo (a definir)';
                                return '<option value="' + d.valor + '"' + (p.destino === d.valor ? ' selected' : '') + '>' + esc(nombreRonda(d.r, total, ll.rondas[d.r])) + ' · contra ' + esc(quien) + '</option>';
                            }).join('') + '</select>' + (dests.length ? '' : '<small>No hay equipos que pasen directo en las rondas siguientes.</small>') + '</div>';
                        h += '<div class="sgns-t-partido sgns-t-repechaje cancha-' + ncR + (p.ganador ? ' is-jugado' : '') + '" data-buscar="' + esc(sinTildes(((ll.equipos[p.a] || {}).nombre || '') + ' ' + ((ll.equipos[p.b] || {}).nombre || ''))) + '"><div class="sgns-t-partido-cab"><b>Repechaje · ' + esc(p.hora || '') + ' hs</b><span class="sgns-t-cancha c' + ncR + '">' + (deporte === 'Ping Pong' ? 'Mesa ' : 'Cancha ') + (p.cancha || 1) + '</span>' +
                            '<button type="button" class="sgns-t-rep-quitar" data-t-rep-quitar="' + esc(p.mid) + '" title="Eliminar este repechaje" aria-label="Eliminar este repechaje">✕ Eliminar</button></div>' +
                            filaR(p.a, 'a') + filaR(p.b, 'b') + selDest + '</div>';
                        return;
                    }
                    var fila = function(id, lado) {
                        if (!id) { return '<div class="sgns-t-eq-fila"><button type="button" class="sgns-t-eq is-vacio" disabled><span>A definir</span></button></div>'; }
                        var e = eq(id);
                        var cls = p.ganador ? (p.ganador === id ? ' gano' : ' perdio') : '';
                        // Ronda 1 sin resultado: el equipo se puede arrastrar a otro lugar
                        var slot = r === 0 && !p.ganador ? ' data-t-slot="0:' + i + ':' + lado + '"' : '';
                        if (slot) { cls += ' is-movible'; }
                        var listo = p.a && p.b;
                        var rival = id === p.a ? p.b : p.a;
                        var wa = rival ? waPartido(id, rival, p, nombreRonda(r, total, ronda)) : null;
                        return '<div class="sgns-t-eq-fila"><button type="button" class="sgns-t-eq' + cls + '" data-t-gana="' + r + ':' + i + ':' + esc(id) + '"' + slot + (listo ? '' : ' disabled') + '><span>' + esc(e.nombre) + '</span><small>' + (e.edad === null ? 's/edad' : e.edad + ' años') + '</small></button>' +
                            '<button type="button" class="sgns-t-edit" data-t-editar="' + esc(id) + '" aria-label="Editar ' + esc(e.nombre) + '" title="Editar equipo"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"></path><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4z"></path></svg></button>' +
                            (wa ? '<a class="sgns-t-wa" href="' + wa + '" target="_blank" rel="noopener" aria-label="Avisarle a ' + esc(e.nombre) + ' por WhatsApp" title="Avisarle a ' + esc(e.nombre) + ' por WhatsApp"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.4 8.4 0 0 1-12.4 7.4L3 20.5l1.7-5.4A8.4 8.4 0 1 1 21 11.5z"></path><path d="M9 8.5c0 3.5 3 6.5 6.5 6.5l1-1.5-2-1-1 .8c-.9-.4-1.7-1.2-2.1-2.1l.8-1-1-2z"></path></svg></a>' : '') +
                            '</div>';
                    };
                    var nc = ((p.cancha || 1) - 1) % 6 + 1;
                    h += '<div class="sgns-t-partido cancha-' + nc + (p.ganador ? ' is-jugado' : (p.a && p.b ? ' is-listo' : '')) + (p.repe ? ' sgns-t-con-repechaje' : '') + '" data-buscar="' + esc(sinTildes(buscable(p.a) + ' ' + buscable(p.b))) + '"><div class="sgns-t-partido-cab"><b>' + esc(p.hora || '') + ' hs</b><span class="sgns-t-cancha c' + nc + '">' + (deporte === 'Ping Pong' ? 'Mesa ' : 'Cancha ') + (p.cancha || 1) + '</span></div>' + fila(p.a, 'a') + fila(p.b, 'b') + '</div>';
                });
                h += '<button type="button" class="sgns-t-mas" data-t-rep-add="' + r + '" title="Agregar un repechaje en esta ronda" aria-label="Agregar un repechaje en esta ronda"><span>+</span><small>Repechaje</small></button>';
                h += '</div>';
                if (libres.length && r === 0 && libresMovibles(ll)) {
                    h += '<p class="sgns-t-nota" data-buscar-libres="' + esc(sinTildes(libres.map(function(p) { return buscable(p.a); }).join(' '))) + '">Pasan directo a la ronda siguiente (' + libres.length + '): ' +
                        ronda.map(function(p, i) { return p.libre && !p.eliminado ? '<button type="button" class="sgns-t-libre is-movible" data-t-slot="0:' + i + ':a">' + esc(eq(p.a).nombre) + '</button>' : ''; }).join(' ') + '</p>';
                } else if (libres.length) {
                    h += '<p class="sgns-t-nota" data-buscar-libres="' + esc(sinTildes(libres.map(function(p) { return buscable(p.a); }).join(' '))) + '">Pasan directo a la ronda siguiente (' + libres.length + '): ' + libres.map(function(p) { return p.a ? esc(eq(p.a).nombre) : 'a definir (el ganador de la ronda anterior)'; }).join(', ') + '.</p>';
                }
                h += '</section>';
            });
            var campeon = ll.rondas[total - 1][0].ganador;
            if (campeon) { h += '<div class="sgns-t-campeon">Campeón de ' + esc(deporte) + ': ' + esc(eq(campeon).nombre) + '</div>'; }
            h += '</div>';
        }

        caja.innerHTML = h;
        filtrarPartidos();
        filtrarAsistencia();
    }

    // Búsqueda dentro de las llaves: muestra solo los partidos donde aparece el equipo o el jugador
    var busqueda = '';
    function filtrarPartidos() {
        var q = sinTildes(busqueda).trim();
        var visibles = 0;
        caja.querySelectorAll('.sgns-t-ronda-bloque').forEach(function(bloque) {
            var hay = 0;
            bloque.querySelectorAll('.sgns-t-partido').forEach(function(pt) {
                var ok = !q || pt.getAttribute('data-buscar').indexOf(q) !== -1;
                pt.style.display = ok ? '' : 'none';
                if (ok) { hay++; }
            });
            var lib = bloque.querySelector('[data-buscar-libres]');
            var libOk = lib && (!q || lib.getAttribute('data-buscar-libres').indexOf(q) !== -1);
            if (lib) { lib.style.display = libOk ? '' : 'none'; }
            bloque.style.display = (hay || libOk || !q) ? '' : 'none';
            visibles += hay;
        });
        var res = document.getElementById('tBuscarRes');
        if (res) { res.textContent = q ? (visibles ? visibles + (visibles === 1 ? ' partido' : ' partidos') : 'Sin resultados') : ''; }
    }

    // Búsqueda en la asistencia: por nombre del equipo, de los jugadores o del que se inscribió
    var busquedaAsis = '';
    function filtrarAsistencia() {
        var q = sinTildes(busquedaAsis).trim();
        var n = 0;
        caja.querySelectorAll('.sgns-t-pend-item').forEach(function(it) {
            var ok = !q || it.getAttribute('data-buscar').indexOf(q) !== -1;
            it.style.display = ok ? '' : 'none';
            if (ok) { n++; }
        });
        var res = document.getElementById('tBuscarAsisRes');
        if (res) { res.textContent = q ? (n ? n + (n === 1 ? ' resultado' : ' resultados') : 'Sin resultados') : ''; }
    }

    caja.addEventListener('input', function(e) {
        if (e.target.id === 'tBuscarAsis') { busquedaAsis = e.target.value; filtrarAsistencia(); return; }
        if (e.target.id !== 'tBuscar') { return; }
        busqueda = e.target.value;
        filtrarPartidos();
    });

    // WhatsApp al representante de un equipo: su rival, la hora del partido y que llegue media hora antes
    function waPartido(id, rivalId, p, ronda) {
        var item = P.registros().filter(function(r) { return String(r.id) === String(id); })[0];
        var ll = torneos[deporte].llaves;
        if (!item || !p.hora) { return null; }
        // Mensaje único: que venga ya
        var msg = '¡Venite que ya estás por jugar!!';
        return telWa(item, msg);
    }

    function textoFixture() {
        var t = torneos[deporte];
        if (!t || !t.llaves) { return ''; }
        var ll = t.llaves, total = ll.rondas.length, out = ['TORNEO SIGNOS · ' + deporte.toUpperCase(), ''];
        var n = function(id) {
            if (!id) { return 'A definir'; }
            var reg = P.registros().filter(function(x) { return String(x.id) === String(id); })[0];
            var e = ll.equipos[id];
            return reg ? nombre(reg) : (e ? e.nombre : '?');
        };
        ll.rondas.forEach(function(ronda, r) {
            out.push(nombreRonda(r, total, ronda).toUpperCase());
            ronda.forEach(function(p) {
                if (p.libre || p.eliminado) { return; }
                out.push((p.repechaje ? 'Repechaje · ' : '') + p.hora + ' hs · ' + (deporte === 'Ping Pong' ? 'Mesa ' : 'Cancha ') + p.cancha + ' · ' + (n(p.a) || 'Equipo 1') + ' vs ' + (n(p.b) || 'Equipo 2'));
            });
            var libres = ronda.filter(function(p) { return p.libre && !p.eliminado; });
            if (libres.length) { out.push('Pasan directo: ' + libres.map(function(p) { return n(p.a); }).join(', ')); }
            out.push('');
        });
        return out.join('\n');
    }

    // ---------------------------------------------------------------------
    // Eventos
    // ---------------------------------------------------------------------
    document.addEventListener('click', function(e) {
        var b = e.target.closest ? e.target.closest('[data-conf-id]') : null;
        if (b) { cambiarAsistencia(b.getAttribute('data-conf-id'), b); }
    });

    function marcar(id, valor) {
        var item = P.registros().filter(function(r) { return String(r.id) === String(id); })[0];
        if (!item || !P.sb) { return; }
        P.sb.from(P.tabla).update({ confirmado: valor }).eq('id', item.id).select().then(function(res) {
            if (res.error || !res.data || !res.data.length) { alert('No se pudo guardar la asistencia.'); } else { item.confirmado = valor; }
            P.render();
            pintar();
        });
    }

    // ---------------------------------------------------------------------
    // Arrastrar y soltar equipos entre partidos de la ronda 1
    // Mouse: apretar y mover. Dedo: mantener apretado un momento y mover (si se desliza de una,
    // scrollea normal). Al soltar sobre otro equipo, se intercambian los dos lugares.
    // ---------------------------------------------------------------------
    var suprimirClick = false;
    var arr = null; // { el, slot, x0, y0, activo, fantasma, destino, timer, toque }
    function arrDestino(x, y) {
        if (arr.fantasma) { arr.fantasma.style.display = 'none'; }
        var bajo = document.elementFromPoint(x, y);
        if (arr.fantasma) { arr.fantasma.style.display = ''; }
        var d = bajo && bajo.closest ? bajo.closest('[data-t-slot]') : null;
        return d && d !== arr.el && caja.contains(d) ? d : null;
    }
    function arrEmpezar() {
        arr.activo = true;
        clearTimeout(arr.timer);
        var nombre = (arr.el.querySelector('span') || arr.el).textContent;
        arr.fantasma = document.createElement('div');
        arr.fantasma.className = 'sgns-t-fantasma';
        arr.fantasma.textContent = nombre;
        document.body.appendChild(arr.fantasma);
        arr.el.classList.add('is-arrastrado');
        caja.classList.add('sgns-t-arrastrando');
        caja.setAttribute('data-lenis-prevent', ''); // que el scroll suave no mueva la página mientras tanto
        if (arr.toque && navigator.vibrate) { navigator.vibrate(15); }
    }
    function arrMover(x, y) {
        if (!arr || !arr.activo) { return; }
        arr.fantasma.style.transform = 'translate(' + (x + 12) + 'px, ' + (y + 12) + 'px)';
        var d = arrDestino(x, y);
        if (d !== arr.destino) {
            if (arr.destino) { arr.destino.classList.remove('is-destino'); }
            arr.destino = d;
            if (d) { d.classList.add('is-destino'); }
        }
    }
    function arrTerminar(soltar) {
        if (!arr) { return; }
        clearTimeout(arr.timer);
        var a = arr;
        arr = null;
        if (!a.activo) { return; }
        suprimirClick = true;
        setTimeout(function() { suprimirClick = false; }, 400);
        if (a.fantasma) { a.fantasma.remove(); }
        a.el.classList.remove('is-arrastrado');
        if (a.destino) { a.destino.classList.remove('is-destino'); }
        caja.classList.remove('sgns-t-arrastrando');
        caja.removeAttribute('data-lenis-prevent');
        var t = torneos[deporte];
        if (soltar && a.destino && t && t.llaves && intercambiar(t.llaves, a.slot, a.destino.getAttribute('data-t-slot'))) {
            estado = 'Equipos intercambiados.';
            guardar(deporte);
            pintar();
        }
    }
    caja.addEventListener('mousedown', function(e) {
        if (e.button !== 0) { return; }
        var el = e.target.closest ? e.target.closest('[data-t-slot]') : null;
        if (!el) { return; }
        arr = { el: el, slot: el.getAttribute('data-t-slot'), x0: e.clientX, y0: e.clientY, activo: false };
    });
    document.addEventListener('mousemove', function(e) {
        if (!arr || arr.toque) { return; }
        if (!arr.activo && Math.abs(e.clientX - arr.x0) + Math.abs(e.clientY - arr.y0) > 6) { arrEmpezar(); }
        if (arr.activo) { e.preventDefault(); arrMover(e.clientX, e.clientY); }
    });
    document.addEventListener('mouseup', function() { if (arr && !arr.toque) { arrTerminar(true); } });
    caja.addEventListener('touchstart', function(e) {
        var el = e.target.closest ? e.target.closest('[data-t-slot]') : null;
        if (!el || e.touches.length !== 1) { return; }
        var tq = e.touches[0];
        arr = { el: el, slot: el.getAttribute('data-t-slot'), x0: tq.clientX, y0: tq.clientY, activo: false, toque: true };
        arr.timer = setTimeout(function() { if (arr) { arrEmpezar(); arrMover(arr.x0, arr.y0); } }, 350);
    }, { passive: true });
    document.addEventListener('touchmove', function(e) {
        if (!arr || !arr.toque) { return; }
        var tq = e.touches[0];
        if (!arr.activo) {
            // Se movió antes de mantener apretado: es un scroll, no un arrastre
            if (Math.abs(tq.clientX - arr.x0) + Math.abs(tq.clientY - arr.y0) > 10) { arrTerminar(false); }
            return;
        }
        e.preventDefault();
        arrMover(tq.clientX, tq.clientY);
    }, { passive: false });
    document.addEventListener('touchend', function() { if (arr && arr.toque) { arrTerminar(true); } });
    document.addEventListener('touchcancel', function() { if (arr && arr.toque) { arrTerminar(false); } });
    // Mantener apretado no tiene que abrir el menú del navegador sobre un equipo
    caja.addEventListener('contextmenu', function(e) { if (e.target.closest && e.target.closest('[data-t-slot]')) { e.preventDefault(); } });

    caja.addEventListener('click', function(e) {
        if (suprimirClick) { suprimirClick = false; e.preventDefault(); e.stopPropagation(); return; }
        var el = e.target.closest ? e.target.closest('button') : null;
        if (!el) { return; }
        var t;
        if (el.hasAttribute('data-t-editar')) { if (P.editar) { P.editar(el.getAttribute('data-t-editar')); } return; }
        if (el.hasAttribute('data-t-rep-add')) {
            t = torneos[deporte];
            if (!t || !t.llaves) { return; }
            agregarRepechaje(t.llaves, +el.getAttribute('data-t-rep-add'));
            horarios(t.llaves, config(deporte));
            estado = 'Repechaje agregado: escribí los nombres de los equipos (si lo creaste sin querer, tocá "Eliminar").';
            guardar(deporte);
            pintar();
            // Foco en el primer nombre del repechaje nuevo
            var nuevos = caja.querySelectorAll('.sgns-t-repechaje .sgns-t-rep-input');
            if (nuevos.length) { nuevos[nuevos.length - 2].focus(); }
            return;
        }
        if (el.hasAttribute('data-t-rep-quitar')) {
            t = torneos[deporte];
            if (!t || !t.llaves) { return; }
            if (!confirm('¿Eliminar este repechaje? Si su ganador iba a jugar contra alguien, ese equipo vuelve a pasar directo.')) { return; }
            quitarRepechaje(t.llaves, el.getAttribute('data-t-rep-quitar'));
            propagar(t.llaves);
            horarios(t.llaves, config(deporte));
            guardar(deporte);
            pintar();
            return;
        }
        if (el.hasAttribute('data-t-deporte')) { deporte = el.getAttribute('data-t-deporte'); estado = ''; preguntaReinicio = false; pintar(); return; }
        if (el.hasAttribute('data-t-asis')) { filtroAsis = el.getAttribute('data-t-asis'); pintar(); return; }
        if (el.hasAttribute('data-t-marcar')) {
            var v = el.getAttribute('data-t-valor');
            marcar(el.getAttribute('data-t-marcar'), v === 'null' ? null : v === 'true');
            return;
        }
        if (el.hasAttribute('data-t-armar')) {
            t = torneos[deporte] = torneos[deporte] || {};
            if (t.llaves && !confirm('Ya hay llaves armadas para ' + deporte + '. Si las volvés a armar se pierden los cruces y los resultados cargados. ¿Seguimos?')) { return; }
            var c = config(deporte);
            var lista = inscriptos(deporte).filter(function(r) { return r.confirmado === true || (c.incluir === 'todos' && r.confirmado !== false); });
            t.config = c;
            t.llaves = horarios(armarLlaves(lista.map(function(r) { return { id: String(r.id), nombre: nombre(r), edad: edadPromedio(r) }; })), c);
            guardar(deporte);
            pintar();
            return;
        }
        // Reiniciar: borra las llaves, los resultados y la configuración de este deporte. La asistencia queda
        if (el.hasAttribute('data-t-reiniciar')) {
            // Primero pregunta qué reiniciar (se muestra debajo de los botones)
            preguntaReinicio = true;
            pintar();
            return;
        }
        if (el.hasAttribute('data-t-reinicio')) {
            var que = el.getAttribute('data-t-reinicio');
            preguntaReinicio = false;
            if (que === 'cancelar') { pintar(); return; }
            if (!P.sb) { estado = 'Sin conexión a la base: no se reinició.'; pintar(); return; }
            var d = deporte;
            delete torneos[d];
            estado = 'Reiniciando…';
            pintar();
            var pasos = [P.sb.from('torneo_evento').delete().eq('juego', d)];
            if (que === 'todo') {
                // La asistencia de todos los inscriptos de este deporte vuelve a "sin responder"
                var ids = inscriptos(d).filter(function(r) { return r.confirmado === true || r.confirmado === false; }).map(function(r) { return r.id; });
                if (ids.length) { pasos.push(P.sb.from(P.tabla).update({ confirmado: null }).in('id', ids).select('id')); }
            }
            Promise.all(pasos).then(function(res) {
                var fallo = res.filter(function(x) { return x.error; })[0];
                if (!fallo && que === 'todo') { inscriptos(d).forEach(function(r) { r.confirmado = null; }); }
                estado = fallo ? 'No se pudo reiniciar: ' + fallo.error.message
                    : (que === 'todo' ? 'Llaves y asistencia de ' + d + ' reiniciadas.' : 'Llaves de ' + d + ' reiniciadas.');
                P.render();
                pintar();
            });
            return;
        }
        if (el.hasAttribute('data-t-horarios')) {
            t = torneos[deporte];
            if (!t || !t.llaves) { return; }
            t.config = config(deporte);
            horarios(t.llaves, t.config);
            guardar(deporte);
            pintar();
            return;
        }
        if (el.hasAttribute('data-t-gana')) {
            t = torneos[deporte];
            var partes = el.getAttribute('data-t-gana').split(':');
            var p = t.llaves.rondas[+partes[0]][+partes[1]];
            var id = partes.slice(2).join(':');
            p.ganador = p.ganador === id ? null : id;   // tocar de nuevo al ganador lo desmarca
            propagar(t.llaves);
            guardar(deporte);
            pintar();
            return;
        }
        if (el.hasAttribute('data-t-copiar')) {
            var txt = textoFixture();
            var ok = function() { estado = 'Fixture copiado: pegalo en WhatsApp.'; pintarEstado(); };
            if (navigator.clipboard && navigator.clipboard.writeText) { navigator.clipboard.writeText(txt).then(ok, function() { prompt('Copiá el fixture:', txt); }); }
            else { prompt('Copiá el fixture:', txt); }
        }
    });

    // Los campos de configuración se guardan al cambiar (las llaves no se tocan hasta rearmar o recalcular)
    caja.addEventListener('change', function(e) {
        var tRep = torneos[deporte];
        // Nombre de un equipo de repechaje, escrito a mano
        var repNom = e.target.getAttribute && e.target.getAttribute('data-t-rep-nombre');
        if (repNom && tRep && tRep.llaves) {
            var pr = repNom.split(':');
            var idR = pr[0] + pr[1];
            tRep.llaves.equipos[idR] = tRep.llaves.equipos[idR] || { nombre: '', edad: null };
            tRep.llaves.equipos[idR].nombre = e.target.value.trim();
            guardar(deporte);
            // Sin redibujar (así no se pierde el foco al pasar al otro nombre): solo se habilita
            // marcar ganador cuando los dos equipos tienen nombre
            var tarjeta = e.target.closest('.sgns-t-repechaje');
            if (tarjeta) {
                var completos = Array.prototype.every.call(tarjeta.querySelectorAll('.sgns-t-rep-input'), function(x) { return x.value.trim(); });
                tarjeta.querySelectorAll('.sgns-t-rep-gana').forEach(function(b) { b.disabled = !completos; });
            }
            return;
        }
        // A dónde va el ganador del repechaje
        var repDest = e.target.getAttribute && e.target.getAttribute('data-t-rep-destino');
        if (repDest && tRep && tRep.llaves) {
            var rpD = buscarRepechaje(tRep.llaves, repDest);
            if (rpD) {
                ponerDestino(tRep.llaves, rpD.p, e.target.value);
                propagar(tRep.llaves);
                horarios(tRep.llaves, config(deporte));
                guardar(deporte);
                pintar();
            }
            return;
        }
        var campo = e.target.getAttribute && e.target.getAttribute('data-t-campo');
        if (!campo) { return; }
        var t = torneos[deporte] = torneos[deporte] || {};
        var c = config(deporte);
        c[campo] = (campo === 'inicio' || campo === 'incluir') ? e.target.value : Math.max(campo === 'descanso' ? 0 : 1, parseInt(e.target.value, 10) || 0);
        t.config = c;
        guardar(deporte);
        pintar();
    });

    boton.addEventListener('click', function() {
        var abrir = !raiz.classList.contains('is-torneo');
        raiz.classList.toggle('is-torneo', abrir);
        caja.style.display = abrir ? 'flex' : 'none';
        document.getElementById('sgnsTorneoBtnTxt').textContent = abrir ? 'SALIR DEL TORNEO' : 'ARMAR TORNEO';
        // El título y el subtítulo cambian para que se note el modo
        var titulo = raiz.querySelector('.sgns-part-title'), sub = raiz.querySelector('.sgns-part-subtitle');
        if (titulo) {
            if (!titulo.dataset.original) { titulo.dataset.original = titulo.textContent; }
            titulo.textContent = abrir ? 'ARMADO DEL TORNEO' : titulo.dataset.original;
        }
        if (sub) {
            if (!sub.dataset.original) { sub.dataset.original = sub.textContent; }
            sub.textContent = abrir ? 'Asistencia, llaves y horarios por deporte' : sub.dataset.original;
        }
        if (abrir) { window.scrollTo(0, 0); }
        if (!abrir) { return; }
        if (cargado) { pintar(); return; }
        caja.innerHTML = '<div class="sgns-t-caja"><p class="sgns-t-nota">Cargando el torneo…</p></div>';
        cargarTorneos().then(pintar, function(err) {
            cargado = true;
            estado = 'No se pudo leer el torneo guardado: ' + (err && err.message || 'error');
            pintar();
        });
    });

    document.addEventListener('sgns:registros', function() {
        if (raiz.classList.contains('is-torneo') && cargado) { pintar(); }
    });

    var salir = document.getElementById('sgnsTorneoSalir');
    if (salir) { salir.addEventListener('click', function() { if (raiz.classList.contains('is-torneo')) { boton.click(); } }); }

    // Para pruebas: las funciones puras del armado
    window.__sgnsTorneo = { armarLlaves: armarLlaves, horarios: horarios, propagar: propagar };
})();
</script>

{# ==========================================================================
   SORTEO: ruleta entre todos los participantes de los equipos marcados como
   presentes (registros_evento.confirmado = true), sin repetir personas, y la
   lista de esos participantes en Excel. Los ganadores quedan solo en pantalla.
   ========================================================================== #}
<style>
    #sgns-participantes-root.is-sorteo .sgns-stats-grid,
    #sgns-participantes-root.is-sorteo .sgns-toolbar,
    #sgns-participantes-root.is-sorteo .sgns-table-wrapper {
        display: none !important;
    }

    /* Modo sorteo: franja dorada fija arriba, título propio y fondo dorado */
    .sgns-s-modo {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 9999;
        align-items: center;
        justify-content: center;
        gap: 14px;
        flex-wrap: wrap;
        padding: 10px 16px;
        background: #eab308;
        color: #09090b;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 2px;
        text-transform: uppercase;
    }
    .sgns-s-modo button {
        min-height: 32px;
        padding: 6px 14px;
        border-radius: 999px;
        border: 1px solid rgba(9, 9, 11, 0.6);
        background: transparent;
        color: #09090b;
        font-family: inherit;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase;
        cursor: pointer;
    }
    .sgns-s-modo button:hover { background: #09090b; color: #eab308; }
    #sgns-participantes-root.is-sorteo .sgns-s-modo { display: flex; }
    #sgns-participantes-root.is-sorteo { padding-top: 52px !important; background: radial-gradient(ellipse at top, rgba(234, 179, 8, 0.14), rgba(234, 179, 8, 0) 60%) #09090b !important; }
    #sgns-participantes-root.is-sorteo .sgns-part-title { color: #facc15; }
    #sgns-participantes-root.is-sorteo #sgnsSorteoBtn { background: #eab308; border-color: #eab308; color: #09090b !important; }
    #sgns-participantes-root.is-sorteo .sgns-header-actions a[href="/registroevento"],
    #sgns-participantes-root.is-sorteo #sgnsExportBtn { display: none; }

    .sgns-sorteo { display: none; }
    .sgns-s-grid { display: grid; grid-template-columns: minmax(0, 1.15fr) minmax(0, 0.85fr); gap: 16px; align-items: start; }
    .sgns-s-panel {
        background: rgba(17, 17, 20, 0.95);
        border: 1px solid rgba(234, 179, 8, 0.4);
        border-radius: 14px;
        padding: 16px;
    }
    .sgns-s-panel + .sgns-s-panel { margin-top: 14px; }
    .sgns-s-centro { display: flex; flex-direction: column; align-items: center; gap: 16px; padding: 22px 16px; }
    .sgns-s-ticker {
        min-height: 40px;
        max-width: 100%;
        font-size: clamp(20px, 3vw, 30px);
        font-weight: 800;
        letter-spacing: 0.5px;
        text-align: center;
        color: #ffffff;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    .sgns-s-ticker.is-idle { color: #a1a1aa; font-weight: 600; font-size: 16px; letter-spacing: 1px; text-transform: uppercase; }
    .sgns-s-ruleta { position: relative; width: min(520px, 84vw); aspect-ratio: 1 / 1; }
    .sgns-s-ruleta canvas { display: block; width: 100%; height: 100%; filter: drop-shadow(0 18px 40px rgba(0, 0, 0, 0.6)); }
    .sgns-s-puntero {
        position: absolute;
        top: -10px;
        left: 50%;
        z-index: 2;
        width: 0;
        height: 0;
        transform: translateX(-50%);
        border-left: 17px solid transparent;
        border-right: 17px solid transparent;
        border-top: 30px solid #facc15;
        filter: drop-shadow(0 3px 4px rgba(0, 0, 0, 0.6));
    }
    .sgns-s-girar { min-width: 240px; min-height: 52px; font-size: 14px; }
    .sgns-s-girar[disabled] { opacity: 0.45; cursor: default; transform: none; }
    .sgns-s-ganador {
        width: 100%;
        padding: 18px 16px;
        border-radius: 16px;
        border: 2px solid #eab308;
        background: rgba(234, 179, 8, 0.1);
        text-align: center;
        animation: sgnsGanador 0.5s cubic-bezier(0.22, 1, 0.36, 1);
    }
    .sgns-s-ganador small { display: block; font-size: 11px; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: #facc15; }
    .sgns-s-ganador b { display: block; margin: 6px 0 4px; font-size: clamp(26px, 4.5vw, 42px); font-weight: 800; line-height: 1.05; color: #ffffff; }
    .sgns-s-ganador span { font-size: 13px; color: #d4d4d8; }
    @keyframes sgnsGanador { from { opacity: 0; transform: scale(0.92); } to { opacity: 1; transform: none; } }

    .sgns-s-lista { display: flex; flex-direction: column; gap: 4px; max-height: 360px; overflow: auto; margin-top: 12px; }
    .sgns-s-item { display: flex; justify-content: space-between; gap: 10px; padding: 7px 10px; border-radius: 8px; background: rgba(255, 255, 255, 0.03); font-size: 13px; }
    .sgns-s-item span { flex: none; font-size: 11.5px; color: #a1a1aa; }
    .sgns-s-item.es-ganador { background: rgba(234, 179, 8, 0.14); color: #fde68a; }
    .sgns-s-ganadores { display: flex; flex-direction: column; gap: 6px; margin-top: 10px; }
    .sgns-s-ganadores li { display: flex; gap: 10px; align-items: baseline; padding: 8px 10px; border-radius: 10px; background: rgba(234, 179, 8, 0.1); list-style: none; font-size: 14px; }
    .sgns-s-ganadores li em { flex: none; font-style: normal; font-weight: 800; color: #facc15; }
    .sgns-s-ganadores li span { margin-left: auto; font-size: 11.5px; color: #a1a1aa; }
    .sgns-s-acciones { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 14px; }

    @media (max-width: 900px) {
        .sgns-s-grid { grid-template-columns: minmax(0, 1fr); }
    }
</style>

<script>
(function() {
    var P = window.__sgnsPanel;
    var raiz = document.getElementById('sgns-participantes-root');
    var caja = document.getElementById('sgnsSorteo');
    var boton = document.getElementById('sgnsSorteoBtn');
    var botonTorneo = document.getElementById('sgnsTorneoBtn');
    if (!P || !raiz || !caja || !boton) { return; }
    var esc = P.escapeHtml;

    // Colores de las porciones: el rojo de la marca, negro y blanco (con su color de texto)
    var COLORES = ['#E60000', '#1c1c20', '#f4f4f5'];
    var TINTA = { '#E60000': '#ffffff', '#1c1c20': '#ffffff', '#f4f4f5': '#09090b' };
    var MAX_CON_NOMBRES = 60;   // con más porciones los nombres no entran: se leen arriba de la ruleta

    var datos = { lista: [], repetidos: 0, equipos: 0 };
    var ganadores = [];         // personas que ya salieron, en orden
    var enRuleta = [];          // los que giran ahora: todos menos los ganadores
    var rotacion = 0;           // giro actual de la ruleta, en radianes
    var girando = false;
    var canvas = null, ctx = null, ticker = null, ultimoIdx = -1;

    function sinTildes(s) { return String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, ''); }
    function limpiar(s) { return String(s || '').replace(/\s+/g, ' ').trim(); }

    // Todos los participantes de los equipos presentes. Una persona que está en dos equipos
    // (por ejemplo, Fútbol y Básquet) cuenta una sola vez: se compara el nombre sin tildes ni mayúsculas
    function armarLista() {
        var mapa = {}, lista = [], repetidos = 0, equipos = 0;
        P.registros().filter(function(r) { return r.confirmado === true; }).forEach(function(r) {
            equipos++;
            var individual = P.esIndividual(r);
            var nombres = individual ? [r.participante_1] : [r.participante_1, r.participante_2, r.participante_3];
            var equipo = individual ? '' : limpiar(r.equipo);
            var deporte = limpiar(r.juego);
            nombres.forEach(function(n) {
                n = limpiar(n);
                if (!n || n === '-') { return; }
                var clave = sinTildes(n);
                var p = mapa[clave];
                if (p) {
                    repetidos++;
                    if (equipo && p.equipos.indexOf(equipo) === -1) { p.equipos.push(equipo); }
                    if (deporte && p.deportes.indexOf(deporte) === -1) { p.deportes.push(deporte); }
                    return;
                }
                p = { clave: clave, nombre: n, equipos: equipo ? [equipo] : [], deportes: deporte ? [deporte] : [] };
                mapa[clave] = p;
                lista.push(p);
            });
        });
        lista.sort(function(a, b) { return a.nombre.localeCompare(b.nombre, 'es'); });
        return { lista: lista, repetidos: repetidos, equipos: equipos };
    }

    function detalle(p) {
        return [p.equipos.join(' / '), p.deportes.join(' / ')].filter(Boolean).join(' · ');
    }

    function esGanador(p) { return ganadores.some(function(g) { return g.clave === p.clave; }); }

    // Número al azar parejo en [0, n), con el generador criptográfico del navegador
    function azar(n) {
        if (window.crypto && window.crypto.getRandomValues) {
            var tope = Math.floor(4294967296 / n) * n, x = new Uint32Array(1);
            do { window.crypto.getRandomValues(x); } while (x[0] >= tope);
            return x[0] % n;
        }
        return Math.floor(Math.random() * n);
    }

    // ---------------------------------------------------------------------
    // Ruleta (canvas). El puntero está arriba; las porciones arrancan en el
    // ángulo "rotacion" y van en el sentido de las agujas del reloj.
    // ---------------------------------------------------------------------
    function colorDe(i, n) {
        var c = COLORES[i % 3];
        if (n > 1 && i === n - 1) {
            var antes = COLORES[(i - 1) % 3], primero = COLORES[0];
            if (c === antes || c === primero) {
                c = COLORES.filter(function(x) { return x !== antes && x !== primero; })[0] || c;
            }
        }
        return c;
    }

    function recortar(texto, n) {
        var max = n <= 16 ? 24 : (n <= 32 ? 19 : 15);
        return texto.length > max ? texto.slice(0, max - 1) + '…' : texto;
    }

    function dibujar() {
        if (!canvas) { return; }
        var tam = canvas.clientWidth;
        if (!tam) { return; }
        var dpr = Math.min(window.devicePixelRatio || 1, 2);
        if (canvas.width !== Math.round(tam * dpr)) { canvas.width = canvas.height = Math.round(tam * dpr); }
        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
        ctx.clearRect(0, 0, tam, tam);
        var c = tam / 2, R = c - 6, n = enRuleta.length;
        if (!n) {
            ctx.beginPath(); ctx.arc(c, c, R, 0, Math.PI * 2);
            ctx.fillStyle = '#1c1c20'; ctx.fill();
            ctx.lineWidth = 4; ctx.strokeStyle = 'rgba(255, 255, 255, 0.3)'; ctx.stroke();
            return;
        }
        var s = Math.PI * 2 / n;
        var fuente = getComputedStyle(raiz).fontFamily || 'sans-serif';
        var tamTexto = Math.max(10, Math.min(16, s * R * 0.42));
        for (var i = 0; i < n; i++) {
            var a0 = rotacion + i * s, color = colorDe(i, n);
            ctx.beginPath(); ctx.moveTo(c, c); ctx.arc(c, c, R, a0, a0 + s); ctx.closePath();
            ctx.fillStyle = color; ctx.fill();
            if (n > 1) { ctx.lineWidth = 1; ctx.strokeStyle = 'rgba(0, 0, 0, 0.35)'; ctx.stroke(); }
            if (n <= MAX_CON_NOMBRES) {
                ctx.save();
                ctx.translate(c, c);
                ctx.rotate(a0 + s / 2);
                ctx.fillStyle = TINTA[color];
                ctx.font = '700 ' + tamTexto + 'px ' + fuente;
                ctx.textAlign = 'right';
                ctx.textBaseline = 'middle';
                ctx.fillText(recortar(enRuleta[i].nombre, n), R - 14, 0);
                ctx.restore();
            }
        }
        ctx.beginPath(); ctx.arc(c, c, R, 0, Math.PI * 2);
        ctx.lineWidth = 5; ctx.strokeStyle = '#ffffff'; ctx.stroke();
        ctx.beginPath(); ctx.arc(c, c, R * 0.11, 0, Math.PI * 2);
        ctx.fillStyle = '#09090b'; ctx.fill();
        ctx.lineWidth = 3; ctx.strokeStyle = '#facc15'; ctx.stroke();
    }

    // Qué porción está debajo del puntero
    function bajoPuntero() {
        var n = enRuleta.length;
        if (!n) { return -1; }
        var vuelta = Math.PI * 2, s = vuelta / n;
        var a = ((-Math.PI / 2 - rotacion) % vuelta + vuelta) % vuelta;
        return Math.min(n - 1, Math.floor(a / s));
    }

    function mostrarTicker(texto, enEspera) {
        if (!ticker) { return; }
        ticker.textContent = texto;
        ticker.classList.toggle('is-idle', !!enEspera);
    }

    function girar() {
        if (girando) { return; }
        // Los que ya ganaron salen de la ruleta antes de cada giro
        enRuleta = datos.lista.filter(function(p) { return !esGanador(p); });
        if (!enRuleta.length) { return; }
        if (canvas) { canvas.setAttribute('aria-label', 'Ruleta del sorteo con ' + enRuleta.length + ' participantes'); }
        dibujar();
        girando = true;
        var btn = caja.querySelector('[data-s-girar]');
        if (btn) { btn.disabled = true; }
        var aviso = caja.querySelector('.sgns-s-ganador');
        if (aviso) { aviso.remove(); }

        // El ganador se elige primero, al azar; la ruleta solo muestra el resultado
        var n = enRuleta.length, s = Math.PI * 2 / n;
        var g = azar(n);
        var dentro = 0.15 + azar(1000) / 1000 * 0.7;          // dónde cae el puntero dentro de la porción
        var base = -Math.PI / 2 - (g + dentro) * s;
        var minimo = rotacion + Math.PI * 2 * 7;                 // al menos 7 vueltas
        var destino = base + Math.PI * 2 * Math.ceil((minimo - base) / (Math.PI * 2));
        var desde = rotacion, duracion = 7000, t0 = performance.now();
        ultimoIdx = -1;

        function cuadro(t) {
            var x = Math.min((t - t0) / duracion, 1);
            rotacion = desde + (destino - desde) * (1 - Math.pow(1 - x, 4));
            dibujar();
            var idx = bajoPuntero();
            if (idx !== ultimoIdx) { ultimoIdx = idx; mostrarTicker(enRuleta[idx].nombre); }
            if (x < 1) { requestAnimationFrame(cuadro); return; }
            rotacion = destino % (Math.PI * 2);
            girando = false;
            terminar(enRuleta[g]);
        }
        requestAnimationFrame(cuadro);
    }

    function terminar(p) {
        ganadores.push(p);
        mostrarTicker(p.nombre);
        pintarLateral();
        var centro = caja.querySelector('.sgns-s-centro');
        if (centro) {
            var div = document.createElement('div');
            div.className = 'sgns-s-ganador';
            div.setAttribute('role', 'status');
            div.innerHTML = '<small>' + (ganadores.length === 1 ? 'Ganador/a' : ganadores.length + '° ganador/a') + '</small><b>' + esc(p.nombre) + '</b><span>' + esc(detalle(p)) + '</span>';
            centro.insertBefore(div, centro.firstChild);
        }
        var btn = caja.querySelector('[data-s-girar]');
        var quedan = datos.lista.filter(function(x) { return !esGanador(x); }).length;
        if (btn) {
            btn.disabled = !quedan;
            btn.textContent = quedan ? 'Sortear otro ganador' : 'No quedan participantes';
        }
    }

    // ---------------------------------------------------------------------
    // Pantalla
    // ---------------------------------------------------------------------
    function pintarLateral() {
        var lat = caja.querySelector('.sgns-s-lateral');
        if (!lat) { return; }
        var h = '';
        h += '<div class="sgns-s-panel"><p class="sgns-t-titulo">Participantes en el sorteo</p>' +
            '<div class="sgns-t-nums" style="grid-template-columns: repeat(3, minmax(0, 1fr))">' +
            '<div class="sgns-t-num si"><b>' + datos.lista.length + '</b><span>Personas</span></div>' +
            '<div class="sgns-t-num"><b>' + datos.equipos + '</b><span>Equipos presentes</span></div>' +
            '<div class="sgns-t-num"><b>' + ganadores.length + '</b><span>Ganadores</span></div></div>';
        if (datos.repetidos) {
            h += '<p class="sgns-t-nota">' + datos.repetidos + (datos.repetidos === 1 ? ' persona estaba' : ' personas estaban') + ' en más de un equipo: cuentan una sola vez.</p>';
        }
        h += '<div class="sgns-s-acciones"><button type="button" class="sgns-action-btn sgns-btn-secondary" data-s-excel' + (datos.lista.length ? '' : ' disabled') + '>Descargar lista en Excel</button></div>';
        h += '<div class="sgns-s-lista">' + datos.lista.map(function(p) {
            return '<div class="sgns-s-item' + (esGanador(p) ? ' es-ganador' : '') + '"><b>' + esc(p.nombre) + '</b><span>' + esc(detalle(p)) + '</span></div>';
        }).join('') + '</div></div>';
        if (ganadores.length) {
            h += '<div class="sgns-s-panel"><p class="sgns-t-titulo">Ganadores</p><ol class="sgns-s-ganadores" style="padding: 0; margin: 0">' +
                ganadores.map(function(p, i) { return '<li><em>' + (i + 1) + '°</em><b>' + esc(p.nombre) + '</b><span>' + esc(detalle(p)) + '</span></li>'; }).join('') +
                '</ol><div class="sgns-s-acciones"><button type="button" class="sgns-action-btn sgns-btn-lock" data-s-reiniciar>Reiniciar sorteo</button></div></div>';
        }
        lat.innerHTML = h;
    }

    function pintar() {
        datos = armarLista();
        // Los ganadores que ya no están en la lista (por ejemplo, si se desmarcó su equipo) se mantienen en la lista de ganadores
        enRuleta = datos.lista.filter(function(p) { return !esGanador(p); });
        var h = '<div class="sgns-s-grid"><div class="sgns-s-panel sgns-s-centro">';
        if (!datos.lista.length) {
            h += '<p class="sgns-t-nota" style="text-align: center">Todavía no hay equipos marcados como presentes. Marcá la asistencia en <b>Armar torneo</b> y volvé al sorteo.</p>';
        }
        h += '<div class="sgns-s-ticker is-idle" aria-live="off">' + (enRuleta.length ? '¿Quién gana?' : (datos.lista.length ? 'Ya salieron todos' : 'Sin participantes')) + '</div>' +
            '<div class="sgns-s-ruleta"><span class="sgns-s-puntero" aria-hidden="true"></span><canvas aria-label="Ruleta del sorteo con ' + enRuleta.length + ' participantes" role="img"></canvas></div>' +
            '<button type="button" class="sgns-action-btn sgns-btn-primary sgns-s-girar" data-s-girar' + (enRuleta.length ? '' : ' disabled') + '>' + (ganadores.length ? 'Sortear otro ganador' : 'Girar la ruleta') + '</button>';
        if (enRuleta.length > MAX_CON_NOMBRES) {
            h += '<p class="sgns-t-nota" style="text-align: center; margin: 0">Con ' + enRuleta.length + ' participantes los nombres no entran en la ruleta: se ven arriba mientras gira.</p>';
        }
        h += '</div><div class="sgns-s-lateral"></div></div>';
        caja.innerHTML = h;
        canvas = caja.querySelector('canvas');
        ctx = canvas.getContext('2d');
        ticker = caja.querySelector('.sgns-s-ticker');
        dibujar();
        pintarLateral();
    }

    // Lista en Excel: una fila por persona (nombre y apellido como se cargó en la inscripción)
    function exportarExcel() {
        var lista = datos.lista;
        if (!lista.length) { return; }
        var celda = 'border: 1px solid #cbd5e1; padding: 10px;';
        var filas = lista.map(function(p, i) {
            var fondo = i % 2 ? '#f8fafc' : '#ffffff';
            return '<tr style="background-color: ' + fondo + ';">' +
                '<td style="' + celda + ' text-align: center; font-weight: bold; color: #64748b;">' + (i + 1) + '</td>' +
                '<td style="' + celda + ' font-weight: bold; color: #0f172a;">' + esc(p.nombre) + '</td>' +
                '<td style="' + celda + ' color: #1e293b;">' + esc(p.equipos.join(' / ') || '-') + '</td>' +
                '<td style="' + celda + ' color: #1e293b;">' + esc(p.deportes.join(' / ') || '-') + '</td></tr>';
        }).join('');
        var th = 'background-color: #09090b; color: #ffffff; padding: 12px 10px; border: 1px solid #334155;';
        var html = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">' +
            '<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' +
            '<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>Sorteo Signos</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->' +
            '<style>body, th, td { font-family: Calibri, \'Segoe UI\', Arial, sans-serif; } table { border-collapse: collapse; }</style></head><body>' +
            '<table border="1"><thead><tr>' +
            '<th style="' + th + ' width: 50px;">N°</th>' +
            '<th style="' + th + ' width: 260px;">NOMBRE Y APELLIDO</th>' +
            '<th style="' + th + ' width: 220px;">EQUIPO</th>' +
            '<th style="' + th + ' width: 150px;">DEPORTE</th>' +
            '</tr></thead><tbody>' + filas + '</tbody></table></body></html>';
        var blob = new Blob(['﻿' + html], { type: 'application/vnd.ms-excel;charset=utf-8' });
        var url = URL.createObjectURL(blob);
        var a = document.createElement('a');
        a.href = url;
        a.download = 'sorteo_signos_participantes_presentes_' + new Date().toISOString().slice(0, 10) + '.xls';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        setTimeout(function() { URL.revokeObjectURL(url); }, 1000);
    }

    caja.addEventListener('click', function(e) {
        var el = e.target.closest ? e.target.closest('button') : null;
        if (!el) { return; }
        if (el.hasAttribute('data-s-girar')) { girar(); return; }
        if (el.hasAttribute('data-s-excel')) { exportarExcel(); return; }
        if (el.hasAttribute('data-s-reiniciar')) {
            if (girando) { return; }
            if (!confirm('¿Reiniciar el sorteo? Se borra la lista de ganadores y vuelven todos a la ruleta.')) { return; }
            ganadores = [];
            rotacion = 0;
            pintar();
        }
    });

    // ---------------------------------------------------------------------
    // Modo sorteo (se excluye con el modo torneo)
    // ---------------------------------------------------------------------
    function modoSorteo(abrir) {
        if (abrir && raiz.classList.contains('is-torneo') && botonTorneo) { botonTorneo.click(); }
        raiz.classList.toggle('is-sorteo', abrir);
        caja.style.display = abrir ? 'block' : 'none';
        document.getElementById('sgnsSorteoBtnTxt').textContent = abrir ? 'SALIR DEL SORTEO' : 'HACER SORTEO';
        var titulo = raiz.querySelector('.sgns-part-title'), sub = raiz.querySelector('.sgns-part-subtitle');
        if (titulo) {
            if (!titulo.dataset.original) { titulo.dataset.original = titulo.textContent; }
            titulo.textContent = abrir ? 'SORTEO' : titulo.dataset.original;
        }
        if (sub) {
            if (!sub.dataset.original) { sub.dataset.original = sub.textContent; }
            sub.textContent = abrir ? 'Ruleta entre los participantes presentes' : sub.dataset.original;
        }
        if (abrir) { window.scrollTo(0, 0); pintar(); }
    }

    boton.addEventListener('click', function() { modoSorteo(!raiz.classList.contains('is-sorteo')); });
    var salir = document.getElementById('sgnsSorteoSalir');
    if (salir) { salir.addEventListener('click', function() { modoSorteo(false); }); }
    // Si se entra al torneo estando en el sorteo, primero se sale del sorteo
    if (botonTorneo) {
        botonTorneo.addEventListener('click', function() { if (raiz.classList.contains('is-sorteo')) { modoSorteo(false); } }, true);
    }

    // Si se actualizan los inscriptos (o la asistencia), la ruleta se rearma con los presentes
    document.addEventListener('sgns:registros', function() {
        if (raiz.classList.contains('is-sorteo') && !girando) { pintar(); }
    });
    window.addEventListener('resize', function() { if (raiz.classList.contains('is-sorteo')) { dibujar(); } });

    // Para pruebas
    window.__sgnsSorteo = { armarLista: armarLista, azar: azar, estado: function() { var i = bajoPuntero(); return { enRuleta: enRuleta.length, ganadores: ganadores.map(function(g) { return g.nombre; }), rotacion: rotacion, bajoPuntero: i >= 0 ? enRuleta[i].nombre : null }; } };
})();
</script>
