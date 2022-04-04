segMensProf("", "", $("#prof-id").val());
segTipoProf("", "", $("#prof-id").val());
$(".rseg4").attr("href", "public/views/docs/rp-seguimientos-profesional.php?reporte=reporte&profesional=" + $("#prof-id").val());
$("#deshacer-filtro-RP").on("click", function () {
    window.location = "reporte-profesional";
});
$("input[name='rango-rp']").daterangepicker({
    opens: 'left',
    maxSpan: {
        days: 30,
    },
    startDate: moment(),
    endDate: moment(),
    maxDate: moment(),
    locale: {
        format: "DD/MM/YYYY",
        separator: " hasta ",
        applyLabel: "Aplicar",
        cancelLabel: "Cancelar",
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
}, function (start, end) {
    let inicio = start.format('YYYY-MM-DD');
    let fin = end.format('YYYY-MM-DD');
    let profesional = $("#prof-id").val();

    $(".rseg4").attr("href", "public/views/docs/rp-seguimientos-profesional.php?reporte=reporte&inicio=" + inicio + "&fin=" + fin + "&profesional=" + profesional);
    segMensProf(inicio, fin, profesional);
    segTipoProf(inicio, fin, profesional);
});

// Grafico mensual de Profesional
function segMensProf(inicior, finr, profesionalr) {
    var param12 = 12;
    var inicio = inicior;
    var fin = finr;
    var profesional = profesionalr;

    var datos = new FormData();
    datos.append("param12", param12);
    datos.append("inicio", inicio);
    datos.append("fin", fin);
    datos.append("profesional", profesional);
    $.ajax({
        url: "public/views/src/ajaxGraficos.php",
        method: "POST",
        cache: false,
        data: datos,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            if (respuesta.length > 0) {
                var mes = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    mes.push(respuesta[i][1]);
                    contador.push(respuesta[i][2]);
                    colores.push(colorRGB());
                }

                $("canvas#rjSegxMesPro").remove();
                $("div.rp1").append('<canvas id="rjSegxMesPro" width="350" height="350"></canvas>');
                var ctx2 = document.getElementById("rjSegxMesPro").getContext("2d");
                var salesGraphChartData = {
                    labels: mes,
                    datasets: [
                        {
                            label: '# de Seguimientos',
                            backgroundColor: colores,
                            borderColor: colores,
                            borderWidth: 1,
                            data: contador
                        }
                    ]
                }

                var salesGraphChartOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    legend: {
                        display: false
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                fontColor: colores
                            },
                            gridLines: {
                                display: false,
                                color: '#000',
                                drawBorder: false
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                stepSize: 10,
                                fontColor: '#000'
                            },
                            gridLines: {
                                display: true,
                                color: '#AFAFAF',
                                drawBorder: false
                            }
                        }]
                    },
                    title: {
                        display: true,
                        text: 'Seguimientos Mensual realizados x Profesional'
                    }
                }
                var salesGraphChart = new Chart(ctx2, {
                    type: 'bar',
                    data: salesGraphChartData,
                    options: salesGraphChartOptions
                });
            }
            else {
                $("canvas#rjSegxMesPro").remove();
                $("div.rp1").append('<canvas id="rjSegxMesPro" width="350" height="350"></canvas>');
                var ctx2 = document.getElementById("rjSegxMesPro").getContext("2d");
                var salesGraphChartData = {
                    labels: ['SIN DATOS'],
                    datasets: [
                        {
                            label: '# de Seguimientos',
                            backgroundColor: colores,
                            borderColor: colores,
                            borderWidth: 1,
                            data: [0]
                        }
                    ]
                }

                var salesGraphChartOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    legend: {
                        display: false
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                fontColor: colores
                            },
                            gridLines: {
                                display: false,
                                color: '#000',
                                drawBorder: false
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                stepSize: 100,
                                fontColor: '#000'
                            },
                            gridLines: {
                                display: true,
                                color: '#AFAFAF',
                                drawBorder: false
                            }
                        }]
                    },
                    title: {
                        display: true,
                        text: 'Seguimientos Mensual realizados x Profesional'
                    }
                }
                var salesGraphChart = new Chart(ctx2, {
                    type: 'bar',
                    data: salesGraphChartData,
                    options: salesGraphChartOptions
                });
            }
        },
    });

}
// Grafico mensual de Profesional

// Grafico mensual de Profesional
function segTipoProf(inicior, finr, profesionalr) {
    var param13 = 13;
    var inicio = inicior;
    var fin = finr;
    var profesional = profesionalr;

    var datos = new FormData();
    datos.append("param13", param13);
    datos.append("inicio", inicio);
    datos.append("fin", fin);
    datos.append("profesional", profesional);
    $.ajax({
        url: "public/views/src/ajaxGraficos.php",
        method: "POST",
        cache: false,
        data: datos,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            if (respuesta.length > 0) {
                var tipo = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    tipo.push(respuesta[i][1]);
                    contador.push(respuesta[i][0]);
                    colores.push(colorRGB());
                }

                $("canvas#rjSegxTipoPro").remove();
                $("div.rp2").append('<canvas id="rjSegxTipoPro" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxTipoPro").getContext("2d");
                var donutData = {
                    labels: tipo,
                    datasets: [
                        {
                            label: '# de Seguimientos',
                            data: contador,
                            backgroundColor: colores,
                            borderColor: colores
                        }
                    ]
                }
                var donutOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    legend: {
                        position: 'left',
                    },
                    title: {
                        display: true,
                        text: 'Tipo de Seguimiento x Profesional'
                    },
                }
                new Chart(ctx, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                });
            }
            else {
                $("canvas#rjSegxTipoPro").remove();
                $("div.rp2").append('<canvas id="rjSegxTipoPro" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxTipoPro").getContext("2d");
                var donutData = {
                    labels: ['SIN DATOS'],
                    datasets: [
                        {
                            label: '# de Seguimientos',
                            data: [0],
                            backgroundColor: colores,
                            borderColor: colores
                        }
                    ]
                }
                var donutOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    legend: {
                        position: 'left',
                    },
                    title: {
                        display: true,
                        text: 'Tipo de Seguimiento x Profesional'
                    },
                    scales: {
                        xAxes: [{
                            ticks: {
                                fontColor: colores
                            },
                            gridLines: {
                                display: false,
                                color: '#000',
                                drawBorder: false
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                stepSize: 100,
                                fontColor: '#000'
                            },
                            gridLines: {
                                display: true,
                                color: '#AFAFAF',
                                drawBorder: false
                            }
                        }]
                    },
                }
                new Chart(ctx, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                });

            }
        },
    });
}
// Grafico mensual de Profesional
function generarNumero(numero) {
    return (Math.random() * numero).toFixed(0);
}

function colorRGB() {
    var coolor = "(" + generarNumero(255) + "," + generarNumero(255) + "," + generarNumero(255) + ")";
    return "rgb" + coolor;
}