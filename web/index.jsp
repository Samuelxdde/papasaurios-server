<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Papasaurios — Salchipapería</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <script src="${ctx}/Vista/JavaScript/navActivo.js"></script>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<nav class="navbar" id="navbar">
    <div class="navbar-inner">
        <!-- Links izquierda -->
        <ul class="nav-links nav-left">
            <li><a href="${ctx}/Vista/Historia.jsp">Nuestra historia</a></li>
            <li><a href="${ctx}/Menu">Menú</a></li>
        </ul>

        <!-- Logo centro -->
        <a href="#hero" class="nav-logo">
            <img src="${ctx}/Vista/Imagenes/loguito.png" alt="Logo">
            <span>Papasaurios</span>
        </a>

        <!-- Links derecha -->
        <ul class="nav-links nav-right">
            <li><a href="${ctx}/Vista/Carrito.jsp">Mi carrito</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.nombreUsuario}">
                    <li><a href="${ctx}/PanelUsuario">Mis pedidos</a></li>
                    <li class="nav-user">Hola, <c:out value="${sessionScope.nombreUsuario}"/></li>
                    <li><a href="${ctx}/CerrarSesion" class="nav-btn">Salir</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${ctx}/Vista/InicioSesion.jsp" class="nav-btn">Ingresar</a></li>
                </c:otherwise>
            </c:choose>
        </ul>

        <!-- Hamburguesa móvil -->
        <button class="hamburger" id="hamburger" aria-label="Menú">
            <span></span><span></span><span></span>
        </button>
    </div>

    <!-- Menú móvil -->
    <div class="mobile-menu" id="mobileMenu">
        <a href="${ctx}/Vista/Historia.jsp">Nuestra historia</a>
        <a href="${ctx}/Menu">Menú</a>
        <a href="${ctx}/Vista/Carrito.jsp">Mi carrito</a>
        <c:if test="${not empty sessionScope.nombreUsuario}">
            <a href="${ctx}/PanelUsuario">Mis pedidos</a>
            <a href="${ctx}/CerrarSesion">Cerrar Sesión</a>
        </c:if>
        <c:if test="${empty sessionScope.nombreUsuario}">
            <a href="${ctx}/Vista/InicioSesion.jsp">Ingresar</a>
        </c:if>
    </div>
</nav>

<!-- ===== HERO PARALLAX ===== -->
<section class="hero" id="hero">
    <div class="hero-bg" id="heroBg"></div>
    <div class="hero-overlay"></div>
    <div class="hero-content" id="heroContent">
        <p class="hero-tag">Soacha, Cundinamarca</p>
        <h1 class="hero-title">Salchipapas · Burgers<br>· Picadas Jurásicas</h1>
        <p class="hero-sub">Armado a tu gusto, con sabor de otra era. Pide para recoger o a domicilio.</p>
        <div class="hero-actions">
            <a href="${ctx}/Menu" class="btn-hero-primary">Pedir ahora</a>
            <a href="#menu" class="btn-hero-secondary">Ver el menú</a>
        </div>
        <!-- Antes era un <div> decorativo sin ningún manejador de eventos:
             no hacía nada al hacer clic. Ahora es un botón real que baja
             con scroll suave hasta la franja destacada, justo debajo del hero. -->
        <button type="button" class="hero-scroll-hint" onclick="document.getElementById('franja-destacada').scrollIntoView({behavior:'smooth'})">
            <span>Descubre más</span>
            <i class="ti ti-chevron-down"></i>
        </button>
    </div>
</section>

<!-- ===== FRANJA DESTACADA ===== -->
<section class="franja" id="franja-destacada">
    <div class="franja-items">
        <div class="franja-item"><i class="ti ti-bone"></i><span>Papas Saurios armables</span></div>
        <div class="franja-sep">✦</div>
        <div class="franja-item"><i class="ti ti-meat"></i><span>Alitas BBQ</span></div>
        <div class="franja-sep">✦</div>
        <div class="franja-item"><i class="ti ti-truck-delivery"></i><span>A domicilio</span></div>
        <div class="franja-sep">✦</div>
        <div class="franja-item"><i class="ti ti-users"></i><span>Picadas para compartir</span></div>
    </div>
</section>

