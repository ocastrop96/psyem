<?php
require_once "../../../app/controller/ReportesControlador.php";
require_once "../../../app/model/ReportesModelo.php";

$reporte = new ReportesControlador();
$reporte->ctrReporteAudiAtenciones();
