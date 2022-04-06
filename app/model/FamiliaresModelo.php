<?php
require_once "dbConnect.php";
class FamiliaresModelo
{
    static public function mdlListarFamiliares($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            psyem_famatencion.idFamiliar,
            date_format(psyem_famatencion.fechaRegistro,'%d/%m/%Y') as fechaRegistro, 
            psyem_famatencion.idAtencion, 
            psyem_atencion.cuentaAtencion, 
            psyem_atencion.historiaAtencion, 
            psyem_atencion.apPaternoAtencion, 
            psyem_atencion.apMaternoAtencion, 
            psyem_atencion.nombAtencion, 
            psyem_famatencion.tipdocFamiliar, 
            psyem_famatencion.ndocFamiliar, 
            psyem_famatencion.nombApFamiliar, 
            psyem_famatencion.idParentesco, 
            psyem_parentescofam.detaParentesco, 
            psyem_famatencion.idTipSexo, 
            psyem_tipsexo.detaTipSexo, 
            psyem_famatencion.edadFamiliar, 
            psyem_famatencion.telcelFamiliar
        FROM
            psyem_famatencion
            INNER JOIN
            psyem_atencion
            ON 
                psyem_famatencion.idAtencion = psyem_atencion.idAtencion
            INNER JOIN
            psyem_parentescofam
            ON 
                psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
            INNER JOIN
            psyem_tipsexo
            ON 
                psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo
            WHERE $item = :$item
            ORDER BY psyem_famatencion.fechaRegistro DESC");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_FAMILIARES()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarFamiliaresF($fechaInicialFam, $fechaFinalFam)
    {
        if ($fechaInicialFam == null) {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_FAMILIARES_F()");
            $stmt->execute();
            return $stmt->fetchAll();
        } else if ($fechaInicialFam == $fechaFinalFam) {

            $stmt = Conexion::conectar()->prepare("CALL LISTAR_FAMILIARES_FECHAS(:fechaFinalFam,:fechaFinalFam);");
            $stmt->bindParam(":fechaFinalFam", $fechaFinalFam, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetchAll();
        } else {
            $fechaActual = new DateTime();
            $fechaActual->add(new DateInterval("P1D"));
            $fechaActualMasUno = $fechaActual->format("Y-m-d");

            $fechaFinalFam2 = new DateTime($fechaFinalFam);
            $fechaFinalFam2->add(new DateInterval("P1D"));
            $fechaFinalFamMasUno = $fechaFinalFam2->format("Y-m-d");

            if ($fechaFinalFamMasUno == $fechaActualMasUno) {
                $stmt = Conexion::conectar()->prepare("CALL LISTAR_FAMILIARES_FECHAS(:fechaInicialFam,:fechaFinalFamMasUno)");
                $stmt->bindParam(":fechaInicialFam", $fechaInicialFam, PDO::PARAM_STR);
                $stmt->bindParam(":fechaFinalFamMasUno", $fechaFinalFamMasUno, PDO::PARAM_STR);
            } else {
                $stmt = Conexion::conectar()->prepare("CALL LISTAR_FAMILIARES_FECHAS(:fechaInicialFam,:fechaFinalFam)");
                $stmt->bindParam(":fechaInicialFam", $fechaInicialFam, PDO::PARAM_STR);
                $stmt->bindParam(":fechaFinalFam", $fechaFinalFam, PDO::PARAM_STR);
            }
            $stmt->execute();
            return $stmt->fetchAll();
        }

        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarPaciente($dato)
    {
        $stmt = Conexion::conectar()->prepare("CALL BUSCAR_PACIENTE(:dato)");
        $stmt->bindParam(":dato", $dato, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarParentesco()
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_PARENTESCO()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarFamiliarPac($existe)
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_FAMILIAR_PACIENTE(:idAtencion)");
        $stmt->bindParam(":idAtencion", $existe, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlValidarPaciente($idAtencion, $ndocFamiliar)
    {
        $stmt = Conexion::conectar()->prepare("CALL VALIDA_FAMILIAR(:idAtencion,:ndocFamiliar)");
        $stmt->bindParam(":idAtencion", $idAtencion, PDO::PARAM_STR);
        $stmt->bindParam(":ndocFamiliar", $ndocFamiliar, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlRegistrarFamiliar($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_FAMILIARES(:fechaRegistro,:idUsuario,:idAtencion,:idParentesco,:idTipSexo,:tipdocFamiliar,:ndocFamiliar,:nombApFamiliar,:edadFamiliar,:telcelFamiliar)");

        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencion", $datos["idAtencion"], PDO::PARAM_INT);
        $stmt->bindParam(":idParentesco", $datos["idParentesco"], PDO::PARAM_INT);
        $stmt->bindParam(":idTipSexo", $datos["idTipSexo"], PDO::PARAM_INT);
        $stmt->bindParam(":fechaRegistro", $datos["fechaRegistro"], PDO::PARAM_STR);
        $stmt->bindParam(":tipdocFamiliar", $datos["tipdocFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":ndocFamiliar", $datos["ndocFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":nombApFamiliar", $datos["nombApFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":edadFamiliar", $datos["edadFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":telcelFamiliar", $datos["telcelFamiliar"], PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEditarFamiliar($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_FAMILIARES(:idFamiliar,:idAtencion,:idParentesco,:idTipSexo,:tipdocFamiliar,:ndocFamiliar,:nombApFamiliar,:edadFamiliar,:telcelFamiliar)");

        $stmt->bindParam(":idFamiliar", $datos["idFamiliar"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencion", $datos["idAtencion"], PDO::PARAM_INT);
        $stmt->bindParam(":idParentesco", $datos["idParentesco"], PDO::PARAM_INT);
        $stmt->bindParam(":idTipSexo", $datos["idTipSexo"], PDO::PARAM_INT);
        $stmt->bindParam(":tipdocFamiliar", $datos["tipdocFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":ndocFamiliar", $datos["ndocFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":nombApFamiliar", $datos["nombApFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":edadFamiliar", $datos["edadFamiliar"], PDO::PARAM_STR);
        $stmt->bindParam(":telcelFamiliar", $datos["telcelFamiliar"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEliminarFamiliar($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL ELIMINAR_FAMILIAR(:idFamiliar, @val)");
        $stmt->bindParam(":idFamiliar", $datos, PDO::PARAM_INT);
        $stmt->execute();
        $value = $stmt->fetch();
        $val2 = $value['nExistencia'];
        if ($val2 == 0) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlAuditoriaFamiliares($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_AUDFAMILIAR(:idFamiliar,:fecRegAudi,:idUsuario,:AccRealizada,:idAtencionAnt, :ndocAnt,:idAtencionNueva,:ndocNuevo)");

        $stmt->bindParam(":idFamiliar", $datos["idFamiliar"], PDO::PARAM_INT);
        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionAnt", $datos["idAtencionAnt"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionNueva", $datos["idAtencionNueva"], PDO::PARAM_INT);
        $stmt->bindParam(":fecRegAudi", $datos["fecRegAudi"], PDO::PARAM_STR);
        $stmt->bindParam(":AccRealizada", $datos["AccRealizada"], PDO::PARAM_STR);
        $stmt->bindParam(":ndocAnt", $datos["ndocAnt"], PDO::PARAM_STR);
        $stmt->bindParam(":ndocNuevo", $datos["ndocNuevo"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlAuditoriaFamiliares2($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_AUDFAMILIAR2(:idFamiliar,:fecRegAudi,:idUsuario,:AccRealizada,:idAtencionAnt, :ndocAnt)");
        $stmt->bindParam(":idFamiliar", $datos["idFamiliar"], PDO::PARAM_INT);
        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionAnt", $datos["idAtencionAnt"], PDO::PARAM_INT);
        $stmt->bindParam(":fecRegAudi", $datos["fecRegAudi"], PDO::PARAM_STR);
        $stmt->bindParam(":AccRealizada", $datos["AccRealizada"], PDO::PARAM_STR);
        $stmt->bindParam(":ndocAnt", $datos["ndocAnt"], PDO::PARAM_STR);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
