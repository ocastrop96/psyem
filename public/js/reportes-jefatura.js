seguimientosXProfesional("", "", 0);
seguimientosxTipo("", "", 0);
seguimientosxDiagPac("", "", 0);
seguimientosxDiagFam("", "", 0);

$("#deshacer-filtro-RJ").on("click", function () {
    window.location = "reporte-jefatura";
});
$("input[name='rango-rj']").daterangepicker({
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
    let profesional = $("#rjProfesional").val();

    $('#rango-rj').attr('inicio', inicio);
    $('#rango-rj').attr('fin', fin);
    $(".rseg1").attr("href", "public/views/docs/rp-seguimientos-jefatura.php?reporte=reporte&inicio=" + inicio + "&fin=" + fin + "&profesional=" + profesional);
    seguimientosXProfesional(inicio, fin, profesional);
    seguimientosxTipo(inicio, fin, profesional);
    seguimientosxDiagPac(inicio, fin, profesional);
    seguimientosxDiagFam(inicio, fin, profesional);
});

$("#rjProfesional").on("change", function () {
    let profesional = $(this).val();
    let inicio = $("#rango-rj").attr("inicio");
    let fin = $("#rango-rj").attr("fin");
    $(".rseg1").attr("href", "public/views/docs/rp-seguimientos-jefatura.php?reporte=reporte&inicio=" + inicio + "&fin=" + fin + "&profesional=" + profesional);
    seguimientosXProfesional(inicio, fin, profesional);
    seguimientosxTipo(inicio, fin, profesional);
    seguimientosxDiagPac(inicio, fin, profesional);
    seguimientosxDiagFam(inicio, fin, profesional);
});

function seguimientosXProfesional(inicior, finr, profesionalr) {
    var param8 = 8;
    var inicio = inicior;
    var fin = finr;
    var profesional = profesionalr;

    var datos = new FormData();
    datos.append("param8", param8);
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
                var profesional = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    profesional.push(respuesta[i][0]);
                    contador.push(respuesta[i][1]);
                    colores.push(colorRGB());
                }

                $("canvas#rjSegxPro").remove();
                $("div.rj1").append('<canvas id="rjSegxPro" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxPro").getContext("2d");
                var donutData = {
                    labels: profesional,
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
                        text: 'Seguimientos realizados x Profesional'
                    },
                }
                new Chart(ctx, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                });
            }
            else {
                $("canvas#rjSegxPro").remove();
                $("div.rj1").append('<canvas id="rjSegxPro" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxPro").getContext("2d");
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
                        text: 'Seguimientos realizados x Profesional'
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
function seguimientosxTipo(inicior, finr, profesionalr) {
    var param9 = 9;
    var inicio = inicior;
    var fin = finr;
    var profesional = profesionalr;

    var datos = new FormData();
    datos.append("param9", param9);
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

                $("canvas#rjSegxTipo").remove();
                $("div.rj2").append('<canvas id="rjSegxTipo" width="350" height="350"></canvas>');
                var ctx2 = document.getElementById("rjSegxTipo").getContext("2d");
                var salesGraphChartData = {
                    labels: tipo,
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
                        text: 'Seguimientos realizados x Tipo'
                    }
                }
                var salesGraphChart = new Chart(ctx2, {
                    type: 'bar',
                    data: salesGraphChartData,
                    options: salesGraphChartOptions
                });
            }
            else {
                $("canvas#rjSegxTipo").remove();
                $("div.rj2").append('<canvas id="rjSegxTipo" width="350" height="350"></canvas>');
                var ctx2 = document.getElementById("rjSegxTipo").getContext("2d");
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
                        text: 'Seguimientos realizados x Tipo'
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

function seguimientosxDiagPac(inicior, finr, profesionalr) {
    var param10 = 10;
    var inicio = inicior;
    var fin = finr;
    var profesional = profesionalr;

    var datos = new FormData();
    datos.append("param10", param10);
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
                var diagnostico = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    diagnostico.push(respuesta[i][1]);
                    contador.push(respuesta[i][0]);
                    colores.push(colorRGB());
                }

                $("canvas#rjSegxDiagPac").remove();
                $("div.rj3").append('<canvas id="rjSegxDiagPac" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxDiagPac").getContext("2d");
                var donutData = {
                    labels: diagnostico,
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
                        text: 'Seguimientos realizados x Diagnostico Familiar'
                    },
                }
                new Chart(ctx, {
                    type: 'pie',
                    data: donutData,
                    options: donutOptions
                });
            }
            else {
                $("canvas#rjSegxDiagPac").remove();
                $("div.rj3").append('<canvas id="rjSegxDiagPac" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxDiagPac").getContext("2d");
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
                        text: 'Seguimientos realizados x Diagnostico Familiar'
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
                    type: 'pie',
                    data: donutData,
                    options: donutOptions
                });

            }
        },
    });

}

function seguimientosxDiagFam(inicior, finr, profesionalr) {
    var param11 = 11;
    var inicio = inicior;
    var fin = finr;
    var profesional = profesionalr;

    var datos = new FormData();
    datos.append("param11", param11);
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
                var diagnostico = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    diagnostico.push(respuesta[i][1]);
                    contador.push(respuesta[i][0]);
                    colores.push(colorRGB());
                }

                $("canvas#rjSegxDiagFam").remove();
                $("div.rj4").append('<canvas id="rjSegxDiagFam" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxDiagFam").getContext("2d");
                var donutData = {
                    labels: diagnostico,
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
                        text: 'Seguimientos realizados x Diagnóstico Familiar'
                    },
                }
                new Chart(ctx, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                });
            }
            else {
                $("canvas#rjSegxDiagFam").remove();
                $("div.rj4").append('<canvas id="rjSegxDiagFam" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rjSegxDiagFam").getContext("2d");
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
                        text: 'Seguimientos realizados x Diagnóstico Familiar'
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
function generarNumero(numero) {
    return (Math.random() * numero).toFixed(0);
}

function colorRGB() {
    var coolor = "(" + generarNumero(255) + "," + generarNumero(255) + "," + generarNumero(255) + ")";
    return "rgb" + coolor;
}