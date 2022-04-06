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
            psyem_usuarios.idUsuario, 
            psyem_usuarios.dniUsuario, 
            psyem_usuarios.apellidosUsuario, 
            psyem_usuarios.nombresUsuario, 
            psyem_usuarios.cuentaUsuario, 
            psyem_usuarios.correoUsuario, 
            psyem_usuarios.claveUsuario, 
            psyem_usuarios.intentosUsuario,
            psyem_usuarios.fechaAlta, 
            psyem_usuarios.profileUsuario, 
            psyem_usuarios.idPerfil, 
            psyem_perfiles.detallePerfil, 
            psyem_usuarios.idEstado, 
            psyem_estadosu.detalleEstadoU
        FROM
            psyem_usuarios
            INNER JOIN
            psyem_perfiles
            ON 
                psyem_usuarios.idPerfil = psyem_perfiles.idPerfil
            INNER JOIN
            psyem_estadosu
            ON 
		psyem_usuarios.idEstado = psyem_estadosu.idEstado 
        WHERE $item = :$item 
            ORDER BY psyem_usuarios.idPerfil ASC");
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
            psyem_perfiles.idPerfil, 
            psyem_perfiles.detallePerfil
        FROM
            psyem_perfiles WHERE $item = :$item");
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
