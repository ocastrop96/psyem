<?php
require_once "dbConnect.php";
class ReportesModelo
{
    static public function mdlListarWidgets()
    {
        $stmt = Conexion::conectar()->prepare("CALL LISTAR_WIDGETS()");
        $stmt->execute();
        return $stmt->fetch();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListar10Diagnosticos()
    {
        $stmt = Conexion::conectar()->prepare("CALL GRAFICO_DIAGNOSTICOS()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    static public function mdlListarSeguimientos()
    {
        $stmt = Conexion::conectar()->prepare("CALL GRAFICO_SEGUIMIENTO_MENSUAL()");
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarAteRegAnu($inicio, $fin)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_ATEREGANU(:inicio,:fin)");
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarParentReg($inicio, $fin)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_PARENTESCO(:inicio,:fin)");
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarSexReg($inicio, $fin)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEXO(:inicio,:fin)");
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarSegReg($inicio, $fin)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMREGS(:inicio,:fin)");
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarSeguixProfesional($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMIENTOXPROFESIONAL(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarSeguixTipo($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMIENTOXTIPO(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarSeguixDiagPac($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMIENTOXDIAGPAC(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlListarSeguixDiagFam($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMIENTOXDIAGFAM(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlSeguiMensxPro($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGMENSXPROFESIONAL(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlSeguiTipxPro($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGTIPOXPROFESIONAL(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    // Reportes excel
    static public function mdlReporteAudAtenciones($inicio, $fin)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_AUDIATENCIONES(:inicio,:fin)");
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlReporteAudFamiliares($inicio, $fin)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_AUDIFAMILIARES(:inicio,:fin)");
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlReporteSeguimientoJefatura($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMIENTO_JEFATURA(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }

    static public function mdlReporteSeguimientoProfesional($inicio, $fin, $profesional)
    {
        $stmt = Conexion::conectar()->prepare("CALL REPORTE_SEGUIMIENTO_PROFESIONAL(:inicio,:fin,:profesional)");
        $stmt->bindParam(":profesional", $profesional, PDO::PARAM_INT);
        $stmt->bindParam(":inicio", $inicio, PDO::PARAM_STR);
        $stmt->bindParam(":fin", $fin, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetchAll();
        $stmt->close();
        $stmt = null;
    }
    // Reportes excel
}
