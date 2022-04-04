<?php
require_once "../../../app/controller/ReportesControlador.php";
require_once "../../../app/model/ReportesModelo.php";

class AjaxGraficos
{
    public function ajaxCargaWid()
    {
        $respuesta = ReportesControlador::ctrListarWidgets();
        echo json_encode($respuesta);
    }
    public function ajaxCarga10Diag()
    {
        $respuesta = ReportesControlador::ctrListar10Diagnosticos();
        echo json_encode($respuesta);
    }

    public function ajaxCargaMensualSeg()
    {
        $respuesta = ReportesControlador::ctrListarSeguimientosMensual();
        echo json_encode($respuesta);
    }

    public $inicio;
    public $fin;
    public function ajaxAteRegAnu()
    {
        $start = $this->inicio;
        $end = $this->fin;
        $respuesta = ReportesControlador::ctrListarAteRegAnu($start, $end);
        echo json_encode($respuesta);
    }

    public $inicio2;
    public $fin2;
    public function ajaxParentReg()
    {
        $start = $this->inicio2;
        $end = $this->fin2;
        $respuesta = ReportesControlador::ctrListarParentReg($start, $end);
        echo json_encode($respuesta);
    }

    public $inicio3;
    public $fin3;
    public function ajaxSexReg()
    {
        $start = $this->inicio3;
        $end = $this->fin3;
        $respuesta = ReportesControlador::ctrListarSexReg($start, $end);
        echo json_encode($respuesta);
    }

    public $inicio4;
    public $fin4;
    public function ajaxSegRegs()
    {
        $start = $this->inicio4;
        $end = $this->fin4;
        $respuesta = ReportesControlador::ctrListarSegRegs($start, $end);
        echo json_encode($respuesta);
    }

    public $inicio5;
    public $fin5;
    public $profesional;

    public function ajaxSeguixProfesional()
    {
        $start = $this->inicio5;
        $end = $this->fin5;
        $profesional = $this->profesional;
        $respuesta = ReportesControlador::ctrListarSeguixProfesional($start, $end, $profesional);
        echo json_encode($respuesta);
    }

    public $inicio6;
    public $fin6;
    public $profesional1;

    public function ajaxSeguixTipo()
    {
        $start = $this->inicio6;
        $end = $this->fin6;
        $profesional = $this->profesional1;
        $respuesta = ReportesControlador::ctrListarSeguixTipo($start, $end, $profesional);
        echo json_encode($respuesta);
    }

    public $inicio7;
    public $fin7;
    public $profesional2;

    public function ajaxSeguixDiagPac1()
    {
        $start = $this->inicio7;
        $end = $this->fin7;
        $profesional = $this->profesional2;
        $respuesta = ReportesControlador::ctrListarSeguixDiagPac($start, $end, $profesional);
        echo json_encode($respuesta);
    }

    public $inicio8;
    public $fin8;
    public $profesional3;

    public function ajaxSeguixDiagFam1()
    {
        $start = $this->inicio8;
        $end = $this->fin8;
        $profesional = $this->profesional3;
        $respuesta = ReportesControlador::ctrListarSeguixDiagFam($start, $end, $profesional);
        echo json_encode($respuesta);
    }

    public $inicio9;
    public $fin9;
    public $profesional4;

    public function ajaxSeguiMensxPro()
    {
        $start = $this->inicio9;
        $end = $this->fin9;
        $profesional = $this->profesional4;
        $respuesta = ReportesControlador::ctrListarSeguiMensxPro($start, $end, $profesional);
        echo json_encode($respuesta);
    }

    // ajaxSeguiTipoxPro
    public $inicio10;
    public $fin10;
    public $profesional5;

    public function ajaxSeguiTipoxPro()
    {
        $start = $this->inicio10;
        $end = $this->fin10;
        $profesional = $this->profesional5;
        $respuesta = ReportesControlador::ctrListarSeguiTipxPro($start, $end, $profesional);
        echo json_encode($respuesta);
    }
}

if (isset($_POST["param1"])) {
    $list1 = new AjaxGraficos();
    $list1->ajaxCargaWid();
}
if (isset($_POST["param2"])) {
    $list2 = new AjaxGraficos();
    $list2->ajaxCarga10Diag();
}

if (isset($_POST["param3"])) {
    $list3 = new AjaxGraficos();
    $list3->ajaxCargaMensualSeg();
}
if (isset($_POST["param4"])) {
    $list4 = new AjaxGraficos();
    $list4->inicio = $_POST["inicio"];
    $list4->fin = $_POST["fin"];
    $list4->ajaxAteRegAnu();
}

if (isset($_POST["param5"])) {
    $list5 = new AjaxGraficos();
    $list5->inicio2 = $_POST["inicio"];
    $list5->fin2 = $_POST["fin"];
    $list5->ajaxParentReg();
}

if (isset($_POST["param6"])) {
    $list6 = new AjaxGraficos();
    $list6->inicio3 = $_POST["inicio"];
    $list6->fin3 = $_POST["fin"];
    $list6->ajaxSexReg();
}

if (isset($_POST["param7"])) {
    $list7 = new AjaxGraficos();
    $list7->inicio4 = $_POST["inicio"];
    $list7->fin4 = $_POST["fin"];
    $list7->ajaxSegRegs();
}

if (isset($_POST["param8"])) {
    $list8 = new AjaxGraficos();
    $list8->inicio5 = $_POST["inicio"];
    $list8->fin5 = $_POST["fin"];
    $list8->profesional = $_POST["profesional"];
    $list8->ajaxSeguixProfesional();
}
if (isset($_POST["param9"])) {
    $list9 = new AjaxGraficos();
    $list9->inicio6 = $_POST["inicio"];
    $list9->fin6 = $_POST["fin"];
    $list9->profesional1 = $_POST["profesional"];
    $list9->ajaxSeguixTipo();
}

if (isset($_POST["param10"])) {
    $list10 = new AjaxGraficos();
    $list10->inicio7 = $_POST["inicio"];
    $list10->fin7 = $_POST["fin"];
    $list10->profesional2 = $_POST["profesional"];
    $list10->ajaxSeguixDiagPac1();
}


if (isset($_POST["param11"])) {
    $list11 = new AjaxGraficos();
    $list11->inicio8 = $_POST["inicio"];
    $list11->fin8 = $_POST["fin"];
    $list11->profesional3 = $_POST["profesional"];
    $list11->ajaxSeguixDiagFam1();
}
if (isset($_POST["param12"])) {
    $list12 = new AjaxGraficos();
    $list12->inicio9 = $_POST["inicio"];
    $list12->fin9 = $_POST["fin"];
    $list12->profesional4 = $_POST["profesional"];
    $list12->ajaxSeguiMensxPro();
}

if (isset($_POST["param13"])) {
    $list13 = new AjaxGraficos();
    $list13->inicio10 = $_POST["inicio"];
    $list13->fin10 = $_POST["fin"];
    $list13->profesional5 = $_POST["profesional"];
    $list13->ajaxSeguiTipoxPro();
}
