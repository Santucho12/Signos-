{% set megamenu = megamenu | default(false) %}
{% set hamburger = hamburger | default(false) %}
{% set subitem = subitem | default(false) %}

{% set hamburger_desktop_subpanels_position = '' %}

{% if settings.hamburger_desktop %}
	{% if settings.logo_position_desktop == 'center' %}
		{% set hamburger_desktop_subpanels_position = 'nav-list-panel-left-md' %}
	{% else %}
		{% set hamburger_desktop_subpanels_position = 'nav-list-panel-right-md' %}
	{% endif %}
{% endif %}

{% if megamenu %}
	{% set arrow_type = 'chevron' %}
	{% set arrow_classes = 'icon-md icon-rotate-90' %}
{% else %}
	{% set arrow_type = 'arrow-long' %}
	{% set arrow_classes = 'icon-lg' %}
{% endif %}

{% for item in navigation %}
	{% if item.subitems %}
		<li class="{% if megamenu %}js-item-desktop nav-item-desktop {% if not subitem %}nav-dropdown nav-main-item {% endif %}{% endif %}nav-item item-with-subitems" data-component="menu.item">
			{% if megamenu %}
			<div class="nav-item-container">
			{% endif %}
				<a class="{% if hamburger %}js-toggle-menu-panel align-items-center{% endif %} nav-list-link position-relative {{ item.current ? 'selected' : '' }}" href="{% if megamenu and item.url %}{{ item.url }}{% else %}#{% endif %}"><span class="nav-item-text-wrapper">{{ item.name }}</span>
					{% if not subitem or hamburger %}
						<span class="nav-list-arrow ml-1">
							<svg class="icon-inline svg-icon-text {{ arrow_classes }}"><use xlink:href="#{{ arrow_type }}"/></svg>
						</span>
					{% endif %}
				</a>
			{% if megamenu %}
			</div>
			{% endif %}
			{% if megamenu and not subitem %}
				<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown">
					<div class="container">
						<div class="row align-items-start">
							<div class="col-md-9">
								<ul class="desktop-list-subitems list-subitems">
									{% include 'snipplets/navigation/navigation-nav-list.tpl' with { 'navigation' : item.subitems, 'subitem' : true, 'megamenu' : true } %}
								</ul>
							</div>
							<div class="col-md-3 d-none d-md-block megamenu-img-col">
								<div class="megamenu-featured-card">
									<img src="{{ ('images/menu-' ~ item.name | lower | replace(' ', '-') ~ '.jpg') | static_url }}" class="megamenu-img" alt="{{ item.name }}" onerror="this.src='{{ 'images/signoslogovip.png' | static_url }}'; this.style.opacity='0.2';">
									<div class="megamenu-img-overlay">
										<span class="megamenu-img-title">{{ item.name }}</span>
										<span class="megamenu-img-cta">Ver todo →</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			{% elseif hamburger %}
				<ul class="js-menu-panel nav-list-panel nav-list-panel-right {{ hamburger_desktop_subpanels_position }} list-subitems" style="display:none;">
					<div class="modal-header">
						<div class="row align-items-center">
							<div class="col">
								<a class="js-toggle-menu-back" href="#">
									<span class="nav-back-icon">←</span>
									<span class="nav-back-text">{{ item.name }}</span>
								</a>
							</div>
							<div class="col-auto">
								<a class="js-toggle-menu-close js-modal-close">
									<svg class="icon-inline icon-lg modal-close-icon"><use xlink:href="#times"/></svg>
								</a>
							</div>
						</div>
					</div>
					{% if item.isCategory %}
						<li class="nav-item">
							<a class="nav-list-link position-relative {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">
								{% if item.isRootCategory %}
									{{ 'Ver todos los productos' | translate }}
								{% else %}
									{{ 'Ver todo en' | translate }} {{ item.name }}
								{% endif %}
							</a>
						</li>
					{% endif %}
					{% include 'snipplets/navigation/navigation-nav-list.tpl' with { 'navigation' : item.subitems, 'subitem' : true, 'hamburger' : true } %}
				</ul>
			{% endif %}
		</li>
	{% else %}
		<li class="js-item-desktop nav-item {% if megamenu %}nav-item-desktop {% if not subitem %}nav-main-item{% endif %}{% endif %}" data-component="menu.item">
			<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}"><span class="nav-item-text-wrapper">{{ item.name }}</span></a>
		</li>
	{% endif %}
{% endfor %}