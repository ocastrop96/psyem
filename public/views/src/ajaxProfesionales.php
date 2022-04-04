<?php
require_once "../../../app/controller/ProfesionalesControlador.php";
require_once "../../../app/model/ProfesionalesModelo.php";
class ajaxProfesionales
{
    // Validar DNI repetido
    public $validarDni;
    public function ajaxDNIRepetido()
    {
        $item = "dniProfesional";
        $valor = $this->validarDni;
        $respuesta = ProfesionalesControlador::ctrListarProfesionales($item, $valor);
        echo json_encode($respuesta);
    }
    // Validar DNI repetido
    // Listar datos profesional 
    public $idProfesional;
    public function ajaxListarProfesional()
    {
        $item = "idProfesional";
        $valor = $this->idProfesional;
        $respuesta = ProfesionalesControlador::ctrListarProfesionales($item, $valor);
        echo json_encode($respuesta);
    }
    // Listar datos profesional
    // Habilitar Profesional
    public $idProfesional2;
    public $idEstado;
    public function HabilitarProfesional()
    {
        $valor1 = $this->idProfesional2;
        $valor2 = $this->idEstado;
        $respuesta = ProfesionalesModelo::mdlHabilitarProfesional($valor1, $valor2);
        echo json_encode($respuesta);
    }
    // Habilitar Profesional
}

// Validar DNI existente
if (isset($_POST["validarDni"])) {
    $validar = new ajaxProfesionales();
    $validar->validarDni = $_POST["validarDni"];
    $validar->ajaxDNIRepetido();
}
// Validar DNI existente
// Listar Profesional
if (isset($_POST["idProfesional"])) {
    $list1 = new ajaxProfesionales();
    $list1->idProfesional = $_POST["idProfesional"];
    $list1->ajaxListarProfesional();
}
// Listar Profesional
// Habilitar Profesional
if (isset($_POST["idEstado"])) {
    $activarEst = new ajaxProfesionales();
    $activarEst->idEstado = $_POST["idEstado"];
    $activarEst->idProfesional2 = $_POST["idProfesional2"];
    $activarEst->HabilitarProfesional();
}
// Habilitar Profesional