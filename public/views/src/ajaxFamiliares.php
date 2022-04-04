<?php
require_once "../../../app/controller/FamiliaresControlador.php";
require_once "../../../app/model/FamiliaresModelo.php";
require_once "../../../app/model/dbConnect.php";


class AjaxFamiliares
{
    public $dato;
    public function ajaxBuscarPaciente1()
    {
        $valorTermino = $this->dato;

        $stmt = Conexion::conectar()->prepare("CALL BUSCAR_PACIENTE('$valorTermino')");
        $stmt->execute();
        $data = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = array("id" => $row['idAtencion'], "text" => 'F. INGRESO - ' . $row['fIngresoAtencion'] .' || N° CUENTA-' . $row['cuentaAtencion'] . ' || ' . $row['tipdocAtencion'] . '-' . $row['nrodocAtencion'] . ' - ' . $row['paciente']. ' || ESTADO : ' . $row['detaEstadoPacAtencion']);
        }
        echo json_encode($data);
    }

    public $dato2;
    public function ajaxBuscarPaciente2()
    {
        $valorTermino = $this->dato2;

        $stmt = Conexion::conectar()->prepare("CALL BUSCAR_PACIENTE('$valorTermino')");
        $stmt->execute();
        $data = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $data[] = array("id" => $row['idAtencion'], "text" => 'F. INGRESO - ' . $row['fIngresoAtencion'] . ' || N° CUENTA-' . $row['cuentaAtencion'] . ' || ' . $row['tipdocAtencion'] . '-' . $row['nrodocAtencion'] . ' - ' . $row['paciente'] . ' || ESTADO : ' . $row['detaEstadoPacAtencion']);
        }
        echo json_encode($data);
    }


    public $idFamiliar;
    public function ajaxListarFamiliar()
    {
        $item = "idFamiliar";
        $valor = $this->idFamiliar;
        $respuesta = FamiliaresControlador::ctrListarFamiliares($item, $valor);
        echo json_encode($respuesta);
    }

    // Validar Cuenta existente
    public $Paciente;
    public $dniFamiliar;
    public function ajaxValidarFamiliar()
    {
        $valor1 = $this->Paciente;
        $valor2 = $this->dniFamiliar;
        $respuesta = FamiliaresControlador::ctrValidarFamiliar($valor1, $valor2);
        echo json_encode($respuesta);
    }
    // Validar Cuenta existente
    // Listar Familiares de paciente
    public $atencion;
    public function ajaxListarFamiliarPac()
    {
        $existeb = $this->atencion;
        $datosFam = FamiliaresControlador::ctrListarFamiliarPaciente($existeb);
        $totalFam = count($datosFam);

        if ($totalFam > 0) {
            $html = "<option value='0'>Seleccione Familiar (Opcional)</option>";
            foreach ($datosFam as $key => $value) {
                $html .= "<option value='$value[idFamiliar]'>$value[familiarPaciente]</option>";
            }
        } else {
            $html = "<option value='0'>No hay familiares relacionados al paciente</option>";
        }

        echo $html;
    }
    // Listar Familiares de paciente
}
// Búsqueda de paciente
if (isset($_POST["searchTerm"])) {
    $list1 = new AjaxFamiliares();
    $list1->dato = $_POST["searchTerm"];
    $list1->ajaxBuscarPaciente1();
}
// Búsqueda de paciente
if (isset($_POST["searchTerm2"])) {
    $list2 = new AjaxFamiliares();
    $list2->dato2 = $_POST["searchTerm2"];
    $list2->ajaxBuscarPaciente2();
}
// Búsqueda de paciente

// Listar Familiar
if (isset($_POST["idFamiliar"])) {
    $list1 = new AjaxFamiliares();
    $list1->idFamiliar = $_POST["idFamiliar"];
    $list1->ajaxListarFamiliar();
}
// Listar Familiar
// Validar Familiar
if (isset($_POST["Paciente"])) {
    $validFa = new AjaxFamiliares();
    $validFa->Paciente = $_POST["Paciente"];
    $validFa->dniFamiliar = $_POST["dniFamiliar"];
    $validFa->ajaxValidarFamiliar();
}
// Listar Familiares Paciente
if (isset($_POST["atencion"])) {
    $list3 = new AjaxFamiliares();
    $list3->atencion = $_POST["atencion"];
    $list3->ajaxListarFamiliarPac();
}
// Listar Familiares Paciente