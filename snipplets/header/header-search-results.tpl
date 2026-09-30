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
                        {# Precios como en la card: un solo tachado, el precio que se
                           cobra en negro y la transferencia en una línea roja debajo. #}
                        {% set transfer_pct = settings.payment_discount_price and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
                    	<p class="search-suggest-price">
                            {% if product.compare_at_price and product.compare_at_price > product.price %}
                                <span class="search-suggest-compare">{{ product.compare_at_price | round | money }}</span>
                            {% endif %}
                            <span class="search-suggest-now">{{ product.price | round | money }}</span>
                    	</p>

                        {% if transfer_pct > 0 %}
                            <p class="search-suggest-transfer">
                                Transferencia: <b>{{ (product.price * (100 - transfer_pct) / 100) | round | money }}</b>
                            </p>
                        {% endif %}

                        {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.product_installments %}
                        {% if product_can_show_installments %}
                            {% set max_installments_without_interests = product.get_max_installments(false) %}
                            {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                                <p class="search-suggest-installments">
                                    <b>{{ max_installments_without_interests.installment }}</b> cuotas sin interés de <b>{{ (product.price / max_installments_without_interests.installment) | round | money }}</b>
                                </p>
                            {% endif %}
                        {% endif %}
                    {% endif %}
                </div>
            </a>
        </li>
    {% endfor %}
    <div class="text-center mt-3">
        <a href="#" class="js-search-suggest-all-link btn btn-secondary d-inline-block">{{ 'Ver todos los resultados' | translate }}</a>
    </div>
</ul>
