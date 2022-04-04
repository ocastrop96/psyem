<?php
require_once "dbConnect.php";
class SeguimientosModelo
{
    static public function mdlListarSeguimientos($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            acpsy_seguimiento.idSeguimiento, 
                date_format(acpsy_seguimiento.fRegistrSeg,'%d/%m/%Y') as fRegistrSeg, 
            acpsy_seguimiento.idAtencionPac, 
            acpsy_atencion.cuentaAtencion, 
            acpsy_atencion.tipdocAtencion,
            acpsy_atencion.nrodocAtencion,
            acpsy_atencion.historiaAtencion, 
            acpsy_atencion.nombAtencion, 
            acpsy_atencion.apPaternoAtencion, 
            acpsy_atencion.apMaternoAtencion, 
            acpsy_seguimiento.idTipoSeguimiento, 
            acpsy_tiposeguimiento.detaTipSeguimiento, 
            acpsy_seguimiento.idMotSeguimiento, 
            acpsy_motivoseguimiento.detaMotivoSef, 
            acpsy_seguimiento.idProfesional, 
            acpsy_profesionales.nombresProfesional, 
            acpsy_profesionales.apellidosProfesional, 
            acpsy_seguimiento.comunFamSeg, 
            acpsy_seguimiento.idDiag1Seg, 
            acpsy_diagnosticos.cieDiagnostico as cieP1,
            acpsy_diagnosticos.detaDiagnostico as detaD1, 
            acpsy_seguimiento.idDiag2Seg,
            dp2.cieDiagnostico as cieP2,
            dp2.detaDiagnostico as detD2, 		
            acpsy_seguimiento.idFamAtSeg, 
            acpsy_famatencion.nombApFamiliar,
            acpsy_famatencion.telcelFamiliar,
            acpsy_parentescofam.detaParentesco,
            acpsy_seguimiento.idDiag1SegFam,
            df1.cieDiagnostico as cieDF1,
            df1.detaDiagnostico as detDF1,  
            acpsy_seguimiento.idDiag2SegFam,
            df2.cieDiagnostico as cieDF2,
            df2.detaDiagnostico as detDF2,   
            acpsy_seguimiento.obsSeg, 
            acpsy_seguimiento.idStatusSeg, 
            acpsy_estatusseguimiento.detaStatusSeg
            FROM
            acpsy_seguimiento
            INNER JOIN
            acpsy_atencion
            ON 
                acpsy_seguimiento.idAtencionPac = acpsy_atencion.idAtencion
            INNER JOIN
            acpsy_profesionales
            ON 
                acpsy_seguimiento.idProfesional = acpsy_profesionales.idProfesional
            INNER JOIN
            acpsy_tiposeguimiento
            ON 
                acpsy_seguimiento.idTipoSeguimiento = acpsy_tiposeguimiento.idTipoSeguimiento
            INNER JOIN
            acpsy_motivoseguimiento
            ON 
                acpsy_seguimiento.idMotSeguimiento = acpsy_motivoseguimiento.idMotSeguimiento
            INNER JOIN
            acpsy_estatusseguimiento
            ON 
                acpsy_seguimiento.idStatusSeg = acpsy_estatusseguimiento.idStatusSeg
            LEFT JOIN
            acpsy_famatencion
            ON 
                acpsy_seguimiento.idFamAtSeg = acpsy_famatencion.idFamiliar
            INNER JOIN
            acpsy_diagnosticos
            ON 
                acpsy_seguimiento.idDiag1Seg = acpsy_diagnosticos.idDiagnostico
            LEFT JOIN
            acpsy_diagnosticos as dp2
            ON 
            acpsy_seguimiento.idDiag2Seg = dp2.idDiagnostico
            LEFT JOIN
            acpsy_diagnosticos as df1
            ON 
            acpsy_seguimiento.idDiag1SegFam = df1.idDiagnostico
            LEFT JOIN
            acpsy_diagnosticos as df2
            ON 
            acpsy_seguimiento.idDiag2SegFam = df2.idDiagnostico
            LEFT JOIN
            acpsy_parentescofam
            ON
            acpsy_famatencion.idParentesco = acpsy_parentescofam.idParentesco
            WHERE $item = :$item
            ORDER BY acpsy_seguimiento.fRegistrSeg desc, acpsy_seguimiento.idSeguimiento desc");
            $stmt->bindParam(":" . $item, $valor, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetch();
        } else {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS()");
            $stmt->execute();
            return $stmt->fetchAll();
        }
        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarSeguimientosF($fechaInicialSeg, $fechaFinalSeg, $Profesional)
    {
        if ($fechaInicialSeg == null) {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_F(:idProfesional)");
            $stmt->bindParam(":idProfesional", $Profesional, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } else if ($fechaInicialSeg == $fechaFinalSeg) {

            $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_FECHAS(:fechaFinalSeg,:fechaFinalSeg,:idProfesional);");
            $stmt->bindParam(":fechaFinalSeg", $fechaFinalSeg, PDO::PARAM_STR);
            $stmt->bindParam(":idProfesional", $Profesional, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } else {
            $fechaActual = new DateTime();
            $fechaActual->add(new DateInterval("P1D"));
            $fechaActualMasUno = $fechaActual->format("Y-m-d");

            $fechaFinalSeg2 = new DateTime($fechaFinalSeg);
            $fechaFinalSeg2->add(new DateInterval("P1D"));
            $fechaFinalSegMasUno = $fechaFinalSeg2->format("Y-m-d");

            if ($fechaFinalSegMasUno == $fechaActualMasUno) {
                $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_FECHAS(:fechaInicialSeg,:fechaFinalSegMasUno,:idProfesional)");
                $stmt->bindParam(":fechaInicialSeg", $fechaInicialSeg, PDO::PARAM_STR);
                $stmt->bindParam(":fechaFinalSegMasUno", $fechaFinalSegMasUno, PDO::PARAM_STR);
                $stmt->bindParam(":idProfesional", $Profesional, PDO::PARAM_INT);
            } else {
                $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_FECHAS(:fechaInicialSeg,:fechaFinalSeg,:idProfesional)");
                $stmt->bindParam(":fechaInicialSeg", $fechaInicialSeg, PDO::PARAM_STR);
                $stmt->bindParam(":fechaFinalSeg", $fechaFinalSeg, PDO::PARAM_STR);
                $stmt->bindParam(":idProfesional", $Profesional, PDO::PARAM_INT);
            }
            $stmt->execute();
            return $stmt->fetchAll();
        }

        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarMonitoreoF($fechaInicialMonit, $fechaFinalMonit)
    {
        if ($fechaInicialMonit == null) {
            $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_MONITOREO()");
            $stmt->execute();
            return $stmt->fetchAll();
        } else if ($fechaInicialMonit == $fechaFinalMonit) {

            $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_MONITOREO_FECHAS(:fechaFinalMonit,:fechaFinalMonit);");
            $stmt->bindParam(":fechaFinalMonit", $fechaInicialMonit, PDO::PARAM_STR);
            $stmt->execute();
            return $stmt->fetchAll();
        } else {
            $fechaActual = new DateTime();
            $fechaActual->add(new DateInterval("P1D"));
            $fechaActualMasUno = $fechaActual->format("Y-m-d");

            $fechaFinalMonit2 = new DateTime($fechaFinalMonit);
            $fechaFinalMonit2->add(new DateInterval("P1D"));
            $fechaFinalMonitMasUno = $fechaFinalMonit2->format("Y-m-d");

            if ($fechaFinalMonitMasUno == $fechaActualMasUno) {
                $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_MONITOREO_FECHAS(:fechaInicialMonit,:fechaFinalMonitMasUno)");
                $stmt->bindParam(":fechaInicialMonit", $fechaInicialMonit, PDO::PARAM_STR);
                $stmt->bindParam(":fechaFinalMonitMasUno", $fechaFinalMonitMasUno, PDO::PARAM_STR);
            } else {
                $stmt = Conexion::conectar()->prepare("CALL LISTAR_SEGUIMIENTOS_MONITOREO_FECHAS(:fechaInicialMonit,:fechaFinalMonit)");
                $stmt->bindParam(":fechaInicialMonit", $fechaInicialMonit, PDO::PARAM_STR);
                $stmt->bindParam(":fechaFinalMonit", $fechaFinalMonit, PDO::PARAM_STR);
            }
            $stmt->execute();
            return $stmt->fetchAll();
        }

        //Cerramos la conexion por seguridad
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarHistorialPaciente($idPaciente)
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_HISTORIAL_PACIENTE(:idPaciente)");
        $stmt->bindParam(":idPaciente", $idPaciente, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarTiposSeguimiento()
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_TIPO_SEGUIMIENTO()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarMotivoSeguimiento()
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_MOTIVOS_SEGUIMIENTO()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarEtapaSeguimiento()
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_ETAPAS_SEGUIMIENTO()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlRegistrarSeguimiento($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_SEGUIMIENTO(:fRegistrSeg,:idUsuario,:idAtencionPac,:idProfesional,:idTipoSeguimiento,:idMotSeguimiento,:idDiag1Seg,:idDiag2Seg,:comunFamSeg,:idFamAtSeg,:idDiag1SegFam,:idDiag2SegFam,:obsSeg)");

        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionPac", $datos["idAtencionPac"], PDO::PARAM_INT);
        $stmt->bindParam(":idProfesional", $datos["idProfesional"], PDO::PARAM_INT);
        $stmt->bindParam(":idTipoSeguimiento", $datos["idTipoSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idMotSeguimiento", $datos["idMotSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1Seg", $datos["idDiag1Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2Seg", $datos["idDiag2Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idFamAtSeg", $datos["idFamAtSeg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1SegFam", $datos["idDiag1SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2SegFam", $datos["idDiag2SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":fRegistrSeg", $datos["fRegistrSeg"], PDO::PARAM_STR);
        $stmt->bindParam(":comunFamSeg", $datos["comunFamSeg"], PDO::PARAM_STR);
        $stmt->bindParam(":obsSeg", $datos["obsSeg"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlEditarSeguimiento($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_SEGUIMIENTO(:idSeguimiento,:fRegistrSeg,:idAtencionPac,:idProfesional,:idTipoSeguimiento,:idMotSeguimiento,:idDiag1Seg,:idDiag2Seg,:comunFamSeg,:idFamAtSeg,:idDiag1SegFam,:idDiag2SegFam,:obsSeg)");

        $stmt->bindParam(":idSeguimiento", $datos["idSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionPac", $datos["idAtencionPac"], PDO::PARAM_INT);
        $stmt->bindParam(":idProfesional", $datos["idProfesional"], PDO::PARAM_INT);
        $stmt->bindParam(":idTipoSeguimiento", $datos["idTipoSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idMotSeguimiento", $datos["idMotSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1Seg", $datos["idDiag1Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2Seg", $datos["idDiag2Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idFamAtSeg", $datos["idFamAtSeg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1SegFam", $datos["idDiag1SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2SegFam", $datos["idDiag2SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":fRegistrSeg", $datos["fRegistrSeg"], PDO::PARAM_STR);
        $stmt->bindParam(":comunFamSeg", $datos["comunFamSeg"], PDO::PARAM_STR);
        $stmt->bindParam(":obsSeg", $datos["obsSeg"], PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
    static public function mdlAnularSeguimiento($datos)
    {
        $stmt = Conexion::conectar()->prepare("CALL ANULAR_SEGUIMIENTO(:idSeguimiento)");
        $stmt->bindParam(":idSeguimiento", $datos, PDO::PARAM_INT);
        if ($stmt->execute()) {
            return "ok";
        } else {
            return "error";
        }
        $stmt->close();
        $stmt = null;
    }
}
