<?php
require_once "../../../app/controller/DiagnosticosControlador.php";
require_once "../../../app/model/DiagnosticosModelo.php";
require_once "../../../app/model/dbConnect.php";
class ajaxDiagnosticos
{
    // Validar CIE repetido
    public $validarCie;
    public function ajaxCIERepetido()
    {
        $item = "cieDiagnostico";
        $valor = $this->validarCie;
        $respuesta = DiagnosticosControlador::ctrListarDiagnosticos($item, $valor);
        echo json_encode($respuesta);
    }
    // Validar CIE repetido
    // Listar Diagnosticos
    public $idDiagnostico;
    public function ajaxListarDiagnosticos()
    {
        $item = "idDiagnostico";
        $valor = $this->idDiagnostico;
        $respuesta = DiagnosticosControlador::ctrListarDiagnosticos($item, $valor);
        echo json_encode($respuesta);
    }
    // Listar Diagnosticos
    // Listar Diagnostico no Seleccionado
    public $existe;
    public function ajaxListarDiagnosticosNoSeleccionado()
    {
        $existeb = $this->existe;
        $datosDiag = DiagnosticosControlador::ctrListarNoSeleccionado($existeb);
        $totalDiag = count($datosDiag);

        if ($totalDiag > 0) {
            $html = "<option value='0'>Seleccione Actividad (Opcional)</option>";
            foreach ($datosDiag as $key => $value) {
                $html .= "<option value='$value[idDiagnostico]'>$value[cieDiagnostico] -  $value[detaDiagnostico]</option>";
            }
        } else {
            $html = "<option value='0'>No hay actividades existentes</option>";
        }

        echo $html;
    }
    // Listar Diagnostico no Seleccionado


    // Búsqueda de diagnosticos
    public $datoBusDX;
    public function ajaxBuscarDiagnosticoPrincipal()
    {
        $valorTermino = $this->datoBusDX;

        $stmt = Conexion::conectar()->prepare("CALL Buscar_Diagnosticos('$valorTermino',1,0,0,0)");
        $stmt->execute();
        $data = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = array("id" => $row['idDiagnostico'], "text" =>  $row['diagnostico']);
        }
        echo json_encode($data);
    }
    // Búsqueda de diagnosticos


    public $datoBusDX2;
    public $datoBusidEx;

    public function ajaxBuscarDiagnosticoPrincipal2()
    {
        $valorTermino = $this->datoBusDX2;
        $filtro = $this->datoBusidEx;

        $stmt = Conexion::conectar()->prepare("CALL Buscar_Diagnosticos('$valorTermino',2,$filtro,0,0)");
        $stmt->execute();
        $data = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = array("id" => $row['idDiagnostico'], "text" =>  $row['diagnostico']);
        }
        echo json_encode($data);
    }

    // Busqueda de Tercer Dx

    public $datoBusDX3;
    public $datoBusidEx_2;
    public $datoBusidEx_3;

    public function ajaxBuscarDiagnosticoPrincipal3()
    {
        $valorTermino = $this->datoBusDX3;
        $filtro2 = $this->datoBusidEx_2;
        $filtro3 = $this->datoBusidEx_3;


        $stmt = Conexion::conectar()->prepare("CALL Buscar_Diagnosticos('$valorTermino',3,$filtro2,$filtro3,0)");
        $stmt->execute();
        $data = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = array("id" => $row['idDiagnostico'], "text" =>  $row['diagnostico']);
        }
        echo json_encode($data);
    }

    // Busqueda de Cuarto Dx
    public $datoBusDX3_1;
    public $datoBusidEx_2_1;
    public $datoBusidEx_3_1;
    public $datoBusidEx_4_1;

    public function ajaxBuscarDiagnosticoPrincipal4()
    {
        $valorTermino = $this->datoBusDX3_1;
        $filtro2 = $this->datoBusidEx_2_1;
        $filtro3 = $this->datoBusidEx_3_1;
        $filtro4 = $this->datoBusidEx_4_1;


        $stmt = Conexion::conectar()->prepare("CALL Buscar_Diagnosticos('$valorTermino',4,$filtro2,$filtro3,$filtro4)");
        $stmt->execute();
        $data = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = array("id" => $row['idDiagnostico'], "text" =>  $row['diagnostico']);
        }
        echo json_encode($data);
    }
}
// Validar CIE repetido
if (isset($_POST["validarCie"])) {
    $validar = new ajaxDiagnosticos();
    $validar->validarCie = $_POST["validarCie"];
    $validar->ajaxCIERepetido();
}
// Validar CIE repetido
// Listar Diagnosticos
if (isset($_POST["idDiagnostico"])) {
    $list1 = new ajaxDiagnosticos();
    $list1->idDiagnostico = $_POST["idDiagnostico"];
    $list1->ajaxListarDiagnosticos();
}
// Listar Diagnosticos
// Listar Diag no seleccionado
if (isset($_POST["existe"])) {
    $list3 = new ajaxDiagnosticos();
    $list3->existe = $_POST["existe"];
    $list3->ajaxListarDiagnosticosNoSeleccionado();
}


if (isset($_POST["searchTerm"])) {
    $listdxPrincipal = new ajaxDiagnosticos();
    $listdxPrincipal->datoBusDX = $_POST["searchTerm"];
    $listdxPrincipal->ajaxBuscarDiagnosticoPrincipal();
}

if (isset($_POST["searchTerm2"])) {
    $listdxPrincipal2 = new ajaxDiagnosticos();
    $listdxPrincipal2->datoBusDX2 = $_POST["searchTerm2"];
    $listdxPrincipal2->datoBusidEx = $_POST["excluido"];
    $listdxPrincipal2->ajaxBuscarDiagnosticoPrincipal2();
}

// Busqueda de 3er Dx
if (isset($_POST["searchTerm3"])) {
    $listdxPrincipal3 = new ajaxDiagnosticos();
    $listdxPrincipal3->datoBusDX3 = $_POST["searchTerm3"];
    $listdxPrincipal3->datoBusidEx_2 = $_POST["excluido"];
    $listdxPrincipal3->datoBusidEx_3 = $_POST["excluido2"];

    $listdxPrincipal3->ajaxBuscarDiagnosticoPrincipal3();
}
// Busqueda de 4to Dx
if (isset($_POST["searchTerm4"])) {
    $listdxPrincipal4 = new ajaxDiagnosticos();
    $listdxPrincipal4->datoBusDX3_1 = $_POST["searchTerm4"];
    $listdxPrincipal4->datoBusidEx_2_1 = $_POST["excluido"];
    $listdxPrincipal4->datoBusidEx_3_1 = $_POST["excluido2"];
    $listdxPrincipal4->datoBusidEx_4_1 = $_POST["excluido3"];

    $listdxPrincipal4->ajaxBuscarDiagnosticoPrincipal4();
}