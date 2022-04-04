$("#deshacer-filtro-Monitoreo").on("click", function () {
    window.location = "monitoreo";
});
$("#rango-Monitoreo").daterangepicker({
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
        var fechaInicialMonit = start.format("YYYY-MM-DD");
        var fechaFinalMonit = end.format("YYYY-MM-DD");

        var capRangoMonit = $("#daterange-btn span").html();
        localStorage.setItem("capRangoMonit", capRangoMonit);
        window.location =
            "index.php?ruta=monitoreo&fechaInicialMonit=" +
            fechaInicialMonit +
            "&fechaFinalMonit=" +
            fechaFinalMonit;
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
        window.location = "monitoreo";
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

        var fechaInicialMonit = año + "-" + mes + "-" + dia;
        var fechaFinalMonit = año + "-" + mes + "-" + dia;

        localStorage.setItem("capRangoMonit", "Hoy");

        window.location =
            "index.php?ruta=monitoreo&fechaInicialMonit=" +
            fechaInicialMonit +
            "&fechaFinalMonit=" +
            fechaFinalMonit;
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
$(".datatableMonitoreo").DataTable({
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

$(".datatableMonitoreo tbody").on("click", ".btnVisualizarSeguimiento", function () {
    var idSeguimiento = $(this).attr("idSeguimiento");
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
                    $("#visSegFec").val(respuesta["fRegistrSeg"]);
                    $("#s21").val(respuesta["nombresProfesional"] + " " + respuesta["apellidosProfesional"]);
                    $("#s22").val(respuesta["detaTipSeguimiento"]);
                    $("#s23").val(respuesta["detaMotivoSef"]);
                    $("#s30").val(respuesta["obsSeg"]);
                    $("#s24").val(respuesta["cuentaAtencion"] + " || " + respuesta["tipdocAtencion"] + "-" + respuesta["nrodocAtencion"] + " - " + respuesta["nombAtencion"] + " " + respuesta["apPaternoAtencion"] + " " + respuesta["apMaternoAtencion"]);
                    // Condicionales en caso del tipo de tipSeguimiento
                    var tipSeguimiento = respuesta["idTipoSeguimiento"];
                    if (tipSeguimiento == 1 || tipSeguimiento == 2) {
                        $("#bloqueComFam13").removeClass("d-none");
                    }
                    else {
                        $("#bloqueComFam13").addClass("d-none");
                    }
                    if (respuesta["comunFamSeg"] == "SI") {
                        $("#block11").removeClass("d-none");
                        $("#comSi13").prop("checked", true);
                        $("#comFami13").val("SI");
                    }
                    else {
                        $("#block11").addClass("d-none");
                        $("#comNo13").prop("checked", true);
                        $("#comFami13").val("NO");
                    }
                    // Condicionales en caso del tipo de tipSeguimiento
                    // Condiciones para diagnosticos
                    if (respuesta["idDiag1Seg"] != 0) {
                        $("#s25").val(respuesta["cieP1"] + " - " + respuesta["detaD1"]);
                    }
                    if (respuesta["idDiag2Seg"] != 0) {
                        $("#s26").val(respuesta["cieP2"] + " - " + respuesta["detD2"]);
                    }

                    if (respuesta["idDiag1SegFam"] != 0) {
                        $("#s28").val(respuesta["cieDF1"] + " - " + respuesta["detDF1"]);
                    }
                    else {
                        $("#s28").val("");
                    }
                    if (respuesta["idDiag2SegFam"] != 0) {
                        $("#s29").val(respuesta["cieDF2"] + " - " + respuesta["detDF2"]);
                    }
                    // Condiciones para diagnosticos
                    if (respuesta["idFamAtSeg"] != 0) {
                        $("#s27").val(respuesta["nombApFamiliar"] + " - " + respuesta["detaParentesco"] + "  " + respuesta["telcelFamiliar"]);
                    }
                    else {
                        $("#s27").val("");
                    }
                },
            });
});