<?php
require_once "../../../app/controller/AtencionesControlador.php";
require_once "../../../app/controller/SeguimientosControlador.php";
require_once "../../../app/model/AtencionesModel.php";
require_once "../../../app/model/SeguimientosModelo.php";


class ajaxAtenciones
{
    // Listar Atención
    public $idAtencion;
    public function ajaxListarAtencion()
    {
        $item = "idAtencion";
        $valor = $this->idAtencion;
        $respuesta = AtencionesControlador::ctrListarAtenciones($item, $valor);
        echo json_encode($respuesta);
    }
    // Listar Atención
    // Validar Cuenta existente
    public $validaCuenta;
    public function ajaxValidarCuenta()
    {
        $item = "cuentaAtencion";
        $valor = $this->validaCuenta;
        $respuesta = AtencionesControlador::ctrListarAtenciones($item, $valor);
        echo json_encode($respuesta);
    }
    // Validar Cuenta existente
}
// Listar Atención
if (isset($_POST["idAtencion"])) {
    $list1 = new ajaxAtenciones();
    $list1->idAtencion = $_POST["idAtencion"];
    $list1->ajaxListarAtencion();
}
// Listar Atención
// Valida cuenta
if (isset($_POST["cuentaAtencion"])) {
    $valida1 = new ajaxAtenciones();
    $valida1->validaCuenta = $_POST["cuentaAtencion"];
    $valida1->ajaxValidarCuenta();
}
// ValidaCuenta