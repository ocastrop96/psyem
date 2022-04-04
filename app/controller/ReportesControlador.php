<?php
class ReportesControlador
{
    static public function ctrListarWidgets()
    {
        $repuesta = ReportesModelo::mdlListarWidgets();
        return $repuesta;
    }

    static public function ctrListar10Diagnosticos()
    {
        $repuesta = ReportesModelo::mdlListar10Diagnosticos();
        return $repuesta;
    }
    static public function ctrListarSeguimientosMensual()
    {
        $repuesta = ReportesModelo::mdlListarSeguimientos();
        return $repuesta;
    }

    static public function ctrListarAteRegAnu($inicio, $fin)
    {
        $repuesta = ReportesModelo::mdlListarAteRegAnu($inicio, $fin);
        return $repuesta;
    }

    static public function ctrListarParentReg($inicio, $fin)
    {
        $repuesta = ReportesModelo::mdlListarParentReg($inicio, $fin);
        return $repuesta;
    }
    static public function ctrListarSexReg($inicio, $fin)
    {
        $repuesta = ReportesModelo::mdlListarSexReg($inicio, $fin);
        return $repuesta;
    }

    static public function ctrListarSegRegs($inicio, $fin)
    {
        $repuesta = ReportesModelo::mdlListarSegReg($inicio, $fin);
        return $repuesta;
    }


    static public function ctrListarSeguixProfesional($inicio, $fin, $profesional)
    {
        $repuesta = ReportesModelo::mdlListarSeguixProfesional($inicio, $fin, $profesional);
        return $repuesta;
    }
    static public function ctrListarSeguixTipo($inicio, $fin, $profesional)
    {
        $repuesta = ReportesModelo::mdlListarSeguixTipo($inicio, $fin, $profesional);
        return $repuesta;
    }

    static public function ctrListarSeguixDiagPac($inicio, $fin, $profesional)
    {
        $repuesta = ReportesModelo::mdlListarSeguixDiagPac($inicio, $fin, $profesional);
        return $repuesta;
    }

    static public function ctrListarSeguixDiagFam($inicio, $fin, $profesional)
    {
        $repuesta = ReportesModelo::mdlListarSeguixDiagFam($inicio, $fin, $profesional);
        return $repuesta;
    }

    static public function ctrListarSeguiMensxPro($inicio, $fin, $profesional)
    {
        $repuesta = ReportesModelo::mdlSeguiMensxPro($inicio, $fin, $profesional);
        return $repuesta;
    }

