<?php
if ($_SESSION["loginPerfil"] == 3 || $_SESSION["loginPerfil"] == 2 || $_SESSION["loginPerfil"] == 4) {
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
          <h4><strong>Administración:. Usuarios</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Administración</a></li>
            <li class="breadcrumb-item active">Usuarios</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Usuarios &nbsp;<i class="fas fa-users-cog"></i></h3>
      </div>
      <div class="card-body">
        <button type="btn" class="btn btn-secondary" data-toggle="modal" data-target="#modal-registrar-usuario"><i class="fas fa-user-plus"></i> Registrar Usuario
        </button>
      </div>
      <div class="card-body">
        <table id="datatableUsuarios" class="table table-bordered table-hover dt-responsive datatableUsuarios">
          <thead>
            <tr>
              <th style="width: 10px">#</th>
              <th>DNI N°</th>
              <th>Nombres</th>
              <th>Apellidos</th>
              <th>Perfil</th>
              <th>Correo</th>
              <th>Cuenta</th>
              <th>Fecha de Alta</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
        </table>
      </div>
    </div>
  </section>
</div>
<div id="modal-registrar-usuario" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formRegUs" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Registrar Usuario &nbsp; <i class="fas fa-users-cog"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgDni">N° DNI &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="rgDni" id="rgDni" class="form-control" placeholder="Ingrese N° DNI" required autocomplete="off" autofocus="autofocus" minlength="8" maxlength="12">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4" id="btnDNIUsuario">
              <div class="form-group">
                <label>Búsqueda:<span class="text-danger">&nbsp;*</span></label>
                <div class="input-group">
                  <button type="button" class="btn btn-block btn-info" id="btnDNIU"><i class="fas fa-search"></i>&nbsp;Consulta DNI</button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgNombres">Nombres &nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="rgNombres" id="rgNombres" class="form-control" placeholder="Ingrese nombres" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-5">
              <div class="form-group">
                <label for="rgApellidos">Apellidos &nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="rgApellidos" id="rgApellidos" class="form-control" placeholder="Ingrese apellidos" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgPerfil">Perfil &nbsp;</label>
                <i class="fas fa-id-card-alt"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="rgPerfil" id="rgPerfil">
                    <option value="0">Seleccione perfil</option>
                    <?php
                    $itemPerfil = null;
                    $valorPerfil  = null;
                    $perfil = UsuariosControlador::ctrListarPerfilesUsuarios($itemPerfil, $valorPerfil);
                    foreach ($perfil as $key => $value) {
                      echo '<option value="' . $value["idPerfil"] . '">' . $value["detallePerfil"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgCorreo">Correo &nbsp;</label>
                <i class="fas fa-at"></i> *
                <div class="input-group">
                  <input type="email" name="rgCorreo" id="rgCorreo" class="form-control" placeholder="Ingrese correo" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgUsuario">Usuario &nbsp;</label>
                <i class="fas fa-user"></i> *
                <div class="input-group">
                  <input type="text" name="rgUsuario" id="rgUsuario" class="form-control" placeholder="Ingrese usuario" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgClave">Contraseña &nbsp;</label>
                <i class="fas fa-key"></i> *
                <div class="input-group">
                  <input type="password" name="rgClave" id="rgClave" class="form-control" placeholder="Ingrese contraseña" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnRegUsu"><i class="fas fa-save"></i> Guardar</button>
          <button type="reset" class="btn btn-danger"><i class="fas fa-eraser"></i> Limpiar</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $registroUsuario = new UsuariosControlador();
        $registroUsuario->ctrRegistrarUsuario();
        ?>
      </form>
    </div>
  </div>
</div>

<!-- Editar Usuario -->
<div id="modal-editar-usuario" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formEdtUs" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Editar Usuario &nbsp; <i class="fas fa-users-cog"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtDni">N° DNI &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="edtDni" id="edtDni" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
                <input type="hidden" name="idUsuario" id="idUsuario">
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4" id="btnEdtDNIUsuario">
              <div class="form-group">
                <label>Búsqueda:<span class="text-danger">&nbsp;*</span></label>
                <div class="input-group">
                  <button type="button" class="btn btn-block btn-info" id="btnDNIUEdt"><i class="fas fa-search"></i>&nbsp;Consulta DNI</button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtNombres">Nombres &nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="edtNombres" id="edtNombres" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtApellidos">Apellidos &nbsp;</label>
                <i class="fas fa-signature"></i> *
                <div class="input-group">
                  <input type="text" name="edtApellidos" id="edtApellidos" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtPerfi1">Perfil &nbsp;</label>
                <i class="fas fa-id-card-alt"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="edtPerfil" id="edtPerfi1">
                    <option id="edtPerfil"></option>
                    <?php
                    $itemPerfil = null;
                    $valorPerfil  = null;
                    $perfil = UsuariosControlador::ctrListarPerfilesUsuarios($itemPerfil, $valorPerfil);
                    foreach ($perfil as $key => $value) {
                      echo '<option value="' . $value["idPerfil"] . '">' . $value["detallePerfil"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtCorreo">Correo &nbsp;</label>
                <i class="fas fa-at"></i> *
                <div class="input-group">
                  <input type="email" name="edtCorreo" id="edtCorreo" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtUsuario">Usuario &nbsp;</label>
                <i class="fas fa-user"></i> *
                <div class="input-group">
                  <input type="text" name="edtUsuario" id="edtUsuario" class="form-control" required autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtClave">Contraseña &nbsp;</label>
                <i class="fas fa-key"></i> *
                <div class="input-group">
                  <input type="password" name="edtClave" id="edtClave" class="form-control" autocomplete="off" autofocus="autofocus">
                  <input type="hidden" name="passActual" id="passActual">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnEdtUsu"><i class="fas fa-save"></i> Guardar cambios</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $editarUsuario = new UsuariosControlador();
        $editarUsuario->ctrEditarUsuario();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Editar Usuario -->
<!-- Eliminar Usuario -->
<?php
$eliminarUsuario = new UsuariosControlador();
$eliminarUsuario->ctrEliminarUsuario();
?>
<!-- Eliminar Usuario -->