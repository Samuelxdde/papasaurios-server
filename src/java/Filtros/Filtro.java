package Filtros;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Filtro global de seguridad.
 *
 * Hace dos cosas:
 *  1) Exige sesión iniciada para todo lo que no sea público (como ya
 *     hacía antes).
 *  2) Ahora que existen 4 roles (Admin=1, Usuario=2, Repartidor=3,
 *     Cocina=4), además valida que el ROL de la sesión coincida con la
 *     sección que se está pidiendo. Antes solo se validaba "¿hay
 *     sesión?", así que un Usuario o un Repartidor logueado podía
 *     entrar por URL directa a /ProductoAdmi, /UsuarioAdmi, /PedidoAdmi, etc.
 *     Se protegen tanto las URLs de los servlets como las vistas JSP
 *     internas a las que esos servlets hacen forward (por si alguien
 *     intenta entrar directo a /Vista/Productoadmi.jsp, por ejemplo).
 */
@WebFilter("/*")
public class Filtro implements Filter {

    private static final int ROL_ADMIN = 1;
    private static final int ROL_REPARTIDOR = 3;
    private static final int ROL_COCINA = 4;

    // Rutas exclusivas del administrador (servlets + las vistas JSP internas
    // a las que esos servlets hacen forward).
    private static final Set<String> RUTAS_SOLO_ADMIN = new HashSet<>(Arrays.asList(
            "/CategoriaAdmi", "/Vista/Categoriaadmi.jsp",
            "/PagosAdmi", "/Vista/Pagosadmi.jsp",
            "/PanelAdmin", "/PanelAdmin.jsp",
            "/PedidoAdmi", "/Vista/Pedidoadmi.jsp",
            "/ProductoAdmi", "/Vista/Productoadmi.jsp",
            "/RolesAdmi", "/Vista/Rolesadmi.jsp",
            "/Tipodoc", "/Vista/Tipodocumentoadmi.jsp",
            "/Usuario", "/Vista/UsuariosAdmi.jsp",
            "/VarianteAdmi", "/Vista/Varianteadmi.jsp"
    ));

    // Panel exclusivo del repartidor. El admin NO entra aquí — gestiona
    // los pedidos (incluido cambiar su estado en cocina) desde /PedidoAdmi.
    private static final Set<String> RUTAS_SOLO_REPARTIDOR = new HashSet<>(Arrays.asList(
            "/PanelRepartidor", "/PanelRepartidor.jsp"
    ));

    // Panel exclusivo de cocina. Mismo criterio: el admin puede seguir
    // cambiando el estado desde /PedidoAdmi si quiere, pero este panel
    // operativo es solo para el rol Cocina.
    private static final Set<String> RUTAS_SOLO_COCINA = new HashSet<>(Arrays.asList(
            "/PanelCocina", "/PanelCocina.jsp"
    ));

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI();
        String contextPath = req.getContextPath();
        String ruta = path.startsWith(contextPath) ? path.substring(contextPath.length()) : path;

        // Recursos estáticos — siempre permitir
        if (path.endsWith(".css") || path.endsWith(".js")
                || path.endsWith(".png") || path.endsWith(".jpg")
                || path.endsWith(".jpeg") || path.endsWith(".gif")
                || path.endsWith(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        // Rutas de la API JSON (/api/*), usadas por la app de Flutter.
        // Este filtro está pensado para la sesión de navegador (cookies +
        // JSP); un cliente móvil normalmente no mantiene esa sesión entre
        // peticiones. Cada endpoint bajo /api/ hace su propia validación
        // (login/registro son públicos; categorías/productos son de
        // solo lectura pública, igual que el menú web; pedidos valida el
        // idUsuario que manda la app — ver la nota de límite conocido en
        // PedidosApiServlet.java sobre agregar un token por petición).
        if (ruta.startsWith("/api/")) {
            chain.doFilter(request, response);
            return;
        }

        // Páginas y servlets PÚBLICOS (no requieren sesión)
        if (ruta.isEmpty() || ruta.equals("/")
            || path.endsWith("index.jsp")
            || path.endsWith("InicioSesion.jsp")
            || path.endsWith("Registrarse.jsp")
            || path.endsWith("Actividad.jsp")
            || path.endsWith("Historia.jsp")
            || path.endsWith("Menu.jsp")
            || path.endsWith("/Menu")
            || path.endsWith("/Carrito")
            // Todos los enlaces "Mi carrito" del sitio (navbar, footer,
            // botón flotante) apuntan directo a esta página, no al
            // servlet /Carrito. El carrito vive en sesión y es visible
            // sin necesidad de cuenta (vacío para un visitante nuevo);
            // solo AGREGAR un producto exige sesión, y eso ya lo valida
            // CarritoServlet por su cuenta. Antes esta página no estaba
            // en la lista pública, así que cualquiera que hiciera clic
            // en "Mi carrito" sin haber iniciado sesión terminaba
            // redirigido al login, aunque solo quisiera ver el menú.
            || path.endsWith("Carrito.jsp")
            || path.endsWith("PoliticaDatos.jsp")
            || path.endsWith("Reserva.jsp")
            || path.endsWith("Recuperar.jsp")
            || path.contains("CargarRegistro")
            || path.contains("Registrarse")
            || path.contains("Iniciar")
            || path.contains("CerrarSesion")
            || path.contains("RecuperarClave")) {
            chain.doFilter(request, response);
            return;
        }

        // Validar sesión
        if (session == null || session.getAttribute("perfil") == null) {
            res.sendRedirect(contextPath + "/Vista/InicioSesion.jsp");
            return;
        }

        int perfil = (Integer) session.getAttribute("perfil");

        // Token CSRF: uno por sesión, generado la primera vez que hace
        // falta. Todos los formularios de acciones que cambian datos
        // (insertar/actualizar/eliminar en los paneles admin) lo llevan
        // como campo oculto, y cada Servlet lo valida antes de ejecutar
        // la acción. Sin esto, un simple link o una imagen en una página
        // externa podía disparar un "eliminar" usando la sesión ya
        // iniciada del administrador (CSRF).
        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", java.util.UUID.randomUUID().toString());
        }

        // Zona exclusiva de administrador
        if (RUTAS_SOLO_ADMIN.contains(ruta) && perfil != ROL_ADMIN) {
            res.sendRedirect(contextPath + panelSegunRol(perfil));
            return;
        }

        // Zona exclusiva de repartidor. El admin gestiona todo desde
        // /PedidoAdmi (incluido cambiar el estado); no necesita ni debe
        // entrar a este panel operativo del repartidor.
        if (RUTAS_SOLO_REPARTIDOR.contains(ruta) && perfil != ROL_REPARTIDOR) {
            res.sendRedirect(contextPath + panelSegunRol(perfil));
            return;
        }

        // Zona exclusiva de cocina.
        if (RUTAS_SOLO_COCINA.contains(ruta) && perfil != ROL_COCINA) {
            res.sendRedirect(contextPath + panelSegunRol(perfil));
            return;
        }

        // Todo lo demás requiere sesión, sin restricción extra de rol
        // (panel de usuario, carrito, checkout, etc.)
        chain.doFilter(request, response);
    }

    private String panelSegunRol(int perfil) {
        if (perfil == ROL_ADMIN) return "/PanelAdmin";
        if (perfil == ROL_REPARTIDOR) return "/PanelRepartidor";
        if (perfil == ROL_COCINA) return "/PanelCocina";
        return "/PanelUsuario";
    }

    @Override public void init(FilterConfig filterConfig) throws ServletException {}
    @Override public void destroy() {}
}
