<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="totalCarrito" value="0"/>
<c:forEach var="item" items="${sessionScope.carrito}">
    <c:set var="totalCarrito" value="${totalCarrito + item.value.cantidad}"/>
</c:forEach>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú - Papasaurios</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <script src="${ctx}/Vista/JavaScript/validarReg.js"></script>
    <style>
        /* Aviso flotante al agregar algo al carrito, sin recargar la página */
        #toastCarrito {
            position: fixed; top: 90px; left: 50%; transform: translateX(-50%) translateY(-20px);
            z-index: 999; opacity: 0; pointer-events: none; transition: opacity .25s ease, transform .25s ease;
            max-width: 90vw;
        }
        #toastCarrito.mostrar { opacity: 1; transform: translateX(-50%) translateY(0); pointer-events: auto; }
        .btn-agregar-carrito.agregado { background: var(--verde); }
    </style>
    <script src="${ctx}/Vista/JavaScript/navActivo.js"></script>
</head>
<body>

<div id="toastCarrito"></div>

<!-- NAVBAR -->
<nav class="navbar scrolled" id="navbar">
    <div class="navbar-inner">
        <ul class="nav-links nav-left">
            <li><a href="${ctx}/index.jsp">Inicio</a></li>
            <li><a href="${ctx}/Vista/Historia.jsp">Nuestra historia</a></li>
        </ul>
        <a href="${ctx}/index.jsp" class="nav-logo">
            <img src="${ctx}/Vista/Imagenes/loguito.png" alt="Logo">
            <span>Papasaurios</span>
        </a>
        <ul class="nav-links nav-right">
            <li><a href="${ctx}/Vista/Carrito.jsp" class="nav-btn"><i class="ti ti-shopping-cart"></i> Mi carrito</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.nombreUsuario}">
                    <li><a href="${ctx}/PanelUsuario">Mis pedidos</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${ctx}/Vista/InicioSesion.jsp">Ingresar</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
        <button class="hamburger" id="hamburger" aria-label="Menú"><span></span><span></span><span></span></button>
    </div>
    <div class="mobile-menu" id="mobileMenu">
        <a href="${ctx}/index.jsp">Inicio</a>
        <a href="${ctx}/Vista/Historia.jsp">Nuestra historia</a>
        <a href="${ctx}/Vista/Carrito.jsp">Mi carrito</a>
        <c:if test="${not empty sessionScope.nombreUsuario}"><a href="${ctx}/PanelUsuario">Mis pedidos</a></c:if>
        <c:if test="${empty sessionScope.nombreUsuario}"><a href="${ctx}/Vista/InicioSesion.jsp">Ingresar</a></c:if>
    </div>
</nav>

<section class="menu-hero">
    <h1>Nuestro menú</h1>
    <p>Elige tu categoría, arma tu pedido y agrégalo al carrito</p>
</section>

<c:if test="${not empty sessionScope.mensajeCarrito}">
    <div class="alert alert-ok menu-alert"><i class="ti ti-circle-check"></i> ${sessionScope.mensajeCarrito} <a href="${ctx}/Vista/Carrito.jsp">Ver carrito</a></div>
    <c:remove var="mensajeCarrito" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.errorCarrito}">
    <div class="alert alert-err menu-alert"><i class="ti ti-alert-circle"></i> ${sessionScope.errorCarrito}</div>
    <c:remove var="errorCarrito" scope="session"/>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-err menu-alert"><i class="ti ti-alert-circle"></i> ${error}</div>
</c:if>

