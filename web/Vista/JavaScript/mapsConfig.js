/**
 * Configuración de Google Maps para Papasaurios.
 *
 * ¿QUÉ HAY QUE HACER PARA QUE FUNCIONE EL MAPA EN VIVO?
 * -------------------------------------------------------
 * 1. Entra a https://console.cloud.google.com/google/maps-apis
 * 2. Crea (o usa) un proyecto y activa estas 2 APIs:
 *      - "Maps JavaScript API"
 *      - "Directions API"
 * 3. Crea una API key y pégala abajo, reemplazando el texto
 *    "TU_API_KEY_AQUI".
 * 4. (Recomendado) Restringe esa key por dominio/HTTP referrer para
 *    que nadie más la use desde otro sitio.
 *
 * SIN API KEY el sitio sigue funcionando: en vez del mapa en vivo
 * embebido, tanto el cliente como el repartidor ven un botón que
 * abre la ubicación / la ruta directo en Google Maps (eso sí
 * funciona siempre, sin key, porque es solo un link).
 */
const GOOGLE_MAPS_API_KEY = "AIzaSyBRXAzUXSpptAvYghMVA24pCQ3cBOXwQcM";

function mapsApiKeyConfigurada() {
    return typeof GOOGLE_MAPS_API_KEY === "string"
        && GOOGLE_MAPS_API_KEY.trim() !== ""
        && GOOGLE_MAPS_API_KEY !== "TU_API_KEY_AQUI";
}

/**
 * Carga dinámicamente el script de Google Maps JS (con Directions
 * incluido vía la librería "routes") y ejecuta el callback cuando
 * esté listo. Si ya se cargó antes, ejecuta el callback de una vez.
 */
function cargarGoogleMaps(callback) {
    if (window.google && window.google.maps) {
        callback();
        return;
    }
    const scriptId = "google-maps-script";
    if (document.getElementById(scriptId)) {
        document.getElementById(scriptId).addEventListener("load", callback);
        return;
    }
    const script = document.createElement("script");
    script.id = scriptId;
    script.src = "https://maps.googleapis.com/maps/api/js?key=" + GOOGLE_MAPS_API_KEY;
    script.async = true;
    script.onload = callback;
    document.head.appendChild(script);
}
