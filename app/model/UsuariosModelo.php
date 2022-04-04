<?php
require_once "dbConnect.php";
class UsuariosModelo
{
    static public function mdlLoginUsuario($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL LOGIN_USUARIO(:cuentaUsuario)");
        $stmt->bindParam(":cuentaUsuario", $datos, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlRegistroIntentos($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRO_INTENTOS(:idUsuario)");
        $stmt->bindParam(":idUsuario", $datos, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarUsuarios($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            acpsy_usuarios.idUsuario, 
            acpsy_usuarios.dniUsuario, 
            acpsy_usuarios.apellidosUsuario, 
            acpsy_usuarios.nombresUsuario, 
            acpsy_usuarios.cuentaUsuario, 
            acpsy_usuarios.correoUsuario, 
            acpsy_usuarios.claveUsuario, 
            acpsy_usuarios.intentosUsuario,
            acpsy_usuarios.fechaAlta, 
            acpsy_usuarios.profileUsuario, 
            acpsy_usuarios.idPerfil, 
            acpsy_perfiles.detallePerfil, 
            acpsy_usuarios.idEstado, 
            acpsy_estadosu.detalleEstadoU
        FROM
            acpsy_usuarios
            INNER JOIN
            acpsy_perfiles
            ON 
                acpsy_usuarios.idPerfil = acpsy_perfiles.idPerfil
            INNER JOIN
            acpsy_estadosu
            ON 
		acpsy_usuarios.idEstado = acpsy_estadosu.idEstado 
        WHERE $item = :$item 
            ORDER BY acpsy_usuarios.idPerfil ASC");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_USUARIOS()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarPerfilesUsuarios($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            acpsy_perfiles.idPerfil, 
            acpsy_perfiles.detallePerfil
        FROM
            acpsy_perfiles WHERE $item = :$item");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_PERFILES_USUARIO()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }

    static public function mdlRegistrarUsuario($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_USUARIO(:idPerfil,:dniUsuario,:apellidosUsuario,:nombresUsuario,:cuentaUsuario,:correoUsuario,:claveUsuario)");
        $stmt->bindParam(":idPerfil", $datos["idPerfil"], PDO::PARAM_INT);
        $stmt->bindParam(":dniUsuario", $datos["dniUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":apellidosUsuario", $datos["apellidosUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":nombresUsuario", $datos["nombresUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":cuentaUsuario", $datos["cuentaUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":correoUsuario", $datos["correoUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":claveUsuario", $datos["claveUsuario"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEditarUsuario($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_USUARIO(:idUsuario,:idPerfil,:dniUsuario,:apellidosUsuario,:nombresUsuario,:cuentaUsuario,:correoUsuario,:claveUsuario)");
        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idPerfil", $datos["idPerfil"], PDO::PARAM_INT);
        $stmt->bindParam(":dniUsuario", $datos["dniUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":apellidosUsuario", $datos["apellidosUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":nombresUsuario", $datos["nombresUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":cuentaUsuario", $datos["cuentaUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":correoUsuario", $datos["correoUsuario"], PDO::PARAM_STR);
        $stmt->bindParam(":claveUsuario", $datos["claveUsuario"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlActualizarUsuario($idUsuario, $idEstado)
    {
        $stmt = Conexion::conectar()->prepare("CALL HABILITAR_USUARIO(:idUsuario,:idEstado)");
        $stmt->bindParam(":idUsuario", $idUsuario, PDO::PARAM_STR);
        $stmt->bindParam(":idEstado", $idEstado, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlDesbloquearUsuario($idUsuario)
    {
        $stmt = Conexion::conectar()->prepare("CALL DESBLOQUEAR_USUARIO(:idUsuario)");
        $stmt->bindParam(":idUsuario", $idUsuario, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }

    static public function mdlValidarEstado($idUsuario)
    {
        $stmt = Conexion::conectar()->prepare("CALL VERIFICA_ESTADO_LOG(:idUsuario)");
        $stmt->bindParam(":idUsuario", $idUsuario, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlEliminarUsuario($dato)
    {
        $stmt = Conexion::conectar()->prepare("CALL ELIMINAR_USUARIO(:idUsuario)");
        $stmt->bindParam(":idUsuario", $dato, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
