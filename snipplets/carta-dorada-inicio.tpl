{# Carta de oro de PRENDA DORADA en los carruseles del inicio (templates/home.tpl, Novedades y Ofertas): la misma de
   snipplets/grid/item.tpl (style-redesign.scss, .sgns-dorada), con la clase nov-card para que ocupe el lugar de una
   tarjeta en el carrusel. product.price viene en centavos: /100000 da los miles #}
{% set dor_transf = settings.payment_discount_price and product.maxPaymentDiscount and product.maxPaymentDiscount.value > 0 ? product.maxPaymentDiscount.value : 0 %}
{% set dor_cuotas = product.show_installments and product.get_max_installments(false) ? product.get_max_installments(false).installment : 1 %}
<a class="nov-card sgns-dorada" data-pid="{{ product.id }}" href="{{ product.url }}" title="{{ product.name }}" aria-label="{{ product.name }}" data-redesign-animate="fadeUp" data-redesign-delay="{{ nov_delay }}">
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
