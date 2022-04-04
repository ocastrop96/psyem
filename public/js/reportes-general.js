cargarAteRegAnu("", "");
cargarSexoAte("", "");
cargarTipParen("", "");
cargarSegRegs("", "");
// Fechero
$("#deshacer-filtro-RG").on("click", function () {
    window.location = "reporte-general";
});
$("input[name='rango-rg']").daterangepicker({
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
    let fin = end.format('YYYY-MM-DD')

    $(".rg1").attr("href", "public/views/docs/rp-audfamiliares.php?reporte=reporte&inicio=" + inicio + "&fin=" + fin);
    $(".rg2").attr("href", "public/views/docs/rp-audatenciones.php?reporte=reporte&inicio=" + inicio + "&fin=" + fin);

    cargarAteRegAnu(inicio, fin);
    cargarTipParen(inicio, fin);
    cargarSexoAte(inicio, fin);
    cargarSegRegs(inicio, fin);
});


function cargarAteRegAnu(inicior, finr) {
    var param4 = 4;
    var inicio = inicior;
    var fin = finr;

    var datos = new FormData();
    datos.append("param4", param4);
    datos.append("inicio", inicio);
    datos.append("fin", fin);
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
                var conteo = [];
                var conteo2 = [];
                for (var i = 0; i < respuesta.length; i++) {
                    mes.push(respuesta[i][1]);
                    conteo.push(respuesta[i][2]);
                    conteo2.push(respuesta[i][3]);
                }
                var mode = 'index'
                var intersect = true
                $("canvas#rgAtenAnuReg").remove();
                $("div.rgen1").append('<canvas id="rgAtenAnuReg" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rgAtenAnuReg").getContext("2d");
                var salesChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: mes,
                        datasets: [
                            {
                                label: 'Registradas',
                                backgroundColor: '#007bff',
                                borderColor: '#007bff',
                                data: conteo
                            },
                            {
                                label: 'Anuladas',
                                backgroundColor: '#ced4da',
                                borderColor: '#ced4da',
                                data: conteo2
                            }
                        ]
                    },
                    options: {
                        maintainAspectRatio: false,
                        tooltips: {
                            mode: mode,
                            intersect: intersect
                        },
                        hover: {
                            mode: mode,
                            intersect: intersect
                        },
                        title: {
                            display: true,
                            text: 'Atenciones Registradas y Anuladas'
                        },
                        legend: {
                            display: false
                        },
                        scales: {
                            xAxes: [{
                                ticks: {
                                    fontColor: '#3D3838'
                                },
                                gridLines: {
                                    display: false,
                                    color: '#F1740C',
                                    drawBorder: false
                                }
                            }],
                            yAxes: [{
                                ticks: {
                                    fontColor: '#3D3838',
                                    stepSize: 20
                                },
                                gridLines: {
                                    display: true,
                                    color: '#3D3838',
                                    drawBorder: false
                                }
                            }]
                        }
                    }
                })
            } else {
                $("canvas#rgAtenAnuReg").remove();
                $("div.rgen1").append('<canvas id="rgAtenAnuReg" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rgAtenAnuReg").getContext("2d");
                var salesChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ['SIN DATOS'],
                        datasets: [
                            {
                                label: 'Registradas',
                                backgroundColor: '#007bff',
                                borderColor: '#007bff',
                                data: [0]
                            },
                            {
                                label: 'Anuladas',
                                backgroundColor: '#ced4da',
                                borderColor: '#ced4da',
                                data: [0]
                            }
                        ]
                    },
                    options: {
                        maintainAspectRatio: false,
                        tooltips: {
                            mode: mode,
                            intersect: intersect
                        },
                        hover: {
                            mode: mode,
                            intersect: intersect
                        },
                        title: {
                            display: true,
                            text: 'Atenciones Registradas y Anuladas'
                        },
                        legend: {
                            display: false
                        },
                        scales: {
                            xAxes: [{
                                ticks: {
                                    fontColor: '#3D3838'
                                },
                                gridLines: {
                                    display: false,
                                    color: '#F1740C',
                                    drawBorder: false
                                }
                            }],
                            yAxes: [{
                                ticks: {
                                    fontColor: '#3D3838',
                                    stepSize: 20
                                },
                                gridLines: {
                                    display: true,
                                    color: '#3D3838',
                                    drawBorder: false
                                }
                            }]
                        }
                    }
                })
            }
        },
    });
}

function cargarTipParen(inicior, finr) {
    var param5 = 5;
    var inicio = inicior;
    var fin = finr;

    var datos = new FormData();
    datos.append("param5", param5);
    datos.append("inicio", inicio);
    datos.append("fin", fin);
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
                var parentesco = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    parentesco.push(respuesta[i][1]);
                    contador.push(respuesta[i][0]);
                    colores.push(colorRGB());
                }

                $("canvas#rggTParen").remove();
                $("div.rgen3").append('<canvas id="rggTParen" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rggTParen").getContext("2d");
                var donutData = {
                    labels: parentesco,
                    datasets: [
                        {
                            label: '# de Frecuencia',
                            data: contador,
                            backgroundColor: colores,
                            borderColor: colores
                        }
                    ]
                }
                var donutOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    title: {
                        display: true,
                        text: 'Seguimientos x Parentesco'
                    },
                    legend: {
                        position: 'left',
                    }
                }
                new Chart(ctx, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                })
            }
            else {
                $("canvas#rggTParen").remove();
                $("div.rgen3").append('<canvas id="rggTParen" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rggTParen").getContext("2d");
                var donutData = {
                    labels: ['SIN DATOS'],
                    datasets: [
                        {
                            label: '# de Frecuencia',
                            data: [0],
                            backgroundColor: colores,
                            borderColor: colores
                        }
                    ]
                }
                var donutOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    title: {
                        display: true,
                        text: 'Seguimientos x Parentesco'
                    },
                    legend: {
                        position: 'left',
                    }
                }
                new Chart(ctx, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                })
            }
        },
    });
}