<div class="menu-layout">

    <!-- Pestañas de categorías (sticky) -->
    <nav class="menu-tabs" id="menuTabs">
        <c:forEach var="entry" items="${menuPorCategoria}" varStatus="st">
            <c:if test="${not empty entry.value}">
                <button class="menu-tab ${st.first ? 'active' : ''}" data-target="panel-${entry.key.idCategoria}" type="button">
                    ${entry.key.nombre_categoria}
                </button>
            </c:if>
        </c:forEach>
    </nav>

    <!-- Paneles de cada categoría -->
    <div class="menu-panels">
        <c:forEach var="entry" items="${menuPorCategoria}" varStatus="st">
            <c:if test="${not empty entry.value}">
                <div class="menu-panel ${st.first ? 'active' : ''}" id="panel-${entry.key.idCategoria}">
                    <div class="menu-panel-header">
                        <h2>${entry.key.nombre_categoria}</h2>
                        <span class="menu-panel-count">${fn:length(entry.value)} productos</span>
                    </div>

                    <div class="menu-productos-list">
                        <c:forEach var="p" items="${entry.value}">
                            <article class="producto-card">
                                <div class="producto-card-img">
                                    <c:choose>
                                        <c:when test="${not empty p.imagen_url}">
                                            <c:choose>
                                                <c:when test="${fn:startsWith(p.imagen_url, 'http')}">
                                                    <img src="${p.imagen_url}" alt="${p.nombre_producto}" loading="lazy">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctx}${p.imagen_url}" alt="${p.nombre_producto}" loading="lazy">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="producto-card-placeholder">🦖</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="producto-card-body">
                                    <h3>${p.nombre_producto}</h3>
                                    <c:if test="${not empty p.descripcion_producto}">
                                        <p class="producto-desc">${p.descripcion_producto}</p>
                                    </c:if>

                                    <form action="${ctx}/Carrito" method="post" class="producto-card-form">
                                        <input type="hidden" name="accion" value="agregar">
                                        <input type="hidden" name="idProducto" value="${p.idProducto}">
                                        <input type="hidden" name="redirect" value="/Vista/Menu.jsp">

                                        <c:set var="variantes" value="${variantesPorProducto[p.idProducto]}"/>
                                        <c:choose>
                                            <c:when test="${not empty variantes}">
                                                <select name="idVariante" class="producto-select-variante" required>
                                                    <c:forEach var="v" items="${variantes}">
                                                        <option value="${v.idVariante}">${v.nombre_variante} — $${v.precio_variante}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="producto-precio">$${p.precio_base}</div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="producto-card-footer">
                                            <div class="producto-stepper">
                                                <button type="button" class="stepper-btn" onclick="step(this,-1)">−</button>
                                                <input type="number" name="cantidad" value="1" min="1" max="20" class="producto-cantidad" readonly>
                                                <button type="button" class="stepper-btn" onclick="step(this,1)">+</button>
                                            </div>
                                            <button type="submit" class="btn-agregar-carrito"><i class="ti ti-shopping-cart-plus"></i></button>
                                        </div>
                                    </form>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<a href="${ctx}/Vista/Carrito.jsp" class="carrito-flotante">
    <i class="ti ti-shopping-cart"></i>
    <c:if test="${totalCarrito > 0}">
        <span class="carrito-flotante-badge" id="carritoBadge">${totalCarrito}</span>
    </c:if>
</a>

<!-- ===== MODAL "DEBES INICIAR SESIÓN" (al intentar agregar al carrito) ===== -->
<div class="overlay-login" id="overlayLogin">
    <div class="modal-login">
        <button type="button" class="modal-login-cerrar" onclick="ocultarModalLogin()" aria-label="Cerrar">✕</button>
        <div class="modal-login-icono"><i class="ti ti-lock"></i></div>
        <h3>Inicia sesión</h3>
        <p data-texto-login>Necesitas una cuenta para agregar productos al carrito. Inicia sesión o crea una cuenta en segundos.</p>
        <div class="modal-login-botones">
            <a href="${ctx}/Vista/InicioSesion.jsp" class="btn-login">Iniciar sesión</a>
            <a href="${ctx}/CargarRegistro" class="btn-login btn-secundario">Crear cuenta</a>
        </div>
        <button type="button" class="modal-login-cancelar" onclick="ocultarModalLogin()">Ahora no</button>
    </div>
</div>

