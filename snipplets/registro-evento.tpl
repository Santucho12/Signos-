{#/*============================================================================
  #Registro de Evento - Signos Indumentaria
  One page minimalista y exclusiva con formulario para equipos de 3 personas
==============================================================================*/#}

<div id="sgns-event-root" class="sgns-event-page">
    {# Glow ambiental de fondo #}
    <div class="sgns-event-glow"></div>

    <div class="sgns-event-container">
        {# Encabezado con Monograma centrado y destacado #}
        <div class="sgns-event-header">
            <div class="sgns-event-brand">
                <img src="{{ 'images/logo final monograma blanco_Mesa de trabajo 1_Mesa de trabajo 1.png' | static_url }}" alt="Signos Indumentaria" class="sgns-event-logo">
            </div>
            <span class="sgns-event-badge">TORNEO EXCLUSIVO</span>
            <h1 class="sgns-event-title">REGISTRO AL EVENTO</h1>
            <p class="sgns-event-subtitle" id="eventSubtitle">Inscribí a tu equipo de 3 integrantes para participar</p>

            {# Fecha y Horario destacados #}
            <div class="sgns-event-datetime">
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

            {# Apartado de Premios #}
            <div class="sgns-prizes">
                <div class="sgns-prizes-header">
                    <span class="sgns-prizes-icon">🏆</span>
                    <span class="sgns-prizes-title">Premios del torneo</span>
                </div>
                <div class="sgns-prize-row">
                    <div class="sgns-prize-item">
                        <div class="sgns-prize-left">
                            <span class="sgns-prize-sport-icon">⚽</span>
                            <span class="sgns-prize-name">Fútbol 3</span>
                        </div>
                        <div class="sgns-prize-right">
                            <span class="sgns-prize-giftcard-label">Giftcard Signos</span>
                            <span class="sgns-prize-amount">$1.000.000</span>
                        </div>
                    </div>
                    <div class="sgns-prize-item">
                        <div class="sgns-prize-left">
                            <span class="sgns-prize-sport-icon">🏀</span>
                            <span class="sgns-prize-name">Básquet 3</span>
                        </div>
                        <div class="sgns-prize-right">
                            <span class="sgns-prize-giftcard-label">Giftcard Signos</span>
                            <span class="sgns-prize-amount">$800.000</span>
                        </div>
                    </div>
                    <div class="sgns-prize-item">
                        <div class="sgns-prize-left">
                            <span class="sgns-prize-sport-icon">🏓</span>
                            <span class="sgns-prize-name">Ping Pong</span>
                        </div>
                        <div class="sgns-prize-right">
                            <span class="sgns-prize-giftcard-label">Giftcard Signos</span>
                            <span class="sgns-prize-amount">$350.000</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {# Card Principal #}
        <div class="sgns-event-card">
            {# Formulario de Registro #}
            <form id="sgnsEventForm" class="sgns-event-form" novalidate>
                
                {# 1. Selección de Juego (Único con ícono) #}
                <div class="sgns-field-group">
                    <label for="eventJuego" class="sgns-label">
                        <span class="sgns-label-icon">🏆</span> JUEGO
                    </label>
                    <div class="sgns-select-wrapper">
                        <select id="eventJuego" name="juego" class="sgns-input sgns-select">
                            <option value="" disabled selected>Seleccioná un juego...</option>
                            <option value="Fútbol" disabled>Fútbol (inscripción cerrada)</option>
                            <option value="Básquet" disabled>Básquet (inscripción cerrada)</option>
                            <option value="Ping Pong">Ping Pong</option>
                        </select>
                    </div>
                    <span class="sgns-field-error" id="errorJuego"></span>
                    <button type="button" id="btnVerReglas" class="sgns-rules-link">
                        <span>📖</span> VER REGLAS DEL JUEGO
                    </button>
                </div>

                {# 2. Nombre del Equipo (no aplica a Ping Pong, que es individual) #}
                <div class="sgns-field-group" id="groupEquipo">
                    <label for="eventEquipo" class="sgns-label">NOMBRE DEL EQUIPO</label>
                    <input type="text" id="eventEquipo" name="equipo" class="sgns-input" placeholder="Ej. SignosTeam" autocomplete="off">
                    <span class="sgns-field-error" id="errorEquipo"></span>
                </div>

                {# 3. Integrantes del Equipo (3 Participantes, o 1 en Ping Pong) #}
                <div class="sgns-section-divider">
                    <span class="sgns-divider-title" id="dividerIntegrantes">INTEGRANTES DEL EQUIPO</span>
                </div>

                <div class="sgns-field-group">
                    <label for="eventParticipante1" class="sgns-label" id="labelParticipante1">PARTICIPANTE 1</label>
                    <input type="text" id="eventParticipante1" name="participante_1" class="sgns-input sgns-input-name" placeholder="Nombre y Apellido" autocomplete="name">
                    <span class="sgns-field-error" id="errorParticipante1"></span>
                    <label for="eventEdad1" class="sgns-label sgns-label-edad">EDAD</label>
                    <input type="number" id="eventEdad1" name="edad_1" class="sgns-input sgns-input-edad" placeholder="Edad" inputmode="numeric" min="5" max="99">
                    <span class="sgns-field-error" id="errorEdad1"></span>
                </div>

                <div class="sgns-field-group" id="groupParticipante2">
                    <label for="eventParticipante2" class="sgns-label">PARTICIPANTE 2</label>
                    <input type="text" id="eventParticipante2" name="participante_2" class="sgns-input sgns-input-name" placeholder="Nombre y Apellido" autocomplete="name">
                    <span class="sgns-field-error" id="errorParticipante2"></span>
                    <label for="eventEdad2" class="sgns-label sgns-label-edad">EDAD</label>
                    <input type="number" id="eventEdad2" name="edad_2" class="sgns-input sgns-input-edad" placeholder="Edad" inputmode="numeric" min="5" max="99">
                    <span class="sgns-field-error" id="errorEdad2"></span>
                </div>

                <div class="sgns-field-group" id="groupParticipante3">
                    <label for="eventParticipante3" class="sgns-label">PARTICIPANTE 3</label>
                    <input type="text" id="eventParticipante3" name="participante_3" class="sgns-input sgns-input-name" placeholder="Nombre y Apellido" autocomplete="name">
                    <span class="sgns-field-error" id="errorParticipante3"></span>
                    <label for="eventEdad3" class="sgns-label sgns-label-edad">EDAD</label>
                    <input type="number" id="eventEdad3" name="edad_3" class="sgns-input sgns-input-edad" placeholder="Edad" inputmode="numeric" min="5" max="99">
                    <span class="sgns-field-error" id="errorEdad3"></span>
                </div>

                {# 4. Datos de Contacto #}
                <div class="sgns-section-divider">
                    <span class="sgns-divider-title">CONTACTO</span>
                </div>

                <div class="sgns-field-group">
                    <label for="eventEmail" class="sgns-label">CORREO ELECTRÓNICO</label>
                    <input type="email" id="eventEmail" name="email" class="sgns-input" placeholder="ejemplo@email.com" autocomplete="email" autocapitalize="none">
                    <span class="sgns-field-error" id="errorEmail"></span>
                </div>

                <div class="sgns-field-group">
                    <label for="eventTelefono" class="sgns-label">NÚMERO DE TELÉFONO</label>
                    <input type="tel" id="eventTelefono" name="telefono" class="sgns-input" placeholder="Ej. 291435....." inputmode="tel" autocomplete="tel">
                    <span class="sgns-field-error" id="errorTelefono"></span>
                </div>

                {# Alerta de error general #}
                <div id="eventGeneralAlert" class="sgns-general-alert" style="display: none;"></div>

                {# Botón de Envío #}
                <button type="submit" id="eventSubmitBtn" class="sgns-submit-btn">
                    <span class="sgns-btn-text">CONFIRMAR REGISTRO</span>
                    <span class="sgns-btn-spinner" style="display: none;">
                        <svg class="sgns-spin-icon" viewBox="0 0 24 24" fill="none">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="3"></circle>
                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                        PROCESANDO...
                    </span>
                </button>
            </form>

            {# Estado de Éxito #}
            <div id="sgnsSuccessState" class="sgns-success-state" style="display: none;">
                <div class="sgns-success-icon-wrap">
                    <svg class="sgns-check-svg" viewBox="0 0 52 52">
                        <circle class="sgns-check-circle" cx="26" cy="26" r="24" fill="none"/>
                        <path class="sgns-check-path" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                    </svg>
                </div>
                <span class="sgns-event-badge sgns-badge-confirmed" id="successBadge">EQUIPO CONFIRMADO</span>
                <h2 class="sgns-success-title" id="successEquipoTitle">¡EQUIPO REGISTRADO!</h2>
                <p class="sgns-success-msg" id="successMsg">
                    Los datos del equipo han sido registrados correctamente en la lista oficial del torneo.
                </p>

                <div class="sgns-ticket-preview">
                    <div class="sgns-ticket-line">
                        <span class="sgns-ticket-label" id="ticketEquipoLabel">EQUIPO</span>
                        <span class="sgns-ticket-val" id="ticketEquipo">-</span>
                    </div>
                    <div class="sgns-ticket-line">
                        <span class="sgns-ticket-label">JUEGO</span>
                        <span class="sgns-ticket-val sgns-text-highlight" id="ticketJuego">-</span>
                    </div>
                    <div class="sgns-ticket-line">
                        <span class="sgns-ticket-label">FECHA Y HORA</span>
                        <span class="sgns-ticket-val">Domingo 4/10 • 12:00 HS</span>
                    </div>
                    <div class="sgns-ticket-line sgns-ticket-line--block">
                        <span class="sgns-ticket-label" id="ticketParticipantesLabel">PARTICIPANTES</span>
                        <div class="sgns-ticket-members">
                            <div class="sgns-member-row">1. <span id="ticketP1">-</span></div>
                            <div class="sgns-member-row" id="ticketRowP2">2. <span id="ticketP2">-</span></div>
                            <div class="sgns-member-row" id="ticketRowP3">3. <span id="ticketP3">-</span></div>
                        </div>
                    </div>
                    <div class="sgns-ticket-line">
                        <span class="sgns-ticket-label">CONTACTO</span>
                        <span class="sgns-ticket-val" id="ticketContacto">-</span>
                    </div>
                    <div class="sgns-ticket-line">
                        <span class="sgns-ticket-label">ESTADO</span>
                        <span class="sgns-ticket-val sgns-text-green">HABILITADO PARA JUGAR</span>
                    </div>
                </div>

                {# Reglas del juego elegido #}
                <div class="sgns-success-rules" id="sgnsSuccessRules">
                    <div class="sgns-rules-title">📖 REGLAS DE TU JUEGO</div>
                    <div id="sgnsSuccessRulesBody"></div>
                </div>
            </div>
        </div>

    </div>

    {# Modal de Reglas #}
    <div id="sgnsRulesModal" class="sgns-modal-overlay" style="display: none;">
        <div class="sgns-modal-box">
            <button type="button" id="sgnsRulesModalClose" class="sgns-modal-close" aria-label="Cerrar">&times;</button>
            <h2 class="sgns-modal-title">📖 REGLAS DEL TORNEO</h2>

            <div class="sgns-modal-tabs">
                <button type="button" class="sgns-modal-tab active" data-rule="Fútbol">⚽ Fútbol</button>
                <button type="button" class="sgns-modal-tab" data-rule="Básquet">🏀 Básquet</button>
                <button type="button" class="sgns-modal-tab" data-rule="Ping Pong">🏓 Ping Pong</button>
            </div>

            <div id="sgnsModalRulesBody" class="sgns-modal-rules-body"></div>
        </div>
    </div>
</div>

{# Estilos Scoped de la Landing #}
<style>
    /* RESET TOTAL Y BLOQUEO DE OVERFLOW HORIZONTAL (Fix definitivo para iPhone/Safari) */
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

    #sgns-event-root,
    #sgns-event-root * {
        box-sizing: border-box !important;
    }

    /* OCULTAR ELEMENTOS AJENOS DE TIENDANUBE EN ESTA PÁGINA */
    header,
    .section-header,
    .js-head-main,
    .main-header,
    .header-bar,
    .head-main,
    .nav-head,
    .redesign-top-banner,
    .section-advertising,
    .adbar,
    .js-advertising,
    .navigation-tabs,
    .social-widgets,
    .btn-whatsapp,
    .js-btn-whatsapp,
    .sgns-wa-bubble,
    a[href*="wa.me"],
    .whatsapp-chat-container,
    .js-modal-whatsapp,
    #whatsapp-modal,
    .notification-cart-container,
    .js-alert-added-to-cart,
    .breadcrumbs,
    .page-header,
    .back-to-admin-banner,
    .marketing-modal,
    .js-hide-footer-while-scrolling-down {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        pointer-events: none !important;
        height: 0 !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
    }

    .sgns-event-page {
        min-height: 100vh;
        width: 100% !important;
        max-width: 100vw !important;
        background: #09090b;
        color: #ffffff;
        position: relative;
        overflow-x: hidden !important;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        padding: 32px 16px 56px;
        font-family: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif !important;
        box-sizing: border-box;
    }

    /* Glow ambiental acotado para nunca desbordar la pantalla */
    .sgns-event-glow {
        position: absolute;
        top: -100px;
        left: 50%;
        transform: translateX(-50%);
        width: 100%;
        max-width: 480px;
        height: 380px;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.08) 0%, rgba(255, 255, 255, 0) 70%);
        pointer-events: none;
        z-index: 1;
    }

    /* Contenedor perfectamente centrado en cualquier pantalla */
    .sgns-event-container {
        position: relative;
        z-index: 2;
        width: 100% !important;
        max-width: 460px !important;
        margin: 0 auto !important;
        display: flex;
        flex-direction: column;
        align-items: center;
        box-sizing: border-box;
    }

    /* Header del Evento */
    .sgns-event-header {
        text-align: center;
        margin-bottom: 22px;
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .sgns-event-brand {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 4px;
        padding: 0;
        text-align: center;
        width: 100%;
    }

    .sgns-event-logo {
        height: 140px;
        width: auto;
        display: block;
        margin: 0 auto;
        filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.2));
    }

    .sgns-event-badge {
        display: inline-block;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 2px;
        text-transform: uppercase !important;
        color: #a1a1aa;
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.12);
        padding: 5px 15px;
        border-radius: 999px;
    }
    .sgns-badge-confirmed {
        color: #22c55e;
        border-color: rgba(34, 197, 94, 0.3);
        background: rgba(34, 197, 94, 0.08);
    }

    .sgns-event-title {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 26px;
        letter-spacing: 2.5px;
        margin: 0;
        color: #ffffff;
        text-transform: uppercase !important;
        text-align: center;
        line-height: 1.15;
    }

    .sgns-event-subtitle {
        font-size: 13px;
        line-height: 1.45;
        color: #71717a;
        margin: 0;
        font-weight: 400;
        text-align: center;
        text-transform: none !important;
    }

    /* Bloque Destacado de Fecha y Horario */
    .sgns-event-datetime {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 14px;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.08) 0%, rgba(255, 255, 255, 0.03) 100%);
        border: 1px solid rgba(255, 255, 255, 0.22);
        box-shadow: 0 4px 22px rgba(0, 0, 0, 0.55), inset 0 1px 0 rgba(255, 255, 255, 0.2);
        padding: 9px 20px;
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
        font-family: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif !important;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 1.5px;
        text-transform: uppercase !important;
    }
    .sgns-dt-icon {
        width: 16px;
        height: 16px;
        color: #ffffff;
        flex-shrink: 0;
        filter: drop-shadow(0 0 6px rgba(255, 255, 255, 0.45));
    }
    .sgns-dt-separator {
        width: 1px;
        height: 15px;
        background: rgba(255, 255, 255, 0.25);
    }

    /* Apartado de Premios */
    .sgns-prizes {
        width: 100%;
        margin-top: 16px;
        background: rgba(17, 17, 20, 0.9);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 18px;
        padding: 16px 18px 14px;
        box-shadow: 0 20px 40px -18px rgba(0, 0, 0, 0.7), inset 0 1px 0 rgba(255, 255, 255, 0.04);
    }
    .sgns-prizes-header {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        margin-bottom: 12px;
    }
    .sgns-prizes-icon {
        font-size: 13px;
        filter: drop-shadow(0 0 6px rgba(250, 204, 21, 0.5));
    }
    .sgns-prizes-title {
        font-size: 10.5px;
        font-weight: 700;
        letter-spacing: 1.8px;
        text-transform: uppercase;
        color: #a1a1aa;
    }
    .sgns-prize-row {
        display: flex;
        flex-direction: column;
    }
    .sgns-prize-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
        padding: 11px 2px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.06);
    }
    .sgns-prize-item:last-child {
        border-bottom: none;
    }
    .sgns-prize-left {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .sgns-prize-sport-icon {
        font-size: 16px;
        width: 30px;
        height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 9px;
        flex-shrink: 0;
    }
    .sgns-prize-name {
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.2px;
        color: #e4e4e7;
    }
    .sgns-prize-right {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-shrink: 0;
    }
    .sgns-prize-giftcard-label {
        font-size: 9px;
        font-weight: 700;
        letter-spacing: 0.4px;
        text-transform: uppercase;
        color: #71717a;
        white-space: nowrap;
    }
    .sgns-prize-amount {
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 0.2px;
        color: #0a0a0a;
        background: linear-gradient(135deg, #fde68a 0%, #facc15 100%);
        padding: 5px 11px;
        border-radius: 999px;
        white-space: nowrap;
    }

    /* Botón Ver Reglas */
    .sgns-rules-link {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        align-self: flex-start;
        margin-top: 8px;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.15);
        color: #ffffff;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase;
        padding: 8px 14px;
        border-radius: 999px;
        cursor: pointer;
        font-family: 'Outfit', sans-serif !important;
        transition: all 0.2s ease;
    }
    .sgns-rules-link:hover {
        background: rgba(255, 255, 255, 0.1);
        border-color: rgba(255, 255, 255, 0.3);
    }

    /* Modal de Reglas */
    .sgns-modal-overlay {
        position: fixed;
        inset: 0;
        background: rgba(0, 0, 0, 0.75);
        backdrop-filter: blur(4px);
        -webkit-backdrop-filter: blur(4px);
        z-index: 999;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }
    .sgns-modal-box {
        position: relative;
        width: 100%;
        max-width: 420px;
        max-height: 85vh;
        overflow-y: auto;
        background: #141418;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 18px;
        padding: 26px 20px 22px;
        box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.9);
    }
    .sgns-modal-close {
        position: absolute;
        top: 12px;
        right: 14px;
        background: transparent;
        border: none;
        color: #a1a1aa;
        font-size: 26px;
        line-height: 1;
        cursor: pointer;
        padding: 4px;
    }
    .sgns-modal-close:hover {
        color: #ffffff;
    }
    .sgns-modal-title {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 19px;
        letter-spacing: 1px;
        color: #ffffff;
        margin: 0 0 16px;
        text-align: center;
    }
    .sgns-modal-tabs {
        display: flex;
        gap: 6px;
        margin-bottom: 16px;
    }
    .sgns-modal-tab {
        flex: 1;
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #a1a1aa;
        padding: 8px 6px;
        border-radius: 10px;
        font-size: 11.5px;
        font-weight: 600;
        cursor: pointer;
        font-family: inherit;
        transition: all 0.2s ease;
    }
    .sgns-modal-tab.active {
        background: #ffffff;
        color: #000000;
        border-color: #ffffff;
        font-weight: 800;
    }
    .sgns-modal-rules-body {
        font-size: 13px;
        line-height: 1.6;
        color: #d4d4d8;
    }
    .sgns-modal-rules-body ul {
        margin: 0;
        padding-left: 18px;
    }
    .sgns-modal-rules-body li {
        margin-bottom: 8px;
    }

    /* Reglas en el estado de éxito */
    .sgns-success-rules {
        margin-top: 16px;
        text-align: left;
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 12px;
        padding: 14px 16px;
    }
    .sgns-rules-title {
        font-size: 11px;
        font-weight: 800;
        letter-spacing: 1px;
        text-transform: uppercase;
        color: #a1a1aa;
        margin-bottom: 8px;
    }
    #sgnsSuccessRulesBody {
        font-size: 12.5px;
        line-height: 1.55;
        color: #d4d4d8;
    }
    #sgnsSuccessRulesBody ul {
        margin: 0;
        padding-left: 16px;
    }
    #sgnsSuccessRulesBody li {
        margin-bottom: 6px;
    }

    /* Card Principal */
    .sgns-event-card {
        width: 100% !important;
        box-sizing: border-box;
        background: rgba(17, 17, 20, 0.95);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 22px;
        padding: 26px 20px 22px;
        box-shadow:
            0 28px 56px -16px rgba(0, 0, 0, 0.8),
            inset 0 1px 0 rgba(255, 255, 255, 0.06);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
    }

    .sgns-field-group {
        margin-bottom: 15px;
        display: flex;
        flex-direction: column;
        width: 100%;
    }

    .sgns-label {
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase !important;
        color: #a1a1aa;
        margin-bottom: 7px;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    .sgns-label-icon {
        font-size: 13px;
    }

    /* Divisores de Sección */
    .sgns-section-divider {
        display: flex;
        align-items: center;
        margin: 20px 0 14px;
        position: relative;
    }
    .sgns-section-divider::before {
        content: "";
        flex: 1;
        height: 1px;
        background: rgba(255, 255, 255, 0.08);
    }
    .sgns-divider-title {
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 1.5px;
        color: #71717a;
        text-transform: uppercase;
        padding: 0 10px;
    }
    .sgns-section-divider::after {
        content: "";
        flex: 1;
        height: 1px;
        background: rgba(255, 255, 255, 0.08);
    }

    /* Inputs y Selects */
    /* IMPORTANTE: font-size 16px evita el zoom automático de Safari en iPhone */
    .sgns-input {
        background: #0f0f12 !important;
        border: 1px solid rgba(255, 255, 255, 0.1) !important;
        color: #ffffff !important;
        font-size: 16px !important;
        font-family: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif !important;
        padding: 13px 15px !important;
        border-radius: 12px !important;
        transition: all 0.2s ease !important;
        outline: none !important;
        width: 100% !important;
        max-width: 100% !important;
        box-sizing: border-box !important;
        -webkit-appearance: none;
        appearance: none;
        text-transform: none !important;
    }
    .sgns-label-edad {
        margin-top: 10px;
    }
    .sgns-input-edad {
        max-width: 120px !important;
    }
    .sgns-input-name {
        text-transform: capitalize !important;
    }
    .sgns-input::placeholder {
        color: #3f3f46 !important;
        font-size: 14.5px !important;
    }
    .sgns-input:focus {
        border-color: rgba(255, 255, 255, 0.5) !important;
        background: #141418 !important;
        box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.08) !important;
    }
    .sgns-input.has-error {
        border-color: #ef4444 !important;
        background: rgba(239, 68, 68, 0.06) !important;
    }

    /* Estilo del Select Desplegable */
    .sgns-select-wrapper {
        position: relative;
        width: 100%;
    }
    .sgns-select {
        cursor: pointer;
        padding-right: 42px !important;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' viewBox='0 0 24 24' fill='none' stroke='%23a1a1aa' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='m6 9 6 6 6-6'/%3E%3C/svg%3E") !important;
        background-repeat: no-repeat !important;
        background-position: right 14px center !important;
    }
    .sgns-select option {
        background: #18181b;
        color: #ffffff;
        padding: 10px;
    }

    .sgns-field-error {
        font-size: 11px;
        color: #ef4444;
        margin-top: 4px;
        min-height: 14px;
        display: block;
    }

    .sgns-general-alert {
        background: rgba(239, 68, 68, 0.12);
        border: 1px solid rgba(239, 68, 68, 0.3);
        color: #fca5a5;
        padding: 10px 14px;
        border-radius: 8px;
        font-size: 12.5px;
        line-height: 1.4;
        margin-bottom: 16px;
    }

    /* Botón de Envío */
    .sgns-submit-btn {
        width: 100%;
        background: #ffffff;
        color: #000000;
        border: none;
        padding: 16px 20px;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 2px;
        text-transform: uppercase !important;
        font-family: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif !important;
        border-radius: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: all 0.25s cubic-bezier(0.2, 0.8, 0.2, 1);
        margin-top: 10px;
        -webkit-tap-highlight-color: transparent;
    }
    .sgns-submit-btn:hover:not(:disabled) {
        background: #f4f4f5;
        transform: translateY(-2px);
        box-shadow: 0 12px 28px -6px rgba(255, 255, 255, 0.3);
    }
    .sgns-submit-btn:active:not(:disabled) {
        transform: translateY(0);
    }
    .sgns-submit-btn:disabled {
        opacity: 0.55;
        cursor: not-allowed;
    }

    .sgns-spin-icon {
        width: 16px;
        height: 16px;
        animation: sgnsSpin 0.8s linear infinite;
    }
    @keyframes sgnsSpin {
        to { transform: rotate(360deg); }
    }

    /* Pantalla de Éxito */
    .sgns-success-state {
        text-align: center;
        padding: 8px 0;
        animation: sgnsFadeIn 0.4s ease-out;
    }
    @keyframes sgnsFadeIn {
        from { opacity: 0; transform: translateY(8px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .sgns-success-icon-wrap {
        width: 58px;
        height: 58px;
        margin: 0 auto 14px;
    }
    .sgns-check-svg {
        width: 58px;
        height: 58px;
        border-radius: 50%;
        display: block;
        stroke-width: 3;
        stroke: #22c55e;
        stroke-miterlimit: 10;
        box-shadow: 0 0 25px rgba(34, 197, 94, 0.25);
    }
    .sgns-check-circle {
        stroke-dasharray: 166;
        stroke-dashoffset: 166;
        stroke-width: 3;
        stroke: #22c55e;
        fill: none;
        animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
    }
    .sgns-check-path {
        transform-origin: 50% 50%;
        stroke-dasharray: 48;
        stroke-dashoffset: 48;
        animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.6s forwards;
    }
    @keyframes stroke {
        100% { stroke-dashoffset: 0; }
    }

    .sgns-success-title {
        font-family: 'Blunt Semiconit', 'Outfit', sans-serif !important;
        font-size: 24px;
        letter-spacing: 1.5px;
        color: #ffffff;
        margin: 10px 0 6px 0;
    }
    .sgns-success-msg {
        font-size: 13.5px;
        color: #a1a1aa;
        line-height: 1.45;
        margin: 0 0 20px 0;
    }

    .sgns-ticket-preview {
        background: #141418;
        border: 1px dashed rgba(255, 255, 255, 0.15);
        border-radius: 12px;
        padding: 16px;
        text-align: left;
    }
    .sgns-ticket-line {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 7px 0;
        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        font-size: 12.5px;
    }
    .sgns-ticket-line--block {
        flex-direction: column;
        align-items: flex-start;
        gap: 6px;
    }
    .sgns-ticket-members {
        display: flex;
        flex-direction: column;
        gap: 4px;
        width: 100%;
        padding-left: 4px;
    }
    .sgns-member-row {
        color: #ffffff;
        font-weight: 500;
        font-size: 12.5px;
    }
    .sgns-ticket-line:last-child {
        border-bottom: none;
    }
    .sgns-ticket-label {
        color: #71717a;
        font-size: 10.5px;
        font-weight: 700;
        letter-spacing: 1px;
    }
    .sgns-ticket-val {
        color: #ffffff;
        font-weight: 600;
        text-align: right;
    }
    .sgns-text-highlight {
        color: #facc15 !important;
    }
    .sgns-text-green {
        color: #22c55e !important;
    }

    /* Responsive fine-tuning */
    @media (max-width: 480px) {
        .sgns-event-page {
            padding: 24px 14px 44px;
        }
        .sgns-event-card {
            padding: 22px 16px 20px;
            border-radius: 18px;
        }
        .sgns-event-logo {
            height: 120px;
        }
        .sgns-event-title {
            font-size: 23px;
            letter-spacing: 2px;
        }
    }
</style>

{# Carga de Supabase Client #}
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>

<script>
(function() {
    // =========================================================================
    // CONFIGURACIÓN DE SUPABASE
    // =========================================================================
    const SUPABASE_CONFIG = {
        url: 'https://byuqwgvjdymypthqpzig.supabase.co',
        anonKey: 'sb_publishable_k5U9eRBSGEeMyu-bCBjKAQ_N56holGK',
        table: 'registros_evento'
    };

    let supabaseClient = null;
    if (window.supabase && SUPABASE_CONFIG.url) {
        try {
            supabaseClient = window.supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
        } catch (e) {
            console.warn('[Supabase Init Error]', e);
        }
    }

    // Elementos del DOM
    const form = document.getElementById('sgnsEventForm');
    const submitBtn = document.getElementById('eventSubmitBtn');
    const btnText = submitBtn.querySelector('.sgns-btn-text');
    const btnSpinner = submitBtn.querySelector('.sgns-btn-spinner');
    const generalAlert = document.getElementById('eventGeneralAlert');
    const successState = document.getElementById('sgnsSuccessState');

    const selectJuego = document.getElementById('eventJuego');
    const inputEquipo = document.getElementById('eventEquipo');
    const inputP1 = document.getElementById('eventParticipante1');
    const inputP2 = document.getElementById('eventParticipante2');
    const inputP3 = document.getElementById('eventParticipante3');
    const inputE1 = document.getElementById('eventEdad1');
    const inputE2 = document.getElementById('eventEdad2');
    const inputE3 = document.getElementById('eventEdad3');
    const inputEmail = document.getElementById('eventEmail');
    const inputTelefono = document.getElementById('eventTelefono');

    const errorJuego = document.getElementById('errorJuego');
    const errorEquipo = document.getElementById('errorEquipo');
    const errorP1 = document.getElementById('errorParticipante1');
    const errorP2 = document.getElementById('errorParticipante2');
    const errorP3 = document.getElementById('errorParticipante3');
    const errorE1 = document.getElementById('errorEdad1');
    const errorE2 = document.getElementById('errorEdad2');
    const errorE3 = document.getElementById('errorEdad3');
    const errorEmail = document.getElementById('errorEmail');
    const errorTelefono = document.getElementById('errorTelefono');

    function setError(input, errorEl, message) {
        input.classList.add('has-error');
        errorEl.textContent = message;
    }

    function clearError(input, errorEl) {
        input.classList.remove('has-error');
        errorEl.textContent = '';
        generalAlert.style.display = 'none';
    }

    // Ping Pong se juega individual: se anota una sola persona, sin nombre de equipo
    function esIndividual(juego) {
        return juego === 'Ping Pong';
    }

    // =========================================================================
    // REGLAS DE CADA JUEGO
    // =========================================================================
    const REGLAS = {
        'Fútbol': `<ul>
            <li>3 jugadores por equipo, todos pueden atacar y defender.</li>
            <li>Sin arquero fijo: cualquiera puede defender el arco, pero sin usar las manos.</li>
            <li>Arcos chicos, aprox. 1,20–1,50 m de ancho × 0,80–1 m de alto.</li>
            <li>Cancha chica, aprox. 15–20 m × 10–12 m.</li>
            <li>Partidos de 4 minutos, o gana el primero que llegue a 5 goles.</li>
            <li>Cambios libres si permitís suplente.</li>
            <li>Si empatan en eliminación directa: penales o "gol de oro".</li>
        </ul>`,
        'Básquet': `<ul>
            <li>3 jugadores por equipo.</li>
            <li>Partidos de 4 minutos, o gana el primero que llegue a 12 puntos.</li>
            <li>El triple vale 3 puntos y el doble vale 2.</li>
            <li>Habrá tiros libres (un solo tiro) y vale 1 punto.</li>
        </ul>`,
        'Ping Pong': `<ul>
            <li>Se juega individual, a 11 puntos.</li>
            <li>3 saques cada uno, en forma cruzada.</li>
            <li>Si tenés tu propia paleta la podés traer; si no, nosotros te la damos.</li>
        </ul>`
    };

    const rulesModal = document.getElementById('sgnsRulesModal');
    const rulesModalClose = document.getElementById('sgnsRulesModalClose');
    const modalRulesBody = document.getElementById('sgnsModalRulesBody');
    const modalTabs = document.querySelectorAll('.sgns-modal-tab');
    const btnVerReglas = document.getElementById('btnVerReglas');

    function renderModalRules(juego) {
        modalRulesBody.innerHTML = REGLAS[juego] || '<p>Reglas a definir.</p>';
        modalTabs.forEach(tab => tab.classList.toggle('active', tab.getAttribute('data-rule') === juego));
    }

    function openRulesModal() {
        const inicial = selectJuego.value || 'Fútbol';
        renderModalRules(inicial);
        rulesModal.style.display = 'flex';
    }

    function closeRulesModal() {
        rulesModal.style.display = 'none';
    }

    btnVerReglas.addEventListener('click', openRulesModal);
    rulesModalClose.addEventListener('click', closeRulesModal);
    rulesModal.addEventListener('click', (e) => {
        if (e.target === rulesModal) closeRulesModal();
    });
    modalTabs.forEach(tab => {
        tab.addEventListener('click', () => renderModalRules(tab.getAttribute('data-rule')));
    });

    function applyModoJuego() {
        const individual = esIndividual(selectJuego.value);
        document.getElementById('groupEquipo').style.display = individual ? 'none' : '';
        document.getElementById('groupParticipante2').style.display = individual ? 'none' : '';
        document.getElementById('groupParticipante3').style.display = individual ? 'none' : '';
        document.getElementById('dividerIntegrantes').textContent = individual ? 'JUGADOR' : 'INTEGRANTES DEL EQUIPO';
        document.getElementById('labelParticipante1').textContent = individual ? 'NOMBRE Y APELLIDO' : 'PARTICIPANTE 1';
        document.getElementById('eventSubtitle').textContent = individual
            ? 'Inscribite para participar (Ping Pong es individual)'
            : 'Inscribí a tu equipo de 3 integrantes para participar';
        if (individual) {
            clearError(inputEquipo, errorEquipo);
            clearError(inputP2, errorP2);
            clearError(inputP3, errorP3);
            clearError(inputE2, errorE2);
            clearError(inputE3, errorE3);
        }
    }

    // Limpieza de errores en tiempo real
    selectJuego.addEventListener('change', () => {
        clearError(selectJuego, errorJuego);
        applyModoJuego();
    });
    // El navegador puede restaurar el juego elegido al volver atrás
    applyModoJuego();
    inputEquipo.addEventListener('input', () => clearError(inputEquipo, errorEquipo));
    inputP1.addEventListener('input', () => clearError(inputP1, errorP1));
    inputP2.addEventListener('input', () => clearError(inputP2, errorP2));
    inputP3.addEventListener('input', () => clearError(inputP3, errorP3));
    inputE1.addEventListener('input', () => clearError(inputE1, errorE1));
    inputE2.addEventListener('input', () => clearError(inputE2, errorE2));
    inputE3.addEventListener('input', () => clearError(inputE3, errorE3));
    inputEmail.addEventListener('input', () => clearError(inputEmail, errorEmail));
    inputTelefono.addEventListener('input', () => clearError(inputTelefono, errorTelefono));

    function validate() {
        let valid = true;
        const individual = esIndividual(selectJuego.value);

        if (!selectJuego.value) {
            setError(selectJuego, errorJuego, 'Seleccioná un juego');
            valid = false;
        } else if (selectJuego.selectedOptions[0] && selectJuego.selectedOptions[0].disabled) {
            // Un juego cerrado puede quedar elegido (el navegador lo restaura al volver atrás): no se envía
            setError(selectJuego, errorJuego, 'Las inscripciones de este juego están cerradas');
            valid = false;
        }

        if (!inputP1.value.trim()) {
            setError(inputP1, errorP1, individual ? 'Ingresá tu nombre y apellido' : 'Ingresá el nombre del participante');
            valid = false;
        }

        const validarEdad = (input, errorEl) => {
            const n = parseInt(input.value, 10);
            if (!Number.isInteger(n) || n < 5 || n > 99) {
                setError(input, errorEl, 'Ingresá una edad válida');
                valid = false;
            }
        };
        validarEdad(inputE1, errorE1);

        if (!individual) {
            validarEdad(inputE2, errorE2);
            validarEdad(inputE3, errorE3);
            if (!inputEquipo.value.trim()) {
                setError(inputEquipo, errorEquipo, 'Ingresá el nombre del equipo');
                valid = false;
            }
            if (!inputP2.value.trim()) {
                setError(inputP2, errorP2, 'Ingresá el nombre del participante');
                valid = false;
            }
            if (!inputP3.value.trim()) {
                setError(inputP3, errorP3, 'Ingresá el nombre del participante');
                valid = false;
            }
        }

        // Solo validar formato de email si fue ingresado
        const emailVal = inputEmail.value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (emailVal && !emailRegex.test(emailVal)) {
            setError(inputEmail, errorEmail, 'Ingresá un correo válido');
            valid = false;
        }

        // Solo validar formato de teléfono si fue ingresado
        const telVal = inputTelefono.value.trim();
        const telClean = telVal.replace(/\D/g, '');
        if (telVal && telClean.length < 7) {
            setError(inputTelefono, errorTelefono, 'Ingresá un teléfono válido (mínimo 7 dígitos)');
            valid = false;
        }

        return valid;
    }

    function setLoading(loading) {
        submitBtn.disabled = loading;
        btnText.style.display = loading ? 'none' : 'inline-block';
        btnSpinner.style.display = loading ? 'inline-flex' : 'none';
    }

    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        generalAlert.style.display = 'none';

        if (!validate()) {
            const firstError = form.querySelector('.has-error');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            return;
        }

        setLoading(true);

        const individual = esIndividual(selectJuego.value);
        const p1 = inputP1.value.trim();
        const p2 = individual ? '' : inputP2.value.trim();
        const p3 = individual ? '' : inputP3.value.trim();
        // En individual el "equipo" es el propio jugador, así la lista lo muestra con su nombre
        const equipo = individual ? p1 : inputEquipo.value.trim();

        const data = {
            juego: selectJuego.value,
            equipo: equipo,
            participante_1: p1,
            participante_2: p2,
            participante_3: p3,
            edad_1: parseInt(inputE1.value, 10),
            edad_2: individual ? null : parseInt(inputE2.value, 10),
            edad_3: individual ? null : parseInt(inputE3.value, 10),
            email: inputEmail.value.trim().toLowerCase(),
            telefono: inputTelefono.value.trim(),
            // Campos de compatibilidad en caso de que la tabla use las columnas anteriores
            nombre: `${equipo} (${selectJuego.value})`,
            apellido: individual ? p1 : `${p1} / ${p2} / ${p3}`
        };

        try {
            // Guardado de respaldo local
            try {
                const stored = JSON.parse(localStorage.getItem('sgns_evento_registros') || '[]');
                stored.push({ ...data, fecha: new Date().toISOString() });
                localStorage.setItem('sgns_evento_registros', JSON.stringify(stored));
            } catch (storageErr) {
                console.warn('[LocalStorage Warning]', storageErr);
            }

            // Inserción en Supabase si está disponible
            if (supabaseClient) {
                try {
                    const { error } = await supabaseClient
                        .from(SUPABASE_CONFIG.table)
                        .insert([data]);

                    if (error) {
                        console.warn('[Supabase Insert Notice]:', error.message || error);
                        // Si es error de duplicado
                        if (error.code === '23505') {
                            throw new Error('Este correo o equipo ya se encuentra registrado.');
                        }
                    }
                } catch (sbErr) {
                    console.warn('[Supabase Direct Notice]:', sbErr);
                    if (sbErr.message && sbErr.message.includes('ya se encuentra registrado')) {
                        throw sbErr;
                    }
                }
            }

            // Éxito: renderizar el Ticket con los datos del equipo (o del jugador en individual)
            form.style.display = 'none';
            document.getElementById('successBadge').textContent = individual ? 'INSCRIPCIÓN CONFIRMADA' : 'EQUIPO CONFIRMADO';
            document.getElementById('successMsg').textContent = individual
                ? 'Tus datos han sido registrados correctamente en la lista oficial del torneo.'
                : 'Los datos del equipo han sido registrados correctamente en la lista oficial del torneo.';
            document.getElementById('ticketEquipoLabel').textContent = individual ? 'JUGADOR' : 'EQUIPO';
            document.getElementById('ticketParticipantesLabel').textContent = individual ? 'PARTICIPANTE' : 'PARTICIPANTES';
            document.getElementById('ticketRowP2').style.display = individual ? 'none' : '';
            document.getElementById('ticketRowP3').style.display = individual ? 'none' : '';
            document.getElementById('successEquipoTitle').textContent = `¡${(data.equipo || (individual ? 'JUGADOR' : 'EQUIPO')).toUpperCase()} REGISTRADO!`;
            document.getElementById('ticketEquipo').textContent = data.equipo || 'Sin nombre';
            document.getElementById('ticketJuego').textContent = (data.juego || 'A definir').toUpperCase();
            document.getElementById('ticketP1').textContent = data.participante_1 || '-';
            document.getElementById('ticketP2').textContent = data.participante_2 || '-';
            document.getElementById('ticketP3').textContent = data.participante_3 || '-';
            const contactoTexto = [data.telefono, data.email].filter(Boolean).join(' • ') || 'Sin datos de contacto';
            document.getElementById('ticketContacto').textContent = contactoTexto;
            document.getElementById('sgnsSuccessRulesBody').innerHTML = REGLAS[data.juego] || '<p>Reglas a definir.</p>';
            successState.style.display = 'block';

            // Scroll suave hacia la confirmación
            successState.scrollIntoView({ behavior: 'smooth', block: 'center' });

        } catch (err) {
            console.error('[Error de Registro]', err);
            generalAlert.textContent = err.message || 'Ocurrió un inconveniente. Por favor revisá los datos e intentá nuevamente.';
            generalAlert.style.display = 'block';
        } finally {
            setLoading(false);
        }
    });

    // Limpieza activa en el DOM para remover modales, WhatsApp o banners
    function cleanDOM() {
        document.querySelectorAll('.btn-whatsapp, .js-btn-whatsapp, .sgns-wa-bubble, .redesign-top-banner, .section-header, .marketing-modal').forEach(function(el) {
            el.remove();
        });
    }
    cleanDOM();
    window.addEventListener('DOMContentLoaded', cleanDOM);
    window.addEventListener('load', cleanDOM);
    setTimeout(cleanDOM, 400);
    setTimeout(cleanDOM, 1200);
})();
</script>
