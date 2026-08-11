package Servlet;

import Controlador.CategoriaDAO;
import Controlador.ProductoDAO;
import Controlador.Producto_varianteDAO;
import Modelo.Categoria;
import Modelo.Producto;
import Modelo.Producto_variante;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Carga el menú público completo: categorías en orden, los productos
 * de cada una, y las variantes (tamaños/combos) de cada producto que
 * las tenga. Es lo que arma cada sección del menú (Papas Saurios,
 * Sandwich, Alitas BBQ...) en index.jsp / Vista/Menu.jsp.
 */
@WebServlet("/Menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<Categoria, List<Producto>> menuPorCategoria = new LinkedHashMap<>();
        Map<Integer, List<Producto_variante>> variantesPorProducto = new HashMap<>();

        try {
            CategoriaDAO categoriaDAO = new CategoriaDAO();
            ProductoDAO productoDAO = new ProductoDAO();
            Producto_varianteDAO varianteDAO = new Producto_varianteDAO();

            List<Categoria> categorias = categoriaDAO.listarCategorias();
            for (Categoria cat : categorias) {
                List<Producto> productos = productoDAO.listarPorCategoria(cat.getidCategoria());
                menuPorCategoria.put(cat, productos);

                for (Producto p : productos) {
                    List<Producto_variante> variantes = varianteDAO.listarPorProducto(p.getidProducto());
                    if (!variantes.isEmpty()) {
                        variantesPorProducto.put(p.getidProducto(), variantes);
                    }
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo cargar el menú: " + e.getMessage());
        }

        request.setAttribute("menuPorCategoria", menuPorCategoria);
        request.setAttribute("variantesPorProducto", variantesPorProducto);

        request.getRequestDispatcher("/Vista/Menu.jsp").forward(request, response);
    }
}
