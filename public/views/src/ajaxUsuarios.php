<?php
require_once "../../../app/controller/UsuariosControlador.php";
require_once "../../../app/model/UsuariosModelo.php";

class ajaxUsuarios
{
    // Validar cuenta de login
    public $validarCuentaLog;
    public function ajaxCuentaLogin()
    {
        $item = "cuentaUsuario";
        $valor = $this->validarCuentaLog;
        $respuesta = UsuariosControlador::ctrListarUsuarios($item, $valor);

        echo json_encode($respuesta);
    }
    // Validar cuenta de login 
    // Validar DNI de Usuario existente
    public $validarDni;

    public function ajaxDNIRepetido()
    {
        $item = "dniUsuario";
        $valor = $this->validarDni;
        $respuesta = UsuariosControlador::ctrListarUsuarios($item, $valor);
        echo json_encode($respuesta);
    }
    // Validar DNI de Usuario existente   
    // Listar datos usuario  
    public $idUsuario;
    public function ajaxListarUsuario()
    {
        $item = "idUsuario";
        $valor = $this->idUsuario;
        $respuesta = UsuariosControlador::ctrListarUsuarios($item, $valor);
        echo json_encode($respuesta);
    }
    // Listar datos usuario  
    // Habilitar Usuario
    public $idUsuario2;
    public $idEstado;
    public function HabilitarUsuario()
    {
        $valor1 = $this->idUsuario2;
        $valor2 = $this->idEstado;
        $respuesta = UsuariosModelo::mdlActualizarUsuario($valor1, $valor2);
        echo json_encode($respuesta);
    }
    // Habilitar Usuario
    // Desbloquear Usuario
    public $idUsuario3;
    public function ajaxDesbloquearUsuario()
    {
        $valor = $this->idUsuario3;
        $respuesta = UsuariosModelo::mdlDesbloquearUsuario($valor);
        echo json_encode($respuesta);
    }
    // Desbloquear Usuario

    // Validar Estado de Usuario
    public $idUsuario4;
    public function ajaxValidaEstado()
    {
        $valor = $this->idUsuario4;
        $respuesta = UsuariosModelo::mdlValidarEstado($valor);
        echo json_encode($respuesta);
    }
    // Validar Estado de Usuario
}
// Validar Cuenta Login
if (isset($_POST["validarCuentaLog"])) {
    $validarcL = new ajaxUsuarios();
    $validarcL->validarCuentaLog = $_POST["validarCuentaLog"];
    $validarcL->ajaxCuentaLogin();
}
// Validar Cuenta Login
// Validar DNI existente
if (isset($_POST["validarDni"])) {
    $validar = new ajaxUsuarios();
    $validar->validarDni = $_POST["validarDni"];
    $validar->ajaxDNIRepetido();
}
// Validar DNI existente
// Listar usuarios
if (isset($_POST["idUsuario"])) {
    $list1 = new ajaxUsuarios();
    $list1->idUsuario = $_POST["idUsuario"];
    $list1->ajaxListarUsuario();
}
// Habilitar Usuario
if (isset($_POST["idEstado"])) {
    $activarEst = new ajaxUsuarios();
    $activarEst->idEstado = $_POST["idEstado"];
    $activarEst->idUsuario2 = $_POST["idUsuario2"];
    $activarEst->HabilitarUsuario();
}
// Habilitar Usuario
// Desbloquear Usuario
if (isset($_POST["idUsuario3"])) {
    $list1 = new ajaxUsuarios();
    $list1->idUsuario3 = $_POST["idUsuario3"];
    $list1->ajaxDesbloquearUsuario();
}
// Desbloquear Usuario
// Validar Estado
if (isset($_POST["idUsuario4"])) {
    $list2 = new ajaxUsuarios();
    $list2->idUsuario4 = $_POST["idUsuario4"];
    $list2->ajaxValidaEstado();
}
