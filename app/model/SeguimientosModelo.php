<?php
require_once "dbConnect.php";
class SeguimientosModelo
{
    static public function mdlListarSeguimientos($item, $valor)
    {
        if ($item != null) {
            $stmt = Conexion::conectar()->prepare("SELECT
            psyem_seguimiento.idSeguimiento,
            date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg,
            psyem_seguimiento.idAtencionPac,
            psyem_atencion.cuentaAtencion,
            psyem_atencion.tipdocAtencion,
            psyem_atencion.nrodocAtencion,
            psyem_atencion.historiaAtencion,
            psyem_atencion.nombAtencion,
            psyem_atencion.apPaternoAtencion,
            psyem_atencion.apMaternoAtencion,
            psyem_seguimiento.idTipoSeguimiento,
            psyem_tiposeguimiento.detaTipSeguimiento,
            psyem_seguimiento.idMotSeguimiento,
            psyem_motivoseguimiento.detaMotivoSef,
            psyem_seguimiento.idProfesional,
            psyem_profesionales.nombresProfesional,
            psyem_profesionales.apellidosProfesional,
            psyem_seguimiento.comunFamSeg,
            psyem_seguimiento.idDiag1Seg,
            psyem_diagnosticos.cieDiagnostico AS cieP1,
            psyem_diagnosticos.detaDiagnostico AS detaD1,
            psyem_seguimiento.idDiag2Seg,
            dp2.cieDiagnostico AS cieP2,
            dp2.detaDiagnostico AS detD2,
            psyem_seguimiento.idDiag3Seg,
            dp3.cieDiagnostico AS cieP3,
            dp3.detaDiagnostico AS detD3,
            psyem_seguimiento.idDiag4Seg,
            dp4.cieDiagnostico AS cieP4,
            dp4.detaDiagnostico AS detD4,
            psyem_seguimiento.idFamAtSeg,
            psyem_famatencion.nombApFamiliar,
            psyem_famatencion.telcelFamiliar,
            psyem_parentescofam.detaParentesco,
            psyem_seguimiento.idDiag1SegFam,
            df1.cieDiagnostico AS cieDF1,
            df1.detaDiagnostico AS detDF1,
            psyem_seguimiento.idDiag2SegFam,
            df2.cieDiagnostico AS cieDF2,
            df2.detaDiagnostico AS detDF2,
            psyem_seguimiento.idDiag3SegFam,
            df3.cieDiagnostico AS cieDF3,
            df3.detaDiagnostico AS detDF3,
            psyem_seguimiento.idDiag4SegFam,
            df4.cieDiagnostico AS cieDF4,
            df4.detaDiagnostico AS detDF4,
            psyem_seguimiento.obsSeg,
            psyem_seguimiento.idStatusSeg,
            psyem_estatusseguimiento.detaStatusSeg 
        FROM
            psyem_seguimiento
            INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
            INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
            INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
            INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
            INNER JOIN psyem_estatusseguimiento ON psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
            LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
            INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS dp2 ON psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS dp3 ON psyem_seguimiento.idDiag3Seg = dp3.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS dp4 ON psyem_seguimiento.idDiag4Seg = dp4.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS df1 ON psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS df2 ON psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS df3 ON psyem_seguimiento.idDiag3SegFam = df3.idDiagnostico
            LEFT JOIN psyem_diagnosticos AS df4 ON psyem_seguimiento.idDiag4SegFam = df4.idDiagnostico
            LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco 
            WHERE $item = :$item
            ORDER BY psyem_seguimiento.fRegistrSeg desc, psyem_seguimiento.idSeguimiento desc");
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
        $stmt = Conexion::conectar()->prepare("CALL REGISTRAR_SEGUIMIENTO(:fRegistrSeg,:idUsuario,:idAtencionPac,:idProfesional,:idTipoSeguimiento,:idMotSeguimiento,:idDiag1Seg,:idDiag2Seg,:idDiag3Seg,:idDiag4Seg,:comunFamSeg,:idFamAtSeg,:idDiag1SegFam,:idDiag2SegFam,:idDiag3SegFam,:idDiag4SegFam,:obsSeg)");

        $stmt->bindParam(":idUsuario", $datos["idUsuario"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionPac", $datos["idAtencionPac"], PDO::PARAM_INT);
        $stmt->bindParam(":idProfesional", $datos["idProfesional"], PDO::PARAM_INT);
        $stmt->bindParam(":idTipoSeguimiento", $datos["idTipoSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idMotSeguimiento", $datos["idMotSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1Seg", $datos["idDiag1Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2Seg", $datos["idDiag2Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag3Seg", $datos["idDiag3Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag4Seg", $datos["idDiag4Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idFamAtSeg", $datos["idFamAtSeg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1SegFam", $datos["idDiag1SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2SegFam", $datos["idDiag2SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag3SegFam", $datos["idDiag3SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag4SegFam", $datos["idDiag4SegFam"], PDO::PARAM_INT);
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
        $stmt = Conexion::conectar()->prepare("CALL EDITAR_SEGUIMIENTO(:idSeguimiento,:fRegistrSeg,:idAtencionPac,:idProfesional,:idTipoSeguimiento,:idMotSeguimiento,:idDiag1Seg,:idDiag2Seg,:idDiag3Seg,:idDiag4Seg,:comunFamSeg,:idFamAtSeg,:idDiag1SegFam,:idDiag2SegFam,:idDiag3SegFam,:idDiag4SegFam,:obsSeg)");

        $stmt->bindParam(":idSeguimiento", $datos["idSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idAtencionPac", $datos["idAtencionPac"], PDO::PARAM_INT);
        $stmt->bindParam(":idProfesional", $datos["idProfesional"], PDO::PARAM_INT);
        $stmt->bindParam(":idTipoSeguimiento", $datos["idTipoSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idMotSeguimiento", $datos["idMotSeguimiento"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1Seg", $datos["idDiag1Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2Seg", $datos["idDiag2Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag3Seg", $datos["idDiag3Seg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag4Seg", $datos["idDiag4Seg"], PDO::PARAM_INT);


        $stmt->bindParam(":idFamAtSeg", $datos["idFamAtSeg"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag1SegFam", $datos["idDiag1SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag2SegFam", $datos["idDiag2SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag3SegFam", $datos["idDiag3SegFam"], PDO::PARAM_INT);
        $stmt->bindParam(":idDiag4SegFam", $datos["idDiag4SegFam"], PDO::PARAM_INT);

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
