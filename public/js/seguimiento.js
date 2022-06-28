$("#deshacer-filtro-Seg").on("click", function () {
    window.location = "seguimiento";
});
$("#rango-seguimiento").daterangepicker({
    ranges: {
        Hoy: [moment(), moment()],
        Ayer: [moment().subtract(1, "days"), moment().subtract(1, "days")],
        "Últimos 7 días": [moment().subtract(6, "days"), moment()],
        "Últimos 30 días": [moment().subtract(29, "days"), moment()],
        "Este mes": [moment().startOf("month"), moment().endOf("month")],
        "Último mes": [
            moment().subtract(1, "month").startOf("month"),
            moment().subtract(1, "month").endOf("month"),
        ],
    },
    startDate: moment(),
    endDate: moment(),
    opens: "right",
    maxSpan: {
        days: 30,
    },
    locale: {
        format: "DD/MM/YYYY",
        separator: " - ",
        applyLabel: "APLICAR",
        cancelLabel: "CANCELAR",
        fromLabel: "Desde",
        toLabel: "Hasta",
        customRangeLabel: "Personalizar",
        weekLabel: "W",
        daysOfWeek: ["Do", "Lu", "Ma", "Mie", "Ju", "Vi", "Sa"],
        monthNames: [
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Agosto",
            "Setiembre",
            "Octubre",
            "Noviembre",
            "Diciembre",
        ],
        firstDay: 1,
    },
},
    function (start, end) {
        $("#daterange-btn span").html(
            start.format("MMMM D, YYYY") + "-" + end.format("MMMM D, YYYY")
        );
        var fechaInicialSeg = start.format("YYYY-MM-DD");
        var fechaFinalSeg = end.format("YYYY-MM-DD");

        var capRangoSeg = $("#daterange-btn span").html();
        localStorage.setItem("capRangoSeg", capRangoSeg);
        window.location =
            "index.php?ruta=seguimiento&fechaInicialSeg=" +
            fechaInicialSeg +
            "&fechaFinalSeg=" +
            fechaFinalSeg;
        let timerInterval;
        Swal.fire({
            title: "Se está cargando la información",
            html: "Espere por favor...",
            timer: 7000,
            timerProgressBar: true,
            onBeforeOpen: () => {
                Swal.showLoading();
                timerInterval = setInterval(() => {
                    const content = Swal.getContent();
                    if (content) {
                        const b = content.querySelector("b");
                        if (b) {
                            b.textContent = Swal.getTimerLeft();
                        }
                    }
                }, 100);
            },
            onClose: () => {
                clearInterval(timerInterval);
            },
        }).then((result) => {
            if (result.dismiss === Swal.DismissReason.timer) {
            }
        });
    }
);
$(".daterangepicker.opensright .drp-buttons .cancelBtn").on(
    "click",
    function () {
        localStorage.removeItem("capRangoSeg");
        localStorage.clear();
        window.location = "seguimiento";
        let timerInterval;
        Swal.fire({
            title: "Se está cargando la información",
            html: "Espere por favor...",
            timer: 7000,
            timerProgressBar: true,
            onBeforeOpen: () => {
                Swal.showLoading();
                timerInterval = setInterval(() => {
                    const content = Swal.getContent();
                    if (content) {
                        const b = content.querySelector("b");
                        if (b) {
                            b.textContent = Swal.getTimerLeft();
                        }
                    }
                }, 100);
            },
            onClose: () => {
                clearInterval(timerInterval);
            },
        }).then((result) => {
            /* Read more about handling dismissals below */
            if (result.dismiss === Swal.DismissReason.timer) {
                console.log("I was closed by the timer");
            }
        });
    }
);
$(".daterangepicker.opensright .ranges li").on("click", function () {
    var textoHoy = $(this).attr("data-range-key");

    if (textoHoy == "Hoy") {
        var d = new Date();

        var dia = d.getDate();
        var mes = d.getMonth() + 1;
        var año = d.getFullYear();
        dia = ("0" + dia).slice(-2);
        mes = ("0" + mes).slice(-2);

        var fechaInicialSeg = año + "-" + mes + "-" + dia;
        var fechaFinalSeg = año + "-" + mes + "-" + dia;

        localStorage.setItem("capRangoSeg", "Hoy");

        window.location =
            "index.php?ruta=seguimiento&fechaInicialSeg=" +
            fechaInicialSeg +
            "&fechaFinalSeg=" +
            fechaFinalSeg;
        let timerInterval;
        Swal.fire({
            title: "Se está cargando la información",
            html: "Espere por favor...",
            timer: 7000,
            timerProgressBar: true,
            onBeforeOpen: () => {
                Swal.showLoading();
                timerInterval = setInterval(() => {
                    const content = Swal.getContent();
                    if (content) {
                        const b = content.querySelector("b");
                        if (b) {
                            b.textContent = Swal.getTimerLeft();
                        }
                    }
                }, 100);
            },
            onClose: () => {
                clearInterval(timerInterval);
            },
        }).then((result) => {
            /* Read more about handling dismissals below */
            if (result.dismiss === Swal.DismissReason.timer) {
                console.log("I was closed by the timer");
            }
        });
    }
});
$(".datatableSeguimiento").DataTable({
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
$("#rgSegObs").keyup(function () {
    var st4 = $(this).val();
    var mayust4 = st4.toUpperCase();
    $("#rgSegObs").val(mayust4);
});
$("#edtSegObs").keyup(function () {
    var st4 = $(this).val();
    var mayust4 = st4.toUpperCase();
    $("#edtSegObs").val(mayust4);
});
$("#rgSegPac").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando..";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese N° de DNI,CE,PASS o Nombres del Paciente',
        ajax: {
            url: "public/views/src/ajaxFamiliares.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm2: params.term,
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$("#edtSegPac").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando..";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese N° de DNI,CE,PASS o Nombres del Paciente',
        ajax: {
            url: "public/views/src/ajaxFamiliares.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm2: params.term,
                };
            },
            processResults: function (response) {
                $("#seleccionActual2").remove();
                $("#seleccionActual21").remove();
                $("#seleccionActual3").remove();
                $("#seleccionActual31").remove();


                $("#seleccionActual27").remove();
                $("#seleccionActual272").remove();

                $("#seleccionActual28").remove();
                $("#seleccionActual282").remove();

                $("#seleccionActual40").remove();
                $("#seleccionActual401").remove();

                $("#seleccionActual41").remove();
                $("#seleccionActual411").remove();



                $("#idFamAnt").val("0");
                $("#edtSegDf11").val("0");
                $("#edtSegDf11").html("Seleccione Diagnóstico");
                $("#edtSegDf21").val("0");
                $("#edtSegDf21").html("Seleccione Diagnóstico o Actividad (Opcional)");


                $("#edtSegDf31").val("0");
                $("#edtSegDf31").html("Seleccione Diagnóstico o Actividad (Opcional)");

                $("#edtSegDf41").val("0");
                $("#edtSegDf41").html("Seleccione Diagnóstico o Actividad (Opcional)");

                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".rgSegDp1").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm: params.term,
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);

$(".edtSegDp1").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm: params.term,
                };
            },
            processResults: function (response) {
                $("#seleccionActual25").addClass("d-none");
                $("#seleccionActual252").addClass("d-none");

                $("#seleccionActual26").addClass("d-none");
                $("#seleccionActual262").addClass("d-none");

                $("#seleccionActual30").addClass("d-none");
                $("#seleccionActual302").addClass("d-none");

                $("#seleccionActual312").addClass("d-none");
                $("#seleccionActual3121").addClass("d-none");

                // $(".edtSegDp2").empty().trigger('change');
                // $(".edtSegDp3").empty().trigger('change');
                // $(".edtSegDp4").empty().trigger('change');

                $("#edtSegDp21").val("0");
                $("#edtSegDp21").html("Seleccione Diagnóstico o Actividad (Opcional)");

                $("#edtSegDp31").val("0");
                $("#edtSegDp31").html("Seleccione Diagnóstico o Actividad (Opcional)");

                $("#edtSegDp41").val("0");
                $("#edtSegDp41").html("Seleccione Diagnóstico o Actividad (Opcional)");

                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".rgSegDp2").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm2: params.term,
                    excluido: $("#rgSegDp1").val(),
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
// Busqueda de tercer diagnostico
$(".rgSegDp3").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm3: params.term,
                    excluido: $("#rgSegDp1").val(),
                    excluido2: $("#rgSegDp2").val(),

                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);

