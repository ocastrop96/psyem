<?php
if ($_SESSION["loginPerfil"] == 1) {
  echo '<script>
    window.location = "dashboard";
  </script>';
  return;
}
?>
<div class="content-wrapper">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h4><strong>Acompañamiento:. Seguimiento de Atencion</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Acompañamiento</a></li>
            <li class="breadcrumb-item active">Seguimiento</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Seguimiento de Atenciones &nbsp;<i class="fas fa-diagnoses"></i></h3>
      </div>
      <div class="card-body">
        <input type="hidden" id="idProfH" value="<?php if ($_SESSION["loginIdProf"] == "") {
                                                    echo "0";
                                                  } else {
                                                    echo $_SESSION["loginIdProf"];
                                                  }  ?>">
        <button type="btn" class="btn btn-secondary pull-left" data-toggle="modal" data-target="#modal-registrar-seguimiento"><i class="fas fa-diagnoses"></i> Registrar seguimiento
        </button>
        <button type="btn" class="ml-2 btn btn-success float-right" id="deshacer-filtro-Seg"><i class="fas fa-undo-alt"></i> Deshacer filtro
        </button>
        <button type="button" class="btn btn-default float-right" id="rango-seguimiento">
          <span>
            <i class="fa fa-calendar-day"></i>
            <?php
            if (isset($_GET["fechaInicialSeg"])) {

              echo $_GET["fechaInicialSeg"] . " - " . $_GET["fechaFinalSeg"];
            } else {

              echo 'Seleccione Rango de fecha';
            }
            ?>
          </span>
          <i class="fas fa-caret-down"></i>
        </button>
      </div>
      <div class="card-body">
        <table id="datatableSeguimiento" class="table table-bordered table-hover dt-responsive datatableSeguimiento">
          <thead>
            <tr>
              <th style="width: 10px">#</th>
              <th style="width: 10px">F.Registro</th>
              <th style="width: 10px">N°Cuenta</th>
              <th>N°Doc</th>
              <th>Paciente</th>
              <th>Tipo de Seguimiento</th>
              <th>Profesional</th>
              <th style="width: 10px">¿Comunicación con familiar?</th>
              <th>Familiar</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if (isset($_GET["fechaInicialSeg"])) {
              $fechaInicialSeg = $_GET["fechaInicialSeg"];
              $fechaFinalSeg = $_GET["fechaFinalSeg"];
            } else {
              $fechaInicialSeg = null;
              $fechaFinalSeg = null;
            }
            $Profesional = $_SESSION["loginIdProf"];
            $seguimientos = SeguimientosControlador::ctrListarSeguimientosF($fechaInicialSeg, $fechaFinalSeg, $Profesional);
            foreach ($seguimientos as $key => $value) {
              if ($value["idStatusSeg"] == 1) {
                $estadoSeg = '<button type="button" class="btn btn-block btn-success font-weight-bold"><i class="fas fa-clipboard-list"></i> ' . $value["detaStatusSeg"] . '</button>';
              } else {
                $estadoSeg = '<button type="button" class="btn btn-block btn-danger font-weight-bold"><i class="fas fa-ban"></i> ' . $value["detaStatusSeg"] . '</button>';
              }
              $botones = '<div class="btn-group"><button class="btn btn-warning btnEditarSeguimiento" idSeguimiento="' . $value["idSeguimiento"] . '" idProfesional="' . $value["idProfesional"] . '"><i class="fas fa-edit"></i></button><button class="btn btn-secondary btnAnularSeguimiento" data-toggle="tooltip" data-placement="left" title="Anular Seguimiento" idSeguimiento="' . $value["idSeguimiento"] . '" idProfesional="' . $value["idProfesional"] . '"><i class="fas fa-power-off"></i></button></div>';
              echo '<tr>
                                <td>' . ($key + 1) . '</td>
                                <td>' . $value["fRegistrSeg"] . '</td>
                                <td>' . $value["cuentaAtencion"] . '</td>
                                <td>' . $value["tipdocAtencion"] . ' - ' . $value["nrodocAtencion"] . '</td>
                                <td>' . $value["nombAtencion"] . ' ' . $value["apPaternoAtencion"] . ' ' . $value["apMaternoAtencion"] . '</td>
                                <td>' . $value["detaTipSeguimiento"] . '</td>
                                <td>' . $value["nombresProfesional"] . ' ' . $value["apellidosProfesional"] . '</td>
                                <td>' . $value["comunFamSeg"] . '</td>
                                <td>' . $value["nombApFamiliar"] . '</td>
                                <td>' . $estadoSeg . '</td>
                                <td>' . $botones . '</td>';
              echo '</tr>';
            }
            ?>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</div>
