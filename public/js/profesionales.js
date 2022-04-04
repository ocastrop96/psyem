$(".datatableProfesionales").DataTable({
    ajax: "public/views/util/datatable-Profesionales.php",
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
$("#rgpDni").attr("minlength", "8");
$("#rgpDni").attr("maxlength", "12");
$("#edtpDni").attr("minlength", "8");
$("#edtpDni").attr("maxlength", "12");
$("#rgpDni").keyup(function () {
    this.value = (this.value + "").replace(/[^0-9]/g, "");
});
$("#rgpCpsp").keyup(function () {
    this.value = (this.value + "").replace(/[^0-9]/g, "");
});
$("#edtpDni").keyup(function () {
    this.value = (this.value + "").replace(/[^0-9]/g, "");
});
$("#edtpCpsp").keyup(function () {
    this.value = (this.value + "").replace(/[^0-9]/g, "");
});
$("#rgpNombres").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#rgpApellidos").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#edtpNombres").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#edtpApellidos").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-ZñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#rgpNombres").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#rgpNombres").val(mu4);
});
$("#rgpApellidos").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#rgpApellidos").val(mu4);
});
$("#edtpNombres").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#edtpNombres").val(mu4);
});
$("#edtpApellidos").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#edtpApellidos").val(mu4);
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
// Validación de campos
$("#btnRegProf").on("click", function () {
    $("#formRegProf").validate({
        rules: {
            rgpCondicion: {
                valueNotEquals: "0",
                required: true,
            },
            rgpDni: {
                required: true,
                maxlength: 12,
                minlength: 8,
            },
            rgpCpsp: {
                required: true,
            },
            rgpNombres: {
                required: true,
            },
            rgpApellidos: {
                required: true,
            },
        },
        messages: {
            rgpCondicion: {
                valueNotEquals: "Seleccione Condición",
                required: "Seleccione condición de profesional",
            },
            rgpDni: {
                required: "DNI Requerido",
                maxlength: "Ingrese máximo 12 dígitos",
                minlength: "Ingrese mínimo 8 dígitos",
            },
            rgpCpsp: {
                required: "CPsP Requerido",
            },
            rgpNombres: {
                required: "Nombres requerido",
            },
            rgpApellidos: {
                required: "Apellidos requerido",
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
$("#btnEdtProf").on("click", function () {
    $("#formEdtProf").validate({
        rules: {
            edtpCondicion: {
                valueNotEquals: "0",
                required: true,
            },
            edtpDni: {
                required: true,
                maxlength: 12,
                minlength: 8,
            },
            edtpCpsp: {
                required: true,
            },
            edtpNombres: {
                required: true,
            },
            edtpApellidos: {
                required: true,
            },
        },
        messages: {
            edtpCondicion: {
                valueNotEquals: "Seleccione Condición",
                required: "Seleccione condición de profesional",
            },
            edtpDni: {
                required: "DNI Requerido",
                maxlength: "Ingrese máximo 12 dígitos",
                minlength: "Ingrese mínimo 8 dígitos",
            },
            edtpCpsp: {
                required: "CPsP Requerido",
            },
            edtpNombres: {
                required: "Nombres requerido",
            },
            edtpApellidos: {
                required: "Apellidos requerido",
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
$("#rgpDni").change(function () {
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
        url: "public/views/src/ajaxProfesionales.php",
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
                $("#rgpDni").val("");
                $("#rgpDni").focus();
                $("#rgpCpsp").val("");
                $("#rgpNombres").val("");
                $("#rgpApellidos").val("");
            } else {
                $("#rgpNombres").val("");
                $("#rgpApellidos").val("");
                $("#btnDNIP").on("click", function () {
                    var dni = $("#rgpDni").val();
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
                                $("#rgpNombres").val(data["nombres"]);
                                $("#rgpApellidos").val(data["apellidoPaterno"] + " " + data["apellidoMaterno"]);
                                $("#rgpCondicion").focus();
                                $("#rgpNombres").prop("readonly", true);
                                $("#rgpApellidos").prop("readonly", true);
                            },
                            failure: function (data) {
                                toastr.info("No se pudo conectar los datos", "DNI");
                            },
                            error: function (data) {
                                $("#rgpNombres").prop("readonly", false);
                                $("#rgpApellidos").prop("readonly", false);
                                $("#rgpDni").focus();
                                $('#formRegProf').trigger("reset");
                            },
                        });
                    }
                });
            }
        },
    });
});
$("#edtpDni").change(function () {
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
        url: "public/views/src/ajaxProfesionales.php",
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
                $("#edtpDni").val("");
                $("#edtpDni").focus();
            } else {
                $("#edtpNombres").val("");
                $("#edtpApellidos").val("");
                $("#btnDNIEdtP").on("click", function () {
                    var dni = $("#edtpDni").val();
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
                                $("#edtpNombres").val(data["nombres"]);
                                $("#edtpApellidos").val(data["apellidoPaterno"] + " " + data["apellidoMaterno"]);
                                $("#edtpCondicion").focus();
                                $("#edtpNombres").prop("readonly", true);
                                $("#edtpApellidos").prop("readonly", true);
                            },
                            failure: function (data) {
                                toastr.info("No se pudo conectar los datos", "DNI");
                            },
                            error: function (data) {
                                $("#edtpNombres").prop("readonly", false);
                                $("#edtpApellidos").prop("readonly", false);
                                $("#edtpDni").focus();
                                $('#formEdtProf').trigger("reset");
                            },
                        });
                    }
                });
            }
        },
    });
});
// Busqueda de Datos por DNI
// Editar Profesional
$(".datatableProfesionales tbody").on("click", ".btnEditarProfesional", function () {
    var idProfesional = $(this).attr("idProfesional");
    var datos = new FormData();
    datos.append("idProfesional", idProfesional);
    $.ajax({
        url: "public/views/src/ajaxProfesionales.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            $("#idProfesional").val(respuesta["idProfesional"]);
            $("#edtpDni").val(respuesta["dniProfesional"]);
            $("#edtpCpsp").val(respuesta["cpspProfesional"]);
            $("#edtpNombres").val(respuesta["nombresProfesional"]);
            $("#edtpApellidos").val(respuesta["apellidosProfesional"]);
            $("#edtpCondicion").val(respuesta["idCondicion"]);
            $("#edtpCondicion").html(respuesta["detaCondicion"]);
        },
    });
});
// Editar Profesional
// Alta y Baja Profesional
$(".datatableProfesionales tbody").on("click", ".btnAltaBajaProf", function () {
    var idProfesional2 = $(this).attr("idProfesional");
    var idEstado = $(this).attr("idEstado");
    var datos = new FormData();
    datos.append("idProfesional2", idProfesional2);
    datos.append("idEstado", idEstado);
    $.ajax({
        url: "public/views/src/ajaxProfesionales.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        success: function (respuesta) {
            if (idEstado == 1) {
                toastr.success("¡El profesional ha sido dado de alta!");
            }
            else {
                toastr.error("¡El profesional ha sido dado de baja!");
            }
        },
    });
    if (idEstado == 2) {
        $(this).removeClass("btn-success");
        $(this).addClass("btn-danger");
        $(this).html('<i class="fas fa-arrow-down"></i>&nbsp; BAJA');
        $(this).attr("idEstado", 1);
    } else {
        $(this).addClass("btn-success");
        $(this).removeClass("btn-danger");
        $(this).html('<i class="fas fa-arrow-up"></i>&nbsp; ALTA');
        $(this).attr("idEstado", 2);
    }
});
// Alta y Baja Profesional
// Eliminar Usuario
$(".datatableProfesionales tbody").on("click", ".btnEliminarProfesional", function () {
    var idProfesional4 = $(this).attr("idProfesional");
    Swal.fire({
        title: "¿Está seguro de eliminar al profesional?",
        text: "¡Si no lo está, puede cancelar la acción!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#343a40",
        cancelButtonColor: "#d33",
        confirmButtonText: "¡Sí, eliminar Profesional!",
        cancelButtonText: "¡No, cancelar",
    }).then(function (result) {
        if (result.value) {
            window.location = "index.php?ruta=profesionales&idProfesional=" + idProfesional4;
        }
    });
});
// Eliminar Usuario