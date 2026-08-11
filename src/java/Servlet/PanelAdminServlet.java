package Servlet;

import Controlador.UsuariosDAO;
import Controlador.PedidoDAO;
import Controlador.PagosDAO;
import Controlador.ProductoDAO;
import Modelo.Usuarios;
import Modelo.Pedido;
import Modelo.Pagos;
import Modelo.Producto;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PanelAdmin")
public class PanelAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("perfil") == null) {
            response.sendRedirect(request.getContextPath() + "/Vista/InicioSesion.jsp");
            return;
        }

        UsuariosDAO usuariosDAO = new UsuariosDAO();
        PedidoDAO pedidoDAO     = new PedidoDAO();
        PagosDAO pagosDAO       = new PagosDAO();
        ProductoDAO productoDAO = new ProductoDAO();

        List<Producto> productos;
        List<Pedido> pedidos;
        try {
            productos = productoDAO.listarProductos();
            pedidos = pedidoDAO.listarPedidos();
        } catch (Exception e) {
            productos = new java.util.ArrayList<>();
            pedidos = new java.util.ArrayList<>();
            request.setAttribute("error", "No se pudieron cargar los datos: " + e.getMessage());
        }

        // Conteos para tarjetas resumen
        int totalUsuarios = usuariosDAO.contarUsuarios();
        int totalPedidos   = pedidos.size();
        int totalPagos     = pagosDAO.listarPagos().size();
        int totalProductos = productos.size();

        // Pedidos a domicilio que aún no se han entregado ni cancelado
        // (1 Recibido, 2 En preparación, 3 Listo) — le da al admin una
        // idea rápida de cuánto trabajo tiene el repartidor en este momento.
        int totalEntregasPendientes = 0;
        for (Pedido p : pedidos) {
            int estado = p.getEstado_pedido_idEstado_pedido();
            if ("Domicilio".equalsIgnoreCase(p.gettipo_entrega()) && estado >= 1 && estado <= 3) {
                totalEntregasPendientes++;
            }
        }

        // Listas para tablas
        List<Usuarios> usuarios = usuariosDAO.listarUsuarios();
        List<Pagos>    pagos    = pagosDAO.listarPagos();

        // Pasar al JSP
        request.setAttribute("totalUsuarios",  totalUsuarios);
        request.setAttribute("totalPedidos",   totalPedidos);
        request.setAttribute("totalPagos",     totalPagos);
        request.setAttribute("totalProductos", totalProductos);
        request.setAttribute("totalEntregasPendientes", totalEntregasPendientes);
        request.setAttribute("usuarios",  usuarios);
        request.setAttribute("pedidos",   pedidos);
        request.setAttribute("pagos",     pagos);
        request.setAttribute("productos", productos);

        request.getRequestDispatcher("/PanelAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
