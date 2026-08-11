<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse - Papasaurios</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/style.css">
    <script src="${ctx}/Vista/JavaScript/validarReg.js"></script>
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
                <li><a href="${ctx}/Vista/Historia.jsp">Nuestra historia</a></li>
                <li><a href="${ctx}/Menu">Menú</a></li>
                <li><a href="${ctx}/Vista/Carrito.jsp">Mi carrito</a></li>
                <li><a href="${ctx}/Iniciar" class="nav-btn">Iniciar Sesión</a></li>
            </ul>
        </div>
    </header>

    <!-- FORMULARIO REGISTRO -->
    <section class="seccion seccion-historia">
        <div class="Formulario">
            <h2>Registrarse</h2>
            <form action="${ctx}/Registrarse" method="post" onsubmit="return validarRegistro()">
                <c:if test="${not empty resultado}">
                    <p class="mensaje">${resultado}</p>
                </c:if>

                <div class="form-field">
                    <label for="nombre">Nombre</label>
                    <input type="text" name="nombrep" id="nombre" required>
                </div>

                <div class="form-field">
                    <label for="apellido">Apellido</label>
                    <input type="text" name="apellidoa" id="apellido" required>
                </div>

                <div class="form-field">
                    <label for="tipodoc">Tipo de documento</label>
                    <select id="tipodoc" name="tipodocs">
                        <c:forEach var="tipo" items="${tiposDoc}">
                            <option value="${tipo.idTipo_documento}">${tipo.descripcion_doc}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-field">
                    <label for="documento">Número de documento</label>
                    <input type="text" name="documentoa" id="documento" required>
                </div>

                <div class="form-field">
                    <label for="telefono">Teléfono</label>
                    <input type="text" name="telefonoi" id="telefono" pattern="\+?\d{7,15}" title="Solo números (puede empezar con '+' para el indicativo de país), entre 7 y 15 dígitos" required>
                </div>

                <div class="form-field">
                    <label for="correo">Correo</label>
                    <input type="email" name="correoz" id="correo" required>
                </div>

                <div class="form-field">
                    <p style="margin:0;">Este formulario crea una cuenta de <strong>cliente</strong>.
                    Si necesitas una cuenta de administrador o de repartidor, pídesela a un administrador
                    desde el panel de usuarios.</p>
                </div>

                <div class="form-field">
                    <label for="clave">Contraseña</label>
                    <input type="password" name="clavev" id="clave" required>
                </div>

                <div class="form-field">
                    <label for="fecha_nac">Fecha de nacimiento</label>
                    <input type="date" name="fecha_nac" id="fecha_nac" required>
                </div>

                <div class="form-field">
                    <label>
                        <input type="checkbox" name="checkbox" id="checkbox" required>
                        Acepto el tratamiento de mis datos personales y los
                        <a href="${ctx}/Vista/PoliticaDatos.jsp" target="_blank">términos y la política de tratamiento de datos</a>
                    </label>
                </div>

                <button type="submit">Registrarse</button>
                <button type="button" onclick="window.location='${ctx}/Iniciar'">Iniciar Sesión</button>
            </form>
        </div>
    </section>

    <!-- ===== MODAL DE CARGA ===== -->
    <div class="overlay-carga" id="overlayCarga">
        <div class="modal-carga">
            <div class="spinner-carga"></div>
            <p data-texto-carga>Creando tu cuenta...</p>
            <span>Un momento, por favor</span>
        </div>
    </div>

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
            <p>&copy; 2026 Papasaurios - Salchipapería. Todos los derechos reservados.</p>
            <p><a href="${ctx}/Vista/PoliticaDatos.jsp">Política de tratamiento de datos y términos</a></p>
        </div>
    </footer>

</body>
</html>
