$(".datatableUsuarios").DataTable({
    ajax: "public/views/util/datatable-Usuarios.php",
    deferRender: true,
    retrieve: true,
    processing: true,
    paging: true,
    lengthChange: true,
    searching: true,
    ordering: true,
    order: [
        [4, "asc"]
    ],
    info: true,
    autoWidth: false,
    language: {
        url: "public/views/resources/js/dataTables.spanish.lang",
    },
});
// Filtrado de campos
$("#rgDni").attr("minlength", "8");
$("#rgDni").attr("maxlength", "12");
$("#rgDni").keyup(function () {
    this.value = (this.value + "").replace(/[^0-9]/g, "");
});
$("#rgNombres").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#rgApellidos").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#rgUsuario").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ]/g, "");
});

$("#rgNombres").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#rgNombres").val(mu4);
});
$("#rgApellidos").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#rgApellidos").val(mu4);
});
$("#rgUsuario").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toLowerCase();
    $("#rgUsuario").val(mu4);
});
$("#rgCorreo").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toLowerCase();
    $("#rgCorreo").val(mu4);
});


$("#edtDni").attr("minlength", "8");
$("#edtDni").attr("maxlength", "12");
$("#edtDni").keyup(function () {
    this.value = (this.value + "").replace(/[^0-9]/g, "");
});
$("#edtNombres").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#edtApellidos").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#edtUsuario").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúÁÉÍÓÚ]/g, "");
});

$("#edtNombres").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#rgNombres").val(mu4);
});
$("#edtApellidos").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#edtApellidos").val(mu4);
});
$("#edtUsuario").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toLowerCase();
    $("#edtUsuario").val(mu4);
});
$("#edtCorreo").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toLowerCase();
    $("#edtCorreo").val(mu4);
});
// Filtrado de campos
// Validación de campos
$.validator.addMethod(
    "valueNotEquals",
    function (value, element, arg) {
        return arg !== value;
    },
    "Value must not equal arg."
);
$("#btnRegUsu").on("click", function () {
    $("#formRegUs").validate({
        rules: {
            rgPerfil: {
                valueNotEquals: "0",
                required: true,
            },
            rgDni: {
                required: true,
                maxlength: 12,
                minlength: 8,
            },
            rgNombres: {
                required: true,
            },
            rgApellidos: {
                required: true,
            },
            rgCorreo: {
                required: true,
                email: true,
            },
            rgUsuario: {
                required: true,
            },
            rgClave: {
                required: true,
            },
        },
        messages: {
            rgPerfil: {
                valueNotEquals: "Seleccione Perfil",
                required: "Seleccione perfil de usuario",
            },
            rgDni: {
                required: "DNI Requerido",
                maxlength: "Ingrese máximo 12 dígitos",
                minlength: "Ingrese mínimo 8 dígitos",
            },
            rgNombres: {
                required: "Nombres requerido",
            },
            rgApellidos: {
                required: "Apellidos requerido",
            },
            rgCorreo: {
                required: "Correo requerido",
                email: "Ingrese un correo válido",
            },
            rgUsuario: {
                required: "Cuenta de usuario requerido",
            },
            rgClave: {
                required: "Contraseña requerida",
            },
        },
        errorElement: "span",
        errorPlacement: function (error, element) {
            error.addClass("invalid-feedback");
            element.closest(".form-group").append(error);
        },
        highlight: function (element, errorClass, validClass) {
            $(element).addClass("is-invalid");
        },
        unhighlight: function (element, errorClass, validClass) {
            $(element).removeClass("is-invalid");
        },
    });
});

