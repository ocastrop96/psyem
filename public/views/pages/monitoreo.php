<?php
if ($_SESSION["loginPerfil"] == 3) {
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
          <h4><strong>Supervisión:. Monitoreo</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Supervisión</a></li>
            <li class="breadcrumb-item active">Monitoreo</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Monitoreo de Seguimientos &nbsp;<i class="fab fa-watchman-monitoring"></i></h3>
      </div>
      <div class="card-body">
        <input type="hidden" id="idProfH" value="<?php if ($_SESSION["loginIdProf"] == "") {
                                                    echo "0";
                                                  } else {
                                                    echo $_SESSION["loginIdProf"];
                                                  }  ?>">
        <button type="btn" class="ml-2 btn btn-success float-right" id="deshacer-filtro-Monitoreo"><i class="fas fa-undo-alt"></i> Deshacer filtro
        </button>
        <button type="button" class="btn btn-default float-right" id="rango-Monitoreo">
          <span>
            <i class="fa fa-calendar-day"></i>
            <?php
            if (isset($_GET["fechaInicialMon"])) {

              echo $_GET["fechaInicialMon"] . " - " . $_GET["fechaFinalMon"];
            } else {

              echo 'Seleccione Rango de fecha';
            }
            ?>
          </span>
          <i class="fas fa-caret-down"></i>
        </button>
      </div>
      <div class="card-body">
        <table id="datatableMonitoreo" class="table table-bordered table-hover dt-responsive datatableMonitoreo">
          <thead>
            <tr>
              <th style="width: 10px">#</th>
              <th style="width: 10px">Fecha</th>
              <th style="width: 10px">N°Cuenta</th>
              <th>Situación</th>
              <th>N°Doc</th>
              <th>Paciente</th>
              <th>Tipo de Seguimiento</th>
              <th>Profesional</th>
              <th style="width: 10px">¿Comunicación con familiar?</th>
              <th>Familiar</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if (isset($_GET["fechaInicialMonit"])) {
              $fechaInicialMonit = $_GET["fechaInicialMonit"];
              $fechaFinalMonit = $_GET["fechaFinalMonit"];
            } else {
              $fechaInicialMonit = null;
              $fechaFinalMonit = null;
            }
            $monitoreo = SeguimientosControlador::ctrListarMonitoreoF($fechaInicialMonit, $fechaFinalMonit);
            foreach ($monitoreo as $key => $value) {

              $botones = '<div class="btn-group"><button class="btn btn-warning btnVisualizarSeguimiento" idSeguimiento="' . $value["idSeguimiento"] . '" data-toggle="modal" data-target="#modal-visualizar-seguimiento"><i class="fas fa-eye"></i></button></div>';
              echo '<tr>
                                <td>' . ($key + 1) . '</td>
                                <td>' . $value["fRegistrSeg"] . '</td>
                                <td>' . $value["cuentaAtencion"] . '</td>
                                <td>' . $value["detaEstadoPacAtencion"] . '</td>
                                <td>' . $value["tipdocAtencion"] . ' - ' . $value["nrodocAtencion"] . '</td>
                                <td>' . $value["nombAtencion"] . ' ' . $value["apPaternoAtencion"] . ' ' . $value["apMaternoAtencion"] . '</td>
                                <td>' . $value["detaTipSeguimiento"] . '</td>
                                <td>' . $value["nombresProfesional"] . ' ' . $value["apellidosProfesional"] . '</td>
                                <td>' . $value["comunFamSeg"] . '</td>
                                <td>' . $value["nombApFamiliar"] . '</td>
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
<!-- Editar Seguimiento -->
<div id="modal-visualizar-seguimiento" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formVisuSeg" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Visualizar Seguimiento&nbsp; <i class="fab fa-watchman-monitoring"></i></h4>
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
                <label for="visSegFec">Fecha de Seguimiento: &nbsp;</label>
                <i class="fas fa-calendar-check"></i>
                <div class="input-group">
                  <input type="text" name="visSegFec" id="visSegFec" class="form-control" data-inputmask-alias="datetime" data-inputmask-inputformat="dd/mm/yyyy" data-mask autocomplete="off" placeholder="dd/mm/yyyy" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="s21">Profesional que atiende: &nbsp;</label>
                <i class="fas fa-user-md"></i> *
                <div class="input-group">
                  <input type="text" name="s21" id="s21" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="s22">Tipo de Seguimiento: &nbsp;</label>
                <i class="fas fa-indent"></i> *
                <div class="input-group">
                  <input type="text" name="s22" id="s22" class="form-control" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-6">
              <div class="form-group">
                <label for="s23">Motivo: &nbsp;</label>
                <i class="fas fa-book-medical"></i> *
                <div class="input-group">
                  <input type="text" name="s23" id="s23" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>
          <h6 class="font-weight-bold">2. Datos del paciente en seguimiento. &nbsp;<i class="fas fa-user-injured"></i></h6>
          <hr>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="s24">Paciente &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="s24" id="s24" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="s25">Diagnóstico 1: <span class="text-danger">&nbsp;*</span></label>
                <i class="fas fa-stethoscope"></i>
                <div class="input-group">
                  <input type="text" name="s25" id="s25" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="s26">Actividad (OPCIONAL): &nbsp;</label>
                <i class="fas fa-stethoscope"></i>
                <div class="input-group">
                  <input type="text" name="s26" id="s26" class="form-control" readonly>
                </div>
              </div>
            </div>
          </div>
          <div id="bloqueComFam13" class="d-none">
            <h6 class="font-weight-bold">3. Comunicación con familiar. &nbsp;<i class="fas fa-hands-helping"></i></h6>
            <hr>
            <div class="row">
              <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
                <label for="comFam13">¿Se realiza comunicación con familiar?</label>
              </div>
              <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
                <div class="input-group clearfix">
                  <div class="icheck-dark d-inline">
                    <input type="radio" id="comSi13" name="comunicaFamilia13" value="SI">
                    <label for="comSi13">
                      SI
                    </label>
                  </div>
                  <div class="icheck-dark d-inline">
                    &nbsp;
                    <input type="radio" id="comNo13" name="comunicaFamilia13" value="NO" checked="">
                    <label for="comNo13">
                      NO
                    </label>
                  </div>
                </div>
                <input type="hidden" name="comFami13" id="comFami13" value="SI">
              </div>
            </div>
            <hr>
            <div id="block11">
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="s27">Familiar del Paciente: <span class="text-danger">&nbsp;*</span></label>
                    <i class="fas fa-chalkboard-teacher"></i>
                    <div class="input-group">
                      <input type="text" name="s27" id="s27" class="form-control" readonly>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="s28">Diagnóstico 1: <span class="text-danger">&nbsp;*</span></label>
                    <i class="fas fa-stethoscope"></i>
                    <div class="input-group">
                      <input type="text" name="s28" id="s28" class="form-control" readonly>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="form-group">
                    <label for="s29">Actividad (OPCIONAL): &nbsp;</label>
                    <i class="fas fa-stethoscope"></i>
                    <div class="input-group">
                    <input type="text" name="s29" id="s29" class="form-control" readonly>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="form-group">
                <label for="s30">Observaciones: &nbsp;</label>
                <i class="fas fa-search"></i>
                <div class="input-group">
                  <input type="text" class="form-control" name="s30" id="s30" readonly>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- Editar Seguimiento -->