<!-- ===== PROMOCIÓN DESTACADA ===== -->
<section class="promo-banner">
    <div class="promo-banner-inner">
        <div class="promo-banner-texto reveal">
            <span class="promo-banner-tag">Lo más pedido</span>
            <h2>El Dino, armado como quieras</h2>
            <p>Papa criolla, cascos o francesa artesanal + queso + salchicha + tu proteína y toppings a elección.</p>
            <div class="promo-banner-precio">
                <span class="promo-banner-desde">Desde</span>
                <span class="promo-banner-monto">$32.000</span>
            </div>
            <a href="${ctx}/Menu" class="btn-hero-primary">Pedir ahora</a>
        </div>
        <div class="promo-banner-cards reveal">
            <div class="promo-mini-card">
                <span class="promo-mini-nombre">Mafesaurus</span>
                <span class="promo-mini-precio">$34.000</span>
                <span class="promo-mini-tag">2 proteínas · 3 toppings</span>
            </div>
            <div class="promo-mini-card promo-mini-card-destacada">
                <span class="promo-mini-nombre">Majosaurus</span>
                <span class="promo-mini-precio">$39.000</span>
                <span class="promo-mini-tag">4 proteínas · 5 toppings</span>
            </div>
        </div>
    </div>
</section>

<!-- ===== HISTORIA ===== -->
<section class="seccion seccion-historia" id="historia">
    <div class="seccion-contenido reverse">
        <div class="seccion-texto reveal">
            <span class="label-seccion">Nuestra historia</span>
            <h2>Nacimos en Soacha con hambre de algo distinto</h2>
            <p>Papasaurios empezó con una idea simple: salchipapas armadas a tu gusto, con la actitud de un dinosaurio hambriento. Hoy tenemos Papas Saurios, sandwiches, burgers, alitas BBQ y mucho más.</p>
            <a href="${ctx}/Vista/Historia.jsp" class="btn-outline">Conocer más</a>
        </div>
        <div class="seccion-imagen reveal">
            <img src="${ctx}/Vista/Imagenes/logo_completo.png" alt="Papasaurios">
            <div class="imagen-deco"></div>
        </div>
    </div>
</section>

<!-- ===== MENÚ DESTACADO ===== -->
<section class="seccion seccion-dark" id="menu">
    <div class="seccion-header reveal">
        <span class="label-seccion">Lo que servimos</span>
        <h2>Nuestro menú</h2>
        <p>Arma tu papa, tu sandwich o tu picada como quieras</p>
    </div>
    <div class="actividades-grid">
        <div class="act-card reveal">
            <div class="act-icon"><i class="ti ti-bone"></i></div>
            <h3>Papas Saurios</h3>
            <p>Dino, Mafesaurus o Majosaurus: papa, queso, salchicha, proteínas y toppings a tu elección.</p>
            <span class="act-tag">Lo más pedido</span>
        </div>
        <div class="act-card reveal">
            <div class="act-icon"><i class="ti ti-sandwich"></i></div>
            <h3>Sandwich</h3>
            <p>Carne, pollo, pernil, roast beef, cordero, atún o el especial De la Casa.</p>
            <span class="act-tag">Pequeño o grande</span>
        </div>
        <div class="act-card reveal">
            <div class="act-icon"><i class="ti ti-burger"></i></div>
            <h3>Dino Burguer &amp; Dog</h3>
            <p>Hamburguesas y perros calientes temáticos, solos o en combo.</p>
            <span class="act-tag">Para compartir</span>
        </div>
        <div class="act-card reveal">
            <div class="act-icon"><i class="ti ti-meat"></i></div>
            <h3>Alitas BBQ</h3>
            <p>Dino, Mafe o Majo Wings: 5, 10 o 20 piezas con papas y salsas.</p>
            <span class="act-tag">Picante a tu gusto</span>
        </div>
        <div class="act-card reveal">
            <div class="act-icon"><i class="ti ti-chef-hat"></i></div>
            <h3>Patacones</h3>
            <p>Costeño, mixto, marinero, mexicano o paisa, todos a un solo precio.</p>
            <span class="act-tag">Bien cargados</span>
        </div>
        <div class="act-card reveal">
            <div class="act-icon"><i class="ti ti-flame"></i></div>
            <h3>Picada Jurásica</h3>
            <p>Papas, alitas, chicharrón, costillas, chunchullo y chorizo para compartir.</p>
            <span class="act-tag">Para el grupo</span>
        </div>
    </div>
    <div class="text-center reveal">
        <a href="${ctx}/Menu" class="btn-hero-primary">Ver menú completo</a>
    </div>
</section>

<!-- ===== HORARIOS ===== -->
<section class="seccion seccion-horarios" id="horarios">
    <div class="seccion-header reveal">
        <span class="label-seccion">Cuándo visitarnos</span>
        <h2>Horarios de atención</h2>
    </div>
    <div class="horarios-contenedor reveal">
        <div class="horario-card destacado">
            <div class="horario-dia">Martes — Sábado</div>
            <div class="horario-hora">11:00 AM — 7:00 PM</div>
            <div class="horario-nota">Pedidos para recoger o domicilio</div>
        </div>
        <div class="horario-sep">✦</div>
        <div class="horario-card">
            <div class="horario-dia">Domingos y Lunes</div>
            <div class="horario-hora">Cerrado</div>
            <div class="horario-nota">Atención solo por encargo especial</div>
        </div>
    </div>
    <div class="reveal text-center" style="margin-top:32px">
        <p class="horario-extra"><i class="ti ti-info-circle"></i> Los horarios pueden variar en festivos. <a href="${ctx}/Menu">Haz tu pedido aquí.</a></p>
    </div>
