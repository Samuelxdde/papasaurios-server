<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuarios — Panel Admin</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Syne:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="sidebar.jsp" %>
<main class="main-content">
    <%@ include file="topbar.jsp" %>
    <div class="crud-header"><h2 class="page-title"><i class="ti ti-users"></i> Gestión de usuarios</h2></div>
    <c:if test="${not empty resultado}"><div class="alert alert-ok"><i class="ti ti-circle-check"></i> ${resultado}</div></c:if>

    <!-- Formulario de creación -->
    <div class="panel form-panel">
        <div class="panel-header"><span class="panel-title"><i class="ti ti-user-plus"></i> Registrar nuevo usuario</span></div>
        <form action="${ctx}/Usuario" method="post" class="crud-form">
            <input type="hidden" name="accion" value="insertar">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <div class="form-row">
                <div class="form-group">
                    <label>Nombre</label>
                    <input type="text" name="nombre" placeholder="Nombre" required>
                </div>
                <div class="form-group">
                    <label>Apellido</label>
                    <input type="text" name="apellido" placeholder="Apellido" required>
                </div>
                <div class="form-group">
                    <label>Documento</label>
                    <input type="text" name="documento" placeholder="Documento" required>
                </div>
                <div class="form-group">
                    <label>Teléfono</label>
                    <input type="text" name="telefono" placeholder="Teléfono" pattern="\+?\d{7,15}" title="Solo números (puede empezar con '+' para el indicativo de país), entre 7 y 15 dígitos" required>
                </div>
                <div class="form-group">
                    <label>Correo</label>
                    <input type="email" name="correo" placeholder="Correo" required>
                </div>
                <div class="form-group">
                    <label>Contraseña</label>
                    <input type="password" name="clave" placeholder="Contraseña" required>
                </div>
                <div class="form-group">
                    <label>Fecha de nacimiento</label>
                    <input type="date" name="fecha_nac" required>
                </div>
                <div class="form-group">
                    <label>Tipo de documento</label>
                    <select name="Tipo_documento_idTipo_documento" required>
                        <c:forEach var="td" items="${listaTipoDocumento}">
                            <option value="${td.idTipo_documento}">${td.descripcion_doc}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Rol</label>
                    <select name="Roles_idRoles" required>
                        <c:forEach var="r" items="${listaRoles}">
                            <option value="${r.idRoles}">${r.descripcion_rol}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label style="text-transform:none;font-size:12px;display:flex;align-items:center;gap:6px;">
                        <input type="checkbox" name="checkbox" style="width:auto;"> Acepta tratamiento de datos
                        (<a href="${ctx}/Vista/PoliticaDatos.jsp" target="_blank">ver política</a>)
                    </label>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-primary"><i class="ti ti-check"></i> Registrar usuario</button>
            </div>
        </form>
    </div>

    <!-- Tabla de usuarios -->
    <div class="panel full-panel">
        <div class="panel-header">
            <span class="panel-title"><i class="ti ti-list"></i> Usuarios registrados</span>
            <div class="panel-actions">
                <div class="search-bar">
                    <i class="ti ti-search"></i>
                    <input type="text" id="searchUsuarios" placeholder="Buscar usuario..." onkeyup="filtrarTabla()">
                </div>
            </div>
        </div>
        <table id="tablaUsuarios">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Documento</th>
                    <th>Teléfono</th>
                    <th>Correo</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${listaUsuarios}">
                    <tr>
                        <td><c:out value="${u.nombre}"/></td>
                        <td><c:out value="${u.apellido}"/></td>
                        <td><c:out value="${u.documento}"/></td>
                        <td><c:out value="${u.telefono}"/></td>
                        <td><c:out value="${u.correo}"/></td>
                        <td>
                            <span class="status ${u.roles_idRoles == 1 ? 'activo' : (u.roles_idRoles == 3 || u.roles_idRoles == 4 ? 'pendiente' : '')}">
                                <c:choose>
                                    <c:when test="${u.roles_idRoles == 1}">Admin</c:when>
                                    <c:when test="${u.roles_idRoles == 3}">Repartidor</c:when>
                                    <c:when test="${u.roles_idRoles == 4}">Cocina</c:when>
                                    <c:otherwise>Usuario</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <button type="button" class="action-btn edit"
                                    data-id="${u.idUsuarios}"
                                    data-nombre="<c:out value='${u.nombre}'/>"
                                    data-apellido="<c:out value='${u.apellido}'/>"
                                    data-documento="<c:out value='${u.documento}'/>"
                                    data-telefono="<c:out value='${u.telefono}'/>"
                                    data-correo="<c:out value='${u.correo}'/>"
                                    data-tipodoc="${u.tipo_documento_idTipo_documento}"
                                    data-rol="${u.roles_idRoles}"
                                    data-fechanac="<fmt:formatDate value="${u.fecha_nac}" pattern="yyyy-MM-dd"/>"
                                    onclick="abrirModalEditar(this)">
                                <i class="ti ti-edit"></i>
                            </button>
                            <form action="${ctx}/Usuario" method="post" style="display:inline;">
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="idUsuario" value="${u.idUsuarios}">
                                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                                <button type="submit" class="action-btn del" onclick="return confirm('¿Eliminar usuario?')"><i class="ti ti-trash"></i></button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listaUsuarios}">
                    <tr><td colspan="7" class="empty-row">No hay usuarios registrados</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Modal de edición -->
    <div id="modalEditar" class="modal-overlay" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.55);align-items:center;justify-content:center;z-index:1000;">
        <div class="panel" style="max-width:520px;width:92%;">
            <div class="panel-header"><span class="panel-title"><i class="ti ti-edit"></i> Editar usuario</span></div>
            <form action="${ctx}/Usuario" method="post" class="crud-form">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                <input type="hidden" name="idUsuario" id="edit-id">
                <div class="form-row">
                    <div class="form-group"><label>Nombre</label><input type="text" name="nombre" id="edit-nombre" required></div>
                    <div class="form-group"><label>Apellido</label><input type="text" name="apellido" id="edit-apellido" required></div>
                    <div class="form-group"><label>Documento</label><input type="text" name="documento" id="edit-documento" required></div>
                    <div class="form-group"><label>Teléfono</label><input type="text" name="telefono" id="edit-telefono" pattern="\+?\d{7,15}" title="Solo números (puede empezar con '+' para el indicativo de país), entre 7 y 15 dígitos" required></div>
                    <div class="form-group"><label>Correo</label><input type="email" name="correo" id="edit-correo" required></div>
                    <div class="form-group"><label>Contraseña</label><input type="password" name="clave" id="edit-clave" placeholder="Dejar igual o escribir nueva"></div>
                    <div class="form-group"><label>Fecha de nacimiento</label><input type="date" name="fecha_nac" id="edit-fecha_nac" required></div>
                    <div class="form-group">
                        <label>Tipo de documento</label>
                        <select name="Tipo_documento_idTipo_documento" id="edit-tipodoc" required>
                            <c:forEach var="td" items="${listaTipoDocumento}">
                                <option value="${td.idTipo_documento}">${td.descripcion_doc}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Rol</label>
                        <select name="Roles_idRoles" id="edit-rol" required>
                            <c:forEach var="r" items="${listaRoles}">
                                <option value="${r.idRoles}">${r.descripcion_rol}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-primary"><i class="ti ti-check"></i> Guardar cambios</button>
                    <button type="button" class="btn-sm" onclick="cerrarModalEditar()">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</main>

<script>
function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('collapsed');
    document.querySelector('.main-content').classList.toggle('expanded');
}
function filtrarTabla() {
    const input = document.getElementById('searchUsuarios').value.toLowerCase();
    const rows = document.querySelectorAll('#tablaUsuarios tbody tr');
    rows.forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(input) ? '' : 'none';
    });
}
function abrirModalEditar(btn) {
    document.getElementById('edit-id').value = btn.dataset.id;
    document.getElementById('edit-nombre').value = btn.dataset.nombre;
    document.getElementById('edit-apellido').value = btn.dataset.apellido;
    document.getElementById('edit-documento').value = btn.dataset.documento;
    document.getElementById('edit-telefono').value = btn.dataset.telefono;
    document.getElementById('edit-correo').value = btn.dataset.correo;
    document.getElementById('edit-clave').value = '';
    document.getElementById('edit-tipodoc').value = btn.dataset.tipodoc;
    document.getElementById('edit-rol').value = btn.dataset.rol;
    document.getElementById('edit-fecha_nac').value = btn.dataset.fechanac;
    document.getElementById('modalEditar').style.display = 'flex';
}
function cerrarModalEditar() {
    document.getElementById('modalEditar').style.display = 'none';
}
</script>
</body>
</html>
