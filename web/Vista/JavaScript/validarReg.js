window.addEventListener("pageshow", function (evento) {
    if (evento.persisted) {
        ocultarCarga();
        ocultarModalLogin();
    }
});

function mostrarCarga(mensaje) {
    const overlay = document.getElementById("overlayCarga");
    if (!overlay) return;
    const texto = overlay.querySelector("[data-texto-carga]");
    if (texto && mensaje) texto.textContent = mensaje;
    overlay.classList.add("activo");
}

function ocultarCarga() {
    const overlay = document.getElementById("overlayCarga");
    if (overlay) overlay.classList.remove("activo");
}

function mostrarModalLogin(mensaje) {
    const overlay = document.getElementById("overlayLogin");
    if (!overlay) return;
    const texto = overlay.querySelector("[data-texto-login]");
    if (texto && mensaje) texto.textContent = mensaje;
    overlay.classList.add("activo");
}

function ocultarModalLogin() {
    const overlay = document.getElementById("overlayLogin");
    if (overlay) overlay.classList.remove("activo");
}

document.addEventListener("click", function (evento) {
    if (evento.target.id === "overlayLogin") {
        ocultarModalLogin();
    }
});

function validarRegistro() {
    const nombre = document.getElementById("nombre").value.trim();
    const apellido = document.getElementById("apellido").value.trim();
    const documento = document.getElementById("documento").value.trim();
    const telefono = document.getElementById("telefono").value.trim();
    const correo = document.getElementById("correo").value.trim();
    const clave = document.getElementById("clave").value.trim();

    // Antes solo se comprobaba que estos campos no vinieran vacíos: el
    // formulario aceptaba nombres como "12345" sin ningún aviso, ni en el
    // navegador ni en el servidor.
    const patronNombre = /^[A-Za-zÀ-ÖØ-öø-ÿ]+([ '-][A-Za-zÀ-ÖØ-öø-ÿ]+)*$/;
    if (nombre === "") {
        alert("El nombre es obligatorio");
        return false;
    }
    if (!patronNombre.test(nombre)) {
        alert("El nombre solo debe contener letras");
        return false;
    }
    if (apellido === "") {
        alert("El apellido es obligatorio");
        return false;
    }
    if (!patronNombre.test(apellido)) {
        alert("El apellido solo debe contener letras");
        return false;
    }
    if (documento === "") {
        alert("El documento es obligatorio");
        return false;
    }
    if (isNaN(documento)) {
        alert("El documento debe ser numérico");
        return false;
    }

    // Antes no se validaba la longitud del documento según el tipo
    // seleccionado: con "Cédula de Ciudadanía" se podía escribir
    // cualquier cantidad de dígitos. El servidor vuelve a validar esto
    // de todas formas (nunca hay que confiar solo en el navegador),
    // pero avisar aquí evita un viaje al servidor para un error obvio.
    const selectTipo = document.getElementById("tipodoc");
    const tipoTexto = selectTipo && selectTipo.selectedOptions.length
        ? selectTipo.selectedOptions[0].text.toLowerCase()
        : "";
    if (tipoTexto.includes("cédula de ciudadanía") || tipoTexto.includes("cedula de ciudadania")) {
        if (documento.length < 6 || documento.length > 10) {
            alert("La cédula de ciudadanía debe tener entre 6 y 10 dígitos");
            return false;
        }
    } else if (tipoTexto.includes("tarjeta de identidad")) {
        if (documento.length < 8 || documento.length > 11) {
            alert("La tarjeta de identidad debe tener entre 8 y 11 dígitos");
            return false;
        }
    }

    // Antes solo se comprobaba que el campo no estuviera vacío: se podía
    // escribir cualquier texto (letras, símbolos) sin ningún aviso, ni
    // aquí ni en el servidor.
    const patronTelefono = /^\+?\d{7,15}$/;
    if (telefono === "") {
        alert("El teléfono es obligatorio");
        return false;
    }
    if (!patronTelefono.test(telefono)) {
        alert("El teléfono solo debe contener números (puede empezar con '+' para el indicativo de país) y tener entre 7 y 15 dígitos");
        return false;
    }
    if (correo === "") {
        alert("El correo es obligatorio");
        return false;
    }
    // Antes solo se comprobaba que el campo no estuviera vacío: el
    // formato en sí lo "validaba" el atributo type="email" del navegador,
    // que es fácil de saltarse (autocompletar, extensiones, navegadores
    // viejos, etc.). El servidor vuelve a validar esto de todas formas,
    // pero avisar aquí evita un viaje al servidor para un error obvio.
    const patronCorreo = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
    if (!patronCorreo.test(correo)) {
        alert("Ingresa un correo con un formato válido (ejemplo: nombre@dominio.com)");
        return false;
    }
    if (clave === "") {
        alert("La contraseña es obligatoria");
        return false;
    }
    mostrarCarga("Creando tu cuenta...");
    return true;
}
function validarLogin() {
    const usuario = document.getElementById("usuario").value.trim();
    const pass = document.getElementById("pass").value.trim();

    if (usuario === "") {
        alert("El documento es obligatorio");
        return false;
    }
    if (isNaN(usuario)) {
        alert("El documento debe ser numérico");
        return false;
    }
    if (pass === "") {
        alert("La clave es obligatoria");
        return false;
    }
    mostrarCarga("Iniciando sesión...");
    return true;
}