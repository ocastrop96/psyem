// Carga de Widgets
CargarWidgets();
// Carga de Widgets
function CargarWidgets() {
    var param1 = 1;
    var datos = new FormData();
    datos.append("param1", param1);
    $.ajax({
        url: "public/views/src/ajaxGraficos.php",
        method: "POST",
        cache: false,
        data: datos,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            $(".one1").html(respuesta["nseguimientos"]);
            $(".one2").html(respuesta["natenciones"]);
            $(".one3").html(respuesta["nfamiliares"]);
            $(".one4").html(respuesta["nusuarios"]);
            $(".one5").html(respuesta["nprofesionales"]);
            $(".one6").html(respuesta["ndiagnosticos"]);
        },
    });
}

DiagnosticosFrecuentes();
function DiagnosticosFrecuentes() {
    var param2 = 2;
    var datos = new FormData();
    datos.append("param2", param2);
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
                var cie = [];
                var frecuencia = [];
                var colores = [];
                for (var i = 0; i < respuesta.length; i++) {
                    cie.push(respuesta[i][1]);
                    frecuencia.push(respuesta[i][3]);
                    colores.push(colorRGB());
                }
                var donutChartCanvas = $('#donutChart').get(0).getContext('2d')
                var donutData = {
                    labels: cie,
                    datasets: [
                        {
                            label: '# de Frecuencia',
                            data: frecuencia,
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
                    }
                }
                new Chart(donutChartCanvas, {
                    type: 'doughnut',
                    data: donutData,
                    options: donutOptions
                })
            }
        },
    });
}
SeguimientosPorMes();
function SeguimientosPorMes() {
    var param3 = 3;
    var datos = new FormData();
    datos.append("param3", param3);
    $.ajax({
        url: "public/views/src/ajaxGraficos.php",
        method: "POST",
        cache: false,
        data: datos,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (respuesta) {
            var mes = [];
            var conteo = [];
            var colores = [];
            for (var i = 0; i < respuesta.length; i++) {
                mes.push(respuesta[i][1]);
                conteo.push(respuesta[i][2]);
                colores.push(colorRGB());
            }
            var areaChartData = {
                labels: mes,
                datasets: [
                    {
                        label: '# Seguimientos x Mes',
                        backgroundColor: colores,
                        borderColor: colores,
                        pointRadius: false,
                        pointColor: '#3b8bba',
                        pointStrokeColor: 'rgba(60,141,188,1)',
                        pointHighlightFill: '#fff',
                        pointHighlightStroke: 'rgba(60,141,188,1)',
                        data: conteo
                    }
                ]
            }
            var barChartCanvas = $('#barChart').get(0).getContext('2d')
            var barChartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                datasetFill: false
            }
            new Chart(barChartCanvas, {
                type: 'bar',
                data: areaChartData,
                options: barChartOptions
            })
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