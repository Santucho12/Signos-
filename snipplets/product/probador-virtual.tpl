{# Botón y contenido del Probador Virtual (Embedded iframe) #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'probador-modal',
    modal_class: 'centered',
    modal_position: 'center',
    modal_transition: 'fade',
    modal_width: 'centered-md modal-md-width-500px',
    modal_body_class: 'p-0',
    modal_header_title: false
} %}
    {% block modal_body %}
        <div class="probador-iframe-container" style="position: relative; overflow: hidden; width: 100%; height: 800px; border-radius: 20px;">
            <div class="js-iframe-loader" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: #fff; display: flex; align-items: center; justify-content: center; z-index: 10;">
                <div class="text-center">
                    <div class="spinner-border text-dark mb-3" role="status"></div>
                    <p class="font-small text-uppercase font-weight-bold" style="letter-spacing: 2px;">Abriendo Probador Virtual...</p>
                </div>
            </div>
            <iframe 
                src="https://perfect-fit-app.vercel.app/" 
                style="width: 100%; height: 100%; border: none;"
                onload="this.previousElementSibling.style.display='none';"
                allow="camera;microphone"
            ></iframe>
        </div>
    {% endblock %}
{% endembed %}
