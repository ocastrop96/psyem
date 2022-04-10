-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 10-04-2022 a las 21:47:59
-- Versión del servidor: 10.1.48-MariaDB
-- Versión de PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db-paus-web`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CargarHojaReclamo` (IN `_hashcode` TEXT)   BEGIN
SELECT
	sc_reclamo.correlativo, 
	DATE_FORMAT( sc_reclamo.fechaReclamo, '%d/%m/%Y' ) AS fechaReclamo, 
	DATE_FORMAT( sc_reclamo.fechaReclamo, '%d' ) AS diaRec, 
	DATE_FORMAT( sc_reclamo.fechaReclamo, '%m' ) AS mesRec, 
	DATE_FORMAT( sc_reclamo.fechaReclamo, '%Y' ) AS anioRec, 
	TIME_FORMAT( sc_reclamo.horaReclamo, "%r" ) AS horaReclamo, 
	TIME_FORMAT( sc_reclamo.horaReclamo, "%h" ) AS horaRec, 
	TIME_FORMAT( sc_reclamo.horaReclamo, "%i" ) AS minRec, 
	TIME_FORMAT( sc_reclamo.horaReclamo, "%p" ) AS PMAMRec, 
	sc_reclamo.tipoDoc, 
	sc_tipodocumento.abrvTipDoc AS docUsuario, 
	sc_reclamo.nDoc, 
	IF(sc_reclamo.tipoDoc = 7,sc_reclamo.razonSocial,CONCAT(sc_reclamo.nombres,' ',sc_reclamo.apellidoPat,' ',sc_reclamo.apellidoMat)) AS UsuarioAfectado, 
	sc_reclamo.email, 
	sc_reclamo.telefono, 
	sc_distrito.descDistrito AS ubgDistrito, 
	sc_reclamo.domicilio, 
	sc_reclamo.tipoDocR, 
	docRep.abrvTipDoc AS docRepre,
	sc_reclamo.nDocR,  
	IF(sc_reclamo.tipoDocR = 7,sc_reclamo.rsocialR,CONCAT(sc_reclamo.nombresR,' ',sc_reclamo.apellidoPatR,' ',sc_reclamo.apellidoMatR)) AS representUsuario, 
	sc_reclamo.emailRep, 
	sc_reclamo.domicilioR,
	sc_reclamo.telefonoR, 
	sc_tipousuario.descTipUsuario, 
	sc_reclamo.regsRep, 
	DATE_FORMAT( sc_reclamo.fechaOcurrencia, '%d/%m/%Y' ) AS fechaOcurrencia, 
	sc_derecho.descDerechoSal, 
	sc_causaespecifica.descCausaEsp, 
	sc_reclamo.detalleReclamo,
	IF(sc_reclamo.autoCorreo = 1,'SI','NO') as autorizaCorreo
FROM
	sc_reclamo
	INNER JOIN
	sc_tipodocumento
	ON 
		sc_reclamo.tipoDoc = sc_tipodocumento.idTipoDoc
	INNER JOIN
	sc_distrito
	ON 
		sc_reclamo.distrito = sc_distrito.idDistrito
	LEFT JOIN
	sc_tipodocumento AS docRep
	ON 
		sc_reclamo.tipoDocR = docRep.idTipoDoc
	INNER JOIN
	sc_tipousuario
	ON 
		sc_reclamo.tipoUsuario = sc_tipousuario.idTipUsuario
	INNER JOIN
	sc_derecho
	ON 
		sc_reclamo.derecho = sc_derecho.idDerecho
	INNER JOIN
	sc_causaespecifica
	ON 
		sc_reclamo.causaEspecifica = sc_causaespecifica.idCausaEsp
WHERE
	autogenerado = _hashcode;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CorrelativoReclamo` (IN `_codigo` TEXT)   BEGIN
SELECT
				CONCAT(
					'Se ha registrado el reclamo N° ',
					sc_reclamo.correlativo,
					' para el Usuario ',
					sc_reclamo.razonSocial,
					'',
					sc_reclamo.nombres,
					' ',
					sc_reclamo.apellidoPat,
					' ',
					sc_reclamo.apellidoMat,'. Verifique el mensaje de confirmación en su correo electrónico.' 
				) AS mensaje 
			FROM
				sc_reclamo 
			WHERE
				autogenerado = _codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCausasEspecificas` ()   SELECT
	sc_causaespecifica.idCausaEsp, 
	sc_causaespecifica.descCausaEsp, 
	sc_causaespecifica.derechoId, 
	sc_derecho.descDerechoSal, 
	sc_causaespecifica.estadoItemCE, 
	sc_estadoitem.descEstadoItem
FROM
	sc_causaespecifica
	INNER JOIN
	sc_derecho
	ON 
		sc_causaespecifica.derechoId = sc_derecho.idDerecho
	INNER JOIN
	sc_estadoitem
	ON 
		sc_causaespecifica.estadoItemCE = sc_estadoitem.idEstadoItem
		ORDER BY estadoItemCE ASC, idCausaEsp ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarCausasxDerecho` (IN `_parametro` INT(11))   SELECT
	sc_causaespecifica.idCausaEsp, 
	sc_causaespecifica.descCausaEsp, 
	sc_causaespecifica.derechoId, 
	sc_causaespecifica.estadoItemCE
FROM
	sc_causaespecifica WHERE estadoItemCE = 1  AND derechoId = _parametro$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarConsultas` ()   SELECT
	sc_consulta.idConsulta, 
	sc_consulta.correlativoCon, 
	date_format(sc_consulta.fechaCon,'%d/%m/%Y') as fechaCon,
	time_format(sc_consulta.horaCon,'%H:%i %p') as horaCon, 
	sc_consulta.tDoc, 
	sc_tipodocumento.abrvTipDoc, 
	sc_consulta.nDoc,
	sc_consulta.nombresAp, 
	sc_consulta.edad, 
	sc_consulta.sexoCon, 
	sc_sexo.descSexo, 
	sc_consulta.telefono, 
	sc_consulta.distrito, 
	sc_distrito.descDistrito, 
	sc_consulta.email, 
	sc_consulta.detalleConsulta, 
	sc_consulta.autogenerado, 
	sc_consulta.estadoDoc, 
	sc_estadodoc.descEstadoDoc
FROM
	sc_consulta
	INNER JOIN
	sc_tipodocumento
	ON 
		sc_consulta.tDoc = sc_tipodocumento.idTipoDoc
	INNER JOIN
	sc_sexo
	ON 
		sc_consulta.sexoCon = sc_sexo.idSexo
	INNER JOIN
	sc_distrito
	ON 
		sc_consulta.distrito = sc_distrito.idDistrito
	INNER JOIN
	sc_estadodoc
	ON 
		sc_consulta.estadoDoc = sc_estadodoc.idEstadoDoc ORDER BY correlativoCon DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDepartamentos` ()   SELECT
	sc_departamento.idDepartamento, 
	sc_departamento.descDepartamento
FROM
	sc_departamento WHERE idDepartamento = 15$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDerechos` ()   SELECT
	sc_derecho.idDerecho, 
	sc_derecho.descDerechoSal, 
	sc_derecho.estadoItemDer, 
	sc_estadoitem.descEstadoItem
FROM
	sc_derecho
	INNER JOIN
	sc_estadoitem
	ON 
		sc_derecho.estadoItemDer = sc_estadoitem.idEstadoItem ORDER BY estadoItemDer ASC, idDerecho ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDerechosForm` ()   SELECT
	sc_derecho.idDerecho, 
	sc_derecho.descDerechoSal
FROM
	sc_derecho
WHERE
	estadoItemDer = 1
ORDER BY
	idDerecho ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarDistritosxProv` (IN `_parametro` INT(11))   SELECT
	sc_distrito.idDistrito, 
	sc_distrito.descDistrito, 
	sc_distrito.provId
FROM
	sc_distrito WHERE provId = _parametro$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarProvinciasxDep` (IN `_parametro` INT(11))   SELECT
	sc_provincia.idProvincia, 
	sc_provincia.descProvincia, 
	sc_provincia.DepaId
FROM
	sc_provincia WHERE DepaId = _parametro AND idProvincia = 127$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarReclamos` ()   SELECT
	sc_reclamo.idReclamo, 
	sc_reclamo.correlativo, 
	date_format( sc_reclamo.fechaReclamo, '%d/%m/%Y' ) AS fechaReclamo, 
	sc_reclamo.tipoDoc, 
	sc_tipodocumento.abrvTipDoc, 
	sc_reclamo.nDoc,
	sc_reclamo.razonSocial, 
	sc_reclamo.nombres, 
	sc_reclamo.apellidoPat, 
	sc_reclamo.apellidoMat, 
	sc_reclamo.sexo, 
	sc_sexo.descSexo, 
	sc_reclamo.email, 
	sc_reclamo.telefono, 
	sc_reclamo.departamento, 
	sc_departamento.descDepartamento, 
	sc_reclamo.provincia, 
	sc_provincia.descProvincia, 
	sc_reclamo.distrito, 
	sc_distrito.descDistrito, 
	sc_reclamo.domicilio, 
	sc_reclamo.tipoDocR, 
	sc_reclamo.nDocR, 
	tdoc2.abrvTipDoc AS descTipoDocR,
	sc_reclamo.rsocialR, 
	sc_reclamo.nombresR, 
	sc_reclamo.emailRep, 
	sc_reclamo.domicilioR, 
	sc_reclamo.telefonoR, 
	sc_reclamo.tipoUsuario, 
	sc_tipousuario.descTipUsuario, 
	date_format( sc_reclamo.fechaOcurrencia, '%d/%m/%Y' ) AS fechaOcurrencia, 
	sc_reclamo.derecho, 
	sc_derecho.descDerechoSal, 
	sc_reclamo.causaEspecifica, 
	sc_causaespecifica.descCausaEsp, 
	sc_reclamo.detalleReclamo, 
	sc_reclamo.estadoRec, 
	sc_estadoreclamo.descEstadoRec, 
	sc_reclamo.etapaReclamo, 
	sc_etapasrec.descEtapa, 
	sc_reclamo.resulRec, 
	sc_resultadorec.descResultado, 
	sc_reclamo.autogenerado, 
	sc_reclamo.autoCorreo
FROM
	sc_reclamo
	INNER JOIN
	sc_tipodocumento
	ON 
		sc_reclamo.tipoDoc = sc_tipodocumento.idTipoDoc
	INNER JOIN
	sc_sexo
	ON 
		sc_reclamo.sexo = sc_sexo.idSexo
	INNER JOIN
	sc_departamento
	ON 
		sc_reclamo.departamento = sc_departamento.idDepartamento
	INNER JOIN
	sc_provincia
	ON 
		sc_departamento.idDepartamento = sc_provincia.DepaId AND
		sc_reclamo.provincia = sc_provincia.idProvincia
	INNER JOIN
	sc_distrito
	ON 
		sc_reclamo.distrito = sc_distrito.idDistrito AND
		sc_provincia.idProvincia = sc_distrito.provId
	INNER JOIN
	sc_tipodocumento AS tdoc2
	ON 
		sc_reclamo.tipoDoc = tdoc2.idTipoDoc
	LEFT JOIN
	sc_tipousuario
	ON 
		sc_reclamo.tipoUsuario = sc_tipousuario.idTipUsuario
	INNER JOIN
	sc_derecho
	ON 
		sc_reclamo.derecho = sc_derecho.idDerecho
	INNER JOIN
	sc_causaespecifica
	ON 
		sc_derecho.idDerecho = sc_causaespecifica.derechoId AND
		sc_reclamo.causaEspecifica = sc_causaespecifica.idCausaEsp
	INNER JOIN
	sc_estadoreclamo
	ON 
		sc_reclamo.estadoRec = sc_estadoreclamo.idEstadoRec
	INNER JOIN
	sc_etapasrec
	ON 
		sc_reclamo.etapaReclamo = sc_etapasrec.idEtapa
	INNER JOIN
	sc_resultadorec
	ON 
		sc_reclamo.resulRec = sc_resultadorec.idResultado
ORDER BY
	correlativo DESC, 
	idReclamo DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarSugerencias` ()   SELECT
	sc_sugerencia.idSugerencia, 
	sc_sugerencia.correlativoSug,
	date_format(sc_sugerencia.fechaSugerencia,'%d/%m/%Y') as fechaSugerencia,
	time_format(sc_sugerencia.horaSugerencia,'%H:%i %p') as horaSugerencia, 
	sc_sugerencia.tDoc, 
	sc_tipodocumento.abrvTipDoc, 
	sc_sugerencia.nDoc, 
	sc_sugerencia.nombresAp, 
	sc_sugerencia.edad, 
	sc_sugerencia.sexoSug, 
	sc_sexo.descSexo, 
	sc_sugerencia.telefono, 
	sc_sugerencia.distrito, 
	sc_distrito.descDistrito, 
	sc_sugerencia.email, 
	sc_sugerencia.detalleSugerencia, 
	sc_sugerencia.autogenerado, 
	sc_sugerencia.estadoDoc, 
	sc_estadodoc.descEstadoDoc
FROM
	sc_sugerencia
	INNER JOIN
	sc_tipodocumento
	ON 
		sc_sugerencia.tDoc = sc_tipodocumento.idTipoDoc
	INNER JOIN
	sc_sexo
	ON 
		sc_sugerencia.sexoSug = sc_sexo.idSexo
	INNER JOIN
	sc_distrito
	ON 
		sc_sugerencia.distrito = sc_distrito.idDistrito
	INNER JOIN
	sc_estadodoc
	ON 
		sc_sugerencia.estadoDoc = sc_estadodoc.idEstadoDoc ORDER BY correlativoSug DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTiposDoc` (IN `_opcion` INT(11))   IF _opcion = 1 THEN
	SELECT
	sc_tipodocumento.idTipoDoc, 
	sc_tipodocumento.abrvTipDoc, 
	sc_tipodocumento.longTipDoc
FROM
	sc_tipodocumento;
ELSE
	SELECT
	sc_tipodocumento.idTipoDoc, 
	sc_tipodocumento.abrvTipDoc, 
	sc_tipodocumento.longTipDoc
FROM
	sc_tipodocumento WHERE idTipoDoc NOT IN(5,6);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTiposDocDetalle` (IN `_opcion` INT(11))   SELECT
	sc_tipodocumento.idTipoDoc, 
	sc_tipodocumento.longTipDoc
FROM
	sc_tipodocumento WHERE idTipoDoc = _opcion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTipoSexo` ()   SELECT
	sc_sexo.idSexo, 
	sc_sexo.descSexo
FROM
	sc_sexo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTiposUsuarios` ()   SELECT
sc_tipousuario.idTipUsuario,
sc_tipousuario.descTipUsuario 
FROM
	sc_tipousuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarUsuarios` ()   SELECT
	sc_usuario.idUsuario, 
	sc_usuario.dni, 
	sc_usuario.nombres, 
	sc_usuario.apellidos, 
	sc_usuario.cuenta, 
	sc_usuario.idPerfil, 
	sc_perfil.descPerfil, 
	sc_usuario.idEstado, 
	sc_estusuario.descEstadoUs, 
	sc_usuario.correo, 
	sc_usuario.clave, 
	sc_usuario.intentos,
	date_format(sc_usuario.fechaAlta,'%d/%m/%Y') AS fechaAlta
FROM
	sc_usuario
	INNER JOIN
	sc_perfil
	ON 
		sc_usuario.idPerfil = sc_perfil.idPerfil
	INNER JOIN
	sc_estusuario
	ON 
		sc_usuario.idEstado = sc_estusuario.idEstadoUs
	ORDER BY sc_usuario.idPerfil ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Listar_Parametros` (IN `_tipParametro` INT)   SELECT
sc_parametros.idParametro,
sc_parametros.tipParametro,
sc_parametros.detalleParametro,
sc_parametros.detalleParametro2,
sc_parametros.correoParametro,
sc_parametros.estatusParametro 
FROM
	sc_parametros 
WHERE
	tipParametro = _tipParametro 
	AND estatusParametro = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LoginUsuario` (IN `_cuenta` VARCHAR(50))   SELECT
	sc_usuario.idUsuario, 
	sc_usuario.idPerfil, 
	sc_usuario.idEstado, 
	sc_usuario.dni, 
	sc_usuario.nombres, 
	sc_usuario.apellidos, 
	sc_usuario.cuenta, 
	sc_usuario.clave, 
	sc_usuario.intentos
FROM
	sc_usuario WHERE sc_usuario.cuenta = _cuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarIntentos` (IN `_idUsuario` INT(11))   UPDATE sc_usuario 
SET intentos = intentos + 1 
WHERE
	idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistroReclamo` (IN `_fechaReclamo` DATE, IN `_horaReclamo` TIME, IN `_tipoDoc` INT(11), IN `_nDoc` VARCHAR(15), IN `_razonSocial` VARCHAR(150), IN `_nombres` VARCHAR(150), IN `_apellidoPat` VARCHAR(150), IN `_apellidoMat` VARCHAR(150), IN `_sexo` INT(11), IN `_email` VARCHAR(50), IN `_telefono` TEXT, IN `_departamento` INT(11), IN `_provincia` INT(11), IN `_distrito` INT(11), IN `_domicilio` TEXT, IN `_tipoDocR` INT(11), IN `_nDocR` VARCHAR(15), IN `_nombresR` VARCHAR(150), IN `_apellidoPatR` VARCHAR(150), IN `_apellidoMatR` VARCHAR(150), IN `_rsocialR` VARCHAR(150), IN `_emailRep` VARCHAR(50), IN `_domicilioR` TEXT, IN `_telefonoR` TEXT, IN `_regsRep` INT(11), IN `_tipoUsuario` INT(11), IN `_fechaOcurrencia` DATE, IN `_derecho` INT(11), IN `_causaEspecifica` INT(11), IN `_detalleReclamo` TEXT, IN `_autogenerado` TEXT, IN `_autoCorreo` INT(11))   INSERT INTO sc_reclamo (
	fechaReclamo,
	horaReclamo,
	tipoDoc,
	nDoc,
	razonSocial,
	nombres,
	apellidoPat,
	apellidoMat,
	sexo,
	email,
	telefono,
	departamento,
	provincia,
	distrito,
	domicilio,
	tipoDocR,
	nDocR,
	nombresR,
	apellidoPatR,
	apellidoMatR,
	rsocialR,
	emailRep,
	domicilioR,
	telefonoR,
	regsRep,
	tipoUsuario,
	fechaOcurrencia,
	derecho,
	causaEspecifica,
	detalleReclamo,
	autogenerado,
	autoCorreo 
)
VALUES
	(
		_fechaReclamo,
		_horaReclamo,
		_tipoDoc,
		_nDoc,
		_razonSocial,
		_nombres,
		_apellidoPat,
		_apellidoMat,
		_sexo,
		_email,
		_telefono,
		_departamento,
		_provincia,
		_distrito,
		_domicilio,
		_tipoDocR,
		_nDocR,
		_nombresR,
		_apellidoPatR,
		_apellidoMatR,
		_rsocialR,
		_emailRep,
		_domicilioR,
		_telefonoR,
		_regsRep,
		_tipoUsuario,
		_fechaOcurrencia,
		_derecho,
		_causaEspecifica,
		_detalleReclamo,
	_autogenerado,
	_autoCorreo)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_amconsulta`
--

CREATE TABLE `sc_amconsulta` (
  `idAccionMC` int(11) NOT NULL,
  `fechaAMC` date DEFAULT NULL,
  `detalleAMC` text COLLATE utf8_bin,
  `idConsultaMC` int(11) DEFAULT NULL,
  `usuarioRC` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_amsugerencia`
--

