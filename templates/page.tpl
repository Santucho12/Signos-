{% if page.handle != 'registroevento' and page.handle != 'registro-evento' and page.handle != 'evento' and page.handle != 'registroeventoparticipantes' and page.handle != 'registro-evento-participantes' %}
{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}
{% endif %}

{# Institutional page  #}

{% if page.handle == 'sobre-nosotros' %}

<style>
    /* Ocultar encabezado estándar solo en esta página para el look premium */
    .page-header { display: none !important; }

    .sobre-nosotros-video-wrapper {
        position: relative;
        border-radius: 24px;
        overflow: hidden;
        box-shadow: 0 30px 60px rgba(0,0,0,0.12);
        background: transparent; /* Quitamos el fondo negro para que se vea el poster */
        height: 700px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }
    .redesign-play-central {
        position: absolute;
        width: 60px;
        height: 60px;
        background: rgba(255, 255, 255, 0.4); /* Más opaco para que se vea bien */
        backdrop-filter: blur(10px);
        border: 2px solid rgba(255, 255, 255, 0.6);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        z-index: 20;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        box-shadow: 0 0 30px rgba(0,0,0,0.3);
    }
    .redesign-play-central svg {
        width: 24px;
        height: 24px;
        margin-left: 3px;
        fill: #fff; /* Aseguramos que el icono sea blanco */
    }
    .redesign-play-central:hover {
        transform: scale(1.1);
        background: rgba(255, 255, 255, 0.6);
        border-color: #fff;
    }
    .video-is-playing .redesign-play-central {
        opacity: 0;
        visibility: hidden;
        transform: scale(0.5);
    }
    .redesign-unmute-btn {
        position: absolute;
        bottom: 20px;
        right: 20px;
        background: rgba(0, 0, 0, 0.5); /* Fondo oscuro para que resalte sobre el poster */
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        padding: 10px 20px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: bold;
        letter-spacing: 1px;
        cursor: pointer;
        z-index: 10;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        color: #fff;
    }
    .redesign-unmute-btn:hover {
        background: rgba(0, 0, 0, 0.7);
        transform: scale(1.05);
    }
    .redesign-unmute-btn svg {
        width: 16px;
        height: 16px;
    }
    .sobre-nosotros-video-wrapper video {
        width: 100%;
        height: 100%;
        display: block;
        object-fit: cover;
        background-size: cover;
    }
    .sobre-nosotros-title {
        font-family: 'Blunt Semiconit', sans-serif !important;
        font-size: 48px;
        letter-spacing: -1px;
        margin-bottom: 0;
        color: #000;
        text-transform: uppercase !important;
        display: block !important; /* Forzamos visualización */
    }
    @media (max-width: 767px) {
        .sobre-nosotros-title { font-size: 42px; }
        .redesign-unmute-btn { bottom: 10px; right: 10px; padding: 8px 15px; font-size: 10px; }
        .sobre-nosotros-video-wrapper { height: auto; min-height: 300px; }
        .sobre-nosotros-video-wrapper video { height: auto; }
    }
</style>

<section class="sobre-nosotros-produccion" style="padding: 80px 0;">
    <div class="container">
        <div class="row mb-5">
            <div class="col-12 text-center">
                <h1 class="sobre-nosotros-title">SOBRE NOSOTROS</h1>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-6">
                <div id="video-wrapper" class="sobre-nosotros-video-wrapper">
                    <video id="sobre-nosotros-video" loop playsinline poster="{{ 'sobre-nosotros.png' | static_url }}">
                        <source src="{{ 'sobre-nosotros.mp4' | static_url }}" type="video/mp4">
                    </video>

                    <div id="play-central" class="redesign-play-central">
                        <svg viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
                    </div>
                    
                    <button id="unmute-btn" class="redesign-unmute-btn" style="opacity:0; pointer-events:none;">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M11 5L6 9H2v6h4l5 4V5zM15.54 8.46a5 5 0 0 1 0 7.07M19.07 4.93a10 10 0 0 1 0 14.14"/>
                        </svg>
                        SILENCIAR
                    </button>
                </div>

                <script>
                    (function() {
                        var video = document.getElementById('sobre-nosotros-video');
                        var wrapper = document.getElementById('video-wrapper');
                        var btn = document.getElementById('unmute-btn');
                        
                        function handleInteraction(e) {
                            e.stopPropagation();
                            if (video.paused) {
                                video.muted = false;
                                video.play();
                                wrapper.classList.add('video-is-playing');
                                btn.style.opacity = "1";
                                btn.style.pointerEvents = "auto";
                            } else {
                                if (video.muted) {
                                    video.muted = false;
                                    btn.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5zM15.54 8.46a5 5 0 0 1 0 7.07M19.07 4.93a10 10 0 0 1 0 14.14"/></svg> SILENCIAR';
                                } else {
                                    video.muted = true;
                                    btn.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5zM15.54 8.46a5 5 0 0 1 0 7.07M19.07 4.93a10 10 0 0 1 0 14.14"/></svg> ACTIVAR SONIDO';
                                }
                            }
                        }

                        if (video && wrapper) {
                            wrapper.addEventListener('click', handleInteraction);
                        }

                        function customSmoothScroll(distance, duration) {
                            var start = window.pageYOffset;
                            var startTime = 'now' in window.performance ? performance.now() : new Date().getTime();
                            function scroll() {
                                var now = 'now' in window.performance ? performance.now() : new Date().getTime();
                                var time = Math.min(1, ((now - startTime) / duration));
                                var timeFunction = time * (2 - time);
                                window.scrollTo(0, Math.ceil((timeFunction * distance) + start));
                                if (time < 1) { requestAnimationFrame(scroll); }
                            }
                            requestAnimationFrame(scroll);
                        }

                        window.addEventListener('load', function() {
                            setTimeout(function() {
                                if (window.pageYOffset === 0) {
                                    var scrollDistance = window.innerWidth > 767 ? 300 : 310;
                                    customSmoothScroll(scrollDistance, 1500);
                                }
                            }, 800);
                        });
                    })();
                </script>
            </div>
        </div>
    </div>
</section>

{% elseif page.handle == 'registroevento' or page.handle == 'registro-evento' or page.handle == 'evento' %}

    {% include "snipplets/registro-evento.tpl" %}

{% elseif page.handle == 'registroeventoparticipantes' or page.handle == 'registro-evento-participantes' %}

    {% include "snipplets/registro-evento-participantes.tpl" %}

{% else %}

{# Otras paginas institucionales #}
<section class="user-content pb-5">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-8">
                {{ page.content }}
            </div>
        </div>
    </div>
</section>

{% endif %}
