// Bloque de combo (app huapps) en la página de producto: título con el ahorro, color sin repetir y total dentro del botón.
(function () {
  function plata(n) {
    return '$' + Math.round(n).toLocaleString('es-AR');
  }

  function armar(grupo) {
    var productos = grupo.querySelector('.huapps-kit-group-products');
    if (!productos) return;

    var cabecera = grupo.querySelector('.sgns-combo-cabecera');
    if (!cabecera) {
      cabecera = document.createElement('div');
      cabecera.className = 'sgns-combo-cabecera';
      cabecera.innerHTML = '<span class="sgns-combo-titulo">Llevá el look completo</span><span class="sgns-combo-ahorro"></span>';
      productos.parentNode.insertBefore(cabecera, productos);
    }

    // "BUZO JOIN NEGRO (NEGRO)" -> nombre sin el color y el color abajo, sin paréntesis
    grupo.querySelectorAll('.huapps-kit-group-item-name a').forEach(function (a) {
      var variante = a.querySelector('.js-huapps-buy-together-item-name-variant');
      // La app reescribe el texto al elegir talle, ej. "(40, CHOCOLATE)": dejar solo el color
      if (!variante || variante.textContent.indexOf('(') === -1) return;
      var partes = variante.textContent.replace(/[()]/g, '').split(',');
      var color = partes[partes.length - 1].trim();
      a.childNodes.forEach(function (nodo) {
        if (nodo.nodeType === 3 && color) {
          var limpio = nodo.nodeValue.replace(new RegExp('\\s+' + color + '\\s*$', 'i'), ' ');
          if (limpio.trim()) nodo.nodeValue = limpio;
        }
      });
      variante.textContent = color;
    });

    var antes = 0, ahora = 0;
    grupo.querySelectorAll('.js-huapps-buy-together-get-product.is-checked').forEach(function (p) {
      var de = p.querySelector('.js-huapps-buy-together-item-get-prices-de');
      var por = p.querySelector('.js-huapps-buy-together-item-get-prices-por');
      var precio = por ? parseFloat(por.dataset.price) || 0 : 0;
      ahora += precio;
      antes += de ? parseFloat(de.dataset.price) || precio : precio;
    });

    var ahorro = cabecera.querySelector('.sgns-combo-ahorro');
    // Solo escribir si cambia: el MutationObserver de abajo vuelve a llamar a armar() con cada cambio
    var texto = antes > ahora ? 'Ahorrás ' + plata(antes - ahora) : '';
    if (ahorro.textContent !== texto) ahorro.textContent = texto;
    if (ahorro.hidden !== !texto) ahorro.hidden = !texto;

    var form = grupo.closest('form') || document;
    var boton = form.querySelector('.js-huapps-buy-together-add-all-to-cart');
    if (boton && ahora) {
      if (boton.getAttribute('data-total') !== plata(ahora)) boton.setAttribute('data-total', plata(ahora));
      if (!boton.classList.contains('sgns-combo-cta')) boton.classList.add('sgns-combo-cta');
      // El botón vive fuera del recuadro, abajo del probador: se mueve adentro para verlo sin scrollear
      if (boton.parentNode !== grupo) grupo.appendChild(boton);
    }
  }

  function iniciar() {
    // Si la app de combos no aparece en 10 s, mostrar el formulario normal del producto
    setTimeout(function () {
      document.querySelectorAll('.js-product-form.sgns-es-kit').forEach(function (form) {
        if (!form.querySelector('.js-huapps-buy-together-kit-content')) form.classList.add('sgns-kit-sin-app');
      });
    }, 10000);

    var pendiente = false;
    function revisar() {
      if (pendiente) return;
      pendiente = true;
      requestAnimationFrame(function () {
        pendiente = false;
        document.querySelectorAll('.js-huapps-buy-together-kit-content').forEach(armar);
      });
    }
    revisar();
    new MutationObserver(revisar).observe(document.body, { childList: true, subtree: true, attributes: true, attributeFilter: ['class'] });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar);
  else iniciar();
})();
