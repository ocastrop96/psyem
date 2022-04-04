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
          <h4><strong>Supervisión:. Pacientes</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Supervisión</a></li>
            <li class="breadcrumb-item active">Pacientes</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Seguimiento de Pacientes &nbsp;<i class="fas fa-procedures"></i></h3>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="form-group">
              <label>Ingrese DNI Paciente:</label>
              <div class="input-group">
                <select class="form-control" style="width: 100%;" id="pacBusqueda" name="pacBusqueda">
                  <option value="0">Ingrese N° de DNI,CE,PASS o Nombres del Paciente</option>
                </select>
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1 col-xl-1">
            <div class="form-group">
              <label class="text-light">.</label>
              <div class="input-group">
                <button type="btn" class="btn bg-secondary pull-right" id="deshacer-filtro-PAC"><i class="fas fa-undo-alt"></i> Deshacer
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="card card-info d-none" id="trgPaciente">
      <div class="card-header">
        <h3 class="card-title font-weight-bold">Datos del Paciente</h3>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-1"><strong>
              <i class="fas fa-hashtag mr-1"></i> N° Cuenta: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1">
            <p class="text-olive font-weight-bold" id="DataPac1"></p>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1"><strong>
              <i class="fas fa-book mr-1"></i> N° HC: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1">
            <p class="text-olive font-weight-bold" id="DataPac2"></p>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1"><strong>
              <i class="fas fa-hashtag mr-1"></i> N° Doc: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-2">
            <p class="text-olive font-weight-bold" id="DataPac3"></p>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-2"><strong>
              <i class="fas fa-book mr-1"></i> Fecha de Ingreso: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1">
            <p class="text-danger font-weight-bold" id="DataPac4"></p>
          </div>
        </div>
        <hr>
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-1">
            <strong><i class="fas fa-hospital-user mr-1"></i> Paciente: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-5">
            <p class="text-gray-dark" id="DataPac5"></p>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-1">
            <strong><i class="fas fa-hospital-alt mr-1"></i> Servicio: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-5">
            <p class="text-gray-dark" id="DataPac6"></p>
          </div>
        </div>
        <hr>
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-1">
            <strong><i class="fas fa-procedures mr-1"></i> Estado: </strong>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-5">
            <p class="text-danger font-weight-bold" id="DataPac7"></p>
          </div>
        </div>
      </div>
    </div>
    <div class="card card-success">
      <div class="card-header">
        <h3 class="card-title">Historial de Seguimientos &nbsp;<i class="fas fa-procedures"></i></h3>
      </div>
      <div class="card-body">
        <table id="datatablesPacientesMont" class="table table-bordered table-hover dt-responsive datatablesPacientesMont">
          <thead>
            <tr>
              <th style="width: 10px">#</th>
              <th style="width: 10px">Fecha</th>
              <th>Tipo</th>
              <th>Motivo</th>
              <th>Profesional</th>
              <th style="width: 10px">DIAG/ACTIVIDAD PAC</th>
              <th style="width: 10px">¿Comunicación con familiar?</th>
              <th>Familiar</th>
              <th style="width: 10px">DIAGNOSTICO/ACTIVIDAD FAM.</th>
              <th>Observaciones</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if (isset($_GET["idPaciente"])) {
              $idPaciente = $_GET["idPaciente"];
            } else {
              $idPaciente = 0;
            }
            $historial = SeguimientosControlador::ctrListarrHistorialAtencion($idPaciente);

            $totalHistorial = count($historial);
            if ($totalHistorial > 0) {
              $idIt = "idAtencion";
              $idP = $_GET["idPaciente"];
              $datosPaciente = AtencionesControlador::ctrListarAtenciones($idIt, $idP);
              echo '<script>
                  $("#trgPaciente").removeClass("d-none");
                  $("#DataPac1").html("'.$datosPaciente["cuentaAtencion"].'");
                  $("#DataPac2").html("'.$datosPaciente["historiaAtencion"].'");
                  $("#DataPac3").html("'.$datosPaciente["tipdocAtencion"].'"+" - "+"'.$datosPaciente["nrodocAtencion"].'");
                  $("#DataPac4").html("'.$datosPaciente["fIngresoAtencion"].'");
                  $("#DataPac5").html("'.$datosPaciente["nombAtencion"].'"+"  "+"'.$datosPaciente["apPaternoAtencion"].'"+"  "+"'.$datosPaciente["apMaternoAtencion"].'");
                  $("#DataPac6").html("'.$datosPaciente["servAtencion"].'");
                  $("#DataPac7").html("'.$datosPaciente["detaEstadoPacAtencion"].'");
              </script>';
            }
            foreach ($historial as $key => $value) {
              if ($value["cieP2"] != null) {
                $cieCPTPac = $value["cieP1"] . ' / ' . $value["cieP2"];
              } else {
                $cieCPTPac = $value["cieP1"];
              }

              if ($value["cieDF2"] != null) {
                $cieCPTFam = $value["cieDF1"] . ' / ' . $value["cieDF2"];
              } else {
                $cieCPTFam = $value["cieDF1"];
              }
              echo '<tr>
                                <td>' . ($key + 1) . '</td>
                                <td>' . $value["fRegistrSeg"] . '</td>
                                <td>' . $value["detaTipSeguimiento"] . '</td>
                                <td>' . $value["detaMotivoSef"] . '</td>
                                <td>' . $value["profesional"] . '</td>
                                <td>' . $cieCPTPac . '</td>
                                <td>' . $value["comunFamSeg"] . '</td>
                                <td>' . $value["nombApFamiliar"] . ' - ' . $value["detaParentesco"] . '</td>
                                <td>' . $cieCPTFam . '</td>
                                <td>' . $value["obsSeg"] . '</td>';
              echo '</tr>';
            }
            ?>
          </tbody>
        </table>
      </div>
    </div>
  </section>
</div>