$("#btnEdtUsu").on("click", function () {
    $("#formEdtUs").validate({
        rules: {
            edtPerfil: {
                valueNotEquals: "0",
                required: true,
            },
            edtDni: {
                required: true,
                maxlength: 12,
                minlength: 8,
            },
            edtNombres: {
                required: true,
            },
            edtApellidos: {
                required: true,
            },
            edtCorreo: {
                required: true,
                email: true,
            },
            edtUsuario: {
                required: true,
            },
        },
        messages: {
            edtPerfil: {
                valueNotEquals: "Seleccione Perfil",
                required: "Seleccione perfil de usuario",
            },
            edtDni: {
                required: "DNI Requerido",
                maxlength: "Ingrese máximo 12 dígitos",
                minlength: "Ingrese mínimo 8 dígitos",
            },
            edtNombres: {
                required: "Nombres requerido",
            },
            edtApellidos: {
                required: "Apellidos requerido",
            },
            edtCorreo: {
                required: "Correo requerido",
                email: "Ingrese un correo válido",
            },
            edtUsuario: {
                required: "Cuenta de usuario requerido",
            },
        },
        errorElement: "span",
        errorPlacement: function (error, element) {
            error.addClass("invalid-feedback");
            element.closest(".form-group").append(error);
        },
        highlight: function (element, errorClass, validClass) {
            $(element).addClass("is-invalid");
        },
        unhighlight: function (element, errorClass, validClass) {
            $(element).removeClass("is-invalid");
        },
    });
});
// Validación de campos

// Busqueda de Datos por DNI
$("#rgDni").change(function () {
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 1500,
    });
    var dni = $(this).val();
    var datos = new FormData();
    datos.append("validarDni", dni);
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
                Toast.fire({
                    icon: "warning",
                    title: "El DNI Ingresado ya se encuentra registrado",
                });
                $("#rgDni").val("");
                $("#rgNombres").val("");
                $("#rgApellidos").val("");
                $("#rgCorreo").val("");
                $("#rgUsuario").val("");
                $("#rgClave").val("");
            } else {
                $("#rgNombres").val("");
                $("#rgApellidos").val("");
                $("#btnDNIU").on("click", function () {
                    var dni = $("#rgDni").val();
                    if (dni.length = 8) {
                        $.ajax({
                            type: "GET",
                            url:
                                "https://dniruc.apisperu.com/api/v1/dni/" +
                                dni +
                                "?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im9jYXN0cm9wLnRpQGdtYWlsLmNvbSJ9.XtrYx8wlARN2XZwOZo6FeLuYDFT6Ljovf7_X943QC_E",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                $("#rgNombres").val(data["nombres"]);
                                $("#rgApellidos").val(data["apellidoPaterno"] + " " + data["apellidoMaterno"]);
                                $("#rgPerfil").focus();
                                $("#rgNombres").prop("readonly", true);
                                $("#rgApellidos").prop("readonly", true);
                            },
                            failure: function (data) {
                                toastr.info("No se pudo conectar los datos", "DNI");
                            },
                            error: function (data) {
                                $("#rgNombres").prop("readonly", false);
                                $("#rgApellidos").prop("readonly", false);
                                $("#rgDni").focus();
                                $('#formRegUs').trigger("reset");
                            },
                        });
                    }
                });
            }
        },
    });
});

