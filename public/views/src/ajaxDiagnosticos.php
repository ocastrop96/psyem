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

        $stmt = Conexion::conectar()->prepare("CALL Buscar_Diagnosticos('$valorTermino',1,0)");
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

        $stmt = Conexion::conectar()->prepare("CALL Buscar_Diagnosticos('$valorTermino',2,$filtro)");
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