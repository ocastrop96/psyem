<?php
require_once "../../../app/controller/SeguimientosControlador.php";
require_once "../../../app/model/SeguimientosModelo.php";

class DatatableSeguimientos
{
    public function mostrarTablaSeguimientos()
    {
        $item = null;
        $valor = null;
        $seguimientos = SeguimientosControlador::ctrListarSeguimientos($item, $valor);
        $datos_json = '{
            "data": [';
        for ($i = 0; $i < count($seguimientos); $i++) {
            // Estado de Seguimiento
            if ($seguimientos[$i]["idStatusSeg"] == 1) {
                $estadoSeg = "<button type='button' class='btn btn-block btn-success font-weight-bold'><i class='fas fa-clipboard-list'></i> " . $seguimientos[$i]["detaStatusSeg"] . "</button>";
            } else {
                $estadoSeg = "<button type='button' class='btn btn-block btn-danger font-weight-bold'><i class='fas fa-ban'></i> " . $seguimientos[$i]["detaStatusSeg"] . "</button>";
            }
            // Estado de Seguimiento

            // Botones de Opciones
            $botones = "<div class='btn-group'><button class='btn btn-warning btnEditarSeguimiento' idSeguimiento='" . $seguimientos[$i]["idSeguimiento"] . "' idProfesional='" . $seguimientos[$i]["idProfesional"] . "'><i class='fas fa-edit'></i></button><button class='btn btn-secondary btnAnularSeguimiento' data-toggle='tooltip' data-placement='left' title='Anular Seguimiento' idSeguimiento='" . $seguimientos[$i]["idSeguimiento"] . "' idProfesional='" . $seguimientos[$i]["idProfesional"] . "'><i class='fas fa-power-off'></i></button></div>";
            // Botones de Opciones
            $datos_json .= '[
                    "' . ($i + 1) . '",
                    "' . $seguimientos[$i]["fRegistrSeg"] . '",
                    "' . $seguimientos[$i]["cuentaAtencion"] . '",
                    "' . $seguimientos[$i]["tipdocAtencion"] . ' - ' . $seguimientos[$i]["nrodocAtencion"] . '",
                    "' . $seguimientos[$i]["nombAtencion"] . ' ' . $seguimientos[$i]["apPaternoAtencion"] . ' ' . $seguimientos[$i]["apMaternoAtencion"] . '",
                    "' . $seguimientos[$i]["detaTipSeguimiento"] . '",
                    "' . $seguimientos[$i]["nombresProfesional"] . ' ' . $seguimientos[$i]["apellidosProfesional"] . '",
                    "' . $seguimientos[$i]["comunFamSeg"] . '",
                    "' . $seguimientos[$i]["nombApFamiliar"] . '",
                    "' . $estadoSeg . '",
                    "' . $botones . '"
                ],';
        }
        $datos_json = substr($datos_json, 0, -1);
        $datos_json .= ']
            }';
        echo $datos_json;
    }
}
$tablaSeguimientos = new DatatableSeguimientos();
$tablaSeguimientos->mostrarTablaSeguimientos();
