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
                    <!-- Slides -->
                    <div class="novedades-carousel-track">
                        <div class="novedades-slide">
                            <img src="{{ 'images/Gemini_Generated_Image_bwi1xsbwi1xsbwi1.png' | static_url }}" alt="Signos Editorial 2026 — 1">
                        </div>
                        <div class="novedades-slide">
                            <img src="{{ 'images/Gemini_Generated_Image_88smk788smk788sm.png' | static_url }}" alt="Signos Editorial 2026 — 2">
                        </div>
                        <div class="novedades-slide">
                            <img src="{{ 'images/Gemini_Generated_Image_pz2dg5pz2dg5pz2d.png' | static_url }}" alt="Signos Editorial 2026 — 3">
                        </div>
                        <!-- Clon del primero para loop infinito -->
                        <div class="novedades-slide">
                            <img src="{{ 'images/Gemini_Generated_Image_bwi1xsbwi1xsbwi1.png' | static_url }}" alt="Signos Editorial 2026 — 1 Clone">
                        </div>
                    </div>
                    <!-- Puntos indicadores (sin flechas) -->
                    <div class="novedades-dots">
                        <span class="novedades-dot active" data-index="0"></span>
                        <span class="novedades-dot" data-index="1"></span>
                        <span class="novedades-dot" data-index="2"></span>
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

</div>