<footer class="footer">
    <div class="footer-contenedor">
        <div class="footer-info">
            <h3>Papasaurios - Salchipapería</h3>
            <p>Dirección: DG 34 #13A-40, Soacha</p>
            <p>Teléfono: +57 314 300 7413</p>
            <p>Email: contacto@papasaurios.com</p>
        </div>
        <div class="logo-footer">
            <img src="${ctx}/Vista/Imagenes/loguito.png" alt="Logo Papasaurios">
        </div>
        <div class="footer-redes">
            <h3>Síguenos</h3>
            <a href="https://www.instagram.com/papasaurios_soacha/" target="_blank">Instagram</a> |
            <a href="https://wa.me/573143007413" target="_blank">WhatsApp</a>
        </div>
    </div>
    <div class="footer-copy"><p>&copy; 2026 Papasaurios. Todos los derechos reservados.</p> <a href="${ctx}/Vista/PoliticaDatos.jsp">Política de datos y términos</a></div>
</footer>

<script>
const ctxJs = "${ctx}";
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
hamburger.addEventListener('click', () => { hamburger.classList.toggle('active'); mobileMenu.classList.toggle('open'); });

// Tabs del menú: sin recargar la página, solo muestra/oculta paneles.
document.querySelectorAll('.menu-tab').forEach(tab => {
    tab.addEventListener('click', () => {
        document.querySelectorAll('.menu-tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.menu-panel').forEach(p => p.classList.remove('active'));
        tab.classList.add('active');
        document.getElementById(tab.dataset.target).classList.add('active');
        document.querySelector('.menu-panels').scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
});

// Stepper de cantidad +/-
function step(btn, delta) {
    const input = btn.parentElement.querySelector('.producto-cantidad');
    let val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    if (val > 20) val = 20;
    input.value = val;
}

// Agregar al carrito sin recargar la página. Antes cada clic mandaba a
// Carrito.jsp y volvía, reiniciando la pestaña activa a la primera
// categoría — molesto si querías seguir agregando cosas de otras
// secciones. Ahora se queda exactamente donde estabas.
let toastTimeout;
function mostrarToast(mensaje, tipo) {
    const toast = document.getElementById('toastCarrito');
    toast.innerHTML = '<div class="alert ' + (tipo === 'error' ? 'alert-err' : 'alert-ok') + '">'
        + '<i class="ti ti-' + (tipo === 'error' ? 'alert-circle' : 'circle-check') + '"></i> ' + mensaje + '</div>';
    toast.classList.add('mostrar');
    clearTimeout(toastTimeout);
    toastTimeout = setTimeout(() => toast.classList.remove('mostrar'), 2200);
}

document.querySelectorAll('.producto-card-form').forEach(form => {
    form.addEventListener('submit', function (e) {
        e.preventDefault();
        const boton = form.querySelector('.btn-agregar-carrito');
        const datos = new URLSearchParams(new FormData(form));

        fetch(ctxJs + '/Carrito', {
            method: 'POST',
            headers: { 'X-Requested-With': 'XMLHttpRequest' },
            body: datos
        })
        .then(r => r.json())
        .then(data => {
            if (!data.ok) {
                if (data.requiereLogin) {
                    mostrarModalLogin('Necesitas una cuenta para agregar productos al carrito. Inicia sesión o crea una cuenta en segundos.');
                } else {
                    mostrarToast(data.error || 'No se pudo agregar el producto.', 'error');
                }
                return;
            }
            // Feedback visual en el propio botón: un check que dura un instante.
            boton.classList.add('agregado');
            const iconoOriginal = boton.innerHTML;
            boton.innerHTML = '<i class="ti ti-check"></i>';
            setTimeout(() => { boton.classList.remove('agregado'); boton.innerHTML = iconoOriginal; }, 900);

            // Actualiza el contador del carrito flotante.
            let badge = document.getElementById('carritoBadge');
            if (!badge) {
                badge = document.createElement('span');
                badge.className = 'carrito-flotante-badge';
                badge.id = 'carritoBadge';
                document.querySelector('.carrito-flotante').appendChild(badge);
            }
            badge.textContent = data.totalItems;

            // Vuelve la cantidad del stepper a 1, listo para seguir agregando.
            form.querySelector('.producto-cantidad').value = 1;

            mostrarToast('Producto agregado al carrito.', 'ok');
        })
        .catch(() => mostrarToast('No se pudo conectar con el servidor.', 'error'));
    });
});
</script>
</body>
</html>
