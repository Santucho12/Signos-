{# Punto de entrada para el nuevo diseño #}

<div class="new-design-container">
    <header id="new-header">
        <div style="padding: 40px; background: #eee; text-align: center;">
            <h2 style="margin:0;">[Nuevo Header]</h2>
            <p>Empezá a construir tu nuevo diseño acá.</p>
        </div>
    </header>

    <main id="new-content" style="padding: 60px 20px; text-align: center;">
        <h3>Bienvenido al modo Preview</h3>
        <p>Este contenido solo es visible para vos.</p>
        
        <div style="margin-top: 40px;">
            <a href="?preview=false" style="color: #ff0055; text-decoration: underline;">Volver al diseño original</a>
        </div>
    </main>

    <footer id="new-footer" style="padding: 40px; background: #333; color: white; text-align: center;">
        <p>&copy; {{ "now" | date('Y') }} - {{ store.name }} [Nuevo Footer]</p>
    </footer>
</div>