    static public function ctrListarSeguiTipxPro($inicio, $fin, $profesional)
    {
        $repuesta = ReportesModelo::mdlSeguiTipxPro($inicio, $fin, $profesional);
        return $repuesta;
    }
    // Reportes Excel
    static public function ctrReporteAudiAtenciones()
    {
        if (isset($_GET["reporte"])) {
            if (isset($_GET["inicio"]) && isset($_GET["fin"])) {
                $visitasReport = ReportesModelo::mdlReporteAudAtenciones($_GET["inicio"], $_GET["fin"]);
                $Name = 'REPORTE_AUDITORIA-ATENCIONES_DE_' . $_GET["inicio"] . '_A_' . $_GET["fin"] . '.xls';
            } else {
                $visitasReport = ReportesModelo::mdlReporteAudAtenciones("", "");
                $Name = 'REPORTE-GENERAL-AUDITORIA-ATENCIONES' . '.xls';
            }
            // Creación de archivo excel

            header('Expires: 0');
            header('Cache-control: private');
            header("Content-type: application/vnd.ms-excel"); // Archivo de Excel
            header("Cache-Control: cache, must-revalidate");
            header('Content-Description: File Transfer');
            header('Last-Modified: ' . date('D, d M Y H:i:s'));
            header("Pragma: public");
            header('Content-Disposition:; filename="' . $Name . '"');
            header("Content-Transfer-Encoding: binary");

            echo utf8_decode("<table border='0'> 
					<tr> 
					<td style='font-weight:bold; background-color:#ddd;'>N°</td> 
					<td style='font-weight:bold; background-color:#ddd;'>FECHA</td>
                    <td style='font-weight:bold; background-color:#ddd;'>TIPO N° DOC</td>
					<td style='font-weight:bold; background-color:#ddd;'>PACIENTE</td>
					<td style='font-weight:bold; background-color:#ddd;'>ACCION REALIZADA</td>
					<td style='font-weight:bold; background-color:#ddd;'>CUENTA ANTERIOR</td>		
					<td style='font-weight:bold; background-color:#ddd;'>EPISODIO ANTERIOR</td>		
                    <td style='font-weight:bold; background-color:#ddd;'>CUENTA NUEVA</td>
                    <td style='font-weight:bold; background-color:#ddd;'>EPISODIO NUEVO</td>	
					<td style='font-weight:bold; background-color:#ddd;'>USUARIO</td>	
                    </tr>");
            foreach ($visitasReport as $row => $item) {
                echo utf8_decode("<tr>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . ($row + 1) . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["fechaRegistro"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["tipdocAtencion"] . "-" . $item["nrodocAtencion"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["nombAtencion"] . " " . $item["apPaternoAtencion"] . " " . $item["apMaternoAtencion"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["AccRealizada"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["cuentaAnterior"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["EpisodioAnterior"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["cuentaNueva"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["EpisodioNuevo"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["cuentaUsuario"] . "</td>
                </tr>");
            }
            echo "</table>";
        }
    }

    static public function ctrReporteAudiFamilares()
    {
        if (isset($_GET["reporte"])) {
            if (isset($_GET["inicio"]) && isset($_GET["fin"])) {
                $visitasReport = ReportesModelo::mdlReporteAudFamiliares($_GET["inicio"], $_GET["fin"]);
                $Name = 'REPORTE_AUDITORIA-FAMILIARES_DE_' . $_GET["inicio"] . '_A_' . $_GET["fin"] . '.xls';
            } else {
                $visitasReport = ReportesModelo::mdlReporteAudFamiliares("", "");
                $Name = 'REPORTE-GENERAL-AUDITORIA-FAMILIARES' . '.xls';
            }
            // Creación de archivo excel

            header('Expires: 0');
            header('Cache-control: private');
            header("Content-type: application/vnd.ms-excel"); // Archivo de Excel
            header("Cache-Control: cache, must-revalidate");
            header('Content-Description: File Transfer');
            header('Last-Modified: ' . date('D, d M Y H:i:s'));
            header("Pragma: public");
            header('Content-Disposition:; filename="' . $Name . '"');
            header("Content-Transfer-Encoding: binary");
            echo utf8_decode("<table border='0'> 
					<tr> 
					<td style='font-weight:bold; background-color:#ddd;'>N°</td> 
					<td style='font-weight:bold; background-color:#ddd;'>FECHA</td>
                    <td style='font-weight:bold; background-color:#ddd;'>TIPO N° DOC</td>
					<td style='font-weight:bold; background-color:#ddd;'>FAMILIAR</td>
					<td style='font-weight:bold; background-color:#ddd;'>ACCION REALIZADA</td>
					<td style='font-weight:bold; background-color:#ddd;'>ID ANTERIOR</td>		
					<td style='font-weight:bold; background-color:#ddd;'>NDOC ANTERIOR</td>		
                    <td style='font-weight:bold; background-color:#ddd;'>ID NUEVA</td>
                    <td style='font-weight:bold; background-color:#ddd;'>NDOC NUEVO</td>	
					<td style='font-weight:bold; background-color:#ddd;'>USUARIO</td>	
                    </tr>");
            foreach ($visitasReport as $row => $item) {
                echo utf8_decode("<tr>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . ($row + 1) . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["fechaRegistro"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["tipdocFamiliar"] . "-" . $item["ndocFamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["nombApFamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["AccRealizada"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["idAtencionAnt"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["ndocAnt"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["idAtencionNueva"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["ndocNuevo"] . "</td>
                <td style='padding:0.5em; border:1px solid #ccc;'>" . $item["cuentaUsuario"] . "</td>
                </tr>");
            }
            echo "</table>";
        }
    }
    static public function ctrReporteSeguimientoJefatura()
    {
        if (isset($_GET["reporte"])) {
            if (isset($_GET["inicio"]) && isset($_GET["fin"]) && isset($_GET["profesional"])) {
                $visitasReport = ReportesModelo::mdlReporteSeguimientoJefatura($_GET["inicio"], $_GET["fin"], $_GET["profesional"]);
                $Name = 'REPORTE_SEGUIMIENTOS-DE-' . $_GET["inicio"] . '_A_' . $_GET["fin"] . '.xls';
            } else {
                $visitasReport = ReportesModelo::mdlReporteSeguimientoJefatura("", "", 0);
                $Name = 'REPORTE-GENERAL-SEGUIMIENTOS-' . date('F-Y') . '.xls';
            }
            // Creación de archivo excel
            header('Expires: 0');
            header('Cache-control: private');
            header("Content-type: application/vnd.ms-excel");
            header("Cache-Control: cache, must-revalidate");
            header('Content-Description: File Transfer');
            header('Last-Modified: ' . date('D, d M Y H:i:s'));
            header("Pragma: public");
            header('Content-Disposition:; filename="' . $Name . '"');
            header("Content-Transfer-Encoding: binary");
            echo utf8_decode("<table border='0'> 
					<tr> 
					<td style='font-weight:bold; background-color:#ddd;'>N°</td> 
					<td style='font-weight:bold; background-color:#ddd;'>FECHA</td>
                    <td style='font-weight:bold; background-color:#ddd;'>TIPO</td>
					<td style='font-weight:bold; background-color:#ddd;'>MOTIVO</td>
					<td style='font-weight:bold; background-color:#ddd;'>DOC PAC</td>
					<td style='font-weight:bold; background-color:#ddd;'>HC</td>		
					<td style='font-weight:bold; background-color:#ddd;'>PACIENTE</td>		
                    <td style='font-weight:bold; background-color:#ddd;'>EDAD</td>
                    <td style='font-weight:bold; background-color:#ddd;'>SEXO</td>	
					<td style='font-weight:bold; background-color:#ddd;'>DIAG PAC</td>
                    <td style='font-weight:bold; background-color:#ddd;'>ACT PAC</td> 
					<td style='font-weight:bold; background-color:#ddd;'>COMUNICACION</td>
                    <td style='font-weight:bold; background-color:#ddd;'>DOC FAM</td>
					<td style='font-weight:bold; background-color:#ddd;'>FAMILIAR</td>
					<td style='font-weight:bold; background-color:#ddd;'>PARENTESCO</td>
					<td style='font-weight:bold; background-color:#ddd;'>EDAD</td>		
					<td style='font-weight:bold; background-color:#ddd;'>SEXO</td>		
                    <td style='font-weight:bold; background-color:#ddd;'>DIAG FAM</td>
                    <td style='font-weight:bold; background-color:#ddd;'>ACT FAM</td>	
					<td style='font-weight:bold; background-color:#ddd;'>PROFESIONAL</td>	
                    </tr>");
            foreach ($visitasReport as $row => $item) {
                echo utf8_decode("<tr>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . ($row + 1) . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["fecha"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["tipo"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["motivo"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["docpaciente"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["historiaAtencion"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["nombpaciente"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["edadPaciente"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["sexoPac"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["diagPac"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["actPac"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["comunicacion"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["docfamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["nombApFamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["parentesco"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["edadFamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["sexoFam"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["diagFam"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["actFam"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["profesional"] . "</td>
                </tr>");
            }
            echo "</table>";
        }
    }

    static public function ctrReporteSeguimientoProfesional()
    {
        if (isset($_GET["reporte"])) {
            if (isset($_GET["inicio"]) && isset($_GET["fin"]) && isset($_GET["profesional"])) {
                $visitasReport = ReportesModelo::mdlReporteSeguimientoProfesional($_GET["inicio"], $_GET["fin"], $_GET["profesional"]);
                $Name = 'REPORTE_SEGUIMIENTOS-DE-' . $_GET["inicio"] . '_A_' . $_GET["fin"] . '.xls';
            } else {
                $visitasReport = ReportesModelo::mdlReporteSeguimientoProfesional("", "", $_GET["profesional"]);
                $Name = 'REPORTE-GENERAL-SEGUIMIENTOS-' . date('F-Y') . '.xls';
            }
            // Creación de archivo excel
            header('Expires: 0');
            header('Cache-control: private');
            header("Content-type: application/vnd.ms-excel");
            header("Cache-Control: cache, must-revalidate");
            header('Content-Description: File Transfer');
            header('Last-Modified: ' . date('D, d M Y H:i:s'));
            header("Pragma: public");
            header('Content-Disposition:; filename="' . $Name . '"');
            header("Content-Transfer-Encoding: binary");
            echo utf8_decode("<table border='0'> 
					<tr> 
					<td style='font-weight:bold; background-color:#ddd;'>N°</td> 
					<td style='font-weight:bold; background-color:#ddd;'>FECHA</td>
                    <td style='font-weight:bold; background-color:#ddd;'>TIPO</td>
					<td style='font-weight:bold; background-color:#ddd;'>MOTIVO</td>
					<td style='font-weight:bold; background-color:#ddd;'>DOC PAC</td>
					<td style='font-weight:bold; background-color:#ddd;'>HC</td>		
					<td style='font-weight:bold; background-color:#ddd;'>PACIENTE</td>		
                    <td style='font-weight:bold; background-color:#ddd;'>EDAD</td>
                    <td style='font-weight:bold; background-color:#ddd;'>SEXO</td>	
					<td style='font-weight:bold; background-color:#ddd;'>DIAG PAC</td>
                    <td style='font-weight:bold; background-color:#ddd;'>ACT PAC</td> 
					<td style='font-weight:bold; background-color:#ddd;'>COMUNICACION</td>
                    <td style='font-weight:bold; background-color:#ddd;'>DOC FAM</td>
					<td style='font-weight:bold; background-color:#ddd;'>FAMILIAR</td>
					<td style='font-weight:bold; background-color:#ddd;'>PARENTESCO</td>
					<td style='font-weight:bold; background-color:#ddd;'>EDAD</td>		
					<td style='font-weight:bold; background-color:#ddd;'>SEXO</td>		
                    <td style='font-weight:bold; background-color:#ddd;'>DIAG FAM</td>
                    <td style='font-weight:bold; background-color:#ddd;'>ACT FAM</td>	
					<td style='font-weight:bold; background-color:#ddd;'>PROFESIONAL</td>	
                    </tr>");
            foreach ($visitasReport as $row => $item) {
                echo utf8_decode("<tr>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . ($row + 1) . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["fecha"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["tipo"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["motivo"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["docpaciente"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["historiaAtencion"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["nombpaciente"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["edadPaciente"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["sexoPac"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["diagPac"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["actPac"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["comunicacion"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["docfamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["nombApFamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["parentesco"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["edadFamiliar"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["sexoFam"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["diagFam"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["actFam"] . "</td>
                <td style='padding:0.5em; border:1px solid #D6DBDF;'>" . $item["profesional"] . "</td>
                </tr>");
            }
            echo "</table>";
        }
    }
    // Reportes Excel
}
