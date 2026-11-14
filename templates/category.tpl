{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}
{% paginate by 12 %}

{# Categorías Drop (la URL dice "drop"): hero con video arriba de los productos, como el del inicio.
   Drop Gorras no: usa la plantilla normal de productos. Cyber Monday usa el mismo hero #}
{% if ('drop' in category.url | lower and 'gorra' not in category.url | lower) or 'cyber' in category.url | lower %}
	{% include 'snipplets/drop-hero.tpl' %}
{% endif %}

{% if not show_help %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
{% if category_banner %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}
<section class="container-fluid mt-3 d-md-none">
	{% include "snipplets/breadcrumbs.tpl" %}
</section>

{% set desktop_category_controls_transparent = settings.filters_desktop_modal and settings.head_fix_desktop and settings.head_transparent and settings.head_transparent_type == 'all' %}

<section class="js-category-controls-prev category-controls-sticky-detector"></section>
<section class="js-category-controls {% if desktop_category_controls_transparent %}js-category-controls-transparent-md category-controls-transparent-md{% endif %} category-controls {% if not settings.filters_desktop_modal %}position-relative-md{% endif %} container-fluid visible-when-content-ready">
	<div class="row align-items-center">
		<div class="col">
			<div class="row align-items-center">
				<div class="col-auto">
					<div class="category-breadcrumbs-container d-none d-md-block">
						{% include "snipplets/breadcrumbs.tpl" %}
					</div>
					{% embed "snipplets/page-header.tpl" with {'breadcrumbs': false} %}
					    {% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
					{% endembed %}
				</div>
				<div class="visible-when-content-ready col text-right d-none d-md-block">
					{% include "snipplets/grid/filters.tpl" with {applied_filters: true} %}
				</div>
			</div>
		</div>
		<div class="col-12 col-md-auto d-none d-md-block">
			{% if products %}
				{{ component(
                    'sort-by',{
                        label: false,
                        sort_by_classes: {
                            select_group: "form-group-small d-inline-block w-auto mb-0",
                            select: "btn btn-default btn-medium text-left font-weight-bold ",
                            select_svg: "icon-inline icon-w-14 icon-lg icon-rotate-90",
                        },
                        select_svg_id: 'chevron'
					}) 
                }}
			{% endif %}
		</div>
		{% include 'snipplets/grid/filters-modals.tpl' %}
	</div>
</section>
{% if category.description %} 
	<p class="mt-2 mb-3 mt-md-0 mb-md-4 container-fluid">{{ category.description }}</p> 
{% endif %}
<div class="container-fluid visible-when-content-ready d-md-none">
	{% include "snipplets/grid/filters.tpl" with {mobile: true, applied_filters: true} %}
</div>

<section class="js-category-body category-body mt-2 mt-md-{% if settings.filters_desktop_modal or (not settings.filters_desktop_modal and not has_filters_available) %}0{% else %}4 pt-md-1{% endif %}">
	<div class="container-fluid">
		<div class="row">
			{% include "snipplets/grid/filters-sidebar.tpl" %}
			{% include 'snipplets/grid/products-list.tpl' %}
		</div>
	</div>
</section>
{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}

{# Modal de Descuentos Proximamente (Solo para la ruta /descuentos/) #}
{% if category.handle == 'descuentos' or category.slug == 'descuentos' or 'descuentos' in category.name | lower %}
    <!-- Estilos del Modal Proximamente -->
    <style>
        .redesign-modal-custom {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 100000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }
        .redesign-modal-custom.is-open {
            opacity: 1;
            visibility: visible;
        }
        .redesign-modal-custom .modal-content {
            background: #000;
            padding: 45px 30px;
            border-radius: 24px;
            max-width: 400px;
            width: 90%;
            text-align: center;
            position: relative;
            transform: scale(0.9) translateY(30px);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 30px 70px rgba(0,0,0,0.8);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .redesign-modal-custom.is-open .modal-content {
            transform: scale(1) translateY(0);
        }
        .redesign-modal-custom .modal-close {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 32px;
            background: none;
            border: none;
            cursor: pointer;
            color: #555;
            line-height: 1;
            transition: color 0.3s ease;
        }
        .redesign-modal-custom .modal-close:hover {
            color: #fff;
        }
        .redesign-modal-custom .modal-icon {
            font-size: 54px;
            margin-bottom: 20px;
            animation: pulseEmoji 2s infinite;
        }
        @keyframes pulseEmoji {
            0% { transform: scale(1); }
            50% { transform: scale(1.15); }
            100% { transform: scale(1); }
        }
        .redesign-modal-custom .modal-title {
            font-family: 'Blunt Semiconit', sans-serif;
            font-size: 30px;
            margin-bottom: 12px;
            color: #fff;
            letter-spacing: 1px;
        }
        .redesign-modal-custom .modal-text {
            font-family: 'Outfit', sans-serif;
            font-size: 19px;
            color: #fff;
            margin-bottom: 8px;
            font-weight: 500;
            line-height: 1.3;
        }
        .redesign-modal-custom .modal-subtext {
            font-family: 'Outfit', sans-serif;
            font-size: 15px;
            color: #999;
            margin-bottom: 30px;
        }
        .redesign-modal-custom .modal-btn-close {
            width: 100%;
            padding: 18px;
            font-weight: bold;
            letter-spacing: 1px;
            border-radius: 12px;
            cursor: pointer;
            background: #fff;
            color: #000;
            border: none;
            box-shadow: none !important;
            transition: all 0.3s ease;
        }
        .redesign-modal-custom .modal-btn-close:hover {
            background: #eee;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255,255,255,0.1) !important;
        }
    </style>

    <!-- Modal HTML -->
    <div id="js-modal-proximamente" class="redesign-modal-custom">
        <div class="modal-content">
            <button class="modal-close" aria-label="Cerrar">&times;</button>
            <div class="modal-body">
                <div class="modal-icon">🔥</div>
                <h2 class="modal-title">¡PRÓXIMAMENTE!</h2>
                <p class="modal-text">Vamos a cargando descuentos muy bomba para vos.</p>
                <p class="modal-subtext">¡Estate atento a nuestras Historias!</p>
                <button class="redesign-btn-primary modal-btn-close">ENTENDIDO</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('js-modal-proximamente');
            if (modal) {
                // Abrir automáticamente si es la página de descuentos
                setTimeout(() => {
                    modal.classList.add('is-open');
                    document.body.style.overflow = 'hidden';
                }, 500);

                const closeBtns = modal.querySelectorAll('.modal-close, .modal-btn-close');
                closeBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        modal.classList.remove('is-open');
                        document.body.style.overflow = '';
                    });
                });
                
                modal.addEventListener('click', function(e) {
                    if (e.target === modal) {
                        modal.classList.remove('is-open');
                        document.body.style.overflow = '';
                    }
                });
            }
        });
    </script>
{% endif %}