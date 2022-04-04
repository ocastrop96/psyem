$(".datatableDiagnosticos").DataTable({
    ajax: "public/views/util/datatable-Diagnosticos.php",
    deferRender: true,
    retrieve: true,
    processing: true,
    paging: true,
    lengthChange: true,
    searching: true,
    ordering: false,
    info: true,
    autoWidth: false,
    language: {
        url: "public/views/resources/js/dataTables.spanish.lang",
    },
});
// Filtrado de campos
$("#rgdCie").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ.]/g, "");
});
$("#rgdDescripcion").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-Z0-9ñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#edtdDescripcion").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-Z0-9ñÑáéíóúüÁÉÍÓÚÜ ]/g, "");
});
$("#edtdCie").keyup(function () {
    this.value = (this.value + "").replace(/[^a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ.]/g, "");
});
$("#rgdCie").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#rgdCie").val(mu4);
});
$("#edtdCie").keyup(function () {
    var u4 = $(this).val();
    var mu4 = u4.toUpperCase();
    $("#edtdCie").val(mu4);
});
// Filtrado de campos
// Validación de campos
$("#btnRegDiag").on("click", function () {
    $("#formRegDiag").validate({
        rules: {
            rgdCie: {
                required: true,
            },
            rgdDescripcion: {
                required: true,
            },
        },
        messages: {
            rgdCie: {
                required: "CIE 10 requerido",
            },
            rgdDescripcion: {
                required: "Descripción requerida",
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
$("#btnEdtDiag").on("click", function () {
    $("#formEdtDiag").validate({
        rules: {
            edtdCie: {
                required: true,
            },
            edtdDescripcion: {
                required: true,
            },
        },
        messages: {
            edtdCie: {
                required: "CIE 10 requerido",
            },
            edtdDescripcion: {
                required: "Descripción requerida",
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
// Verificar CIE 10 Repetido
$("#rgdCie").change(function () {
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 1500,
    });
    var cie10 = $(this).val();
    var datos = new FormData();
    datos.append("validarCie", cie10);
    $.ajax({
        url: "public/views/src/ajaxDiagnosticos.php",
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
                    title: "El CIE 10 Ingresado ya se encuentra registrado",
                });
                $("#rgdCie").val("");
                $("#rgdCie").focus();
                $("#rgdDescripcion").val("");
            } else {
                $("#rgdDescripcion").val("");
            }
        },
    });
});
$("#edtdCie").change(function () {
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 1500,
    });
    var cie10 = $(this).val();
    var datos = new FormData();
    datos.append("validarCie", cie10);
    $.ajax({
        url: "public/views/src/ajaxDiagnosticos.php",
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
                    title: "El CIE 10 Ingresado ya se encuentra registrado",
                });
                $("#edtdCie").val("");
                $("#edtdCie").focus();
                $("#edtdDescripcion").val("");
            }
        },
    });
});
// Verificar CIE 10 Repetido
// Editar Profesional
$(".datatableDiagnosticos tbody").on("click", ".btnEditarDiagnostico", function () {
    var idDiagnostico = $(this).attr("idDiagnostico");
    var datos = new FormData();
    datos.append("idDiagnostico", idDiagnostico);
    $.ajax({
        url: "public/views/src/ajaxDiagnosticos.php",
        method: "POST",
        data: datos,
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            $("#idDiagnostico").val(respuesta["idDiagnostico"]);
            $("#edtdCie").val(respuesta["cieDiagnostico"]);
            $("#edtdDescripcion").val(respuesta["detaDiagnostico"]);
        },
    });
});
// Editar Profesional
// Eliminar Profesional
$(".datatableDiagnosticos tbody").on("click", ".btnEliminarDiagnostico", function () {
    var idDiagnostico4 = $(this).attr("idDiagnostico");
    Swal.fire({
        title: "¿Está seguro de eliminar al diagnóstico?",
        text: "¡Si no lo está, puede cancelar la acción!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#343a40",
        cancelButtonColor: "#d33",
        confirmButtonText: "¡Sí, eliminar Diagnóstico!",
        cancelButtonText: "¡No, cancelar",
    }).then(function (result) {
        if (result.value) {
            window.location = "index.php?ruta=diagnosticos&idDiagnostico=" + idDiagnostico4;
        }
    });
});
// Eliminar Profesional