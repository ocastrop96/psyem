<?php
// Controladores
require_once "./app/controller/PlantillaControlador.php";
require_once "./app/controller/UsuariosControlador.php";
require_once "./app/controller/DiagnosticosControlador.php";
require_once "./app/controller/ProfesionalesControlador.php";
require_once "./app/controller/AtencionesControlador.php";
require_once "./app/controller/FamiliaresControlador.php";
require_once "./app/controller/SeguimientosControlador.php";
require_once "./app/controller/ReportesControlador.php";

// Modelos
require_once "./app/model/UsuariosModelo.php";
require_once "./app/model/DiagnosticosModelo.php";
require_once "./app/model/ProfesionalesModelo.php";
require_once "./app/model/AtencionesModel.php";
require_once "./app/model/FamiliaresModelo.php";
require_once "./app/model/SeguimientosModelo.php";
require_once "./app/model/ReportesModelo.php";

$template = new ControladorPlantilla();
$template->ctrPlantilla();
