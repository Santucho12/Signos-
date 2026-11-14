<ul class="search-suggest-list">
    {% set search_suggestions = products | take(6) %}
    {% for product in search_suggestions %}
        <li class="search-suggest-item container-fluid">
            <a href="{{ product.url }}" class="search-suggest-link row justify-content-md-center m-0">
                <div class="search-suggest-image-container col-xs-auto">
                    {{ product.featured_image | product_image_url("tiny") | img_tag(product.featured_image.alt, {class: 'search-suggest-image'}) }}
                </div>
                <div class="search-suggest-text col">
                	<p class="search-suggest-name">
                		{{ product.name | highlight(query) }}
                	</p>
                    {% if product.display_price %}
                        {% set transfer_pct = settings.payment_discount_price and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
                        {# Mismo bloque de precio que las cards: anterior tachado, precio, barra de cuotas y transferencia #}
                        {% set max_free = product.show_installments and settings.product_installments and product.get_max_installments(false) ? product.get_max_installments(false).installment : 1 %}
                        <div class="sgns-precio sgns-precio--chico">
                            {% if product.compare_at_price and product.compare_at_price > product.price %}
                                <s class="sgns-precio__antes">{{ product.compare_at_price | round | money }}</s>
                            {% endif %}
                            <div class="sgns-precio__actual">{{ product.price | round | money }}</div>
                            {% if max_free > 1 %}
                                <div class="sgns-precio__cuotas"><b>{{ max_free }} cuotas sin interés</b> de {{ (product.price / max_free) | round | money }}</div>
                            {% endif %}
                            {% if transfer_pct > 0 %}
                                <div class="sgns-precio__transf">{{ (product.price * (100 - transfer_pct) / 100) | round | money }} con transferencia</div>
                            {% endif %}
                        </div>
                    {% endif %}
                </div>
            </a>
        </li>
    {% endfor %}
    <div class="text-center mt-3">
        <a href="#" class="js-search-suggest-all-link btn btn-secondary d-inline-block">{{ 'Ver todos los resultados' | translate }}</a>
    </div>
</ul>
