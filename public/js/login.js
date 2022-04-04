$("#usuarioLog").focus();
// Filtro de campos
$("#usuarioLog").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toLowerCase();
    $("#usuarioLog").val(mu4);
});
$("#usuarioLog").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ]/g, "");
});
// Filtro de campos
// Validación de campos
function ValidarLogin() {
    var usuarioLog = $("#usuarioLog").val();
    var passwordLog = $("#usuarioPass").val();

    if (usuarioLog.length == 0 || passwordLog.length == 0) {
        Swal.fire({
            icon: "warning",
            title: "Ingrese usuario y contraseña por favor",
            showConfirmButton: false,
            timer: 2000
        });
        return false
    }
}
$("#btnLogin").on("click", function () {
    ValidarLogin()
});
// Validación de campos
// Validacion de cuenta existente
$("#usuarioLog").change(function () {
    var cuenta = $(this).val();
    var datos = new FormData();

    datos.append("validarCuentaLog", cuenta);

    $.ajax({
        url: "public/views/src/ajaxUsuarios.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            if (respuesta) {
                $("#usuarioPass").focus();
                $("#mensajeLog").addClass("d-none");
            } else {
                $("#usuarioLog").val("");
                $("#usuarioLog").focus();
                $("#mensajeLog").removeClass("d-none");
            }
        },
    });
});
// Validacion de cuenta existente