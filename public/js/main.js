$(document).ready(function () {
    /** add active class and stay opened when selected */
    var url = window.location;
    // for sidebar menu entirely but not cover treeview
    $('ul.nav-sidebar a').filter(function () {
        return this.href == url;
    }).addClass('active');
    // for treeview
    $('ul.nav-treeview a').filter(function () {
        return this.href == url;
    }).parentsUntil(".nav-sidebar > .nav-treeview").addClass('menu-open').prev('a').addClass('active');
})

window.onbeforeunload = ValidarEstadoLog($("#estatusLog").val());
function ValidarEstadoLog(idLog) {
    if (idLog) {
        var idLogUs = idLog;
        var datos = new FormData();
        datos.append("idUsuario4", idLogUs);
        $.ajax({
            url: "public/views/src/ajaxUsuarios.php",
            method: "POST",
            data: datos,
            cache: false,
            contentType: false,
            processData: false,
            dataType: "json",
            success: function (respuesta) {
                if (respuesta["idEstado"] == 2) {
                    window.location = "logout";
                }
            },
        });
    }
}