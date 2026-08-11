<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Admin — Papasaurios</title>
    <link rel="stylesheet" href="${ctx}/Vista/Css/admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@2.44.0/tabler-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Syne:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>

<%@ include file="Vista/sidebar.jsp" %>

<!-- ===== MAIN ===== -->
<main class="main-content">

    <%@ include file="Vista/topbar.jsp" %>

    <div class="crud-header">
        <h1 class="page-title">Dashboard</h1>
        <p class="page-sub">Resumen general de Papasaurios</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-err"><i class="ti ti-alert-circle"></i> ${error}</div>
    </c:if>

    <!-- Tarjetas resumen -->
    <section class="cards-grid">
        <div class="stat-card green">
            <div class="stat-icon"><i class="ti ti-users"></i></div>
            <div class="stat-label">Usuarios</div>
            <div class="stat-num">${totalUsuarios}</div>
            <div class="stat-sub">registrados en total</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-icon"><i class="ti ti-shopping-cart"></i></div>
            <div class="stat-label">Pedidos</div>
            <div class="stat-num">${totalPedidos}</div>
            <div class="stat-sub">en el sistema</div>
        </div>
        <div class="stat-card amber">
            <div class="stat-icon"><i class="ti ti-bone"></i></div>
            <div class="stat-label">Productos</div>
            <div class="stat-num">${totalProductos}</div>
            <div class="stat-sub">en el menú</div>
        </div>
        <div class="stat-card teal">
            <div class="stat-icon"><i class="ti ti-credit-card"></i></div>
            <div class="stat-label">Pagos registrados</div>
            <div class="stat-num">${totalPagos}</div>
            <div class="stat-sub">en total</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-icon"><i class="ti ti-moped"></i></div>
            <div class="stat-label">Entregas pendientes</div>
            <div class="stat-num">${totalEntregasPendientes}</div>
            <div class="stat-sub"><a href="${pageContext.request.contextPath}/PedidoAdmi" style="color:inherit;text-decoration:underline;">ver en pedidos</a></div>
        </div>
    </section>

    <!-- Fila de tablas -->
    <section class="tables-row">

        <!-- Tabla pedidos recientes -->
        <div class="panel">
            <div class="panel-header">
                <span class="panel-title"><i class="ti ti-shopping-cart"></i> Pedidos recientes</span>
                <a href="${ctx}/PedidoAdmi" class="btn-sm">Ver todos</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Entrega</th>
                        <th>Fecha</th>
                        <th>Total</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${pedidos}" begin="0" end="4">
                        <tr>
                            <td>${p.idPedido}</td>
                            <td>${p.tipo_entrega}</td>
                            <td>${p.fecha}</td>
                            <td>$${p.total}</td>
                            <td>
                                <span class="status
                                    <c:choose>
                                        <c:when test="${p.estado_pedido_idEstado_pedido == 4}">activo</c:when>
                                        <c:when test="${p.estado_pedido_idEstado_pedido == 5}">inactivo</c:when>
                                        <c:otherwise>pendiente</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${p.estado_pedido_idEstado_pedido == 1}">Recibido</c:when>
                                        <c:when test="${p.estado_pedido_idEstado_pedido == 2}">En preparación</c:when>
                                        <c:when test="${p.estado_pedido_idEstado_pedido == 3}">Listo</c:when>
                                        <c:when test="${p.estado_pedido_idEstado_pedido == 4}">Entregado</c:when>
                                        <c:otherwise>Cancelado</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pedidos}">
                        <tr><td colspan="5" class="empty-row">No hay pedidos registrados</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Tabla productos -->
        <div class="panel">
            <div class="panel-header">
                <span class="panel-title"><i class="ti ti-bone"></i> Productos</span>
                <a href="${ctx}/ProductoAdmi" class="btn-sm">Gestionar</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Precio base</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="prod" items="${productos}" begin="0" end="4">
                        <tr>
                            <td>${prod.idProducto}</td>
                            <td>${prod.nombre_producto}</td>
                            <td>$${prod.precio_base}</td>
                            <td>
                                <a href="${ctx}/ProductoAdmi?accion=editar&id=${prod.idProducto}" class="action-btn edit"><i class="ti ti-edit"></i></a>
                                <a href="${ctx}/ProductoAdmi?accion=eliminar&id=${prod.idProducto}" class="action-btn del" onclick="return confirm('¿Eliminar producto?')"><i class="ti ti-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty productos}">
                        <tr><td colspan="4" class="empty-row">No hay productos registrados</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </section>

    <!-- Tabla usuarios completa -->
    <section class="panel full-panel">
        <div class="panel-header">
            <span class="panel-title"><i class="ti ti-users"></i> Gestión de usuarios</span>
            <div class="panel-actions">
                <div class="search-bar">
                    <i class="ti ti-search"></i>
                    <input type="text" id="searchUsuarios" placeholder="Buscar usuario..." onkeyup="filtrar('tablaUsuarios')">
                </div>
                <a href="${ctx}/Usuario" class="btn-primary">
                    <i class="ti ti-plus"></i> Nuevo usuario
                </a>
            </div>
        </div>
        <table id="tablaUsuarios">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Documento</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${usuarios}">
                    <tr>
                        <td><c:out value="${u.nombre}"/></td>
                        <td><c:out value="${u.apellido}"/></td>
                        <td><c:out value="${u.documento}"/></td>
                        <td><c:out value="${u.correo}"/></td>
                        <td><c:out value="${u.telefono}"/></td>
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
                            <a href="${ctx}/Usuario" class="action-btn edit" title="Editar y eliminar en Gestión de usuarios"><i class="ti ti-edit"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty usuarios}">
                    <tr><td colspan="7" class="empty-row">No hay usuarios registrados</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="text-center" style="margin-top:14px">
            <a href="${ctx}/Usuario" class="btn-sm"><i class="ti ti-arrow-right"></i> Ir a Gestión de usuarios (editar / eliminar)</a>
        </div>
    </section>

</main>

<script src="${ctx}/Vista/JavaScript/admin.js"></script>
</body>
</html>
