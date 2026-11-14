{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}
{% set columns_desktop = template == 'home' ? section_columns_desktop : 4 %}
{% set columns_mobile = template == 'home' ? section_columns_mobile : settings.grid_columns_mobile %}
{% set theme_editor = params.preview %}
{% set appear_transition = appear_transition ?? true %}
{% set inline_quick_shop = settings.quick_shop and settings.quick_shop_type == 'inline' %}

{# Subscription only detection #}
{% set is_subscription_only = product.isSubscriptionOnly() %}

{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not reduced_item
    and not slide_item
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'item-slider-controls-container svg-square svg-icon-text d-none d-md-block' %}
    {% set control_next_svg_id = 'chevron' %}
    {% set control_prev_svg_id = 'chevron' %}
{% endif %}

{# Secondary images #}

{% set show_secondary_image = settings.product_hover %}

{# Etiquetas "CYBER SGNS" y "PRENDA DORADA" (puestas en los productos en Tiendanube): con ellas la tienda reconoce desde el
   servidor las prendas del Cyber y las doradas, sin esperar a static/js/prenda-dorada.js (en los listados Tiendanube no
   trae las categorías). product.tags llega como lista de textos #}
{% set tag_cyber = false %}
{% set tag_dorada = false %}
{% if product.tags is defined and product.tags %}
    {% for _tag in (product.tags is iterable ? product.tags : product.tags | split(',')) %}
        {% if _tag | trim | lower == 'cyber sgns' %}{% set tag_cyber = true %}{% endif %}
        {% if _tag | trim | lower == 'prenda dorada' %}{% set tag_dorada = true %}{% endif %}
    {% endfor %}
{% endif %}
{# Las doradas también llevan "(GOLD EDITION)" en el nombre. La dorada manda: si lo es, no lleva la tarjeta del Cyber #}
{% set dorada_srv = tag_dorada or 'gold edition' in product.name | lower %}
{% set cyber_srv = tag_cyber and not dorada_srv %}

{% if slide_item %}
    <div class="swiper-slide">
{% endif %}
    <div class="js-item-product{% if cyber_srv %} sgns-cyber-card{% endif %}{% if slide_item %} js-item-slide p-0{% endif %}{% if not slide_item %} col-{% if columns_mobile == 1 %}12{% elseif columns_mobile == 2 %}6{% else %}4{% endif %} col-md-{% if columns_desktop == 2 %}6{% elseif columns_desktop == 3 %}4{% else %}3{% endif %}{% endif %} item item-product {% if reduced_item %}item-product-reduced{% endif %} grid-item {% if reduced_item %}item-product-reduced{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}"{% if appear_transition %} data-transition="fade-in-up"{% endif %}>
        {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
            <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}">
        {% endif %}
        {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

        {# Set how much viewport space the images will take to load correct image #}

        {% if params.preview %}
            {% set mobile_image_viewport_space = '100' %}
            {% set desktop_image_viewport_space = '50' %}
        {% else %}
            {% if columns_mobile == 3 %}
                {% set mobile_image_viewport_space = '33' %}
            {% elseif columns_mobile == 2 %}
                {% set mobile_image_viewport_space = '50' %}
            {% else %}
                {% set mobile_image_viewport_space = '100' %}
            {% endif %}

            {% if columns_desktop == 4 %}
                {% set desktop_image_viewport_space = '25' %}
            {% elseif columns_desktop == 3 %}
                {% set desktop_image_viewport_space = '33' %}
            {% else %}
                {% set desktop_image_viewport_space = '50' %}
            {% endif %}
        {% endif %}

        {% set image_classes = 'js-item-image lazyautosizes ' ~ (not image_priority_high ? 'lazyload') ~ ' fade-in img-absolute img-absolute-centered' %}
        {% set data_expand = show_image_slider ? '50' : '-10' %}

        {% set floating_elements %}
            {% set is_novedad = false %}
            {% for category in product.categories %}
                {% if 'novedad' in category.name | lower %}
                    {% set is_novedad = true %}
                {% endif %}
            {% endfor %}
            {% if product.category and ('novedad' in product.category.name | lower) %}
                {% set is_novedad = true %}
            {% endif %}
            {# Productos de la categoría "Prenda dorada": badge dorado "ÚNICO", como el de descuento #}
            {% set is_dorada = false %}
            {% for category in product.categories %}
                {% if 'dorad' in category.name | lower %}
                    {% set is_dorada = true %}
                {% endif %}
            {% endfor %}
            {# También dentro de la propia categoría (por si el producto no la trae en product.categories) #}
            {% if template == 'category' and category is defined and category.name is defined and 'dorad' in category.name | lower %}
                {% set is_dorada = true %}
            {% endif %}
            {% if dorada_srv %}{% set is_dorada = true %}{% endif %}

            {% set discount_pct = product.display_price and product.compare_at_price > product.price ? ((product.compare_at_price - product.price) * 100 + product.compare_at_price // 2) // product.compare_at_price : 0 %}


            {% if discount_pct > 0 or is_novedad or is_dorada %}
                <div class="sgns-item-badges">
                    {% if discount_pct > 0 %}
                        <span class="sgns-discount-badge">-{{ discount_pct }}%</span>
                    {% endif %}
                    {% if is_dorada %}
                        <span class="sgns-discount-badge sgns-badge-unico">ÚNICO</span>
                    {% endif %}
                    {% if is_novedad %}
                        <div class="label-novedad-custom">NOVEDAD</div>
                    {% endif %}
                </div>
            {% endif %}

            <span class="sgns-bolsa" aria-hidden="true"><svg viewBox="0 0 565 512" aria-hidden="true"><path d="M528.22,422.85l-37.53-230.4c-6.05-37.16-38.15-64.45-75.8-64.45h-4.65C410.24,57.31,352.93,0,282.24,0S154.24,57.31,154.24,128h-4.65c-37.65,0-69.75,27.29-75.8,64.45l-37.53,230.4c-7.61,46.73,28.46,89.15,75.8,89.15H452.42c47.34,0,83.42-42.42,75.8-89.15ZM282.24,51.2c42.42,0,76.8,34.38,76.8,76.8H205.44c0-42.42,34.38-76.8,76.8-76.8Zm170.18,409.6H112.05c-15.78,0-27.8-14.14-25.27-29.72l37.53-230.4c2.02-12.39,12.72-21.48,25.27-21.48h4.65v51.2h51.2v-51.2h153.6v51.2h51.2v-51.2h4.65c12.55,0,23.25,9.1,25.27,21.48l37.53,230.4c2.54,15.58-9.48,29.72-25.27,29.72Z"/></svg></span>

            {% if not reduced_item %}
                <div class="item-floating-elements">
                    {% if settings.product_color_variants %}
                        {% include 'snipplets/labels.tpl' with {color: true} %}
                    {% else %}
                        {% include 'snipplets/labels.tpl' %}
                    {% endif %}
                    {% if show_image_slider %}
                        {% set slider_pagination_two_amount_classes = product.images_count == 2 ? 'two-bullets' %}
                        <div class="js-product-item-slider-pagination-container-private item-slider-pagination-container d-md-none {{ slider_pagination_two_amount_classes }}">
                            <div class="js-product-item-slider-pagination-private item-slider-pagination swiper-pagination" data-item-slider-id="{{ product.id }}"></div>
                        </div>
                    {% endif %}
                </div>
            {% endif %}
        {% endset %}

        {{ component(
            'product-item-image', {
                image_lazy: true,
                image_lazy_js: true,
                image_thumbs: ['small', 'medium', 'large', 'huge', 'original'],
                image_data_expand: data_expand,
                image_secondary_data_sizes: 'auto',
                image_sizes: '(max-width: 768px)' ~ mobile_image_viewport_space ~ 'vw, (min-width: 769px)' ~ desktop_image_viewport_space ~ 'vw',
                secondary_image: show_secondary_image,
                slider: show_image_slider,
                slider_pagination: false,
                placeholder: true,
                image_priority_high: image_priority_high,
                custom_content: floating_elements,
                product_item_image_classes: {
                    image_container: 'item-image' ~ (columns == 1 ? ' item-image-big'),
                    image_padding_container: 'position-relative d-block',
                    image: image_classes,
                    image_featured: 'item-image-featured',
                    image_secondary: 'item-image-secondary',
                    slider_container: 'swiper-container position-absolute h-100 w-100',
                    slider_wrapper: 'swiper-wrapper',
                    slider_slide: 'swiper-slide item-image-slide',
                    slider_control: 'icon-inline icon-lg',
                    slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class,
                    slider_control_prev: 'icon-flip-horizontal',
                    slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class,
                    more_images_message: 'item-more-images-message',
                    placeholder: 'placeholder-fade',
                },
                control_next_svg_id: control_next_svg_id,
                control_prev_svg_id: control_prev_svg_id,
            })
        }}

        {% if 
            ((settings.quick_shop and not product.isSubscribable()) or settings.product_color_variants)
            and product.available 
            and product.display_price 
            and product.variations 
            and not reduced_item 
        %}

            {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}
            {% if inline_quick_shop %}
                <div class="position-relative">
            {% endif %}
                <div class="js-item-variants {% if inline_quick_shop %}item-variants item-variants-hidden transition-soft{% else %}hidden{% endif %}">
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% if product.variations %}
                            {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                        {% endif %}
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                        {# Add to cart CTA #}

                        <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary w-100 mb-2 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                        {# Fake add to cart CTA visible during add to cart event #}

                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "mb-2"} %}
                    </form>
                </div>
            {% if inline_quick_shop %}
                </div>
            {% endif %}

        {% endif %}
        <div class="js-item-description item-description" data-store="product-item-info-{{ product.id }}">
            <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link{% if inline_quick_shop and not reduced_item %} item-link-quickshop{% endif %}">
                <div class="js-item-name item-name nov-card__name mb-2 {% if columns_mobile == 3 %}d-none d-md-block{% endif %}" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                {% if product.display_price %}
                    {% if is_subscription_only %}
                        {# Subscription only products: use subscription-price component with product_list location #}
                        {{ component('subscriptions/subscription-price', {
                            location: 'product_list',
                            subscription_classes: {
                                container: 'item-price-container {% if columns_mobile == 3 %}mb-0 mb-md-2{% else %}mb-2{% endif %}',
                                price_compare: 'price-compare',
                                price_with_subscription: 'item-price',
                            },
                        }) }}
                    {% else %}
                        {# Normal products: mismo bloque de precios que las cards del home #}
                        {% set transfer_pct = settings.payment_discount_price and not reduced_item and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
                        <div class="js-item-price-container item-price-container nov-card__price sgns-precio {% if columns_mobile == 3 %}mb-0 mb-md-2{% else %}mb-2{% endif %}" data-store="product-item-price-{{ product.id }}">
                            {% if not reduced_item %}
                                <span class="js-compare-price-display price-compare nov-card__compare sgns-precio__antes {% if columns_mobile == 3 and product.compare_at_price %}d-none d-md-inline-block{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %} data-price-compare-visibility="{{ product.compare_at_price ? 'true' : 'false' }}">
                                    {{ product.compare_at_price | money }}
                                </span>
                            {% endif %}
                            {# Precio, barra negra de cuotas y precio con transferencia (las cuotas antes iban más abajo) #}
                            <div class="js-price-display item-price sgns-precio__actual" data-product-price="{{ product.price }}">
                                {{ product.price | money }}
                            </div>
                            {% set max_free_installments = product.show_installments and product.get_max_installments(false) ? product.get_max_installments(false).installment : 1 %}
                            {% if settings.product_installments and not reduced_item and max_free_installments > 1 %}
                                <div class="sgns-precio__cuotas"><b>{{ max_free_installments }} cuotas sin interés</b> de {{ (product.price / max_free_installments) | round | money }}</div>
                            {% endif %}
                            {% if transfer_pct > 0 %}
                                <div class="sgns-precio__transf">{{ (product.price * (100 - transfer_pct) / 100) | round | money }} con transferencia</div>
                            {% endif %}
                        </div>
                    {% endif %}
                {% endif %}
                {% if settings.product_color_variants and not reduced_item %}
                    {% if columns_mobile == 3 or theme_editor %}
                        <span class="js-item-colors-container {% if columns_mobile == 3 %}d-none d-md-block{% endif %}">
                    {% endif %}
                        {% include 'snipplets/grid/item-colors.tpl' %}
                    {% if columns_mobile == 3 or theme_editor %}
                        </span>
                    {% endif %}
                {% endif %}
            </a>
            {% if settings.quick_shop and not reduced_item %}
                <div class="js-item-quickshop item-actions{% if inline_quick_shop %}-inline{% else %} mt-3{% endif %} {% if columns_mobile == 3 %}d-none d-md-block{% endif %}">
                    
                    {% if product.available and product.display_price %}

                        {% set quickshop_button_classes = inline_quick_shop ? 'item-btn-quickshop' : 'btn btn-primary btn-small' %}
                    
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
                        
                        {% if product.isSubscribable() %}

                            {# Product with subscription will link to the product page #}

                            {% set button_text = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) : texts[state] %}
                            {% set button_title = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) ~ ' ' ~ product.name : ('Compra rápida de' | translate) ~ ' ' ~ product.name %}
                            <a href="{{ product_url_with_selected_variant }}" class="{{ quickshop_button_classes }}" title="{{ button_title }}" aria-label="{{ button_title }}">
                                {% if inline_quick_shop %}
                                    <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#bag"/></svg>
                                {% else %}
                                    {{ button_text | translate }}
                                {% endif %}
                            </a>

                        {% else %}
                            {% if product.variations %}
                                
                                {% if inline_quick_shop %}
                                
                                    {# Open quickshop inline if has variants #}

                                    <button type="button" class="js-item-buy-open {{ quickshop_button_classes }}" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}">
                                        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#bag"/></svg>
                                    </button>
                                    <button type="button" class="js-item-buy-close {{ quickshop_button_classes }}" aria-label="{{ 'Cerrar compra rápida' | translate }}" style="display: none;">
                                        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#times"/></svg>
                                    </button>
                                {% else %}
                                    {# Open quickshop popup if has variants #}

                                    <a data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" href="#" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open js-fullscreen-modal-open {{ quickshop_button_classes }}" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">{{ 'Comprar' | translate }}</a>
                                {% endif %}
                            {% else %}
                                <form class="js-product-form d-inline-block" method="post" action="{{ store.cart_url }}">
                                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                    {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                    {% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
                                    {% set button_placeholder_icon = inline_quick_shop ? true : false %}
                                    {% set button_placeholder_classes = inline_quick_shop ? 'btn-quickshop item-btn-quickshop' : 'btn-small mb-2' %}

                                    {% if inline_quick_shop %}
                                        <div class="js-item-submit-container {{ quickshop_button_classes }}">
                                            <input type="submit" class="js-addtocart js-prod-submit-form btn {{ state }}" value="{{ texts[state] | translate }}" alt="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />
                                            <svg class="icon-inline icon-lg svg-icon-text item-btn-quickshop-icon"><use xlink:href="#bag"/></svg>
                                        </div>
                                    {% else %}
                                        <input type="submit" class="js-addtocart js-prod-submit-form {{ quickshop_button_classes }} w-100 mb-2 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"/>
                                    {% endif %}

                                    {# Fake add to cart CTA visible during add to cart event #}

                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: button_placeholder_classes, direct_add: true, icon: button_placeholder_icon} %}
                                </form>
                            {% endif %}
                        {% endif %}
                    {% endif %}
                </div>
            {% endif %}
        </div>
        {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
            </div>{# This closes the quickshop tag #}
        {% endif %}

        {# Structured data to provide information for Google about the product content #}
        {# PRENDA DORADA: los productos de la categoría "Prenda dorada" se muestran como carta de oro (estilo FIFA):
           escudo dorado, sello ÚNICO, la foto, el nombre y los
           precios como estadísticas (product.price viene en centavos: /100000 da los miles). Reemplaza a la tarjeta normal (style-redesign.scss, .sgns-dorada) #}
        {% set es_dorada = false %}
        {% for cat_d in product.categories %}{% if 'dorad' in cat_d.name | lower %}{% set es_dorada = true %}{% endif %}{% endfor %}
        {% if template == 'category' and category is defined and category.name is defined and 'dorad' in category.name | lower %}{% set es_dorada = true %}{% endif %}
        {# Con la etiqueta PRENDA DORADA o "(GOLD EDITION)" en el nombre ya sale dorada desde el servidor en cualquier página #}
        {% if dorada_srv %}{% set es_dorada = true %}{% endif %}
        {# Fuera de la categoría la carta va oculta (sgns-dorada--latente): static/js/prenda-dorada.js la activa si el
           producto está en Prenda dorada, porque en el inicio, la búsqueda y el Cyber Tiendanube no trae esa categoría.
           La carta de oro manda siempre, también sobre la tarjeta del Cyber #}
        {% if not reduced_item %}
            {% set dor_transf = settings.payment_discount_price and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
            {% set dor_cuotas = product.show_installments and product.get_max_installments(false) ? product.get_max_installments(false).installment : 1 %}
            <a class="sgns-dorada{% if not es_dorada %} sgns-dorada--latente{% endif %}" data-pid="{{ product.id }}" href="{{ product.url }}" title="{{ product.name }}" aria-label="{{ product.name }}">
                <span class="sgns-dorada__unico">ÚNICO</span>
                <span class="sgns-dorada__foto" style="background-image: url('{{ product.featured_image | product_image_url('large') }}');"></span>
                <span class="sgns-dorada__nombre">{{ product.name }}</span>
                <span class="sgns-dorada__stats">
                    <span><b>{{ (product.price / 100000) | round }}K</b> PRECIO</span>
                    {% if dor_transf > 0 %}<span><b>{{ (product.price * (100 - dor_transf) / 10000000) | round }}K</b> TRANSF</span>{% else %}<span><b>1/1</b> STOCK</span>{% endif %}
                    {% if dor_cuotas > 1 %}<span><b>{{ dor_cuotas }}</b> CUOTAS</span><span><b>{{ (product.price / dor_cuotas / 100000) | round }}K</b> C/U</span>{% endif %}
                    {% if dor_transf > 0 %}<span><b>1/1</b> STOCK</span>{% endif %}
                    <span><b>SGNS</b> STUDIO</span>
                </span>
            </a>
        {% endif %}
        {{ component('structured-data', {'item': true}) }}
    </div>
{% if slide_item %}
    </div>
{% endif %}