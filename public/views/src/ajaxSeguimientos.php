<?php
require_once "../../../app/controller/SeguimientosControlador.php";
require_once "../../../app/model/SeguimientosModelo.php";

class ajaxSeguimientos
{
    // Listar Seguimiento
    public $idSeguimiento;
    public function ajaxListarSeguimiento()
    {
        $item = "idSeguimiento";
        $valor = $this->idSeguimiento;
        $respuesta = SeguimientosControlador::ctrListarSeguimientos($item, $valor);
        echo json_encode($respuesta);
    }
    // Listar Seguimiento
}
// Listar Seguimiento
if (isset($_POST["idSeguimiento"])) {
    $list1 = new ajaxSeguimientos();
    $list1->idSeguimiento = $_POST["idSeguimiento"];
    $list1->ajaxListarSeguimiento();
}
// Listar Seguimiento