$(".rgSegDf3").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm3: params.term,
                    excluido: $("#rgSegDf1").val(),
                    excluido2: $("#rgSegDf2").val(),

                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
// Busqueda de tercer diagnostico

// Busqueda de cuarto diagnostico
$(".rgSegDp4").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm4: params.term,
                    excluido: $("#rgSegDp1").val(),
                    excluido2: $("#rgSegDp2").val(),
                    excluido3: $("#rgSegDp3").val(),
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".rgSegDf4").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm4: params.term,
                    excluido: $("#rgSegDf1").val(),
                    excluido2: $("#rgSegDf2").val(),
                    excluido3: $("#rgSegDf3").val(),
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
// Busqueda de cuarto diagnostico
$(".edtSegDp2").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm2: params.term,
                    excluido: $("#edtSegDp1").val(),
                };
            },
            processResults: function (response) {
                $("#seleccionActual26").addClass("d-none");
                $("#seleccionActual262").addClass("d-none");

                $("#seleccionActual30").addClass("d-none");
                $("#seleccionActual302").addClass("d-none");

                $("#seleccionActual312").addClass("d-none");
                $("#seleccionActual3121").addClass("d-none");

                // $(".edtSegDp3").empty().trigger('change');
                // $(".edtSegDp4").empty().trigger('change');

                $("#edtSegDp31").val("0");
                $("#edtSegDp31").html("Seleccione Diagnóstico o Actividad (Opcional)");

                $("#edtSegDp41").val("0");
                $("#edtSegDp41").html("Seleccione Diagnóstico o Actividad (Opcional)");
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".edtSegDp3").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Opcional ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm3: params.term,
                    excluido: $("#edtSegDp1").val(),
                    excluido2: $("#edtSegDp2").val(),
                };
            },
            processResults: function (response) {

                $("#seleccionActual30").addClass("d-none");
                $("#seleccionActual302").addClass("d-none");

                $("#seleccionActual312").addClass("d-none");
                $("#seleccionActual3121").addClass("d-none");

                // $(".edtSegDp4").empty().trigger('change');

                $("#edtSegDp41").val("0");
                $("#edtSegDp41").html("Seleccione Diagnóstico o Actividad (Opcional)");

                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".edtSegDp4").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Opcional ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm4: params.term,
                    excluido: $("#edtSegDp1").val(),
                    excluido2: $("#edtSegDp2").val(),
                    excluido3: $("#edtSegDp3").val(),
                };
            },
            processResults: function (response) {

                $("#seleccionActual312").addClass("d-none");
                $("#seleccionActual3121").addClass("d-none");

                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);



