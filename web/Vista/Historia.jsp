<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historia - Papasaurios</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <script src="${ctx}/Vista/JavaScript/navActivo.js"></script>
</head>
<body>

    <!-- NAVBAR -->
    <header class="navbar scrolled">
        <div class="navbar-inner">
            <a href="${ctx}/index.jsp" class="nav-logo">
                <img src="${ctx}/Vista/Imagenes/logo.png" alt="Logo">
                <span>Papasaurios</span>
            </a>
            <ul class="nav-links">
                <li><a href="${ctx}/index.jsp">Inicio</a></li>
                <li><a href="${ctx}/Menu">Menú</a></li>
                <li><a href="${ctx}/Vista/Carrito.jsp">Mi carrito</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.nombreUsuario}">
                        <li><a href="${ctx}/PanelUsuario">Mis pedidos</a></li>
                        <li class="nav-user">Hola, <c:out value="${sessionScope.nombreUsuario}"/></li>
                        <li><a href="${ctx}/CerrarSesion" class="nav-btn">Salir</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${ctx}/Vista/InicioSesion.jsp" class="nav-btn">Iniciar Sesión</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </header>

    <!-- SECCIÓN HISTORIA -->
    <section class="seccion seccion-historia reveal">
        <div class="seccion-header">
            <span class="label-seccion">Nuestra Historia</span>
            <h2>Hambre prehistórica, sabor actual</h2>
            <p>Papasaurios nació en Soacha con una idea simple: salchipapas armadas a tu gusto,
               servidas con la actitud de un dinosaurio hambriento.</p>
        </div>

        <div class="seccion-contenido">
            <div class="seccion-texto">
                <h2>De una idea a todo un menú</h2>
                <p>Empezamos con la Papa Saurios clásica y fuimos creciendo: sandwiches, Dino Burguers,
                   Dino Dogs, patacones, alitas BBQ, dorilocos y picadas para compartir. Todo pensado para
                   que cada pedido se sienta como un festín de otra era.</p>
                <a href="${ctx}/Menu" class="btn-outline">Ver el menú</a>
            </div>
            <div class="seccion-imagen">
                <img src="${ctx}/Vista/Imagenes/logo_completo.png" alt="Historia Papasaurios">
                <div class="imagen-deco"></div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
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
        <div class="footer-copy">
            <p>&copy; 2026 Papasaurios. Todos los derechos reservados.</p>
            <p><a href="${ctx}/Vista/PoliticaDatos.jsp">Política de tratamiento de datos y términos</a></p>
        </div>
    </footer>

    <a href="${ctx}/Vista/Carrito.jsp" class="carrito-flotante">
        <i class="ti ti-shopping-cart"></i>
        <c:if test="${not empty sessionScope.carrito}">
            <span class="carrito-flotante-badge">${sessionScope.carrito.size()}</span>
        </c:if>
    </a>

    <script>
    const reveals = document.querySelectorAll('.reveal');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });
    reveals.forEach(el => observer.observe(el));
    </script>
</body>
</html>