$("#edtDni").change(function () {
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 1500,
    });
    var dni = $(this).val();
    var datos = new FormData();
    datos.append("validarDni", dni);
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
                Toast.fire({
                    icon: "warning",
                    title: "El DNI Ingresado ya se encuentra registrado",
                });
                $("#edtDni").val("");
                $("#edtDni").focus();
            } else {
                $("#edtNombres").val("");
                $("#edtApellidos").val("");
                $("#btnDNIUEdt").on("click", function () {
                    var dni = $("#edtDni").val();
                    if (dni.length = 8) {
                        $.ajax({
                            type: "GET",
                            url:
                                "https://dniruc.apisperu.com/api/v1/dni/" +
                                dni +
                                "?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im9jYXN0cm9wLnRpQGdtYWlsLmNvbSJ9.XtrYx8wlARN2XZwOZo6FeLuYDFT6Ljovf7_X943QC_E",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                $("#edtNombres").val(data["nombres"]);
                                $("#edtApellidos").val(data["apellidoPaterno"] + " " + data["apellidoMaterno"]);
                                $("#edtPerfil").focus();
                                $("#edtNombres").prop("readonly", true);
                                $("#edtApellidos").prop("readonly", true);
                            },
                            failure: function (data) {
                                toastr.info("No se pudo conectar los datos", "DNI");
                            },
                            error: function (data) {
                                $("#edtNombres").prop("readonly", false);
                                $("#edtApellidos").prop("readonly", false);
                                $("#edtDni").focus();
                                $('#formEdtUs').trigger("reset");
                            },
                        });
                    }
                });
            }
        },
    });
});
// Busqueda de Datos por DNI
// Editar Usuario
$(".datatableUsuarios tbody").on("click", ".btnEditarUsuario", function () {
    var idUsuario = $(this).attr("idUsuario");
    var datos = new FormData();
    datos.append("idUsuario", idUsuario);
    $.ajax({
        url: "public/views/src/ajaxUsuarios.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            $("#idUsuario").val(respuesta["idUsuario"]);
            $("#edtDni").val(respuesta["dniUsuario"]);
            $("#edtNombres").val(respuesta["nombresUsuario"]);
            $("#edtApellidos").val(respuesta["apellidosUsuario"]);
            $("#edtPerfil").val(respuesta["idPerfil"]);
            $("#edtPerfil").html(respuesta["detallePerfil"]);
            $("#edtCorreo").val(respuesta["correoUsuario"]);
            $("#edtUsuario").val(respuesta["cuentaUsuario"]);
            $("#passActual").val(respuesta["claveUsuario"]);
        },
    });
});
// Editar Usuario
// Habilitacion de Usuario
$(".datatableUsuarios tbody").on("click", ".btnHabilitar", function () {
    var idUsuario2 = $(this).attr("idUsuario");
    var idEstado = $(this).attr("idEstado");
    var datos = new FormData();
    datos.append("idUsuario2", idUsuario2);
    datos.append("idEstado", idEstado);
    $.ajax({
        url: "public/views/src/ajaxUsuarios.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        success: function (respuesta) {
            if (idEstado == 1) {
                toastr.success("¡La cuenta de usuario ha sido habilitada!");
            }
            else {
                toastr.error("¡La cuenta de usuario ha sido inhabilitada!");
            }
        },
    });
    if (idEstado == 2) {
        $(this).removeClass("btn-success");
        $(this).addClass("btn-danger");
        $(this).html('<i class="fas fa-user-minus"></i>INHABILITADO');
        $(this).attr("idEstado", 1);
    } else {
        $(this).addClass("btn-success");
        $(this).removeClass("btn-danger");
        $(this).html('<i class="fas fa-user-check"></i>HABILITADO');
        $(this).attr("idEstado", 2);
    }
});
// Habilitacion de Usuario
// Desbloqueo de Usuario
$(".datatableUsuarios tbody").on("click", ".btnDesbloquearUsuario", function () {
    var idUsuario3 = $(this).attr("idUsuario");
    var datos = new FormData();
    datos.append("idUsuario3", idUsuario3);
    $.ajax({
        url: "public/views/src/ajaxUsuarios.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        success: function (respuesta) {
            toastr.info("¡La cuenta de usuario ha sido desbloqueada!");
        },
    });
});
// Desbloqueo de Usuario
// Eliminar Usuario
$(".datatableUsuarios tbody").on("click", ".btnEliminarUsuario", function () {
    var idUsuario4 = $(this).attr("idUsuario");
    Swal.fire({
        title: "¿Está seguro de eliminar al usuario?",
        text: "¡Si no lo está, puede cancelar la acción!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#343a40",
        cancelButtonColor: "#d33",
        confirmButtonText: "¡Sí, eliminar Usuario!",
        cancelButtonText: "¡No, cancelar",
    }).then(function (result) {
        if (result.value) {
            window.location = "index.php?ruta=usuarios&idUsuario=" + idUsuario4;
        }
    });
});
// Eliminar Usuario