$(".rgSegDf1").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm: params.term,
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".edtSegDf1").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm: params.term,
                };
            },
            processResults: function (response) {
                $("#seleccionActual27").addClass("d-none");
                $("#seleccionActual272").addClass("d-none");

                $("#seleccionActual28").addClass("d-none");
                $("#seleccionActual282").addClass("d-none");


                $("#seleccionActual40").addClass("d-none");
                $("#seleccionActual401").addClass("d-none");

                $("#seleccionActual41").addClass("d-none");
                $("#seleccionActual411").addClass("d-none");

                // $(".edtSegDf2").empty().trigger('change');
                $("#edtSegDf21").val("0");
                $("#edtSegDf21").html("Seleccione Diagnóstico o Actividad (Opcional)");

                // $(".edtSegDf3").empty().trigger('change');
                $("#edtSegDf31").val("0");
                $("#edtSegDf31").html("Seleccione Diagnóstico o Actividad (Opcional)");

                // $(".edtSegDf4").empty().trigger('change');
                $("#edtSegDf41").val("0");
                $("#edtSegDf41").html("Seleccione Diagnóstico o Actividad (Opcional)");
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);
$(".rgSegDf2").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm2: params.term,
                    excluido: $("#rgSegDf1").val(),
                };
            },
            processResults: function (response) {
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);

$(".edtSegDf2").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Principal ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm2: params.term,
                    excluido: $("#edtSegDf1").val(),
                };
            },
            processResults: function (response) {

                $("#seleccionActual28").addClass("d-none");
                $("#seleccionActual282").addClass("d-none");


                $("#seleccionActual40").addClass("d-none");
                $("#seleccionActual401").addClass("d-none");

                $("#seleccionActual41").addClass("d-none");
                $("#seleccionActual411").addClass("d-none");

                // $(".edtSegDf3").empty().trigger('change');
                $("#edtSegDf31").val("0");
                $("#edtSegDf31").html("Seleccione Diagnóstico o Actividad (Opcional)");

                // $(".edtSegDf4").empty().trigger('change');
                $("#edtSegDf41").val("0");
                $("#edtSegDf41").html("Seleccione Diagnóstico o Actividad (Opcional)");
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);



$(".edtSegDf3").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Opcional ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm3: params.term,
                    excluido: $("#edtSegDf1").val(),
                    excluido2: $("#edtSegDf2").val(),

                };
            },
            processResults: function (response) {


                $("#seleccionActual40").addClass("d-none");
                $("#seleccionActual401").addClass("d-none");

                $("#seleccionActual41").addClass("d-none");
                $("#seleccionActual411").addClass("d-none");

                // $(".edtSegDf3").empty().trigger('change');
                // $("#edtSegDf3").val("0");
                // $("#edtSegDf3").html("Seleccione Diagnóstico o Actividad (Opcional)");

                // $(".edtSegDf4").empty().trigger('change');
                $("#edtSegDf41").val("0");
                $("#edtSegDf41").html("Seleccione Diagnóstico o Actividad (Opcional)");
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);


$(".edtSegDf4").select2(
    {
        maximumInputLength: "12",
        minimumInputLength: "2",
        language: {

            noResults: function () {

                return "No hay resultado";
            },
            searching: function () {

                return "Buscando Diagnóstico Opcional ...";
            },
            inputTooShort: function () {
                return "Ingrese 2 o más caracteres";
            },
            inputTooLong: function () {
                return "Ingrese máximo 12 caracteres";
            }
        },
        scrollAfterSelect: true,
        placeholder: 'Ingrese CIE 10 o Descripción del Dx',
        ajax: {
            url: "public/views/src/ajaxDiagnosticos.php",
            type: "post",
            dataType: "json",
            delay: 200,
            data: function (params) {
                return {
                    searchTerm4: params.term,
                    excluido: $("#edtSegDf1").val(),
                    excluido2: $("#edtSegDf2").val(),
                    excluido3: $("#edtSegDf3").val(),


                };
            },
            processResults: function (response) {

                $("#seleccionActual41").addClass("d-none");
                $("#seleccionActual411").addClass("d-none");

                $(".edtSegDf4").empty().trigger('change');
                $("#edtSegDf4").val("0");
                $("#edtSegDf4").html("Seleccione Diagnóstico o Actividad (Opcional)");
                return {
                    results: response,
                };
            },
            cache: true,
        },
    }
);

