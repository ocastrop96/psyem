<?php
class FamiliaresControlador
{
    static public function ctrListarFamiliares($item, $valor)
    {
        $rptListFam = FamiliaresModelo::mdlListarFamiliares($item, $valor);
        return $rptListFam;
    }

    static public function ctrListarPaciente($dato)
    {
        $rptBuscarPac = FamiliaresModelo::mdlListarPaciente($dato);
        return $rptBuscarPac;
    }
    static public function ctrListarParentesco()
    {
        $rptFamParen = FamiliaresModelo::mdlListarParentesco();
        return $rptFamParen;
    }
    static public function ctrValidarFamiliar($idAtencion, $ndocFamiliar)
    {
        $rptFamValid = FamiliaresModelo::mdlValidarPaciente($idAtencion, $ndocFamiliar);
        return $rptFamValid;
    }
    static public function ctrListarFamiliarPaciente($existe)
    {
        $rptListDiagSe = FamiliaresModelo::mdlListarFamiliarPac($existe);
        return $rptListDiagSe;
    }
    static public function ctrListarFamiliaresF($fechaInicialFam, $fechaFinalFam)
    {
        $rptListFamF = FamiliaresModelo::mdlListarFamiliaresF($fechaInicialFam, $fechaFinalFam);
        return $rptListFamF;
    }
    static public function ctrRegistrarFamiliar()
    {
        if (isset($_POST["rgfAtencion"]) && isset($_POST["rgfNdoc"])) {
            if (
                preg_match('/^[0-9]+$/', $_POST["rgfAtencion"]) &&
                preg_match('/^[0-9]+$/', $_POST["rgfNdoc"])
            ) {
                date_default_timezone_set('America/Lima');
                $fRegFam = date("Y-m-d");
                $datos = array(
                    "fechaRegistro" =>  $fRegFam,
                    "idUsuario" => $_POST["idUsFam"],
                    "idAtencion" => $_POST["rgfAtencion"],
                    "idParentesco" => $_POST["rgfParent"],
                    "idTipSexo" => $_POST["rgfSexo"],
                    "tipdocFamiliar" => $_POST["rgfTdoc"],
                    "ndocFamiliar" => $_POST["rgfNdoc"],
                    "nombApFamiliar" => $_POST["rgfNomAp"],
                    "edadFamiliar" => $_POST["rgfEdad"],
                    "telcelFamiliar" => $_POST["rgfTel"]
                );
                $rptRegFam = FamiliaresModelo::mdlRegistrarFamiliar($datos);
                if ($rptRegFam == "ok") {
                    echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "¡El familiar ha sido registrado con éxito!",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            function redirect(){
                                window.location = "familiares";
                            }
                            setTimeout(redirect,1200);
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
                            window.location = "familiares";
                        }
                        setTimeout(redirect,1200);
                    </script>';
                }
            } else {
                echo '<script>
                        Swal.fire({
                        icon: "error",
                        title: "Ingrese los datos requeridos",
                        showConfirmButton: false,
                        timer: 1500
                        });
                        function redirect(){
                            window.location = "familiares";
                        }
                        setTimeout(redirect,1200);
                    </script>';
            }
        }
    }
    static public function ctrEditarFamiliar()
    {
        if (isset($_POST["edtfAtencion"]) && isset($_POST["edtfNdoc"])) {
            if (
                preg_match('/^[0-9]+$/', $_POST["edtfAtencion"]) &&
                preg_match('/^[0-9]+$/', $_POST["edtfNdoc"])
            ) {
                date_default_timezone_set('America/Lima');
                $fEditFam = date("Y-m-d");

                if ($_POST["edtfNdoc"] != $_POST["idDniAct"] || $_POST["edtfAtencion"] != $_POST["idAteAct"]) {
                    // Registro de Auditoría
                    $datosAudi = array(
                        "fecRegAudi" => $fEditFam,
                        "idFamiliar" => $_POST["idFamiliar"],
                        "idUsuario" => $_POST["idUsEdtFam"],
                        "AccRealizada" => "ACTUALIZACIÓN",
                        "idAtencionAnt" => $_POST["idAteAct"],
                        "ndocAnt" => $_POST["idDniAct"],
                        "idAtencionNueva" => $_POST["edtfAtencion"],
                        "ndocNuevo" => $_POST["edtfNdoc"]
                    );
                    $rptEditarAudfAM = FamiliaresModelo::mdlAuditoriaFamiliares($datosAudi);
                    // Registro de Auditoría
                }
                $datos = array(
                    "idFamiliar" => $_POST["idFamiliar"],
                    "idAtencion" => $_POST["edtfAtencion"],
                    "idParentesco" => $_POST["edtfParent"],
                    "idTipSexo" => $_POST["edtfSexo"],
                    "tipdocFamiliar" => $_POST["edtfTdoc"],
                    "ndocFamiliar" => $_POST["edtfNdoc"],
                    "nombApFamiliar" => $_POST["edtfNomAp"],
                    "edadFamiliar" => $_POST["edtfEdad"],
                    "telcelFamiliar" => $_POST["edtfTel"]
                );

                $rptEdtFam = FamiliaresModelo::mdlEditarFamiliar($datos);
                if ($rptEdtFam == "ok") {
                    echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "¡El familiar ha sido actualizado con éxito!",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            function redirect(){
                                window.location = "familiares";
                            }
                            setTimeout(redirect,1200);
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
                            window.location = "familiares";
                        }
                        setTimeout(redirect,1200);
                    </script>';
                }
            } else {
                echo '<script>
                        Swal.fire({
                        icon: "error",
                        title: "Ingrese los datos requeridos",
                        showConfirmButton: false,
                        timer: 1500
                        });
                        function redirect(){
                            window.location = "familiares";
                        }
                        setTimeout(redirect,1200);
                    </script>';
            }
        }
    }
    static public function ctrEliminarFamiliar()
    {
        if (isset($_GET["idFamiliar"])) {

            date_default_timezone_set('America/Lima');
            $fElimFam = date("Y-m-d");

            $idFamiliar = $_GET["idFamiliar"];

            $rptEliminarFamiliar = FamiliaresModelo::mdlEliminarFamiliar($idFamiliar);

            if ($rptEliminarFamiliar == "ok") {
                $datosAudi = array(
                    "fecRegAudi" => $fElimFam,
                    "idFamiliar" => $_GET["idFamiliar"],
                    "idUsuario" => $_GET["idUsuario"],
                    "AccRealizada" => "ELIMINACIÓN",
                    "idAtencionAnt" => $_GET["idAtencion"],
                    "ndocAnt" => $_GET["idNDoc"]
                );
                $rptElimAudfAM = FamiliaresModelo::mdlAuditoriaFamiliares2($datosAudi);
                echo '<script>
                        Swal.fire({
                        icon: "success",
                        title: "¡El familiar ha sido eliminado con éxito!",
                        showConfirmButton: false,
                        timer: 1400
                    });
                    function redirect() {
                        window.location = "familiares";
                    }
                    setTimeout(redirect, 1200);
                    </script>';
            } else {
                echo '<script>
                        Swal.fire({
                        icon: "error",
                        title: "¡El familiar tiene seguimiento registrado, no puede ser eliminado!",
                        showConfirmButton: false,
                        timer: 1400
                    });
                    function redirect() {
                        window.location = "familiares";
                    }
                    setTimeout(redirect, 1200);
                    </script>';
            }
        }
    }
}
