<?php
class AtencionesControlador
{
    static public function ctrTraerDatosCuenta($filtro,$dato)
    {
        $repuesta = AtencionesModelo::mdlTraerDatosCuenta($filtro,$dato);
        return $repuesta;
    }
    static public function ctrCargarDatosCuenta($IdCuentaAtencion)
    {
        $repuesta = AtencionesModelo::mdlCargarDatosCuenta($IdCuentaAtencion);
        return $repuesta;
    }
    static public function ctrListarAtencionesF($fechaInicialAte, $fechaFinalAte)
    {
        $rptListAtenF = AtencionesModelo::mdlListarAtencionesF($fechaInicialAte, $fechaFinalAte);
        return $rptListAtenF;
    }
    static public function ctrListarAtenciones($item, $valor)
    {
        $rptListAten = AtencionesModelo::mdlListarAtenciones($item, $valor);
        return $rptListAten;
    }
    static public function ctrListarSexo()
    {
        $rptSexo = AtencionesModelo::mdlListarSexo();
        return $rptSexo;
    }
    static public function ctrListarEstadosPaciente()
    {
        $rptEstadoPac = AtencionesModelo::mdlListarEstadoPac();
        return $rptEstadoPac;
    }
    static public function ctrRegistrarAtencion()
    {
        if (isset($_POST["rgaNCuenta"]) && isset($_POST["rgaNHC"])) {
            if (
                preg_match('/^[0-9]+$/', $_POST["rgaNCuenta"]) &&
                preg_match('/^[0-9]+$/', $_POST["rgaNHC"])
            ) {
                // Seteo de fechas
                date_default_timezone_set('America/Lima');
                $fRegistroAtencion = date("Y-m-d");

                $fNac = $_POST["rgaFNac"];
                $dateFNac = str_replace('/', '-', $fNac);
                $fNac1 = date('Y-m-d', strtotime($dateFNac));

                $fIng = $_POST["rgaFIngServicio"];
                $dateFIng = str_replace('/', '-', $fIng);
                $fIng1 = date('Y-m-d', strtotime($dateFIng));
                // Seteo de fechas
                $datos = array(
                    "fRegistroAtencion" => $fRegistroAtencion,
                    "idEpisodio" => $_POST["idEpisodio"],
                    "cuentaAtencion" => $_POST["rgaNCuenta"],
                    "historiaAtencion" => $_POST["rgaNHC"],
                    "fechaPacNacimiento" => $fNac1,
                    "tipdocAtencion" => $_POST["rgaTdoc"],
                    "nrodocAtencion" => $_POST["rgaNDoc"],
                    "apPaternoAtencion" => $_POST["rgaAPaterno"],
                    "apMaternoAtencion" => $_POST["rgaAMaterno"],
                    "nombAtencion" => $_POST["rgaNombres"],
                    "fIngresoAtencion" => $fIng1,
                    "servAtencion" => $_POST["rgaServicio"],
                    "camaAtencion" => $_POST["rgaCama"],
                    "distritoAtencion" => $_POST["rgaDistrito"],
                    "edadAtencion" => $_POST["rgaEdad"],
                    "financiaAtencion" => $_POST["rgaFinancia"],
                    "idURegAtencion" => $_POST["usuRegAte"],
                    "tipSexoAtencion" => $_POST["rgaSexo"],
                    "idEstadoPacAtencion" => $_POST["rgaEstadoPac"]
                );
                $rptRegistroAtencion = AtencionesModelo::mdlRegistrarAtenciones($datos);
                if ($rptRegistroAtencion == "ok") {
                    echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "¡La atención ha sido registrada con éxito!",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            function redirect(){
                                window.location = "atenciones";
                            }
                            setTimeout(redirect,1100);
                      </script>';
                } else {
                    echo '<script>
                        Swal.fire({
                        icon: "error",
                        title: "Hubo un error al registrar. Intente nuevamente",
                        showConfirmButton: false,
                        timer: 1500
                        });
                        function redirect(){
                            window.location = "atenciones";
                        }
                        setTimeout(redirect,1100);
                    </script>';
                }
            } else {
                echo '<script>
                    Swal.fire({
                    icon: "error",
                    title: "Ingrese correctamente sus datos",
                    showConfirmButton: false,
                    timer: 1500
                    });
                    function redirect(){
                        window.location = "atenciones";
                    }
                    setTimeout(redirect,1000);
                </script>';
            }
        }
    }
    static public function ctrEditarAtencion()
    {
        if (isset($_POST["edtaNCuenta"]) && isset($_POST["edtaNHC"])) {
            if (
                preg_match('/^[0-9]+$/', $_POST["edtaNCuenta"]) &&
                preg_match('/^[0-9]+$/', $_POST["edtaNHC"])
            ) {
                // Seteo de fechas
                date_default_timezone_set('America/Lima');
                $fRegistroAtencionAudit = date("Y-m-d");

                $fNac = $_POST["edtaFNac"];
                $dateFNac = str_replace('/', '-', $fNac);
                $fNac1 = date('Y-m-d', strtotime($dateFNac));

                $fIng = $_POST["edtaFIngServicio"];
                $dateFIng = str_replace('/', '-', $fIng);
                $fIng1 = date('Y-m-d', strtotime($dateFIng));
                // Registro de Auditoría
                $datosAudi = array(
                    "fechaRegAudi" => $fRegistroAtencionAudit,
                    "idAtencion" => $_POST["idAtencion"],
                    "idUsuario" => $_POST["usuEdtAte"],
                    "AccRealizada" => "MODIFICACIÓN",
                    "cuentaAnterior" => $_POST["idCuentaAct"],
                    "EpisodioAnterior" => $_POST["idEpisodioEdtAct"],
                    "cuentaNueva" => $_POST["edtaNCuenta"],
                    "EpisodioNuevo" => $_POST["idEpisodioEdt"]
                );
                // Registro de Auditoría
                $rptEditarAudAtencion = AtencionesModelo::mdlAuditoriaAtenciones($datosAudi);
                // Seteo de fechas
                $datos = array(
                    "idEpisodio" => $_POST["idEpisodioEdt"],
                    "cuentaAtencion" => $_POST["edtaNCuenta"],
                    "historiaAtencion" => $_POST["edtaNHC"],
                    "fechaPacNacimiento" => $fNac1,
                    "tipdocAtencion" => $_POST["edtaTdoc"],
                    "nrodocAtencion" => $_POST["edtaNDoc"],
                    "apPaternoAtencion" => $_POST["edtaAPaterno"],
                    "apMaternoAtencion" => $_POST["edtaAMaterno"],
                    "nombAtencion" => $_POST["edtaNombres"],
                    "fIngresoAtencion" => $fIng1,
                    "servAtencion" => $_POST["edtaServicio"],
                    "camaAtencion" => $_POST["edtaCama"],
                    "distritoAtencion" => $_POST["edtaDistrito"],
                    "edadAtencion" => $_POST["edtaEdad"],
                    "financiaAtencion" => $_POST["edtaFinancia"],
                    "idAtencion" => $_POST["idAtencion"],
                    "tipSexoAtencion" => $_POST["edtaSexo"],
                    "idEstadoPacAtencion" => $_POST["edtaEstadoPac"]
                );
                $rptEditarAtencion = AtencionesModelo::mdlEditarAtenciones($datos);

                if ($rptEditarAtencion == "ok") {
                    echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "¡La atención ha sido actualizada con éxito!",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            function redirect(){
                                window.location = "atenciones";
                            }
                            setTimeout(redirect,1100);
                      </script>';
                } else {
                    echo '<script>
                        Swal.fire({
                        icon: "error",
                        title: "Hubo un error al registrar. Intente nuevamente",
                        showConfirmButton: false,
                        timer: 1500
                        });
                        function redirect(){
                            window.location = "atenciones";
                        }
                        setTimeout(redirect,1100);
                    </script>';
                }
            } else {
                echo '<script>
                    Swal.fire({
                    icon: "error",
                    title: "Ingrese correctamente sus datos",
                    showConfirmButton: false,
                    timer: 1500
                    });
                    function redirect(){
                        window.location = "atenciones";
                    }
                    setTimeout(redirect,1000);
                </script>';
            }
        }
    }

