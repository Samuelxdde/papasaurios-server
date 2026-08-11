package Controlador;

import java.util.regex.Pattern;

/**
 * Valida la estructura de un correo electrónico.
 *
 * Antes el campo de correo solo tenía `type="email" required` en el HTML,
 * es decir, validación del navegador únicamente. Eso no protege nada: el
 * servlet recibe el parámetro tal cual y lo guarda sin revisarlo, así que
 * cualquier envío que no pase por el formulario (fetch, Postman, un
 * navegador con la validación desactivada, etc.) puede insertar cadenas
 * como "correo", "a@b" o "" en la columna de correo.
 *
 * Este validador se apoya en un patrón razonable para el formato
 * local@dominio.tld: no pretende cubrir el 100% del RFC 5322 (nadie lo
 * hace en la práctica), pero sí rechaza los casos evidentemente inválidos
 * y es el mismo criterio usado en el navegador (JS) y en el servidor.
 */
public class EmailValidator {

    private EmailValidator() {
    }

    // local-part @ dominio . tld (tld de al menos 2 letras)
    private static final Pattern PATRON_CORREO = Pattern.compile(
            "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    private static final int LONGITUD_MAXIMA = 254; // límite práctico de RFC 5321

    /**
     * @param correo correo ingresado
     * @return null si es válido, o un mensaje de error listo para mostrar al usuario
     */
    public static String validar(String correo) {
        if (correo == null || correo.trim().isEmpty()) {
            return "El correo es obligatorio.";
        }
        String valor = correo.trim();
        if (valor.length() > LONGITUD_MAXIMA) {
            return "El correo es demasiado largo.";
        }
        if (!PATRON_CORREO.matcher(valor).matches()) {
            return "El correo no tiene un formato válido (ejemplo: nombre@dominio.com).";
        }
        return null;
    }
}