function cargarSexoAte(inicior, finr) {
    var param6 = 6;
    var inicio = inicior;
    var fin = finr;

    var datos = new FormData();
    datos.append("param6", param6);
    datos.append("inicio", inicio);
    datos.append("fin", fin);

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
                var sexo = [];
                var contador = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    sexo.push(respuesta[i][1]);
                    contador.push(respuesta[i][0]);
                    colores.push(colorRGB());
                }

                $("canvas#rggTSexParen").remove();
                $("div.rgen4").append('<canvas id="rggTSexParen" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rggTSexParen").getContext("2d");
                var donutData = {
                    labels: sexo,
                    datasets: [
                        {
                            label: '# de Seguimientos',
                            data: contador,
                            backgroundColor: colores,
                        }
                    ]
                }
                var pieData = donutData;
                var pieOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    title: {
                        display: true,
                        text: 'Seguimientos x Sexo de Familiar'
                    },
                }
                new Chart(ctx, {
                    type: 'pie',
                    data: pieData,
                    options: pieOptions
                })
            }
            else {
                $("canvas#rggTSexParen").remove();
                $("div.rgen4").append('<canvas id="rggTSexParen" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rggTSexParen").getContext("2d");
                var donutData = {
                    labels: ['SIN DATOS'],
                    datasets: [
                        {
                            label: '# de Seguimientos',
                            data: [0],
                            backgroundColor: colores,
                        }
                    ]
                }
                var pieData = donutData;
                var pieOptions = {
                    maintainAspectRatio: false,
                    responsive: true,
                    title: {
                        display: true,
                        text: 'Seguimientos x Sexo de Familiar'
                    },
                }
                new Chart(ctx, {
                    type: 'pie',
                    data: pieData,
                    options: pieOptions
                })
            }
        },
    });
}

function cargarSegRegs(inicior, finr) {
    var param7 = 7;
    var inicio = inicior;
    var fin = finr;

    var datos = new FormData();
    datos.append("param7", param7);
    datos.append("inicio", inicio);
    datos.append("fin", fin);

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
                $("canvas#rggSegs").remove();
                $("div.rgen2").append('<canvas id="rggSegs" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rggSegs").getContext("2d");
                var salesGraphChartData = {
                    labels: mes,
                    datasets: [
                        {
                            fill: true,
                            borderWidth: 2,
                            lineTension: 0,
                            spanGaps: true,
                            borderColor: '#17a2b8',
                            pointRadius: 3,
                            pointHoverRadius: 7,
                            pointColor: '#17a2b8',
                            pointBackgroundColor: '#17a2b8',
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
                                fontColor: '#000'
                            },
                            gridLines: {
                                display: false,
                                color: '#000',
                                drawBorder: false
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                stepSize: 50,
                                fontColor: '#6A6A6A'
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
                        text: 'Seguimientos realizados'
                    }
                }
                var salesGraphChart = new Chart(ctx, {
                    type: 'line',
                    data: salesGraphChartData,
                    options: salesGraphChartOptions
                });
            }
            else{
                $("canvas#rggSegs").remove();
                $("div.rgen2").append('<canvas id="rggSegs" width="350" height="350"></canvas>');
                var ctx = document.getElementById("rggSegs").getContext("2d");
                var salesGraphChartData = {
                    labels: ['SIN DATOS'],
                    datasets: [
                        {
                            fill: true,
                            borderWidth: 2,
                            lineTension: 0,
                            spanGaps: true,
                            borderColor: '#17a2b8',
                            pointRadius: 3,
                            pointHoverRadius: 7,
                            pointColor: '#17a2b8',
                            pointBackgroundColor: '#17a2b8',
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
                                fontColor: '#000'
                            },
                            gridLines: {
                                display: false,
                                color: '#000',
                                drawBorder: false
                            }
                        }],
                        yAxes: [{
                            ticks: {
                                stepSize: 50,
                                fontColor: '#6A6A6A'
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
                        text: 'Seguimientos realizados'
                    }
                }
                var salesGraphChart = new Chart(ctx, {
                    type: 'line',
                    data: salesGraphChartData,
                    options: salesGraphChartOptions
                });
            }
        },
    });
}
// Evento captura rango
function generarNumero(numero) {
    return (Math.random() * numero).toFixed(0);
}

function colorRGB() {
    var coolor = "(" + generarNumero(255) + "," + generarNumero(255) + "," + generarNumero(255) + ")";
    return "rgb" + coolor;
}