$("#rgSegFec").inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' });
$('#rgSegFec').datepicker({
    'format': 'dd/mm/yyyy',
    'autoclose': true,
    'language': 'es',
    'endDate': new Date(),
});
$("#edtSegFec").inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' });
$('#edtSegFec').datepicker({
    'format': 'dd/mm/yyyy',
    'autoclose': true,
    'language': 'es',
    'endDate': new Date(),
});
// Condicionales para mostrar bloques
$("#rgSegTip").on("change", function () {
    // $("#tipSeg").prop("disabled", true);
    let comboTipSeg = $(this).val();
    if (comboTipSeg > 0) {
        if (comboTipSeg == 1 || comboTipSeg == 2) {
            $("#bloqueComFam").removeClass("d-none");
            $("#comSi").prop("checked", true);
            $("#comFami").val("SI");
        }
        else {
            $("#bloqueComFam").addClass("d-none");
            $("#comNo").prop("checked", true);
            $("#comFami").val("NO");
        }
    }
    else {
        $("#comNo").prop("checked", true);
        $("#comFami").val("NO");
        $("#bloqueComFam").addClass("d-none");
    }
});
$("#edtSegTip").on("change", function () {
    // $("#tipSeg").prop("disabled", true);
    let comboTipSeg = $(this).val();
    if (comboTipSeg > 0) {
        if (comboTipSeg == 1 || comboTipSeg == 2) {
            $("#bloqueComFam1").removeClass("d-none");
            $("#block11").removeClass("d-none");
            $("#comSi1").prop("checked", true);
            $("#comFami1").val("SI");
        }
        else {
            $("#bloqueComFam1").addClass("d-none");
            $("#comNo1").prop("checked", true);
            $("#comFami1").val("NO");
        }
    }
    else {
        $("#comNo1").prop("checked", true);
        $("#comFami1").val("NO");
        $("#bloqueComFam1").addClass("d-none");
    }
});
// Condicionales para mostrar bloques
// COMUNICA FAMILIAR
$("#comSi").click(function () {
    if ($("#comSi").is(":checked")) {
        let temEtiqueta = "<option value='0'>Seleccione Dx o Actividad</option>";

        $("#comFami").val("SI");
        $("#block1").removeClass("d-none");
        $("#rgSegFam")[0].selectedIndex = 0;
        $("#rgSegDf1").empty().trigger('change')
        $("#rgSegDf1")[0].selectedIndex = 0;
        $("#rgSegDf2").empty().trigger('change')
        $("#rgSegDf2")[0].selectedIndex = 0;

        $("#rgSegDf3").empty().trigger('change')
        $("#rgSegDf3")[0].selectedIndex = 0;
        $("#rgSegDf4").empty().trigger('change')
        $("#rgSegDf4")[0].selectedIndex = 0;

        $("#rgSegDf1").html(temEtiqueta);
        $("#rgSegDf2").html(temEtiqueta);
        $("#rgSegDf3").html(temEtiqueta);
        $("#rgSegDf4").html(temEtiqueta);

    } else {
        $("#comFami").val("NO");
    }
});
$("#comNo").click(function () {
    if ($("#comNo").is(":checked")) {
        let temEtiqueta = "<option value='0'>Seleccione Dx o Actividad</option>";

        $("#comFami").val("NO");
        $("#block1").addClass("d-none");

        $("#rgSegFam")[0].selectedIndex = 0;

        $("#rgSegDf1").empty().trigger('change')
        $("#rgSegDf1")[0].selectedIndex = 0;
        $("#rgSegDf1").html(temEtiqueta);

        $("#rgSegDf2").empty().trigger('change')
        $("#rgSegDf2")[0].selectedIndex = 0;
        $("#rgSegDf2").html(temEtiqueta);

        $("#rgSegDf3").empty().trigger('change')
        $("#rgSegDf3")[0].selectedIndex = 0;
        $("#rgSegDf3").html(temEtiqueta);

        $("#rgSegDf4").empty().trigger('change')
        $("#rgSegDf4")[0].selectedIndex = 0;
        $("#rgSegDf4").html(temEtiqueta);



    } else {
        $("#comFami").val("SI");
    }
});
// COMUNICA FAMILIAR
$("#comSi1").click(function () {
    if ($("#comSi1").is(":checked")) {
        $("#comFami1").val("SI");
        $("#block11").removeClass("d-none");
        $("#edtSegFam")[0].selectedIndex = 0;
        $("#edtSegDf1")[0].selectedIndex = 0;
        $("#edtSegDf2")[0].selectedIndex = 0;
        $("#edtSegDf3")[0].selectedIndex = 0;
        $("#edtSegDf4")[0].selectedIndex = 0;
    } else {
        $("#comFami1").val("NO");
    }
});
$("#comNo1").click(function () {
    if ($("#comNo1").is(":checked")) {
        let temEtiqueta = "<option value='0'>Seleccione Dx o Actividad</option>";
        $("#comFami1").val("NO");
        $("#block11").addClass("d-none");

        $("#edtSegFam")[0].selectedIndex = 0;

        // $("#edtSegDf1").empty().trigger('change')
        $("#edtSegDf1")[0].selectedIndex = 0;
        $("#edtSegDf1").html(temEtiqueta);

        // $("#edtSegDf2").empty().trigger('change')
        $("#edtSegDf2")[0].selectedIndex = 0;
        $("#edtSegDf2").html(temEtiqueta);

        // $("#edtSegDf3").empty().trigger('change')
        $("#edtSegDf3")[0].selectedIndex = 0;
        $("#edtSegDf3").html(temEtiqueta);

        // $("#edtSegDf4").empty().trigger('change')
        $("#edtSegDf4")[0].selectedIndex = 0;
        $("#edtSegDf4").html(temEtiqueta);


        $("#seleccionActual3").addClass("d-none");
        $("#seleccionActual31").addClass("d-none");


        $("#seleccionActual27").addClass("d-none");
        $("#seleccionActual272").addClass("d-none");

        $("#seleccionActual28").addClass("d-none");
        $("#seleccionActual282").addClass("d-none");


        $("#seleccionActual40").addClass("d-none");
        $("#seleccionActual401").addClass("d-none");

        $("#seleccionActual41").addClass("d-none");
        $("#seleccionActual411").addClass("d-none");


    } else {
        $("#comFami").val("SI");
    }
});
// COMUNICA FAMILIAR
// DIAGNOSTICOS Y ACTIVIDADES
$("#rgSegDp1").on("change", function () {
    var existe = $(this).val();
    $("#rgSegDp2")[0].selectedIndex = 0;
    if (existe > 0) {
        $.ajax({
            url: "public/views/src/ajaxDiagnosticos.php",
            method: "POST",
            dataType: "html",
            data: { existe: existe }
        }).done(function (respuesta) {
            $("#rgSegDp2").html(respuesta);
        }).fail(function () {
            console.log("error");
        });
    }
    else {
        var errorhtml = "<option value='0'>No hay actividades existentes</option>";
        $("#rgSegDp2").html(errorhtml);
    }
});