CREATE TABLE `sc_amsugerencia` (
  `idAccionMS` int(255) NOT NULL,
  `fechaAMS` date DEFAULT NULL,
  `detalleAMS` text COLLATE utf8_bin,
  `idSugerenciaMS` int(11) DEFAULT NULL,
  `usuarioRS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_causaespecifica`
--

CREATE TABLE `sc_causaespecifica` (
  `idCausaEsp` int(11) NOT NULL,
  `descCausaEsp` text COLLATE utf8_bin,
  `codigoSusaludCE` text COLLATE utf8_bin,
  `derechoId` int(11) DEFAULT NULL,
  `estadoItemCE` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_causaespecifica`
--

INSERT INTO `sc_causaespecifica` (`idCausaEsp`, `descCausaEsp`, `codigoSusaludCE`, `derechoId`, `estadoItemCE`) VALUES
(1, 'Demora en emision de carta de garantía por la IAFAS cuando corresponda', '', 1, 2),
(2, 'De la solicitud de afiliación', '', 1, 2),
(3, 'Demora en el proceso de afiliación al SIS', '', 1, 2),
(4, 'Demora en la entrega de formatos', '', 1, 2),
(5, 'De solicitud de la carta de garantía cuando corresponda', NULL, 2, 2),
(6, 'Demora en la entrega de la hoja de referencia a un establecimiento de mayor complejidad u otra IPRESS', NULL, 2, 2),
(7, 'Demora en la entrega de otros formatos', NULL, 2, 2),
(8, 'Demora en la atención de emergencia', NULL, 3, 2),
(9, 'Demora en la atención de consultorio externo', NULL, 3, 2),
(10, 'Demora en la hospitalización', NULL, 3, 2),
(11, 'Demora en la realización de exámenes o intervenciones asistenciales', NULL, 3, 2),
(12, 'Demora en la intervencion quirúrgica', NULL, 3, 2),
(13, 'Demora en la referencia', NULL, 3, 2),
(14, 'Por plataforma de atención de IPRESS', NULL, 4, 2),
(15, 'Problemas relacionados al lenguaje', NULL, 4, 2),
(16, 'Por otras instancias de la IPRESS', NULL, 4, 2),
(17, 'Demora en la admisión del asegurado en la IPRESS o en los servicios de apoyo al diagnóstico', NULL, 5, 2),
(18, 'Demora en llegada de ambulancia o atención a domicilio', NULL, 5, 2),
(19, 'Demora de atención del asegurado en la central telefónica', NULL, 5, 2),
(20, 'Demora en la atención al asegurado en la plataforma de atención', NULL, 5, 2),
(21, 'Incumplimiento de citas en la IPRESS', NULL, 5, 2),
(22, 'La IPRESS no cumple con el horario establecido', NULL, 5, 2),
(23, 'Oportunidad de referencia a otro establecimiento de salud o servicio', NULL, 5, 2),
(24, 'Asignación o cambio de médico tratante en la IPRESS sin consentimiento expreso del asegurado', NULL, 5, 2),
(25, 'No disponibilidad de servicio de salud en lugar de residencia', NULL, 5, 2),
(26, 'Relacionados al contrato entre la IAFAS y la IPRESS', NULL, 5, 2),
(27, 'Otras relacionadas con el acceso a los servicios', NULL, 5, 2),
(28, 'La IPRESS al prestar servicios no incluidos en el plan de salud', NULL, 6, 2),
(29, 'Por cobros no autorizados por servicios ot orgados que superen los límites de la cobertura', NULL, 6, 2),
(30, 'Rechazo de atención en periodo de carencia', NULL, 6, 2),
(31, 'Otros relacionados con gastos no cubiertos', NULL, 6, 2),
(32, 'Cobros adicionales a las tarifas contractualmente pactadas', NULL, 7, 2),
(33, 'Cobros en emergencia', NULL, 7, 2),
(34, 'Otros relacionados con los cobros por la atención', NULL, 7, 2),
(35, 'En los casos que el reclamo, de orden administrativo, no corresponda a las causales señaladas', NULL, 8, 2),
(36, 'Relacionado con la evaluación durante la consulta médica ambulatoria o en emergencia', NULL, 9, 2),
(37, 'Sobre la información del personal responsable de la atención', NULL, 9, 2),
(38, 'Sobre información de la prestación de salud', NULL, 9, 2),
(39, 'Relacionado con el diagnóstico', NULL, 9, 2),
(40, 'Relacionado con la atención de consulta médica o emergencia a domicilio', NULL, 9, 2),
(41, 'Relacionado con el tratamiento médico ambulatorio , a domicilio o en emergencia', NULL, 9, 2),
(42, 'Relacionado con la referencia o traslado', NULL, 9, 2),
(43, 'Demora en la atención en el servicio de emergencia', NULL, 9, 2),
(44, 'Relacionado con el tratamiento quirúrgico', NULL, 9, 2),
(45, 'Relacionado con la hospitalización', NULL, 9, 2),
(46, 'Relacionado con el examen o procedimiento auxiliar', NULL, 9, 2),
(47, 'Relacionado con la información al paciente por el médico', NULL, 9, 2),
(48, 'Otros relacionados con la calidad de la atención', NULL, 9, 2),
(49, 'Indumentaria del personal asistencial', NULL, 10, 2),
(50, 'Ambientes', NULL, 10, 2),
(51, 'Equipos, instrumental biomédico e insumos', NULL, 10, 2),
(52, 'Otros relacionados con la salubridad', NULL, 10, 2),
(53, 'Infraestructura', NULL, 11, 2),
(54, 'Equipamiento', NULL, 11, 2),
(55, 'Otros', NULL, 11, 2),
(56, 'Cambio de medicamento', NULL, 12, 2),
(57, 'Relacionado con la receta', NULL, 12, 2),
(58, 'Demora en la entrega de medicamentos e insumos', NULL, 12, 2),
(59, 'No conformidad con el medicamento indicado', NULL, 12, 2),
(60, 'Falta de medicamento o insumos en la IPRESS', NULL, 12, 2),
(61, 'Error en la entrega de medicamento', NULL, 12, 2),
(62, 'Negativa en la entrega de medicamentos e insumos', NULL, 12, 2),
(63, 'Medicamento no cubierto o excluido', NULL, 12, 2),
(64, 'Otros relacionados con el suministro de medicamentos e insumos médicos', NULL, 12, 2),
(65, 'Discriminación al asegurado en los servicios de la IPRESS o la IAFAS', NULL, 13, 2),
(66, 'Descortesía en personal administrativo en la IPRESS', NULL, 13, 2),
(67, 'Trabas a la comunicación del asegurado con sus familiares', NULL, 13, 2),
(68, 'Descortesía en el personal médico', NULL, 13, 2),
(69, 'Descortesía en el personal asistencial no médico', NULL, 13, 2),
(70, 'Violación a la confidencialidad de datos del usuario', NULL, 14, 2),
(71, 'Falta de confidencilaidad de la información sobre el asegurado ', NULL, 14, 2),
(72, 'Presencia de personal no autorizado en evaluación clínica', NULL, 14, 2),
(73, 'Atención de salud brindada en condiciones de exposición', NULL, 14, 2),
(74, 'Registro no consentido de imágenes personales', NULL, 14, 2),
(75, 'Falta de consentimiento informado', NULL, 14, 2),
(76, 'En los casos que el reclamo de carácter prestacional no corresponda a las causales señaladas', NULL, 15, 2),
(77, 'Emitir recetas farmacológicas sin la denominación genérica internacional, datos erróneos o incompleta', '1101', 16, 1),
(78, 'Dispensar medicamentos y/o dispositivos médicos de manera insatisfecha', '1102', 16, 1),
(79, 'No cumplir o no acceder a hacer el procedimiento de referencia o contrareferencia', '1103', 16, 1),
(80, 'Direccionar al usuario a comprar medicamentos o dispositivos médicos fuera del establecimiento de salud', '1104', 16, 1),
(81, 'Negar o condicionar al usuario a realizarse procedimientos de apoyo al diagnóstico', '1105', 16, 1),
(82, 'Demorar en el otorgamiento de citas o en la atención para la consulta externa', '1106', 16, 1),
(83, 'Demora para la Hospitalización', '1107', 16, 1),
(84, 'Demora en el otorgamiento de prestaciones de salud durante la Hospitalización', '1108', 16, 1),
(85, 'Demorar en la atención de emergencia de acuerdo a la prioridad', '1109', 16, 1),
(86, 'Demorar en la atención de paciente obstétrica', '1110', 16, 1),
(87, 'Demorar en el otorgamiento o reprogramación de cupo para el procedimiento quirúrgico', '1111', 16, 1),
(88, 'Negar la atención en situaciones de emergencia', '1112', 16, 1),
(89, 'Encontrar IPRESS y/o unidades prestadoras de salud cerradas en horario de atención o no presencia del personal responsable de la atención', '1113', 16, 1),
(90, 'No acceso a la historia clínica', '1114', 16, 1),
(91, 'Reclamos relacionados a la infraestructura de la institución', '1115', 16, 1),
(92, 'No cumplir o no acceder a hacer el procedimiento de referencia o contrareferencia', '1116', 16, 1),
(93, 'Demorar en la toma o entrega de examenes de apoyo diagnóstico', '1117', 16, 1),
(94, 'Cobrar indebidamente', '1118', 16, 1),
(95, 'No cuentan con ventanilla preferencial', '1119', 16, 1),
(96, 'Incumplimiento en la programación de citas', '1120', 16, 1),
(97, 'Incumplimiento en la programación de intervenciones quirúrgicas', '1121', 16, 1),
(98, 'No brindar información de los procesos administrativos de la IPRESS', '1201', 17, 1),
(99, 'No recibir de su médico y/o personal de salud tratante información comprensible sobre su estado de salud o tratamiento', '1203', 17, 1),
(100, 'No recibir de su médico y/o personal de salud trato amable', '1302', 18, 1),
(101, 'No recibir del personal administrativo trato amable y respuetuoso', '1303', 18, 1),
(102, 'No brindar el procedimiento médico ó quirúrgico adecuado', '1304', 18, 1),
(103, 'No brindar un trato acorde a la cultura, condición y género del usuario', '1305', 18, 1),
(104, 'Presunto error en los resultados de exámenes de apoyo al diagnóstico', '1306', 18, 1),
(105, 'No brindar atención con pleno respeto a la dignidad del usuario', '1307', 18, 1),
(106, 'Retener al usuario de alta ó al cadáver por motivo de deuda, previo acuerdo de pagos o trámites administrativos', '1309', 18, 1),
(107, 'No brindar atención con respeto a la dignidad del usuario', '1310', 18, 1),
(108, 'No solicitar al usuario o su representante legal el consentimiento informado por escrito de acuerdo a los requerimientos de la normatividad vigente', '1401', 19, 1),
(109, 'Negar o demorar en brindar al usuario el acceso a su historia clínica y a otros registros clínicos solicitados y no garantizar sus carácter reservado', '1501', 20, 1),
(110, 'No realizar la gestión del reclamo de forma oportuna y adecuada', '1502', 20, 1),
(111, 'No contar con Plataforma de Atención al Usuario en Salud de acuerdo a la normatividad vigente', '1504', 20, 1),
(112, 'Otros relativos a la atención de salud en las IPRESS', '2001', 21, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_consulta`
--

CREATE TABLE `sc_consulta` (
  `idConsulta` int(11) NOT NULL,
  `correlativoCon` text COLLATE utf8_bin,
  `fechaCon` date DEFAULT NULL,
  `horaCon` time DEFAULT NULL,
  `tDoc` int(11) DEFAULT NULL,
  `nDoc` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `nombresAp` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `edad` int(11) DEFAULT '0',
  `sexoCon` int(11) DEFAULT NULL,
  `telefono` text COLLATE utf8_bin,
  `distrito` int(11) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `detalleConsulta` text COLLATE utf8_bin,
  `autogenerado` text COLLATE utf8_bin,
  `estadoDoc` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_consulta`
--

INSERT INTO `sc_consulta` (`idConsulta`, `correlativoCon`, `fechaCon`, `horaCon`, `tDoc`, `nDoc`, `nombresAp`, `edad`, `sexoCon`, `telefono`, `distrito`, `email`, `detalleConsulta`, `autogenerado`, `estadoDoc`) VALUES
(1, 'LC-2021-000001', '2021-11-30', '11:07:53', 1, '77478995', 'OLGER IVAN CASTRO PALACIOS', 25, 1, '914907409', 1260, 'ocastrop.ti@gmail.com', 'prueba de consulta', NULL, 1);

--
-- Disparadores `sc_consulta`
--
DELIMITER $$
CREATE TRIGGER `GENERAR_CORRELATIVO_CONSULTA` BEFORE INSERT ON `sc_consulta` FOR EACH ROW BEGIN
    DECLARE cont1 int default 0;
    DECLARE anio text;
    set anio = (SELECT YEAR(CURDATE()));
    SET cont1= (SELECT count(*) FROM sc_consulta WHERE year(fechaCon) = year(now()));
    IF (cont1 < 1) THEN
    SET NEW.correlativoCon = CONCAT('LC-',anio,'-', LPAD(cont1 + 1, 5, '0'));
    ELSE
    SET NEW.correlativoCon = CONCAT('LC-',anio,'-', LPAD(cont1 + 1, 5, '0'));
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_departamento`
--

CREATE TABLE `sc_departamento` (
  `idDepartamento` int(11) NOT NULL,
  `descDepartamento` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_departamento`
--

INSERT INTO `sc_departamento` (`idDepartamento`, `descDepartamento`) VALUES
(1, 'AMAZONAS'),
(2, 'ANCASH'),
(3, 'APURIMAC'),
(4, 'AREQUIPA'),
(5, 'AYACUCHO'),
(6, 'CAJAMARCA'),
(7, 'CALLAO'),
(8, 'CUSCO'),
(9, 'HUANCAVELICA'),
(10, 'HUANUCO'),
(11, 'ICA'),
(12, 'JUNIN'),
(13, 'LA LIBERTAD'),
(14, 'LAMBAYEQUE'),
(15, 'LIMA'),
(16, 'LORETO'),
(17, 'MADRE DE DIOS'),
(18, 'MOQUEGUA'),
(19, 'PASCO'),
(20, 'PIURA'),
(21, 'PUNO'),
(22, 'SAN MARTIN'),
(23, 'TACNA'),
(24, 'TUMBES'),
(25, 'UCAYALI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_derecho`
--

CREATE TABLE `sc_derecho` (
  `idDerecho` int(11) NOT NULL,
  `descDerechoSal` text COLLATE utf8_bin,
  `estadoItemDer` int(11) DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_derecho`
--

INSERT INTO `sc_derecho` (`idDerecho`, `descDerechoSal`, `estadoItemDer`) VALUES
(1, 'Demora en la entrega de formatos por la IAFAS', 2),
(2, 'Demora en la entrega de formatos en la IPRESS', 2),
(3, 'Demora en la prestacion de servicio de salud', 2),
(4, 'Deficiencia en la información brindada en la IPRESS', 2),
(5, 'Dificultad de acceso a los servicios de atención al asegurado', 2),
(6, 'Disconformidad por el cobro de gastos no cubiertos', 2),
(7, 'Disconformidad con los cobros por la atención', 2),
(8, 'Otros relativos a la oportunidad', 2),
(9, 'Calidad de atención de salud', 2),
(10, 'Deficiencia en el orden, limpieza y bioseguridad de la IPRESS', 2),
(11, 'Relativos a la infraestructura y el equipamiento', 2),
(12, 'No conformidad con la prescripción, el suministro de medicamentos o insumos en la IPRESS', 2),
(13, 'Disconformidad con el trato recibido', 2),
(14, 'Confidencialidad y Consentimiento informado', 2),
(15, 'Otros relativos a la prestación', 2),
(16, 'Acceso a los Servicios de Salud', 1),
(17, 'Acceso a la Información', 1),
(18, 'Atención y Recuperación de la Salud', 1),
(19, 'Consentimiento Informado', 1),
(20, 'Protección de Derechos', 1),
(21, 'Otros', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_distrito`
--

CREATE TABLE `sc_distrito` (
  `idDistrito` int(11) NOT NULL,
  `descDistrito` text COLLATE utf8_bin,
  `provId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_distrito`
--

INSERT INTO `sc_distrito` (`idDistrito`, `descDistrito`, `provId`) VALUES
(1, 'CHACHAPOYAS', 1),
(2, 'ASUNCION', 1),
(3, 'BALSAS', 1),
(4, 'CHETO', 1),
(5, 'CHILIQUIN', 1),
(6, 'CHUQUIBAMBA', 1),
(7, 'GRANADA', 1),
(8, 'HUANCAS', 1),
(9, 'LA JALCA', 1),
(10, 'LEIMEBAMBA', 1),
(11, 'LEVANTO', 1),
(12, 'MAGDALENA', 1),
(13, 'MARISCAL CASTILLA', 1),
(14, 'MOLINOPAMPA', 1),
(15, 'MONTEVIDEO', 1),
(16, 'OLLEROS', 1),
(17, 'QUINJALCA', 1),
(18, 'SAN FRANCISCO DE DAGUAS', 1),
(19, 'SAN ISIDRO DE MAINO', 1),
(20, 'SOLOCO', 1),
(21, 'SONCHE', 1),
(22, 'LA PECA', 2),
(23, 'ARAMANGO', 2),
(24, 'COPALLIN', 2),
(25, 'EL PARCO', 2),
(26, 'IMAZA', 2),
(27, 'JUMBILLA', 3),
(28, 'CHISQUILLA', 3),
(29, 'CHURUJA', 3),
(30, 'COROSHA', 3),
(31, 'CUISPES', 3),
(32, 'FLORIDA', 3),
(33, 'JAZAN', 3),
(34, 'RECTA', 3),
(35, 'SAN CARLOS', 3),
(36, 'SHIPASBAMBA', 3),
(37, 'VALERA', 3),
(38, 'YAMBRASBAMBA', 3),
(39, 'NIEVA', 4),
(40, 'EL CENEPA', 4),
(41, 'RIO SANTIAGO', 4),
(42, 'LAMUD', 5),
(43, 'CAMPORREDONDO', 5),
(44, 'COCABAMBA', 5),
(45, 'COLCAMAR', 5),
(46, 'CONILA', 5),
(47, 'INGUILPATA', 5),
(48, 'LONGUITA', 5),
(49, 'LONYA CHICO', 5),
(50, 'LUYA', 5),
(51, 'LUYA VIEJO', 5),
(52, 'MARIA', 5),
(53, 'OCALLI', 5),
(54, 'OCUMAL', 5),
(55, 'PISUQUIA', 5),
(56, 'PROVIDENCIA', 5),
(57, 'SAN CRISTOBAL', 5),
(58, 'SAN FRANCISCO DEL YESO', 5),
(59, 'SAN JERONIMO', 5),
(60, 'SAN JUAN DE LOPECANCHA', 5),
(61, 'SANTA CATALINA', 5),
(62, 'SANTO TOMAS', 5),
(63, 'TINGO', 5),
(64, 'TRITA', 5),
(65, 'SAN NICOLAS', 6),
(66, 'CHIRIMOTO', 6),
(67, 'COCHAMAL', 6),
(68, 'HUAMBO', 6),
(69, 'LIMABAMBA', 6),
(70, 'LONGAR', 6),
(71, 'MARISCAL BENAVIDES', 6),
(72, 'MILPUC', 6),
(73, 'OMIA', 6),
(74, 'SANTA ROSA', 6),
(75, 'TOTORA', 6),
(76, 'VISTA ALEGRE', 6),
(77, 'BAGUA GRANDE', 7),
(78, 'CAJARURO', 7),
(79, 'CUMBA', 7),
(80, 'EL MILAGRO', 7),
(81, 'JAMALCA', 7),
(82, 'LONYA GRANDE', 7),
(83, 'YAMON', 7),
(84, 'HUARAZ', 8),
(85, 'COCHABAMBA', 8),
(86, 'COLCABAMBA', 8),
(87, 'HUANCHAY', 8),
(88, 'INDEPENDENCIA', 8),
(89, 'JANGAS', 8),
(90, 'LA LIBERTAD', 8),
(91, 'OLLEROS', 8),
(92, 'PAMPAS', 8),
(93, 'PARIACOTO', 8),
(94, 'PIRA', 8),
(95, 'TARICA', 8),
(96, 'AIJA', 9),
(97, 'CORIS', 9),
(98, 'HUACLLAN', 9),
(99, 'LA MERCED', 9),
(100, 'SUCCHA', 9),
(101, 'LLAMELLIN', 10),
(102, 'ACZO', 10),
(103, 'CHACCHO', 10),
(104, 'CHINGAS', 10),
(105, 'MIRGAS', 10),
(106, 'SAN JUAN DE RONTOY', 10),
(107, 'CHACAS', 11),
(108, 'ACOCHACA', 11),
(109, 'CHIQUIAN', 12),
(110, 'ABELARDO PARDO LEZAMETA', 12),
(111, 'ANTONIO RAYMONDI', 12),
(112, 'AQUIA', 12),
(113, 'CAJACAY', 12),
(114, 'CANIS', 12),
(115, 'COLQUIOC', 12),
(116, 'HUALLANCA', 12),
(117, 'HUASTA', 12),
(118, 'HUAYLLACAYAN', 12),
(119, 'LA PRIMAVERA', 12),
(120, 'MANGAS', 12),
(121, 'PACLLON', 12),
(122, 'SAN MIGUEL DE CORPANQUI', 12),
(123, 'TICLLOS', 12),
(124, 'CARHUAZ', 13),
(125, 'ACOPAMPA', 13),
(126, 'AMASHCA', 13),
(127, 'ANTA', 13),
(128, 'ATAQUERO', 13),
(129, 'MARCARA', 13),
(130, 'PARIAHUANCA', 13),
(131, 'SAN MIGUEL DE ACO', 13),
(132, 'SHILLA', 13),
(133, 'TINCO', 13),
(134, 'YUNGAR', 13),
(135, 'SAN LUIS', 14),
(136, 'SAN NICOLAS', 14),
(137, 'YAUYA', 14),
(138, 'CASMA', 15),
(139, 'BUENA VISTA ALTA', 15),
(140, 'COMANDANTE NOEL', 15),
(141, 'YAUTAN', 15),
(142, 'CORONGO', 16),
(143, 'ACO', 16),
(144, 'BAMBAS', 16),
(145, 'CUSCA', 16),
(146, 'LA PAMPA', 16),
(147, 'YANAC', 16),
(148, 'YUPAN', 16),
(149, 'HUARI', 17),
(150, 'ANRA', 17),
(151, 'CAJAY', 17),
(152, 'CHAVIN DE HUANTAR', 17),
(153, 'HUACACHI', 17),
(154, 'HUACCHIS', 17),
(155, 'HUACHIS', 17),
(156, 'HUANTAR', 17),
(157, 'MASIN', 17),
(158, 'PAUCAS', 17),
(159, 'PONTO', 17),
(160, 'RAHUAPAMPA', 17),
(161, 'RAPAYAN', 17),
(162, 'SAN MARCOS', 17),
(163, 'SAN PEDRO DE CHANA', 17),
(164, 'UCO', 17),
(165, 'HUARMEY', 18),
(166, 'COCHAPETI', 18),
(167, 'CULEBRAS', 18),
(168, 'HUAYAN', 18),
(169, 'MALVAS', 18),
(170, 'CARAZ', 26),
(171, 'HUALLANCA', 26),
(172, 'HUATA', 26),
(173, 'HUAYLAS', 26),
(174, 'MATO', 26),
(175, 'PAMPAROMAS', 26),
(176, 'PUEBLO LIBRE', 26),
(177, 'SANTA CRUZ', 26),
(178, 'SANTO TORIBIO', 26),
(179, 'YURACMARCA', 26),
(180, 'PISCOBAMBA', 27),
(181, 'CASCA', 27),
(182, 'ELEAZAR GUZMAN BARRON', 27),
(183, 'FIDEL OLIVAS ESCUDERO', 27),
(184, 'LLAMA', 27),
(185, 'LLUMPA', 27),
(186, 'LUCMA', 27),
(187, 'MUSGA', 27),
(188, 'OCROS', 21),
(189, 'ACAS', 21),
(190, 'CAJAMARQUILLA', 21),
(191, 'CARHUAPAMPA', 21),
(192, 'COCHAS', 21),
(193, 'CONGAS', 21),
(194, 'LLIPA', 21),
(195, 'SAN CRISTOBAL DE RAJAN', 21),
(196, 'SAN PEDRO', 21),
(197, 'SANTIAGO DE CHILCAS', 21),
(198, 'CABANA', 22),
(199, 'BOLOGNESI', 22),
(200, 'CONCHUCOS', 22),
(201, 'HUACASCHUQUE', 22),
(202, 'HUANDOVAL', 22),
(203, 'LACABAMBA', 22),
(204, 'LLAPO', 22),
(205, 'PALLASCA', 22),
(206, 'PAMPAS', 22),
(207, 'SANTA ROSA', 22),
(208, 'TAUCA', 22),
(209, 'POMABAMBA', 23),
(210, 'HUAYLLAN', 23),
(211, 'PAROBAMBA', 23),
(212, 'QUINUABAMBA', 23),
(213, 'RECUAY', 24),
(214, 'CATAC', 24),
(215, 'COTAPARACO', 24),
(216, 'HUAYLLAPAMPA', 24),
(217, 'LLACLLIN', 24),
(218, 'MARCA', 24),
(219, 'PAMPAS CHICO', 24),
(220, 'PARARIN', 24),
(221, 'TAPACOCHA', 24),
(222, 'TICAPAMPA', 24),
(223, 'CHIMBOTE', 25),
(224, 'CACERES DEL PERU', 25),
(225, 'COISHCO', 25),
(226, 'MACATE', 25),
(227, 'MORO', 25),
(228, 'NEPE&Ntilde;A', 25),
(229, 'SAMANCO', 25),
(230, 'SANTA', 25),
(231, 'NUEVO CHIMBOTE', 25),
(232, 'SIHUAS', 26),
(233, 'ACOBAMBA', 26),
(234, 'ALFONSO UGARTE', 26),
(235, 'CASHAPAMPA', 26),
(236, 'CHINGALPO', 26),
(237, 'HUAYLLABAMBA', 26),
(238, 'QUICHES', 26),
(239, 'RAGASH', 26),
(240, 'SAN JUAN', 26),
(241, 'SICSIBAMBA', 26),
(242, 'YUNGAY', 27),
(243, 'CASCAPARA', 27),
(244, 'MANCOS', 27),
(245, 'MATACOTO', 27),
(246, 'QUILLO', 27),
(247, 'RANRAHIRCA', 27),
(248, 'SHUPLUY', 27),
(249, 'YANAMA', 27),
(250, 'ABANCAY', 28),
(251, 'CHACOCHE', 28),
(252, 'CIRCA', 28),
(253, 'CURAHUASI', 28),
(254, 'HUANIPACA', 28),
(255, 'LAMBRAMA', 28),
(256, 'PICHIRHUA', 28),
(257, 'SAN PEDRO DE CACHORA', 28),
(258, 'TAMBURCO', 28),
(259, 'ANDAHUAYLAS', 29),
(260, 'ANDARAPA', 29),
(261, 'CHIARA', 29),
(262, 'HUANCARAMA', 29),
(263, 'HUANCARAY', 29),
(264, 'HUAYANA', 29),
(265, 'KISHUARA', 29),
(266, 'PACOBAMBA', 29),
(267, 'PACUCHA', 29),
(268, 'PAMPACHIRI', 29),
(269, 'POMACOCHA', 29),
(270, 'SAN ANTONIO DE CACHI', 29),
(271, 'SAN JERONIMO', 29),
(272, 'SAN MIGUEL DE CHACCRAMPA', 29),
(273, 'SANTA MARIA DE CHICMO', 29),
(274, 'TALAVERA', 29),
(275, 'TUMAY HUARACA', 29),
(276, 'TURPO', 29),
(277, 'KAQUIABAMBA', 29),
(278, 'ANTABAMBA', 30),
(279, 'EL ORO', 30),
(280, 'HUAQUIRCA', 30),
(281, 'JUAN ESPINOZA MEDRANO', 30),
(282, 'OROPESA', 30),
(283, 'PACHACONAS', 30),
(284, 'SABAINO', 30),
(285, 'CHALHUANCA', 31),
(286, 'CAPAYA', 31),
(287, 'CARAYBAMBA', 31),
(288, 'CHAPIMARCA', 31),
(289, 'COLCABAMBA', 31),
(290, 'COTARUSE', 31),
(291, 'HUAYLLO', 31),
(292, 'JUSTO APU SAHUARAURA', 31),
(293, 'LUCRE', 31),
(294, 'POCOHUANCA', 31),
(295, 'SAN JUAN DE CHAC&Ntilde;A', 31),
(296, 'SA&Ntilde;AYCA', 31),
(297, 'SORAYA', 31),
(298, 'TAPAIRIHUA', 31),
(299, 'TINTAY', 31),
(300, 'TORAYA', 31),
(301, 'YANACA', 31),
(302, 'TAMBOBAMBA', 32),
(303, 'COTABAMBAS', 32),
(304, 'COYLLURQUI', 32),
(305, 'HAQUIRA', 32),
(306, 'MARA', 32),
(307, 'CHALLHUAHUACHO', 32),
(308, 'CHINCHEROS', 33),
(309, 'ANCO-HUALLO', 33),
(310, 'COCHARCAS', 33),
(311, 'HUACCANA', 33),
(312, 'OCOBAMBA', 33),
(313, 'ONGOY', 33),
(314, 'URANMARCA', 33),
(315, 'RANRACANCHA', 33),
(316, 'CHUQUIBAMBILLA', 34),
(317, 'CURPAHUASI', 34),
(318, 'GAMARRA', 34),
(319, 'HUAYLLATI', 34),
(320, 'MAMARA', 34),
(321, 'MICAELA BASTIDAS', 34),
(322, 'PATAYPAMPA', 34),
(323, 'PROGRESO', 34),
(324, 'SAN ANTONIO', 34),
(325, 'SANTA ROSA', 34),
(326, 'TURPAY', 34),
(327, 'VILCABAMBA', 34),
(328, 'VIRUNDO', 34),
(329, 'CURASCO', 34),
(330, 'AREQUIPA', 35),
(331, 'ALTO SELVA ALEGRE', 35),
(332, 'CAYMA', 35),
(333, 'CERRO COLORADO', 35),
(334, 'CHARACATO', 35),
(335, 'CHIGUATA', 35),
(336, 'JACOBO HUNTER', 35),
(337, 'LA JOYA', 35),
(338, 'MARIANO MELGAR', 35),
(339, 'MIRAFLORES', 35),
(340, 'MOLLEBAYA', 35),
(341, 'PAUCARPATA', 35),
(342, 'POCSI', 35),
(343, 'POLOBAYA', 35),
(344, 'QUEQUE&Ntilde;A', 35),
(345, 'SABANDIA', 35),
(346, 'SACHACA', 35),
(347, 'SAN JUAN DE SIGUAS', 35),
(348, 'SAN JUAN DE TARUCANI', 35),
(349, 'SANTA ISABEL DE SIGUAS', 35),
(350, 'SANTA RITA DE SIGUAS', 35),
(351, 'SOCABAYA', 35),
(352, 'TIABAYA', 35),
(353, 'UCHUMAYO', 35),
(354, 'VITOR', 35),
(355, 'YANAHUARA', 35),
(356, 'YARABAMBA', 35),
(357, 'YURA', 35),
(358, 'JOSE LUIS BUSTAMANTE Y RIVERO', 35),
(359, 'CAMANA', 36),
(360, 'JOSE MARIA QUIMPER', 36),
(361, 'MARIANO NICOLAS VALCARCEL', 36),
(362, 'MARISCAL CACERES', 36),
(363, 'NICOLAS DE PIEROLA', 36),
(364, 'OCO&Ntilde;A', 36),
(365, 'QUILCA', 36),
(366, 'SAMUEL PASTOR', 36),
(367, 'CARAVELI', 37),
(368, 'ACARI', 37),
(369, 'ATICO', 37),
(370, 'ATIQUIPA', 37),
(371, 'BELLA UNION', 37),
(372, 'CAHUACHO', 37),
(373, 'CHALA', 37),
(374, 'CHAPARRA', 37),
(375, 'HUANUHUANU', 37),
(376, 'JAQUI', 37),
(377, 'LOMAS', 37),
(378, 'QUICACHA', 37),
(379, 'YAUCA', 37),
(380, 'APLAO', 38),
(381, 'ANDAGUA', 38),
(382, 'AYO', 38),
(383, 'CHACHAS', 38),
(384, 'CHILCAYMARCA', 38),
(385, 'CHOCO', 38),
(386, 'HUANCARQUI', 38),
(387, 'MACHAGUAY', 38),
(388, 'ORCOPAMPA', 38),
(389, 'PAMPACOLCA', 38),
(390, 'TIPAN', 38),
(391, 'U&Ntilde;ON', 38),
(392, 'URACA', 38),
(393, 'VIRACO', 38),
(394, 'CHIVAY', 39),
(395, 'ACHOMA', 39),
(396, 'CABANACONDE', 39),
(397, 'CALLALLI', 39),
(398, 'CAYLLOMA', 39),
(399, 'COPORAQUE', 39),
(400, 'HUAMBO', 39),
(401, 'HUANCA', 39),
(402, 'ICHUPAMPA', 39),
(403, 'LARI', 39),
(404, 'LLUTA', 39),
(405, 'MACA', 39),
(406, 'MADRIGAL', 39),
(407, 'SAN ANTONIO DE CHUCA', 39),
(408, 'SIBAYO', 39),
(409, 'TAPAY', 39),
(410, 'TISCO', 39),
(411, 'TUTI', 39),
(412, 'YANQUE', 39),
(413, 'MAJES', 39),
(414, 'CHUQUIBAMBA', 40),
(415, 'ANDARAY', 40),
(416, 'CAYARANI', 40),
(417, 'CHICHAS', 40),
(418, 'IRAY', 40),
(419, 'RIO GRANDE', 40),
(420, 'SALAMANCA', 40),
(421, 'YANAQUIHUA', 40),
(422, 'MOLLENDO', 41),
(423, 'COCACHACRA', 41),
(424, 'DEAN VALDIVIA', 41),
(425, 'ISLAY', 41),
(426, 'MEJIA', 41),
(427, 'PUNTA DE BOMBON', 41),
(428, 'COTAHUASI', 42),
(429, 'ALCA', 42),
(430, 'CHARCANA', 42),
(431, 'HUAYNACOTAS', 42),
(432, 'PAMPAMARCA', 42),
(433, 'PUYCA', 42),
(434, 'QUECHUALLA', 42),
(435, 'SAYLA', 42),
(436, 'TAURIA', 42),
(437, 'TOMEPAMPA', 42),
(438, 'TORO', 42),
(439, 'AYACUCHO', 43),
(440, 'ACOCRO', 43),
(441, 'ACOS VINCHOS', 43),
(442, 'CARMEN ALTO', 43),
(443, 'CHIARA', 43),
(444, 'OCROS', 43),
(445, 'PACAYCASA', 43),
(446, 'QUINUA', 43),
(447, 'SAN JOSE DE TICLLAS', 43),
(448, 'SAN JUAN BAUTISTA', 43),
(449, 'SANTIAGO DE PISCHA', 43),
(450, 'SOCOS', 43),
(451, 'TAMBILLO', 43),
(452, 'VINCHOS', 43),
(453, 'JESUS NAZARENO', 43),
(454, 'CANGALLO', 44),
(455, 'CHUSCHI', 44),
(456, 'LOS MOROCHUCOS', 44),
(457, 'MARIA PARADO DE BELLIDO', 44),
(458, 'PARAS', 44),
(459, 'TOTOS', 44),
(460, 'SANCOS', 45),
(461, 'CARAPO', 45),
(462, 'SACSAMARCA', 45),
(463, 'SANTIAGO DE LUCANAMARCA', 45),
(464, 'HUANTA', 46),
(465, 'AYAHUANCO', 46),
(466, 'HUAMANGUILLA', 46),
(467, 'IGUAIN', 46),
(468, 'LURICOCHA', 46),
(469, 'SANTILLANA', 46),
(470, 'SIVIA', 46),
(471, 'LLOCHEGUA', 46),
(472, 'SAN MIGUEL', 47),
(473, 'ANCO', 47),
(474, 'AYNA', 47),
(475, 'CHILCAS', 47),
(476, 'CHUNGUI', 47),
(477, 'LUIS CARRANZA', 47),
(478, 'SANTA ROSA', 47),
(479, 'TAMBO', 47),
(480, 'PUQUIO', 48),
(481, 'AUCARA', 48),
(482, 'CABANA', 48),
(483, 'CARMEN SALCEDO', 48),
(484, 'CHAVI&Ntilde;A', 48),
(485, 'CHIPAO', 48),
(486, 'HUAC-HUAS', 48),
(487, 'LARAMATE', 48),
(488, 'LEONCIO PRADO', 48),
(489, 'LLAUTA', 48),
(490, 'LUCANAS', 48),
(491, 'OCA&Ntilde;A', 48),
(492, 'OTOCA', 48),
(493, 'SAISA', 48),
(494, 'SAN CRISTOBAL', 48),
(495, 'SAN JUAN', 48),
(496, 'SAN PEDRO', 48),
(497, 'SAN PEDRO DE PALCO', 48),
(498, 'SANCOS', 48),
(499, 'SANTA ANA DE HUAYCAHUACHO', 48),
(500, 'SANTA LUCIA', 48),
(501, 'CORACORA', 49),
(502, 'CHUMPI', 49),
(503, 'CORONEL CASTA&Ntilde;EDA', 49),
(504, 'PACAPAUSA', 49),
(505, 'PULLO', 49),
(506, 'PUYUSCA', 49),
(507, 'SAN FRANCISCO DE RAVACAYCO', 49),
(508, 'UPAHUACHO', 49),
(509, 'PAUSA', 50),
(510, 'COLTA', 50),
(511, 'CORCULLA', 50),
(512, 'LAMPA', 50),
(513, 'MARCABAMBA', 50),
(514, 'OYOLO', 50),
(515, 'PARARCA', 50),
(516, 'SAN JAVIER DE ALPABAMBA', 50),
(517, 'SAN JOSE DE USHUA', 50),
(518, 'SARA SARA', 50),
(519, 'QUEROBAMBA', 51),
(520, 'BELEN', 51),
(521, 'CHALCOS', 51),
(522, 'CHILCAYOC', 51),
(523, 'HUACA&Ntilde;A', 51),
(524, 'MORCOLLA', 51),
(525, 'PAICO', 51),
(526, 'SAN PEDRO DE LARCAY', 51),
(527, 'SAN SALVADOR DE QUIJE', 51),
(528, 'SANTIAGO DE PAUCARAY', 51),
(529, 'SORAS', 51),
(530, 'HUANCAPI', 52),
(531, 'ALCAMENCA', 52),
(532, 'APONGO', 52),
(533, 'ASQUIPATA', 52),
(534, 'CANARIA', 52),
(535, 'CAYARA', 52),
(536, 'COLCA', 52),
(537, 'HUAMANQUIQUIA', 52),
(538, 'HUANCARAYLLA', 52),
(539, 'HUAYA', 52),
(540, 'SARHUA', 52),
(541, 'VILCANCHOS', 52),
(542, 'VILCAS HUAMAN', 53),
(543, 'ACCOMARCA', 53),
(544, 'CARHUANCA', 53),
(545, 'CONCEPCION', 53),
(546, 'HUAMBALPA', 53),
(547, 'INDEPENDENCIA', 53),
(548, 'SAURAMA', 53),
(549, 'VISCHONGO', 53),
(550, 'CAJAMARCA', 54),
(551, 'CAJAMARCA', 54),
(552, 'ASUNCION', 54),
(553, 'CHETILLA', 54),
(554, 'COSPAN', 54),
(555, 'ENCA&Ntilde;ADA', 54),
(556, 'JESUS', 54),
(557, 'LLACANORA', 54),
(558, 'LOS BA&Ntilde;OS DEL INCA', 54),
(559, 'MAGDALENA', 54),
(560, 'MATARA', 54),
(561, 'NAMORA', 54),
(562, 'SAN JUAN', 54),
(563, 'CAJABAMBA', 55),
(564, 'CACHACHI', 55),
(565, 'CONDEBAMBA', 55),
(566, 'SITACOCHA', 55),
(567, 'CELENDIN', 56),
(568, 'CHUMUCH', 56),
(569, 'CORTEGANA', 56),
(570, 'HUASMIN', 56),
(571, 'JORGE CHAVEZ', 56),
(572, 'JOSE GALVEZ', 56),
(573, 'MIGUEL IGLESIAS', 56),
(574, 'OXAMARCA', 56),
(575, 'SOROCHUCO', 56),
(576, 'SUCRE', 56),
(577, 'UTCO', 56),
(578, 'LA LIBERTAD DE PALLAN', 56),
(579, 'CHOTA', 57),
(580, 'ANGUIA', 57),
(581, 'CHADIN', 57),
(582, 'CHIGUIRIP', 57),
(583, 'CHIMBAN', 57),
(584, 'CHOROPAMPA', 57),
(585, 'COCHABAMBA', 57),
(586, 'CONCHAN', 57),
(587, 'HUAMBOS', 57),
(588, 'LAJAS', 57),
(589, 'LLAMA', 57),
(590, 'MIRACOSTA', 57),
(591, 'PACCHA', 57),
(592, 'PION', 57),
(593, 'QUEROCOTO', 57),
(594, 'SAN JUAN DE LICUPIS', 57),
(595, 'TACABAMBA', 57),
(596, 'TOCMOCHE', 57),
(597, 'CHALAMARCA', 57),
(598, 'CONTUMAZA', 58),
(599, 'CHILETE', 58),
(600, 'CUPISNIQUE', 58),
(601, 'GUZMANGO', 58),
(602, 'SAN BENITO', 58),
(603, 'SANTA CRUZ DE TOLED', 58),
(604, 'TANTARICA', 58),
(605, 'YONAN', 58),
(606, 'CUTERVO', 59),
(607, 'CALLAYUC', 59),
(608, 'CHOROS', 59),
(609, 'CUJILLO', 59),
(610, 'LA RAMADA', 59),
(611, 'PIMPINGOS', 59),
(612, 'QUEROCOTILLO', 59),
(613, 'SAN ANDRES DE CUTERVO', 59),
(614, 'SAN JUAN DE CUTERVO', 59),
(615, 'SAN LUIS DE LUCMA', 59),
(616, 'SANTA CRUZ', 59),
(617, 'SANTO DOMINGO DE LA CAPILLA', 59),
(618, 'SANTO TOMAS', 59),
(619, 'SOCOTA', 59),
(620, 'TORIBIO CASANOVA', 59),
(621, 'BAMBAMARCA', 60),
(622, 'CHUGUR', 60),
(623, 'HUALGAYOC', 60),
(624, 'JAEN', 61),
(625, 'BELLAVISTA', 61),
(626, 'CHONTALI', 61),
(627, 'COLASAY', 61),
(628, 'HUABAL', 61),
(629, 'LAS PIRIAS', 61),
(630, 'POMAHUACA', 61),
(631, 'PUCARA', 61),
(632, 'SALLIQUE', 61),
(633, 'SAN FELIPE', 61),
(634, 'SAN JOSE DEL ALTO', 61),
(635, 'SANTA ROSA', 61),
(636, 'SAN IGNACIO', 62),
(637, 'CHIRINOS', 62),
(638, 'HUARANGO', 62),
(639, 'LA COIPA', 62),
(640, 'NAMBALLE', 62),
(641, 'SAN JOSE DE LOURDES', 62),
(642, 'TABACONAS', 62),
(643, 'PEDRO GALVEZ', 63),
(644, 'CHANCAY', 63),
(645, 'EDUARDO VILLANUEVA', 63),
(646, 'GREGORIO PITA', 63),
(647, 'ICHOCAN', 63),
(648, 'JOSE MANUEL QUIROZ', 63),
(649, 'JOSE SABOGAL', 63),
(650, 'SAN MIGUEL', 64),
(651, 'SAN MIGUEL', 64),
(652, 'BOLIVAR', 64),
(653, 'CALQUIS', 64),
(654, 'CATILLUC', 64),
(655, 'EL PRADO', 64),
(656, 'LA FLORIDA', 64),
(657, 'LLAPA', 64),
(658, 'NANCHOC', 64),
(659, 'NIEPOS', 64),
(660, 'SAN GREGORIO', 64),
(661, 'SAN SILVESTRE DE COCHAN', 64),
(662, 'TONGOD', 64),
(663, 'UNION AGUA BLANCA', 64),
(664, 'SAN PABLO', 65),
(665, 'SAN BERNARDINO', 65),
(666, 'SAN LUIS', 65),
(667, 'TUMBADEN', 65),
(668, 'SANTA CRUZ', 66),
(669, 'ANDABAMBA', 66),
(670, 'CATACHE', 66),
(671, 'CHANCAYBA&Ntilde;OS', 66),
(672, 'LA ESPERANZA', 66),
(673, 'NINABAMBA', 66),
(674, 'PULAN', 66),
(675, 'SAUCEPAMPA', 66),
(676, 'SEXI', 66),
(677, 'UTICYACU', 66),
(678, 'YAUYUCAN', 66),
(679, 'CALLAO', 67),
(680, 'BELLAVISTA', 67),
(681, 'CARMEN DE LA LEGUA REYNOSO', 67),
(682, 'LA PERLA', 67),
(683, 'LA PUNTA', 67),
(684, 'VENTANILLA', 67),
(685, 'CUSCO', 67),
(686, 'CCORCA', 67),
(687, 'POROY', 67),
(688, 'SAN JERONIMO', 67),
(689, 'SAN SEBASTIAN', 67),
(690, 'SANTIAGO', 67),
(691, 'SAYLLA', 67),
(692, 'WANCHAQ', 67),
(693, 'ACOMAYO', 68),
(694, 'ACOPIA', 68),
(695, 'ACOS', 68),
(696, 'MOSOC LLACTA', 68),
(697, 'POMACANCHI', 68),
(698, 'RONDOCAN', 68),
(699, 'SANGARARA', 68),
(700, 'ANTA', 69),
(701, 'ANCAHUASI', 69),
(702, 'CACHIMAYO', 69),
(703, 'CHINCHAYPUJIO', 69),
(704, 'HUAROCONDO', 69),
(705, 'LIMATAMBO', 69),
(706, 'MOLLEPATA', 69),
(707, 'PUCYURA', 69),
(708, 'ZURITE', 69),
(709, 'CALCA', 70),
(710, 'COYA', 70),
(711, 'LAMAY', 70),
(712, 'LARES', 70),
(713, 'PISAC', 70),
(714, 'SAN SALVADOR', 70),
(715, 'TARAY', 70),
(716, 'YANATILE', 70),
(717, 'YANAOCA', 71),
(718, 'CHECCA', 71),
(719, 'KUNTURKANKI', 71),
(720, 'LANGUI', 71),
(721, 'LAYO', 71),
(722, 'PAMPAMARCA', 71),
(723, 'QUEHUE', 71),
(724, 'TUPAC AMARU', 71),
(725, 'SICUANI', 72),
(726, 'CHECACUPE', 72),
(727, 'COMBAPATA', 72),
(728, 'MARANGANI', 72),
(729, 'PITUMARCA', 72),
(730, 'SAN PABLO', 72),
(731, 'SAN PEDRO', 72),
(732, 'TINTA', 72),
(733, 'SANTO TOMAS', 73),
(734, 'CAPACMARCA', 73),
(735, 'CHAMACA', 73),
(736, 'COLQUEMARCA', 73),
(737, 'LIVITACA', 73),
(738, 'LLUSCO', 73),
(739, 'QUI&Ntilde;OTA', 73),
(740, 'VELILLE', 73),
(741, 'ESPINAR', 74),
(742, 'CONDOROMA', 74),
(743, 'COPORAQUE', 74),
(744, 'OCORURO', 74),
(745, 'PALLPATA', 74),
(746, 'PICHIGUA', 74),
(747, 'SUYCKUTAMBO', 74),
(748, 'ALTO PICHIGUA', 74),
(749, 'SANTA ANA', 75),
(750, 'ECHARATE', 75),
(751, 'HUAYOPATA', 75),
(752, 'MARANURA', 75),
(753, 'OCOBAMBA', 75),
(754, 'QUELLOUNO', 75),
(755, 'KIMBIRI', 75),
(756, 'SANTA TERESA', 75),
(757, 'VILCABAMBA', 75),
(758, 'PICHARI', 75),
(759, 'PARURO', 76),
(760, 'ACCHA', 76),
(761, 'CCAPI', 76),
(762, 'COLCHA', 76),
(763, 'HUANOQUITE', 76),
(764, 'OMACHA', 76),
(765, 'PACCARITAMBO', 76),
(766, 'PILLPINTO', 76),
(767, 'YAURISQUE', 76),
(768, 'PAUCARTAMBO', 77),
(769, 'CAICAY', 77),
(770, 'CHALLABAMBA', 77),
(771, 'COLQUEPATA', 77),
(772, 'HUANCARANI', 77),
(773, 'KOS&Ntilde;IPATA', 77),
(774, 'URCOS', 78),
(775, 'ANDAHUAYLILLAS', 78),
(776, 'CAMANTI', 78),
(777, 'CCARHUAYO', 78),
(778, 'CCATCA', 78),
(779, 'CUSIPATA', 78),
(780, 'HUARO', 78),
(781, 'LUCRE', 78),
(782, 'MARCAPATA', 78),
(783, 'OCONGATE', 78),
(784, 'OROPESA', 78),
(785, 'QUIQUIJANA', 78),
(786, 'URUBAMBA', 79),
(787, 'CHINCHERO', 79),
(788, 'HUAYLLABAMBA', 79),
(789, 'MACHUPICCHU', 79),
(790, 'MARAS', 79),
(791, 'OLLANTAYTAMBO', 79),
(792, 'YUCAY', 79),
(793, 'HUANCAVELICA', 80),
(794, 'ACOBAMBILLA', 80),
(795, 'ACORIA', 80),
(796, 'CONAYCA', 80),
(797, 'CUENCA', 80),
(798, 'HUACHOCOLPA', 80),
(799, 'HUAYLLAHUARA', 80),
(800, 'IZCUCHACA', 80),
(801, 'LARIA', 80),
(802, 'MANTA', 80),
(803, 'MARISCAL CACERES', 80),
(804, 'MOYA', 80),
(805, 'NUEVO OCCORO', 80),
(806, 'PALCA', 80),
(807, 'PILCHACA', 80),
(808, 'VILCA', 80),
(809, 'YAULI', 80),
(810, 'ASCENSION', 80),
(811, 'HUANDO', 80),
(812, 'ACOBAMBA', 81),
(813, 'ANDABAMBA', 81),
(814, 'ANTA', 81),
(815, 'CAJA', 81),
(816, 'MARCAS', 81),
(817, 'PAUCARA', 81),
(818, 'POMACOCHA', 81),
(819, 'ROSARIO', 81),
(820, 'LIRCAY', 82),
(821, 'ANCHONGA', 82),
(822, 'CALLANMARCA', 82),
(823, 'CCOCHACCASA', 82),
(824, 'CHINCHO', 82),
(825, 'CONGALLA', 82),
(826, 'HUANCA-HUANCA', 82),
(827, 'HUAYLLAY GRANDE', 82),
(828, 'JULCAMARCA', 82),
(829, 'SAN ANTONIO DE ANTAPARCO', 82),
(830, 'SANTO TOMAS DE PATA', 82),
(831, 'SECCLLA', 82),
(832, 'CASTROVIRREYNA', 83),
(833, 'ARMA', 83),
(834, 'AURAHUA', 83),
(835, 'CAPILLAS', 83),
(836, 'CHUPAMARCA', 83),
(837, 'COCAS', 83),
(838, 'HUACHOS', 83),
(839, 'HUAMATAMBO', 83),
(840, 'MOLLEPAMPA', 83),
(841, 'SAN JUAN', 83),
(842, 'SANTA ANA', 83),
(843, 'TANTARA', 83),
(844, 'TICRAPO', 83),
(845, 'CHURCAMPA', 84),
(846, 'ANCO', 84),
(847, 'CHINCHIHUASI', 84),
(848, 'EL CARMEN', 84),
(849, 'LA MERCED', 84),
(850, 'LOCROJA', 84),
(851, 'PAUCARBAMBA', 84),
(852, 'SAN MIGUEL DE MAYOCC', 84),
(853, 'SAN PEDRO DE CORIS', 84),
(854, 'PACHAMARCA', 84),
(855, 'HUAYTARA', 85),
(856, 'AYAVI', 85),
(857, 'CORDOVA', 85),
(858, 'HUAYACUNDO ARMA', 85),
(859, 'LARAMARCA', 85),
(860, 'OCOYO', 85),
(861, 'PILPICHACA', 85),
(862, 'QUERCO', 85),
(863, 'QUITO-ARMA', 85),
(864, 'SAN ANTONIO DE CUSICANCHA', 85),
(865, 'SAN FRANCISCO DE SANGAYAICO', 85),
(866, 'SAN ISIDRO', 85),
(867, 'SANTIAGO DE CHOCORVOS', 85),
(868, 'SANTIAGO DE QUIRAHUARA', 85),
(869, 'SANTO DOMINGO DE CAPILLAS', 85),
(870, 'TAMBO', 85),
(871, 'PAMPAS', 86),
(872, 'ACOSTAMBO', 86),
(873, 'ACRAQUIA', 86),
(874, 'AHUAYCHA', 86),
(875, 'COLCABAMBA', 86),
(876, 'DANIEL HERNANDEZ', 86),
(877, 'HUACHOCOLPA', 86),
(878, 'HUARIBAMBA', 86),
(879, '&Ntilde;AHUIMPUQUIO', 86),
(880, 'PAZOS', 86),
(881, 'QUISHUAR', 86),
(882, 'SALCABAMBA', 86),
(883, 'SALCAHUASI', 86),
(884, 'SAN MARCOS DE ROCCHAC', 86),
(885, 'SURCUBAMBA', 86),
(886, 'TINTAY PUNCU', 86),
(887, 'HUANUCO', 87),
(888, 'AMARILIS', 87),
(889, 'CHINCHAO', 87),
(890, 'CHURUBAMBA', 87),
(891, 'MARGOS', 87),
(892, 'QUISQUI', 87),
(893, 'SAN FRANCISCO DE CAYRAN', 87),
(894, 'SAN PEDRO DE CHAULAN', 87),
(895, 'SANTA MARIA DEL VALLE', 87),
(896, 'YARUMAYO', 87),
(897, 'PILLCO MARCA', 87),
(898, 'AMBO', 88),
(899, 'CAYNA', 88),
(900, 'COLPAS', 88),
(901, 'CONCHAMARCA', 88),
(902, 'HUACAR', 88),
(903, 'SAN FRANCISCO', 88),
(904, 'SAN RAFAEL', 88),
(905, 'TOMAY KICHWA', 88),
(906, 'LA UNION', 89),
(907, 'CHUQUIS', 89),
(908, 'MARIAS', 89),
(909, 'PACHAS', 89),
(910, 'QUIVILLA', 89),
(911, 'RIPAN', 89),
(912, 'SHUNQUI', 89),
(913, 'SILLAPATA', 89),
(914, 'YANAS', 89),
(915, 'HUACAYBAMBA', 90),
(916, 'CANCHABAMBA', 90),
(917, 'COCHABAMBA', 90),
(918, 'PINRA', 90),
(919, 'LLATA', 91),
(920, 'ARANCAY', 91),
(921, 'CHAVIN DE PARIARCA', 91),
(922, 'JACAS GRANDE', 91),
(923, 'JIRCAN', 91),
(924, 'MIRAFLORES', 91),
(925, 'MONZON', 91),
(926, 'PUNCHAO', 91),
(927, 'PU&Ntilde;OS', 91),
(928, 'SINGA', 91),
(929, 'TANTAMAYO', 91),
(930, 'RUPA-RUPA', 92),
(931, 'DANIEL ALOMIA ROBLES', 92),
(932, 'HERMILIO VALDIZAN', 92),
(933, 'JOSE CRESPO Y CASTILLO', 92),
(934, 'LUYANDO', 92),
(935, 'MARIANO DAMASO BERAUN', 92),
(936, 'HUACRACHUCO', 93),
(937, 'CHOLON', 93),
(938, 'SAN BUENAVENTURA', 93),
(939, 'PANAO', 94),
(940, 'CHAGLLA', 94),
(941, 'MOLINO', 94),
(942, 'UMARI', 94),
(943, 'PUERTO INCA', 95),
(944, 'CODO DEL POZUZO', 95),
(945, 'HONORIA', 95),
(946, 'TOURNAVISTA', 95),
(947, 'YUYAPICHIS', 95),
(948, 'JESUS', 96),
(949, 'BA&Ntilde;OS', 96),
(950, 'JIVIA', 96),
(951, 'QUEROPALCA', 96),
(952, 'RONDOS', 96),
(953, 'SAN FRANCISCO DE ASIS', 96),
(954, 'SAN MIGUEL DE CAURI', 96),
(955, 'CHAVINILLO', 97),
(956, 'CAHUAC', 97),
(957, 'CHACABAMBA', 97),
(958, 'APARICIO POMARES', 97),
(959, 'JACAS CHICO', 97),
(960, 'OBAS', 97),
(961, 'PAMPAMARCA', 97),
(962, 'CHORAS', 97),
(963, 'ICA', 98),
(964, 'LA TINGUI&Ntilde;A', 98),
(965, 'LOS AQUIJES', 98),
(966, 'OCUCAJE', 98),
(967, 'PACHACUTEC', 98),
(968, 'PARCONA', 98),
(969, 'PUEBLO NUEVO', 98),
(970, 'SALAS', 98),
(971, 'SAN JOSE DE LOS MOLINOS', 98),
(972, 'SAN JUAN BAUTISTA', 98),
(973, 'SANTIAGO', 98),
(974, 'SUBTANJALLA', 98),
(975, 'TATE', 98),
(976, 'YAUCA DEL ROSARIO', 98),
(977, 'CHINCHA ALTA', 99),
(978, 'ALTO LARAN', 99),
(979, 'CHAVIN', 99),
(980, 'CHINCHA BAJA', 99),
(981, 'EL CARMEN', 99),
(982, 'GROCIO PRADO', 99),
(983, 'PUEBLO NUEVO', 99),
(984, 'SAN JUAN DE YANAC', 99),
(985, 'SAN PEDRO DE HUACARPANA', 99),
(986, 'SUNAMPE', 99),
(987, 'TAMBO DE MORA', 99),
(988, 'NAZCA', 100),
(989, 'CHANGUILLO', 100),
(990, 'EL INGENIO', 100),
(991, 'MARCONA', 100),
(992, 'VISTA ALEGRE', 100),
(993, 'PALPA', 101),
(994, 'LLIPATA', 101),
(995, 'RIO GRANDE', 101),
(996, 'SANTA CRUZ', 101),
(997, 'TIBILLO', 101),
(998, 'PISCO', 102),
(999, 'HUANCANO', 102),
(1000, 'HUMAY', 102),
(1001, 'INDEPENDENCIA', 102),
(1002, 'PARACAS', 102),
(1003, 'SAN ANDRES', 102),
(1004, 'SAN CLEMENTE', 102),
(1005, 'TUPAC AMARU INCA', 102),
(1006, 'HUANCAYO', 103),
(1007, 'CARHUACALLANGA', 103),
(1008, 'CHACAPAMPA', 103),
(1009, 'CHICCHE', 103),
(1010, 'CHILCA', 103),
(1011, 'CHONGOS ALTO', 103),
(1012, 'CHUPURO', 103),
(1013, 'COLCA', 103),
(1014, 'CULLHUAS', 103),
(1015, 'EL TAMBO', 103),
(1016, 'HUACRAPUQUIO', 103),
(1017, 'HUALHUAS', 103),
(1018, 'HUANCAN', 103),
(1019, 'HUASICANCHA', 103),
(1020, 'HUAYUCACHI', 103),
(1021, 'INGENIO', 103),
(1022, 'PARIAHUANCA', 103),
(1023, 'PILCOMAYO', 103),
(1024, 'PUCARA', 103),
(1025, 'QUICHUAY', 103),
(1026, 'QUILCAS', 103),
(1027, 'SAN AGUSTIN', 103),
(1028, 'SAN JERONIMO DE TUNAN', 103),
(1029, 'SA&Ntilde;O', 103),
(1030, 'SAPALLANGA', 103),
(1031, 'SICAYA', 103),
(1032, 'SANTO DOMINGO DE ACOBAMBA', 103),
(1033, 'VIQUES', 103),
(1034, 'CONCEPCION', 104),
(1035, 'ACO', 104),
(1036, 'ANDAMARCA', 104),
(1037, 'CHAMBARA', 104),
(1038, 'COCHAS', 104),
(1039, 'COMAS', 104),
(1040, 'HEROINAS TOLEDO', 104),
(1041, 'MANZANARES', 104),
(1042, 'MARISCAL CASTILLA', 104),
(1043, 'MATAHUASI', 104),
(1044, 'MITO', 104),
(1045, 'NUEVE DE JULIO', 104),
(1046, 'ORCOTUNA', 104),
(1047, 'SAN JOSE DE QUERO', 104),
(1048, 'SANTA ROSA DE OCOPA', 104),
(1049, 'CHANCHAMAYO', 105),
(1050, 'PERENE', 105),
(1051, 'PICHANAQUI', 105),
(1052, 'SAN LUIS DE SHUARO', 105),
(1053, 'SAN RAMON', 105),
(1054, 'VITOC', 105),
(1055, 'JAUJA', 106),
(1056, 'ACOLLA', 106),
(1057, 'APATA', 106),
(1058, 'ATAURA', 106),
(1059, 'CANCHAYLLO', 106),
(1060, 'CURICACA', 106),
(1061, 'EL MANTARO', 106),
(1062, 'HUAMALI', 106),
(1063, 'HUARIPAMPA', 106),
(1064, 'HUERTAS', 106),
(1065, 'JANJAILLO', 106),
(1066, 'JULCAN', 106),
(1067, 'LEONOR ORDO&Ntilde;EZ', 106),
(1068, 'LLOCLLAPAMPA', 106),
(1069, 'MARCO', 106),
(1070, 'MASMA', 106),
(1071, 'MASMA CHICCHE', 106),
(1072, 'MOLINOS', 106),
(1073, 'MONOBAMBA', 106),
(1074, 'MUQUI', 106),
(1075, 'MUQUIYAUYO', 106),
(1076, 'PACA', 106),
(1077, 'PACCHA', 106),
(1078, 'PANCAN', 106),
(1079, 'PARCO', 106),
(1080, 'POMACANCHA', 106),
(1081, 'RICRAN', 106),
(1082, 'SAN LORENZO', 106),
(1083, 'SAN PEDRO DE CHUNAN', 106),
(1084, 'SAUSA', 106),
(1085, 'SINCOS', 106),
(1086, 'TUNAN MARCA', 106),
(1087, 'YAULI', 106),
(1088, 'YAUYOS', 106),
(1089, 'JUNIN', 107),
(1090, 'CARHUAMAYO', 107),
(1091, 'ONDORES', 107),
(1092, 'ULCUMAYO', 107),
(1093, 'SATIPO', 108),
(1094, 'COVIRIALI', 108),
(1095, 'LLAYLLA', 108),
(1096, 'MAZAMARI', 108),
(1097, 'PAMPA HERMOSA', 108),
(1098, 'PANGOA', 108),
(1099, 'RIO NEGRO', 108),
(1100, 'RIO TAMBO', 108),
(1101, 'TARMA', 109),
(1102, 'ACOBAMBA', 109),
(1103, 'HUARICOLCA', 109),
(1104, 'HUASAHUASI', 109),
(1105, 'LA UNION', 109),
(1106, 'PALCA', 109),
(1107, 'PALCAMAYO', 109),
(1108, 'SAN PEDRO DE CAJAS', 109),
(1109, 'TAPO', 109),
(1110, 'LA OROYA', 110),
(1111, 'CHACAPALPA', 110),
(1112, 'HUAY-HUAY', 110),
(1113, 'MARCAPOMACOCHA', 110),
(1114, 'MOROCOCHA', 110),
(1115, 'PACCHA', 110),
(1116, 'SANTA BARBARA DE CARHUACAYAN', 110),
(1117, 'SANTA ROSA DE SACCO', 110),
(1118, 'SUITUCANCHA', 110),
(1119, 'YAULI', 110),
(1120, 'CHUPACA', 111),
(1121, 'AHUAC', 111),
(1122, 'CHONGOS BAJO', 111),
(1123, 'HUACHAC', 111),
(1124, 'HUAMANCACA CHICO', 111),
(1125, 'SAN JUAN DE ISCOS', 111),
(1126, 'SAN JUAN DE JARPA', 111),
(1127, 'TRES DE DICIEMBRE', 111),
(1128, 'YANACANCHA', 111),
(1129, 'TRUJILLO', 112),
(1130, 'EL PORVENIR', 112),
(1131, 'FLORENCIA DE MORA', 112),
(1132, 'HUANCHACO', 112),
(1133, 'LA ESPERANZA', 112),
(1134, 'LAREDO', 112),
(1135, 'MOCHE', 112),
(1136, 'POROTO', 112),
(1137, 'SALAVERRY', 112),
(1138, 'SIMBAL', 112),
(1139, 'VICTOR LARCO HERRERA', 112),
(1140, 'ASCOPE', 113),
(1141, 'CHICAMA', 113),
(1142, 'CHOCOPE', 113),
(1143, 'MAGDALENA DE CAO', 113),
(1144, 'PAIJAN', 113),
(1145, 'RAZURI', 113),
(1146, 'SANTIAGO DE CAO', 113),
(1147, 'CASA GRANDE', 113),
(1148, 'BOLIVAR', 114),
(1149, 'BAMBAMARCA', 114),
(1150, 'CONDORMARCA', 114),
(1151, 'LONGOTEA', 114),
(1152, 'UCHUMARCA', 114),
(1153, 'UCUNCHA', 114),
(1154, 'CHEPEN', 115),
(1155, 'PACANGA', 115),
(1156, 'PUEBLO NUEVO', 115),
(1157, 'JULCAN', 116),
(1158, 'CALAMARCA', 116),
(1159, 'CARABAMBA', 116),
(1160, 'HUASO', 116),
(1161, 'OTUZCO', 117),
(1162, 'AGALLPAMPA', 117),
(1163, 'CHARAT', 117),
(1164, 'HUARANCHAL', 117),
(1165, 'LA CUESTA', 117),
(1166, 'MACHE', 117),
(1167, 'PARANDAY', 117),
(1168, 'SALPO', 117),
(1169, 'SINSICAP', 117),
(1170, 'USQUIL', 117),
(1171, 'SAN PEDRO DE LLOC', 118),
(1172, 'GUADALUPE', 118),
(1173, 'JEQUETEPEQUE', 118),
(1174, 'PACASMAYO', 118),
(1175, 'SAN JOSE', 118),
(1176, 'TAYABAMBA', 119),
(1177, 'BULDIBUYO', 119),
(1178, 'CHILLIA', 119),
(1179, 'HUANCASPATA', 119),
(1180, 'HUAYLILLAS', 119),
(1181, 'HUAYO', 119),
(1182, 'ONGON', 119),
(1183, 'PARCOY', 119),
(1184, 'PATAZ', 119),
(1185, 'PIAS', 119),
(1186, 'SANTIAGO DE CHALLAS', 119),
(1187, 'TAURIJA', 119),
(1188, 'URPAY', 119),
(1189, 'HUAMACHUCO', 120),
(1190, 'CHUGAY', 120),
(1191, 'COCHORCO', 120),
(1192, 'CURGOS', 120),
(1193, 'MARCABAL', 120),
(1194, 'SANAGORAN', 120),
(1195, 'SARIN', 120),
(1196, 'SARTIMBAMBA', 120),
(1197, 'SANTIAGO DE CHUCO', 121),
(1198, 'ANGASMARCA', 121),
(1199, 'CACHICADAN', 121),
(1200, 'MOLLEBAMBA', 121),
(1201, 'MOLLEPATA', 121),
(1202, 'QUIRUVILCA', 121),
(1203, 'SANTA CRUZ DE CHUCA', 121),
(1204, 'SITABAMBA', 121),
(1205, 'GRAN CHIMU', 122),
(1206, 'CASCAS', 122),
(1207, 'LUCMA', 122),
(1208, 'MARMOT', 122),
(1209, 'SAYAPULLO', 122),
(1210, 'VIRU', 123),
(1211, 'CHAO', 123),
(1212, 'GUADALUPITO', 123),
(1213, 'CHICLAYO', 124),
(1214, 'CHONGOYAPE', 124),
(1215, 'ETEN', 124),
(1216, 'ETEN PUERTO', 124),
(1217, 'JOSE LEONARDO ORTIZ', 124),
(1218, 'LA VICTORIA', 124),
(1219, 'LAGUNAS', 124),
(1220, 'MONSEFU', 124),
(1221, 'NUEVA ARICA', 124),
(1222, 'OYOTUN', 124),
(1223, 'PICSI', 124),
(1224, 'PIMENTEL', 124),
(1225, 'REQUE', 124),
(1226, 'SANTA ROSA', 124),
(1227, 'SA&Ntilde;A', 124),
(1228, 'CAYALTI', 124),
(1229, 'PATAPO', 124),
(1230, 'POMALCA', 124),
(1231, 'PUCALA', 124),
(1232, 'TUMAN', 124),
(1233, 'FERRE&Ntilde;AFE', 125),
(1234, 'CA&Ntilde;ARIS', 125),
(1235, 'INCAHUASI', 125),
(1236, 'MANUEL ANTONIO MESONES MURO', 125),
(1237, 'PITIPO', 125),
(1238, 'PUEBLO NUEVO', 125),
(1239, 'LAMBAYEQUE', 126),
(1240, 'CHOCHOPE', 126),
(1241, 'ILLIMO', 126),
(1242, 'JAYANCA', 126),
(1243, 'MOCHUMI', 126),
(1244, 'MORROPE', 126),
(1245, 'MOTUPE', 126),
(1246, 'OLMOS', 126),
(1247, 'PACORA', 126),
(1248, 'SALAS', 126),
(1249, 'SAN JOSE', 126),
(1250, 'TUCUME', 126),
(1251, 'LIMA', 127),
(1252, 'ANCON', 127),
(1253, 'ATE', 127),
(1254, 'BARRANCO', 127),
(1255, 'BREÑA', 127),
(1256, 'CARABAYLLO', 127),
(1257, 'CHACLACAYO', 127),
(1258, 'CHORRILLOS', 127),
(1259, 'CIENEGUILLA', 127),
(1260, 'COMAS', 127),
(1261, 'EL AGUSTINO', 127),
(1262, 'INDEPENDENCIA', 127),
(1263, 'JESUS MARIA', 127),
(1264, 'LA MOLINA', 127),
(1265, 'LA VICTORIA', 127),
(1266, 'LINCE', 127),
(1267, 'LOS OLIVOS', 127),
(1268, 'LURIGANCHO', 127),
(1269, 'LURIN', 127),
(1270, 'MAGDALENA DEL MAR', 127),
(1271, 'MAGDALENA VIEJA', 127),
(1272, 'MIRAFLORES', 127),
(1273, 'PACHACAMAC', 127),
(1274, 'PUCUSANA', 127),
(1275, 'PUENTE PIEDRA', 127),
(1276, 'PUNTA HERMOSA', 127),
(1277, 'PUNTA NEGRA', 127),
(1278, 'RIMAC', 127),
(1279, 'SAN BARTOLO', 127),
(1280, 'SAN BORJA', 127),
(1281, 'SAN ISIDRO', 127),
(1282, 'SAN JUAN DE LURIGANCHO', 127),
(1283, 'SAN JUAN DE MIRAFLORES', 127),
(1284, 'SAN LUIS', 127),
(1285, 'SAN MARTIN DE PORRES', 127),
(1286, 'SAN MIGUEL', 127),
(1287, 'SANTA ANITA', 127),
(1288, 'SANTA MARIA DEL MAR', 127),
(1289, 'SANTA ROSA', 127),
(1290, 'SANTIAGO DE SURCO', 127),
(1291, 'SURQUILLO', 127),
(1292, 'VILLA EL SALVADOR', 127),
(1293, 'VILLA MARIA DEL TRIUNFO', 127),
(1294, 'BARRANCA', 128),
(1295, 'PARAMONGA', 128),
(1296, 'PATIVILCA', 128),
(1297, 'SUPE', 128),
(1298, 'SUPE PUERTO', 128),
(1299, 'CAJATAMBO', 129),
(1300, 'COPA', 129),
(1301, 'GORGOR', 129),
(1302, 'HUANCAPON', 129),
(1303, 'MANAS', 129),
(1304, 'CANTA', 130),
(1305, 'ARAHUAY', 130),
(1306, 'HUAMANTANGA', 130),
(1307, 'HUAROS', 130),
(1308, 'LACHAQUI', 130),
(1309, 'SAN BUENAVENTURA', 130),
(1310, 'SANTA ROSA DE QUIVES', 130),
(1311, 'SAN VICENTE DE CA&Ntilde;ETE', 131),
(1312, 'ASIA', 131),
(1313, 'CALANGO', 131),
(1314, 'CERRO AZUL', 131),
(1315, 'CHILCA', 131),
(1316, 'COAYLLO', 131),
(1317, 'IMPERIAL', 131),
(1318, 'LUNAHUANA', 131),
(1319, 'MALA', 131),
(1320, 'NUEVO IMPERIAL', 131),
(1321, 'PACARAN', 131),
(1322, 'QUILMANA', 131),
(1323, 'SAN ANTONIO', 131),
(1324, 'SAN LUIS', 131),
(1325, 'SANTA CRUZ DE FLORES', 131),
(1326, 'ZU&Ntilde;IGA', 131),
(1327, 'HUARAL', 132),
(1328, 'ATAVILLOS ALTO', 132),
(1329, 'ATAVILLOS BAJO', 132),
(1330, 'AUCALLAMA', 132),
(1331, 'CHANCAY', 132),
(1332, 'IHUARI', 132),
(1333, 'LAMPIAN', 132),
(1334, 'PACARAOS', 132),
(1335, 'SAN MIGUEL DE ACOS', 132),
(1336, 'SANTA CRUZ DE ANDAMARCA', 132),
(1337, 'SUMBILCA', 132),
(1338, 'VEINTISIETE DE NOVIEMBRE', 132),
(1339, 'MATUCANA', 133),
(1340, 'ANTIOQUIA', 133),
(1341, 'CALLAHUANCA', 133),
(1342, 'CARAMPOMA', 133),
(1343, 'CHICLA', 133),
(1344, 'CUENCA', 133),
(1345, 'HUACHUPAMPA', 133),
(1346, 'HUANZA', 133),
(1347, 'HUAROCHIRI', 133),
(1348, 'LAHUAYTAMBO', 133),
(1349, 'LANGA', 133),
(1350, 'LARAOS', 133),
(1351, 'MARIATANA', 133),
(1352, 'RICARDO PALMA', 133),
(1353, 'SAN ANDRES DE TUPICOCHA', 133),
(1354, 'SAN ANTONIO', 133),
(1355, 'SAN BARTOLOME', 133),
(1356, 'SAN DAMIAN', 133),
(1357, 'SAN JUAN DE IRIS', 133),
(1358, 'SAN JUAN DE TANTARANCHE', 133),
(1359, 'SAN LORENZO DE QUINTI', 133),
(1360, 'SAN MATEO', 133),
(1361, 'SAN MATEO DE OTAO', 133),
(1362, 'SAN PEDRO DE CASTA', 133),
(1363, 'SAN PEDRO DE HUANCAYRE', 133),
(1364, 'SANGALLAYA', 133),
(1365, 'SANTA CRUZ DE COCACHACRA', 133),
(1366, 'SANTA EULALIA', 133),
(1367, 'SANTIAGO DE ANCHUCAYA', 133),
(1368, 'SANTIAGO DE TUNA', 133),
(1369, 'SANTO DOMINGO DE LOS OLLEROS', 133),
(1370, 'SURCO', 133),
(1371, 'HUACHO', 134),
(1372, 'AMBAR', 134),
(1373, 'CALETA DE CARQUIN', 134),
(1374, 'CHECRAS', 134),
(1375, 'HUALMAY', 134),
(1376, 'HUAURA', 134),
(1377, 'LEONCIO PRADO', 134),
(1378, 'PACCHO', 134),
(1379, 'SANTA LEONOR', 134),
(1380, 'SANTA MARIA', 134),
(1381, 'SAYAN', 134),
(1382, 'VEGUETA', 134),
(1383, 'OYON', 135),
(1384, 'ANDAJES', 135),
(1385, 'CAUJUL', 135),
(1386, 'COCHAMARCA', 135),
(1387, 'NAVAN', 135),
(1388, 'PACHANGARA', 135),
(1389, 'YAUYOS', 136),
(1390, 'ALIS', 136),
(1391, 'AYAUCA', 136),
(1392, 'AYAVIRI', 136),
(1393, 'AZANGARO', 136),
(1394, 'CACRA', 136),
(1395, 'CARANIA', 136),
(1396, 'CATAHUASI', 136),
(1397, 'CHOCOS', 136),
(1398, 'COCHAS', 136),
(1399, 'COLONIA', 136),
(1400, 'HONGOS', 136),
(1401, 'HUAMPARA', 136),
(1402, 'HUANCAYA', 136),
(1403, 'HUANGASCAR', 136),
(1404, 'HUANTAN', 136),
(1405, 'HUA&Ntilde;EC', 136),
(1406, 'LARAOS', 136),
(1407, 'LINCHA', 136),
(1408, 'MADEAN', 136),
(1409, 'MIRAFLORES', 136),
(1410, 'OMAS', 136),
(1411, 'PUTINZA', 136),
(1412, 'QUINCHES', 136),
(1413, 'QUINOCAY', 136),
(1414, 'SAN JOAQUIN', 136),
(1415, 'SAN PEDRO DE PILAS', 136),
(1416, 'TANTA', 136),
(1417, 'TAURIPAMPA', 136),
(1418, 'TOMAS', 136),
(1419, 'TUPE', 136),
(1420, 'VI&Ntilde;AC', 136),
(1421, 'VITIS', 136),
(1422, 'IQUITOS', 137),
(1423, 'ALTO NANAY', 137),
(1424, 'FERNANDO LORES', 137),
(1425, 'INDIANA', 137),
(1426, 'LAS AMAZONAS', 137),
(1427, 'MAZAN', 137),
(1428, 'NAPO', 137),
(1429, 'PUNCHANA', 137),
(1430, 'PUTUMAYO', 137),
(1431, 'TORRES CAUSANA', 137),
(1432, 'BELEN', 137),
(1433, 'SAN JUAN BAUTISTA', 137),
(1434, 'YURIMAGUAS', 138),
(1435, 'BALSAPUERTO', 138),
(1436, 'BARRANCA', 138),
(1437, 'CAHUAPANAS', 138),
(1438, 'JEBEROS', 138),
(1439, 'LAGUNAS', 138),
(1440, 'MANSERICHE', 138),
(1441, 'MORONA', 138),
(1442, 'PASTAZA', 138),
(1443, 'SANTA CRUZ', 138),
(1444, 'TENIENTE CESAR LOPEZ ROJAS', 138),
(1445, 'NAUTA', 139),
(1446, 'PARINARI', 139),
(1447, 'TIGRE', 139),
(1448, 'TROMPETEROS', 139),
(1449, 'URARINAS', 139),
(1450, 'RAMON CASTILLA', 140),
(1451, 'PEBAS', 140),
(1452, 'YAVARI', 140),
(1453, 'SAN PABLO', 140),
(1454, 'REQUENA', 141),
(1455, 'ALTO TAPICHE', 141),
(1456, 'CAPELO', 141),
(1457, 'EMILIO SAN MARTIN', 141),
(1458, 'MAQUIA', 141),
(1459, 'PUINAHUA', 141),
(1460, 'SAQUENA', 141),
(1461, 'SOPLIN', 141),
(1462, 'TAPICHE', 141),
(1463, 'JENARO HERRERA', 141),
(1464, 'YAQUERANA', 141),
(1465, 'CONTAMANA', 142),
(1466, 'INAHUAYA', 142),
(1467, 'PADRE MARQUEZ', 142),
(1468, 'PAMPA HERMOSA', 142),
(1469, 'SARAYACU', 142),
(1470, 'VARGAS GUERRA', 142),
(1471, 'TAMBOPATA', 143),
(1472, 'INAMBARI', 143),
(1473, 'LAS PIEDRAS', 143),
(1474, 'LABERINTO', 143),
(1475, 'MANU', 144),
(1476, 'FITZCARRALD', 144),
(1477, 'MADRE DE DIOS', 144),
(1478, 'HUEPETUHE', 144),
(1479, 'I&Ntilde;APARI', 145),
(1480, 'IBERIA', 145),
(1481, 'TAHUAMANU', 145),
(1482, 'MOQUEGUA', 146),
(1483, 'CARUMAS', 146),
(1484, 'CUCHUMBAYA', 146),
(1485, 'SAMEGUA', 146),
(1486, 'SAN CRISTOBAL', 146),
(1487, 'TORATA', 146),
(1488, 'OMATE', 147),
(1489, 'CHOJATA', 147),
(1490, 'COALAQUE', 147),
(1491, 'ICHU&Ntilde;A', 147),
(1492, 'LA CAPILLA', 147),
(1493, 'LLOQUE', 147),
(1494, 'MATALAQUE', 147),
(1495, 'PUQUINA', 147),
(1496, 'QUINISTAQUILLAS', 147),
(1497, 'UBINAS', 147),
(1498, 'YUNGA', 147),
(1499, 'ILO', 148),
(1500, 'EL ALGARROBAL', 148),
(1501, 'PACOCHA', 148),
(1502, 'CHAUPIMARCA', 149),
(1503, 'HUACHON', 149),
(1504, 'HUARIACA', 149),
(1505, 'HUAYLLAY', 149),
(1506, 'NINACACA', 149),
(1507, 'PALLANCHACRA', 149),
(1508, 'PAUCARTAMBO', 149),
(1509, 'SAN FCO.DE ASIS DE YARUSYACAN', 149),
(1510, 'SIMON BOLIVAR', 149),
(1511, 'TICLACAYAN', 149),
(1512, 'TINYAHUARCO', 149),
(1513, 'VICCO', 149),
(1514, 'YANACANCHA', 149),
(1515, 'YANAHUANCA', 150),
(1516, 'CHACAYAN', 150),
(1517, 'GOYLLARISQUIZGA', 150),
(1518, 'PAUCAR', 150),
(1519, 'SAN PEDRO DE PILLAO', 150),
(1520, 'SANTA ANA DE TUSI', 150),
(1521, 'TAPUC', 150),
(1522, 'VILCABAMBA', 150),
(1523, 'OXAPAMPA', 151),
(1524, 'CHONTABAMBA', 151),
(1525, 'HUANCABAMBA', 151),
(1526, 'PALCAZU', 151),
(1527, 'POZUZO', 151),
(1528, 'PUERTO BERMUDEZ', 151),
(1529, 'VILLA RICA', 151),
(1530, 'PIURA', 152),
(1531, 'CASTILLA', 152),
(1532, 'CATACAOS', 152),
(1533, 'CURA MORI', 152),
(1534, 'EL TALLAN', 152),
(1535, 'LA ARENA', 152),
(1536, 'LA UNION', 152),
(1537, 'LAS LOMAS', 152),
(1538, 'TAMBO GRANDE', 152),
(1539, 'AYABACA', 153),
(1540, 'FRIAS', 153),
(1541, 'JILILI', 153),
(1542, 'LAGUNAS', 153),
(1543, 'MONTERO', 153),
(1544, 'PACAIPAMPA', 153),
(1545, 'PAIMAS', 153),
(1546, 'SAPILLICA', 153),
(1547, 'SICCHEZ', 153),
(1548, 'SUYO', 153),
(1549, 'HUANCABAMBA', 154),
(1550, 'CANCHAQUE', 154),
(1551, 'EL CARMEN DE LA FRONTERA', 154),
(1552, 'HUARMACA', 154),
(1553, 'LALAQUIZ', 154),
(1554, 'SAN MIGUEL DE EL FAIQUE', 154),
(1555, 'SONDOR', 154),
(1556, 'SONDORILLO', 154),
(1557, 'CHULUCANAS', 155),
(1558, 'BUENOS AIRES', 155),
(1559, 'CHALACO', 155),
(1560, 'LA MATANZA', 155),
(1561, 'MORROPON', 155),
(1562, 'SALITRAL', 155),
(1563, 'SAN JUAN DE BIGOTE', 155),
(1564, 'SANTA CATALINA DE MOSSA', 155),
(1565, 'SANTO DOMINGO', 155),
(1566, 'YAMANGO', 155),
(1567, 'PAITA', 156),
(1568, 'AMOTAPE', 156),
(1569, 'ARENAL', 156),
(1570, 'COLAN', 156),
(1571, 'LA HUACA', 156),
(1572, 'TAMARINDO', 156),
(1573, 'VICHAYAL', 156),
(1574, 'SULLANA', 157),
(1575, 'BELLAVISTA', 157),
(1576, 'IGNACIO ESCUDERO', 157),
(1577, 'LANCONES', 157),
(1578, 'MARCAVELICA', 157),
(1579, 'MIGUEL CHECA', 157),
(1580, 'QUERECOTILLO', 157),
(1581, 'SALITRAL', 157),
(1582, 'PARI&Ntilde;AS', 158),
(1583, 'EL ALTO', 158),
(1584, 'LA BREA', 158),
(1585, 'LOBITOS', 158),
(1586, 'LOS ORGANOS', 158),
(1587, 'MANCORA', 158),
(1588, 'SECHURA', 159),
(1589, 'BELLAVISTA DE LA UNION', 159),
(1590, 'BERNAL', 159),
(1591, 'CRISTO NOS VALGA', 159),
(1592, 'VICE', 159),
(1593, 'RINCONADA LLICUAR', 159),
(1594, 'PUNO', 160),
(1595, 'ACORA', 160),
(1596, 'AMANTANI', 160),
(1597, 'ATUNCOLLA', 160),
(1598, 'CAPACHICA', 160),
(1599, 'CHUCUITO', 160),
(1600, 'COATA', 160),
(1601, 'HUATA', 160),
(1602, 'MA&Ntilde;AZO', 160),
(1603, 'PAUCARCOLLA', 160),
(1604, 'PICHACANI', 160),
(1605, 'PLATERIA', 160),
(1606, 'SAN ANTONIO', 160),
(1607, 'TIQUILLACA', 160),
(1608, 'VILQUE', 160),
(1609, 'AZANGARO', 161),
(1610, 'ACHAYA', 161),
(1611, 'ARAPA', 161),
(1612, 'ASILLO', 161),
(1613, 'CAMINACA', 161),
(1614, 'CHUPA', 161),
(1615, 'JOSE DOMINGO CHOQUEHUANCA', 161),
(1616, 'MU&Ntilde;ANI', 161),
(1617, 'POTONI', 161),
(1618, 'SAMAN', 161),
(1619, 'SAN ANTON', 161),
(1620, 'SAN JOSE', 161),
(1621, 'SAN JUAN DE SALINAS', 161),
(1622, 'SANTIAGO DE PUPUJA', 161),
(1623, 'TIRAPATA', 161),
(1624, 'MACUSANI', 162),
(1625, 'AJOYANI', 162),
(1626, 'AYAPATA', 162),
(1627, 'COASA', 162),
(1628, 'CORANI', 162),
(1629, 'CRUCERO', 162),
(1630, 'ITUATA', 162),
(1631, 'OLLACHEA', 162),
(1632, 'SAN GABAN', 162),
(1633, 'USICAYOS', 162),
(1634, 'JULI', 163),
(1635, 'DESAGUADERO', 163),
(1636, 'HUACULLANI', 163),
(1637, 'KELLUYO', 163),
(1638, 'PISACOMA', 163),
(1639, 'POMATA', 163),
(1640, 'ZEPITA', 163),
(1641, 'ILAVE', 164),
(1642, 'CAPAZO', 164),
(1643, 'PILCUYO', 164),
(1644, 'SANTA ROSA', 164),
(1645, 'CONDURIRI', 164),
(1646, 'HUANCANE', 165),
(1647, 'COJATA', 165),
(1648, 'HUATASANI', 165),
(1649, 'INCHUPALLA', 165),
(1650, 'PUSI', 165),
(1651, 'ROSASPATA', 165),
(1652, 'TARACO', 165),
(1653, 'VILQUE CHICO', 165),
(1654, 'LAMPA', 166),
(1655, 'CABANILLA', 166),
(1656, 'CALAPUJA', 166),
(1657, 'NICASIO', 166),
(1658, 'OCUVIRI', 166),
(1659, 'PALCA', 166),
(1660, 'PARATIA', 166),
(1661, 'PUCARA', 166),
(1662, 'SANTA LUCIA', 166),
(1663, 'VILAVILA', 166),
(1664, 'AYAVIRI', 167),
(1665, 'ANTAUTA', 167),
(1666, 'CUPI', 167),
(1667, 'LLALLI', 167),
(1668, 'MACARI', 167),
(1669, 'NU&Ntilde;OA', 167),
(1670, 'ORURILLO', 167),
(1671, 'SANTA ROSA', 167),
(1672, 'UMACHIRI', 167),
(1673, 'MOHO', 168),
(1674, 'CONIMA', 168),
(1675, 'HUAYRAPATA', 168),
(1676, 'TILALI', 168),
(1677, 'PUTINA', 169),
(1678, 'ANANEA', 169),
(1679, 'PEDRO VILCA APAZA', 169),
(1680, 'QUILCAPUNCU', 169),
(1681, 'SINA', 169),
(1682, 'JULIACA', 170),
(1683, 'CABANA', 170),
(1684, 'CABANILLAS', 170),
(1685, 'CARACOTO', 170),
(1686, 'SANDIA', 171),
(1687, 'CUYOCUYO', 171),
(1688, 'LIMBANI', 171),
(1689, 'PATAMBUCO', 171),
(1690, 'PHARA', 171),
(1691, 'QUIACA', 171),
(1692, 'SAN JUAN DEL ORO', 171),
(1693, 'YANAHUAYA', 171),
(1694, 'ALTO INAMBARI', 171),
(1695, 'YUNGUYO', 172),
(1696, 'ANAPIA', 172),
(1697, 'COPANI', 172),
(1698, 'CUTURAPI', 172),
(1699, 'OLLARAYA', 172),
(1700, 'TINICACHI', 172),
(1701, 'UNICACHI', 172),
(1702, 'MOYOBAMBA', 173),
(1703, 'CALZADA', 173),
(1704, 'HABANA', 173),
(1705, 'JEPELACIO', 173),
(1706, 'SORITOR', 173),
(1707, 'YANTALO', 173),
(1708, 'BELLAVISTA', 174),
(1709, 'ALTO BIAVO', 174),
(1710, 'BAJO BIAVO', 174),
(1711, 'HUALLAGA', 174),
(1712, 'SAN PABLO', 174),
(1713, 'SAN RAFAEL', 174),
(1714, 'SAN JOSE DE SISA', 175),
(1715, 'AGUA BLANCA', 175),
(1716, 'SAN MARTIN', 175),
(1717, 'SANTA ROSA', 175),
(1718, 'SHATOJA', 175),
(1719, 'SAPOSOA', 176),
(1720, 'ALTO SAPOSOA', 176),
(1721, 'EL ESLABON', 176),
(1722, 'PISCOYACU', 176),
(1723, 'SACANCHE', 176),
(1724, 'TINGO DE SAPOSOA', 176),
(1725, 'LAMAS', 177),
(1726, 'ALONSO DE ALVARADO', 177),
(1727, 'BARRANQUITA', 177),
(1728, 'CAYNARACHI', 177),
(1729, 'CU&Ntilde;UMBUQUI', 177),
(1730, 'PINTO RECODO', 177),
(1731, 'RUMISAPA', 177),
(1732, 'SAN ROQUE DE CUMBAZA', 177),
(1733, 'SHANAO', 177),
(1734, 'TABALOSOS', 177),
(1735, 'ZAPATERO', 177),
(1736, 'JUANJUI', 178),
(1737, 'CAMPANILLA', 178),
(1738, 'HUICUNGO', 178),
(1739, 'PACHIZA', 178),
(1740, 'PAJARILLO', 178),
(1741, 'PICOTA', 179),
(1742, 'BUENOS AIRES', 179),
(1743, 'CASPISAPA', 179),
(1744, 'PILLUANA', 179),
(1745, 'PUCACACA', 179),
(1746, 'SAN CRISTOBAL', 179),
(1747, 'SAN HILARION', 179),
(1748, 'SHAMBOYACU', 179),
(1749, 'TINGO DE PONASA', 179),
(1750, 'TRES UNIDOS', 179),
(1751, 'RIOJA', 180),
(1752, 'AWAJUN', 180),
(1753, 'ELIAS SOPLIN VARGAS', 180),
(1754, 'NUEVA CAJAMARCA', 180),
(1755, 'PARDO MIGUEL', 180),
(1756, 'POSIC', 180),
(1757, 'SAN FERNANDO', 180),
(1758, 'YORONGOS', 180),
(1759, 'YURACYACU', 180),
(1760, 'TARAPOTO', 181),
(1761, 'ALBERTO LEVEAU', 181),
(1762, 'CACATACHI', 181),
(1763, 'CHAZUTA', 181),
(1764, 'CHIPURANA', 181),
(1765, 'EL PORVENIR', 181),
(1766, 'HUIMBAYOC', 181),
(1767, 'JUAN GUERRA', 181),
(1768, 'LA BANDA DE SHILCAYO', 181),
(1769, 'MORALES', 181),
(1770, 'PAPAPLAYA', 181),
(1771, 'SAN ANTONIO', 181),
(1772, 'SAUCE', 181),
(1773, 'SHAPAJA', 181),
(1774, 'TOCACHE', 182),
(1775, 'NUEVO PROGRESO', 182),
(1776, 'POLVORA', 182),
(1777, 'SHUNTE', 182),
(1778, 'UCHIZA', 182),
(1779, 'TACNA', 183),
(1780, 'ALTO DE LA ALIANZA', 183),
(1781, 'CALANA', 183),
(1782, 'CIUDAD NUEVA', 183),
(1783, 'INCLAN', 183),
(1784, 'PACHIA', 183),
(1785, 'PALCA', 183),
(1786, 'POCOLLAY', 183),
(1787, 'SAMA', 183),
(1788, 'CORONEL GREGORIO ALBARRACIN LANCHIPA', 183),
(1789, 'CANDARAVE', 184),
(1790, 'CAIRANI', 184),
(1791, 'CAMILACA', 184),
(1792, 'CURIBAYA', 184),
(1793, 'HUANUARA', 184),
(1794, 'QUILAHUANI', 184),
(1795, 'LOCUMBA', 185),
(1796, 'ILABAYA', 185),
(1797, 'ITE', 185),
(1798, 'TARATA', 186),
(1799, 'CHUCATAMANI', 186),
(1800, 'ESTIQUE', 186),
(1801, 'ESTIQUE-PAMPA', 186),
(1802, 'SITAJARA', 186),
(1803, 'SUSAPAYA', 186),
(1804, 'TARUCACHI', 186),
(1805, 'TICACO', 186),
(1806, 'TUMBES', 187),
(1807, 'CORRALES', 187),
(1808, 'LA CRUZ', 187),
(1809, 'PAMPAS DE HOSPITAL', 187),
(1810, 'SAN JACINTO', 187),
(1811, 'SAN JUAN DE LA VIRGEN', 187),
(1812, 'ZORRITOS', 188),
(1813, 'CASITAS', 188),
(1814, 'ZARUMILLA', 189),
(1815, 'AGUAS VERDES', 189),
(1816, 'MATAPALO', 189),
(1817, 'PAPAYAL', 189),
(1818, 'CALLERIA', 190),
(1819, 'CAMPOVERDE', 190),
(1820, 'IPARIA', 190),
(1821, 'MASISEA', 190),
(1822, 'YARINACOCHA', 190),
(1823, 'NUEVA REQUENA', 190),
(1824, 'RAYMONDI', 191),
(1825, 'SEPAHUA', 191),
(1826, 'TAHUANIA', 191),
(1827, 'YURUA', 191),
(1828, 'PADRE ABAD', 192),
(1829, 'IRAZOLA', 192),
(1830, 'CURIMANA', 192),
(1831, 'PURUS', 193);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_estadodoc`
--

CREATE TABLE `sc_estadodoc` (
  `idEstadoDoc` int(11) NOT NULL,
  `descEstadoDoc` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_estadodoc`
--

INSERT INTO `sc_estadodoc` (`idEstadoDoc`, `descEstadoDoc`) VALUES
(1, 'REGISTRADO'),
(2, 'ATENDIDO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_estadoitem`
--

CREATE TABLE `sc_estadoitem` (
  `idEstadoItem` int(11) NOT NULL,
  `descEstadoItem` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_estadoitem`
--

INSERT INTO `sc_estadoitem` (`idEstadoItem`, `descEstadoItem`) VALUES
(1, 'ACTIVO'),
(2, 'INACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_estadoreclamo`
--

CREATE TABLE `sc_estadoreclamo` (
  `idEstadoRec` int(11) NOT NULL,
  `descEstadoRec` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `codEstadoRec` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_estadoreclamo`
--

INSERT INTO `sc_estadoreclamo` (`idEstadoRec`, `descEstadoRec`, `codEstadoRec`) VALUES
(1, 'RESUELTO', '1'),
(2, 'EN TRAMITE', '2'),
(3, 'TRASLADADO', '3'),
(4, 'ARCHIVADO POR DUPLICIDAD', '4'),
(5, 'ACUMULADO', '5'),
(6, 'CONCLUIDO', '6');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_estusuario`
--

CREATE TABLE `sc_estusuario` (
  `idEstadoUs` int(11) NOT NULL,
  `descEstadoUs` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_estusuario`
--

INSERT INTO `sc_estusuario` (`idEstadoUs`, `descEstadoUs`) VALUES
(1, 'HABILITADO'),
(2, 'INHABILITADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_etapasrec`
--

CREATE TABLE `sc_etapasrec` (
  `idEtapa` int(11) NOT NULL,
  `descEtapa` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_etapasrec`
--

INSERT INTO `sc_etapasrec` (`idEtapa`, `descEtapa`) VALUES
(1, 'ADMISIÓN Y REGISTRO'),
(2, 'EVALUACIÓN E INVESTIGACIÓN'),
(3, 'RESULTADO Y NOTIFICACIÓN'),
(4, 'ARCHIVOY CUSTODIA DEL EXPEDIENTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_parametros`
--

CREATE TABLE `sc_parametros` (
  `idParametro` int(11) NOT NULL,
  `tipParametro` int(11) DEFAULT '1',
  `detalleParametro` text COLLATE utf8_bin,
  `detalleParametro2` text COLLATE utf8_bin,
  `correoParametro` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `anioInicial` int(11) DEFAULT '0',
  `anioFinal` int(11) DEFAULT '0',
  `estatusParametro` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_parametros`
--

INSERT INTO `sc_parametros` (`idParametro`, `tipParametro`, `detalleParametro`, `detalleParametro2`, `correoParametro`, `anioInicial`, `anioFinal`, `estatusParametro`) VALUES
(1, 1, 'Libro de Reclamaciones en Salud Virtual-HNSEB', 'Información de Registro de Reclamo en Salud Virtual-HNSEB', 'libroreclamaciones@hnseb.gob.pe', 0, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_perfil`
--

CREATE TABLE `sc_perfil` (
  `idPerfil` int(11) NOT NULL,
  `descPerfil` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_perfil`
--

INSERT INTO `sc_perfil` (`idPerfil`, `descPerfil`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'JEFE(A)'),
(3, 'RESPONSABLE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_provincia`
--

CREATE TABLE `sc_provincia` (
  `idProvincia` int(11) NOT NULL,
  `descProvincia` text COLLATE utf8_bin,
  `DepaId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_provincia`
--

INSERT INTO `sc_provincia` (`idProvincia`, `descProvincia`, `DepaId`) VALUES
(1, 'CHACHAPOYAS ', 1),
(2, 'BAGUA', 1),
(3, 'BONGARA', 1),
(4, 'CONDORCANQUI', 1),
(5, 'LUYA', 1),
(6, 'RODRIGUEZ DE MENDOZA', 1),
(7, 'UTCUBAMBA', 1),
(8, 'HUARAZ', 2),
(9, 'AIJA', 2),
(10, 'ANTONIO RAYMONDI', 2),
(11, 'ASUNCION', 2),
(12, 'BOLOGNESI', 2),
(13, 'CARHUAZ', 2),
(14, 'CARLOS FERMIN FITZCARRALD', 2),
(15, 'CASMA', 2),
(16, 'CORONGO', 2),
(17, 'HUARI', 2),
(18, 'HUARMEY', 2),
(19, 'HUAYLAS', 2),
(20, 'MARISCAL LUZURIAGA', 2),
(21, 'OCROS', 2),
(22, 'PALLASCA', 2),
(23, 'POMABAMBA', 2),
(24, 'RECUAY', 2),
(25, 'SANTA', 2),
(26, 'SIHUAS', 2),
(27, 'YUNGAY', 2),
(28, 'ABANCAY', 3),
(29, 'ANDAHUAYLAS', 3),
(30, 'ANTABAMBA', 3),
(31, 'AYMARAES', 3),
(32, 'COTABAMBAS', 3),
(33, 'CHINCHEROS', 3),
(34, 'GRAU', 3),
(35, 'AREQUIPA', 4),
(36, 'CAMANA', 4),
(37, 'CARAVELI', 4),
(38, 'CASTILLA', 4),
(39, 'CAYLLOMA', 4),
(40, 'CONDESUYOS', 4),
(41, 'ISLAY', 4),
(42, 'LA UNION', 4),
(43, 'HUAMANGA', 5),
(44, 'CANGALLO', 5),
(45, 'HUANCA SANCOS', 5),
(46, 'HUANTA', 5),
(47, 'LA MAR', 5),
(48, 'LUCANAS', 5),
(49, 'PARINACOCHAS', 5),
(50, 'PAUCAR DEL SARA SARA', 5),
(51, 'SUCRE', 5),
(52, 'VICTOR FAJARDO', 5),
(53, 'VILCAS HUAMAN', 5),
(54, 'CAJAMARCA', 6),
(55, 'CAJABAMBA', 6),
(56, 'CELENDIN', 6),
(57, 'CHOTA ', 6),
(58, 'CONTUMAZA', 6),
(59, 'CUTERVO', 6),
(60, 'HUALGAYOC', 6),
(61, 'JAEN', 6),
(62, 'SAN IGNACIO', 6),
(63, 'SAN MARCOS', 6),
(64, 'SAN PABLO', 6),
(65, 'SANTA CRUZ', 6),
(66, 'CALLAO', 7),
(67, 'CUSCO', 8),
(68, 'ACOMAYO', 8),
(69, 'ANTA', 8),
(70, 'CALCA', 8),
(71, 'CANAS', 8),
(72, 'CANCHIS', 8),
(73, 'CHUMBIVILCAS', 8),
(74, 'ESPINAR', 8),
(75, 'LA CONVENCION', 8),
(76, 'PARURO', 8),
(77, 'PAUCARTAMBO', 8),
(78, 'QUISPICANCHI', 8),
(79, 'URUBAMBA', 8),
(80, 'HUANCAVELICA', 9),
(81, 'ACOBAMBA', 9),
(82, 'ANGARAES', 9),
(83, 'CASTROVIRREYNA', 9),
(84, 'CHURCAMPA', 9),
(85, 'HUAYTARA', 9),
(86, 'TAYACAJA', 9),
(87, 'HUANUCO', 10),
(88, 'AMBO', 10),
(89, 'DOS DE MAYO', 10),
(90, 'HUACAYBAMBA', 10),
(91, 'HUAMALIES', 10),
(92, 'LEONCIO PRADO', 10),
(93, 'MARA&Ntilde;ON', 10),
(94, 'PACHITEA', 10),
(95, 'PUERTO INCA', 10),
(96, 'LAURICOCHA', 10),
(97, 'YAROWILCA', 10),
(98, 'ICA', 11),
(99, 'CHINCHA', 11),
(100, 'NAZCA', 11),
(101, 'PALPA', 11),
(102, 'PISCO', 11),
(103, 'HUANCAYO', 12),
(104, 'CONCEPCION', 12),
(105, 'CHANCHAMAYO', 12),
(106, 'JAUJA', 12),
(107, 'JUNIN', 12),
(108, 'SATIPO', 12),
(109, 'TARMA', 12),
(110, 'YAULI', 12),
(111, 'CHUPACA', 12),
(112, 'TRUJILLO', 13),
(113, 'ASCOPE', 13),
(114, 'BOLIVAR', 13),
(115, 'CHEPEN', 13),
(116, 'JULCAN', 13),
(117, 'OTUZCO', 13),
(118, 'PACASMAYO', 13),
(119, 'PATAZ', 13),
(120, 'SANCHEZ CARRION', 13),
(121, 'SANTIAGO DE CHUCO', 13),
(122, 'GRAN CHIMU', 13),
(123, 'VIRU', 13),
(124, 'CHICLAYO', 14),
(125, 'FERRE&Ntilde;AFE', 14),
(126, 'LAMBAYEQUE', 14),
(127, 'LIMA', 15),
(128, 'BARRANCA', 15),
(129, 'CAJATAMBO', 15),
(130, 'CANTA', 15),
(131, 'CA&Ntilde;ETE', 15),
(132, 'HUARAL', 15),
(133, 'HUAROCHIRI', 15),
(134, 'HUAURA', 15),
(135, 'OYON', 15),
(136, 'YAUYOS', 15),
(137, 'MAYNAS', 16),
(138, 'ALTO AMAZONAS', 16),
(139, 'LORETO', 16),
(140, 'MARISCAL RAMON CASTILLA', 16),
(141, 'REQUENA', 16),
(142, 'UCAYALI', 16),
(143, 'TAMBOPATA', 17),
(144, 'MANU', 17),
(145, 'TAHUAMANU', 17),
(146, 'MARISCAL NIETO', 18),
(147, 'GENERAL SANCHEZ CERRO', 18),
(148, 'ILO', 18),
(149, 'PASCO', 19),
(150, 'DANIEL ALCIDES CARRION', 19),
(151, 'OXAPAMPA', 19),
(152, 'PIURA', 20),
(153, 'AYABACA', 20),
(154, 'HUANCABAMBA', 20),
(155, 'MORROPON', 20),
(156, 'PAITA', 20),
(157, 'SULLANA', 20),
(158, 'TALARA', 20),
(159, 'SECHURA', 20),
(160, 'PUNO', 21),
(161, 'AZANGARO', 21),
(162, 'CARABAYA', 21),
(163, 'CHUCUITO', 21),
(164, 'EL COLLAO', 21),
(165, 'HUANCANE', 21),
(166, 'LAMPA', 21),
(167, 'MELGAR', 21),
(168, 'MOHO', 21),
(169, 'SAN ANTONIO DE PUTINA', 21),
(170, 'SAN ROMAN', 21),
(171, 'SANDIA', 21),
(172, 'YUNGUYO', 21),
(173, 'MOYOBAMBA', 22),
(174, 'BELLAVISTA', 22),
(175, 'EL DORADO', 22),
(176, 'HUALLAGA', 22),
(177, 'LAMAS', 22),
(178, 'MARISCAL CACERES', 22),
(179, 'PICOTA', 22),
(180, 'RIOJA', 22),
(181, 'SAN MARTIN', 22),
(182, 'TOCACHE', 22),
(183, 'TACNA', 23),
(184, 'CANDARAVE', 23),
(185, 'JORGE BASADRE', 23),
(186, 'TARATA', 23),
(187, 'TUMBES', 24),
(188, 'CONTRALMIRANTE VILLAR', 24),
(189, 'ZARUMILLA', 24),
(190, 'CORONEL PORTILLO', 25),
(191, 'ATALAYA', 25),
(192, 'PADRE ABAD', 25),
(193, 'PURUS', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_reclamo`
--

CREATE TABLE `sc_reclamo` (
  `idReclamo` int(11) NOT NULL,
  `correlativo` text COLLATE utf8_bin,
  `fechaReclamo` date DEFAULT NULL,
  `horaReclamo` time DEFAULT NULL,
  `tipoDoc` int(11) DEFAULT NULL,
  `nDoc` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `razonSocial` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `nombres` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `apellidoPat` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `apellidoMat` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `sexo` int(11) DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `telefono` text COLLATE utf8_bin,
  `departamento` int(11) DEFAULT NULL,
  `provincia` int(11) DEFAULT NULL,
  `distrito` int(11) DEFAULT NULL,
  `domicilio` text COLLATE utf8_bin,
  `tipoDocR` int(11) DEFAULT '0',
  `nDocR` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `nombresR` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `apellidoPatR` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `apellidoMatR` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `rsocialR` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `emailRep` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `domicilioR` text COLLATE utf8_bin,
  `telefonoR` text COLLATE utf8_bin,
  `regsRep` int(11) DEFAULT '2',
  `tipoUsuario` int(11) DEFAULT NULL,
  `fechaOcurrencia` date DEFAULT NULL,
  `derecho` int(11) DEFAULT NULL,
  `causaEspecifica` int(11) DEFAULT NULL,
  `detalleReclamo` text COLLATE utf8_bin,
  `estadoRec` int(11) DEFAULT '2',
  `etapaReclamo` int(11) DEFAULT '1',
  `resulRec` int(11) DEFAULT '1',
  `registroSistema` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `autogenerado` text COLLATE utf8_bin,
  `autoCorreo` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_reclamo`
--

INSERT INTO `sc_reclamo` (`idReclamo`, `correlativo`, `fechaReclamo`, `horaReclamo`, `tipoDoc`, `nDoc`, `razonSocial`, `nombres`, `apellidoPat`, `apellidoMat`, `sexo`, `email`, `telefono`, `departamento`, `provincia`, `distrito`, `domicilio`, `tipoDocR`, `nDocR`, `nombresR`, `apellidoPatR`, `apellidoMatR`, `rsocialR`, `emailRep`, `domicilioR`, `telefonoR`, `regsRep`, `tipoUsuario`, `fechaOcurrencia`, `derecho`, `causaEspecifica`, `detalleReclamo`, `estadoRec`, `etapaReclamo`, `resulRec`, `registroSistema`, `autogenerado`, `autoCorreo`) VALUES
(1, 'LR-2019-00001', '2019-07-13', NULL, 1, '70014912', NULL, 'SARA CRISTINA', 'CALDERON', 'WATANABE', 2, 'chinita_87_18@msn.com', '921844435', 15, 127, 1260, 'JR SAN JACINTO 263 SAN JUAN BAUTISTA', 1, '41836237', 'ANTHONY EUGENIO', 'MARCHAND', ' PAUCAR', NULL, 'chinita_87_18@msn.com', 'JR SAN JACINTO 263 SAN JUAN BAUTISTA', '921844435', 1, 1, '2019-07-13', 5, 20, 'A mi esposo el infectologo le dio una interconsulta para gastro con urgencia de lo cual le kisieron dar cita para el 21 de agosto y cuando fui a pedir una adicionsl no habia nadie absolutamente nadie en el consultorio de gastro, otras enfermeras y doctores de otras areas viendo con el inmenso dolor de mi esposo no atinaron hacer absolutamente nada y no me parece dable es un hospital y ellos estan trabajando minimo tienen k atenderlo unl tiene k esperar su gsna y encima no hay esa area totsl donde estan esos doctores', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(2, 'LR-2019-00002', '2019-08-26', NULL, 1, '41023258', NULL, 'YNGRID DALY', 'CHAVEZ', 'GUERRERO', 2, 'yngridchavezguerrero341@gmai.com', '983337506', 15, 127, 1251, 'JR.HUAYNA CAPAC MZ I LOTE 19 IV ZONA COLLIQUE COMAS', 1, '41023258', 'YNGRID DALY', 'CHAVEZ', 'GUERRERO', NULL, 'yngridchavezguerrero341@gmail.com', 'JR.HUAYNA CAPAC MZ I LOTE 19 COLLIQUE COMAS', '983337506', 1, 3, '2019-08-26', 13, 69, 'Que pésima la atención  de la sra que atiende la línea telefónica central 5580186 , le pregunte el dia de hoy acerca del costo de una operación y me responde otra cosa de mala manera  ,no presta atención  a la consulta realizada y corta la llamada ,vuelvo a llamar y vuelve a cortar  indicanfo que no puede atender ,es una falta de respeto si asi atienden a los futuros pacientes como sera a los enfermos.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(3, 'LR-2019-00003', '2019-09-26', NULL, 1, '41766344', NULL, 'CESAR ROBERTO', 'ARROYO', 'TOVAR', 1, 'danielgonzalesarroyo@yahoo.es', '987822164', 15, 127, 1251, 'PSJ JUAN MASIAS 180 URB MIRONES ALTOS - LIMA - LIMA', 1, '45440972', 'DANIEL ARMANDO', 'GONZALES', 'ARROYO', NULL, 'danielgonzalesarroyo@yahoo.es', 'CALLE CASAPALCA 1659 - URB CHACRA RIOS NORTE - LIMA - LIMA', '987822164', 1, 2, '2019-09-26', 3, 12, 'Ingrese por emergencia el día 06 de julio del 2019 por fractura expuesta de tibia derecha (según diagnóstico de mi historia clínica 1275409) me estabilizaron y por la noche me recetaron fijaciones (según receta 007-3923233 Dr. Jose Hinostroza) de metal la cuales fueron compradas por mi familiar (S/ 2100.00), estas fijaciones fueron colocadas al día sgts. 07.07.2019 por la tarde. En preocupación por mi salud mis consultas a los doctores fue que seguía después de las fijaciones ellos me indicaron que tenía que evolucionar, renegar la piel y subir mi hemoglobina, para luego hacer injerto (DR. AGUSTIN PECHO / DR. CARLOS FRANCO / DR. VICTOR AGUERO). Las semanas fueron pasando y mi familia colaboro en todo lo requerido: donación de sangre, compra de medicamentos fuera de los que el hospital brinda, colaboramos en todo.\nEl dia 03.08.2019 el Dr. Victor Agüero me realizo una limpieza QX, donde me indican que después de esta limpieza vendría el injerto.\nEl 15.08.19 el Dr. Agustin Pecho nos receta 06 clavos + 01 fijador (receta - 007-4030333) está para culminar con el proceso, con la indicación que se hará una reducción de 5 a 8 cm de hueso dañado, por mi salud y mi bienestar acepte, mi familiar tuvo que hacer de todo para conseguir el dinero y poder comprar lo solicitado (S/. 1400.00).\nPara fines de agosto 20.08.2019 el Dr. Victor Aguero nos solicita una placa ANGIO TEM (S/. 800.00) para el miembro inferior derecho, donde el hospital Sergio Bernales no la hace, esta tiene que ser tomada de forma particular y la familia tenía que coordinar con una ambulancia particular(S/ 320.00) para trasladar al paciente a sacar dichas placas (Centro de Lima Av. Grau) día 05.09.2019, esta placa para tener una mejor información de la pierna afectada.\nPosterior a esto los doctores me indican que la pierna tiene que ser amputada según informe médico, donde los doctores me indicaron que mi hueso estaba descalcificado y no iba soportar las fijaciones, nuestra indignación va por que tuvieron que esperar tanto tiempo, mi familia quiso obtener una segunda opinión acudiendo personalmente a otros especialistas dado que los del hospital Sergio Bernales no era del todo claro.\nAcudimos a SUSALUD el 06.09.2019 ya que los doctores no dieron fecha de operación, nos apoyaron y en esa semana los doctores se reúnen con mi familia e indican el hueso expuesto está infectado y podrido desde la quincena de agosto, que ellos tenían imágenes e informes donde detallan lo diagnosticado, mi familia solicito los informes e imágenes pero los doctores no dieron respuesta me refiero a los doctores encargado (Dr. Agustín Pecho). Mi familia tuvo que insitir para procedan con la operación. Nuevamente los doctores me volvieron a postergar  la operación desde el 15.09.2019 el 21.09.2019  donde en esa semana me tuvieron en ayunas no almorzando ni alimentándome debidamente, por el simple hecho de que me operen al día sgt. En fin mi operación fue hoy 26.09.2019, la pierna amputada, defraudado por no tener la información  y atención como debió de ser, me pregunto yo donde queda el juramento hipocrático.\nEstaremos procediendo con la denuncia y demanda correspondiente,\nSin más que mencionar  me despido\n\nAtte\nCesar Roberto Arroyo Tovar\nDNI 41766344\n', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(4, 'LR-2019-00004', '2019-11-12', NULL, 1, '64854342', NULL, 'JUAN', 'MONTES', 'MONTES', 1, 'jamm0710@gmail.com', '5772533', 15, 127, 1285, 'MZ B LOTE 20 SMP', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2019-11-11', 15, 76, 'internas de obstetricia (UAP) y medicina tienen sexo en cuartos.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(5, 'LR-2019-00005', '2019-12-07', NULL, 1, '73089437', NULL, 'LUZ VICTORIA', 'CURO', 'CCENCHO', 2, 'sunglvcc@gmail.com', '985777742', 15, 127, 1260, 'CALLE 29', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2019-12-07', 13, 69, 'Llame en dos oportunidades  para preguntar la primera tomo la llamada y me colgo ;y en la segunda la señora me atendio super horrible.\n\nLlame entre las 11:56 - 11:58 am \n', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(6, 'LR-2019-00006', '2019-12-09', NULL, 1, '6911628', NULL, 'JULIA', 'HUACCACHI', 'CARTAGENA', 2, 'lmhcontadoresyabogados@gmail.com', '983457228', 15, 127, 1260, 'JIRÓN CORBACHO N° 265 URBANIZACIÓN SANTA LUZMILA - COMAS', 1, '41184764', 'LUIS ENRIQUE ', 'MOTTA', 'HUACACHI', NULL, 'lmhcontadoresyabogados@gmail.com', 'JIRÓN CORBACHO N° 265 URBANIZACIÓN SANTA LUZMILA - COMAS', '983457228', 1, 1, '2019-12-09', 15, 76, 'El día de hoy, 9 de diciembre del 2019, a las 11:18am, nos acercamos a atención de emergencias del hospital porque se le había reventado una celulitis alojada en la parte superior del ombligo, donde presentaba secreción o también llamada \"pus\" por lo que  sentía bastante dolor mi señora madre; luego del procedimiento de admisión y toda la documentación realizada para su atención, nos acercamos a la división de cirugía, donde  atendió a mi madre el doctor IVÁN ROLI CONDOR ELIZARBE, Médico Internista con CMP N° 082338; cuando el doctor se prestaba a atender a mi madre, y al acostarla en la camilla, se dió cuenta que no había guantes quirúrgico, por lo que me mandó a comprar, yo con la finalidad que atiendan a mi madre fui enseguida, al regreso y luego de entregarle el guante; procedió a ejercer presión en la zona afectada y, al salir secreción y no habiendo nada para limpiarle la herida, otra vez me mandó a comprar gasa esterilizada, por lo que nuevamente fui a la farmacia a comprar, al regreso al hospital me encuentro con mi madre saliendo de cirugía llorando, y al preguntarle que había pasado, me manifestó que el mencionado doctor le estaba limpiando la herida, con el empaque del guante que antes había comprado, es decir, el doctor no esperó que trajera la gasa que él mismo me había mandado a comprar. Al confrontarlo por lo sucedido, sólo atinó a decir que no podía esperar mucho, porque era una sala de emergencia, eso fue todo lo que me dijo. Al pedirle su identificación, no me lo quiso dar, por lo que esperé que venga el médico de turno; la médico de turno hizo firmar a mi mamá una hoja de retiro voluntario de paciente, luego de firmar esta hoja, recién me dió el nombre del doctor.\nDebo decir, que es inaceptable el proceder de éste médico, ya que no tuvo mayor reparo en una adecuada atención médica, con los cuidados que se requiere, por lo que realizo la presente queja, y de ser necesario iré ante el mismo colegio médico del Perú para que se haga justicia y ´que éste médico reciba la sanción que amerita su actuación. \n', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(7, 'LR-2019-00007', '2019-12-14', NULL, 1, '76209786', NULL, 'MIGUEL ANGEL', 'CALLA', 'VALVERDE', 1, 'MCKLXJR@GMAIL.COM', '952109011', 15, 127, 1256, 'JR. ROSA DE AMERICA MZ 91B LOTE 01 - URB RAUL PORRAS BARRENECHEA CMTE 50', 1, '70781430', 'JEAN PIEER SMITH', 'CALLA', 'VALVERDE', NULL, 'MCKLXJR@GMAIL.COM', 'JR. ROSA DE AMERICA MZ 91B LOTE 01 - URB RAUL PORRAS BARRENECHEA CMTE 50', '952109011-934470866', 1, 1, '2019-12-13', 13, 65, 'DENUNCIA POR MALA PRAXIS, MALTRATO Y DISCRIMINACIÓN\n\nSEÑORES DEL HOSPITAL SERGIO BERNALES, LA PRESENTE PARA HACER MANIFIESTO MI INDIGNACIÓN\nY RECHAZO A LA ACTITUD DEL CIRUJANO DENTISTA LUIS SAHUARAURA ROMERO COP.35339 POR EL PÉSIMO TRATO HACIA\nMI HERMANO JEAN PIERRE SMITH CALLA VALVERDE Y MI MADRE NORMA YOLANDA VALVERDE VALVERDE EN SUS INSTALACIONES. SIENDO EL DÍA 13/12/2019 A LAS 3:30PM MI MADRE NORMA VALVERDE VALVERDE LLEVÓ A MI HNO. JEAN PIEER SMITH CALLA VALVERDE A SACARSE LA MUELA MEDIANTE EL SIS YA QUE MI HNO. TIENE UNA DISCAPACIDAD Y NO HABLA. ENTONCES EN LO QUE EL DR LE PONE LA ANESTESIA Y FORCEJEA PARA SACARLE LA MUELA, LE HACE DOLER A HNO PROVOCANDO QUE EL TENGA MIEDO A LO CUAL EL DR DE MANERA PREPOTENTE Y DISCRIMINATORIA LE GRITA A MADRE QUE YA NO LE TERMINARA DE ATENDER Y QUE SE LO LLEVE A OTRO HOSPITAL, DEJANDO TODO DE SANGRE Y CON LA MUELA YA TODA MOVIDA A MI HERMANO, QUEDANDO EL MUY ASUSTADO CON MIEDO INCLUSIVE DE ABRIR LA BOCA Y QUE LE VEAN, Y QUE CUANDO SE LE PASE LA ANESTESIA VA A SUFRIR CON EL DOLOR Y TODO EL MALESTAR, SE LES SOLICITÓ EL LIBRO DE RECLAMACIONES Y EN TODO MOMENTO ESTUVIERON PELOTEANDO A MI MAMÁ DICIENDO QUE VAYA A MESA DE PARTES, LUEGO A EMERGENCIA Y A LAS FINALES QUE NO ESTABA LA PERSONA ENCARGADA Y DEBÍAMOS VOLVER EL LUNES. SE QUE USTEDES NO RESPALDAN ESTE TIPO DE HECHOS Y YA SE HAN HECHO LAS DENUNCIAS EN EL HOSP. SERGIO BERNALES, LIBROS DE RECLAMACIONES, SUSALUD, SIS, CONADIS Y ESTE HECHO NO PUEDE QUEDAR IMPUNE Y QUE ESE \"PROFESIONAL\" RECIBA LAS SANCIONES CORRESPONDIENTES . DEJO MIS DATOS PARA QUE SE PUEDAN CONTACTAR CONMIGO.\nMIGUEL CALLA VALVERDE\nDNI: 76209786\nCEL: 952109011 / 934470866\nCORREO: MCKLXJP@GMAIL.COM', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(8, 'LR-2019-00008', '2019-12-14', NULL, 1, '9543780', NULL, 'NORMA YOLANDA', 'VALVERDE', 'VALVERDE', 2, 'NORMAYOLANDAVALVERDE@GMAIL.COM', '960517293', 15, 127, 1256, 'JR. ROSA DE AMERICA MZ 91B LOTE 01 - COMITE 50 - URB. RAUL PORRAS BARRENECHEA', 1, '70781430', 'JEAN PIEER SMITH', 'CALLA', 'VALVERDE', NULL, 'NORMAYOLANDAVALVERDE@GMAIL.COM', 'JR. ROSA DE AMERICA MZ 91B LOTE 01 - COMITE 50 - URB. RAUL PORRAS BARRENECHEA', '960517293', 1, 1, '2019-12-13', 9, 36, 'DENUNCIA POR MALA PRAXIS, MALTRATO Y DISCRIMINACIÓN\n\nSEÑORES DEL HOSPITAL SERGIO BERNALES, LA PRESENTE PARA HACER MANIFIESTO MI INDIGNACIÓN\nY RECHAZO A LA ACTITUD DEL CIRUJANO DENTISTA LUIS SAHUARAURA ROMERO COP.35339 POR EL PÉSIMO TRATO HACIA\nMI Y MI HIJO JEAN PIERRE SMITH CALLA VALVERDE EN SUS INSTALACIONES. SIENDO EL DÍA 13/12/2019 A LAS 3:30PM LLEVÉ A MI HNO. JEAN PIEER SMITH CALLA VALVERDE A SACARSE LA MUELA MEDIANTE EL SIS YA QUE ÉL TIENE UNA DISCAPACIDAD DE RETARDO LEVE Y NO HABLA. ENTONCES EN LO QUE EL DR. LE PONE LA ANESTESIA Y FORCEJEA PARA SACARLE LA MUELA, LE HACE DOLER A HNO PROVOCANDO QUE EL TENGA MIEDO A LO CUAL EL DR DE MANERA PREPOTENTE Y DISCRIMINATORIA LE GRITÁNDOME QUE YA NO LE TERMINARA DE ATENDER Y QUE SE LO LLEVE A OTRO HOSPITAL, DEJANDO TODO DE SANGRE Y CON LA MUELA YA TODA MOVIDA A MI HIJO, QUEDANDO EL MUY ASUSTADO CON MIEDO INCLUSIVE DE ABRIR LA BOCA Y QUE LE VEAN, Y QUE CUANDO SE LE PASE LA ANESTESIA VA A SUFRIR CON EL DOLOR Y TODO EL MALESTAR, SE LES SOLICITÓ EL LIBRO DE RECLAMACIONES Y ALGUIEN ENCARGADO PARA PONER MI DENUNCIA, Y EN TODO MOMENTO ESTUVIERON MANDANDO DE UN LUGAR A OTRO DICIENDO QUE VAYA A MESA DE PARTES, LUEGO A EMERGENCIA Y A LAS FINALES QUE NO ESTABA LA PERSONA ENCARGADA Y DEBÍAMOS VOLVER EL LUNES. SE QUE USTEDES NO RESPALDAN ESTE TIPO DE HECHOS Y YA SE HAN HECHO LAS DENUNCIAS EN EL HOSP. SERGIO BERNALES, LIBROS DE RECLAMACIONES, SUSALUD, SIS, CONADIS Y ESTE HECHO NO PUEDE QUEDAR IMPUNE Y QUE ESE \"PROFESIONAL\" RECIBA LAS SANCIONES CORRESPONDIENTES YA QUE NI SIQUIERA SABE PEDIR DISCULPAS Y LO DENUNCIARÉ PENALMENTE POR LOS DAÑOS PSICOLÓGICOS OCASIONADOS A MI HIJO . DEJO MIS DATOS PARA QUE SE PUEDAN CONTACTAR CONMIGO.\nNORMA YOLANDA VALVERDE VALVERDE\nDNI: 09543780\nCEL: 960517293\nCORREO: NORMAYOLANDAVALVERDE@GMAIL.COM', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(9, 'LR-2019-00009', '2019-12-30', NULL, 1, '40542570', NULL, 'JANETT', 'MALDONADO', 'SANTARIA', 2, 'iarc_77@outlook.com', '980897481', 15, 127, 1260, 'JR. MARIANO MELGAR MZ A LOTE 12', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2019-12-30', 3, 12, 'Mi familiar ingreso a las 6:00 am el detalle es que ingresó por emergencia y pidiéndonos una serie de medicamentos, dentro de ello examen de tomagrafia los cuales los medicamentos no son utilizados y supuestamente deben intervenir la quirúrgicamente y no hay médico son las 7:30 pm y estamos esperando, no es justo. ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(10, 'LR-2020-00001', '2020-01-06', NULL, 1, '80061514', NULL, 'JUSTINA FAUSTA', 'JARA', 'PINEDA', 2, 'karincamposobregon@gmail.com', '936498552', 15, 127, 1260, 'JR. CIRO ALEGRIA 230 COLLIQUE COMAS', 1, '9479739', 'PATRICIA', 'OBREGON', 'JARA', NULL, 'karincamposobregon@gmail.com', 'JR. CIRO ALEGRIA 230 COLLIQUE COMAS', '936498552', 1, 1, '2019-12-13', 9, 48, 'EEL DÍA 13/12/2019 SIENDO LAS 04:00PM MI MAMÁ ASISTIÓ A LA CITA DE TERAPIA FÍSICA A CARGO DE LA SRA. CAMACHO QUISPE VIRGINIA CONSUELO, DURANTE LA SESIÓN, ESTÁ SEÑORA SE MOSTRO DISTRAIDA, YA QUE ATENDÍA A MÁS DE UN PACIENTE A LA VEZ, Y AL APLICAR LA COMPRESA CALIENTE EN EL HOMBRO DERECHO DE MI MAMÁ, ELLA SINTIÓ UN FUERTE DOLOR Y QUEMAZÓN AVISANDO DE INMEDIATO A LA SEÑORA, SIN EMBARGO ELLA RESPONDE \"ASÍ ES LA TERAPIA DEBE AGUANTAR\",  ADEMÁS LE PIDIÓ QUE SE MANTENGA CON LA COMPRESA POR UN TIEMPO DE 25MIN APROX, AL TÉRMINO DE LA SESIÓN, Y VER LAS HERIDAS OCASIONADAS PRODUCTO DE LA QUEMADURA, REALIZÓ UNA FROTACIÓN EN LA ZONA, OCASIONANDO QUE LAS AMPOLLAS POR QUEMADURAS SE ABRAN ÁUN MÁS, Y SIN DARLE NINGUNA ATENCIÓN INMEDIATA, SINO MÁS BIEN AMENAZANDO QUE SI RECLAMA YA NO LE ATENDERÁ Y PERDERÁ LAS DEMÁS CITAS,  POR TAL MOTIVO  EXIJO QUE SE INVESTIGUE EL ACCIONAR DE ESTA SEÑORA QUE NO MERECE LLAMARSE PROFESIONAL, POR SU PÉSIMA CALIDAD DE ATENCIÓN, MALTRATO. ASIMISMO, PIDO SE HAGA EL LLAMO DE ATENCIÓN Y DE SER POSIBLE LA ROTACIÓN, ASIMISMO, AL CONVERSAR CON LOS ENCARGADOS DEL HOSPITAL, NEGARON A MI MADRE LA ATENCIÓN EN EL SERVICIO DE DERMATOLOGIA U OTRA ESPECIALIDAD,  POR TENER SIS, INDICANDO QUE DEBE IR A LA  POSTA DE SALUD PARA HACER TRAMITES, NO OBSTANTE AL ACUDIR CON EL PERSONAL DE SUSALUD, CONSEGUIMOS QUE SEA ATENDIDA POR EL AREA DE CIRUGIA PLÁSTICA DEL MISMO HOSPITAL SIN HACER NINGÚN TRÁMITE. EXIJO UNA PRONTA SOLUCIÓN, PRIMERO LA REPROGRAMACIÓN DE LA CITA DE TERAPIA FISICAS FALTANTES, ASI COMO EL CAMBIO DE TERAPISTA Y LA ATENCIÓN INTEGRAL A MI MAMÁ POR TODOS LOS DAÑOS OCASIONADOS POR ESTA SEÑORA.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(11, 'LR-2020-00002', '2020-01-27', NULL, 1, '43671100', NULL, 'LADY ', 'SIFUENTES', 'COTRINA', 2, 'lbsifcot@gmail.com', '968565568', 15, 127, 1260, 'MZB1LOTE 30', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2020-01-27', 3, 11, 'Vine a tramitar un certificado de salud, el día sábado 25 del presente quise ser atendida por la ventanilla de laboratorio externo el personal debería atender 7:15 como dice su aviso pero llegaron a las 8:30. He vuelto el día lunes 27 a recoger mis resultados y ocurre lo mismo son las 8:00 am y el personal no llega.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(12, 'LR-2020-00003', '2020-02-07', NULL, 1, '41312747', NULL, 'VERONICA JULISSA ', 'FACUNDO', 'GUERRERO', 2, 'obst.facundo2018@gmail.com', '934839225', 15, 127, 1267, 'MZBBB2LOTE2 CALLE 53 URBANIZACIÓN LA FLORESTA DE PRO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2020-02-03', 13, 69, 'El día 16 de febrero del presente año presente una solicitud al área de docencia para realizar una pasantía de 150 horas en el servicio de obstetricia de dicho hospital la cual me denegaron por haber hecho un reclamo al trato que se me dio al informarme el avance de mi documento ,me siento mortificada que el día 6 me acerco a mesa de partes donde han tomado represalias en mi contra denegando mi pedido donde ya se obtuvo la aceptación del jefe de gineco obstetricia informando q no había campo para realizar ,pero a 4 colegas que también presentaron el mismo día les dieron la configuración positiva pero a mí persona no solo por haber levantado mi voz de protesta eso me parece injusto ya que espere como  más de 20 días en respuesta teniendo todos mis documentos en regla y pruebas de ello .', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(13, 'LR-2020-00004', '2020-02-10', NULL, 1, '70761914', NULL, 'ANGEL JESÚS ', 'CCANTO', 'GAMBOA', 1, 'darkangel_541_3@hotmail.com', '924574451', 15, 127, 1260, 'AVENIDA REVOLUCIÓN 940 - 942', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2020-02-10', 13, 66, 'Estoy en la ventanilla de rayos x y la señorita que se encargaba de la atención estuvo sin hacer nada por 10 minutos, a pesar de que toque para pedir que me atiendan por el dolor que tengo en la columna y la espalda por haber sido atacado por piedras por rateros. ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(14, 'LR-2020-00005', '2020-02-10', NULL, 1, '76428866', NULL, 'MARCO ANTONIO', 'CUADROS', 'CUBAS', 1, 'marco.cubas@outlook.com', '933742834', 15, 127, 1260, 'AH LOS JARDINES MZ A - LT 1 - NUEVA ESPERANZA - 3RA ZONA DE COLLIQUE', 1, '40563394', 'MARCO ANTONIO ', 'CUBAS', 'CUADROS', NULL, 'marco.cubas@outlook.com', 'AV. JOSE CARLOS MARIATEGUI NO 300', '933742834', 1, 1, '2020-02-08', 15, 76, 'Mi sobrino fue operado de apendicitis el dia 08/02/2020 por emergencia. Es una verguenza que el hospital no cuente, con guantes, bisturí, hilos y demás instrumentos y medicamentos para la operación. Se supone que el SIS cubre los medicamentos. Tuve que comprar esos medicamentos en farmacias particulares asumiento un costo de 300 soles, que el sis debió de cubrir, porque deben contar con esos instrumentos y medicamentos. Es una verguenza total que un hospital nacional no tenga medicamentos. Cuando uno se acerca a farmacia del hospital y les pregunta para ver si hay o no stock, te tratan mal y te dicen no hay, donde esta la transparencia en los servicios. Yo necesito la devolucion de lo gastado.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(15, 'LR-2020-00006', '2020-02-14', NULL, 1, '4637768', NULL, 'ROSA GISELA', 'GUZMÁN', 'GARIBAY', 2, 'gisela.gzmng@gmail.com', '954125241', 15, 127, 1260, 'JR. EDUARDO CORREO MZ D1 LOTE17 STA LUZMILA', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-02-14', 13, 69, 'Buen día. El día de hoy llame al 5580156 para consultar sobre el nombre de un doctor que atendería a mi madre rosa gribay dni 06121269 por un tema Oncológicos recibiendo una total mal trato via telefónico por la apaciencia de la señora que contesto. \nFavor de tomar la debida llamamda de atención por ser de justicia y derecho una atencion apropida a los pacientes.\n', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(16, 'LR-2020-00007', '2020-03-05', NULL, 1, '21257959', NULL, 'DAGOMAR RAUL', 'SUAREZ', 'LEON', 1, 'hgsf_2012@hotmail.com', '989627569', 15, 127, 1256, 'CALLE 11 MZ G1 LOTE 12 3RA ETAPA URB. SANTO DOMINGO', 1, '41364110', 'HENRY GABRIEL', 'SUAREZ', 'FERNANDEZ', NULL, 'hgsf_2012@hotmail.com', 'CALLE 11 MZ G1 LOTE 12 3RA ETAPA URB. SANTO DOMINGO', '989627569', 1, 1, '2020-03-05', 9, 37, 'REALIZO EL PRESENTE RECLAMO POR RAZONES EN LAS QUE MI SR PADRE AL HABER SIDO INTERNADO EN ESTE HOSPITAL  COLLIQUE TRAS EL IMPACTO DE BALA, RESULTA QUE LOS GALENOS LYNN MALLQUI  Y ANDRÉS ESTACIO EN OMISIÓN A SUS FUNCIONES INDICAN QUE NO PROCEDE OPERACIÓN PORQUE NECESITAN UNA ORDEN JUDICIAL INCURRIENDO EN DELITO. POR LO QUE SOLICITO A UDS SU PRONTA INTERVENCIÓN EN EL PRESENTE CASO DADA LA SITUACIÓN GRAVE DE SALUD POR LA QUE ATRAVIESA MI SR PADRE, DESANGRÁNDOSE Y SIN TENER POR PARTE DEL HOSPITAL UN DIÁGNOTISCO CLARO SOBRE SU CASO, Y PARA COLMO DE MALES ME HAN NOTIFICADO QUE LE DARÁN DE ALTA PORQUE LA BALA NO HA COMPROMETIDO LA PARTE ÓSEA. ES INSÓLITA DICHA RESPUESTA SI EL PROYECTIL ESTÁ EN SU CUERPO Y AÚN ESTÁ DESANGRÁNDOSE.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(17, 'LR-2020-00008', '2020-03-12', NULL, 1, '29538263', NULL, 'MICHAEL', 'GALDOS', 'OJEDA', 1, 'galdos.michael@gmail.com', '.36665980', 15, 127, 1267, 'CALLE LAS ACACIAS 989 ', 1, '41435456', 'FANNY LOURDES', 'PEÑA', 'PALACIOS', NULL, 'galdos.michael@gmail.com', 'LAS ACACIAS 989 LOS OLIVOS ', '936665980', 1, 3, '2020-03-12', 3, 8, 'Hoy nos apersonamos a las 8:30 pm por la carpa que tienen instalada al ingreso para que a la sra Fanny Peña le descarte la infección por el Corona virus , luego de la consulta los médicos determinaron que si sería necesario que le tomen la muestra, nos explicaron que esto tomaría hasta 4 horas de espera y esto que es la única paciente en espera de esta muestra ,indico la médico de turno que no contaban con personal y que además había temor de hacer está toma de muestra por parte del personal , son las 13:30 horas y no realiza la muestra ... La Sra Fanny tiene fiebre de 38 no le an proporcionado no una pastilla y seguimos esperando le hagan la muestra \nEn este acto hay incumplimiento de funciones de parte del personal médico por qué a la fecha  que puede ser más importante que tomar una muestra del corona virus .... Nos retiraremos sin la toma bajo responsabilidad penal del personal encargado por qué al no cumplir sus funciones nos obligan a retirarnos con la consecuencia de que el virus sea expaecido a la población por no haber  realizado su trabajo adecuadamente\nQueda en responsabilidad funcional de los medicos cuerpo técnico y del director del hospital las consecuencias de estos actos de incumplimiento de funciones', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(18, 'LR-2020-00009', '2020-04-19', NULL, 1, '09503565', NULL, 'ENRIQUE JORGE', 'SAMANIEGO', 'PUMA', 1, 'elizabeth1833@hotmail.com', '991914545', 15, 127, 1261, 'MZ R LT 9 1RA ZONA EL AGUSTINO ', 1, '42711910', 'ELIZABETH FLOR', 'GARAY', 'QUINTANILLA', NULL, 'elizabeth1833@hotmail.com', 'AV SAN GERMAN 944', '991914545', 1, 3, '1969-12-31', 9, 39, 'ESTIMADOS SEÑORES MI TIO FUE A TOMARSE LA PRUEBA DE COVID19 EL DÍA 17/04/20 Y DIJERON QUE EL SÁBADO LLAMARÍAN Y NADA Y SE FUE HASTA EL MISMO HOSPITAL PARA AVERIGUAR Y SOLO RESPONDE QUE LOS LLAMEN DE UNA FORMA DÉSPOTA UN MALTRATO A LAS PERSONAS QUE FUIMOS EXPONIENDO ASI NUESTRA SALUD ,SEÑORES MI TIO TIENE 75 AÑOS EL VIVE SOLO MI TIA DE BUEN CORAZON LO ACOGIO EN SU CASA PARA APOYARLO EN ESTA CUARENTENA SIENDO ELLA MUY HUMILDE Y AL DIA SIGUENTE NOS INFORMARON QUE SU HIJO DIO POSITIVO AL COVID ,MI TIA QUE VIVE EN CARABAYLLO ESTA DESESPERADA YA QUE AHI VIVEN 3 FAMILIAS MAS Y HAY NIÑOS Y ADULTO MAYOR PORFAVOR  SEAN MAS CONCIENTES LLAMEN PARA SABER EL RESULTADO ,USTEDES DICEN QUEDEN EN CASA PERO CON ESTO COMO QUEDARSE SIN RESPUESTA ,ES ALARMANTE SI SALIO POSITIVO MIRE CUANTOS YA ABRA CONTAGIADO EN EL CAMINO AL HOSPITAL PORFAVOR AYUDA ,  LLAMEN ,GRACIAS ', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(19, 'LR-2020-00010', '2020-04-20', NULL, 1, '07132913', NULL, 'MARIELLA ', 'MORALES', 'LEIVA', 2, 'gemenis_20@hotmail.com', '994727426', 15, 127, 1270, ' CALLE  PEDRO  DRINOT 385 DPTO 311', 1, '07132913', 'MARIELLA DEL CARMEN', 'MORALES', 'LEIVA', NULL, 'gemenis_20@hotmail.com', 'CALLE  PEDRO  DRINOT 385 DPTO 311', '994727426', 1, 1, '2020-04-14', 9, 48, 'Mi,hermano WALTER MORALES LEIVA  ingreso  por diagnostico  de COVID19, el 13  de abril del  presente año, no  se le  está  atendiendo, con  el  protocolo que  según  difunde  el  Presidente  de  la República, lo  tiene  abandonado.   El médico ha solicitado  medicina   para  que  compre   pero  ninguna  persona  encargada  no  ha  comunicado al familiar   para  que  compre  a  tendido  que llamar  el paciente para  decir  que  esta abandonado  varios días sin  medicina  , esta  abandonado  a  su  suerte ,     esperando  que  se  muera para  luego llamar   a  su  familiares y decirle  no  pudo  con  el tratamiento.  Ahora  esta en UCI ,para  decir  que  no  responde  el tratamiento  cuando lo  han  tenido  abandonado  sin  ningún tratamiento.  Es un  abandono  total  , también  pidieron  accesorio de limpieza para  el  paciente  , los familiares  enviaron y  nunca  llego los accesorio de limpieza . Ahora  que ya  esta en unidad de cuidados críticos   recién llama para  decir   que  su  estado  es  crítico  cuando   el personal  de Comando Covid19  loa  tenido      abandonado  sin  medicina  y  sin tratamiento.  ', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(20, 'LR-2020-00011', '2020-05-06', NULL, 1, '46000819', NULL, 'LUIS ALFONSO ', 'RIOS', 'COTRINA', 1, 'lrios.rc@gmail.com', '954763425', 15, 127, 1260, 'PASAJE DANIEL ALCIDES CARRION MZ C8 LT8 - AAHH 11 DE JULIO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2020-05-05', 15, 76, 'Por la mala informacion que brindan para la postulacion del CAS 27-2020 donde piden enviar los dcocumentos que solicitan al correo institucional dirección@hnseb.gob.pe  el cual tiene problemas para recibir los mensajes o simplemente no existe por una mala descripcion del correo intencional o aproposito , por este motivo no pude hacer llegar mis documentos para la postulacion de ese cas 27-2020 ya que salio error de destinatario, es un error que no debe pasar por alto gracias', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(21, 'LR-2020-00012', '2020-05-16', NULL, 1, '10195062', NULL, 'ROSADELFA CELINA', 'HUERTA', 'CHAGUA', 2, 'rhch299@gmail.com', '965957406', 15, 127, 1285, 'CALLE SANTA CRUZ MZ. A LT. 3 VIÑAS II DE NARANJAL-SMP. ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-04-27', 15, 76, 'Demora en la cremacion de mi madre PAULA. CHAGUA VALDEZ fallecida el 27/04/2020 al no ubicar su cuerpo por existir desorden en la cámara de refrigeración del Hospital Sergio Bernales', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(22, 'LR-2020-00013', '2020-05-17', NULL, 1, '42818533', NULL, 'ANALI', 'MAYO', 'RUBINA', 2, 'analimourine@gmail.com', '992616907', 15, 127, 1260, 'JR CLORINDA MÁLAGA 129 KM 12', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-05-01', 3, 9, 'Buenas tardes soy una paciente oncologíca que hace dos meses y medio no recibo mis quimioterapias, de acuerdo al ministerio de salud ningún paciente que recibe quimio su tratamiento no ha debido de parar. Exijo mi atención soy una paciente con cáncer, ni es posible esa negligencia por parte de este hospital.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(23, 'LR-2020-00014', '2020-06-11', NULL, 1, '40005182', NULL, 'GISSELA', 'MIRANDA', 'SALAS', 2, 'gisselamirandasto@gmail.com', '964983032', 15, 127, 1260, 'JR SAN IGNACIO #336', 1, '40005182', 'GISSELA', 'MIRANDA', 'SALAS', NULL, 'gisselamirandasto@gmail.com', 'JR SAN IGNACIO#336', '964983032', 1, 1, '2020-06-10', 9, 48, 'Señores del hospital Sergio Bernales \nHago responsable al Dr Orlando Herrera Alania\nPor su errada desicion de cerrar el area de quimio y no tener un ambiente oncologico \nHago responsable a dicho doctor si mi salud empeora y cometer un acto de negligencia\nAtte :Gissela', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(24, 'LR-2020-00015', '2020-08-14', NULL, 1, '10881946', NULL, 'ROGER ENRIQUE', 'DIAZ', 'MORALES', 1, 'roger1088enrique@gmail.com', '992482972', 15, 127, 1260, 'AV MIRAFLORES 1321 KM11 LA LIBERTAD COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-03-04', 9, 46, 'Reclamo sobre mi resognancia Magnética con contraste desde la fecha 4/3/2020 ingresado por la srta se susalud elizabeth y ingresado en referencias de las cuales hasta el día de hoy estoy peor no puedo caminar susalud intervino con denuncia de las cuales no contestan los teléfonos solicito cerebridad posible sobre mi resognancia Magnética con contraste solicitado por el dr Jesús incaluque succa de neurocirugía ya que no quiso firmar ni poner fecha por último en las órdenes solicitadas de referencia ni informe médico ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(25, 'LR-2020-00016', '2020-08-18', NULL, 1, '10881946', NULL, 'ROGER ENRIQUE', 'DIAZ', 'MORALES', 1, 'roger1088enrique@gmail.com', '992482972', 15, 127, 1260, 'AV MIRAFLORES 1321 KM11 LA LIBERTAD COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-03-06', 3, 13, 'RECLAMO POR SERVICIO DE NEUROCIRUGIA POR EL DR JESUS INCALLUQUE DIAGNOSTICO Y REFERENCIA PARA RESOGNANCIA MAGNETICA CON CONTRASTE ATENDIDO EN REFERENCIA DE HOSPITAL COLLIQUE Y REGISTRADA POR LA SRTA ELIZABETH DE SUSALUD EN EL SISTEMA DE SUSALUD Y SIS AL DIA DE HOY NO FIGURA EN NINGUN SISTEMA SOLICITO CELEBRIDAD Y CALIDAD DE SALUD YA QUE ESTOY DELICADO POR MISMO MAL DE HERNIA DISCAL SEVERA NO PUEDO CAMINAR DISGNOSTICADO POR EL MISMO DR NEUROCIRUJANO Y COVID 19 NEUMONIA PULMONAR SOLICITO SE DE PRIORIDAD MI CASO DE RESOGNANCIA MAGNETICA POR DOLORES MUY INTENSOS QUE ME AQUEJAN Y SIQUIATRIA POR QUERERME QUITAR LA VIDA EN REITERADAS OPORTUNIDADES', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(26, 'LR-2020-00017', '2020-08-25', NULL, 1, '7121320', NULL, 'JORGE ALBERTO', 'ALDANA', 'CAMPOS', 1, 'jorgealberto.aldanacampos@gmail.com', '997553109', 15, 127, 1285, 'AV. CANTA CALLAO MZ. V LT. 9', 1, '48167744', 'ROSELIND MARCELA', 'ALDANA', 'AMAU', NULL, 'roselind1126@gmail.com', 'AV. CANTA CALLAO MZ. V LT. 9', '16777092', 1, 1, '2020-08-13', 4, 16, 'El médico y la enfermera de emergencias nos informaron que el paciente, mi papá, dió Igg reactivo a la prueba rápida Covid y nos llevaron a un área aparte dónde colocaban a los pacientes que daban positivo a la prueba rápida, luego de haber estado más de 8 horas en el patio. Sin embargo, al ver en la página del INS el resultado de mi papá figura como negativo. Es decir, nos expusieron en un área de personas positivas a Covid, sin estar mal de ello.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(27, 'LR-2020-00018', '2020-09-05', NULL, 1, '43615409', NULL, 'ERIKA', 'VILLARREAL', 'DE LA CRUZ', 2, 'alex.adosh.20@gmail.com', '993901199', 15, 127, 1285, 'MZD LOTE 4 EL ROSAL DE SAN DIEGO ', 1, '43615409', 'ERIKA', 'VILLARREAL', 'DE LA CRUZ', NULL, 'alex.adosh.20@gmail.com', 'MZD LOTE 4 EL ROSAAL DE SAN DIEGO N', '993901199', 1, 1, '2019-04-01', 15, 76, 'Quisiera que se hagan cargo de todo su tratamiento de mi bb ', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(28, 'LR-2020-00019', '2020-09-28', NULL, 1, '47155080', NULL, 'IVON JOSSELYN', 'CISNEROS', 'OCHANTE', 2, 'lindaydulce77@gmail.com', '966446417', 15, 127, 1260, 'AV.INDUSTRIAL 230 URB EL ALAMO COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-09-11', 15, 76, 'El día 11 de setiembre del 2020 fui al hospital Sergio Bernales de collique y me mandaron a sacar una una resonancia magnética y de las cuales me hicieron pagar 810 soles y de ahí me hicieron todos los procedimientos me sacaron la prueba del Covic 19  y salió positivo y estoy muy indignada porque la resonancia magnética los hicimos particularmente y yo quiero que por favor que sea justicia y que me hagan la devolución de mi dinero porque la verdad hemos gastado mucho y no me parece justo que en el hospital me hagan pagar ese monto mi esposo por la desesperación lo pago pero ahora yo quiero que me devuelvan mi dinero por favor  y que se haga justicia ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(29, 'LR-2020-00020', '2020-10-02', NULL, 1, '9991641', NULL, 'GLORIA SALOME', 'VILLANUEVA', 'ROJAS', 2, 'gloria.gvr81@gmail.com', '942373403', 15, 127, 1260, 'AV GUILLERMO DE LA FUENTE # 420 SANTA LUZMILA', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-10-02', 5, 21, 'Soy paciente Oncologica, y he intentado todo este tiempo en sacar cita con la Doctora Martínez,la cual es mi doctora de cabecera desde el inicio de todo el tratamiento.. y no he podido sacar cita, porque no figura en la wed las citas de Oncología médica, es que, ¿acaso no le importamos al Doctor Herrera ? ¿porque no está la Doctora Martínez? tengo que seguir un tratamiento ... y durante todo, este tiempo de cuarentena me estaba atendiendo virtualmente, conforme al ministerio de salud y a las ordenanzas de Gobierno por medidas de seguridad. Es necesario, y exijo una pronta respuesta a mi molestia por no tener una cita con la doctora,la cual deberia figurar en la wed de atención de citas, tengo que seguir el tratamiento. ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(30, 'LR-2020-00021', '2020-10-04', NULL, 1, '41223002', NULL, 'LUIS BELISARIO', 'CONDORI', 'CARCACI', 1, 'billydol_81@hotmail.com', '948316308', 15, 127, 1275, 'MZ  T  LOTE 57 2DA  EXPLANADA  LADERAS  DEL CHILLON', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-09-17', 15, 76, 'El 17 de setiembre de 2020 presente una solicitud de mesa de partes virtual, el cual me indicaron vía whatsapp que demoran en contestar 7 días hábiles, a la fechas son más de  10 días hábiles, cuando he llamado al  anexo 302 de mesa de partes me indicaron que el personal del área administrativo no trabaja, que sólo a veces y que mañana siga insistiendo de 8am a 3pm. Por favor,  entiendo que es una entidad del estado y siendo del sector de salud deberían de dar la prioridad del caso, para no exponernos en una asistencia presencia siendo una persona vulnerable. Espero puedan atender mi solicitud a la brevedad posible.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(31, 'LR-2020-00022', '2020-10-12', NULL, 1, '40386007', NULL, 'GIOVANA MARIA', 'TADEO', 'ARRIETA', 2, 'mariatadeo@gmail.com', '959761127', 15, 127, 1256, 'PROLONGACIÓN MRCAL OSCAR R BENAVIDES 194 P.J. EL PROGRESO 2DO SECTOR', 1, '77774406', 'KARLA ALOMDRA', 'RAMOS', 'TADEO', NULL, 'alomdrakk026@gmail.com', 'PROLONGACIÓN MRCAL OSCAR R BENAVIDES 117 P.J. EL PROGRESO 2DO SECTOR', '959761127', 1, 1, '2020-10-08', 12, 58, 'Buenos días mi mamá es paciente oncológica y ya tuvo su cita el día jueves con su doctora pero estuve llamando desde ese mismo día y hasta ahora no me responden mi mamá no puede estar sin sus medicinas, deberían contestar los teléfonos quizás no es la única que este pasando por lo mismo, seguro habrá mas pacientes iguales pero tengan LA AMABILIDAD si la tienen que contestar ese teléfono. ya mi mamá estuvo varios meses sin su medicina pero ahora ya no así que espero que puedan contestar HOY  sus teléfonos para que pueda recoger sus MEDICINAS lo antes posible. Gracias, solucionen ese problema  de no contestar. ', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(32, 'LR-2020-00023', '2020-10-14', NULL, 1, '6929931', NULL, 'RENE', 'CASTILLO', 'TRELLES VDA DE ROSAS', 2, 'rosasjoselito@gmail.com', '947832769', 15, 127, 1260, 'JR MANUEL GONZALES PRADA 136 / 1RA ZONA DE COLLIQUE', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-10-14', 12, 64, 'El día de hoy me acerque a recoger a farmacia mi telereceta  y me indicaron que no tienen NEVIBOLOL 5MG y me dijeron que solo tienen vencido el medicamento. Cuando fui días atrás dijeron que si tenían para venta, pero que se necesita receta. Y a la receta de hoy no le marcaron NO SE ENTREGO al medicamento en mención y parece como si lo hubieran entregado. Son muchas irregularidades con medicamentos caros, por favor auditarlos.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(33, 'LR-2020-00026', '2020-11-04', NULL, 1, '45720258', NULL, 'ZAIDA FIORELLA', 'ITURRIZAGA', 'VALENCIA', 2, 'zaida.iturri@hotmail.com', '921078985', 15, 127, 1260, 'AV ALFONZO UGARTE LOTE 8 COMIRE 92 AÑO NUEVO ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-11-04', 3, 8, 'Llegue al hospital por emergencia a las 11:50 de la mañana soy gestante , le expliqué que siento mucho dolor y que tengo deseos de orinar a cada momento y picazón , le expliqué que ya me dieron un tratamiento anterior pero que de la misma manera sigo con las molestias y que el día de hoy empeoró no puedo dormir ni caminar porque duele , ella me respondía la será que te hace las preguntas la que te recibe en la puerta porque no saben cual es su nombre , me dijo que no es una emergencia que regrese mañana porque se me ve bien , a lo que yo le respondí me está negando la atención y me dijo no solo te decía mejor vienes mañana temprano y yo le dije pero me duele va donde el doctor y el le dice recién viene a las 2 de la mañana dile que espere , ya habiendo explicado que soy diabética ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(34, 'LR-2020-00027', '2020-11-04', NULL, 1, '45720258', NULL, 'ZAIDA FIORELLA', 'ITURRIZAGA', 'VALENCIA', 2, 'zaida.iturri@hotmail.com', '921078985', 15, 127, 1260, 'AV ALFONZO UGARTE LOTE 8 COMITE 92 AÑO NUEVO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-11-04', 3, 8, 'Continuando el reclamo la srta me realizó preguntas incómodas de forma sarcástica hacia otra paciente y el de seguridad me preguntaba cuántas parejas eh tenido , a que edad comenze a tener relaciones , y cuántas parejas eh tenido y si todo los abortos que eh tenido ha sido del mismo hombre o diferentes parejas , el día de ayer tuve una crisis por intento de suicidio soy una paciente psiquiatrica que no está tomando . medicamentos por el embarazo , el motivo de mi crisis es por el dolor que siento de mi embarazo pienso en matarme porque no soporto y sus preguntas me hicieron sentir mal y comencé a llorar ahí­ sola en silencio porque me mandó a esperar más allá¡ , hasta ahora sigo esperando y no me brinda atención tengo dolor y me siento mal pero no resido atencion.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(35, 'LR-2020-00028', '2020-11-06', NULL, 1, '42024087', NULL, 'JUAN MANUEL', 'JUAPE', 'KU', 1, 'juantlv13@gmail.com', '942813848', 15, 127, 1260, 'AH AÑO NUEVO MZ N5 LT.42', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-11-04', 12, 58, 'Soy un paciente con problemas cronicos relcionados con diavetes y anemia megaloblastica tube una cita por oncologia el dia 4/11/2020 doctor receto vitaminas y hasta ahora no recibo correo ni respuesta para recoger y me siento mal de salud por favor nesecito una respuesta a mi caso y tambien me mandaron interconsulta por hematologia que no encuentro en doctor fast', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(36, 'LR-2020-00029', '2020-11-09', NULL, 1, '6039807', NULL, 'HUMBERTO', 'SILVA', 'ROJAS', 1, 'han.ter65@hotmail.com', '995058211', 15, 127, 1251, 'AV. LUIS BRAILLE 1394, DPTO.901', 1, '72606483', 'RICARDO HUMBERTO', 'SILVA', 'BALLADARES', NULL, 'eliballadares@hotmail.com', 'AV. LUIS BRAILLE 1394, DPTO. 901', '964978048', 1, 3, '2020-08-10', 15, 76, 'Mi papa fallecio el 31 de julio por covid19 y el 10/8/2020 solicite la copia de su historia clínica y hasta hoy no me la entregan y la necesito para activar seguros de desgravamen con urgencia', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(37, 'LR-2020-00024', '2020-10-31', NULL, 1, '42024087', NULL, 'JUAN MANUEL', 'JUAPE', 'KU', 1, 'juantlv13@gmail.com', '942813848', 15, 127, 1260, 'AH AÑO NUEVO MZ N5 LT.42', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-11-04', 9, 36, 'Me apersoné al Hospital Sergio Bernales por el área de emergencia porque me sentía mal me dirigí al área de tópico para que me revisaran porque me sentíal mal y cansado el doctor que me atendió ni siquiera me tomó la presión no me revisó para nada me indicó que debía sacar consulta por Dr Fast que lo mío era crónico pues estoy disconforme porque ni siquiera me revisó para ver como estaba por eso impongo que no actuó de forma correcta el doctor.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(38, 'LR-2020-00025', '2020-11-02', NULL, 1, '32845972', NULL, 'MARIA JESUS', 'CONCHA', 'SAYAGO', 2, 'dama23021379@gmail.com', '949271520', 15, 127, 1256, 'PRADERAS DE PUNCHAUCA MZ. B LTE.12', 1, '70283408', 'MAITTE ALISON', 'PARDO', 'HONORES', NULL, 'pardomaitte@gmail.com', 'PRADERAS DE PUNCHAUCA MZ. B LTE.12', '949271520', 1, 1, '2020-10-12', 15, 76, 'María J.Concha S., atendiéndose desde fines del año pasado en el HNSB, por neurología, ante ello,retomo consulta 28/08/20 con Dr. Alejos zirena J. para tratarse de insomnio constante y parkinson, tras la atención telemedicina entregó una semana después la medicina y receta; por control,7 de octubre tuvo segundo cita con el mismo doctor, le recetó y nunca nos brindaron la medicina, escribimos a telemedicina 12/10/2020 y que no estuvieron atendiendo, que saque otra cita, el 14/10/20 el mismo dr. dijo que mandaría la receta y hasta la fecha no atienden, es de urgencia por ser de la tercera edad. Reclamamos la demora en la atención de servicio de salud, dificulta de acceso a los servicios de atención a la asegurada, no conformidad con el suministro de medicamentos, disconformidad con el trato brindado.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(39, 'LR-2020-00030', '2020-11-23', NULL, 1, '42806774', NULL, 'ANGELA MONICA', 'YANCCE', 'PERALTA', 2, 'monicayancce@hotmail.com', '936827159', 15, 127, 1260, 'CALLE LAS VEGAS 120 URBANIZACION LAS VEGAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-11-20', 16, 97, 'EL DIA 20.11.20 MI MADRE INGRESO POR EMERGENCIA 2PM CON CUADRO DE APENDICITIS,EL JEFE DE GUARDIA DRA.ALEGRE MENCIONO Q TENIA Q ESPERAR LA SALA DE OPERACIONES,SIENDO 4AM DEL DIA 21.11.20 CONSULTE SI YA ESTABA PROGRAMADA LA OPERACION Y ME VOLVIO A DECIR QUE NO ERA PRIORIDAD,HABIENDO DEJADO EL MEDICO ANTERIOR  LA ORDEN COMO PRIORIDAD REALIZAR UNA LAPARASCOPICA A PRIMERA HORA,CONSULTE CUANTAS HORAS MAS PODRIA ESPERAR MI MADRE Y ME DIJERON QUE EL SISTEMA DE SALUD ES DEFICIENTE Y TENGA PACIENCIA, LA PROGRAMACION FUE DE 8AM A 8:30AM, SIENDO LAS 9AM LA SEGUIAN CONSIDERANDO COMO NO PRIORIDAD,ANTE TANTOS RECLAMOS LA OPERARON CON CIRUJIA Y NO LAPARASCOPICA,EL DIA 22.11.20 INFORMARON Q TENIA DIABETES CON EL AZUCAR MUY ALTO, LUEGO CONSULTE CON EL LIC.MICHEL Y ME INFORMO QUE SU AZUCAR ERA 101mg/DL Q INDICA NO DIABETES,EL DIA DE HOY 23.11.20 CAMBIARON DE DIAGNOSTICO APENDICITIS AGUDA PERFORADA NECROSADA DICIENDO Q SE COMPLICO POR NO LLEGAR A TIEMPO LA CUAL RESPONSABILIZO AL HOSPITAL LA ATECION TARDIA', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(40, 'LR-2020-00031', '2020-12-02', NULL, 1, '6138637', NULL, 'ANGELICA', 'PERALTA', 'PRADO', 2, 'monicayancce@hotmail.com', '936827159', 15, 127, 1260, 'CALLE LAS VEGAS 120 URB LAS VEGAS COMAS', 1, '42806774', 'ANGELA MONICA ', 'YANCCE', 'PERALTA', NULL, 'monicayancce@hotmail.com', 'CALLE LAS VEGAS 120 URB LAS VEGAS COMAS', '936827159', 1, 1, '2020-11-30', 18, 105, 'EL DIA 30.11.20 8AM ACUDIMOS EMERGENCIA,MI MAMA PRESENTABA DOLOR E INFLAMACION EN LOS PUNTOS DE LA OPERACION,POR LOQ NOS INDICARON EN TRIAJE Q UBIQUE AL MEDICO Q  LA OPERO Y NOS NEGARON LA INFORMACION, ALAS 2PM NOS SOLICITARON EXAMENES PARA EVALUARLA Y AL ENTRAR AL BAÑO DE EMERGENCIA VIMOS AL INTERNO Q ATENDIO A MI MAMA Y LE PEDIMOS Q REVISE LOS PUNTOS,NOS ATENDIO MUY AMABLEMENTE,LUEGO PASO EL DR ROMERO QUIEN CON INDIFERENCIA Y RISAS RECORDO Q MI MAMA FUE SU PACIENTE Y DE BRAZOS CRUZADOS DIJO Q LE ABRAN LOS PUNTOS Y DRENEN SIN ANESTESIA PORQ NO AMERITABA,PERO EL INTERNO DECIDIO PONERLE ANESTECIA PORQ TENIA DOLOR Y DRENAR,SABIENDO Q ENTRO CON UN CUADRO DE APENDICITIS Y POR NEGLIGENCIA DEL DR ROMERO POR NO CONSIDERARLA PRIORIDAD Y SALIO CON DIAGNOSTICO APENDICITIS AGUDA PERFORADA NECROSADA', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(41, 'LR-2020-00032', '2020-12-06', NULL, 1, '72407435', NULL, 'BERTHA LUCIA', 'MONTES', 'GUERRA', 2, 'belu.montesguerra@gmail.com', '915014854', 15, 127, 1260, 'AV. MIRAFLORES 2278 KM11 COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-12-06', 18, 103, 'Hoy 06/12a las 7:40 am solicite el ingreso para llevar pañales y ropa a mi paciente internado en departamento de cirugía ya que estaba mojada y no tenía Cambios el personal de seguridad Brayan Costar Víctor Antonio de la puerte principal junto a su compañero que no quiso identificarse en actitudes prepotentes y agresivas me negaron el ingreso realizando llamadas que no fueron contestadas por el departamento y necesitaba con urgencia llevar lo que yo tenía a mi paciente le dije que vayan a verificar no quisieron. Luego de dos horas me hacen ingresar porque la enfermera llamó y dentro del hospital en la puerta del departamento estaba el señor Jaime no me dijo sus apellidos, donde no me deja ingresar a mi paciente indicando que son las normas ninguna enfermera salio tuvo que salir mi paciente ya que no puedo entregar sus cosas personales a nadie porque estamos en PANDEMIA por lo que me grita cuando intente alcanzarle las cosas a mi paciente solicito tomar las acciones debidas. Pésimo serv', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(42, 'LR-2020-00033', '2020-12-17', NULL, 1, '10881946', NULL, 'ROGER ENRIQUE', 'DIAZ', 'MORALES', 1, 'roger1088enrique@gmail.com', '997706743', 15, 127, 1260, 'AV MIRAFLORES 1321 KM11 LA LIBERTAD COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-12-17', 21, 112, 'reclamo sobre documentos enviados a hospital sergio enrique bernales por mesadepartesvirtual@hnseb.gob.pe y remitido tambien al director de dicha institucion dr julio silva ramos de denuncia sobre derechos vulnerados emitidos por susalud con pass635-2020 y con multa de 500 uit por susalud  se envio documentos de resarcimiento economico por parte del sr roger enrique diaz morales con dni 10881946 en reiteradas veces el correo se remita a tramite administrativo  se corra traslado inmediato y se logre a llegar a una calidad de vida por la dejades de parte de la quejada y solicitar ala ves un monto razonable de parte del hospital sergio enrique bernales por maltrato y vulneraciones contagiado por el mismo hospital de covid 19 y toda mi familia por los trayectos desde marzo por las especialidades de neurologia y neurocirugia medicina fisica entre otros  a todo esto se suma 3 denuncias mas vulneradas con expedientes iprot 08010-2020 seguidos de expediente iprot 9129-2020 vulneraciones ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(43, 'LR-2020-00034', '2020-12-17', NULL, 1, '10881946', NULL, 'ROGER ENRIQUE', 'DIAZ', 'MORALES', 1, 'roger1088enrique@gmail.com', '997706743', 15, 127, 1260, 'AV MIRAFLORES 1321 KM11 LA LIBERTAD COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-12-17', 21, 112, 'reclamo por no dar codigo o ala negativa de brin dar informacion donde se envio correo eletronico por mesadepartes virtual@hnseb.gob.pe de fecha 26 de noviembre del 2020 los cuales no tienes fundamento para sin codigo de ingreso incumpliendo las normas legales del libro de reclamaciones si n dejar efeto a lo enviado solicito se regularise mi documento de fecha 26 de noviembre  por su mesa de partes si no se recaudara informacion y se procedera a denunciar ala defensoria del pueblo para su investigacion y a susalud ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(44, 'LR-2020-00035', '2020-12-27', NULL, 1, '48859784', NULL, 'EMMYMAR IBETH', 'CABRERA', 'LINARES', 2, 'emmymar188@gmail.com', '945958090', 15, 127, 1260, 'CALLE SAN JOSE 119, URB SAN CARLOS COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2020-05-03', 21, 112, 'violencia obstétrica derecho a la salud y la integridad física mía y de mi bebe\nrealización de procedimientos invasivos sin ser informada de forma agresiva y forzada, estudiantes no indicaban procedimientos a realizar y administración de medicamentos \nnegación a recibir agua u otros alimentos, negación a la higiene durante el trabajo de parto, tenían un baño sin lavamanos, entre a la sala de parto con la misma ropa de la calle y caminando descalza con los pies sucios, paciente añosa 38 años primera gestación se me forzó a parto vaginal, con episiotomía, desgarro vaginal, hemorroides, bebé salió con la maniobra de kristeller la cual estaba escrito que no quería y mi bebe tubo una fractura, todo lo anterior no lo escribieron en el informe médico. A mi bebe no me la mostraron al nacer, no le vi el rostro, una enfermera me indico que estaba \"sucia\" cuando mi bebe tenia hiperpigmentación de su piel (un tipo de nevo gigante) la enfermera no me coloco la medicación Y MUCHO MAS PERO NO ALCANZA', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1);
INSERT INTO `sc_reclamo` (`idReclamo`, `correlativo`, `fechaReclamo`, `horaReclamo`, `tipoDoc`, `nDoc`, `razonSocial`, `nombres`, `apellidoPat`, `apellidoMat`, `sexo`, `email`, `telefono`, `departamento`, `provincia`, `distrito`, `domicilio`, `tipoDocR`, `nDocR`, `nombresR`, `apellidoPatR`, `apellidoMatR`, `rsocialR`, `emailRep`, `domicilioR`, `telefonoR`, `regsRep`, `tipoUsuario`, `fechaOcurrencia`, `derecho`, `causaEspecifica`, `detalleReclamo`, `estadoRec`, `etapaReclamo`, `resulRec`, `registroSistema`, `autogenerado`, `autoCorreo`) VALUES
(45, 'LR-2021-00001', '2021-01-04', NULL, 1, '70812089', NULL, 'SONIA ARACELY', 'VELASQUEZ', 'TORRES', 2, 'sonia-03-10@outlook.com', '926553504', 15, 127, 1260, 'JR LORETO 276', 1, '70812089', 'SONIA ARACELY', 'VELASQUEZ', 'TORRES', NULL, 'sonia-03-10@outlook.com', 'JR. LORETO 276', '926553504', 1, 3, '2021-01-04', 16, 88, 'Llevo 5 horas en cola para una prueba programada ayer, y encima que hacen hacer cola, dejan pasar a los conocidos de los médicos o enfermeras de turno, no es justo que hagamos una cola bajo el sol, con olores nauseabundos y dejen pasar como si nada a gente solo por ser conocidos.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(46, 'LR-2021-00002', '2021-01-08', NULL, 1, '40379423', NULL, 'IVAN RONALD', 'SOTO', 'HUAMANI', 1, 'akpla24@gmail.com', '956945613', 15, 127, 1260, 'EL PACAYAL 2 MZB LOTE 44 CARABAYLLO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-01-08', 18, 107, 'Sali positivo del corona y el doctor se niega a darme tratamiento ene l hospital sergio de collique zona coviv', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(47, 'LR-2021-00003', '2021-01-11', NULL, 1, '9475971', NULL, 'JESUS MANUELA', 'CARBAJAL', 'ESPINOZA', 2, 'csp408@hotma.com', '922572420', 15, 127, 1260, 'JIRON CARABAYLLO 350', 1, '6827132', 'LUCIANO ', 'CHAVARRIA', 'CARRANZA', NULL, 'csp408@hotmail.co.com', 'JIRON CARABAYLLO 350', '922572420', 1, 1, '2021-01-11', 16, 81, 'Hoy fui para  realizar unos ánalisis que me mando el Geriatra mi suegro tiene SIS, me acerque a vigilancia, laboratorio, sis, asistenta social, referencia y nadie me supo dar informacion. Todo examén de análisis, ecografias lo tenemos q hacer particularmente. Teniendo el sis, sabemos q la situacion económica esta muy dificil en estos tiempos de pandemia. Ruego controlar esta situacion ya que hay mucha necesidad', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(48, 'LR-2021-00004', '2021-02-22', NULL, 1, '46294446', NULL, 'DANY EMPERATRIZ', 'CABRERA', 'TORRES', 2, 'emperatrizct31@gmail.com', '973312558', 15, 127, 1260, 'AA.HH BELÉN MZ.B LOTE 2', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-02-22', 21, 112, 'Buenos dias.   Me dieron mi cita virtual para el dia de hoy para oftalmologia estube mas de 10 minutos y nada no entraba la doctora sali y volví a ingresar y nada, creo que lo hice como 3 veces ... deberían ver una forma más fácil de ingresar... perdí la cita supongo y nunca pude hablar con la doctora... otra cosa traten de buscar una aplicación que sea más accesible a las personas... Hay personas que son adulto mayor y no entienden mucho la tecnología... deberían considerarlo por favor...', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(49, 'LR-2021-00005', '2021-02-22', NULL, 1, '15841296', NULL, 'MARITA ESTHER', 'TIRADO', 'VEGA', 2, 'marciapereztirado4@gmail.com', '998613102', 15, 127, 1260, 'JR.MARCO DONGO 245', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-02-22', 16, 88, 'El motivo del reclamo es porque el jueves 18 tuve una cita con la médico Merly Martinez Pomayauli en el cual me indicó que había enviado un correo con la referencia que solicité y me dio un número para llamar(015201542) donde me dijo que ahí sacara una cita y donde supuestamente me entregarían la referencia para luego ser sellada por el médico de turno.Desde ese día empecé a llamar y recién hoy contestaron mis llamadas,pero el joven que contestó me dijo que ese número es solo para entrega de medicamentos y que ellos no dan referencia y me brindo otro número al cual llamo y suena apagado.Necesito que me den una solución porque yo soy una paciente oncológica y requiero con urgencia comenzar con mis tratamientos(quimioterapia,radioterapia),espero que me brinden una solución. \n', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(50, 'LR-2021-00006', '2021-03-01', NULL, 1, '40823107', NULL, 'NANCY', 'CORONADO', 'CARRASCO', 2, 'coronadocarrasconancy@gmail.com', '961099069', 15, 127, 1260, 'CALLEGUYANA 147 URB PARRAL', 1, '40823107', 'NANCY', 'CORONADO', 'CARRASCO', NULL, 'coronadocarrasconancy@gmail.com', 'CALLEGUYANA 147 EL PARRAL', '961099069', 1, 1, '2021-03-01', 18, 105, 'estoy llamando hace un para una cita y los numeros de telefonos q me dieron no contestan los numeros son 5201542 y 925141340 la consulta es traumatologia pa ver una placa de tobillo y para ver si se puede retirar el yeso ya tengo mas de un mes llamando gracias me atendi x emergencia en el mes de enero el dia 21', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(51, 'LR-2021-00007', '2021-03-10', NULL, 1, '46481808', NULL, 'SHESSIRA', 'ROJAS', 'TUTAYA', 2, 'shadira_sexxy_22@hotmail.com', '902089819', 15, 127, 1256, 'A.V MERYNO REYNA 113 KM 18', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-03-07', 16, 88, 'No me quisieron atender. Ponían peros yo siendo una gestante con código blanco. Venía con dolor fuerte no hay corazón para esta madre gestante', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(52, 'LR-2021-00008', '2021-03-18', NULL, 1, '45158425', NULL, 'ASUNCIONA EDITH', 'VASQUEZ', 'ZAVALETA', 2, 'edith27vz@gmail.com', '944912882', 15, 127, 1256, 'MZ D1 LTE 5 URB RESIDENCIAL LUCYANA DE CARABAYLLO', 1, '32924655', 'PANFILO', 'ZAVALETA', 'GONZALES', NULL, 'edith27vz@gmail.com', 'MZ D1 LTE 5 URB RESIDENCIAL LUCYANA DE CARABAYLLO', '944912885', 1, 1, '2021-03-18', 17, 99, 'Desde el día lunes 15 de marzo no hay información del paciente ya sea por llamada telefónica o en el hospital', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(53, 'LR-2021-00009', '2021-03-18', NULL, 1, '32924655', NULL, 'PANFILO', 'ZAVALETA', 'GONZALES', 1, 'edith27vz@gmail.com', '944912882', 15, 127, 1256, 'MZ D1 LTE 5 URB RESIDENCIAL LUCYANA DE CARABAYLLO', 1, '45158425', 'ASUNCIONA EDITH', 'VASQUEZ', 'ZAVALETA', NULL, 'edith27vz@gmail.com', 'MZ D1 LTE 5 URB RESIDENCIAL LUCYANA DE CARABAYLLO', '944912882', 1, 1, '2021-03-18', 17, 99, 'No tenemos información del paciente desde el día 15 de marzo no sabemos del estado del paciente si está recuperando o más grave', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(54, 'LR-2021-00010', '2021-03-31', NULL, 2, '3175788', NULL, 'LUIS', 'GUILLEN', 'TORO', 1, 'guillenluis401@gmail.com', '928835860', 15, 127, 1260, 'AV  SAN. FELIPE. COMAS', 1, '92166335', 'LUIS', 'GUILLEN', 'TORO', NULL, 'guillenluis401@gmail.com', 'AV SAN FELIPE. COMAS 443', '928835860', 1, 1, '2021-03-31', 16, 79, 'Tengo una hija de tres meses que requiere con urgencia esa hoja se referencia para poder ser atendida en el hospital de san borjas y ni la posta ni el hospital de collique me quueren dar la referencia  mi hija  nacio con sindrome se daow y supuestanente hay que hacerle descarte de hidrosefalia  y nadie nos ayuda se pelotean dicen que no estan dando por tema covid si no fuera energencia no expusiera a mi hija  ella requiere atencion por favor  ayuda ', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(55, 'LR-2021-00011', '2021-04-25', NULL, 1, '9732430', NULL, 'MARIA EUGENIA', 'ASTOCONDOR', 'FUERTES', 2, 'rutmoi0903@hotmail.com', '962823210', 15, 127, 1260, 'AV. JOSE PARDO 266 EL CARMEN ', 1, '9732430', 'MARIA EUGENIA', 'ASTOCONDOR', 'FUERTES', NULL, 'rutmoi0903@hotmail.com', 'AV. JOSE PARDO 266 EL CARMEN ', '962823210', 1, 2, '2021-04-25', 21, 112, 'No es posible que en el hospital no haya algo tan elemental como cloruro, jeringa, gasas para la atención del SOAT, algo tan elemental las familias tengan que salir a comprar a las farmacias de la calle', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(56, 'LR-2021-00012', '2021-04-27', NULL, 1, '40969537', NULL, 'RONALD EDMUNDO', 'QUINTANA', 'ESPINOZA', 1, 'rquintana.espinoza1981@hotmail.com', '984991375', 15, 127, 1251, 'AV. MIRAFLORES # 630 EL PROGRESO  ALT KM 19 ', 1, '6836323', 'MELECIA', 'ESPINOZA', 'MELGAREJO', NULL, 'rquintana.espinoza1981@hotmail.com', 'AV. MIRAFLORES # 630 EL PROGRESO  ALT KM 19', '984991375', 1, 1, '2021-04-27', 21, 112, 'MI RECLAMO (SIS) 4591 EXP 032, EN MESA DE PARTE DEJE LAS PRUEBAS \" EXP 003524\" 33 FOLIO EL 14/04, A LA FECHA NO TENGO RESPUESTA DE MI RECLAMO, TODO ESTO SUCEDIO POR RECOMENDACION DE LOS DR. : MANUEL, VANESSA, JORGE, KARLA EN REALIZAR DE MANERA EXTERNA (PRUEBAS, RESONANCIA, MEDICAMENTOS, PROCEDIMIENTO, AMBULANCIA)  A TODO ELLO NO SENTI SOLUCIONES A LOS GASTOS QUE NOS SOMETIAN. SOLICITO EL REEMBOLSO DE TODO LO QUE HEMOS GASTADO, YA QUE NO TENEMOS PARA DEVOLVER LO QUE NOS HAN PRESTADO, MIS PADRES SON PERSONAS VULNERABLES Y DE TERCERA EDAD, AHORA MAS QUE NUNCA CON LA PANDEMIA QUE NOS HEMOS QUEDADO COMPLICADO Y SIN DINERO.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(57, 'LR-2021-00013', '2021-04-29', NULL, 1, '7601613', NULL, 'JESUS EUGENIA', 'MALLQUI', 'MACCHA', 2, 'cibercafe.pe@gmail.com', '942356269', 15, 127, 1260, 'JR. OCOÑA 163 URB. SAN FELIPE', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-01-28', 16, 84, 'TODO  COMENZO  EL 28 DE  ENERO  QUE  INGRESAMOS  AL HOSPITAL  EN EMERGENCIA CON MI HERMANO PEDRO EDWIN MALLQUI MACCHA  DONDE  EL DOCTOR ENCARGANDO DE  EMERGENCIA SOLO LO RECETO MEDICAMENTOS  BASICO Y LO  DIERON DE ALTA, PASARON  3 DIAS  Y  VOLVIMOS  A IR  A  EMERGENCIA  YA QUE EL DOLOR A MI HERMANO  ERA  MAS  FUERTE,  DONDE  EL DOCTOR  ENCARGADO NOS  DERIBO A SALA COVID PARA PODER SACAR  LOS  RESULTADOS Y  SALIERON NEGATIVO, RAPIDAMENTE NOS  DERIVARON A  EMERGENCIA DONDE EL DOCTOR  LO  HIDRATO CON SUERO, EL DOCTOR LO TOCO LA PARTE DEL DOLOR  Y LO DIAGNOSTICARON   PERITONITIS GENERALIZADA POR  APENDISTIS PERFORADA  ( QUE LE DIO UNA  SEPSIS EN UNA  INFECCION  RENAL Y HEPATICA). DONDE  LOS  DERIBARON DESPUES  DE 20 HORAS  A LA SALA  OPERACION  DONDE LO OPERO EL  CIRUJANO DE TURNO', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(58, 'LR-2021-00014', '2021-04-29', NULL, 1, '7601613', NULL, 'JESUS EUGENIA', 'MALLQUI', 'MACCHA', 2, 'cibercafe.pe@gmail.com', '942356296', 15, 127, 1260, 'JR. OCOÑA 163 URB. SAN FELIPE ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-02-01', 16, 84, 'PASARON 6 DIAS  Y   NOS COMUNICO EL CIRUJANO ES QUE MI  HERMANO ESTAN EN RECUPERACION, NOSOTROS CON LA  DESESPERACION NOS AVERIGUAMOS  QUE  TENIAS QUE  HABLAR CON  JEFE  DE  UCI CON EL DOCTOR  SANDOVAL  DONDE EL DOCTOR  SALDOVAL NOS INDICO QUE  TENIAMOS QUE  HACERLE A MI HERMANO UNA HEMODIALISIS PARA QUE SE  RECUPERE DONDE  EL DOCTOR  NOS  ENTREGO DOS  TARJETA DE DOS NEUFLOLOGO, DONDE  TERCAMENTE  EL DOCTOR SANDOVAL  QUERIA QUE SEA CON ESOS DOS  NEUFLOLOGO\nDONDE  ME  GASTE  S/. 9,00.00 SOLES, DONDE  SOLICITO  LA  DEVOLUCION DE  LOS  SEIS  DIALESIS, YA QUE  LA JEFA  DE  SEGUROS  Y LA  ASISTENTE  SOCIAL  NOS INDICO  QUE  POR  SER  ASEGURADO  POR  EL SIS  LE  CORRESPONDIA  LA  DIALISIS  MAS  MEDICINAS PERO EN ESE  MOMENTO NO  HABIA  ESE  SERVICIO, POR ESO NOSOTROS  NOS  DERIBAMOS  A HACERLE DICHO DIALISIS  FUERA\nOTRA  DENUNCIA QUE  QUIERO REALIZAR  ES QUE  AL  SR. EDGAR   GABRIEL FLORES( TRABAJA  COMO ENFERMERO EN LA SALA DE OPERACION)  ME COBRO 200 SOLES  PARA  SER  ENTREGADO   AL  DOCTOR  SANDOVAL  PARA  SER  INGRESADO A  UNA  CAMA  UCI  TENIENDO  EN MI PODER  LOS   BOUCHER, TAMBIEN  QUE  UNA  SECRETARIA  NOS  VENDIO UN MEDICAMENTO  CARO  QUE  SU  PRECIO ERA 100 SOLES PERO ELLA NOS  VENDIO A 60 SOLES  DONDE LA  SEÑORITA  SACO DE  SU  CAJON  YA QUE NO  ENTIENDO COMO  TUVO MI CELULAR PARA QUE  SE  COMUNIQUE CONMIGO  , ELLA NO ME DIO COMPROBANTE DE  PAGO PERO SI LO RECONOSCO  PERSONALMENTE . Y A  LA VEZ  TENIA  EN SU PODER  VARIOS  MEDICAMENTOS  EN SU  ESCRITORIO \nNO ME  PRESENTE  ANTES  PORQUE  NO TENIA  LAS PRUEBAS  PARA  DEMOSTRAR   QUE  FUIMOS  VICTIMA  DE  ESTAFA  Y  TRAFICARON CON NUESTRO  DOLOR  AJENO  ESPERO SE ME HAGA  JUSTICI A  DE  LO CONTRATIO ME  PRESENTARE  A  LOS  CANALES  DE  TELEVISION  POR  TENGO  UNA DEUDA  CON LOS  BANCO.\n', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(59, 'LR-2021-00015', '2021-04-29', NULL, 1, '46107189', NULL, 'CARLOS EDUARDO', 'PEREA', 'ROSSI', 1, 'jorgeperea.mdc@gmail.com', '989099355', 15, 127, 1260, 'CONDOMINIO SOL DE RETABLO MAZ E LOTE 31 DPTO 908 - COMAS', 1, '43516519', 'JORGE ERNESTO', 'PEREA', 'ROSSI', NULL, 'jorgeperea.mdc@gmail.com', 'CONDOMINIO SOL DE RETABLO MAZ E LOTE 31 DPTO 908 - COMAS', '989099355', 1, 1, '2021-04-29', 18, 105, 'Mi hermano, Carlos Perea Rossi, DNI 46107189 con VIH hace 10 años y sin recibir TARGA hace 2 años, está grave ya que al parecer ha tenido una isquemia cerebral. Hoy 29/04/2021, fui al PROCETSS del hospital Sergio Bernales de Comas para que me deriven a infectología, pero el trato es demasiado indiferente. Me piden prueba de TBC y una hoja de derivación con la que no cuento porque mi hermano no puede hablar ni movilizarse. Para su familia es de total riesgo acercarse a un hospital por el COVID. Quisiera que lo vean en infectología y que puedan tratar su enfermedad haciendo valer su derecho de persona vulnerable. Ya lo he llevado 2 veces de emergencia, pero solo lo estabilizan y le dan alta. No ven sus niveles de defensas ni nada relacionado a su TARGA.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(60, 'LR-2021-00016', '2021-05-04', NULL, 1, '40990135', NULL, 'MIGUEL ANGEL', 'ARISMENDIZ', 'RODRIGUEZ', 1, 'm_arismendiz@hotmail.com', '966779506', 15, 127, 1256, 'AH KEIKO SOFIA MZ C LT 18 EL PROGRESO DE CARABAYLLO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-05-04', 16, 79, 'tengo una paciente de covid hospitalizado en otro nosocomio, tengo una receta de 14 ampollas de COLISTINA de 150 mg, ingrese a la web del Hospital Sergio Bernales en consulta de medicamentos y tienen el stock, al acercarme al hospital me negaron el medicamento indicando que no cuentan con stock, raro porque figura stock y solo venden si coordinas con un referido del mismo nosocimio y este se communica con el encargado del area de famarcia y si a el le parece aprueba que se venda y eso no esta bien, no puede ser posible que dependa de que tan bien le caiga al farmaceutico o que tan amigo sea para poder autorizar la venta del medicamento, mi queja es que teniendo el medicamento y presentando mi receta, no me quieren vender y eso no puede estar pasando, es un paciente covid que necesita el medicamento con mucha urgencia, no se puede estar negando los medicamentos ni escogiendo a quien vender..... estamos en una situacion dificil por la pandemia, estamos hablando de vidas humanas las que exponemos mas empatia con los demas, nos valemos de un cargo para hacer lo que queremos y eso esta mul mal', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(61, 'LR-2021-00017', '2021-05-16', NULL, 1, '9476255', NULL, 'ALBERTO ZACARIAS', 'GONZALES', 'SALDAÑA', 1, 'beto.petruzzi@hotmail.com', '989155267', 15, 127, 1260, 'JR. CUSIHUAMAN 238 URB. SANTA LUZMILA ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-05-15', 18, 101, 'Que, el día de ayer por emergencia fui atendido por un Dr. que no se identificó, mucho menos proporcionó su apellido al brindarme una receta sin sello alguno, le manifesté que con quién tenía el gusto y el Dr. de manera prepotente se negó a brindarme sus datos y me dijo que me retirara, le expliqué que yo tenía SIS Independiente para que me pueda facilitar los medicamentos, el Dr. me dijo que los medicamentos me lo comprara en la calle. Posteriormente acudí a la jefa de guardia, la Dra. Karina Moreano quien me atendió amablemente tomando mis datos y el motivo de mi queja. Señores he sido atendido en este hospital y operado de la vesícula de manera formal, nunca he tenido ninguna clase de problemas con ningún personal de esta Institución, le agradecería de antemano una respuesta objetiva con respecto al reclamo realizado precedentemente.\nSírvase tener presente y proceder  como corresponda.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(62, 'LR-2021-00018', '2021-05-18', NULL, 1, '44132419', NULL, 'IRENE MARIBEL', 'CRIALES', 'FLORES', 2, 'irenecriales3@gmail.com', '992036033', 15, 127, 1260, 'JR JUAN JOSE MUÑOZ #408 SANTA LUZMILA', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-02-10', 16, 82, 'Buenas tardes pues de mi centro materno mandaron una referencia y siempre q voy me pasean q espere q llamen y nada yo lo q necesito es una referencia para mi hijo para q se atienda en el hospital del  niño para su medicacion y el seguimiento e cuidados paliativos nose porq tanto la demora ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(63, 'LR-2021-00019', '2021-05-21', NULL, 1, '6836323', NULL, 'MELECIA', 'ESPINOZA', 'MELGAREJO', 2, 'rquintana.espinoza1981@hotmail.com', '984991375', 15, 127, 1256, 'AV. MIRAFLORES # 630 EL PROCGRESO ', 1, '40969537', 'RONALD EDMUNDO', 'QUINTANA', 'ESPINOZA', NULL, 'rquintana.espinoza1981@hotmail.com', 'AV. MIRAFLORES # 630 EL PROGRESO ', '984991375', 1, 1, '2021-03-26', 21, 112, 'El18/03 mi madre fue internada y se han generado gastos por tu tema de salud cuando ella tiene SIS y se gasto en medicina, ambulancia, procedimiento y resonancia, todo el gasto es de 5,303.08. Fui el 14/04 a presentar los sustentos a mesa de parte, donde deje las pruebas de la orden de cada medico (firma, sello y nombre) se genero el EXPEDIENTE 003524, estamos ENDEUDADOS  ojala me puedan llamar e indicar la solución de mi problema, cuando llamo a mesa de parte no me dan razón de mi reclamo, solicito su ayuda por favor, estamos en situación critica. y si desean que me apersone hare el esfuerzo de hacerlo.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(64, 'LR-2021-00020', '2021-05-22', NULL, 1, '40703363', NULL, 'ANA BEATRIZ', 'SILVA', 'PURIZAGA', 2, 'anasilvapurizaga@gmail.com', '910214149', 15, 127, 1260, 'EL PROGRESO CARABAYLLO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-05-22', 21, 112, 'Mi reclamo hoy en la puerta principal del hospital los dos guachimanes hace ingresar a 3 personas para el pabellón de medicina  y los demás q estamos esperando desde las 8 am no nos deja ingresar asta 11.30 hay pucha preferencia y algunos indica que le tienen que dar 2 propina para ingresar', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(65, 'LR-2021-00021', '2021-05-31', NULL, 1, '40386007', NULL, 'GIOVANA MARIA', 'TADEO', 'ARRIETA', 2, 'alomdrakk026@gmail.com', '959761127', 15, 127, 1256, 'PROLONGACIÓN OSCAR R BENAVIDES 196', 1, '77774406', 'KARLA ALOMDRA', 'RAMOS', 'TADEO', NULL, 'alomdrakk026@gmail.com', 'PROLONGACION OSCAR R BENAVIDES 196 194', '959761127', 1, 1, '2021-05-19', 21, 112, 'Buenas noches quería hacer este reclama hace una semana pero por falta de internet no lo hice, en fin mi reclamo consiste en que mi mamá fue al área de farmacia para el recojo de su medicina mensual y la señorita que estuvo atendiendo en ese momento le hace una serie de preguntas ¿Porque usa esa pastilla? ¿Para qué es? ¿Cuál es su enfermedad? Mi madre le dice que tiene cáncer por eso el uso de esas pastillas pero la señorita imprudente le hace unas preguntas más que no vienen al caso; Eso me parece que es una total falta de respeto porque ella ya estaba superando su enfermedad (psicológica) llegó a mi casa destruida y no me imagino que preguntas le hará a otros pacientes. Espero puedan corregir esta situación y que no se vuelva a repetir. Gracias.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(66, 'LR-2021-00022', '2021-06-01', NULL, 1, '9927847', NULL, 'LIDA', 'REYNALDO', 'SIFUENTES', 2, 'lidareynaldo@hotmail.com', '993255989', 15, 127, 1260, 'JR 23 DE SEPTIEMBRE 251 URB VILLA HIPER', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-02-18', 17, 98, 'Mi pareja el sr Misael Oscar Caytuiro Loayza falleció de covid 19 el 17/02/2021 en el hospital Sergio Bernales no se me dio la debida información el licenciado del hospital me pregunta sra cremación o inhumación le respondí inhumación sra realize los trámites para la entrega del cuerpo me entrego el certificado médico de defunción y q regrese para realizar los trámites de reembolso del sis no me dieron la debida información.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(67, 'LR-2021-00023', '2021-06-04', NULL, 1, '45005707', NULL, 'KARINA JOHANA', 'SICCHA', 'JURADO', 2, 'karina1734@hotmail.com', '950274999', 15, 127, 1260, 'AV. METROPOLITANA 500', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-05-29', 18, 103, 'Buenas tardes. Mi reclamo a especificar es la falta de personal para la cantidad de pacientes que recibe el hospital. Así también la infraestructura del mismo hospital, camas fuera de uso, enchufes salidos, y la poca atención que le dan a la madre lactante y cesariada. Durante mi estadía en el hospital tuve que pasar más de 10 días internada por un cuadro de colestasis sin ser resuelto, inducida a parto natural con un bebé de 4.400 kilos y reprogramada para una cesárea en dos oportunidades. Cuando tuve a la bebe las camas no tenían barandas y corría el riesgo de algún accidente con mi Rn. El personal hace su mayor esfuerzo pero deberían invertir en bienes como camas para la GESTANTES y RN así como equipos que logren un resultados más atinado como los ecografos. Por mi parte tuve la oportunidad de realizarme los análisis que el hospital necesitaba pero no todas las pacientes cuentan con esa posibilidad. \nEscribo mi reclamo para prevenir a las demás pacientes inscritas en el SIS', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(68, 'LR-2021-00024', '2021-06-08', NULL, 1, '42024087', NULL, 'JUAN MANUEL', 'JUAPE', 'KU', 1, 'juantlv13@gmail.com', '942813848', 15, 127, 1260, 'ANGEL MORALES 131 COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-06-08', 21, 112, 'Siendo las 1:56 pm me apersone al hospital sergio bernales al area de emergencia por un dolor de la columna le indique al doctor de topico que me dolia la colunma el señor solo me indico que no era una emergencia a pesar que le dije que me dolia la columna y que me isiera ver ami posta que ese dolor no requeria emergencia reclamo por una mala atencion por parte del doctor de guardia a esa hora no procedio a revisarme y nisiquiera los signos vitales yo tomando farmacos para el dolor no me pasa reclamo por tanto una mala atencion porque va contra mis derechos sobre mi salud', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(69, 'LR-2021-00025', '2021-06-10', NULL, 1, '71037748', NULL, 'MILANIE MILAGROS', 'HINOSTROZA', 'JIMENEZ', 2, 'mhj_74_47@hotmail.com', '950454440', 15, 127, 1251, 'CALLE LOS NOGALES ASOC. DE PROP VILLA SANTA MARIA ETAPA I MZ L LT10 CARABAYLLO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-06-10', 20, 109, 'Buenos días, mi nombre es Milanie Hinostroza Jimenez DNI 71037748, tengo seguro SIS.\nMi hija nació en el Hospital SERGIO E. BERNALES el 20-04-2015, \nMi hija está llevando tratamiento por problema de crecimiento y el Pediatra necesita trabajar con el INFORME MEDICO DE HISTORIA NEONATAL, \nHace 1 mes me acerque a meza de partes del Hospital SERGIO E. BERNALES y me dicen que no encuentran la información de historia neonatal de mi hija, no entiendo ya que mi hija nació en el hospital, si podrían decirme donde tengo que pedir esa información.\nESTARIA MUY AGRADECIDA SI ME RESPONDEN, YA QUE SE TRATA DE UN TRATAMIENTO DE UNA NIÑA.\nGRACIAS,', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(70, 'LR-2021-00026', '2021-06-14', NULL, 1, '40558185', NULL, 'MARTHA EVELYN', 'CHUNGA', 'ANGELES', 2, 'rvillalobos9541@gmail.com', '969881556', 15, 127, 1256, 'MZ A LT 3 ', 1, '17989600', 'JORGE LUIS', 'VILLALOBOS', 'ALVAREZ', NULL, 'rvillalobos9541@gmail.com', 'MZ A LT 3', '918996807', 1, 1, '2021-06-14', 18, 102, 'LLEVO HOSPITALIZADA DESDE EL DIA JUEVES 10/06/21 POR EMERGENCIA MEDICA YA QUE SUFRI UN ACCIDENTE Y TENGO UNA FX EN EL TOBILLO, ME PIDIERON LOS IMPLEMENTOS DE OPERACION LOS CUALES YA FUERON COMPRADOS, ME SACARON LOS ANALISIS MEDICOS CORRESPONDIENTES PARA LA OPERACION Y HASTA EL MOMENTO LLEVAN POSTERGANDOLO. DEL DIA JUEVES PASO AL VIERNES, LUEGO AL SABADO. DEL DIA SABADO 12/06/2021 FUE POSTERGADO PARA EL DIA LUNES 14/06/2021 Y HOY IGUALMENTE FUE POSTERGADO.\nME INDICAN QUE HAY OTROS PACIENTES Y QUE MI FRACTURA NO ES CONSIDERADO COMO EMERGENCIA Y NO HAY SALAS DISPONIBLES Y TENGO QUE ESPERAR. MI ACCIDENTE FUE EL DIA 07/06/2021 PRACTICAMENTE LLEVO 1 SEMANA Y SIGO ESPERANDO YA QUE EN EL HOSPITAL ME VIENEN POSTERGANDO LOS DIAS DE OPERACION.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(71, 'LR-2021-00027', '2021-06-27', NULL, 1, '44357184', NULL, 'EVELYN VANESA', 'NARCISO', 'VELASQUEZ', 2, 'evy_25@hotmail.com', '965345400', 15, 127, 1260, 'PSJ.STA.CRUZ  MZ.F LOTE 16 URB.EL RETABLO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-06-27', 18, 102, 'Ingrese por emergencia a las 12 del fin \nAhorita son las 11 de la noche y no me dan nada para mi dolor de cabeza recibo muy mal trato departe del enfermero de turno', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(72, 'LR-2021-00028', '2021-07-08', NULL, 1, '6954793', NULL, 'GENOVEVA', 'SANTANA', 'CAHUASA', 2, 'brando.forever9723@gmail.com', '976184774', 15, 127, 1275, 'MZ H LT 4 LADERAS DE CHILLON', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-07-05', 21, 112, 'El día Lunes 05 me encontraba en compañía de mi hijo Victor Ochoa(que se encuentra internado en el área de Neumología cama 24segundo piso) quien tiene un catéter en el pecho que tiene que ser cambiado semanalmente con la aguja N22 V, se aperdonó la Lic. \"Juanita\" en compañía de un técnico para poder cambiarle el catéter lo cuál intento realizarlo en 3 intentos(pinchada) y aún así no logró llevarlo a cabo, como mi paciente ya no aguantaba el dolor la Lic refirió que se acercaría otra Lic pero que no habría problema en la utilización de la misma agua. Cuando se acerca la sgt Lic, le llama la atención a la Lic \"Juanita\" que porqué había \"intentado\" cambiar el catéter ya que   ella no sabe poner ese tipo de aguja y ese acto podría haberle causado consecuencias en su salud, en consecuencia a ese acto negligente la aguja quedó inservible. Y en mi condición económica me afecta por qué soy una persona mayor (3era edad) con carga familiar y mal de salud. Y ahora nadie se quiere hacer responsable sobre la aguja que tiene un costo de 35 soles y nadie me da razón de la Lic y ni una disculpa recibimos de su parte', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(73, 'LR-2021-00029', '2021-07-26', NULL, 1, '72700760', NULL, 'KIMBERLY NAOMI', 'RODRIGUEZ', 'CASTILLO', 2, 'kimberly9768@gmail.com', '949374538', 15, 127, 1260, 'AV. 22 DE AGOSTO #946', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-07-24', 18, 102, 'El día 24 de julio del presente año en el turno noche se me realizo un AMEU o también llamado legrado, llegado el momento de realizarme el AMEU la doctora de turno reviso los instrumentos, percatándose de que los instrumentos estaban incompletos, faltaba el anillo- o del embolo, a pesar de ello continuaron con el procedimiento. Ya realizándose el procedimiento, después de un buen rato de hacer la manipulación y no poder culminar con éxito la doctora decidió no continuar debido a que el instrumento no estaba succionando como debía y se me estaba dañando, por lo que no se logro culminar con éxito dicho procedimiento. Cabe resaltar que en todo momento se me realizo el procedimiento con los instrumentos incompletos. Bajo la supervisión de los encargados de ese turno, todos estaban al tanto que el instrumento estaba incompleto. Ya pasando a mi camilla para la recuperación solicite mi alta voluntaria, debido a que estaba inconforme por la atención que se me brindo.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(74, 'LR-2021-00030', '2021-07-29', NULL, 1, '44553960', NULL, 'ENRIQUE CARLOS', 'ALFARO', 'HUIÑOCANA', 1, 'sakike19@gmail.com', '960334399', 15, 127, 1260, ' SAN ISIDRO    459                                                                                                                                                                                                               ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-07-27', 16, 80, 'la paciente  felicitas huiñocana bujanda sis 1912148\nhacen comprar medicamentos fuera del establecimiento ,como por ejemplo  ,\"SISTEMA VAC\"  donde ningun lado venden ,piden examen de sangre  que lo adquiera a fuera ya que no cuentan con laboratoria ,tengo pruebas contundentes en mano ,para poder llevar a otras instancias ,aun el paciente se encuentra hospitalizado...', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(75, 'LR-2021-00031', '2021-07-29', NULL, 1, '76026025', NULL, 'VIRGINIA KATHERIN', 'SANCHEZ', 'BERRIOS', 2, 'vkatherinsanchez@gmail.com', '954855179', 15, 127, 1290, 'AV. PASEO DE LA REPUBLICA 201, SANTIAGO DE SURCO', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-07-28', 18, 104, 'Estimados,\nEl día de ayer 28/07 me apersone a la clinica de Emergencias de la Clinica Internacional en San Borja, por el motivo que tenia una fuerte infeccion urinaria y ardor en la uretra y en la zona vaginal. Fui clara al decir a la doctora MENA RAMIREZ TATIANA, que yo tome pastillas, calmantes y no me pasaba, tanto fue el dolor que me vi en la obligación de ir a emergencias. Sin embargo, cuando me atendió, me hizo algunos toques y solo me pidio señalar la zona de dolor, después concluyó en darme calmantes y decirme que se hara un cultivo para saber el tipo de infección. Horas mas tarde me entero por la enfermera, que este cultivo tomaria 48 horas para dar los resultados, hasta el momento estaba confundida. Porque no es la primera que yo me atiendo, el 01/05/2021 yo me atiendo en emergencia y el doctor de turno hizo  todo a la brevedad y se supo lo que realmente tenia. Pero la doctora no realizo ese procedimiento, solo se atinó en darme unos calmantes y me dijo que lo que tenia era una infeccion mas no sabia qué bacteria tenia y que debía irme a mi casa y esperar 2 dias para nuevamente ir por medicina interna y saber qué realmente tengo.\nEn la madrugada para el 29/07 desperté y lloré por el profundo dolor que sentía, estuve a punto de irme a la clinica nuevamente, pero tanto fue el dolor que me desmaye , despertandome horas de la mañana. No entiendo porqué la doctora concluyó que lo que tenia era una urgencia, y que los calmantes iba a pasarme el dolor y cobrarme toda la atención brindada en emergencia. Cabe resaltar que cuando hice el ingreso, la señorita de administración me dijo tajantemente que muchas las atenciones serian urgencias y que deberia pagar si fuese el caso, fue ahi que me parecio algo raro el ambiente, pero al ver que la doctora me dijo que no era grave y lo paso como urgencia, estoy concluyendo que lo que mas primaba ahi, en ese lugar, era la cantidad de pacientes por urgencia y asi pagar el servicio.\nTengo en mi poder todos los papeles y fotografias que avalan lo que tuve que pagar y pasar, lo que solicito con caracter urgente es que me reembolsen lo que he gastado en \"urgencia\", cuando el dolor era emergencia y si la doctora MENA RAMIREZ TATIANA CMP54219 consideró más el lado monetario que a su paciente, mandó a cobrar indebidamente un servicio que era de suma emergencia.', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(76, 'LR-2021-00032', '2021-08-03', NULL, 1, '40386007', NULL, 'GIOVANA MARIA', 'TADEO', 'ARRIETA', 2, 'alomdrakk026@gmail.com', '959761127', 15, 127, 1256, 'PRO OSCAR R BENAVIDES 196', 1, '77774406', 'KARLA ALOMDRA', 'RAMOS', 'TADEO', NULL, 'alomdrakk026@gmail.com', 'PROLONG OSCAR R BENAVIDES 196', '959761127', 1, 1, '2021-07-14', 16, 82, 'Buenas tardes, desde el 14 venga sacando cita para oncología la doctora martinez ya le hizo la receta pero hasta ahora no programan para que recoja las medicinas ya va ser un mes y nada. Espero solucionen esto rápido.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(77, 'LR-2021-00033', '2021-08-04', NULL, 1, '44947359', NULL, 'LESLIE CRISTINA', 'ROJAS', 'CONTRERAS', 2, 'lessrojas35@gmail.com', '949748953', 15, 127, 1260, 'A.H.VILLA DISCIPLINA MZ A LOTE 15 4TA ZONA DE COLLIQUE', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-08-01', 18, 102, 'Buenas el día 1 de agosto hora 01:00a.m. Me acerqué a emergencia obstetrica por una amenaza de aborto pues tenía sangrado dolor y quería saber si ya había perdido mi bb o aún estaba vivo y pues había una sola doctora que me dijo que tenía dos pacientes y que terminando me atendería ,también había otra persona de salud que no me quiso tomar mis signos vitales porque no llevaba mi facial y puedo entender mi responsabilidad hasta ahí pero ellos no llevaban tampoco el protector luego la doctora de ese turno me dijo que si quería saber si mi bb estaba vivo que me vaya a sacar una eco justamente si yo me acerco es porque tengo Sis me dijo entonces esperara su manera de trato fue muy poca empatía al igual que el personal de salud que me recibió a las finales tuve que retirarme pues quería que me atiendan pero no lo hizieron hace unos años yo fui atendida por emergencia y siempre había internos personal que te iba llenado los datos te revisaban pero ahora de verdad estoy disconforme con una atención que jamás se me dio con protocolos de salud que no llevan a cabo.espero tomen en cuenta mi reclamo pues no creo ser la única paciente con este tipo de quejas y flata de empatía con nosotros.gracias ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(78, 'LR-2021-00034', '2021-08-11', NULL, 1, '47280476', NULL, 'KELLY VANESSA', 'FIGUEROA', 'PACHERRES', 2, 'kfigueroa3107@gmail.com', '939468528', 15, 127, 1260, 'JR. LOS NOGALES 110', 1, '42147561', 'SARITA MILAGROS', 'MOREY', 'ESPINOZA', NULL, 'maycolyuniorbazanmorey21@gmail.com', 'JR. LOS NOGALES 110', '910764970', 1, 1, '2021-08-09', 16, 81, 'El día 09 de agosto 2021  lleve a mi familiar  Kelly Figueroa pacherres  a hospital. Sergio Bernales  por  dolores  en su vientre y ella está gestando con 24 y  en ginecología de emergencia le dijieron. Ami familiar que está con contracciones y que si el bebé nace  no hay cama UCI para bebe  y así que  lo mejor. Era que tome un taxi y me. Dirija ala maternidad de lima porque si ellos. Me atendían. Mi  familiar   tenía que firmar un documento donde ella se hace responsable de lo que pueda pasar.  A ella o. Al bebé  ', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(79, 'LR-2021-00035', '2021-08-12', NULL, 1, '47280476', NULL, 'KELLY VANESSA', 'FIGUEROA', 'PACHERRES', 2, 'kfigueroa3107@gmail.com', '930468528', 15, 127, 1260, 'LOS NOGALES 110', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-08-10', 21, 112, 'El 10 de agosto alas 6:30pm  ingresé a ginecología de emergencia con dolor en el corte  de anterior operación y costilla derecha lo cuales me. Revisaron y me indicaron que la bebé estaba bien pero que me realizarían análisis para ver si era cálculos o pancrias  mientras me realizaban los análisis me Iván a poner medicina lo cual mi familia salió a comprar y cuando trae el suero y los demás medicamentos justo hubo cambio de turno y el turno entrante me dió de alta y me reseto paracetamol   y no me pusieron ningún medicamento que mi familia avía. Comprado ya ni el suero y se quedaron. Con los medicamentos que ya mi familia me. Avía comprado y tampoco me dieron. Los resultados para ver si  era cálculos o pancrias  lo cuales la doctora de turno. No dejo. Que me. Quedé para. Ver mis resultados y solo me dió de alta ', 2, 1, 1, '2021-12-02 17:40:57', NULL, 1),
(80, 'LR-2021-00036', '2021-08-31', NULL, 1, '06820487', NULL, 'LUIS ALBERTO', 'SAYAVERDE', 'ZURITA', 1, 'luissayaverde6@gamil.com', '957433068', 15, 127, 1260, 'ASENTAMIENTO HUMANO SAN JOSE MZ H LOTE 2 DISTRITO DE CARBAYLLO KM2 ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-08-31', 21, 112, 'abuso de autoridad por parte de la empresa particular de seguridad servis athenas , con los agentes de seguridad privada  femenino peña , obstaculizandome la salida  y el libre transito cuando mi persona no se encuentra de turno  en momentos que yo me retiro  por la puerta de emergencia ,  a pesar de las explicaciones insistio  en retenerme , asi mismo pongo en conocimiento la falta de libro de reclamaciones de esta empresa de seguridiad hecho que  es contrario a la ley .', 2, 1, 1, '2021-12-09 16:13:28', NULL, 1),
(81, 'LR-2021-00037', '2021-09-08', NULL, 1, '00823498', NULL, 'ROSA', 'CHOQUE', 'AYMA', 2, 'rosachoqueayma1972@gmail.com', '960807685', 15, 127, 1256, 'MZ A LOTE 23 PROGRAMA DE VIVIENDA STA ISABEL - CENTRO POBLADO RURAL PUNCHAUCA CARABAYLLO ', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-09-06', 18, 105, 'Buenas tardes Hago una denuncia contra el orientador de salud de citas del Área de Cosultas Externas   del ambiente de Emergencia fecha 6-9-2021 hora de 10:40 am a 3 pm área de sala quien no portaba un carnet de identificación de unos 50 años de edad promedio tez trigueño Necesito se le investigue y se abra cámara que creo no direcciona a la parte donde acomoda a un hombre o lo infiltra detrás de mi quien estuvo manoteándome ósea poniéndome la mano encima hasta empujándome por el hombro para que yo avance las sillas el arrastraje largo horizontal  en ese momento doliéndome la columna y con sueño por no haber dormido durante la madrugada por los sonidos eléctricos de bomba de agua de la casa Mz A Lte 20 de PdVSta Isabel del costado de mi domicilio Tremendo problemón para mi me genera esto ya que mi vista esta disminuida lo que escribo apenas veo la estoy viviendo difícil hasta  reclamar IMPLICA GASTO Queja contra ruidos molestos CODIGO 0521232/ E2135774 /8-9-2021/ en el Municipio de Carabayllo con tanta papelería inútil solo manipulación a tener que hablar redactar Estoy cagada HC: 1148430 dentro del hospital Sergio Bernales así como ese señor cual puesto detrás de mi por el orientador en el 2017 han llegado hasta ponerme el trasero en la cara cual bombardearme con coincidencias de olores fétidos o anestésicos que duermen o desconcentran  COMO ANTE CAMARA PUEDE ocurrirme tragedias cual provocada a reaccionar a decir algo Discúlpenme pero es recurrente por cierto como saber QUE ESTAN BUSCANDO RATIFICAR DE QUE ME SIRVE SUS HISTORIAS CLINICAS POR DIOS ESTOY HARTA hasta de lo que me pusieron  EN PSIQUIATRIA  ME LO SUBIRAN A 200? Yo no puedo estar siendo tocada en todo caso me voy a esperar a otra parte y de lejos hasta mi turno prefiero ver a la gente  POR FAVOR BOTEN AL ORIENTADOR Y TRABAJADOR DE VENTANILLA CREO TAMBIEN ES Como es posible que me haga pelear TENGO MAREOS ESTOY COMO HINCHADA CON DOLOR DE CABEZA Y DOLOR EN LOS OIDOS Necesito tener la tranquilidad de saber que no tengo cáncer en los senos luego de haberme golpeado ahí las puertas  de un ómnibus de la LINEA 13 ET STA CRUZ el 16-03-2021 tanto a esa mafia le arde me hayan recibido la denuncia que tiene que enlodarme o que ? Disculpe pero estoy recontra molesta Perdí hasta el trabajo  Gracias ', 2, 1, 1, '2021-12-09 16:13:29', NULL, 1),
(82, 'LR-2021-00038', '2021-09-12', NULL, 1, '71731347', NULL, 'ALMENDRA ROCCIO', 'CRUZ', 'RAMOS', 2, 'caralbert.c@gmail.com', '915371876', 15, 127, 1260, 'AV.CERO DE PASCO #669 - PUEBLO JOVEN LA LIBERTAD  -COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-09-11', 18, 102, 'Hoy ingresé a mi menor hija de nombre Mía Belén Sánchez Cruz, quien sufrió una fractura de brazo, la lleve al hospital en collique, desde que llegué hasta el momento en el que me retiré no se dignaron a darle una pastilla ni la atención adecuada para una niña con una fractura, además de ello quisieron obligarme a firmar el alta de mi menor hija y que la traslade a otro nosocomio, el nombre del doctor que no atendió a mi hija es Arturo Arbildo Zambrano, quien me trató mal, diciéndome que si no me gustaba su atención valla a una clínica, que para eso uno debe ser profesional, cuando m acerqué a pedir el cuaderno de reclamaciones escrito se negaron a dármelo, me atendió el dr. Vega Rojas Maiquel quien me dijo ser encargado del libro de reclamaciones al estar de jefe de piso, se negó a darme el libro y me pidió que no haga ningún reclamo, que de ser así la atención de mi hija demoraría más, pésima atención, mal trato y una total indiferencia por parte del personal médico ', 2, 1, 1, '2021-12-09 16:13:30', NULL, 1),
(83, 'LR-2021-00039', '2021-09-13', NULL, 1, '47660342', NULL, 'PEDRO', 'MARIN', 'NAVARRO', 1, 'pmarin.binda@gmail.com', '987905792', 15, 127, 1260, 'PROL. LOS ANGELES MZ \"LL\" LTE 42 URBANIZACION SANTA LUZMILA', 1, '06863557', 'PEDRO', 'MARIN', 'SAAVEDRA', NULL, 'pmarin.binda@gmail.com', 'PROL. LOS ANGELES MZ \"LL\" LTE 42 URBANIZACION SANTA LUZMILA', '959478641', 1, 1, '2021-09-10', 18, 102, 'El usuario fue sometido a una colecistectomía, han pasado 3 días para que concluyan que necesita una colangiopancreatografia retrograda endoscópica(CPRE). Cuando las imágenes de colangioresonancia le fue entregada al cirujano (imágenes que nadie vio ni saben donde están)el día 10 en donde claramente se podía concluir la necesidad de una CPRE. Ahora se hacen los preocupados en referirlo a otro nosocomio, actitud que me indigna ya que hace algunos años mi esposa falleció en este hospital esperando la bendita referencia. Exijo que asuman su responsabilidad para que mi hijo sea trasladado de manera inmediata a un nosocomio que tenga especialistas responsables que puedan realizar el denominado CPRE.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(84, 'LR-2021-00040', '2021-10-01', NULL, 1, '09543875', NULL, 'JOHN WILBER', 'HERRERA', 'RAMOS', 1, 'jhr_1969@hotmail.com', '994581300', 15, 127, 1256, 'JR. MADRE SELVA 333 SANTA ISABEL DISTRITO DE CARBAYLLO', 1, '09543875', 'JOHN WILBER', 'HERRERA', 'RAMOS', NULL, 'jhr_1969@hotmail.com', 'JR.MADRE SELVA 333 SANTA ISABEL DISTRITO DE CARABAYLLO', '994581300', 1, 1, '2021-10-01', 21, 112, 'Me apersone a la puerta principal del hospital solicitando mi ingreso mostrando mi pase emitido Dr Ivan Sueldo M  por paciente adulto mayor y requiere apoyo en su alimentación y asimismo atender lo que se requiere en la compra de medicinas  y exámenes médicos que no  presta el hospital. El vigilante observa mi pase aduciendo que no tiene fecha fingió llamar x telf y me dijo que a las 11 reclamo, me dice PREPOTENTE si  no estaba de acuerdo que retire a mi  paciente y que me lo lleve. LOS VIGILANTES TIENEN POTESTAD PARA VOTAR A LOS PACIENTES DEL HOSPITAL  Y DAR MAL TRATO A LOS FAMILIARES QUE PRESTAMOS APOYO EN LA ATENCIÓN SUS PACIENTES, EXIJO SANCIÓN  PARA LOS 02 VIGILANTES DE LA PUERTA PRINCIPAL DE INGRESO.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(85, 'LR-2021-00041', '2021-10-05', NULL, 1, '48859784', NULL, 'EMMYMAR IBETH', 'CABRERA', 'LINARES', 2, 'emmymar188@gmail.com', '945958090', 15, 127, 1260, 'SAN CARLOS, COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-10-03', 18, 105, 'Mi hija de un año de edad estaba hospitalizada en el pabellón 3 de pediatría cama 1 Ema Lima Cabrera, En la noche del 3 de octubre desde las 9 hasta las 10.30  estaba llorando para descansar pero no podía ya que un familiar de otro paciente estaba viendo noticias y luego música en su celular en alto volumen a menos de un metro de distancia de mi menor hija, le comunique del inconveniente a un oerosnal de salud quien solo le pidió a esta persona que bajara el volumen a lo que hizo caso omiso, se le dió prioridad al disfrute de un adulto ante al bienestar de un menor en estado de hospitalización que tiene derecho a la salud, mi bebé de un año no pudo dormir hasta que esa persona no apagó su teléfono a las 10.30 pm. Mi hija solo pudo dormir 4 horas lo que afecto su estado anímico en general. El ruido de los adultos debe estar prohibido en horas nocturnas, los bebés no pueden esperar hasta altas horas de la noche para dormir y menos estando mal de salud la prioridad del área de hospitalización no debe ser el disfrute de los padres si no la recuperación de los niños. ', 2, 1, 1, '2021-12-09 16:13:31', NULL, 1),
(86, 'LR-2021-00042', '2021-11-08', NULL, 1, '40195996', NULL, 'MONICA NOHEMI', 'ROSAS', 'SANCHEZ', 2, 'rosasmn@hnseb.gob.pe', '5580186', 15, 127, 1282, 'COMAS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-11-08', 19, 108, 'prueba de funcionamiento', 2, 1, 1, '2021-12-09 16:13:34', NULL, 1),
(87, 'LR-2021-00043', '2021-11-10', NULL, 1, '23441047', NULL, 'RAUL', 'SUAREZ', 'BARRIOS', 1, 'rsubar3@gmail.com', '957459036', 15, 127, 1256, 'CALLE 27 DE NOVIEMBRE MZ 5J, LOTE 16, EL PROGRESO', 1, '23441047', 'RAUL', 'SUAREZ', 'BARRIOS', NULL, 'rsubar3@gmail.com', 'CALLE 27 DE NOVIEMBRE MZ 5J, LOTE 16, EL PROGRESO', '957459036', 1, 1, '2021-11-10', 21, 112, 'El paciente SEGUNDO BERNARDO ABANTO MERINO, se encuentra hospitalizado desde el 11/10/2021 debido a una caída que sufrió en su domicilio.\r\nEstuvo en UCI, hasta el 07/11/21, ese día a las 18:40 horas del día, el Dr. Moreno, llamó a Madeleine Abanto, hija del paciente,  comunicando que el paciente había sufrido una caída, y tenía daños físicos y tuvieron que sacarle la tomografía, coserle una de las heridas, con tres puntos, y se quedó con rasguños en la parte superior de la cabeza, y otros golpes más.\r\nA partir del accidente, viene sintiendo dolores y nauseas, que en UCI no presentaba, lo cual nos obliga a recurrir y hacer el RECLAMO.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(88, 'LR-2021-00044', '2021-11-10', NULL, 1, '06822080', NULL, 'SEGUNDO BERNARDO', 'ABANTO', 'MERINO', 1, 'rsubar3@gmail.com', '957459036', 15, 127, 1256, 'CALLE 27 DE NOVIEMBRE MZ 5J LOTE 16 EL PROGRESO ', 1, '23441047', 'RAUL', 'SUAREZ', 'BARRIOS', NULL, 'rsubar3@gmail.com', 'CALLE 27 DE NOVIEMBRE MZ 5J LOTE 16 EL PROGRESO ', '957459036', 1, 1, '2021-11-07', 18, 107, 'El paciente que se encontraba en UCI desde el 11/10/21, pasó  a sala de recuperación y sufrió una caída, el 07/11/21, habiendose dañando la parte frontal de la cabeza con resultados para tomografía y cerradura de herida con tres puntos de sutura por negligencia en la atención, actualmente presenta nauseas y dolores que en UCI no presentaba, la familia exige explicación y sanción a los responsables.', 2, 1, 1, '2021-12-09 17:52:12', NULL, 1),
(89, 'LR-2021-00045', '2021-11-11', NULL, 1, '10600063', NULL, 'OMAR RAFAEL', 'SOTO', 'PEÑA', 1, 'omarosa_29@hotmail.es', '992641936', 15, 127, 1253, 'CALLE ESCORPION 172 SOL DE VITARTE', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-11-10', 17, 98, 'El dia de hoy llame a reclamos de essalud donde me informan que el dia de ayer 10 de noviembre fui programado para una ecografia abdominal la cual no e sido notificado.segundo el dia de ayer miercoles 10 del pte. Ingrese a emergencia por calculos renales tengo la documentacion donde sustento lo sucedido a mi persona estoy q llamo al voto bernales infinidad de veces y no contestan por eso hago este reclamo para que se me reprograme y se me envie a mi celular x msj de texto ó correo correctamente.', 2, 1, 1, '2021-12-09 16:13:32', NULL, 1),
(90, 'LR-2021-00046', '2021-11-11', NULL, 1, '06573462', NULL, 'ROSA MARIA', 'QUISPE', 'GONZALES', 2, 'omarosa_29@hotmail.es', '991700619', 15, 127, 1253, 'CALLE ESCORPION 172 SOL DE VITARTE', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-11-11', 16, 79, 'Desde el año 2020 e presentado a referecia documentos para tener una cirugia por varices.e llamado al area de referencia de la principal y me dicen que mi referencia esta observada en el 2020 a pesar que hace 1. Mes y medio pedia que volvieran a enviar mi referencia donde e sido asignada y nada se me informa q no a sido reenviada la misma llamo a referencia del voto bernales por varios dias y no contestan y cortan la llamada mis molestias van en aumento y no obtengo respuestas favorable para mi persona.', 2, 1, 1, '2021-12-09 16:13:34', NULL, 1),
(91, 'LR-2021-00047', '2021-11-20', NULL, 1, '41059515', NULL, 'LIZBETH LOURDES', 'MONTERO', 'VILLAR', 2, 'lilumv@gmail.com', '915365752', 15, 127, 1287, 'JR MANCO CAPAC 517', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2021-11-20', 18, 101, 'No puedo solicitar una cita a imagenologia estoy que llamo desde el miercoles al numero 015960577 opc 1 y se cae la llamada nunca ingresa la opcion 2 dice que nunca podran ayudarme porque no es su area fui precencialmente al seguro y vigilancia no deja entrar y dicen que es por telefono y su central telefonica esta malograda y mi salud EMPEORA NO TENGO TRATAMIENTO NECESITO LA RADIOGRAFIA Y POCO LES IMPORTA NO TIENEN OTRO NUMERO SOLICITO QUE REVISEN SU HISTORIAL DE LLAMADAS DE LA OPC 1 NUNCA FUNCIONA SOLICITO LA CITA PARA LA REDIOGRAFICA Y PODER SACAR MI CITA CON ESTO PONEN EN PELIGRO MI SALUD YA QUE SE AGRABA', 2, 1, 1, '2021-12-09 16:13:36', NULL, 1),
(92, 'LR-2021-00048', '2021-12-11', NULL, 1, '75945913', NULL, 'JOEL', 'MUÑOZ', 'FERNANDEZ', 1, 'munozfernandezjoel@gmail.com', '982674017', 15, 127, 1260, 'JR. NICOLÁS DE PIÉROLA 260 URB. LA LIBERTAD', 1, '09737631', 'SILVIA ROSARIO', 'FERNANDEZ', 'VALLEJO', NULL, 'rosariofv2711@gmail.com', 'JR. NICOLÁS DE PIÉROLA 260', '933834483', 1, 1, '2021-12-10', 16, 88, 'El día 10 de diciembre mi madre, Silvia Rosario Fernandez Vallejo, fue trasladada al área de ginecología para ser hospitalizada debido a una hemorragia uterina, se negaron a atender a mi madre y brindarle una cama debido a una disposición interna de no introducir celulares con la excusa de \"poder grabar\". Sinceramente no sé si ello es legal o qué es lo que no quieren que graben. Tengo la necesidad de comunicarme con mi madre por temas de conocimientos farmaceúticos y de dietas por parte de ella para mi padre, quien es una persona discapacitada visual, diabética e hipertensa. Me niegan a brindarle un medio de comunicación con la justificación de tener una normativa interna de prohibir el uso de celular con la penalidad de negar la atención a una paciente en situación de emergencia.', 2, 1, 1, '2021-12-11 05:03:36', NULL, 1);
INSERT INTO `sc_reclamo` (`idReclamo`, `correlativo`, `fechaReclamo`, `horaReclamo`, `tipoDoc`, `nDoc`, `razonSocial`, `nombres`, `apellidoPat`, `apellidoMat`, `sexo`, `email`, `telefono`, `departamento`, `provincia`, `distrito`, `domicilio`, `tipoDocR`, `nDocR`, `nombresR`, `apellidoPatR`, `apellidoMatR`, `rsocialR`, `emailRep`, `domicilioR`, `telefonoR`, `regsRep`, `tipoUsuario`, `fechaOcurrencia`, `derecho`, `causaEspecifica`, `detalleReclamo`, `estadoRec`, `etapaReclamo`, `resulRec`, `registroSistema`, `autogenerado`, `autoCorreo`) VALUES
(93, 'LR-2021-00049', '2021-12-21', NULL, 1, '72739003', NULL, 'BLANCA NICOL', 'CELESTINO', 'MONASI', 2, 'cmariaferanda@gmail.com', '993796517', 15, 127, 1260, 'JIRÓN TUNGASUCA 230', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2021-12-21', 16, 96, 'Planificación familiar nunca se encuentra abierto. Llamo y dicen que puedo ir a cualquier hora pero es la tercera vez que vengo y esta cerrado. ', 2, 1, 1, '2021-12-21 18:23:52', NULL, 1),
(94, 'LR-2022-00001', '2022-01-11', NULL, 1, '16176247', NULL, 'EDWIN DONATO', 'RODRIGUEZ', 'OSORIO', 1, 'rodriguezedwin800@gmail.com', '959776184', 15, 127, 1268, 'JUAN VELASCO ALVARADO MZF-LTE30-CTE-2', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2022-01-11', 16, 82, 'La institución ha puesto ha  disposición números telefónicos para sacar citas, pero nunca responden. ¡NUNCA!\r\nNo hay un modo de acceder a información sobre citas, ni siquiera en la página del facebook. \r\nMencionan que podemos llamar pero no responde nadie y cortan la llamada.', 2, 1, 1, '2022-01-11 15:49:19', NULL, 1),
(95, 'LR-2022-00002', '2022-01-17', NULL, 1, '70572883', NULL, 'BILLY JAMES', 'MONTORO', 'ALCANTARA', 1, 'billymontoro@gmail.com', '922605950', 15, 127, 1260, 'CARABAYLLO, EL PORVENIR, MZ.D LT.7 LOS JAXMINES', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2022-01-17', 16, 81, 'El día lunes 17 de enero del 2022 tuve cita con el doctor de traumatología a horas 11 AM, el cual me mandó a sacar cita con una orden para examen radiológico de rodilla, al ir a sacar la cita el señor encargado de atender me niega la orden debido a malogrado la máquina de radiografia', 2, 1, 1, '2022-01-17 17:03:15', NULL, 1),
(96, 'LR-2022-00003', '2022-01-18', NULL, 1, '21279295', NULL, 'JACQUELINE ROCIO', 'HUAMAN', 'MORALES', 2, 'jacquelinerociohuaman@gmail.com', '955647989', 15, 127, 1251, 'CALLE TRINIDAD MORAN 248 URB. EL RETABLO 1RA ETAPA - COMAS', 1, '21279295', 'JACQUELINE ROCIO', 'HUAMAN', 'MORALES', NULL, 'jacquelinerociohuaman@gmail.com', 'CALLE TRINIDAD MORAN 248 URB. EL RETABLO 1RA ETAPA - COMAS', '955647989', 1, 1, '2022-01-18', 16, 79, 'El día de hoy por indicación de mi médico del centro de salud materno infantil santa luzmila II, llamé al departamento de medicina física  y rehabilitación para que me facilitaran una referencia para mi menor hijo hacia el instituto nacional de rehabilitación.\r\nProcedimos a llamar al departamento de medicina física y rehabilitación del hospital Sergio Bernales y el encargado de responder las llamadas simplemente no escucha y cuelga el teléfono.\r\nEsto claramente vulnera los derechos de mi menor hijo a ser atendido y obstaculiza desde ya su rehabilitación en el INR. Quedo muy decepcionada y sobretodo que lamentable la imagen que dejan como hospital nacional. Esperamos la solución pronta para que mi menor hijo pueda seguir su rehabilitación a tiempo.', 2, 1, 1, '2022-01-18 16:54:04', NULL, 1),
(97, 'LR-2022-00004', '2022-01-29', NULL, 1, '44580099', NULL, 'CARMEN ROSA', 'QUIQUE', 'YAPU', 2, 'carito_279_55@hotmail.com', '999912391', 15, 127, 1260, 'AV. HONDURAS 342', 1, '44580099', 'CARMEN ROSA ', 'QUIQUE', 'YAPU', NULL, 'carito_279_55@hotmail.com', 'AV. HONDURAS 342', '999912391', 1, 1, '2022-01-28', 16, 82, 'Mi queja es ante la demora de  emitir una cita, como mínimo más de 2 meses para una cita si se va en los primeros días permitidos indicados por caja, el cuál es el día 22 de cada mes, sin embargo no necesariamente es ese día por experiencia propia.\r\nLos Doctores emiten una cita aproximada, pero no se puede realizar en esos días ya que no hay cupos por lo mencionado anteriormente( son a partir del 22 de cada mes y las citas inician un mes un después), no cumpliendo así con la cita de los doctores. Me parece que no deben emitir citas programadas si los  doctores emiten otras fechas, eso implica la demora en las citas y las soluciones a los problemas de salud de los pacientes que se agravan día con día. \r\nMi padre: atención Marzo 2021 pasó de próstata 2 a 3 y con esta demora puede ser CANCER.\r\n\r\n', 2, 1, 1, '2022-01-29 22:55:28', NULL, 1),
(98, 'LR-2022-00005', '2022-02-09', NULL, 1, '44580099', NULL, 'CARMEN ROSA', 'QUIQUE', 'YAPU', 2, 'carito_279_55@hotmail.com', '999912391', 15, 127, 1260, 'AV. HONDURAS 342 URB. EL PARRAL', 1, '44580099', 'CARMEN ROSA ', 'QUIQUE', 'YAPU', NULL, 'carito_279_55@hotmail.com', 'AV. HONDURAS 342 URB. EL PARRAL', '999912391', 1, 1, '2022-01-28', 16, 82, 'Mi queja es ante la demora de emitir una cita, como mínimo más de 2 meses para una cita si se va en los primeros días permitidos indicados por caja, el cuál es el 22 de cada mes, sin embargo no necesariamente ese día por experiencia propia. Los doctores emiten una cita aproximada, pero no se puede realizar en esos días ya que no hay cupos por lo mencionado anteriormente (son a partir del 22 de cada mes y las citas inician un mes después), no cumpliendo así con la cita de los doctores. Me parece que no deben emitir citas programadas si los doctores emiten otras fechas, eso implica la demora en obtener las citas y las soluciones a los problemas de salud de los pacientes que se agravan día a día. Mi padre: atención Marzo 2021 pasó de próstata 2 a 3 y con esta demora puede ser CANCER. ', 2, 1, 1, '2022-02-09 19:22:22', NULL, 1),
(99, 'LR-2022-00006', '2022-02-09', NULL, 1, '06846127', NULL, 'NICOLAS HECTOR', 'CARDENAS', 'REYES', 1, 'nicolas.hector1955@gmail.com', '949227063', 15, 127, 1260, 'AAHH SAN JUAN BAUTISTA 3RA ETAPA MZ I LT 13', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2022-01-06', 18, 105, 'Que no hay insumos en el área de rayos x , y me mandan a que me queje al director del hospital.\r\nY para los pacientes que están hospitalizados si hay insumos, pero cuando lo solicito, no hay.', 2, 1, 1, '2022-02-09 20:18:49', NULL, 1),
(100, 'LR-2022-00007', '2022-02-11', NULL, 2, '003895153', NULL, 'GABRIEL JOSÉ', 'HERRERA', 'VALERA', 1, 'gaboo.h81@gmail.com', '993535571', 15, 127, 1287, 'URB ZARATE, JIRON TIAHUANACO 904', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2022-02-11', 16, 92, 'Me atendió en traje y me redirigió a medicina general. Los vigilantes me tenían paseando de un lado para el otro. Y no me dejaron ir a admisión, cuando me tocó el turno de atención. La doctora tuesta me dice q no estoy registrado. Q vuelva a admisión toda la mañana perdida. Creo q hubo discriminación', 2, 1, 1, '2022-02-11 15:15:50', NULL, 1),
(101, 'LR-2022-00008', '2022-02-25', NULL, 1, '23975114', NULL, 'VLADIMIR', 'BORDA', 'BELIZARIO', 1, 'vladybobe@gmail.com', '979023076', 15, 127, 1255, 'JR RUIZ GALLO 668', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3, '2022-02-25', 21, 112, 'Presente una solicitud de fecha 15 nov del 2021 con N de registro  011795,  no hubo respuesta alguna de la parte de la institución tanto por correo y teléfono por lo que el día 28 de enero me apersone al área de personal de hospital, recién se pusieron a buscar repondiendo argumentos para justificar su falta, llegue hasta entrevistarme con el jefe de persona Sr Jhonatan  Muñoz donde el mismo se comprometió en resolver y dar respuesta a la solicitud en una semana , me facilitó su N cel  974599263 indicando q me enviaría por correo o whassap, después de varias llamadas sin éxito decidí hacer mi reclamo no puede ser que un oficio esté sin responder desde 15 nov del 2021 hasta hoy, a donde más debo  de recurrir para obtener este documento que me es urgente, gracias ', 2, 1, 1, '2022-02-25 17:38:10', NULL, 1),
(102, 'LR-2022-00009', '2022-03-09', NULL, 1, '80275575', NULL, 'FERNANDO TEOFILO', 'EUGENIO', 'GUTIERREZ', 1, 'siempre--fernando@hotmail.com', '947354705', 15, 127, 1260, 'JR COLMENA 1002 PJ LA LIBERTAD DISTRITO DE COMAS', 1, '80275575', 'FERNANDO TEOFILO', 'EUGENIO', 'GUTIERREZ', NULL, 'siempre--fernando@hotmail.com', 'JR. COLMENA 1002 PJ LA LIBERTAD  DISTRITO DE COMAS', '947354705', 1, 1, '2022-03-09', 18, 102, 'Médico jefe no da la atención debida y su actuar anti ético es de lo peor con la paciente de nombre Eugenio utia Verónica Edith que tiene fractura con los exámenes ya correspondientes la tiene en observación sin proceder a hospitalizarle solicito una investigación al médico jefe de turno 09 de marzo del 2022 solicitando su investigación ', 2, 1, 1, '2022-03-09 05:31:21', NULL, 1),
(105, 'LR-2022-00010', '2022-03-14', NULL, 1, '19961222', NULL, 'TITO GODOFREDO', 'GUTARRA', 'GARCIA', 1, 'tigoguga@hotmail.com', '970594948', 15, 127, 1253, 'MZ E LOTE 19 ASOC. VILLA SAN LUIS', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2022-03-14', 16, 82, 'No encuentro cita a endocrinología y habiendo obtenido cita virtual esta no se dio, quedaron en reprogramar y a la fecha no se cumple. ', 2, 1, 1, '2022-03-14 12:30:09', NULL, 1),
(106, 'LR-2022-00011', '2022-03-17', NULL, 1, '09459466', NULL, 'MONICA MARISOL', 'GUTIERREZ', 'PIMENTEL', 2, 'melissa_sedano@hotmail.com', '946538404', 15, 127, 1260, 'JR SANTA ROSA 681', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, '2022-03-17', 16, 82, 'El dia 02/03/2022 obtuve un accidente entre por emergencia me caí de cabeza me hicieron 6 puntos en la cabeza, necesito que acepte mi referencia con neurocirugía en el hospital collique  y hasta el momento no lo aceptan , sufro de mareos, me tiembla las piernas y me duele la cabeza.\r\nPor favor  ', 2, 1, 1, '2022-03-17 14:43:48', NULL, 1),
(107, 'LR-2022-00012', '2022-04-09', '13:22:27', 1, '07490976', '', 'PEDRO ', 'CARGUACHIN', 'SANCHEZ', 1, 'solracdro@yahoo.com', '946300180', 15, 127, 1256, 'CALLE X MZ H2 LT37', 0, '', '', '', '', '', '', '', '', 2, 1, '2022-04-08', 18, 101, ' hoy sábado 8/4  /22 siendo las 10 :00 am  en la ventanilla 2 el señor  Rivero me pide que el papel de cita adicional díga cita \" adicional\" si no no me puede atender accedo a su petición voy donde la enfermera de oftalmología  y pone el sello de adicional , regreso ala ventanilla y este señor mala gracia me dice que lo eh falsificado que no me puede atender   que tiene que ir la enfermera  que clase de atenido da este señor para eso le pagan trántandome como falsificador  que clase de trabajo tienen  gana dinero sentado.', 2, 1, 1, '2022-04-09 18:22:27', 'LRV20220409131147fd2b6aa0cae72ca8a3d979dac3084cc5c035d622', 1);

--
-- Disparadores `sc_reclamo`
--
DELIMITER $$
CREATE TRIGGER `GENERAR_CORRELATIVO_RECLAMO` BEFORE INSERT ON `sc_reclamo` FOR EACH ROW BEGIN
    DECLARE cont1 int default 0;
    DECLARE anio text;
    set anio = (SELECT YEAR(CURDATE()));
    SET cont1= (SELECT count(*) FROM sc_reclamo WHERE year(fechaReclamo) = year(now()));
    IF (cont1 < 1) THEN
    SET NEW.correlativo = CONCAT('LR-',anio,'-', LPAD(cont1 + 1, 5, '0'));
    ELSE
    SET NEW.correlativo = CONCAT('LR-',anio,'-', LPAD(cont1 + 1, 5, '0'));
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_respuestarec`
--

CREATE TABLE `sc_respuestarec` (
  `idRespuesta` int(11) NOT NULL,
  `fechaRespuesta` date DEFAULT NULL,
  `idReclamoR` int(11) DEFAULT NULL,
  `detalleRespuesta` text COLLATE utf8_bin,
  `usuarioReg` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_resultadorec`
--

CREATE TABLE `sc_resultadorec` (
  `idResultado` int(11) NOT NULL,
  `descResultado` text COLLATE utf8_bin,
  `codResultado` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_resultadorec`
--

INSERT INTO `sc_resultadorec` (`idResultado`, `descResultado`, `codResultado`) VALUES
(1, 'PENDIENTE', '0'),
(2, 'FUNDADO', '1'),
(3, 'FUNDADO PARCIAL', '2'),
(4, 'INFUNDADO', '3'),
(5, 'IMPROCEDENTE', '4'),
(6, 'CONCLUIDO ANTICIPADAMENTE', '5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_sexo`
--

CREATE TABLE `sc_sexo` (
  `idSexo` int(11) NOT NULL,
  `descSexo` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_sexo`
--

INSERT INTO `sc_sexo` (`idSexo`, `descSexo`) VALUES
(1, 'MASCULINO'),
(2, 'FEMENINO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_sugerencia`
--

CREATE TABLE `sc_sugerencia` (
  `idSugerencia` int(11) NOT NULL,
  `correlativoSug` text COLLATE utf8_bin,
  `fechaSugerencia` date DEFAULT NULL,
  `horaSugerencia` time DEFAULT NULL,
  `tDoc` int(11) DEFAULT NULL,
  `nDoc` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `nombresAp` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `edad` int(11) DEFAULT '0',
  `sexoSug` int(11) DEFAULT NULL,
  `telefono` text COLLATE utf8_bin,
  `distrito` int(11) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `detalleSugerencia` text COLLATE utf8_bin,
  `autogenerado` text COLLATE utf8_bin,
  `estadoDoc` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_sugerencia`
--

INSERT INTO `sc_sugerencia` (`idSugerencia`, `correlativoSug`, `fechaSugerencia`, `horaSugerencia`, `tDoc`, `nDoc`, `nombresAp`, `edad`, `sexoSug`, `telefono`, `distrito`, `email`, `detalleSugerencia`, `autogenerado`, `estadoDoc`) VALUES
(1, 'LS-2021-000001', '2021-11-30', '11:06:29', 1, '77478995', 'OLGER IVAN CASTRO PALACIOS', 25, 1, '914907409', 1260, 'olger60019castro@gmail.com', 'prueba de sugerencia', NULL, 1);

--
-- Disparadores `sc_sugerencia`
--
DELIMITER $$
CREATE TRIGGER `GENERAR_CORRELATIVO_SUGERENCIA` BEFORE INSERT ON `sc_sugerencia` FOR EACH ROW BEGIN
    DECLARE cont1 int default 0;
    DECLARE anio text;
    set anio = (SELECT YEAR(CURDATE()));
    SET cont1= (SELECT count(*) FROM sc_sugerencia WHERE year(fechaSugerencia) = year(now()));
    IF (cont1 < 1) THEN
    SET NEW.correlativoSug = CONCAT('LS-',anio,'-', LPAD(cont1 + 1, 5, '0'));
    ELSE
    SET NEW.correlativoSug = CONCAT('LS-',anio,'-', LPAD(cont1 + 1, 5, '0'));
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_tipodocumento`
--

CREATE TABLE `sc_tipodocumento` (
  `idTipoDoc` int(11) NOT NULL,
  `codigoSeti` text COLLATE utf8_bin,
  `abrvTipDoc` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `detalleTipDoc` text COLLATE utf8_bin,
  `longTipDoc` int(11) UNSIGNED DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_tipodocumento`
--

INSERT INTO `sc_tipodocumento` (`idTipoDoc`, `codigoSeti`, `abrvTipDoc`, `detalleTipDoc`, `longTipDoc`) VALUES
(1, '1', 'DNI', 'Documento Nacional de Identidad', 8),
(2, '2', 'CE', 'Carnet de Extranjeria', 12),
(3, '3', 'PAS', 'Pasaporte', 12),
(4, '4', 'DIE', 'Documento de Identidad Extranjero', 12),
(5, '5', 'CUI', 'Código Único de Identificación', 8),
(6, '6', 'CNV', 'Certificado de Nacido Vivo', 8),
(7, '11', 'RUC', 'Registro Único de Contribuyente', 11),
(8, '12', 'PTP', 'Permiso Temporal de Permanencia', 9),
(9, 'A', 'OTROS', 'Otros tipos', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_tiposparametro`
--

CREATE TABLE `sc_tiposparametro` (
  `idTipParametro` int(11) NOT NULL,
  `descTipParam` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_tiposparametro`
--

INSERT INTO `sc_tiposparametro` (`idTipParametro`, `descTipParam`) VALUES
(1, 'Correo'),
(2, 'Nombre Año'),
(3, 'Decenio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_tipousuario`
--

CREATE TABLE `sc_tipousuario` (
  `idTipUsuario` int(11) NOT NULL,
  `descTipUsuario` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_tipousuario`
--

INSERT INTO `sc_tipousuario` (`idTipUsuario`, `descTipUsuario`) VALUES
(1, 'SIS'),
(2, 'SOAT'),
(3, 'PARTICULAR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sc_usuario`
--

CREATE TABLE `sc_usuario` (
  `idUsuario` int(11) NOT NULL,
  `idPerfil` int(11) DEFAULT NULL,
  `idEstado` int(11) DEFAULT '2',
  `dni` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `apellidos` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `nombres` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `cuenta` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `clave` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `intentos` int(11) DEFAULT NULL,
  `fechaAlta` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `sc_usuario`
--

INSERT INTO `sc_usuario` (`idUsuario`, `idPerfil`, `idEstado`, `dni`, `apellidos`, `nombres`, `cuenta`, `correo`, `clave`, `intentos`, `fechaAlta`) VALUES
(1, 1, 1, '77478995', 'CASTRO PALACIOS', 'OLGER IVAN', 'ocastrop', 'ocastrop@hnseb.gob.pe', '$2a$07$usesomesillystringforeVF6hLwtgsUBAmUN4cGEd8tYF74gSHRW', 1, '2022-03-29 17:19:45'),
(2, 1, 1, '10000000', 'QS', 'ADMIN', 'adminqs', 'ocastrop@hnseb.gob.pe', '$2a$07$usesomesillystringforeVF6hLwtgsUBAmUN4cGEd8tYF74gSHRW', 0, '2021-06-01 15:34:46');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `sc_amconsulta`
--
ALTER TABLE `sc_amconsulta`
  ADD PRIMARY KEY (`idAccionMC`),
  ADD KEY `consultaId` (`idConsultaMC`);

--
-- Indices de la tabla `sc_amsugerencia`
--
ALTER TABLE `sc_amsugerencia`
  ADD PRIMARY KEY (`idAccionMS`),
  ADD KEY `sugerenciaId` (`idSugerenciaMS`);

--
-- Indices de la tabla `sc_causaespecifica`
--
ALTER TABLE `sc_causaespecifica`
  ADD PRIMARY KEY (`idCausaEsp`),
  ADD KEY `derechoidd` (`derechoId`);

--
-- Indices de la tabla `sc_consulta`
--
ALTER TABLE `sc_consulta`
  ADD PRIMARY KEY (`idConsulta`);

--
-- Indices de la tabla `sc_departamento`
--
ALTER TABLE `sc_departamento`
  ADD PRIMARY KEY (`idDepartamento`);

--
-- Indices de la tabla `sc_derecho`
--
ALTER TABLE `sc_derecho`
  ADD PRIMARY KEY (`idDerecho`);

--
-- Indices de la tabla `sc_distrito`
--
ALTER TABLE `sc_distrito`
  ADD PRIMARY KEY (`idDistrito`),
  ADD KEY `provID1` (`provId`);

--
-- Indices de la tabla `sc_estadodoc`
--
ALTER TABLE `sc_estadodoc`
  ADD PRIMARY KEY (`idEstadoDoc`);

--
-- Indices de la tabla `sc_estadoitem`
--
ALTER TABLE `sc_estadoitem`
  ADD PRIMARY KEY (`idEstadoItem`);

--
-- Indices de la tabla `sc_estadoreclamo`
--
ALTER TABLE `sc_estadoreclamo`
  ADD PRIMARY KEY (`idEstadoRec`);

--
-- Indices de la tabla `sc_estusuario`
--
ALTER TABLE `sc_estusuario`
  ADD PRIMARY KEY (`idEstadoUs`);

--
-- Indices de la tabla `sc_etapasrec`
--
ALTER TABLE `sc_etapasrec`
  ADD PRIMARY KEY (`idEtapa`);

--
-- Indices de la tabla `sc_parametros`
--
ALTER TABLE `sc_parametros`
  ADD PRIMARY KEY (`idParametro`);

--
-- Indices de la tabla `sc_perfil`
--
ALTER TABLE `sc_perfil`
  ADD PRIMARY KEY (`idPerfil`);

--
-- Indices de la tabla `sc_provincia`
--
ALTER TABLE `sc_provincia`
  ADD PRIMARY KEY (`idProvincia`),
  ADD KEY `depId` (`DepaId`);

--
-- Indices de la tabla `sc_reclamo`
--
ALTER TABLE `sc_reclamo`
  ADD PRIMARY KEY (`idReclamo`),
  ADD KEY `tipoDocu` (`tipoDoc`),
  ADD KEY `sexRec` (`sexo`),
  ADD KEY `department` (`departamento`),
  ADD KEY `province` (`provincia`),
  ADD KEY `distric` (`distrito`),
  ADD KEY `tipU` (`tipoUsuario`),
  ADD KEY `derechoU` (`derecho`),
  ADD KEY `cespecU` (`causaEspecifica`),
  ADD KEY `estRec` (`estadoRec`),
  ADD KEY `etapaReclamo` (`etapaReclamo`),
  ADD KEY `resultadoReclamo` (`resulRec`);

--
-- Indices de la tabla `sc_respuestarec`
--
ALTER TABLE `sc_respuestarec`
  ADD PRIMARY KEY (`idRespuesta`),
  ADD KEY `reclamoId` (`idReclamoR`),
  ADD KEY `usuarioId` (`usuarioReg`);

--
-- Indices de la tabla `sc_resultadorec`
--
ALTER TABLE `sc_resultadorec`
  ADD PRIMARY KEY (`idResultado`);

--
-- Indices de la tabla `sc_sexo`
--
ALTER TABLE `sc_sexo`
  ADD PRIMARY KEY (`idSexo`);

--
-- Indices de la tabla `sc_sugerencia`
--
ALTER TABLE `sc_sugerencia`
  ADD PRIMARY KEY (`idSugerencia`);

--
-- Indices de la tabla `sc_tipodocumento`
--
ALTER TABLE `sc_tipodocumento`
  ADD PRIMARY KEY (`idTipoDoc`);

--
-- Indices de la tabla `sc_tiposparametro`
--
ALTER TABLE `sc_tiposparametro`
  ADD PRIMARY KEY (`idTipParametro`);

--
-- Indices de la tabla `sc_tipousuario`
--
ALTER TABLE `sc_tipousuario`
  ADD PRIMARY KEY (`idTipUsuario`);

--
-- Indices de la tabla `sc_usuario`
--
ALTER TABLE `sc_usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `perfUser` (`idPerfil`),
  ADD KEY `estUser` (`idEstado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `sc_amconsulta`
--
ALTER TABLE `sc_amconsulta`
  MODIFY `idAccionMC` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sc_amsugerencia`
--
ALTER TABLE `sc_amsugerencia`
  MODIFY `idAccionMS` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sc_causaespecifica`
--
ALTER TABLE `sc_causaespecifica`
  MODIFY `idCausaEsp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT de la tabla `sc_consulta`
--
ALTER TABLE `sc_consulta`
  MODIFY `idConsulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sc_departamento`
--
ALTER TABLE `sc_departamento`
  MODIFY `idDepartamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `sc_derecho`
--
ALTER TABLE `sc_derecho`
  MODIFY `idDerecho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `sc_distrito`
--
ALTER TABLE `sc_distrito`
  MODIFY `idDistrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1832;

--
-- AUTO_INCREMENT de la tabla `sc_estadodoc`
--
ALTER TABLE `sc_estadodoc`
  MODIFY `idEstadoDoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sc_estadoitem`
--
ALTER TABLE `sc_estadoitem`
  MODIFY `idEstadoItem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sc_estadoreclamo`
--
ALTER TABLE `sc_estadoreclamo`
  MODIFY `idEstadoRec` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sc_estusuario`
--
ALTER TABLE `sc_estusuario`
  MODIFY `idEstadoUs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sc_etapasrec`
--
ALTER TABLE `sc_etapasrec`
  MODIFY `idEtapa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `sc_parametros`
--
ALTER TABLE `sc_parametros`
  MODIFY `idParametro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sc_perfil`
--
ALTER TABLE `sc_perfil`
  MODIFY `idPerfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sc_provincia`
--
ALTER TABLE `sc_provincia`
  MODIFY `idProvincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT de la tabla `sc_reclamo`
--
ALTER TABLE `sc_reclamo`
  MODIFY `idReclamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT de la tabla `sc_resultadorec`
--
ALTER TABLE `sc_resultadorec`
  MODIFY `idResultado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sc_sexo`
--
ALTER TABLE `sc_sexo`
  MODIFY `idSexo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sc_sugerencia`
--
ALTER TABLE `sc_sugerencia`
  MODIFY `idSugerencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sc_tipodocumento`
--
ALTER TABLE `sc_tipodocumento`
  MODIFY `idTipoDoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `sc_tiposparametro`
--
ALTER TABLE `sc_tiposparametro`
  MODIFY `idTipParametro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sc_tipousuario`
--
ALTER TABLE `sc_tipousuario`
  MODIFY `idTipUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sc_usuario`
--
ALTER TABLE `sc_usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `sc_amconsulta`
--
ALTER TABLE `sc_amconsulta`
  ADD CONSTRAINT `consultaId` FOREIGN KEY (`idConsultaMC`) REFERENCES `sc_consulta` (`idConsulta`);

--
-- Filtros para la tabla `sc_amsugerencia`
--
ALTER TABLE `sc_amsugerencia`
  ADD CONSTRAINT `sugerenciaId` FOREIGN KEY (`idSugerenciaMS`) REFERENCES `sc_sugerencia` (`idSugerencia`);

--
-- Filtros para la tabla `sc_causaespecifica`
--
ALTER TABLE `sc_causaespecifica`
  ADD CONSTRAINT `DerechoOwn` FOREIGN KEY (`derechoId`) REFERENCES `sc_derecho` (`idDerecho`);

--
-- Filtros para la tabla `sc_distrito`
--
ALTER TABLE `sc_distrito`
  ADD CONSTRAINT `provID1` FOREIGN KEY (`provId`) REFERENCES `sc_provincia` (`idProvincia`);

--
-- Filtros para la tabla `sc_provincia`
--
ALTER TABLE `sc_provincia`
  ADD CONSTRAINT `depId` FOREIGN KEY (`DepaId`) REFERENCES `sc_departamento` (`idDepartamento`);

--
-- Filtros para la tabla `sc_reclamo`
--
ALTER TABLE `sc_reclamo`
  ADD CONSTRAINT `cespecU` FOREIGN KEY (`causaEspecifica`) REFERENCES `sc_causaespecifica` (`idCausaEsp`),
  ADD CONSTRAINT `department` FOREIGN KEY (`departamento`) REFERENCES `sc_departamento` (`idDepartamento`),
  ADD CONSTRAINT `derechoU` FOREIGN KEY (`derecho`) REFERENCES `sc_derecho` (`idDerecho`),
  ADD CONSTRAINT `distric` FOREIGN KEY (`distrito`) REFERENCES `sc_distrito` (`idDistrito`),
  ADD CONSTRAINT `estRec` FOREIGN KEY (`estadoRec`) REFERENCES `sc_estadoreclamo` (`idEstadoRec`),
  ADD CONSTRAINT `etapaReclamo` FOREIGN KEY (`etapaReclamo`) REFERENCES `sc_etapasrec` (`idEtapa`),
  ADD CONSTRAINT `province` FOREIGN KEY (`provincia`) REFERENCES `sc_provincia` (`idProvincia`),
  ADD CONSTRAINT `resultadoReclamo` FOREIGN KEY (`resulRec`) REFERENCES `sc_resultadorec` (`idResultado`),
  ADD CONSTRAINT `sexRec` FOREIGN KEY (`sexo`) REFERENCES `sc_sexo` (`idSexo`),
  ADD CONSTRAINT `tipU` FOREIGN KEY (`tipoUsuario`) REFERENCES `sc_tipousuario` (`idTipUsuario`),
  ADD CONSTRAINT `tipoDocu` FOREIGN KEY (`tipoDoc`) REFERENCES `sc_tipodocumento` (`idTipoDoc`);

--
-- Filtros para la tabla `sc_respuestarec`
--
ALTER TABLE `sc_respuestarec`
  ADD CONSTRAINT `reclamoId` FOREIGN KEY (`idReclamoR`) REFERENCES `sc_reclamo` (`idReclamo`),
  ADD CONSTRAINT `usuarioId` FOREIGN KEY (`usuarioReg`) REFERENCES `sc_usuario` (`idUsuario`);

--
-- Filtros para la tabla `sc_usuario`
--
ALTER TABLE `sc_usuario`
  ADD CONSTRAINT `estUser` FOREIGN KEY (`idEstado`) REFERENCES `sc_estusuario` (`idEstadoUs`),
  ADD CONSTRAINT `perfUser` FOREIGN KEY (`idPerfil`) REFERENCES `sc_perfil` (`idPerfil`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
