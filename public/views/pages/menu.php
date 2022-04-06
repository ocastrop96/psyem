<aside class="main-sidebar elevation-4 sidebar-light-info">
  <!-- Brand Logo -->
  <a href="dashboard" class="brand-link">
    <img src="public/views/resources/img/acpsy-logo-main.png" alt="ACPSY-logo" class="brand-image img-circle elevation-3" style="opacity: .8">
    <span class="brand-text font-weight-bolder">PSYEM-Web</span>
  </a>

  <div class="sidebar">
    <div class="user-panel mt-3 pb-3 d-flex">
      <div class="image">
        <img src="public/views/resources/img/logo-usuario-psico.jpg" class="img-circle elevation-2" alt="User Image">
      </div>
      <div class="info">
        <a href="dashboard" class="d-block font-weight-bolder">Hola! <br><?php echo $_SESSION["loginNombres"]; ?><br>
          <p class="font-italic"><?php echo $_SESSION["loginPerfilDesc"]; ?></p>
        </a>
      </div>
    </div>
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar nav-compact" data-widget="treeview" role="menu" data-accordion="false">
        <li class="nav-item">
          <a href="dashboard" class="nav-link">
            <i class="nav-icon fas fa-tachometer-alt"></i>
            <p>
              Dashboard
            </p>
          </a>
        </li>
        <?php
        if ($_SESSION["loginPerfil"] == 1) {
          echo '
          <li class="nav-header">Administración</li>
        <li class="nav-item">
          <a href="usuarios" class="nav-link">
            <i class="nav-icon fas fa-users"></i>
            <p>
              Usuarios
            </p>
          </a>
        </li>
        <li class="nav-header">Complementos</li>
        <li class="nav-item">
          <a href="profesionales" class="nav-link">
            <i class="nav-icon fas fa-id-card-alt"></i>
            <p>
              Profesionales
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="diagnosticos" class="nav-link">
            <i class="nav-icon fas fa-stethoscope"></i>
            <p>
              Diagnósticos
            </p>
          </a>
        </li>

        <li class="nav-header">Acompañamiento</li>
        <li class="nav-item">
          <a href="atenciones" class="nav-link">
            <i class="nav-icon fas fa-archive"></i>
            <p>
              Atenciones
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="familiares" class="nav-link">
            <i class="nav-icon fas fa-chalkboard-teacher"></i>
            <p>
              Familiares
            </p>
          </a>
        </li>
        <li class="nav-header">Supervisión</li>
        <li class="nav-item">
        <a href="monitoreo" class="nav-link">
          <i class="nav-icon fab fa-watchman-monitoring"></i>
          <p>
            Monitoreo
          </p>
        </a>
      </li>
      <li class="nav-item">
      <a href="pacientes" class="nav-link">
        <i class="nav-icon fas fa-procedures"></i>
        <p>
          Pacientes
        </p>
      </a>
    </li>
        <li class="nav-header">Reportes</li>
        <li class="nav-item">
          <a href="reporte-general" class="nav-link">
            <i class="nav-icon fas fa-chart-pie"></i>
            <p>
              General
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="reporte-jefatura" class="nav-link">
            <i class="nav-icon fas fa-chart-line"></i>
            <p>
              Jefatura
            </p>
          </a>
        </li>
        <li class="nav-item">
        <a href="reporte-control" class="nav-link">
          <i class="nav-icon fas fa-project-diagram"></i>
          <p>
            Control
          </p>
        </a>
      </li>
          ';
        } elseif ($_SESSION["loginPerfil"] == 2) {
          echo '
        <li class="nav-header">Complementos</li>
        <li class="nav-item">
          <a href="profesionales" class="nav-link">
            <i class="nav-icon fas fa-id-card-alt"></i>
            <p>
              Profesionales
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="diagnosticos" class="nav-link">
            <i class="nav-icon fas fa-stethoscope"></i>
            <p>
              Diagnósticos
            </p>
          </a>
        </li>

        <li class="nav-header">Acompañamiento</li>
        <li class="nav-item">
          <a href="atenciones" class="nav-link">
            <i class="nav-icon fas fa-archive"></i>
            <p>
              Atenciones
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="familiares" class="nav-link">
            <i class="nav-icon fas fa-chalkboard-teacher"></i>
            <p>
              Familiares
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="seguimiento" class="nav-link">
            <i class="nav-icon fas fa-diagnoses"></i>
            <p>
              Seguimiento
            </p>
          </a>
        </li>
        <li class="nav-header">Supervisión</li>
        <li class="nav-item">
        <a href="monitoreo" class="nav-link">
          <i class="nav-icon fab fa-watchman-monitoring"></i>
          <p>
            Monitoreo
          </p>
        </a>
      </li>
      <li class="nav-item">
      <a href="pacientes" class="nav-link">
        <i class="nav-icon fas fa-procedures"></i>
        <p>
          Pacientes
        </p>
      </a>
    </li>
        <li class="nav-header">Reportes</li>
        <li class="nav-item">
          <a href="reporte-general" class="nav-link">
            <i class="nav-icon fas fa-chart-pie"></i>
            <p>
              General
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="reporte-jefatura" class="nav-link">
            <i class="nav-icon fas fa-chart-line"></i>
            <p>
              Jefatura
            </p>
          </a>
        </li>
        <li class="nav-item">
        <a href="reporte-control" class="nav-link">
          <i class="nav-icon fas fa-project-diagram"></i>
          <p>
            Control
          </p>
        </a>
      </li>';
        } elseif ($_SESSION["loginPerfil"] == 3) {
          echo '
          <li class="nav-header">Acompañamiento</li>
          <li class="nav-item">
            <a href="atenciones" class="nav-link">
              <i class="nav-icon fas fa-archive"></i>
              <p>
                Atenciones
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="familiares" class="nav-link">
              <i class="nav-icon fas fa-chalkboard-teacher"></i>
              <p>
                Familiares
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="seguimiento" class="nav-link">
              <i class="nav-icon fas fa-diagnoses"></i>
              <p>
                Seguimiento
              </p>
            </a>
          </li>
          <li class="nav-header">Reportes</li>
          <li class="nav-item">
            <a href="reporte-profesional" class="nav-link">
              <i class="nav-icon fas fa-chart-bar"></i>
              <p>
                Profesional
              </p>
            </a>
          </li>
            ';
        } else {
          echo '
        <li class="nav-header">Acompañamiento</li>
        <li class="nav-item">
          <a href="atenciones" class="nav-link">
            <i class="nav-icon fas fa-archive"></i>
            <p>
              Atenciones
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="familiares" class="nav-link">
            <i class="nav-icon fas fa-chalkboard-teacher"></i>
            <p>
              Familiares
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="seguimiento" class="nav-link">
            <i class="nav-icon fas fa-diagnoses"></i>
            <p>
              Seguimiento
            </p>
          </a>
        </li>
        <li class="nav-header">Supervisión</li>
        <li class="nav-item">
        <a href="monitoreo" class="nav-link">
          <i class="nav-icon fab fa-watchman-monitoring"></i>
          <p>
            Monitoreo
          </p>
        </a>
      </li>
      <li class="nav-item">
      <a href="pacientes" class="nav-link">
        <i class="nav-icon fas fa-procedures"></i>
        <p>
          Pacientes
        </p>
      </a>
    </li>
        <li class="nav-header">Reportes</li>
        <li class="nav-item">
          <a href="reporte-profesional" class="nav-link">
            <i class="nav-icon fas fa-chart-bar"></i>
            <p>
              Profesional
            </p>
          </a>
        </li>
        <li class="nav-item">
          <a href="reporte-control" class="nav-link">
            <i class="nav-icon fas fa-project-diagram"></i>
            <p>
              Control
            </p>
          </a>
        </li>
          ';
        } ?>
      </ul>
    </nav>
  </div>
</aside>