$("#rgSegDf1").on("change", function () {
    var existe2 = $(this).val();
    $("#rgSegDf2")[0].selectedIndex = 0;
    if (existe2 > 0) {
        $.ajax({
            url: "public/views/src/ajaxDiagnosticos.php",
            method: "POST",
            dataType: "html",
            data: { existe: existe2 }
        }).done(function (respuesta) {
            $("#rgSegDf2").html(respuesta);
        }).fail(function () {
            console.log("error");
        });
    }
    else {
        var errorhtml = "<option value='0'>No hay actividades existentes</option>";
        $("#rgSegDf2").html(errorhtml);
    }
});
// DIAGNOSTICOS Y ACTIVIDADES
// Listar Familiares
$("#rgSegPac").on("change", function () {
    var atencion = $(this).val();
    $("#rgSegFam")[0].selectedIndex = 0;
    if (atencion > 0) {
        $.ajax({
            url: "public/views/src/ajaxFamiliares.php",
            method: "POST",
            dataType: "html",
            data: { atencion: atencion }
        }).done(function (respuesta) {
            $("#rgSegFam").html(respuesta);
        }).fail(function () {
            console.log("error");
        });
    }
});
// Listar Familiares
// Validación de campos
$("#btnRegSeg").on("click", function () {
    var tipoS = $("#rgSegTip").val();

    if (tipoS == 1) {
        $("#formRegSeg").validate({
            rules: {
                rgSegFec: {
                    required: true,
                },
                rgSegTip: {
                    valueNotEquals: "0",
                },
                rgSegProf: {
                    valueNotEquals: "0",
                },
                rgSegMot: {
                    valueNotEquals: "0",
                },
                rgSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegDp1: {
                    valueNotEquals: "0",
                },
                rgSegFam: {
                    valueNotEquals: "0",
                },
                rgSegDf1: {
                    valueNotEquals: "0",
                },
            },
            messages: {

                rgSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                rgSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                rgSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                rgSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                rgSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                rgSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
                },
                rgSegFam: {
                    valueNotEquals: "Seleccione Familiar",
                },
                rgSegDf1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
    if ($("#comSi").is(":checked")) {
        $("#formRegSeg").validate({
            rules: {
                rgSegFec: {
                    required: true,
                },
                rgSegTip: {
                    valueNotEquals: "0",
                },
                rgSegProf: {
                    valueNotEquals: "0",
                },
                rgSegMot: {
                    valueNotEquals: "0",
                },
                rgSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegDp1: {
                    valueNotEquals: "0",
                },
            },
            messages: {
                rgSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                rgSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                rgSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                rgSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                rgSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                rgSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
    else if (tipoS == 2) {
        $("#formRegSeg").validate({
            rules: {
                rgSegFec: {
                    required: true,
                },
                rgSegTip: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegProf: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegMot: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegDp1: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegFam: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegDf1: {
                    valueNotEquals: "0",
                    required: true,
                },
            },
            messages: {
                rgSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                rgSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                    required: "Seleccione una opción",
                },
                rgSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                rgSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                    required: "Seleccione una opción",
                },
                rgSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                rgSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
                    required: "Seleccione una opción",
                },
                rgSegFam: {
                    valueNotEquals: "Seleccione Familiar",
                    required: "Seleccione una opción",
                },
                rgSegDf1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
                    required: "Seleccione una opción",
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
    }
    else {
        $("#formRegSeg").validate({
            rules: {
                rgSegFec: {
                    required: true,
                },
                rgSegTip: {
                    valueNotEquals: "0",
                },
                rgSegProf: {
                    valueNotEquals: "0",
                },
                rgSegMot: {
                    valueNotEquals: "0",
                },
                rgSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                rgSegDp1: {
                    valueNotEquals: "0",
                },
            },
            messages: {
                rgSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                rgSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                rgSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                rgSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                rgSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                rgSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
});
// Validación de campos
// Editar Seguimiento
$(".datatableSeguimiento tbody").on("click", ".btnEditarSeguimiento", function () {
    var idSeguimiento = $(this).attr("idSeguimiento");
    var idProfesional = $(this).attr("idProfesional");
    var idProfesional2 = $("#idProfH").val();

    // Ocultar etiquetas en el caso de no encontrar valores alternativos
    $("#seleccionActual26").addClass("d-none");
    $("#seleccionActual27").addClass("d-none");
    $("#seleccionActual28").addClass("d-none");
    $("#seleccionActual30").addClass("d-none");
    $("#seleccionActual312").addClass("d-none");
    $("#seleccionActual40").addClass("d-none"); 
    $("#seleccionActual41").addClass("d-none");



    // Ocultar etiquetas en el caso de no encontrar valores alternativos

    if (idProfesional2 != 0) {
        if (idProfesional == idProfesional2) {
            var datos = new FormData();
            datos.append("idSeguimiento", idSeguimiento);
            $.ajax({
                url: "public/views/src/ajaxSeguimientos.php",
                method: "POST",
                data: datos,
                cache: false,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (respuesta) {
                    $("#idSeguimiento").val(respuesta["idSeguimiento"]);
                    $("#edtSegObs").val(respuesta["obsSeg"]);
                    $("#edtSegFec").val(respuesta["fRegistrSeg"]);
                    $("#edtSegProf").val(respuesta["idProfesional"]);
                    $("#s2").val(respuesta["nombresProfesional"] + " " + respuesta["apellidosProfesional"]);
                    $("#edtSegTip1").val(respuesta["idTipoSeguimiento"]);
                    $("#edtSegTip1").html(respuesta["detaTipSeguimiento"]);
                    $("#edtSegMot1").val(respuesta["idMotSeguimiento"]);
                    $("#edtSegMot1").html(respuesta["detaMotivoSef"]);

                    $("#seleccionActual21").html(respuesta["cuentaAtencion"] + " - " + respuesta["tipdocAtencion"] + "-" + respuesta["nrodocAtencion"] + " - " + respuesta["nombAtencion"] + " " + respuesta["apPaternoAtencion"] + " " + respuesta["apMaternoAtencion"]);


                    $("#edtSegPac1").val(respuesta["idAtencionPac"]);
                    $("#edtSegPac1").html(respuesta["cuentaAtencion"] + " || " + respuesta["tipdocAtencion"] + "-" + respuesta["nrodocAtencion"] + " - " + respuesta["nombAtencion"] + " " + respuesta["apPaternoAtencion"] + " " + respuesta["apMaternoAtencion"]);
                    // Condicionales en caso del tipo de tipSeguimiento
                    var tipSeguimiento = respuesta["idTipoSeguimiento"];
                    if (tipSeguimiento == 1 || tipSeguimiento == 2) {
                        $("#bloqueComFam1").removeClass("d-none");
                    }
                    else {
                        $("#bloqueComFam1").addClass("d-none");
                    }
                    if (respuesta["comunFamSeg"] == "SI") {
                        $("#block11").removeClass("d-none");
                        $("#comSi1").prop("checked", true);
                        $("#comFami1").val("SI");
                    }
                    else {
                        $("#block11").addClass("d-none");
                        $("#comNo1").prop("checked", true);
                        $("#comFami1").val("NO");
                    }
                    // Condicionales en caso del tipo de tipSeguimiento
                    // Condiciones para diagnosticos
                    if (respuesta["idDiag1Seg"] != 0) {
                        $("#edtSegDp11").val(respuesta["idDiag1Seg"]);
                        $("#edtSegDp11").html(respuesta["cieP1"] + " - " + respuesta["detaD1"]);

                        let base = respuesta["detaD1"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual252").html(respuesta["cieP1"] + " || " + recorte);
                    }
                    if (respuesta["idDiag2Seg"] != 0) {
                        $("#seleccionActual26").removeClass("d-none");

                        $("#edtSegDp21").val(respuesta["idDiag2Seg"]);
                        $("#edtSegDp21").html(respuesta["cieP2"] + " - " + respuesta["detD2"]);

                        let base = respuesta["detD2"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual262").html(respuesta["cieP2"] + " || " + recorte);
                    }


                    if (respuesta["idDiag3Seg"] != 0) {
                        $("#seleccionActual30").removeClass("d-none");

                        $("#edtSegDp31").val(respuesta["idDiag3Seg"]);
                        $("#edtSegDp31").html(respuesta["cieP3"] + " - " + respuesta["detD3"]);

                        let base = respuesta["detD3"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual302").html(respuesta["cieP3"] + " || " + recorte);
                    }

                    if (respuesta["idDiag4Seg"] != 0) {
                        $("#seleccionActual312").removeClass("d-none");

                        $("#edtSegDp41").val(respuesta["idDiag4Seg"]);
                        $("#edtSegDp41").html(respuesta["cieP4"] + " - " + respuesta["detD4"]);

                        let base = respuesta["detD4"];
                        let recorte = base.substring(0, 55);

                        $("#seleccionActual3121").html(respuesta["cieP4"] + " || " + recorte);
                    }

                    if (respuesta["idDiag1SegFam"] != 0) {
                        $("#seleccionActual27").removeClass("d-none");

                        $("#edtSegDf11").val(respuesta["idDiag1SegFam"]);
                        $("#edtSegDf11").html(respuesta["cieDF1"] + " - " + respuesta["detDF1"]);

                        let base = respuesta["detDF1"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual272").html(respuesta["cieDF1"] + " || " + recorte);
                    }
                    else {
                        $("#edtSegDf11").val("0");
                        $("#edtSegDf11").html("Seleccione Diagnóstico");
                    }
                    if (respuesta["idDiag2SegFam"] != 0) {
                        $("#seleccionActual28").removeClass("d-none");

                        $("#edtSegDf21").val(respuesta["idDiag2SegFam"]);
                        $("#edtSegDf21").html(respuesta["cieDF2"] + " - " + respuesta["detDF2"]);
                        let base = respuesta["detDF2"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual282").html(respuesta["cieDF2"] + " || " + recorte);
                    }

                    if (respuesta["idDiag3SegFam"] != 0) {
                        $("#seleccionActual40").removeClass("d-none");

                        $("#edtSegDf31").val(respuesta["idDiag3SegFam"]);
                        $("#edtSegDf31").html(respuesta["cieDF3"] + " - " + respuesta["detDF3"]);
                        let base = respuesta["detDF3"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual401").html(respuesta["cieDF3"] + " || " + recorte);
                    }

                    if (respuesta["idDiag4SegFam"] != 0) {
                        $("#seleccionActual41").removeClass("d-none");

                        $("#edtSegDf41").val(respuesta["idDiag4SegFam"]);
                        $("#edtSegDf41").html(respuesta["cieDF4"] + " - " + respuesta["detDF4"]);
                        let base = respuesta["detDF4"];
                        let recorte = base.substring(0, 60);

                        $("#seleccionActual411").html(respuesta["cieDF4"] + " || " + recorte);
                    }

                    // Condiciones para diagnosticos
                    $("#idFamAnt").val(respuesta["idFamAtSeg"]);
                    if (respuesta["idFamAtSeg"] != 0) {
                        $("#seleccionActual31").html(respuesta["nombApFamiliar"] + " - " + respuesta["detaParentesco"] + "  " + respuesta["telcelFamiliar"]);
                    }
                    else {
                        $("#seleccionActual31").html("");
                    }
                    var atencion = respuesta["idAtencionPac"];
                    $("#edtSegFam")[0].selectedIndex = 0;
                    $.ajax({
                        url: "public/views/src/ajaxFamiliares.php",
                        method: "POST",
                        dataType: "html",
                        data: { atencion: atencion }
                    }).done(function (respuesta) {
                        $("#edtSegFam").html(respuesta);
                    }).fail(function () {
                        console.log("error");
                    });
                },
            });
            $("#modal-editar-seguimiento").modal("show");
        }
        else {
            Swal.fire({
                icon: "error",
                title: "No tienes permiso para editar el seguimiento seleccionado",
                showConfirmButton: false,
                timer: 1600
            });
            $("#modal-editar-seguimiento").modal("hide");

        }
    }
    else {
        $("#modal-editar-seguimiento").modal("hide");
        Swal.fire({
            icon: "error",
            title: "No tienes permiso para editar el seguimiento seleccionado",
            showConfirmButton: false,
            timer: 1600
        });
    }
});
$("#edtSegPac").on("change", function () {
    var atencion = $(this).val();
    $("#edtSegFam")[0].selectedIndex = 0;
    if (atencion > 0) {
        $.ajax({
            url: "public/views/src/ajaxFamiliares.php",
            method: "POST",
            dataType: "html",
            data: { atencion: atencion }
        }).done(function (respuesta) {
            $("#edtSegFam").html(respuesta);
        }).fail(function () {
            console.log("error");
        });
    }
});
$("#edtSegDp1").on("change", function () {
    var existe = $(this).val();
    $("#edtSegDp2")[0].selectedIndex = 0;
    if (existe > 0) {
        $.ajax({
            url: "public/views/src/ajaxDiagnosticos.php",
            method: "POST",
            dataType: "html",
            data: { existe: existe }
        }).done(function (respuesta) {
            $("#edtSegDp2").html(respuesta);
        }).fail(function () {
            console.log("error");
        });
    }
    else {
        var errorhtml = "<option value='0'>No hay actividades existentes</option>";
        $("#edtSegDp2").html(errorhtml);
    }
});

$("#edtSegDf1").on("change", function () {
    var existe2 = $(this).val();
    $("#edtSegDf2")[0].selectedIndex = 0;
    if (existe2 > 0) {
        $.ajax({
            url: "public/views/src/ajaxDiagnosticos.php",
            method: "POST",
            dataType: "html",
            data: { existe: existe2 }
        }).done(function (respuesta) {
            $("#edtSegDf2").html(respuesta);
        }).fail(function () {
            console.log("error");
        });
    }
    else {
        var errorhtml = "<option value='0'>No hay actividades existentes</option>";
        $("#edtSegDf2").html(errorhtml);
    }
});
$("#edtSegFam").on("change", function () {
    $("#seleccionActual3").remove();
    $("#seleccionActual31").remove();
});
// Editar Seguimiento
// Validación de campos
$("#btnEdtSeg").on("click", function () {
    var tipoS = $("#edtSegTip").val();
    if (tipoS == 1) {
        $("#formEdtSeg").validate({
            rules: {
                edtSegFec: {
                    required: true,
                },
                edtSegTip: {
                    valueNotEquals: "0",
                },
                edtSegProf: {
                    valueNotEquals: "0",
                },
                edtSegMot: {
                    valueNotEquals: "0",
                },
                edtSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                edtSegDp1: {
                    valueNotEquals: "0",
                },
                edtSegDf1: {
                    valueNotEquals: "0",
                },
            },
            messages: {

                edtSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                edtSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                edtSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                edtSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                edtSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                edtSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
                },
                edtSegDf1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
    if ($("#comSi1").is(":checked")) {
        $("#formEdtSeg").validate({
            rules: {
                edtSegFec: {
                    required: true,
                },
                edtSegTip: {
                    valueNotEquals: "0",
                },
                edtSegProf: {
                    valueNotEquals: "0",
                },
                edtSegMot: {
                    valueNotEquals: "0",
                },
                edtSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                edtSegDp1: {
                    valueNotEquals: "0",
                },
            },
            messages: {
                edtSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                edtSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                edtSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                edtSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                rgSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                edtSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
    else if (tipoS == 2) {
        $("#formEdtSeg").validate({
            rules: {
                edtSegFec: {
                    required: true,
                },
                edtSegTip: {
                    valueNotEquals: "0",
                },
                edtSegProf: {
                    valueNotEquals: "0",
                },
                edtSegMot: {
                    valueNotEquals: "0",
                },
                edtSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                edtSegDp1: {
                    valueNotEquals: "0",
                },
                edtSegFam: {
                    valueNotEquals: "0",
                },
                edtSegDf1: {
                    valueNotEquals: "0",
                },
            },
            messages: {
                edtSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                edtSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                edtSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                edtSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                edtSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                edtSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
                },
                edtSegFam: {
                    valueNotEquals: "Seleccione Familiar",
                },
                edtSegDf1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
    else {
        $("#formEdtSeg").validate({
            rules: {
                edtSegFec: {
                    required: true,
                },
                edtSegTip: {
                    valueNotEquals: "0",
                },
                edtSegProf: {
                    valueNotEquals: "0",
                },
                edtSegMot: {
                    valueNotEquals: "0",
                },
                edtSegPac: {
                    valueNotEquals: "0",
                    required: true,
                },
                edtSegDp1: {
                    valueNotEquals: "0",
                },
            },
            messages: {
                edtSegFec: {
                    required: "Ingrese Fecha de Seguimiento",
                },
                edtSegTip: {
                    valueNotEquals: "Seleccione Tipo de Seguimiento",
                },
                edtSegProf: {
                    valueNotEquals: "Seleccione Profesional",
                },
                edtSegMot: {
                    valueNotEquals: "Seleccione Motivo",
                },
                edtSegPac: {
                    valueNotEquals: "Seleccione Paciente",
                    required: "Seleccione Paciente atendido",
                },
                edtSegDp1: {
                    valueNotEquals: "Seleccione al menos un diagnóstico",
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
    }
});
// Anular Seguimiento
$(".datatableSeguimiento tbody").on("click", ".btnAnularSeguimiento", function () {
    var idSeguimiento = $(this).attr("idSeguimiento");
    var idProfesional = $(this).attr("idProfesional");
    var idProfesional2 = $("#idProfH").val();

    if (idProfesional2 != 0) {
        if (idProfesional == idProfesional2) {
            Swal.fire({
                title: '¿Está seguro(a) de anular el seguimiento?',
                text: "¡Si no lo está, puede cancelar la acción!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#343a40',
                cancelButtonText: 'Cancelar',
                cancelButtonColor: '#d33',
                confirmButtonText: '¡Sí, anular seguimiento!'
            }).then(function (result) {
                if (result.value) {
                    window.location = "index.php?ruta=seguimiento&idSeguimiento=" + idSeguimiento;
                }
            })
        }
        else {
            Swal.fire({
                icon: "error",
                title: "No tienes permiso para anular el seguimiento seleccionado",
                showConfirmButton: false,
                timer: 1600
            });
        }
    }
    else {
        Swal.fire({
            icon: "error",
            title: "No tienes permiso para anular el seguimiento seleccionado",
            showConfirmButton: false,
            timer: 1600
        });
    }
});
// Anular Seguimiento