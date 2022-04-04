<?php
if ($_SESSION["loginPerfil"] == 3 || $_SESSION["loginPerfil"] == 4) {
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
          <h4><strong>Reportes:. Jefatura</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Reportes</a></li>
            <li class="breadcrumb-item active">Jefatura</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Reporte Jefatura &nbsp;<i class="fas fa-chart-line"></i></h3>
        <div class="card-tools">
          <a href="public/views/docs/rp-seguimientos-jefatura.php?reporte=reporte" class="rseg1">
            <button type="btn" class="btn btn-success"><i class="fas fa-file-excel"></i> Reporte de Seguimientos
            </button>
          </a>
        </div>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
            <div class="form-group">
              <label>Selecciona un rango de fecha:</label>
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="far fa-calendar-alt"></i>
                  </span>
                </div>
                <input type="text" class="form-control float-right" id="rango-rj" name="rango-rj" readonly inicio="<?php date_default_timezone_set('America/Lima');
                                                                                                                    echo date("Y-m-d"); ?>" fin="<?php date_default_timezone_set('America/Lima');
                                                                                                                                                  echo date("Y-m-d"); ?>">
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6">
            <div class="form-group">
              <label>Seleccione Profesional:</label>
              <div class="input-group">
                <select class="form-control" name="rjProfesional" id="rjProfesional">
                  <option value="0">---TODOS-----</option>
                  <?php
                  $item = null;
                  $value = null;

                  $profesionales = ProfesionalesControlador::ctrListarProfesionales($item, $value);
                  foreach ($profesionales as $key => $value) {
                    echo '<option value="' . $value["idProfesional"] . '">' . $value["nombresProfesional"] . ' ' . $value["apellidosProfesional"] . '</option>';
                  }
                  ?>
                </select>
                <button type="btn" class="ml-2 btn bg-info pull-right" id="deshacer-filtro-RJ"><i class="fas fa-undo-alt"></i> Deshacer filtro
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="card card-danger">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos x Profesional</h3>
          </div>
          <div class="card-body">
            <div class="chart rj1">
              <canvas id="rjSegxPro" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card card-teal">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos x Tipo</h3>
          </div>
          <div class="card-body">
            <div class="chart rj2">
              <canvas id="rjSegxTipo" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="card card-secondary">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos x Diagnóstico de Paciente</h3>
          </div>
          <div class="card-body">
            <div class="chart rj3">
              <canvas id="rjSegxDiagPac" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card card-info">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos x Diagnóstico de Familiar</h3>
          </div>
          <div class="card-body">
            <div class="chart rj4">
              <canvas id="rjSegxDiagFam" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>