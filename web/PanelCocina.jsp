<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de cocina — Papasaurios</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <style>
        .pedido-nota { font-size: 0.78rem; color: var(--dorado2); margin-top: 2px; font-style: italic; }
        .cocina-card-listo { opacity: 0.7; }
    </style>
</head>
<body>

<nav class="navbar scrolled" id="navbar">
    <div class="navbar-inner">
        <ul class="nav-links nav-left">
            <li><a href="${ctx}/index.jsp">Inicio</a></li>
        </ul>
        <a href="${ctx}/PanelCocina" class="nav-logo">
            <img src="${ctx}/Vista/Imagenes/loguito.png" alt="Logo">
            <span>Papasaurios</span>
        </a>
        <ul class="nav-links nav-right">
            <li class="nav-user"><i class="ti ti-chef-hat"></i> Hola, <c:out value="${sessionScope.nombreUsuario}"/></li>
            <li><a href="${ctx}/CerrarSesion" class="nav-btn">Salir</a></li>
        </ul>
        <button class="hamburger" id="hamburger" aria-label="Menú"><span></span><span></span><span></span></button>
    </div>
    <div class="mobile-menu" id="mobileMenu">
        <a href="${ctx}/index.jsp">Inicio</a>
        <a href="${ctx}/CerrarSesion">Cerrar Sesión</a>
    </div>
</nav>

<section class="seccion seccion-perfil" style="padding-top:140px;">
    <div class="seccion-header reveal">
        <span class="label-seccion">Panel de cocina</span>
        <h2>Hola, <c:out value="${sessionScope.nombreUsuario}"/> 🍳</h2>
        <p>Cola de pedidos, del más viejo al más nuevo.</p>
    </div>

    <div class="perfil-grid reveal">
        <div class="perfil-card">
            <div class="perfil-card-icon"><i class="ti ti-receipt"></i></div>
            <div>
                <div class="perfil-card-label">Por empezar</div>
                <div class="perfil-card-valor">${recibidos.size()}</div>
            </div>
        </div>
        <div class="perfil-card">
            <div class="perfil-card-icon"><i class="ti ti-tools-kitchen-2"></i></div>
            <div>
                <div class="perfil-card-label">En preparación</div>
                <div class="perfil-card-valor">${enPreparacion.size()}</div>
            </div>
        </div>
    </div>
</section>

<c:if test="${not empty error}">
    <div class="alert alert-err" style="max-width:600px;margin:0 auto 24px;"><i class="ti ti-alert-circle"></i> ${error}</div>
</c:if>
<c:if test="${not empty mensaje}">
    <div class="alert alert-ok" style="max-width:600px;margin:0 auto 24px;"><i class="ti ti-circle-check"></i> ${mensaje}</div>
</c:if>

<section class="seccion seccion-dark">
    <div class="seccion-header reveal">
        <span class="label-seccion">Paso 1</span>
        <h2>Por empezar</h2>
    </div>

    <div class="reservas-usuario-grid reveal">
        <c:forEach var="pedido" items="${recibidos}">
            <div class="reserva-card">
                <div class="pedido-card-top">
                    <div class="reserva-card-fecha"><i class="ti ti-hash"></i> Pedido ${pedido.idPedido}</div>
                    <span class="status pendiente">Recibido</span>
                </div>
                <div class="reserva-card-hora"><i class="ti ti-clock"></i> <fmt:formatDate value="${pedido.hora}" pattern="hh:mm a"/></div>
                <div class="reserva-card-personas">
                    <i class="ti ti-truck-delivery"></i> ${pedido.tipo_entrega}
                    <c:if test="${not empty pedido.direccion_entrega}"> — <c:out value="${pedido.direccion_entrega}"/></c:if>
                </div>

                <c:set var="detalles" value="${detallesPorPedido[pedido.idPedido]}"/>
                <c:if test="${not empty detalles}">
                    <ul class="pedido-detalle-lista">
                        <c:forEach var="d" items="${detalles}">
                            <li>
                                <span class="pedido-detalle-cant">${d.cantidad}x</span> ${nombresProducto[d.producto_idProducto]}
                                <c:if test="${not empty d.nota}"><div class="pedido-nota"><i class="ti ti-note"></i> ${d.nota}</div></c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>

                <form action="${ctx}/PanelCocina" method="post" style="margin-top:14px;">
                    <input type="hidden" name="accion" value="empezar">
                    <input type="hidden" name="id" value="${pedido.idPedido}">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    <button type="submit" class="btn-hero-primary" style="border:none;cursor:pointer;font-family:inherit;width:100%;">
                        <i class="ti ti-player-play"></i> Empezar preparación
                    </button>
                </form>
            </div>
        </c:forEach>
        <c:if test="${empty recibidos}">
            <div class="reserva-card-vacio">
                <i class="ti ti-checkbox"></i>
                <p>No hay pedidos nuevos por empezar.</p>
            </div>
        </c:if>
    </div>
