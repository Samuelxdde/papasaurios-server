<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<aside class="sidebar" id="sidebar">
    <div class="sidebar-logo">
        <img src="${ctx}/Vista/Imagenes/loguito.png" alt="Papasaurios" style="width:36px;height:36px;border-radius:50%;object-fit:cover;flex-shrink:0;">
        <div>
            <div class="logo-title">Papasaurios</div>
            <div class="logo-sub">Panel administrativo</div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section">General</div>
        <a href="${ctx}/PanelAdmin" class="nav-item"><i class="ti ti-layout-dashboard"></i> Inicio</a>
        <a href="${ctx}/Usuario" class="nav-item"><i class="ti ti-users"></i> Usuarios</a>

        <div class="nav-section">Menú</div>
        <a href="${ctx}/CategoriaAdmi" class="nav-item"><i class="ti ti-category"></i> Categorías</a>
        <a href="${ctx}/ProductoAdmi" class="nav-item"><i class="ti ti-bone"></i> Productos</a>
        <a href="${ctx}/VarianteAdmi" class="nav-item"><i class="ti ti-stack"></i> Variantes (tamaños/combos)</a>

        <div class="nav-section">Pedidos</div>
        <a href="${ctx}/PedidoAdmi" class="nav-item"><i class="ti ti-shopping-cart"></i> Pedidos</a>
        <a href="${ctx}/PagosAdmi" class="nav-item"><i class="ti ti-credit-card"></i> Pagos</a>

        <div class="nav-section">Configuración</div>
        <a href="${ctx}/Tipodoc" class="nav-item"><i class="ti ti-file-description"></i> Tipo documento</a>
        <a href="${ctx}/RolesAdmi" class="nav-item"><i class="ti ti-shield"></i> Roles</a>
        <a href="${ctx}/CerrarSesion" class="nav-item nav-logout"><i class="ti ti-logout"></i> Cerrar sesión</a>
    </nav>
</aside>
