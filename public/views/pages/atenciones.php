<div class="content-wrapper">
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h4><strong>Acompañamiento:. Atenciones</strong></h4>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Acompañamiento</a></li>
            <li class="breadcrumb-item active">Atenciones</li>
          </ol>
        </div>
      </div>
    </div>
  </section>
  <section class="content">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Módulo Atenciones &nbsp;<i class="fas fa-archive"></i></h3>
      </div>
      <div class="card-body">
        <input type="hidden" value="<?php echo $_SESSION["loginId"]; ?>" id="idAtencionUsuario">
        <button type="btn" class="btn btn-secondary" data-toggle="modal" data-target="#modal-registrar-atencion"><i class="fas fa-archive"></i> Registrar Paciente
        </button>
        <button type="btn" class="ml-2 btn btn-success float-right" id="deshacer-filtro-Ate"><i class="fas fa-undo-alt"></i> Deshacer filtro
        </button>
        <button type="button" class="btn btn-default float-left float-sm-right float-lg-right mt-2 mt-lg-0 mt-sm-0" id="rango-atencion">
          <span>
            <i class="fa fa-calendar-plus"></i>
            <?php
            if (isset($_GET["fechaInicialAte"])) {

              echo $_GET["fechaInicialAte"] . " - " . $_GET["fechaFinalAte"];
            } else {

              echo 'Seleccione Rango de fecha';
            }
            ?>
          </span>
          <i class="fas fa-caret-down"></i>
        </button>
      </div>
      <div class="card-body">
        <table id="datatableAtenciones" class="table table-bordered table-hover dt-responsive datatableAtenciones">
          <thead>
            <tr>
              <th style="width: 10px">#</th>
              <th>N° Ficha</th>
              <th style="width: 10px">F.Registro</th>
              <th style="width: 10px">N° Cuenta</th>
              <th>N° HC</th>
              <th>Tip N° Doc</th>
              <th>F.Ingreso</th>
              <th>Est.Pac</th>
              <th>Apellidos y Nombres</th>
              <th>F.Financ</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if (isset($_GET["fechaInicialAte"])) {
              $fechaInicialAte = $_GET["fechaInicialAte"];
              $fechaFinalAte = $_GET["fechaFinalAte"];
            } else {
              $fechaInicialAte = null;
              $fechaFinalAte = null;
            }

            $atenciones = AtencionesControlador::ctrListarAtencionesF($fechaInicialAte, $fechaFinalAte);
            foreach ($atenciones as $key => $value) {
              // Estado de Paciente
              if ($value["idEstadoPacAtencion"] == 1) {
                $estadoPaciente = "<button type='button' class='btn btn-block btn-warning font-weight-bold' data-toggle='tooltip' data-placement='left' title='" . $value["detaEstadoPacAtencion"] . "'><i class='fas fa-procedures'></i></button>";
              } elseif ($value["idEstadoPacAtencion"] == 2) {
                $estadoPaciente = "<button type='button' class='btn btn-block btn-success font-weight-bold' data-toggle='tooltip' data-placement='left' title='" . $value["detaEstadoPacAtencion"] . "'><i class='fas fa-walking'></i></button>";
              } else {
                $estadoPaciente = "<button type='button' class='btn btn-block btn-danger font-weight-bold' data-toggle='tooltip' data-placement='left' title='" . $value["detaEstadoPacAtencion"] . "'><i class='fas fa-clinic-medical'></i></button>";
              }
              // Estado de Paciente

              // Estado de Atención
              if ($value["idEstadoAte"] == 1) {
                $estadoAtencion = "<button type='button' class='btn btn-block btn-success font-weight-bold'><i class='fas fa-clipboard-list'></i> " . $value["detaEstadoAte"] . "</button>";

                $botones = "<div class='btn-group'><button class='btn btn-warning btnEditarAtencion' idAtencion='" . $value["idAtencion"] . "' data-toggle='modal' data-target='#modal-editar-atencion'><i class='fas fa-edit'></i></button><button class='btn btn-secondary btnAnularAtencion' data-toggle='tooltip' data-placement='left' title='Anular Atención' idAtencion='" . $value["idAtencion"] . "' idCuenta='" . $value["cuentaAtencion"] . "' idEpisodio = '" . $value["idEpisodio"] . "'><i class='fas fa-power-off'></i></button></div>";
              } elseif ($value["idEstadoAte"] == 2) {
                $estadoAtencion = "<button type='button' class='btn btn-block btn-danger font-weight-bold'><i class='fa fa-ban'></i> " . $value["detaEstadoAte"] . "</button>";

                $botones = "<div class='btn-group'><button class='btn btn-warning disabled'><i class='fas fa-edit'></i></button><button class='btn btn-info disabled'><i class='fas fa-file-medical-alt'></i></button><button class='btn btn-secondary disabled'><i class='fas fa-power-off'></i></button></div>";
              } else {
                $estadoAtencion = "<button type='button' class='btn btn-block btn-info font-weight-bold'><i class='fa fa-check'></i> " . $value["detaEstadoAte"] . "</button>";

                $botones = "<div class='btn-group'><button class='btn btn-warning disabled'><i class='fas fa-edit'></i></button><button class='btn btn-secondary disabled'><i class='fas fa-power-off'></i></button></div>";
              }

              echo '<tr>
                                <td>' . ($key + 1) . '</td>
                                <td>' . $value["correlativo_Atencion"] . '</td>
                                <td>' . $value["fRegistroAtencion"] . '</td>
                                <td>' . $value["cuentaAtencion"] . '</td>
                                <td>' . $value["historiaAtencion"] . '</td>
                                <td>' . $value["tipdocAtencion"] . ' - ' . $value["nrodocAtencion"] . '</td>
                                <td>' . $value["fIngresoAtencion"] . '</td>
                                <td>' . $estadoPaciente . '</td>
                                <td>' . $value["apPaternoAtencion"] . ' ' . $value["apMaternoAtencion"] . ' ' . $value["nombAtencion"] . '</td>
                                <td>' . $value["financiaAtencion"] . '</td>
                                <td>' . $estadoAtencion . '</td>
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
<!-- Registrar Atención -->
<div id="modal-registrar-atencion" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formRegAte" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Registrar Atención de Paciente&nbsp; <i class="fas fa-hospital-user"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaNCuenta">N° de Cuenta &nbsp;</label>
                <i class="fas fa-hashtag"></i> *
                <div class="input-group">
                  <input type="text" name="rgaNCuenta" id="rgaNCuenta" class="form-control" placeholder="Ingrese N° Cuenta" required autocomplete="off" autofocus="autofocus" readonly>
                  <input type="hidden" name="usuRegAte" id="usuRegAte" value="<?php echo $_SESSION["loginId"]; ?>">
                  <input type="hidden" name="idEpisodio" id="idEpisodio">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4" id="btnCuentaPac1">
              <div class="form-group">
                <label>Búsqueda:<span class="text-danger">&nbsp;*</span></label>
                <div class="input-group">
                  <button type="button" class="btn btn-block btn-info" data-toggle="modal" data-target="#modal-busqueda-cuenta" id="btnCuentaPac"><i class="fas fa-search"></i> Consultar Datos</button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaNHC">N° de Historia &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="rgaNHC" id="rgaNHC" class="form-control" placeholder="Ingrese N° HC" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaFNac">F.Nacimiento</label>
                <i class="fas fa-calendar-alt"></i>
                <div class="input-group">
                  <input type="text" name="rgaFNac" id="rgaFNac" class="form-control" placeholder="Ingrese F. Nacimiento" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaTdoc">T.Doc &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="rgaTdoc" id="rgaTdoc" class="form-control" placeholder="Ingrese T.Doc" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaNDoc">N.Doc &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="rgaNDoc" id="rgaNDoc" class="form-control" placeholder="Ingrese N° Doc" autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgaAPaterno">Apellido Paterno &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="rgaAPaterno" id="rgaAPaterno" class="form-control" placeholder="Ingrese Apellido Paterno" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgaAMaterno">Apellido Materno &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="rgaAMaterno" id="rgaAMaterno" class="form-control" placeholder="Ingrese Apellido Materno" autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgaNombres">Nombres &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="rgaNombres" id="rgaNombres" class="form-control" placeholder="Ingrese Nombres" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-2">
              <div class="form-group">
                <label for="rgaEdad">Edad</label>
                <i class="fas fa-pager"></i> *
                <div class="input-group">
                  <input type="text" name="rgaEdad" id="rgaEdad" class="form-control" placeholder="Ingrese Edad" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaSexo">Sexo &nbsp;</label>
                <i class="fas fa-venus-mars"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="rgaSexo" id="rgaSexo">
                    <option value="0" id="setSex">Seleccione Sexo</option>
                    <?php
                    $sexPac = AtencionesControlador::ctrListarSexo();
                    foreach ($sexPac as $key => $value) {
                      echo '<option value="' . $value["idTipSexo"] . '">' . $value["detaTipSexo"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="rgaFinancia">Financimiento &nbsp;</label>
                <i class="fas fa-coins"></i> *
                <div class="input-group">
                  <input type="text" name="rgaFinancia" id="rgaFinancia" class="form-control" placeholder="Ingrese Financiamiento" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgaDistrito">Distrito &nbsp;</label>
                <i class="fas fa-search-location"></i> *
                <div class="input-group">
                  <input type="text" name="rgaDistrito" id="rgaDistrito" class="form-control" placeholder="Ingrese Distrito" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
              <div class="form-group">
                <label for="rgaEstadoPac">Estado Paciente &nbsp;</label>
                <i class="fas fa-user-injured"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="rgaEstadoPac" id="rgaEstadoPac">
                    <option value="0" id="setEstado">Seleccione Estado</option>
                    <?php
                    $estadoPac = AtencionesControlador::ctrListarEstadosPaciente();
                    foreach ($estadoPac as $key => $value) {
                      echo '<option value="' . $value["idEstadoPacAtencion"] . '">' . $value["detaEstadoPacAtencion"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
              <div class="form-group">
                <label for="rgaCama">Cama &nbsp;</label>
                <i class="fas fa-procedures"></i> *
                <div class="input-group">
                  <input type="text" name="rgaCama" id="rgaCama" class="form-control" placeholder="Ingrese N° Cama (Opcional)" autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="rgaFIngServicio">Fecha de Ingreso &nbsp;</label>
                <i class="fas fa-calendar-alt"></i> *
                <div class="input-group">
                  <input type="text" name="rgaFIngServicio" id="rgaFIngServicio" class="form-control" placeholder="Ingrese Fecha de Ingreso" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-8">
              <div class="form-group">
                <label for="rgaServicio">Servicio Ingresado &nbsp;</label>
                <i class="fas fa-hospital-alt"></i> *
                <div class="input-group">
                  <input type="text" name="rgaServicio" id="rgaServicio" class="form-control" placeholder="Ingrese Servicio" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnRegAte"><i class="fas fa-save"></i> Guardar</button>
          <button type="reset" class="btn btn-danger"><i class="fas fa-eraser"></i> Limpiar</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $registraAtencion = new AtencionesControlador();
        $registraAtencion->ctrRegistrarAtencion();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Registrar Atención -->
<!-- Busqueda de cuentas -->
<div id="modal-busqueda-cuenta" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header text-center" style="background: #7EB2C2; color: white">
        <h4 class="modal-title">Búsqueda de Paciente&nbsp; <i class="fas fa-hospital-user"></i></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-2">
            <div class="form-group">
              <label for="fCuenta">Filtro &nbsp;</label>
              <i class="fas fa-filter"></i> *
              <div class="input-group">
                <select class="form-control" style="width: 100%;" name="fCuenta" id="fCuenta">
                  <option value="1">DNI</option>
                  <option value="2">N° HC</option>
                </select>
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-3">
            <div class="form-group">
              <label for="">N° de DNI o HC &nbsp;</label>
              <i class="fas fa-hashtag"></i> *
              <div class="input-group">
                <input type="text" name="searchCuenta" id="searchCuenta" class="form-control" placeholder="Ingrese N° DNI o HC" required autocomplete="off" autofocus="autofocus">
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-2">
            <div class="form-group">
              <label>Buscar cuenta</label>
              <div class="input-group">
                <button type="button" class="btn btn-block btn-info" id="btnCuentaCarg1"><i class="fas fa-search"></i></button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-body">
        <div id="dataCuenta"></div>
      </div>
    </div>
  </div>
</div>
<!-- Busqueda de cuentas -->
<!-- Editar Atención -->
<div id="modal-editar-atencion" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="" role="form" id="formEdtAte" method="post">
        <div class="modal-header text-center" style="background: #5D646C; color: white">
          <h4 class="modal-title">Editar Atención de Paciente&nbsp; <i class="fas fa-hospital-user"></i></h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaCorrelativo">N° de Atención &nbsp;</label>
                <i class="fas fa-hashtag"></i> *
                <div class="input-group">
                  <input type="text" name="edtaCorrelativo" id="edtaCorrelativo" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                  <input type="hidden" name="idCuentaAct" id="idCuentaAct">
                  <input type="hidden" name="idEpisodioEdtAct" id="idEpisodioEdtAct">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaNCuenta">N° de Cuenta &nbsp;</label>
                <i class="fas fa-hashtag"></i> *
                <div class="input-group">
                  <input type="text" name="edtaNCuenta" id="edtaNCuenta" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                  <input type="hidden" name="usuEdtAte" id="usuEdtAte" value="<?php echo $_SESSION["loginId"]; ?>">
                  <input type="hidden" name="idAtencion" id="idAtencion">
                  <input type="hidden" name="idEpisodioEdt" id="idEpisodioEdt">
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4" id="btnCuentaPac2">
              <div class="form-group">
                <label>Búsqueda:<span class="text-danger">&nbsp;*</span></label>
                <div class="input-group">
                  <button type="button" class="btn btn-block btn-info" data-toggle="modal" data-target="#modal-busqueda-cuenta-edt" id="btnCuentaPac2"><i class="fas fa-search"></i> Consultar Datos Cuenta</button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaNHC">N° de Historia &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="edtaNHC" id="edtaNHC" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaFNac">F.Nacimiento</label>
                <i class="fas fa-calendar-alt"></i>
                <div class="input-group">
                  <input type="text" name="edtaFNac" id="edtaFNac" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaTdoc">T.Doc &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="edtaTdoc" id="edtaTdoc" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaNDoc">N.Doc &nbsp;</label>
                <i class="fas fa-id-card"></i> *
                <div class="input-group">
                  <input type="text" name="edtaNDoc" id="edtaNDoc" class="form-control" autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtaAPaterno">Apellido Paterno &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="edtaAPaterno" id="edtaAPaterno" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtaAMaterno">Apellido Materno &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="edtaAMaterno" id="edtaAMaterno" class="form-control" autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtaNombres">Nombres &nbsp;</label>
                <i class="fas fa-hospital-user"></i> *
                <div class="input-group">
                  <input type="text" name="edtaNombres" id="edtaNombres" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-2">
              <div class="form-group">
                <label for="edtaEdad">Edad</label>
                <i class="fas fa-pager"></i> *
                <div class="input-group">
                  <input type="text" name="edtaEdad" id="edtaEdad" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaSexo">Sexo &nbsp;</label>
                <i class="fas fa-venus-mars"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="edtaSexo" id="edtaSexo">
                    <option id="setSex2"></option>
                    <?php
                    $sexPac = AtencionesControlador::ctrListarSexo();
                    foreach ($sexPac as $key => $value) {
                      echo '<option value="' . $value["idTipSexo"] . '">' . $value["detaTipSexo"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-3">
              <div class="form-group">
                <label for="edtaFinancia">Financimiento &nbsp;</label>
                <i class="fas fa-coins"></i> *
                <div class="input-group">
                  <input type="text" name="edtaFinancia" id="edtaFinancia" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtaDistrito">Distrito &nbsp;</label>
                <i class="fas fa-search-location"></i> *
                <div class="input-group">
                  <input type="text" name="edtaDistrito" id="edtaDistrito" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
              <div class="form-group">
                <label for="edtaEstadoPac">Estado Paciente &nbsp;</label>
                <i class="fas fa-user-injured"></i> *
                <div class="input-group">
                  <select class="form-control" style="width: 100%;" name="edtaEstadoPac" id="edtaEstadoPac">
                    <option id="setEstado2"></option>
                    <?php
                    $estadoPac = AtencionesControlador::ctrListarEstadosPaciente();
                    foreach ($estadoPac as $key => $value) {
                      echo '<option value="' . $value["idEstadoPacAtencion"] . '">' . $value["detaEstadoPacAtencion"] . '</option>';
                    }
                    ?>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-6">
              <div class="form-group">
                <label for="edtaCama">Cama &nbsp;</label>
                <i class="fas fa-procedures"></i> *
                <div class="input-group">
                  <input type="text" name="edtaCama" id="edtaCama" class="form-control" placeholder="Ingrese N° Cama (Opcional)" autocomplete="off" autofocus="autofocus">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-4">
              <div class="form-group">
                <label for="edtaFIngServicio">Fecha de Ingreso &nbsp;</label>
                <i class="fas fa-calendar-alt"></i> *
                <div class="input-group">
                  <input type="text" name="edtaFIngServicio" id="edtaFIngServicio" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-8">
              <div class="form-group">
                <label for="edtaServicio">Servicio Ingresado &nbsp;</label>
                <i class="fas fa-hospital-alt"></i> *
                <div class="input-group">
                  <input type="text" name="edtaServicio" id="edtaServicio" class="form-control" required autocomplete="off" autofocus="autofocus" readonly>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="submit" class="btn btn-secondary" id="btnEdtAte"><i class="fas fa-save"></i> Guardar Cambios</button>
          <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fas fa-times-circle"></i> Salir</button>
        </div>
        <?php
        $editarAtencion = new AtencionesControlador();
        $editarAtencion->ctrEditarAtencion();
        ?>
      </form>
    </div>
  </div>
</div>
<!-- Editar Atención -->
<!-- Busqueda de cuentas -->
<div id="modal-busqueda-cuenta-edt" class="modal fade" role="dialog" aria-modal="true" style="padding-right: 17px;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header text-center" style="background: #7EB2C2; color: white">
        <h4 class="modal-title">Búsqueda de Paciente&nbsp; <i class="fas fa-hospital-user"></i></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-2">
            <div class="form-group">
              <label for="fCuenta2">Filtro &nbsp;</label>
              <i class="fas fa-filter"></i> *
              <div class="input-group">
                <select class="form-control" style="width: 100%;" name="fCuenta2" id="fCuenta2">
                  <option value="1">DNI</option>
                  <option value="2">N° HC</option>
                </select>
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-3">
            <div class="form-group">
              <label for="">N° de Cuenta &nbsp;</label>
              <i class="fas fa-hashtag"></i> *
              <div class="input-group">
                <input type="text" name="searchCuenta2" id="searchCuenta2" class="form-control" placeholder="Ingrese N° DNI o HC" required autocomplete="off" autofocus="autofocus">
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-2">
            <div class="form-group">
              <label>Buscar cuenta</label>
              <div class="input-group">
                <button type="button" class="btn btn-block btn-info" id="btnCuentaCarg2"><i class="fas fa-search"></i></button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-body">
        <div id="dataCuenta2"></div>
      </div>
    </div>
  </div>
</div>
<!-- Busqueda de cuentas -->
<?php
$anulaAtencion = new AtencionesControlador();
$anulaAtencion->ctrAnularAtencion();
?>