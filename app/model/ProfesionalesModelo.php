<?php
require_once "dbConnect.php";
class ProfesionalesModelo
{
    static public function mdlListarProfesionales($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            psyem_profesionales.idProfesional,
            psyem_profesionales.idEstado, 
            psyem_estadoprof.detaEstadoProf, 
            psyem_profesionales.idCondicion, 
            psyem_condicionprof.detaCondicion, 
            psyem_profesionales.dniProfesional, 
            psyem_profesionales.cpspProfesional, 
            psyem_profesionales.apellidosProfesional, 
            psyem_profesionales.nombresProfesional
        FROM
            psyem_profesionales
            INNER JOIN
            psyem_estadoprof
            ON 
                psyem_profesionales.idEstado = psyem_estadoprof.idEstadoProf
            INNER JOIN
            psyem_condicionprof
            ON 
                psyem_profesionales.idCondicion = psyem_condicionprof.idCondicion
                WHERE $item = :$item
                ORDER BY psyem_profesionales.apellidosProfesional ASC");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_PROFESIONALES()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarCondiciones()
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_CONDICIONES_PROF()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlRegistrarProfesional($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_PROFESIONAL(:idCondicion,:dniProfesional,:cpspProfesional,:apellidosProfesional,:nombresProfesional)");
        $stmt->bindParam(":idCondicion", $datos["idCondicion"], PDO::PARAM_INT);
        $stmt->bindParam(":dniProfesional", $datos["dniProfesional"], PDO::PARAM_STR);
        $stmt->bindParam(":cpspProfesional", $datos["cpspProfesional"], PDO::PARAM_STR);
        $stmt->bindParam(":apellidosProfesional", $datos["apellidosProfesional"], PDO::PARAM_STR);
        $stmt->bindParam(":nombresProfesional", $datos["nombresProfesional"], PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEditarProfesional($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_PROFESIONAL(:idProfesional,:idCondicion,:dniProfesional,:cpspProfesional,:apellidosProfesional,:nombresProfesional)");
        $stmt->bindParam(":idProfesional", $datos["idProfesional"], PDO::PARAM_INT);
        $stmt->bindParam(":idCondicion", $datos["idCondicion"], PDO::PARAM_INT);
        $stmt->bindParam(":dniProfesional", $datos["dniProfesional"], PDO::PARAM_STR);
        $stmt->bindParam(":cpspProfesional", $datos["cpspProfesional"], PDO::PARAM_STR);
        $stmt->bindParam(":apellidosProfesional", $datos["apellidosProfesional"], PDO::PARAM_STR);
        $stmt->bindParam(":nombresProfesional", $datos["nombresProfesional"], PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlHabilitarProfesional($idProfesional, $idEstado)
    {
        $stmt = Conexion::conectar()->prepare("CALL HABILITAR_PROFESIONAL(:idProfesional,:idEstado)");
        $stmt->bindParam(":idProfesional", $idProfesional, PDO::PARAM_STR);
        $stmt->bindParam(":idEstado", $idEstado, PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEliminarProfesional($dato)
    {
        $stmt = Conexion::conectar()->prepare("CALL ELIMINAR_PROFESIONAL(:idProfesional)");
        $stmt->bindParam(":idProfesional", $dato, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
