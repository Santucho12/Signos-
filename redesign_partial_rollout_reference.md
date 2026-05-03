# Guía de Referencia: Rollout Parcial del Rediseño (SGNS Studio)

Este documento detalla la implementación realizada para activar el rediseño de forma parcial: habilitando los componentes globales (carrito, productos, footer) para todos los clientes, pero manteniendo la Home original como predeterminada.

## 1. Estrategia de Clases CSS
Se utilizan dos clases en el elemento `<html>` para controlar el estado:

- `.redesign-active`: Activa el framework global (fuentes, variables, header interno, footer, carrito). **Habilitada para todos.**
- `.redesign-preview`: Activa específicamente la **Home nueva** y elementos de depuración (badge). **Habilitada solo bajo condición (link secreto/cookie).**

## 2. Cambios en `layouts/layout.tpl`

### Detección y Aplicación de Clases (Head)
Se modificó el script de detección para separar la activación del framework de la previsualización de la Home:

```javascript
var isPreview = false;
var urlParam = new URLSearchParams(window.location.search).get('redesign');

// Detección de Modo Preview (Home nueva + Badge)
if (urlParam === 'mi_redesign_2026') {
    document.cookie = 'redesign_preview=1;path=/;SameSite=Lax';
    isPreview = true;
} else if (urlParam === 'off') {
    document.cookie = 'redesign_preview=;path=/;expires=Thu, 01 Jan 1970 00:00:00 GMT';
    isPreview = false;
} else if (document.cookie.indexOf('redesign_preview=1') !== -1 || params.preview) {
    isPreview = true;
}

// Aplicación Universal del Rediseño
document.documentElement.classList.add('redesign-active');

// Aplicación Condicional de la Home Nueva
if (isPreview) {
    document.documentElement.classList.add('redesign-preview');
}
```

### Gestión de Scripts y UI (Footer)
- El archivo `redesign.js` se carga para todos (maneja animaciones de productos).
- El **badge de preview** y el **noindex** se envuelven en un condicional `if (isPreview)`.

## 3. Cambios en `templates/home.tpl`

Se actualizó el estilo inline de seguridad para usar la clase de preview:

```html
<style>
    .redesign-home-content { display: none !important; }
    .redesign-preview .redesign-home-content { display: block !important; }
</style>
```

## 4. Lógica de CSS en `style-redesign.scss`

Para que este sistema funcione, las reglas deben estar estructuradas así:

- **Componentes Globales**: `.redesign-active .mi-componente { ... }`
- **Home Nueva**: `.redesign-preview .redesign-home-content { ... }`
- **Home Vieja**: `.redesign-preview .original-home-content { display: none; }`
- **Header Home (Transparente)**: `.redesign-preview .template-home .head-main { ... }`
- **Header Home (Sólido/Backup)**: `.redesign-active:not(.redesign-preview) .template-home .head-main { ... }`