<!-- Registrar Seguimiento -->
<div id="modal-registrar-seguimiento" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formRegSeg" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Registrar Seguimiento&nbsp; <i class="fas fa-diagnoses"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <h6 class="font-weight-bold">1. Tipo de Seguimiento y Personal de Salud. &nbsp;<i class="fas fa-hospital-user"></i></h6>
          <hr>
          <div class="row">
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="rgSegFec">Fecha de Seguimiento: &nbsp;</label>
                <i class="fas fa-calendar-check"></i>
                <div class="input-group">
                  <input type="text" name="rgSegFec" id="rgSegFec" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask autocomplete="off" placeholder="dd/mm/yyyy" required>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="rgSegProf">Profesional que atiende: &nbsp;</label>
                <i class="fas fa-user-md"></i> *
                <div class="input-group">
                  <input type="hidden" name="rgSegProf" value="<?php echo $_SESSION["loginIdProf"]; ?>">
                  <input type="text" name="s1" id="s1" class="form-control" value="<?php echo $_SESSION["loginNombProf"]; ?>" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="rgSegTip">Tipo de Seguimiento: &nbsp;</label>
                <i class="fas fa-indent"></i> *
                <div class="input-group">
                  <select class="form-control" id="rgSegTip" name="rgSegTip">
                    <option value="0">Seleccione Tipo de Seguimiento</option>
                    <?php
                    $tipSeg = SeguimientosControlador::ctrListarTipoSeguimiento();
                    foreach ($tipSeg as $key => $value) {
                      echo '<option value="' . $value["idTipoSeguimiento"] . '">' . $value["detaTipSeguimiento"] . '</option>';
                    }
                    ?>
                  </select>
                  <input type="hidden" name="idUsuario" value="<?php echo $_SESSION["loginId"]; ?>">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="rgSegMot">Motivo: &nbsp;</label>
                <i class="fas fa-book-medical"></i> *
                <div class="input-group">
                  <select class="form-control" id="rgSegMot" name="rgSegMot">
                    <option value="0">Seleccione Motivo</option>
                    <?php
                    $motSeg = SeguimientosControlador::ctrListarMotivoSeguimiento();
                    foreach ($motSeg as $key => $value) {
                      echo '<option value="' . $value["idMotSeguimiento"] . '">' . $value["detaMotivoSef"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <h6 class="font-weight-bold">2. Datos del paciente en seguimiento. &nbsp;<i class="fas fa-user-injured"></i></h6>
          <hr>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="rgSegPac">Paciente &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" id="rgSegPac" name="rgSegPac">
                    <option value="0">Ingrese apellidos, N° DNI o HC del paciente</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="rgSegDp1">Diagnóstico 1: <span class="text-danger">&nbsp;*</span></label>
                <i class="fas fa-stethoscope"></i>
                <div class="input-group">
                  <select class="form-control" id="rgSegDp1" name="rgSegDp1">
                    <option value="0">Seleccione Diagnóstico 1</option>
                    <?php
                    $item = null;
                    $val = null;
                    $diag1 = DiagnosticosControlador::ctrListarDiagnosticos($item, $val);
                    foreach ($diag1 as $key => $value) {
                      echo '<option value="' . $value["idDiagnostico"] . '">' . $value["cieDiagnostico"] . ' - ' . $value["detaDiagnostico"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="rgSegDp2">Actividad (OPCIONAL): &nbsp;</label>
                <i class="fas fa-stethoscope"></i>
                <div class="input-group">
                  <select class="form-control" id="rgSegDp2" name="rgSegDp2">
                    <option value="0">Seleccione Actividad (Opcional)</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div id="bloqueComFam" class="d-none">
            <h6 class="font-weight-bold">3. Comunicación con familiar. &nbsp;<i class="fas fa-hands-helping"></i></h6>
            <hr>
            <div class="row">
              <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
                <label for="comFam">¿Se realiza comunicación con familiar?</label>
              </div>
              <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
                <div class="input-group clearfix">
                  <div class="icheck-dark d-inline">
                    <input type="radio" id="comSi" name="comunicaFamilia" value="SI">
                    <label for="comSi">
                      SI
                    </label>
                  </div>
                  <div class="icheck-dark d-inline">
                    &nbsp;
                    <input type="radio" id="comNo" name="comunicaFamilia" value="NO" checked="">
                    <label for="comNo">
                      NO
                    </label>
                  </div>
                </div>
                <input type="hidden" name="comFami" id="comFami" value="SI">
              </div>
            </div>
            <hr>
            <div id="block1">
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="rgSegFam">Familiar del Paciente: <span class="text-danger">&nbsp;*</span></label>
                    <i class="fas fa-chalkboard-teacher"></i>
                    <div class="input-group">
                      <select class="form-control" id="rgSegFam" name="rgSegFam">
                        <option value="0">Seleccione Familiar</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="rgSegDf1">Diagnóstico 1: <span class="text-danger">&nbsp;*</span></label>
                    <i class="fas fa-stethoscope"></i>
                    <div class="input-group">
                      <select class="form-control" id="rgSegDf1" name="rgSegDf1">
                        <option value="0">Seleccione Diagnóstico 1</option>
                        <?php
                        $item = null;
                        $val = null;
                        $diagf1 = DiagnosticosControlador::ctrListarDiagnosticos($item, $val);
                        foreach ($diagf1 as $key => $value) {
                          echo '<option value="' . $value["idDiagnostico"] . '">' . $value["cieDiagnostico"] . ' - ' . $value["detaDiagnostico"] . '</option>';
                        }
                        ?>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="rgSegDf2">Actividad (OPCIONAL): &nbsp;</label>
                    <i class="fas fa-stethoscope"></i>
                    <div class="input-group">
                      <select class="form-control" id="rgSegDf2" name="rgSegDf2">
                        <option value="0">Seleccione Actividad (Opcional)</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="rgSegObs">Observaciones: &nbsp;</label>
                <i class="fas fa-search"></i>
                <div class="input-group">
                  <input type="text" class="form-control" name="rgSegObs" id="rgSegObs" placeholder="Ingrese observaciones (Opcional)">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnRegSeg"><i class="fas fa-save"></i> Registrar</button>
          <button type="reset" class="btn btn-danger"><i class="fas fa-eraser"></i> Limpiar</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $regSeguimiento = new SeguimientosControlador();
        $regSeguimiento->ctrRegistrarSeguimiento();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Registrar Seguimiento -->
<!-- Editar Seguimiento -->
<div id="modal-editar-seguimiento" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formEdtSeg" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Editar Seguimiento&nbsp; <i class="fas fa-diagnoses"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <h6 class="font-weight-bold">1. Tipo de Seguimiento y Personal de Salud. &nbsp;<i class="fas fa-hospital-user"></i></h6>
          <hr>
          <div class="row">
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="edtSegFec">Fecha de Seguimiento: &nbsp;</label>
                <i class="fas fa-calendar-check"></i>
                <div class="input-group">
                  <input type="text" name="edtSegFec" id="edtSegFec" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask autocomplete="off" placeholder="dd/mm/yyyy" required>
                  <input type="hidden" name="idSeguimiento" id="idSeguimiento">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="edtSegProf">Profesional que atiende: &nbsp;</label>
                <i class="fas fa-user-md"></i> *
                <div class="input-group">
                  <input type="hidden" name="edtSegProf" id="edtSegProf">
                  <input type="text" name="s2" id="s2" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="edtSegTip">Tipo de Seguimiento: &nbsp;</label>
                <i class="fas fa-indent"></i> *
                <div class="input-group">
                  <select class="form-control" id="edtSegTip" name="edtSegTip">
                    <option id="edtSegTip1"></option>
                    <?php
                    $tipSeg1 = SeguimientosControlador::ctrListarTipoSeguimiento();
                    foreach ($tipSeg1 as $key => $value) {
                      echo '<option value="' . $value["idTipoSeguimiento"] . '">' . $value["detaTipSeguimiento"] . '</option>';
                    }
                    ?>
                  </select>
                  <input type="hidden" name="idUsuario" value="<?php echo $_SESSION["loginId"]; ?>">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="edtSegMot">Motivo: &nbsp;</label>
                <i class="fas fa-book-medical"></i> *
                <div class="input-group">
                  <select class="form-control" id="edtSegMot" name="edtSegMot">
                    <option id="edtSegMot1"></option>
                    <?php
                    $motSeg1 = SeguimientosControlador::ctrListarMotivoSeguimiento();
                    foreach ($motSeg1 as $key => $value) {
                      echo '<option value="' . $value["idMotSeguimiento"] . '">' . $value["detaMotivoSef"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <h6 class="font-weight-bold">2. Datos del paciente en seguimiento. &nbsp;<i class="fas fa-user-injured"></i></h6>
          <hr>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="edtSegPac">Paciente &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <span class="font-weight-bolder text-danger" id="seleccionActual2">ACTUAL : </span>
                <span class="font-weight-bolder" id="seleccionActual21"></span>
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" id="edtSegPac" name="edtSegPac">
                    <option id="edtSegPac1">Ingrese apellidos, N° DNI o HC del paciente</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="edtSegDp1">Diagnóstico 1: <span class="text-danger">&nbsp;*</span></label>
                <i class="fas fa-stethoscope"></i>
                <div class="input-group">
                  <select class="form-control" id="edtSegDp1" name="edtSegDp1">
                    <option id="edtSegDp11"></option>
                    <?php
                    $item = null;
                    $val = null;
                    $diag1 = DiagnosticosControlador::ctrListarDiagnosticos($item, $val);
                    foreach ($diag1 as $key => $value) {
                      echo '<option value="' . $value["idDiagnostico"] . '">' . $value["cieDiagnostico"] . ' - ' . $value["detaDiagnostico"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="edtSegDp2">Actividad (OPCIONAL): &nbsp;</label>
                <i class="fas fa-stethoscope"></i>
                <div class="input-group">
                  <select class="form-control" id="edtSegDp2" name="edtSegDp2">
                    <option id="edtSegDp21"></option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div id="bloqueComFam1" class="d-none">
            <h6 class="font-weight-bold">3. Comunicación con familiar. &nbsp;<i class="fas fa-hands-helping"></i></h6>
            <hr>
            <div class="row">
              <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
                <label for="comFam">¿Se realiza comunicación con familiar?</label>
              </div>
              <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
                <div class="input-group clearfix">
                  <div class="icheck-dark d-inline">
                    <input type="radio" id="comSi1" name="comunicaFamilia1" value="SI">
                    <label for="comSi1">
                      SI
                    </label>
                  </div>
                  <div class="icheck-dark d-inline">
                    &nbsp;
                    <input type="radio" id="comNo1" name="comunicaFamilia1" value="NO" checked="">
                    <label for="comNo1">
                      NO
                    </label>
                  </div>
                </div>
                <input type="hidden" name="comFami1" id="comFami1" value="SI">
              </div>
            </div>
            <hr>
            <div id="block11">
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="edtSegFam">Familiar del Paciente: <span class="text-danger">&nbsp;*</span></label>
                    <i class="fas fa-chalkboard-teacher"></i>
                    <input type="hidden" name="idFamAnt" id="idFamAnt">
                    <span class="font-weight-bolder text-danger" id="seleccionActual3">ACTUAL : </span>
                    <span class="font-weight-bolder" id="seleccionActual31"></span>
                    <div class="input-group">
                      <select class="form-control" id="edtSegFam" name="edtSegFam">
                        <option id="edtSegFam1"></option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="edtSegDf1">Diagnóstico 1: <span class="text-danger">&nbsp;*</span></label>
                    <i class="fas fa-stethoscope"></i>
                    <div class="input-group">
                      <select class="form-control" id="edtSegDf1" name="edtSegDf1">
                        <option id="edtSegDf11"></option>
                        <?php
                        $item = null;
                        $val = null;
                        $diagf1 = DiagnosticosControlador::ctrListarDiagnosticos($item, $val);
                        foreach ($diagf1 as $key => $value) {
                          echo '<option value="' . $value["idDiagnostico"] . '">' . $value["cieDiagnostico"] . ' - ' . $value["detaDiagnostico"] . '</option>';
                        }
                        ?>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="edtSegDf2">Actividad (OPCIONAL): &nbsp;</label>
                    <i class="fas fa-stethoscope"></i>
                    <div class="input-group">
                      <select class="form-control" id="edtSegDf2" name="edtSegDf2">
                        <option id="edtSegDf21">Seleccione Actividad (Opcional)</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="edtSegObs">Observaciones: &nbsp;</label>
                <i class="fas fa-search"></i>
                <div class="input-group">
                  <input type="text" class="form-control" name="edtSegObs" id="edtSegObs" placeholder="Ingrese observaciones (Opcional)">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnEdtSeg"><i class="fas fa-sync"></i> Actualizar</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $edtSeguimiento = new SeguimientosControlador();
        $edtSeguimiento->ctrEditarSeguimiento();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Editar Seguimiento -->
<!-- Anular seguimiento -->
<?php
$anuSeguimiento = new SeguimientosControlador();
$anuSeguimiento->ctrAnularSeguimiento();
?>
<!-- Anular seguimiento -->