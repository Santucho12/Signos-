{# CYBER SGNS: portada armada con HTML y CSS (antes era una imagen y perdía calidad). Recrea el cartel de neón:
   fondo azul noche con cuadrícula, franjas de luz en dos esquinas, marco de circuito, CYBER en cian y SGNS en rosa,
   "Descuentos de hasta 70% OFF", etiquetas de descuento y destellos. Lo incluye snipplets/drop-hero.tpl.
   Las reglas de texto van con el id y !important porque el tema impone su tipografía a todo (style-redesign.scss, "aplica a absolutamente todo") #}
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;800&family=Exo+2:ital,wght@1,800;1,900&display=block" rel="stylesheet">
<style>
.sgns-cyber-portada { position: absolute; inset: 0; overflow: hidden; container-type: size; background: radial-gradient(60% 55% at 50% 48%, #221a20 0%, #141015 55%, #08060a 100%); }
.sgns-cyber-portada *, .sgns-cyber-portada *::before, .sgns-cyber-portada *::after { box-sizing: border-box; }
.sgns-cyber-portada__grilla { position: absolute; inset: 0; background-image: linear-gradient(rgba(230,0,0,.12) 1px, transparent 1px), linear-gradient(90deg, rgba(230,0,0,.12) 1px, transparent 1px); background-size: 4.6cqh 4.6cqh; background-position: center; }

/* Franjas de luz: bandas gruesas en diagonal que salen de la esquina de arriba a la izquierda y de la de abajo a la derecha */
.sgns-cyber-portada__franjas { position: absolute; width: 78cqh; height: 78cqh; pointer-events: none; }
.sgns-cyber-portada__franjas--arriba { left: 0; top: 0; }
.sgns-cyber-portada__franjas--abajo { right: 0; bottom: 0; transform: rotate(180deg); }
.sgns-cyber-portada__franjas i { position: absolute; left: -40cqh; width: 140cqh; transform-origin: center; transform: rotate(-45deg); border-radius: 0; }
.sgns-cyber-portada__franjas i:nth-child(1) { top: -10cqh; height: 4.6cqh; background: linear-gradient(90deg, #E60000, #E60000 45%, #ffe5e5); box-shadow: 0 0 26px rgba(230,0,0,.6); }
.sgns-cyber-portada__franjas i:nth-child(2) { top: -3cqh; height: 1.8cqh; background: #ffe5e5; box-shadow: 0 0 20px #ffe5e5; }
.sgns-cyber-portada__franjas i:nth-child(3) { top: 1cqh; height: 3.6cqh; background: linear-gradient(90deg, #E60000, #E60000); box-shadow: 0 0 22px #E60000; }
.sgns-cyber-portada__franjas i:nth-child(4) { top: 7cqh; height: .9cqh; background: #ffe5e5; box-shadow: 0 0 14px #ffe5e5; }
.sgns-cyber-portada__franjas i:nth-child(5) { top: 10cqh; height: 2cqh; background: #E60000; box-shadow: 0 0 18px #E60000; }
.sgns-cyber-portada__franjas i:nth-child(6) { top: 15cqh; height: .6cqh; background: #ffe5e5; box-shadow: 0 0 10px #ffe5e5; }

/* Bloque central: todas las medidas salen de --u */
.sgns-cyber-portada__centro { position: absolute; left: 50%; top: 57%; transform: translate(-50%, -50%); --u: min(.62cqw, 1.08cqh); width: calc(var(--u) * 60); text-align: center; }
.sgns-cyber-portada__marco { position: absolute; left: calc(var(--u) * -4); right: calc(var(--u) * -4); top: calc(var(--u) * -2.4); height: calc(var(--u) * 30.5); pointer-events: none; }
.sgns-cyber-portada__marco svg { width: 100%; height: 100%; overflow: visible; }
.sgns-cyber-portada__circuito { position: absolute; left: 36%; top: calc(var(--u) * -7.5); width: calc(var(--u) * 26); height: calc(var(--u) * 6); }
.sgns-cyber-portada__circuito--abajo { left: 42%; top: calc(var(--u) * 47.5); width: calc(var(--u) * 18); height: calc(var(--u) * 2); }
.sgns-cyber-portada__circuito svg { width: 100%; height: 100%; overflow: visible; }

#sgns-cyber-portada p.sgns-cyber-portada__palabra { position: relative; margin: 0 !important; padding: 0 !important; font-family: 'Orbitron', sans-serif !important; font-weight: 800 !important; font-style: normal !important; text-transform: uppercase !important; line-height: .98 !important; letter-spacing: .01em !important; font-size: calc(var(--u) * 13.6) !important; color: transparent !important; -webkit-text-fill-color: transparent !important; -webkit-text-stroke: calc(var(--u) * .8) var(--neon) !important; paint-order: stroke; filter: drop-shadow(calc(var(--u) * 1.1) calc(var(--u) * 1.1) 0 rgba(230,0,0,.55)) drop-shadow(0 0 calc(var(--u) * .35) var(--neon)) drop-shadow(0 0 calc(var(--u) * 1.4) var(--neon)) drop-shadow(0 0 calc(var(--u) * 3.2) var(--neon-suave)); text-shadow: none !important; }
#sgns-cyber-portada p.sgns-cyber-portada__palabra span, #sgns-cyber-portada p.sgns-cyber-portada__oferta small { font-family: inherit !important; font-weight: inherit !important; font-style: inherit !important; letter-spacing: inherit !important; text-transform: inherit !important; }
/* Centro claro del tubo */
#sgns-cyber-portada p.sgns-cyber-portada__palabra span { position: absolute; inset: 0; -webkit-text-stroke: calc(var(--u) * .2) var(--nucleo) !important; }
#sgns-cyber-portada p.sgns-cyber-portada__palabra--cyber { --neon: #E60000; --neon-suave: rgba(230,0,0,.55); --nucleo: #ffe5e5; }
#sgns-cyber-portada p.sgns-cyber-portada__palabra--sgns { --neon: #E60000; --neon-suave: rgba(230,0,0,.55); --nucleo: #ffe5e5; margin-top: calc(var(--u) * 1) !important; animation: sgnsCyberTubo 7s infinite; }
@keyframes sgnsCyberTubo { 0%, 40%, 43%, 46%, 100% { opacity: 1; } 41%, 45% { opacity: .4; } }
#sgns-cyber-portada p.sgns-cyber-portada__bajada { margin: calc(var(--u) * 2.2) 0 0 !important; padding: 0 !important; font-family: 'Exo 2', sans-serif !important; font-style: italic !important; font-weight: 900 !important; text-transform: uppercase !important; line-height: 1 !important; letter-spacing: .01em !important; font-size: calc(var(--u) * 4.1) !important; color: #ffe5e5 !important; -webkit-text-fill-color: #ffe5e5 !important; -webkit-text-stroke: 0 !important; text-shadow: 0 0 calc(var(--u) * 1.2) rgba(230,0,0,.65) !important; }
#sgns-cyber-portada p.sgns-cyber-portada__oferta { margin: calc(var(--u) * .3) 0 0 !important; padding: 0 !important; font-family: 'Exo 2', sans-serif !important; font-style: italic !important; font-weight: 900 !important; text-transform: uppercase !important; line-height: 1 !important; letter-spacing: 0 !important; font-size: calc(var(--u) * 11) !important; color: #ffe5e5 !important; -webkit-text-fill-color: #ffe5e5 !important; -webkit-text-stroke: 0 !important; text-shadow: 0 0 calc(var(--u) * 1.5) rgba(230,0,0,.8), 0 0 calc(var(--u) * 4) rgba(230,0,0,.4) !important; }
#sgns-cyber-portada p.sgns-cyber-portada__oferta small { font-size: .82em !important; margin-left: .18em; color: inherit !important; -webkit-text-fill-color: inherit !important; }

/* Etiquetas y destellos */
.sgns-cyber-portada__adorno { position: absolute; }
.sgns-cyber-portada__adorno svg { display: block; width: 100%; height: 100%; overflow: visible; }
.sgns-cyber-portada__etiqueta--1 { width: calc(var(--u) * 17); height: calc(var(--u) * 14); right: calc(var(--u) * -9); top: calc(var(--u) * -15); }
.sgns-cyber-portada__etiqueta--2 { width: calc(var(--u) * 17); height: calc(var(--u) * 14); left: calc(var(--u) * -17); top: calc(var(--u) * 31); }
.sgns-cyber-portada__destello { width: calc(var(--u) * 7); height: calc(var(--u) * 7); animation: sgnsCyberDestello 2.6s ease-in-out infinite; }
.sgns-cyber-portada__destello--1 { left: calc(var(--u) * -22); top: calc(var(--u) * 6); }
.sgns-cyber-portada__destello--2 { right: calc(var(--u) * -24); top: calc(var(--u) * 0); animation-delay: .9s; }
.sgns-cyber-portada__destello--3 { right: calc(var(--u) * -17); top: calc(var(--u) * 37); width: calc(var(--u) * 5.5); height: calc(var(--u) * 5.5); animation-delay: 1.7s; }
@keyframes sgnsCyberDestello { 0%, 100% { opacity: 1; transform: scale(1); } 50% { opacity: .5; transform: scale(.85); } }

/* Celular (pantalla vertical): el bloque ocupa casi todo el ancho y las franjas se achican */
@container (max-aspect-ratio: 4/5) {
  .sgns-cyber-portada__centro { --u: 1.45cqw; top: calc(50% - 55px); }
  .sgns-cyber-portada__franjas { width: 55cqw; height: 55cqw; }
  .sgns-cyber-portada__franjas i { left: -40cqw; width: 140cqw; }
  .sgns-cyber-portada__franjas i:nth-child(1) { top: -14cqw; height: 3.6cqw; }
  .sgns-cyber-portada__franjas i:nth-child(2) { top: -8cqw; height: 1.4cqw; }
  .sgns-cyber-portada__franjas i:nth-child(3) { top: -4cqw; height: 2.6cqw; }
  .sgns-cyber-portada__franjas i:nth-child(4) { top: 1cqw; height: .7cqw; }
  .sgns-cyber-portada__franjas i:nth-child(5) { top: 4cqw; height: 1.3cqw; }
  .sgns-cyber-portada__franjas i:nth-child(6) { top: 8cqw; height: .45cqw; }
  .sgns-cyber-portada__etiqueta--1 { right: calc(var(--u) * 0); top: calc(var(--u) * -22); }
  .sgns-cyber-portada__etiqueta--2 { left: calc(var(--u) * 0); top: calc(var(--u) * 46); }
  .sgns-cyber-portada__destello--1 { left: calc(var(--u) * 2); top: calc(var(--u) * -18); }
  .sgns-cyber-portada__destello--2 { right: calc(var(--u) * 18); top: calc(var(--u) * -26); }
  .sgns-cyber-portada__destello--3 { right: calc(var(--u) * 6); top: calc(var(--u) * 50); }
}

/* ENTRADA: todo aparece de a poco y escalonado. Mientras dura la intro (html.sgns-intro-on) queda en pausa en
   el primer cuadro y arranca cuando el velo se va. Orden: cuadrícula, franjas, marco, CYBER, SGNS, circuitos,
   "Descuentos de hasta", "70% OFF", etiquetas y destellos */
html.sgns-intro-on .sgns-cyber-portada, html.sgns-intro-on .sgns-cyber-portada * { animation-play-state: paused !important; }
.sgns-cyber-portada__grilla { animation: sgnsCpFundido 1.2s ease-out both; }
.sgns-cyber-portada__franjas i { animation: sgnsCpFranja 1.1s cubic-bezier(.2,.8,.2,1) both; }
.sgns-cyber-portada__franjas i:nth-child(1) { animation-delay: .15s; } .sgns-cyber-portada__franjas i:nth-child(2) { animation-delay: .25s; }
.sgns-cyber-portada__franjas i:nth-child(3) { animation-delay: .35s; } .sgns-cyber-portada__franjas i:nth-child(4) { animation-delay: .45s; }
.sgns-cyber-portada__franjas i:nth-child(5) { animation-delay: .55s; } .sgns-cyber-portada__franjas i:nth-child(6) { animation-delay: .65s; }
.sgns-cp-trazo { stroke-dasharray: 1; stroke-dashoffset: 1; animation: sgnsCpDibujo 1.1s cubic-bezier(.65,0,.35,1) both; }
.sgns-cp-trazo--1 { animation-delay: .5s; } .sgns-cp-trazo--2 { animation-delay: .65s; } .sgns-cp-trazo--3 { animation-delay: 1.6s; animation-duration: .8s; } .sgns-cp-trazo--4 { animation-delay: 2.3s; animation-duration: .7s; }
.sgns-cp-punto { animation: sgnsCpFundido .4s ease-out both; } .sgns-cp-punto--1 { animation-delay: 1.5s; } .sgns-cp-punto--2 { animation-delay: 2.25s; }
#sgns-cyber-portada p.sgns-cyber-portada__palabra--cyber { animation: sgnsCpEnciende 1s linear .9s both; }
#sgns-cyber-portada p.sgns-cyber-portada__palabra--sgns { animation: sgnsCpEnciende 1s linear 1.3s both, sgnsCyberTubo 7s 4s infinite; }
#sgns-cyber-portada p.sgns-cyber-portada__bajada { animation: sgnsCpSube .8s cubic-bezier(.2,.8,.2,1) 1.9s both; }
#sgns-cyber-portada p.sgns-cyber-portada__oferta { animation: sgnsCpAparece .9s cubic-bezier(.34,1.4,.64,1) 2.1s both; }
.sgns-cyber-portada__etiqueta--1, .sgns-cyber-portada__etiqueta--2 { animation: sgnsCpEtiqueta .8s cubic-bezier(.34,1.5,.64,1) both; }
.sgns-cyber-portada__etiqueta--1 { animation-delay: 2.4s; } .sgns-cyber-portada__etiqueta--2 { animation-delay: 2.55s; }
.sgns-cyber-portada__destello--1 { animation: sgnsCpAparece .6s ease-out 2.6s both, sgnsCyberDestello 2.6s ease-in-out 3.2s infinite; }
.sgns-cyber-portada__destello--2 { animation: sgnsCpAparece .6s ease-out 2.75s both, sgnsCyberDestello 2.6s ease-in-out 4.1s infinite; }
.sgns-cyber-portada__destello--3 { animation: sgnsCpAparece .6s ease-out 2.9s both, sgnsCyberDestello 2.6s ease-in-out 4.9s infinite; }
@keyframes sgnsCpFundido { from { opacity: 0; } to { opacity: 1; } }
@keyframes sgnsCpFranja { from { opacity: 0; translate: -18cqh -18cqh; } to { opacity: 1; translate: 0 0; } }
@keyframes sgnsCpDibujo { to { stroke-dashoffset: 0; } }
/* Tubo de neón que se prende: titila un par de veces y queda encendido */
@keyframes sgnsCpEnciende { 0% { opacity: 0; } 10% { opacity: .8; } 14% { opacity: .1; } 22% { opacity: .9; } 26% { opacity: .25; } 40% { opacity: 1; } 46% { opacity: .55; } 60%, 100% { opacity: 1; } }
@keyframes sgnsCpSube { from { opacity: 0; translate: 0 calc(var(--u) * 3); } to { opacity: 1; translate: 0 0; } }
@keyframes sgnsCpAparece { from { opacity: 0; scale: .7; } to { opacity: 1; scale: 1; } }
@keyframes sgnsCpEtiqueta { from { opacity: 0; scale: .4; rotate: -25deg; } to { opacity: 1; scale: 1; rotate: 0deg; } }
/* Con "reducir movimiento" (por ejemplo, animaciones desactivadas en Windows) la entrada suave se mantiene,
   pero sin titileos ni latidos: las letras aparecen con un fundido */
@media (prefers-reduced-motion: reduce) {
  #sgns-cyber-portada p.sgns-cyber-portada__palabra--cyber { animation: sgnsCpFundido 1s ease-out .9s both; }
  #sgns-cyber-portada p.sgns-cyber-portada__palabra--sgns { animation: sgnsCpFundido 1s ease-out 1.3s both; }
  .sgns-cyber-portada__destello--1 { animation: sgnsCpAparece .6s ease-out 2.6s both; }
  .sgns-cyber-portada__destello--2 { animation: sgnsCpAparece .6s ease-out 2.75s both; }
  .sgns-cyber-portada__destello--3 { animation: sgnsCpAparece .6s ease-out 2.9s both; }
}
</style>
<div class="sgns-cyber-portada" id="sgns-cyber-portada" role="img" aria-label="Cyber Sale: descuentos de hasta 70% off">
    <div class="sgns-cyber-portada__grilla"></div>
    <div class="sgns-cyber-portada__franjas sgns-cyber-portada__franjas--arriba"><i></i><i></i><i></i><i></i><i></i><i></i></div>
    <div class="sgns-cyber-portada__franjas sgns-cyber-portada__franjas--abajo"><i></i><i></i><i></i><i></i><i></i><i></i></div>
    <div class="sgns-cyber-portada__centro" aria-hidden="true">
        {# Marco: rosa del lado izquierdo y cian del derecho, con esquinas cortadas y aberturas arriba y abajo #}
        <div class="sgns-cyber-portada__marco"><svg viewBox="0 0 600 275" preserveAspectRatio="none" fill="none" stroke-width="5" stroke-linecap="round" stroke-linejoin="round">
            <path pathLength="1" class="sgns-cp-trazo sgns-cp-trazo--1" d="M210 4H32L6 30V245L32 271H150" stroke="#E60000" style="filter: drop-shadow(0 0 3px #E60000) drop-shadow(0 0 10px #E60000)"/>
            <path pathLength="1" class="sgns-cp-trazo sgns-cp-trazo--2" d="M400 4H568L594 30V245L568 271H300" stroke="#E60000" style="filter: drop-shadow(0 0 3px #E60000) drop-shadow(0 0 10px #E60000)"/>
        </svg></div>
        <span class="sgns-cyber-portada__circuito"><svg viewBox="0 0 260 60" fill="none" stroke="#E60000" stroke-width="5" stroke-linecap="round" style="filter: drop-shadow(0 0 3px #E60000) drop-shadow(0 0 8px #E60000)"><circle class="sgns-cp-punto sgns-cp-punto--1" cx="10" cy="10" r="8"/><path pathLength="1" class="sgns-cp-trazo sgns-cp-trazo--3" d="M18 10H200L222 32V56"/></svg></span>
        <span class="sgns-cyber-portada__circuito sgns-cyber-portada__circuito--abajo"><svg viewBox="0 0 180 20" fill="none" stroke="#E60000" stroke-width="5" stroke-linecap="round" style="filter: drop-shadow(0 0 3px #E60000) drop-shadow(0 0 8px #E60000)"><circle class="sgns-cp-punto sgns-cp-punto--2" cx="10" cy="10" r="8"/><path pathLength="1" class="sgns-cp-trazo sgns-cp-trazo--4" d="M18 10H162"/><circle class="sgns-cp-punto sgns-cp-punto--2" cx="170" cy="10" r="8"/></svg></span>
        <p class="sgns-cyber-portada__palabra sgns-cyber-portada__palabra--cyber">CYBER<span>CYBER</span></p>
        <p class="sgns-cyber-portada__palabra sgns-cyber-portada__palabra--sgns">SALE<span>SALE</span></p>
        <p class="sgns-cyber-portada__bajada">Descuentos de hasta</p>
        <p class="sgns-cyber-portada__oferta">70%<small>OFF</small></p>
        {# Etiqueta de precio con %, y rayitas de brillo #}
        <span class="sgns-cyber-portada__adorno sgns-cyber-portada__etiqueta--1"><svg viewBox="0 0 130 110" fill="none" stroke="#E60000" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" style="filter: drop-shadow(0 0 3px #E60000) drop-shadow(0 0 10px #E60000)"><g transform="rotate(-28 60 60)"><path d="M18 40h66l22 20-22 20H18a6 6 0 0 1-6-6V46a6 6 0 0 1 6-6Z"/><circle cx="86" cy="60" r="4"/><path d="M36 72l20-24"/><circle cx="37" cy="52" r="4"/><circle cx="55" cy="69" r="4"/></g><path d="M104 18l10-10M110 32l14-4M96 8l2-8" stroke="#E60000" style="filter: drop-shadow(0 0 6px #E60000)"/></svg></span>
        <span class="sgns-cyber-portada__adorno sgns-cyber-portada__etiqueta--2"><svg viewBox="0 0 130 110" fill="none" stroke="#E60000" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" style="filter: drop-shadow(0 0 3px #E60000) drop-shadow(0 0 10px #E60000)"><g transform="rotate(-28 60 60)"><path d="M18 40h66l22 20-22 20H18a6 6 0 0 1-6-6V46a6 6 0 0 1 6-6Z"/><circle cx="86" cy="60" r="4"/><path d="M36 72l20-24"/><circle cx="37" cy="52" r="4"/><circle cx="55" cy="69" r="4"/></g><path d="M100 96l12 8M88 104l4 12M108 84l14 0" stroke="#E60000" style="filter: drop-shadow(0 0 6px #E60000)"/></svg></span>
        <span class="sgns-cyber-portada__adorno sgns-cyber-portada__destello sgns-cyber-portada__destello--1"><svg viewBox="0 0 40 40" fill="none" stroke="#E60000" stroke-width="2.8" stroke-linecap="round" style="filter: drop-shadow(0 0 5px #E60000)"><path d="M20 2v11M20 27v11M2 20h11M27 20h11M7 7l6 6M27 27l6 6M33 7l-6 6M13 27l-6 6"/></svg></span>
        <span class="sgns-cyber-portada__adorno sgns-cyber-portada__destello sgns-cyber-portada__destello--2"><svg viewBox="0 0 40 40" fill="none" stroke="#E60000" stroke-width="2.8" stroke-linecap="round" style="filter: drop-shadow(0 0 5px #E60000)"><path d="M20 2v11M20 27v11M2 20h11M27 20h11M7 7l6 6M27 27l6 6M33 7l-6 6M13 27l-6 6"/></svg></span>
        <span class="sgns-cyber-portada__adorno sgns-cyber-portada__destello sgns-cyber-portada__destello--3"><svg viewBox="0 0 40 40" fill="none" stroke="#E60000" stroke-width="2.8" stroke-linecap="round" style="filter: drop-shadow(0 0 5px #E60000)"><path d="M20 2v11M20 27v11M2 20h11M27 20h11M7 7l6 6M27 27l6 6M33 7l-6 6M13 27l-6 6"/></svg></span>
    </div>
</div>
