// La app de combos inyecta textos en portugués; los pasamos a español.
(function () {
  var textos = {
    'adicionar tudo': 'Agregar todo'
  };

  function traducir(raiz) {
    var walker = document.createTreeWalker(raiz, NodeFilter.SHOW_TEXT);
    var nodo;
    while ((nodo = walker.nextNode())) {
      var clave = nodo.nodeValue.trim().toLowerCase();
      if (textos[clave]) nodo.nodeValue = nodo.nodeValue.replace(nodo.nodeValue.trim(), textos[clave]);
    }
    raiz.querySelectorAll && raiz.querySelectorAll('input[type="submit"], input[type="button"]').forEach(function (el) {
      var clave = (el.value || '').trim().toLowerCase();
      if (textos[clave]) el.value = textos[clave];
    });
  }

  function iniciar() {
    traducir(document.body);
    new MutationObserver(function (cambios) {
      cambios.forEach(function (c) {
        c.addedNodes.forEach(function (n) {
          if (n.nodeType === 1) traducir(n);
          else if (n.nodeType === 3 && n.parentNode) traducir(n.parentNode);
        });
        if (c.type === 'characterData' && c.target.parentNode) traducir(c.target.parentNode);
      });
    }).observe(document.body, { childList: true, subtree: true, characterData: true });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', iniciar);
  else iniciar();
})();
