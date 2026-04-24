{% if use_big_search %}
    <form class="js-search-container js-search-form {% if settings.search_big_desktop %}search-container {% if settings.logo_position_desktop != 'center' %}mr-md-3{% elseif settings.hamburger_desktop %}ml-md-3{% endif %}{% endif %}" action="{{ store.search_url }}" method="get">
        <div class="form-group m-0">
            <input class="js-search-input form-control search-input" autocomplete="off" type="search" name="q" placeholder="{{ '¿Qué estás buscando?' | translate }}" aria-label="{{ '¿Qué estás buscando?' | translate }}" />
            <button type="submit" class="btn search-input-submit" value="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscar' | translate }}">
                <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#search"/></svg>
            </button>
        </div>
    </form>
    <div class="js-search-suggest search-suggest {% if settings.logo_position_desktop != 'center' %}mr-md-3{% elseif settings.hamburger_desktop %}ml-md-3{% endif %}">
        {# AJAX container for search suggestions #}
    </div>

{% else %}
    {% set tabnav_icon_class = '' %}
    {% if tabnav %}
        {% set tabnav_icon_class = 'tabnav-icon tabnav-icon-open' %}
    {% endif %}
    <span class="utilities-container">
        <a href="#" class="js-modal-open js-search-button {% if tabnav %}js-toggle-tabnav tabnav-link{% endif %} utilities-link utilities-item" data-toggle="#nav-search" aria-label="{{ 'Buscador' | translate }}">
            <svg class="icon-inline utilities-icon {{ tabnav_icon_class }} original-search-icon"><use xlink:href="#search"/></svg>
            <span class="redesign-search-wrapper" style="display:none; align-items:center;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle;">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <span class="redesign-search-text d-none d-md-inline-block" style="margin-left: 6px; font-family: 'Montserrat', sans-serif; font-weight: 700; font-size: 13px; letter-spacing: 0.5px; vertical-align: middle;">BUSCAR</span>
            </span>
            {% if tabnav %}
                <svg class="tabnav-icon tabnav-icon-close icon-inline utilities-icon"><use xlink:href="#times"/></svg>
            {% endif %}
            {% if settings.utilities_type_desktop == 'icons_text' %}
                <span class="utilities-text d-none d-md-inline-block {% if settings.show_tab_nav %}mr-2 mr-md-0{% endif %}">{{ 'Buscar' | translate }}</span>
            {% endif %}
        </a>
    </span>
{% endif %}