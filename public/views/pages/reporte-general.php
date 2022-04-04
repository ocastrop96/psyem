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
          <h4><strong>Reportes:. General</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Reportes</a></li>
            <li class="breadcrumb-item active">General</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Reporte General &nbsp;<i class="fas fa-chart-pie"></i></h3>
        <div class="card-tools">
          <a href="public/views/docs/rp-audatenciones.php?reporte=reporte" class="rg2">
            <button type="btn" class="btn btn-danger"><i class="fas fa-file-excel"></i> Auditoría Atenciones
            </button>
          </a>
          <a href="public/views/docs/rp-audfamiliares.php?reporte=reporte" class="rg1">
            <button type="btn" class="btn btn-secondary"><i class="fas fa-file-excel"></i> Auditoría Familiares
            </button>
          </a>
        </div>
      </div>

      <div class="card-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-7 col-xl-7">
            <div class="form-group">
              <label>Selecciona un rango de fecha:</label>
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="far fa-calendar-alt"></i>
                  </span>
                </div>
                <input type="text" class="form-control float-right" id="rango-rg" name="rango-rg" readonly>
                <button type="btn" class="ml-2 btn bg-success pull-right" id="deshacer-filtro-RG"><i class="fas fa-undo-alt"></i> Deshacer filtro
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="card card-gray">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Atenciones Registradas y Anuladas</h3>
          </div>
          <div class="card-body">
            <div class="chart rgen1">
              <canvas id="rgAtenAnuReg" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card card-info">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos Registrados</h3>
          </div>
          <div class="card-body">
            <div class="chart rgen2">
              <canvas id="rggSegs" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="card card-danger">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos x Tipo de Parentesco Fam.</h3>
          </div>
          <div class="card-body">
            <div class="chart rgen3">
              <canvas id="rggTParen" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card card-teal">
          <div class="card-header">
            <h3 class="card-title font-weight-bold">Seguimientos x Sexo Fam.</h3>
          </div>
          <div class="card-body">
            <div class="chart rgen4">
              <canvas id="rggTSexParen" width="350" height="350"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>