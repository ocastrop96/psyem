<div class="preloader flex-column justify-content-center align-items-center">
  <img class="animation__shake" src="public/views/resources/img/acpsy-logo-main.png" alt="ACPSY-LOGO" height="80" width="80">
</div>
<div class="content-wrapper">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h4><strong>Inicio:. Dashboard</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active">Dashboard</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-4 col-12">
          <!-- small box -->
          <div class="small-box bg-olive">
            <div class="inner">
              <h3 class="one1"></h3>

              <p class="font-weight-bold">Seguimientos Realizados</p>
            </div>
            <div class="icon">
              <i class="fas fa-diagnoses"></i>
            </div>
            <a href="seguimiento" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-4 col-12">
          <!-- small box -->
          <div class="small-box bg-teal">
            <div class="inner">
              <h3 class="one2"></h3>
              <p class="font-weight-bold">Pacientes Registrados</p>
            </div>
            <div class="icon">
              <i class="fas fa-hospital-user"></i>
            </div>
            <a href="atenciones" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-4 col-12">
          <!-- small box -->
          <div class="small-box bg-warning">
            <div class="inner">
              <h3 class="one3"></h3>
              <p class="font-weight-bold">Familiares Registrados</p>
            </div>
            <div class="icon">
              <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <a href="familiares" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
          </div>
        </div>
      </div>
      <?php
      if ($_SESSION["loginPerfil"] == 1 || $_SESSION["loginPerfil"] == 2) {
        include "widgets/adminboss.php";
      }
      ?>
      <div class="row">
        <div class="col-md-6">
          <div class="card card-gray">
            <div class="card-header">
              <h3 class="card-title font-weight-bold">Consolidado de Seguimientos</h3>
            </div>
            <div class="card-body">
              <div class="chart">
                <canvas id="barChart" width="400" height="400"></canvas>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card card-info">
            <div class="card-header">
              <h3 class="card-title font-weight-bold">10 Diagnósticos Frecuentes</h3>
            </div>
            <div class="card-body">
              <canvas id="donutChart" width="400" height="400"></canvas>
            </div>
          </div>
        </div>
      </div>

    </div>
  </section>
</div>