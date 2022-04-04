<?php
// LLamada a controlador
require_once "../../../app/controller/UsuariosControlador.php";
// LLamada a modelo
require_once "../../../app/model/UsuariosModelo.php";

// require_once "../../app/model/UsuariosModelo.php";

class DatatableUsuarios
{
    public function mostrarTablaUsuarios()
    {
        $item = null;
        $valor = null;
        $usuarios = UsuariosControlador::ctrListarUsuarios($item, $valor);

        $datos_json = '{
            "data": [';

        for ($i = 0; $i < count($usuarios); $i++) {

            // Perfil con iconos
            if ($usuarios[$i]["idPerfil"] == 1) {
                $perfil = "<i class='fas fa-user-cog'></i>&nbsp" . $usuarios[$i]["detallePerfil"] . "";
            } else if ($usuarios[$i]["idPerfil"] == 2) {
                $perfil = "<i class='fas fa-user-tie'></i>&nbsp" . $usuarios[$i]["detallePerfil"] . "";
            } else if ($usuarios[$i]["idPerfil"] == 3) {
                $perfil = "<i class='fas fa-hospital-user'></i>&nbsp" . $usuarios[$i]["detallePerfil"] . "";
            }else {
                $perfil = "<i class='fas fa-tasks'></i>&nbsp" . $usuarios[$i]["detallePerfil"] . "";
            }
            // Botones de Estado
            if (($usuarios[$i]["idEstado"] != 2)) {
                $estado = "<button type='button' class='btn btn-block btn-success btnHabilitar' idUsuario='" . $usuarios[$i]["idUsuario"] . "' idEstado='2'><i class='fas fa-user-check'></i>HABILITADO</button>";
            } else {
                $estado = "<button type='button' class='btn btn-block btn-danger btnHabilitar' idUsuario='" . $usuarios[$i]["idUsuario"] . "' idEstado='1'><i class='fas fa-user-minus'></i>INHABILITADO</button>";
            }
            // Botones de Opciones
            $botones = "<div class='btn-group'><button class='btn btn-warning btnEditarUsuario' idUsuario='" . $usuarios[$i]["idUsuario"] . "' data-toggle='modal' data-target='#modal-editar-usuario'><i class='fas fa-edit'></i></button><button class='btn btn-info btnDesbloquearUsuario' data-toggle='tooltip' data-placement='left' title='Desbloquear Usuario' idUsuario='" . $usuarios[$i]["idUsuario"] . "'><i class='fas fa-unlock-alt'></i></button><button class='btn btn-danger btnEliminarUsuario' data-toggle='tooltip' data-placement='left' title='Eliminar Usuario' idUsuario='" . $usuarios[$i]["idUsuario"] . "'><i class='fas fa-trash-alt'></i></button></div>";

            $datos_json .= '[
                "' . ($i + 1) . '",
                "' . $usuarios[$i]["dniUsuario"] . '",
                "' . $usuarios[$i]["nombresUsuario"] . '",
                "' . $usuarios[$i]["apellidosUsuario"] . '",
                "' . $perfil . '",
                "' . $usuarios[$i]["correoUsuario"] . '",
                "' . $usuarios[$i]["cuentaUsuario"] . '",
                "' . $usuarios[$i]["fechaAlta"] . '",
                "' . $estado . '",
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
$tablaUsuarios = new DatatableUsuarios();
$tablaUsuarios->mostrarTablaUsuarios();
