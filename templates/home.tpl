{# Detect presence of features that remove empty placeholders #}

{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_video = settings.video_embed %}
{% set has_main_categories = settings.main_categories and settings.slider_categories and settings.slider_categories is not empty %}
{% set has_banners = settings.banner and settings.banner is not empty %}
{% set has_promotional_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
{% set has_news_banners = settings.banner_news and settings.banner_news is not empty %}
{% set has_image_and_text_module = settings.module and settings.module is not empty %}
{% set has_informative_banners = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_01_description or settings.banner_services_02_description or settings.banner_services_03_description) %}
{% set has_instafeed = settings.show_instafeed and store.instagram and store.hasInstagramToken() %}
{% set has_welcome_message = settings.welcome_message or settings.welcome_text %}
{% set has_institutional_message = settings.institutional_message or settings.institutional_text %}
{% set has_testimonial_01 = settings.testimonial_01_description or settings.testimonial_01_name or "testimonial_01.jpg" | has_custom_image %}
{% set has_testimonial_02 = settings.testimonial_02_description or settings.testimonial_02_name or "testimonial_02.jpg" | has_custom_image %}
{% set has_testimonial_03 = settings.testimonial_03_description or settings.testimonial_03_name or "testimonial_03.jpg" | has_custom_image %}
{% set has_testimonials = has_testimonial_01 or has_testimonial_02 or has_testimonial_03 %}
{% set has_brands = settings.brands and settings.brands is not empty %}

{% set show_help = not (has_main_slider or has_mobile_slider or has_video or has_main_categories or has_banners or has_promotional_banners or has_news_banners or has_image_and_text_module or has_informative_banners or has_instafeed or has_welcome_message or has_institutional_message or has_testimonials or has_brands) and not has_products %}

{% set show_component_help = params.preview %}

{% if show_component_help %}
	{% include "snipplets/svg/empty-placeholders.tpl" %}
{% endif %}

{% if not params.preview %}
    {% set admin_link = is_theme_draft ? '/admin/themes/settings/draft/' : '/admin/themes/settings/active/' %}
{% endif %}

{% set newArray = [] %}

<!-- ========================================== -->
<!-- ORIGINAL HOME CONTENT (Hidden in Redesign) -->
<!-- ========================================== -->
<div class="original-home-content">
<div class="js-home-sections-container home-sections-container">
	{% for i in 1..18 %}
        {% set section = 'home_order_position_' ~ i %}
        {% set section_select = attribute(settings, section) %}

        {% if section_select not in newArray %}
            {% include 'snipplets/home/home-section-switch.tpl' %}
            {% set newArray = newArray|merge([section_select]) %}
        {% endif %}

    {% endfor %}

    {#  **** Hidden Sections ****  #}
    {% if show_component_help %}
        <div style="display:none">
            {% for section_select in ['slider', 'main_categories', 'products', 'informatives', 'categories', 'new', 'video', 'sale', 'main_product', 'instafeed', 'promotional', 'news_banners', 'newsletter', 'welcome', 'testimonials', 'brands', 'modules', 'institutional'] %}
                {% if section_select not in newArray %}
                    {% include 'snipplets/home/home-section-switch.tpl' %}
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
</div>

{% if settings.home_promotional_popup and ("home_popup_image.jpg" | has_custom_image or settings.home_popup_title or settings.home_popup_txt or settings.home_news_box or (settings.home_popup_btn and settings.home_popup_url)) %}
	{% include 'snipplets/home/home-popup.tpl' %}
{% endif %}
</div>

<!-- ========================================== -->
<!-- REDESIGN HOME CONTENT (Visible in Redesign)-->
<!-- ========================================== -->
<style>
    /* SEGURIDAD: Ocultar el rediseño para clientes finales si el CSS aún no cargó */
    .redesign-home-content {
        display: none !important;
    }
    .redesign-active .redesign-home-content {
        display: block !important;
    }
    /* Ocultar elementos para evitar que parpadeen antes de que carguen las animaciones */
    .redesign-hero-title, .redesign-hero-subtitle, .redesign-btn-primary {
        opacity: 0;
    }
</style>
<div class="redesign-home-content">
    
    <!-- 1. HERO VIDEO -->
    <section class="redesign-hero">
        <!-- Video de fondo cargado desde el FTP -->
        <video autoplay muted loop playsinline class="redesign-hero-video">
            <source src="{{ 'recortado-7026828-uhd_4096_2160_25fps.mp4' | static_url }}" type="video/mp4">
        </video>
        
        <div class="redesign-hero-overlay"></div>
        
        <div class="redesign-hero-content-box">
            <h1 class="redesign-hero-title">TEMP'26</h1>
            <p class="redesign-hero-subtitle">
                <span class="redesign-text-rotator">
                    <span class="active">LOS MEJORES PRECIOS</span>
                    <span>LA MEJOR CALIDAD</span>
                </span>
            </p>
            <a href="/productos" class="redesign-btn-primary">
                VER COLECCIÓN
            </a>
            
            <div class="redesign-scroll-indicator">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 5V19M12 19L5 12M12 19L19 12" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
        </div>

        <!-- Banner de Beneficios en el Video -->
        <div class="redesign-hero-benefits">
            <span class="benefit-text">15% DE DESCUENTO CON TRANSFERENCIA</span>
            <span class="benefit-sep">|</span>
            <span class="benefit-text">ENVIOS A TODO EL PAIS</span>
            <span class="benefit-sep">|</span>
            <span class="benefit-text">3 Y 6 CUOTAS SIN INTERES</span>
        </div>
    </section>

    <!-- 2. NOVEDADES SECTION -->
    <section class="redesign-novedades">
        <div class="novedades-container">
            <!-- Columna Izquierda: Imagen / Carrusel -->
            <!-- Columna Izquierda: Carrusel Automático -->
            <div class="novedades-media">
                <div class="novedades-carousel" data-redesign-animate="fadeIn" data-redesign-delay="0">
                    <!-- Slides de a 2 imágenes -->
                    <div class="novedades-carousel-track">
                        <!-- Slide 1: Par de imágenes -->
                        <div class="novedades-slide">
                            <div class="novedades-slide-pair">
                                <img src="{{ 'images/Gemini_Generated_Image_bwi1xsbwi1xsbwi1.png' | static_url }}" alt="Signos Editorial 2026 — 1">
                                <img src="{{ 'images/Gemini_Generated_Image_88smk788smk788sm.png' | static_url }}" alt="Signos Editorial 2026 — 2">
                            </div>
                        </div>
                        <!-- Slide 2: Par de imágenes -->
                        <div class="novedades-slide">
                            <div class="novedades-slide-pair">
                                <img src="{{ 'images/Gemini_Generated_Image_pz2dg5pz2dg5pz2d.png' | static_url }}" alt="Signos Editorial 2026 — 3">
                                <img src="{{ 'images/Gemini_Generated_Image_bwi1xsbwi1xsbwi1.png' | static_url }}" alt="Signos Editorial 2026 — 4">
                            </div>
                        </div>
                        <!-- Clon del Slide 1 para loop infinito -->
                        <div class="novedades-slide">
                            <div class="novedades-slide-pair">
                                <img src="{{ 'images/Gemini_Generated_Image_bwi1xsbwi1xsbwi1.png' | static_url }}" alt="Signos Editorial 2026 — 1 Clone">
                                <img src="{{ 'images/Gemini_Generated_Image_88smk788smk788sm.png' | static_url }}" alt="Signos Editorial 2026 — 2 Clone">
                            </div>
                        </div>
                    </div>
                    <!-- Puntos indicadores -->
                    <div class="novedades-dots">
                        <span class="novedades-dot active" data-index="0"></span>
                        <span class="novedades-dot" data-index="1"></span>
                    </div>
                </div>
            </div>
            
            <!-- Columna Derecha: Textos -->
            <div class="novedades-text-content">
                <p class="novedades-eyebrow" data-redesign-animate="fadeUp" data-redesign-delay="300">Otoño / Invierno — Colección 2026</p>
                <h2 class="novedades-title" data-redesign-animate="fadeUp" data-redesign-delay="600">Tu outfit habla antes que vos. <br>Dale algo bueno para contar.</h2>
                <p class="novedades-description" data-redesign-animate="fadeUp" data-redesign-delay="900">Cada pieza fue seleccionada pensando en vos. <br>Stock limitado, calidad que se nota</p>
                
                <div class="novedades-cta-wrapper" data-redesign-animate="fadeUp" data-redesign-delay="1200">
                    <div class="redesign-scroll-indicator" style="margin: 19px 0 1px 0; opacity: 0.5;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 5V19M12 19L5 12M12 19L19 12" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <a href="/productos" class="redesign-btn-gold">VER NOVEDADES</a>
                </div>
            </div>
        </div>
    </section>

    <!-- 3. OFFERS SECTION (Grilla Estática 4 Fotos con Urgencia) -->
    <section class="redesign-offers">
        <div class="container-wide">
            <div class="offers-header" data-redesign-animate="fadeUp">
                <h2 class="offers-section-title">OFERTAS Y DESCUENTOS</h2>
                <p class="offers-urgency-text">STOCK LIMITADO — ¡ESTAS PRENDAS SE TERMINAN HOY!</p>
            </div>
            
            <div class="offers-carousel-wrapper">
                <div class="offers-track">
                    <!-- Item 1 -->
                    <div class="offer-item" data-redesign-animate="fadeUp" data-redesign-delay="100">
                        <div class="offer-img-box">
                            <span class="offer-badge">-50% OFF</span>
                            <img src="{{ 'images/WhatsApp Image 2026-04-08 at 23.43.30 (1).jpeg' | static_url }}" alt="Oferta 1">
                        </div>
                        <div class="offer-info">
                            <h4>NUEVA COLECCIÓN I</h4>
                            <p class="price-box"><span class="old-price">$45.000</span> <span class="new-price">$22.500</span></p>
                            <p class="offer-installments">6 cuotas sin interés de <strong>$3.750</strong></p>
                        </div>
                    </div>
                    <!-- Item 2 -->
                    <div class="offer-item" data-redesign-animate="fadeUp" data-redesign-delay="200">
                        <div class="offer-img-box">
                            <span class="offer-badge">-40% OFF</span>
                            <img src="{{ 'images/WhatsApp Image 2026-04-08 at 23.43.30 (2).jpeg' | static_url }}" alt="Oferta 2">
                        </div>
                        <div class="offer-info">
                            <h4>NUEVA COLECCIÓN II</h4>
                            <p class="price-box"><span class="old-price">$38.000</span> <span class="new-price">$22.800</span></p>
                            <p class="offer-installments">6 cuotas sin interés de <strong>$3.800</strong></p>
                        </div>
                    </div>
                    <!-- Item 3 -->
                    <div class="offer-item" data-redesign-animate="fadeUp" data-redesign-delay="300">
                        <div class="offer-img-box">
                            <span class="offer-badge">-30% OFF</span>
                            <img src="{{ 'images/WhatsApp Image 2026-04-08 at 23.43.30 (3).jpeg' | static_url }}" alt="Oferta 3">
                        </div>
                        <div class="offer-info">
                            <h4>NUEVA COLECCIÓN III</h4>
                            <p class="price-box"><span class="old-price">$18.000</span> <span class="new-price">$12.600</span></p>
                            <p class="offer-installments">6 cuotas sin interés de <strong>$2.100</strong></p>
                        </div>
                    </div>
                    <!-- Item 4 -->
                    <div class="offer-item" data-redesign-animate="fadeUp" data-redesign-delay="400">
                        <div class="offer-img-box">
                            <span class="offer-badge">-35% OFF</span>
                            <img src="{{ 'images/WhatsApp Image 2026-04-08 at 23.43.30.jpeg' | static_url }}" alt="Oferta 4">
                        </div>
                        <div class="offer-info">
                            <h4>NUEVA COLECCIÓN IV</h4>
                            <p class="price-box"><span class="old-price">$52.000</span> <span class="new-price">$33.800</span></p>
                            <p class="offer-installments">6 cuotas sin interés de <strong>$5.633</strong></p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="offers-footer" data-redesign-animate="fadeUp">
                <a href="/promociones" class="redesign-btn-gold">Aprovechar ofertas</a>
            </div>
        </div>
    </section>

    <!-- 4. SOCIAL EXPERIENCE SECTION (Instagram & TikTok) -->
    <section class="redesign-social-feed">
        <div class="container-wide">
            <div class="social-header" data-redesign-animate="fadeUp">
                <h2 class="social-title">SEGUINOS EN REDES SOCIALES</h2>
                <p class="social-subtitle">Conectá con nuestra comunidad</p>
            </div>
            
            <div class="social-grid">
                <!-- Instagram Card -->
                <div class="social-card instagram-profile-card" data-redesign-animate="fadeUp" data-redesign-delay="200">
                    <div class="social-profile-header">
                        <div class="profile-pic-container">
                            <img src="{{ 'images/signoslogovip.png' | static_url }}" alt="Signos Profile" class="profile-pic">
                        </div>
                        <div class="profile-info-text">
                            <div class="profile-username">
                                signos_indumentaria
                                <svg class="verified-badge" viewBox="0 0 24 24"><path fill="#0095f6" d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm-1.9 14.7L6.3 12.9l1.4-1.4 2.4 2.4 5.6-5.6 1.4 1.4-7 7z"/></svg>
                            </div>
                            <div class="profile-full-name">THE SIGNOS COMPANY ®</div>
                        </div>
                        <div class="social-platform-icon"><svg><use xlink:href="#instagram"/></svg></div>
                    </div>
                    
                    <div class="profile-stats">
                        <div class="stat-item"><strong>3.1k</strong><span>POSTS</span></div>
                        <div class="stat-item"><strong>185k</strong><span>FOLLOWERS</span></div>
                        <div class="stat-item"><strong>5.4k</strong><span>FOLLOWING</span></div>
                    </div>

                    <div class="profile-bio">
                        <p>📍 O'HIGGINS 191</p>
                        <p>📍 VM WASHINGTON 691</p>
                        <p>📍 ZELARRAYAN 2250</p>
                        <p>📍 HORARIO DE CORRIDO: 09:30 a 20:30</p>
                    </div>

                    <div class="social-preview-grid">
                        <div class="grid-img">
                            <video autoplay muted loop playsinline class="grid-video video-align-top">
                                <source src="{{ 'ig/𝗡𝗢𝗦 𝗩𝗜𝗡𝗜𝗠𝗢𝗦 𝗛𝗔𝗦𝗧𝗔 𝗔𝗖𝗔 𝗣𝗔𝗥𝗔 𝗟𝗔𝗥𝗚𝗔𝗥 𝗘𝗦𝗧𝗔 𝗕𝗢𝗠𝗕𝗔𝟯𝘅𝟮 𝗻𝘂𝗲𝘃.mp4' | static_url }}" type="video/mp4">
                            </video>
                        </div>
                        <div class="grid-img">
                            <video autoplay muted loop playsinline class="grid-video">
                                <source src="{{ 'ig/Últimos días para hacer tu regalito🎁O elegir tu outfit para estas fiestasBanco provincia hasta .mp4' | static_url }}" type="video/mp4">
                            </video>
                        </div>
                        <div class="grid-img">
                            <video autoplay muted loop playsinline class="grid-video">
                                <source src="{{ 'ig/El regalo ideal para las fiestas está en @signos_indumentaria 🎅🌲🔥.mp4' | static_url }}" type="video/mp4">
                            </video>
                        </div>
                    </div>

                    <div class="social-actions-row">
                        <a href="{{ store.instagram }}" target="_blank" class="social-link-btn btn-ig">Seguir en Instagram</a>
                        <button class="social-share-btn"><svg viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/></svg></button>
                    </div>
                </div>
                
                <!-- TikTok Card -->
                <div class="social-card tiktok-profile-card" data-redesign-animate="fadeUp" data-redesign-delay="400">
                    <div class="social-profile-header">
                        <div class="profile-pic-container">
                            <img src="{{ 'images/signoslogovip.png' | static_url }}" alt="Signos TikTok" class="profile-pic">
                        </div>
                        <div class="profile-info-text">
                            <div class="profile-username">signos.oficial</div>
                            <div class="profile-full-name">SIGNOS INDUMENTARIA</div>
                        </div>
                        <div class="social-platform-icon">
                            <svg viewBox="0 0 448 512">
                                <path d="M448,209.91a210.06,210.06,0,0,1-122.77-39.25V349.38A162.55,162.55,0,1,1,185,188.31V278.2a74.62,74.62,0,1,0,52.23,71.18V0l88,0a121.18,121.18,0,0,0,1.86,22.17h0A122.18,122.18,0,0,0,381,102.39a121.43,121.43,0,0,0,67,20.14Z"/>
                            </svg>
                        </div>
                    </div>

                    <div class="profile-stats">
                        <div class="stat-item"><strong>12.5k</strong><span>LIKES</span></div>
                        <div class="stat-item"><strong>42k</strong><span>FOLLOWERS</span></div>
                        <div class="stat-item"><strong>120</strong><span>FOLLOWING</span></div>
                    </div>

                    <div class="profile-bio">
                        <p>🔥 Tendencia y Estilo Masculino</p>
                        <p>📦 Envíos a todo el país</p>
                        <p>⚡ Nueva Colección 2026 ya disponible</p>
                    </div>

                    <div class="social-preview-grid">
                        <div class="grid-img">
                            <video autoplay muted loop playsinline class="grid-video">
                                <source src="{{ 'ig/tiktok/@signos_indumentaria • 2025-2026 🔥.mp4' | static_url }}" type="video/mp4">
                            </video>
                        </div>
                        <div class="grid-img">
                            <video autoplay muted loop playsinline class="grid-video video-align-top">
                                <source src="{{ 'ig/tiktok/ALGUNAS OPCIONES DE OUTFITS QUE PODES ENCONTRAR EN SIGNOS⚡️.mp4' | static_url }}" type="video/mp4">
                            </video>
                        </div>
                        <div class="grid-img">
                            <video autoplay muted loop playsinline class="grid-video">
                                <source src="{{ 'ig/tiktok/Nueva PROMO solo hasta este finde! 😮_💨Buzos 2 x $90.000🔥Aprovecha que se viene el frío a llev.mp4' | static_url }}" type="video/mp4">
                            </video>
                        </div>
                    </div>

                    <div class="social-actions-row">
                        <a href="{{ store.tiktok }}" target="_blank" class="social-link-btn btn-tk">Seguir en TikTok</a>
                        <button class="social-share-btn"><svg viewBox="0 0 24 24"><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/></svg></button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>