<?php
// LLamada a controlador
require_once "../../../app/controller/FamiliaresControlador.php";
// LLamada a modelo
require_once "../../../app/model/FamiliaresModelo.php";
class DatatableFamiliares
{
    public function mostrarTablaFamiliares()
    {
        $item = null;
        $valor = null;
        $familiares = FamiliaresControlador::ctrListarFamiliares($item, $valor);
        $datos_json = '{
            "data": [';

        for ($i = 0; $i < count($familiares); $i++) {
            // Botones de Opciones
            $botones = "<div class='btn-group'><button class='btn btn-warning btnEditarFamiliar' idFamiliar='" . $familiares[$i]["idFamiliar"] . "' data-toggle='modal' data-target='#modal-editar-familiar'><i class='fas fa-edit'></i></button><button class='btn btn-danger btnEliminarFamiliar' data-toggle='tooltip' data-placement='left' title='Eliminar Familiar' idFamiliar='" . $familiares[$i]["idFamiliar"] . "' idAtencion='" . $familiares[$i]["idAtencion"] . "' idNDoc='" . $familiares[$i]["ndocFamiliar"] . "'><i class='fas fa-trash-alt'></i></button></div>";

            $datos_json .= '[
                "' . ($i + 1) . '",
                "' . $familiares[$i]["fechaRegistro"] . '",
                "' . $familiares[$i]["cuentaAtencion"] . '",
                "' . $familiares[$i]["historiaAtencion"] . '",
                "' . $familiares[$i]["nombAtencion"] . ' ' . $familiares[$i]["apPaternoAtencion"] . ' ' . $familiares[$i]["apMaternoAtencion"] . '",
                "' . $familiares[$i]["tipdocFamiliar"] . '-' . $familiares[$i]["ndocFamiliar"] . '",
                "' . $familiares[$i]["nombApFamiliar"] . '",
                "' . $familiares[$i]["detaParentesco"] . '",
                "' . $familiares[$i]["telcelFamiliar"] . '",
                "' . $botones . '"
            ],';
        }
        $datos_json = substr($datos_json, 0, -1);
        $datos_json .= ']
        }';
        echo $datos_json;
    }
}
$tablaFamiliares = new DatatableFamiliares();
$tablaFamiliares->mostrarTablaFamiliares();
