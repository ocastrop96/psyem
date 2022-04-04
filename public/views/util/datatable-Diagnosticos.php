<?php
// LLamada a controlador
require_once "../../../app/controller/DiagnosticosControlador.php";
// LLamada a modelo
require_once "../../../app/model/DiagnosticosModelo.php";

// require_once "../../app/model/UsuariosModelo.php";

class DatatableDiagnosticos
{
    public function mostrarTablaDiagnosticos()
    {
        $item = null;
        $valor = null;
        $diagnosticos = DiagnosticosControlador::ctrListarDiagnosticos($item, $valor);
        $datos_json = '{
            "data": [';

        for ($i = 0; $i < count($diagnosticos); $i++) {

            // Botones de Opciones
            $botones = "<div class='btn-group'><button class='btn btn-warning btnEditarDiagnostico' idDiagnostico='" . $diagnosticos[$i]["idDiagnostico"] . "' data-toggle='modal' data-target='#modal-editar-diagnostico'><i class='fas fa-edit'></i></button><button class='btn btn-danger btnEliminarDiagnostico' data-toggle='tooltip' data-placement='left' title='Eliminar Diagnóstico' idDiagnostico='" . $diagnosticos[$i]["idDiagnostico"] . "'><i class='fas fa-trash-alt'></i></button></div>";

            $datos_json .= '[
                "' . ($i + 1) . '",
                "' . $diagnosticos[$i]["cieDiagnostico"] . '",
                "' . $diagnosticos[$i]["detaDiagnostico"] . '",
                "' . $botones . '"
            ],';
        }
        $datos_json = substr($datos_json, 0, -1);
        $datos_json .= ']
        }';
        echo $datos_json;
    }
}
// Llamamos a la tabla de Usuarios
$tablaDiagnosticos = new DatatableDiagnosticos();
$tablaDiagnosticos->mostrarTablaDiagnosticos();