</section>

<!-- ===== TESTIMONIOS ===== -->
<section class="seccion seccion-dark" id="testimonios">
    <div class="seccion-header reveal">
        <span class="label-seccion">Lo que dicen</span>
        <h2>Testimonios</h2>
    </div>
    <div class="testimonios-grid">
        <div class="testimonio-card reveal">
            <div class="testimonio-estrellas">★★★★★</div>
            <p>"El Majosaurus es una locura, queda buenísimo entre varios. ¡Volvemos seguro!"</p>
            <div class="testimonio-autor">
                <div class="autor-avatar">MG</div>
                <div><strong>María García</strong><span>Soacha</span></div>
            </div>
        </div>
        <div class="testimonio-card reveal">
            <div class="testimonio-estrellas">★★★★★</div>
            <p>"Fuimos en familia un sábado y la Picada Jurásica no alcanzó ni para las fotos, de buena que estaba."</p>
            <div class="testimonio-autor">
                <div class="autor-avatar">CR</div>
                <div><strong>Carlos Rodríguez</strong><span>Soacha</span></div>
            </div>
        </div>
        <div class="testimonio-card reveal">
            <div class="testimonio-estrellas">★★★★★</div>
            <p>"Pedí a domicilio y llegó calientito y rápido. Las alitas Mafe Wings con todo y limonada, espectacular."</p>
            <div class="testimonio-autor">
                <div class="autor-avatar">LP</div>
                <div><strong>Laura Patiño</strong><span>Soacha</span></div>
            </div>
        </div>
    </div>
</section>

<!-- ===== UBICACIÓN ===== -->
<section class="seccion seccion-ubicacion" id="ubicacion">
    <div class="seccion-contenido">
        <div class="seccion-texto reveal">
            <span class="label-seccion">Encuéntranos</span>
            <h2>¿Cómo llegar?</h2>
            <div class="ubicacion-datos">
                <div class="ubic-item"><i class="ti ti-map-pin"></i><span>DG 34 #13A-40, Soacha</span></div>
                <div class="ubic-item"><i class="ti ti-phone"></i><span>+57 314 300 7413</span></div>
                <div class="ubic-item"><i class="ti ti-mail"></i><span>contacto@papasaurios.com</span></div>
                <div class="ubic-item"><i class="ti ti-brand-instagram"></i><span>@papasaurios_soacha</span></div>
            </div>
            <div class="redes-sociales">
                <a href="https://www.instagram.com/papasaurios_soacha/" class="red-btn" target="_blank"><i class="ti ti-brand-instagram"></i></a>
                <a href="https://wa.me/573143007413" class="red-btn" target="_blank"><i class="ti ti-brand-whatsapp"></i></a>
            </div>
        </div>
        <div class="seccion-mapa reveal">
            <div class="mapa-placeholder">
                <i class="ti ti-map-2"></i>
                <p>DG 34 #13A-40<br>Soacha, Cundinamarca</p>
                <a href="https://maps.google.com/?q=DG+34+%2313A-40,+Soacha" target="_blank" class="btn-outline">Ver en Google Maps</a>
            </div>
        </div>
    </div>
</section>

<!-- ===== FOOTER ===== -->
<footer class="footer">
    <div class="footer-contenedor">
        <div class="footer-info">
            <h3>Papasaurios — Salchipapería</h3>
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

<script src="${ctx}/Vista/JavaScript/funciones.js"></script>
<script>
// ===== PARALLAX HERO =====
const heroBg = document.getElementById('heroBg');
const heroContent = document.getElementById('heroContent');
window.addEventListener('scroll', () => {
    const y = window.scrollY;
    if (heroBg) heroBg.style.transform = `translateY(${y * 0.45}px)`;
    if (heroContent) heroContent.style.transform = `translateY(${y * 0.2}px)`;
});

// ===== NAVBAR SHRINK =====
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 60);
});

// ===== HAMBURGUESA =====
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    mobileMenu.classList.toggle('open');
});

// ===== REVEAL ON SCROLL =====
const reveals = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            observer.unobserve(entry.target);
        }
    });
}, { threshold: 0.12 });
reveals.forEach(el => observer.observe(el));

// ===== SMOOTH SCROLL =====
document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
        const target = document.querySelector(a.getAttribute('href'));
        if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth' }); }
    });
});
</script>
</body>
</html>
