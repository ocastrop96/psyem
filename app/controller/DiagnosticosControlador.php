<?php
class DiagnosticosControlador
{
    static public function ctrListarDiagnosticos($item, $valor)
    {
        $rptListDiag = DiagnosticosModelo::mdlListarDiagnosticos($item, $valor);
        return $rptListDiag;
    }
    static public function ctrListarNoSeleccionado($existe)
    {
        $rptListDiagSe = DiagnosticosModelo::mdlListarNoSeleccionado($existe);
        return $rptListDiagSe;
    }
    static public function ctrRegistrarDiagnostico()
    {
        if (isset($_POST["rgdCie"]) && isset($_POST["rgdDescripcion"])) {
            if (
                preg_match('/^[a-zA-Z0-9ñÑáéíóúüÁÉÍÓÚÜ.]+$/', $_POST["rgdCie"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúüÁÉÍÓÚÜ ]+$/', $_POST["rgdDescripcion"])
            ) {
                $datos = array(
                    "cieDiagnostico" => $_POST["rgdCie"],
                    "detaDiagnostico" => $_POST["rgdDescripcion"]
                );
                $rptRegistroDiagnostico = DiagnosticosModelo::mdlRegistrarDiagnostico($datos);
                if ($rptRegistroDiagnostico == "ok") {
                    echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "¡El diagnóstico ha sido registrado con éxito!",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            function redirect(){
                                window.location = "diagnosticos";
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
                            window.location = "diagnosticos";
                        }
                        setTimeout(redirect,1200);
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
                        window.location = "diagnosticos";
                    }
                    setTimeout(redirect,1200);
                </script>';
            }
        }
    }
    static public function ctrEditarDiagnostico()
    {
        if (isset($_POST["edtdCie"]) && isset($_POST["edtdDescripcion"])) {
            if (
                preg_match('/^[a-zA-Z0-9ñÑáéíóúüÁÉÍÓÚÜ.]+$/', $_POST["edtdCie"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúüÁÉÍÓÚÜ ]+$/', $_POST["edtdDescripcion"])
            ) {
                $datos = array(
                    "idDiagnostico" => $_POST["idDiagnostico"],
                    "cieDiagnostico" => $_POST["edtdCie"],
                    "detaDiagnostico" => $_POST["edtdDescripcion"]
                );
                $rptEditarDiagnostico = DiagnosticosModelo::mdlEditarDiagnostico($datos);
                if ($rptEditarDiagnostico == "ok") {
                    echo '<script>
                            Swal.fire({
                                icon: "success",
                                title: "¡El diagnóstico ha sido editado con éxito!",
                                showConfirmButton: false,
                                timer: 1500
                            });
                            function redirect(){
                                window.location = "diagnosticos";
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
                            window.location = "diagnosticos";
                        }
                        setTimeout(redirect,1200);
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
                        window.location = "diagnosticos";
                    }
                    setTimeout(redirect,1200);
                </script>';
            }
        }
    }
    static public function ctrEliminarDiagnostico()
    {
        if (isset($_GET["idDiagnostico"])) {
            $datos = $_GET["idDiagnostico"];
            $rptEliminaDiag = DiagnosticosModelo::mdlEliminarDiagnostico($datos);
            if ($rptEliminaDiag == "ok") {
                echo '<script>
                        Swal.fire({
                            icon: "success",
                            title: "¡El diagnóstico ha sido eliminado con éxito!",
                            showConfirmButton: false,
                            timer: 1500
                        });
                        function redirect(){
                            window.location = "diagnosticos";
                        }
                        setTimeout(redirect,1200);
                    </script>';
            } else {
                echo '<script>
                        Swal.fire({
                            icon: "error",
                            title: "¡El diagnóstico ha podido ser eliminado!",
                            showConfirmButton: false,
                            timer: 1500
                        });
                        function redirect(){
                            window.location = "diagnosticos";
                        }
                        setTimeout(redirect,1200);
                    </script>';
            }
        }
    }
}
