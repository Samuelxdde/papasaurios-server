function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('collapsed');
    var main = document.querySelector('.main-content');
    if (main) main.classList.toggle('expanded');
}

function filtrar(tablaId) {
    var input = document.activeElement;
    var filtro = input && input.value ? input.value.toLowerCase() : '';
    var tabla = document.getElementById(tablaId);
    if (!tabla) return;
    var filas = tabla.querySelectorAll('tbody tr');
    filas.forEach(function (fila) {
        fila.style.display = fila.innerText.toLowerCase().includes(filtro) ? '' : 'none';
    });
}

function confirmar() {
    return confirm('¿Estás seguro de realizar esta acción?');
}
