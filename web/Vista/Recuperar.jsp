<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recuperar Contraseña - Papasaurios</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/style.css">
    <script src="${ctx}/Vista/JavaScript/navActivo.js"></script>
</head>
<body>
    <div class="Formulario">
        <h2>Recuperar Contraseña</h2>

        <!-- Mensaje de resultado -->
        <c:if test="${not empty mensaje}">
            <p class="mensaje">${mensaje}</p>
        </c:if>

        <!-- Formulario de recuperación -->
        <form action="${ctx}/RecuperarClave" method="post">
            <label for="documento">Documento:</label>
            <input type="text" name="documento" id="documento" placeholder="Ingrese su documento" required>

            <button type="submit">Enviar nueva contraseña</button>
            <button type="button" onclick="window.location='${ctx}/index.jsp'">Volver al inicio</button>
        </form>
    </div>
</body>
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
</html>
