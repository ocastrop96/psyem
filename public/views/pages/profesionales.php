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
          <h4><strong>Complementos:. Profesionales</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Complementos</a></li>
            <li class="breadcrumb-item active">Profesionales</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Profesionales &nbsp;<i class="fas fa-id-card-alt"></i></h3>
      </div>
      <div class="card-body">
        <button type="btn" class="btn btn-secondary" data-toggle="modal" data-target="#modal-registrar-profesional"><i class="fas fa-id-card-alt"></i> Registrar Profesional
        </button>
      </div>
      <div class="card-body">
        <table id="datatableProfesionales" class="table table-bordered table-hover dt-responsive datatableProfesionales">
          <thead>
            <tr>
              <th style="width: 10px">#</th>
              <th>DNI N°</th>
              <th>CPsP N°</th>
              <th>Nombres</th>
              <th>Apellidos</th>
              <th>Condición</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
        </table>
      </div>
    </div>
  </section>
</div>
<!-- Registro de Profesionales -->
<div id="modal-registrar-profesional" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formRegProf" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Registrar Profesional &nbsp; <i class="fas fa-user-md"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgpDni">DNI N° &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="rgpDni" id="rgpDni" class="form-control" placeholder="Ingrese N° DNI" required autocomplete="off" autofocus="autofocus" minlength="8" maxlength="12">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3" id="btnDNIUsuario">
              <div class="form-group">
                <label>Búsqueda:<span class="text-danger">&nbsp;*</span></label>
                <div class="input-group">
                  <button type="button" class="btn btn-block btn-info" id="btnDNIP"><i class="fas fa-search"></i>&nbsp;Consulta DNI</button>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgpCpsp">CPsP N° &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="rgpCpsp" id="rgpCpsp" class="form-control" placeholder="Ingrese N° CPsP" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgpNombres">Nombres Profesional&nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="rgpNombres" id="rgpNombres" class="form-control" placeholder="Ingrese nombres" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-5">
              <div class="form-group">
                <label for="rgpApellidos">Apellidos Profesional&nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="rgpApellidos" id="rgpApellidos" class="form-control" placeholder="Ingrese apellidos" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgpCondicion">Condición Laboral &nbsp;</label>
                <i class="fas fa-id-card-alt"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="rgpCondicion" id="rgpCondicion">
                    <option value="0">Sel. condición</option>
                    <?php
                    $condP = ProfesionalesControlador::ctrListarCondicion();
                    foreach ($condP as $key => $value) {
                      echo '<option value="' . $value["idCondicion"] . '">' . $value["detaCondicion"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnRegProf"><i class="fas fa-save"></i> Guardar</button>
          <button type="reset" class="btn btn-danger"><i class="fas fa-eraser"></i> Limpiar</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $registroProfesional = new ProfesionalesControlador();
        $registroProfesional->ctrRegistrarProfesional();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Registro de Profesionales -->

<!-- Editar Profesionales -->
<div id="modal-editar-profesional" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formEdtProf" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Editar Profesional &nbsp; <i class="fas fa-user-md"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtpDni">DNI N° &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="edtpDni" id="edtpDni" class="form-control" required autocomplete="off" autofocus="autofocus" minlength="8" maxlength="12">
                  <input type="hidden" name="idProfesional" id="idProfesional">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3" id="btnDNIUsuario">
              <div class="form-group">
                <label>Búsqueda:<span class="text-danger">&nbsp;*</span></label>
                <div class="input-group">
                  <button type="button" class="btn btn-block btn-info" id="btnDNIEdtP"><i class="fas fa-search"></i>&nbsp;Consulta DNI</button>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtpCpsp">CPsP N° &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="edtpCpsp" id="edtpCpsp" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtpNombres">Nombres Profesional&nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="edtpNombres" id="edtpNombres" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-5">
              <div class="form-group">
                <label for="edtpApellidos">Apellidos Profesional&nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="edtpApellidos" id="edtpApellidos" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtpCondicion1">Condición Laboral &nbsp;</label>
                <i class="fas fa-id-card-alt"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="edtpCondicion" id="edtpCondicion1">
                    <option id="edtpCondicion"></option>
                    <?php
                    $condP = ProfesionalesControlador::ctrListarCondicion();
                    foreach ($condP as $key => $value) {
                      echo '<option value="' . $value["idCondicion"] . '">' . $value["detaCondicion"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnEdtProf"><i class="fas fa-save"></i> Guardar cambios</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $editarProfesional = new ProfesionalesControlador();
        $editarProfesional->ctrEditarProfesional();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Editar Profesionales -->
<?php
$eliminarProfesional = new ProfesionalesControlador();
$eliminarProfesional->ctrEliminarProfesional();
?>