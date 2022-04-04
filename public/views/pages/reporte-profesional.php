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
          <h4><strong>Reportes:. Profesional</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Reportes</a></li>
            <li class="breadcrumb-item active">Profesional</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Reporte Profesional &nbsp;<i class="fas fa-chart-bar"></i></h3>
        <div class="card-tools">
          <a href="public/views/docs/rp-seguimientos-profesional.php?reporte=reporte" class="rseg4">
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
                <input type="text" class="form-control float-right" id="rango-rp" name="rango-rp" readonly inicio="<?php date_default_timezone_set('America/Lima');
                                                                                                                    echo date("Y-m-d"); ?>" fin="<?php date_default_timezone_set('America/Lima');
                                                                                                                                                  echo date("Y-m-d"); ?>">
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-5 col-xl-5">
            <div class="form-group">
              <label>Profesional:</label>
              <div class="input-group">
                <input type="hidden" name="prof-id" id="prof-id" value="<?php echo $_SESSION["loginIdProf"]; ?>">
                <input type="text" class="form-control" id="prof-name" name="prof-name" readonly value="<?php echo $_SESSION["loginNombProf"]; ?>">
                <button type="btn" class="ml-2 btn bg-teal pull-right" id="deshacer-filtro-RP"><i class="fas fa-undo-alt"></i> Deshacer filtro
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="card card-info">
            <div class="card-header">
              <h3 class="card-title font-weight-bold">Seguimientos x Mes - Profesional</h3>
            </div>
            <div class="card-body">
              <div class="chart rp1">
                <canvas id="rjSegxMesPro" width="350" height="350"></canvas>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card card-success">
            <div class="card-header">
              <h3 class="card-title font-weight-bold">Seguimientos x Tipo - Profesional</h3>
            </div>
            <div class="card-body">
              <div class="chart rp2">
                <canvas id="rjSegxTipoPro" width="350" height="350"></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>