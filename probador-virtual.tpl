{# Botón y contenido del Probador Virtual #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'probador-modal',
    modal_class: 'centered',
    modal_position: 'center',
    modal_transition: 'fade',
    modal_width: 'centered-md modal-md-width-500px',
    modal_body_class: 'probador-modal-compact',
    modal_header_title: false
} %}
    {% block modal_body %}
        <div class="probador-virtual-content position-relative p-4 p-md-5 text-center">
            
            {# STEP 1: Datos #}
            <div id="probador-step-1" class="probador-step active">
                <h2 class="h3 font-weight-bold mb-1" style="font-family: 'Blunt Semiconit', sans-serif; text-transform: uppercase; letter-spacing: 2px;">Probador Virtual</h2>
                <p class="text-muted mb-5 font-small">Calculá tu talle ideal en segundos</p>

                <div class="category-selection mb-5 d-flex justify-content-center">
                    <button type="button" class="js-probador-category btn rounded-pill" data-category="Pantalon/Short">Pantalon / Short</button>
                    <button type="button" class="js-probador-category btn active rounded-pill" data-category="Remera/Buzo">Remera / buzo / campera</button>
                </div>

                <div class="form-container-compact mx-auto" style="max-width: 320px;">
                    <div class="form-group mb-4">
                        <label class="d-block mb-2 font-weight-bold font-small text-uppercase">Altura</label>
                        <div class="input-group">
                            <input type="number" class="form-control text-center" placeholder="0" id="probador-altura">
                            <div class="input-group-append">
                                <span class="input-group-text">cm</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group mb-4">
                        <label class="d-block mb-2 font-weight-bold font-small text-uppercase">Peso</label>
                        <div class="input-group">
                            <input type="number" class="form-control text-center" placeholder="0" id="probador-peso">
                            <div class="input-group-append">
                                <span class="input-group-text">kg</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group mb-5">
                        <label class="d-block mb-2 font-weight-bold font-small text-uppercase">Edad</label>
                        <div class="input-group">
                            <input type="number" class="form-control text-center" placeholder="0" id="probador-edad">
                            <div class="input-group-append">
                                <span class="input-group-text">años</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4 pt-4 border-top">
                    <button type="button" class="btn btn-dark btn-block py-3 js-probador-next" style="border: none; font-weight: 900; letter-spacing: 2px; border-radius: 50px; background: #000;">CALCULAR</button>
                </div>
            </div>

            {# STEP 2: Resultado Final (Directo) #}
            <div id="probador-step-3" class="probador-step text-center py-4" style="display: none;">
                <h2 class="h4 font-weight-bold mb-1" style="font-family: 'Blunt Semiconit', sans-serif; text-transform: uppercase;">¡Talle Recomendado!</h2>
                <div class="py-5">
                    <div id="probador-resultado-talle" class="display-2 font-weight-bold text-dark mb-3" style="font-family: 'Blunt Semiconit', sans-serif;">L</div>
                    <p id="probador-resultado-texto" class="text-muted px-4">Según tus datos, el talle L es el ajuste perfecto para este producto.</p>
                </div>
                <button type="button" class="btn btn-outline-dark px-5 py-3 js-modal-close rounded-pill" style="font-weight: 800; font-size: 11px; letter-spacing: 1px;">SELECCIONAR Y CERRAR</button>
            </div>

        </div>
    {% endblock %}
{% endembed %}