    static public function ctrAnularAtencion()
    {
        if (isset($_GET["idAtencion"])) {
            $idAtencion = $_GET["idAtencion"];
            $idCuenta = $_GET["idCuenta"];
            $idEpisodio = $_GET["idEpisodio"];
            $idUsuario = $_GET["idUsuario"];

            date_default_timezone_set('America/Lima');
            $fAnulaAtencion = date("Y-m-d");
            $datosAuditaAnula = array(
                "fechaRegAudi" => $fAnulaAtencion,
                "idAtencion" => $idAtencion,
                "idUsuario" => $idUsuario,
                "AccRealizada" => "ANULACION",
                "cuentaAnterior" => $idCuenta,
                "EpisodioAnterior" => $idEpisodio
            );
            $rptAnularAudAtencion = AtencionesModelo::mdlAuditoriaAtenciones2($datosAuditaAnula);

            // Anular Ficha
            $rptAnulaAtencion = AtencionesModelo::mdlAnularAtenciones($idAtencion);
            if ($rptAnulaAtencion == "ok") {
                echo '<script>
                        Swal.fire({
                        icon: "success",
                        title: "¡La Atención ha sido anulada con éxito!",
                        showConfirmButton: false,
                        timer: 1300
                          });
                          function redirect() {
                              window.location = "atenciones";
                          }
                          setTimeout(redirect, 1000);
                    </script>';
            } else {
                echo '<script>
                        Swal.fire({
                        icon: "error",
                        title: "¡No se puede anular la atención!",
                        showConfirmButton: false,
                        timer: 1300
                          });
                          function redirect() {
                              window.location = "atenciones";
                          }
                          setTimeout(redirect, 1100);
                    </script>';
            }
            // Anular Ficha
        }
    }
}