</section>

<section class="seccion">
    <div class="seccion-header reveal">
        <span class="label-seccion">Paso 2</span>
        <h2>En preparación</h2>
    </div>

    <div class="reservas-usuario-grid reveal">
        <c:forEach var="pedido" items="${enPreparacion}">
            <div class="reserva-card">
                <div class="pedido-card-top">
                    <div class="reserva-card-fecha"><i class="ti ti-hash"></i> Pedido ${pedido.idPedido}</div>
                    <span class="status activo">En preparación</span>
                </div>
                <div class="reserva-card-hora"><i class="ti ti-clock"></i> <fmt:formatDate value="${pedido.hora}" pattern="hh:mm a"/></div>
                <c:if test="${not empty pedido.hora_estimada}">
                    <div class="reserva-card-hora"><i class="ti ti-hourglass"></i> Estimado: <fmt:formatDate value="${pedido.hora_estimada}" pattern="hh:mm a"/></div>
                </c:if>
                <div class="reserva-card-personas">
                    <i class="ti ti-truck-delivery"></i> ${pedido.tipo_entrega}
                    <c:if test="${not empty pedido.direccion_entrega}"> — <c:out value="${pedido.direccion_entrega}"/></c:if>
                </div>

                <c:set var="detalles" value="${detallesPorPedido[pedido.idPedido]}"/>
                <c:if test="${not empty detalles}">
                    <ul class="pedido-detalle-lista">
                        <c:forEach var="d" items="${detalles}">
                            <li>
                                <span class="pedido-detalle-cant">${d.cantidad}x</span> ${nombresProducto[d.producto_idProducto]}
                                <c:if test="${not empty d.nota}"><div class="pedido-nota"><i class="ti ti-note"></i> ${d.nota}</div></c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>

                <form action="${ctx}/PanelCocina" method="post" style="margin-top:14px;">
                    <input type="hidden" name="accion" value="listo">
                    <input type="hidden" name="id" value="${pedido.idPedido}">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    <button type="submit" class="btn-hero-primary" style="border:none;cursor:pointer;font-family:inherit;width:100%;">
                        <i class="ti ti-check"></i> Marcar como listo
                    </button>
                </form>
            </div>
        </c:forEach>
        <c:if test="${empty enPreparacion}">
            <div class="reserva-card-vacio">
                <i class="ti ti-tools-kitchen-2"></i>
                <p>No hay nada en preparación en este momento.</p>
            </div>
        </c:if>
    </div>
</section>

<section class="seccion seccion-dark">
    <div class="seccion-header reveal">
        <span class="label-seccion">Historial</span>
        <h2>Listos recientemente</h2>
    </div>

    <div class="reservas-usuario-grid reveal">
        <c:forEach var="pedido" items="${listosRecientes}">
            <div class="reserva-card cocina-card-listo">
                <div class="pedido-card-top">
                    <div class="reserva-card-fecha"><i class="ti ti-hash"></i> Pedido ${pedido.idPedido}</div>
                    <span class="status activo"><i class="ti ti-check"></i> Listo</span>
                </div>
                <div class="reserva-card-personas">
                    <i class="ti ti-truck-delivery"></i> ${pedido.tipo_entrega}
                    <c:if test="${not empty pedido.direccion_entrega}"> — <c:out value="${pedido.direccion_entrega}"/></c:if>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty listosRecientes}">
            <div class="reserva-card-vacio">
                <i class="ti ti-history"></i>
                <p>Todavía no has marcado ningún pedido como listo.</p>
            </div>
        </c:if>
    </div>
</section>

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
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
hamburger.addEventListener('click', () => { hamburger.classList.toggle('active'); mobileMenu.classList.toggle('open'); });
const reveals = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => { if (entry.isIntersecting) { entry.target.classList.add('visible'); observer.unobserve(entry.target); } });
}, { threshold: 0.1 });
reveals.forEach(el => observer.observe(el));

// Auto-refresco de la cocina: cada 8 segundos pregunta al servidor si
// hay pedidos nuevos o si alguno cambió de estado (por ejemplo, si otra
// persona en otro dispositivo ya lo marcó). Si nada cambió, no hace
// nada — la pantalla se queda quieta, sin parpadear ni perder el
// scroll. Solo recarga cuando de verdad hay algo nuevo que ver.
(function () {
    let ultimaFirma = "${firmaEstado}";
    setInterval(async () => {
        try {
            const res = await fetch('${ctx}/PanelCocina?check=estado', { cache: 'no-store' });
            const datos = await res.json();
            if (datos.firma !== ultimaFirma) {
                location.reload();
            }
        } catch (e) {
            // Sin internet momentáneamente o el servidor no respondió:
            // no pasa nada, se vuelve a intentar en el siguiente ciclo.
        }
    }, 8000);
})();
</script>
</body>
</html>
