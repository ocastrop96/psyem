<?php
require_once "dbConnect.php";
class DiagnosticosModelo
{
    static public function mdlListarDiagnosticos($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            psyem_diagnosticos.idDiagnostico,
            psyem_diagnosticos.cieDiagnostico,
            psyem_diagnosticos.detaDiagnostico 
            FROM
                psyem_diagnosticos 
            WHERE $item = :$item
            ORDER BY psyem_diagnosticos.cieDiagnostico");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_DIAGNOSTICOS()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarNoSeleccionado($existe)
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_DIAGNOSTICO_NO_SELECCIONADO(:idDiagnostico)");
        $stmt->bindParam(":idDiagnostico", $existe, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlRegistrarDiagnostico($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_DIAGNOSTICO(:cieDiagnostico,:detaDiagnostico)");
        $stmt->bindParam(":cieDiagnostico", $datos["cieDiagnostico"], PDO::PARAM_STR);
        $stmt->bindParam(":detaDiagnostico", $datos["detaDiagnostico"], PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEditarDiagnostico($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_DIAGNOSTICO(:idDiagnostico,:cieDiagnostico,:detaDiagnostico)");
        $stmt->bindParam(":idDiagnostico", $datos["idDiagnostico"], PDO::PARAM_INT);
        $stmt->bindParam(":cieDiagnostico", $datos["cieDiagnostico"], PDO::PARAM_STR);
        $stmt->bindParam(":detaDiagnostico", $datos["detaDiagnostico"], PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEliminarDiagnostico($dato)
    {
        $stmt = Conexion::conectar()->prepare("CALL ELIMINAR_DIAGNOSTICO(:idDiagnostico)");
        $stmt->bindParam(":idDiagnostico", $dato, PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
