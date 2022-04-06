-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 06-04-2022 a las 21:10:41
-- Versión del servidor: 5.7.33
-- Versión de PHP: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db-psyemweb`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ANULAR_ATENCION` (IN `_idAtencion` INT(11))   UPDATE psyem_atencion SET idEpisodio = "ANULADA", cuentaAtencion = "ANULADA", idEstadoAte = 2 WHERE idAtencion = _idAtencion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ANULAR_SEGUIMIENTO` (IN `_idSeguimiento` INT(11))   UPDATE psyem_seguimiento 
SET psyem_seguimiento.idStatusSeg = 2
WHERE
	idSeguimiento = _idSeguimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Buscar_Diagnosticos` (IN `_termino` TEXT, IN `_opcion` INT, IN `_dxDif` INT)   BEGIN
	IF
		( _opcion = 1 ) THEN
		SELECT
			psyem_diagnosticos.idDiagnostico,
			CONCAT(
				UPPER( psyem_diagnosticos.cieDiagnostico ),
				' - ',
			UPPER( psyem_diagnosticos.detaDiagnostico )) AS diagnostico 
		FROM
			psyem_diagnosticos 
		WHERE
			(
				psyem_diagnosticos.cieDiagnostico LIKE CONCAT( '%', UPPER( _termino ), '%' ) 
			OR psyem_diagnosticos.detaDiagnostico LIKE CONCAT( '%', LOWER( _termino ), '%' ));
		ELSE SELECT
			psyem_diagnosticos.idDiagnostico,
			CONCAT(
				UPPER( psyem_diagnosticos.cieDiagnostico ),
				' - ',
			UPPER( psyem_diagnosticos.detaDiagnostico )) AS diagnostico 
		FROM
			psyem_diagnosticos 
		WHERE
			(
				psyem_diagnosticos.cieDiagnostico LIKE CONCAT( '%', UPPER( _termino ), '%' ) 
			OR psyem_diagnosticos.detaDiagnostico LIKE CONCAT( '%', LOWER( _termino ), '%' )) 
			AND psyem_diagnosticos.idDiagnostico != _dxDif;
		
	END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BUSCAR_PACIENTE` (IN `_termino` TEXT)   SELECT
idAtencion,date_format(psyem_atencion.fIngresoAtencion,'%d/%m/%Y') AS fIngresoAtencion,cuentaAtencion,tipdocAtencion,nrodocAtencion,CONCAT(nombAtencion,' ',apPaternoAtencion,' ',apMaternoAtencion) AS paciente,psyem_estadopaciente.detaEstadoPacAtencion
FROM
	psyem_atencion
INNER JOIN
	psyem_estadopaciente
	ON 
		psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
WHERE (psyem_atencion.nrodocAtencion LIKE CONCAT('%',_termino,'%') OR psyem_atencion.apPaternoAtencion LIKE CONCAT('%',UPPER(_termino),'%') OR psyem_atencion.apMaternoAtencion LIKE CONCAT('%',UPPER(_termino),'%') OR psyem_atencion.nombAtencion LIKE CONCAT('%',UPPER(_termino),'%')) AND (psyem_atencion.idEstadoAte != 2)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DESBLOQUEAR_USUARIO` (IN `_idUsuario` INT(11))   UPDATE psyem_usuarios SET intentosUsuario = 0 WHERE idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_ATENCION` (IN `_idEpisodio` TEXT, IN `_cuentaAtencion` VARCHAR(20), IN `_historiaAtencion` VARCHAR(20), IN `_idEstadoPacAtencion` INT(11), IN `_fechaPacNacimiento` DATE, IN `_tipdocAtencion` VARCHAR(20), IN `_nrodocAtencion` VARCHAR(15), IN `_apPaternoAtencion` VARCHAR(30), IN `_apMaternoAtencion` VARCHAR(30), IN `_nombAtencion` VARCHAR(30), IN `_fIngresoAtencion` DATE, IN `_servAtencion` VARCHAR(100), IN `_camaAtencion` VARCHAR(20), IN `_distritoAtencion` VARCHAR(100), IN `_edadAtencion` VARCHAR(20), IN `_tipSexoAtencion` INT(11), IN `_financiaAtencion` VARCHAR(50), IN `_idAtencion` INT(11))   UPDATE psyem_atencion SET idEpisodio = _idEpisodio,
cuentaAtencion = _cuentaAtencion,
historiaAtencion = _historiaAtencion,
idEstadoPacAtencion = _idEstadoPacAtencion,
fechaPacNacimiento = _fechaPacNacimiento,
tipdocAtencion = _tipdocAtencion,
nrodocAtencion = _nrodocAtencion,
apPaternoAtencion = _apPaternoAtencion,
apMaternoAtencion = _apMaternoAtencion,
nombAtencion = _nombAtencion,
fIngresoAtencion = _fIngresoAtencion,
servAtencion = _servAtencion,
camaAtencion = _camaAtencion,
distritoAtencion = _distritoAtencion,
edadAtencion = _edadAtencion,
tipSexoAtencion = _tipSexoAtencion,
financiaAtencion = _financiaAtencion
WHERE
	idAtencion = _idAtencion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_DIAGNOSTICO` (IN `_idDiagnostico` INT(11), IN `_cieDiagnostico` VARCHAR(20), IN `_detaDiagnostico` VARCHAR(100))   UPDATE psyem_diagnosticos SET cieDiagnostico = _cieDiagnostico,detaDiagnostico = _detaDiagnostico WHERE idDiagnostico = _idDiagnostico$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_FAMILIARES` (IN `_idFamiliar` INT(11), IN `_idAtencion` INT(11), IN `_idParentesco` INT(11), IN `_idTipSexo` INT(11), IN `_tipdocFamiliar` VARCHAR(20), IN `_ndocFamiliar` VARCHAR(20), IN `_nombApFamiliar` VARCHAR(100), IN `_edadFamiliar` VARCHAR(20), IN `_telcelFamiliar` VARCHAR(12))   UPDATE psyem_famatencion 
SET idAtencion = _idAtencion,
idParentesco = _idParentesco,
idTipSexo = _idTipSexo,
tipdocFamiliar = _tipdocFamiliar,
ndocFamiliar = _ndocFamiliar,
nombApFamiliar = _nombApFamiliar,
edadFamiliar = _edadFamiliar,
telcelFamiliar = _telcelFamiliar 
WHERE
	idFamiliar = _idFamiliar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_PROFESIONAL` (IN `_idProfesional` INT(11), IN `_idCondicion` INT(11), `_dniProfesional` VARCHAR(15), IN `_cpspProfesional` VARCHAR(25), IN `_apellidosProfesional` VARCHAR(50), IN `_nombresProfesional` VARCHAR(50))   UPDATE psyem_profesionales SET idCondicion = _idCondicion, dniProfesional = _dniProfesional, cpspProfesional = _cpspProfesional, apellidosProfesional = _apellidosProfesional, nombresProfesional = _nombresProfesional WHERE idProfesional = _idProfesional$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_SEGUIMIENTO` (IN `_idSeguimiento` INT(11), IN `_fRegistrSeg` DATE, IN `_idAtencionPac` INT(11), IN `_idProfesional` INT(11), IN `_idTipoSeguimiento` INT(11), IN `_idMotSeguimiento` INT(11), IN `_idDiag1Seg` INT(11), IN `_idDiag2Seg` INT(11), IN `_comunFamSeg` VARCHAR(10), IN `_idFamAtSeg` INT(11), IN `_idDiag1SegFam` INT(11), IN `_idDiag2SegFam` INT(11), IN `_obsSeg` VARCHAR(200))   UPDATE psyem_seguimiento 
SET fRegistrSeg = _fRegistrSeg,
idAtencionPac = _idAtencionPac,
idProfesional = _idProfesional,
idTipoSeguimiento = _idTipoSeguimiento,
idMotSeguimiento = _idMotSeguimiento,
idDiag1Seg = _idDiag1Seg,
idDiag2Seg = _idDiag2Seg,
comunFamSeg = _comunFamSeg,
idFamAtSeg = _idFamAtSeg,
idDiag1SegFam = _idDiag1SegFam,
idDiag2SegFam = _idDiag2SegFam,
obsSeg = _obsSeg 
WHERE
	idSeguimiento = _idSeguimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_USUARIO` (IN `_idUsuario` INT(11), IN `_idPerfil` INT(11), IN `_dniUsuario` VARCHAR(20), IN `_apellidosUsuario` VARCHAR(50), IN `_nombresUsuario` VARCHAR(50), IN `_cuentaUsuario` VARCHAR(50), IN `_correoUsuario` VARCHAR(50), IN `_claveUsuario` VARCHAR(100))   UPDATE psyem_usuarios 
SET idPerfil = _idPerfil,
dniUsuario = _dniUsuario,
apellidosUsuario = _apellidosUsuario,
nombresUsuario = _nombresUsuario,
cuentaUsuario = _cuentaUsuario,
correoUsuario = _correoUsuario,
claveUsuario = _claveUsuario 
WHERE
	idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_DIAGNOSTICO` (IN `_idDiagnostico` INT(11))   DELETE FROM psyem_diagnosticos WHERE idDiagnostico = _idDiagnostico$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_FAMILIAR` (IN `_idFamiliar` INT(11), OUT `nExistencia` INT(11))   BEGIN
    DECLARE conteo INT;
	SET conteo = (SELECT count(idFamiliar) as existencia FROM psyem_famatencion fam
	WHERE EXISTS (SELECT NULL
	FROM psyem_seguimiento seg
	WHERE seg.idFamAtSeg = fam.idFamiliar) AND idFamiliar = _idFamiliar);
    IF(conteo >= 1) THEN
       SET nExistencia = 1;
    ELSE
       DELETE FROM psyem_famatencion WHERE idFamiliar = _idFamiliar;
       SET nExistencia = 0;
    END IF;
    SELECT nExistencia;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_PROFESIONAL` (IN `_idProfesional` INT(11))   DELETE FROM psyem_profesionales WHERE idProfesional = _idProfesional$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_USUARIO` (IN `_idUsuario` INT(11))   DELETE FROM psyem_usuarios WHERE idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GRAFICO_DIAGNOSTICOS` ()   SELECT
	psyem_diagnosticos.idDiagnostico as id, 
	psyem_diagnosticos.cieDiagnostico as cie10, 
	psyem_diagnosticos.detaDiagnostico as detalle, 
	COUNT(*) AS frecuencia
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
GROUP BY
	psyem_seguimiento.idDiag1Seg
ORDER BY frecuencia DESC
LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GRAFICO_SEGUIMIENTO_MENSUAL` ()   SELECT
MONTH ( psyem_seguimiento.fRegistrSeg ) AS NMES,
MES_SPANISH ( psyem_seguimiento.fRegistrSeg, 'es_ES' ) AS MES,
COUNT( psyem_seguimiento.idSeguimiento ) AS CONTEO 
FROM
	psyem_seguimiento 
WHERE
	idStatusSeg = 1 
	AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
	CURDATE()) 
GROUP BY
	NMES,MES
ORDER BY MONTH(psyem_seguimiento.fRegistrSeg)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HABILITAR_PROFESIONAL` (IN `_idProfesional` INT(11), IN `_idEstado` INT(11))   UPDATE psyem_profesionales SET idEstado = _idEstado WHERE idProfesional = _idProfesional$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HABILITAR_USUARIO` (IN `_idUsuario` INT(11), IN `_idEstado` INT(11))   UPDATE psyem_usuarios SET idEstado = _idEstado WHERE idUsuario = _idUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ATENCIONES` ()   SELECT
	psyem_atencion.idAtencion, 
	psyem_atencion.correlativo_Atencion, 
	date_format(psyem_atencion.fRegistroAtencion,'%d/%m/%Y') as fRegistroAtencion,
	psyem_atencion.idEpisodio, 
	psyem_atencion.cuentaAtencion, 
	psyem_atencion.historiaAtencion, 
	psyem_atencion.idEstadoPacAtencion, 
	psyem_estadopaciente.detaEstadoPacAtencion, 
	date_format(psyem_atencion.fechaPacNacimiento,'%d/%m/%Y')as fechaPacNacimiento, 
	psyem_atencion.tipdocAtencion, 
	psyem_atencion.nrodocAtencion, 
	psyem_atencion.apPaternoAtencion, 
	psyem_atencion.apMaternoAtencion, 
	psyem_atencion.nombAtencion, 
	date_format(psyem_atencion.fIngresoAtencion,'%d/%m/%Y')as fIngresoAtencion, 
	psyem_atencion.servAtencion, 
	psyem_atencion.camaAtencion, 
	psyem_atencion.distritoAtencion, 
	psyem_atencion.edadAtencion, 
	psyem_atencion.tipSexoAtencion, 
	psyem_tipsexo.detaTipSexo, 
	psyem_atencion.financiaAtencion, 
	psyem_atencion.idEstadoAte, 
	psyem_estadoatencion.detaEstadoAte
FROM
	psyem_atencion
	INNER JOIN
	psyem_estadoatencion
	ON 
		psyem_atencion.idEstadoAte = psyem_estadoatencion.idEstadoAte
	INNER JOIN
	psyem_estadopaciente
	ON 
		psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
	INNER JOIN
	psyem_tipsexo
	ON 
		psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
	ORDER BY psyem_atencion.correlativo_Atencion DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ATENCIONES_F` ()   SELECT
psyem_atencion.idAtencion,
psyem_atencion.correlativo_Atencion,
date_format( psyem_atencion.fRegistroAtencion, '%d/%m/%Y' ) AS fRegistroAtencion,
psyem_atencion.idEpisodio,
psyem_atencion.cuentaAtencion,
psyem_atencion.historiaAtencion,
psyem_atencion.idEstadoPacAtencion,
psyem_estadopaciente.detaEstadoPacAtencion,
date_format( psyem_atencion.fechaPacNacimiento, '%d/%m/%Y' ) AS fechaPacNacimiento,
psyem_atencion.tipdocAtencion,
psyem_atencion.nrodocAtencion,
psyem_atencion.apPaternoAtencion,
psyem_atencion.apMaternoAtencion,
psyem_atencion.nombAtencion,
date_format( psyem_atencion.fIngresoAtencion, '%d/%m/%Y' ) AS fIngresoAtencion,
psyem_atencion.servAtencion,
psyem_atencion.camaAtencion,
psyem_atencion.distritoAtencion,
psyem_atencion.edadAtencion,
psyem_atencion.tipSexoAtencion,
psyem_tipsexo.detaTipSexo,
psyem_atencion.financiaAtencion,
psyem_atencion.idEstadoAte,
psyem_estadoatencion.detaEstadoAte 
FROM
	psyem_atencion
	INNER JOIN psyem_estadoatencion ON psyem_atencion.idEstadoAte = psyem_estadoatencion.idEstadoAte
	INNER JOIN psyem_estadopaciente ON psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
	INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo 
WHERE
	MONTH ( psyem_atencion.fRegistroAtencion ) = MONTH (
	CURDATE()) 
	AND YEAR ( psyem_atencion.fRegistroAtencion ) = YEAR (
	CURDATE()) 
ORDER BY
	psyem_atencion.correlativo_Atencion DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ATENCIONES_FECHAS` (IN `_fechaInicialAte` DATE, IN `_fechaFinalAte` DATE)   IF
	( _fechaInicialAte = _fechaFinalAte ) THEN
	SELECT
		psyem_atencion.idAtencion,
		psyem_atencion.correlativo_Atencion,
		date_format( psyem_atencion.fRegistroAtencion, '%d/%m/%Y' ) AS fRegistroAtencion,
		psyem_atencion.idEpisodio,
		psyem_atencion.cuentaAtencion,
		psyem_atencion.historiaAtencion,
		psyem_atencion.idEstadoPacAtencion,
		psyem_estadopaciente.detaEstadoPacAtencion,
		date_format( psyem_atencion.fechaPacNacimiento, '%d/%m/%Y' ) AS fechaPacNacimiento,
		psyem_atencion.tipdocAtencion,
		psyem_atencion.nrodocAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_atencion.nombAtencion,
		date_format( psyem_atencion.fIngresoAtencion, '%d/%m/%Y' ) AS fIngresoAtencion,
		psyem_atencion.servAtencion,
		psyem_atencion.camaAtencion,
		psyem_atencion.distritoAtencion,
		psyem_atencion.edadAtencion,
		psyem_atencion.tipSexoAtencion,
		psyem_tipsexo.detaTipSexo,
		psyem_atencion.financiaAtencion,
		psyem_atencion.idEstadoAte,
		psyem_estadoatencion.detaEstadoAte 
	FROM
		psyem_atencion
		INNER JOIN psyem_estadoatencion ON psyem_atencion.idEstadoAte = psyem_estadoatencion.idEstadoAte
		INNER JOIN psyem_estadopaciente ON psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo 
	WHERE
		psyem_atencion.fRegistroAtencion = _fechaFinalAte 
	ORDER BY
		psyem_atencion.correlativo_Atencion DESC;
	ELSE SELECT
		psyem_atencion.idAtencion,
		psyem_atencion.correlativo_Atencion,
		date_format( psyem_atencion.fRegistroAtencion, '%d/%m/%Y' ) AS fRegistroAtencion,
		psyem_atencion.idEpisodio,
		psyem_atencion.cuentaAtencion,
		psyem_atencion.historiaAtencion,
		psyem_atencion.idEstadoPacAtencion,
		psyem_estadopaciente.detaEstadoPacAtencion,
		date_format( psyem_atencion.fechaPacNacimiento, '%d/%m/%Y' ) AS fechaPacNacimiento,
		psyem_atencion.tipdocAtencion,
		psyem_atencion.nrodocAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_atencion.nombAtencion,
		date_format( psyem_atencion.fIngresoAtencion, '%d/%m/%Y' ) AS fIngresoAtencion,
		psyem_atencion.servAtencion,
		psyem_atencion.camaAtencion,
		psyem_atencion.distritoAtencion,
		psyem_atencion.edadAtencion,
		psyem_atencion.tipSexoAtencion,
		psyem_tipsexo.detaTipSexo,
		psyem_atencion.financiaAtencion,
		psyem_atencion.idEstadoAte,
		psyem_estadoatencion.detaEstadoAte 
	FROM
		psyem_atencion
		INNER JOIN psyem_estadoatencion ON psyem_atencion.idEstadoAte = psyem_estadoatencion.idEstadoAte
		INNER JOIN psyem_estadopaciente ON psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo 
	WHERE
	psyem_atencion.fRegistroAtencion BETWEEN _fechaInicialAte 
	AND _fechaFinalAte
	ORDER BY
		psyem_atencion.correlativo_Atencion DESC;

END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_CONDICIONES_PROF` ()   SELECT idCondicion,detaCondicion FROM psyem_condicionprof$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_DIAGNOSTICOS` ()   SELECT
psyem_diagnosticos.idDiagnostico,
psyem_diagnosticos.cieDiagnostico,
UPPER(psyem_diagnosticos.detaDiagnostico) AS detaDiagnostico
FROM
	psyem_diagnosticos 
ORDER BY psyem_diagnosticos.idDiagnostico ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_DIAGNOSTICO_NO_SELECCIONADO` (IN `_idDiagnostico` INT)   SELECT
psyem_diagnosticos.idDiagnostico,
psyem_diagnosticos.cieDiagnostico,
UPPER(psyem_diagnosticos.detaDiagnostico) AS detaDiagnostico
FROM
	psyem_diagnosticos 
WHERE psyem_diagnosticos.idDiagnostico != _idDiagnostico
ORDER BY psyem_diagnosticos.idDiagnostico ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ESTADOS_PACIENTE` ()   SELECT
	psyem_estadopaciente.idEstadoPacAtencion, 
	psyem_estadopaciente.detaEstadoPacAtencion
FROM
	psyem_estadopaciente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ETAPAS_SEGUIMIENTO` ()   SELECT
	psyem_etapaseguimiento.idEtapSegui, 
	psyem_etapaseguimiento.detaEtapSegui
FROM
	psyem_etapaseguimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_FAMILIARES` ()   SELECT
	psyem_famatencion.idFamiliar,
	date_format(psyem_famatencion.fechaRegistro,'%d/%m/%Y') as fechaRegistro, 
	psyem_famatencion.idAtencion, 
	psyem_atencion.cuentaAtencion, 
	psyem_atencion.historiaAtencion, 
	psyem_atencion.apPaternoAtencion, 
	psyem_atencion.apMaternoAtencion, 
	psyem_atencion.nombAtencion, 
	psyem_famatencion.tipdocFamiliar, 
	psyem_famatencion.ndocFamiliar, 
	psyem_famatencion.nombApFamiliar, 
	psyem_famatencion.idParentesco, 
	psyem_parentescofam.detaParentesco, 
	psyem_famatencion.idTipSexo, 
	psyem_tipsexo.detaTipSexo, 
	psyem_famatencion.edadFamiliar, 
	psyem_famatencion.telcelFamiliar
FROM
	psyem_famatencion
	INNER JOIN
	psyem_atencion
	ON 
		psyem_famatencion.idAtencion = psyem_atencion.idAtencion
	INNER JOIN
	psyem_parentescofam
	ON 
		psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	INNER JOIN
	psyem_tipsexo
	ON 
		psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo
	ORDER BY psyem_famatencion.fechaRegistro DESC, psyem_famatencion.idFamiliar DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_FAMILIARES_F` ()   SELECT
psyem_famatencion.idFamiliar,
date_format( psyem_famatencion.fechaRegistro, '%d/%m/%Y' ) AS fechaRegistro,
psyem_famatencion.idAtencion,
psyem_atencion.cuentaAtencion,
psyem_atencion.historiaAtencion,
psyem_atencion.apPaternoAtencion,
psyem_atencion.apMaternoAtencion,
psyem_atencion.nombAtencion,
psyem_famatencion.tipdocFamiliar,
psyem_famatencion.ndocFamiliar,
psyem_famatencion.nombApFamiliar,
psyem_famatencion.idParentesco,
psyem_parentescofam.detaParentesco,
psyem_famatencion.idTipSexo,
psyem_tipsexo.detaTipSexo,
psyem_famatencion.edadFamiliar,
psyem_famatencion.telcelFamiliar 
FROM
	psyem_famatencion
	INNER JOIN psyem_atencion ON psyem_famatencion.idAtencion = psyem_atencion.idAtencion
	INNER JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	INNER JOIN psyem_tipsexo ON psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo 
WHERE
	MONTH ( psyem_famatencion.fechaRegistro ) = MONTH (
	CURDATE()) AND YEAR( psyem_famatencion.fechaRegistro ) = YEAR(CURDATE())
ORDER BY
	psyem_famatencion.fechaRegistro DESC,
	psyem_famatencion.idFamiliar DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_FAMILIARES_FECHAS` (IN `_fechaInicialFam` DATE, IN `_fechaFinalFam` DATE)   IF
	( _fechaInicialFam = _fechaFinalFam ) THEN
	SELECT
		psyem_famatencion.idFamiliar,
		date_format( psyem_famatencion.fechaRegistro, '%d/%m/%Y' ) AS fechaRegistro,
		psyem_famatencion.idAtencion,
		psyem_atencion.cuentaAtencion,
		psyem_atencion.historiaAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_atencion.nombAtencion,
		psyem_famatencion.tipdocFamiliar,
		psyem_famatencion.ndocFamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_famatencion.idParentesco,
		psyem_parentescofam.detaParentesco,
		psyem_famatencion.idTipSexo,
		psyem_tipsexo.detaTipSexo,
		psyem_famatencion.edadFamiliar,
		psyem_famatencion.telcelFamiliar 
	FROM
		psyem_famatencion
		INNER JOIN psyem_atencion ON psyem_famatencion.idAtencion = psyem_atencion.idAtencion
		INNER JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		INNER JOIN psyem_tipsexo ON psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo 
	WHERE
		psyem_famatencion.fechaRegistro = _fechaFinalFam 
	ORDER BY
		psyem_famatencion.fechaRegistro DESC,
		psyem_famatencion.idFamiliar DESC;
	ELSE SELECT
		psyem_famatencion.idFamiliar,
		date_format( psyem_famatencion.fechaRegistro, '%d/%m/%Y' ) AS fechaRegistro,
		psyem_famatencion.idAtencion,
		psyem_atencion.cuentaAtencion,
		psyem_atencion.historiaAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_atencion.nombAtencion,
		psyem_famatencion.tipdocFamiliar,
		psyem_famatencion.ndocFamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_famatencion.idParentesco,
		psyem_parentescofam.detaParentesco,
		psyem_famatencion.idTipSexo,
		psyem_tipsexo.detaTipSexo,
		psyem_famatencion.edadFamiliar,
		psyem_famatencion.telcelFamiliar 
	FROM
		psyem_famatencion
		INNER JOIN psyem_atencion ON psyem_famatencion.idAtencion = psyem_atencion.idAtencion
		INNER JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		INNER JOIN psyem_tipsexo ON psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo 
	WHERE
		psyem_famatencion.fechaRegistro BETWEEN _fechaInicialFam 
		AND _fechaFinalFam 
	ORDER BY
		psyem_famatencion.fechaRegistro DESC,
		psyem_famatencion.idFamiliar DESC; 
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_FAMILIAR_PACIENTE` (IN `_idAtencion` INT(11))   SELECT
	psyem_famatencion.idFamiliar,
	CONCAT( psyem_famatencion.nombApFamiliar, ' - ', psyem_parentescofam.detaParentesco, ' ', psyem_famatencion.telcelFamiliar ) AS familiarPaciente 
FROM
	psyem_famatencion
	INNER JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco 
WHERE
	psyem_famatencion.idAtencion = _idAtencion ORDER BY psyem_famatencion.nombApFamiliar ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_HISTORIAL_PACIENTE` (IN `_idPaciente` INT(11))   SELECT
psyem_seguimiento.idAtencionPac,
date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg,
psyem_tiposeguimiento.detaTipSeguimiento,
psyem_motivoseguimiento.detaMotivoSef,
CONCAT(psyem_profesionales.nombresProfesional," ",psyem_profesionales.apellidosProfesional) as profesional,
psyem_seguimiento.comunFamSeg,
psyem_diagnosticos.cieDiagnostico AS cieP1,
psyem_diagnosticos.detaDiagnostico AS detaD1,
dp2.cieDiagnostico AS cieP2,
dp2.detaDiagnostico AS detD2,
psyem_famatencion.nombApFamiliar,
psyem_parentescofam.detaParentesco,
df1.cieDiagnostico AS cieDF1,
df1.detaDiagnostico AS detDF1,
df2.cieDiagnostico AS cieDF2,
df2.detaDiagnostico AS detDF2,
psyem_seguimiento.obsSeg
FROM
	psyem_seguimiento
	INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
	INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
	INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
	INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
	INNER JOIN psyem_estatusseguimiento ON psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
	LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
	INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	LEFT JOIN psyem_diagnosticos AS dp2 ON psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
	LEFT JOIN psyem_diagnosticos AS df1 ON psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
	LEFT JOIN psyem_diagnosticos AS df2 ON psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
	LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco 
WHERE
 psyem_seguimiento.idAtencionPac = _idPaciente AND psyem_seguimiento.idStatusSeg != 2
ORDER BY
	psyem_seguimiento.fRegistrSeg ASC,
	psyem_seguimiento.idSeguimiento ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_MOTIVOS_SEGUIMIENTO` ()   SELECT
	psyem_motivoseguimiento.idMotSeguimiento, 
	psyem_motivoseguimiento.detaMotivoSef
FROM
	psyem_motivoseguimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_PARENTESCO` ()   SELECT idParentesco,detaParentesco FROM `psyem_parentescofam` ORDER BY idParentesco$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_PERFILES_USUARIO` ()   SELECT
	psyem_perfiles.idPerfil, 
	psyem_perfiles.detallePerfil
FROM
	psyem_perfiles$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_PROFESIONALES` ()   SELECT
	psyem_profesionales.idProfesional,
	psyem_profesionales.idEstado, 
	psyem_estadoprof.detaEstadoProf, 
	psyem_profesionales.idCondicion, 
	psyem_condicionprof.detaCondicion, 
	psyem_profesionales.dniProfesional, 
	psyem_profesionales.cpspProfesional, 
	psyem_profesionales.apellidosProfesional, 
	psyem_profesionales.nombresProfesional
FROM
	psyem_profesionales
	INNER JOIN
	psyem_estadoprof
	ON 
		psyem_profesionales.idEstado = psyem_estadoprof.idEstadoProf
	INNER JOIN
	psyem_condicionprof
	ON 
		psyem_profesionales.idCondicion = psyem_condicionprof.idCondicion
	ORDER BY psyem_profesionales.apellidosProfesional ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_SEGUIMIENTOS` ()   SELECT
	psyem_seguimiento.idSeguimiento, 
		date_format(psyem_seguimiento.fRegistrSeg,'%d/%m/%Y') as fRegistrSeg, 
	psyem_seguimiento.idAtencionPac, 
	psyem_atencion.cuentaAtencion, 
	psyem_atencion.tipdocAtencion,
	psyem_atencion.nrodocAtencion,
	psyem_atencion.historiaAtencion, 
	psyem_atencion.nombAtencion, 
	psyem_atencion.apPaternoAtencion, 
	psyem_atencion.apMaternoAtencion, 
	psyem_seguimiento.idTipoSeguimiento, 
	psyem_tiposeguimiento.detaTipSeguimiento, 
	psyem_seguimiento.idMotSeguimiento, 
	psyem_motivoseguimiento.detaMotivoSef, 
	psyem_seguimiento.idProfesional, 
	psyem_profesionales.nombresProfesional, 
	psyem_profesionales.apellidosProfesional, 
	psyem_seguimiento.comunFamSeg, 
	psyem_seguimiento.idDiag1Seg, 
	psyem_diagnosticos.cieDiagnostico as cieP1,
	psyem_diagnosticos.detaDiagnostico as detaD1, 
	psyem_seguimiento.idDiag2Seg,
	dp2.cieDiagnostico as cieP2,
	dp2.detaDiagnostico as detD2, 		
	psyem_seguimiento.idFamAtSeg, 
	psyem_famatencion.nombApFamiliar,
	psyem_famatencion.telcelFamiliar,
	psyem_parentescofam.detaParentesco,
	psyem_seguimiento.idDiag1SegFam,
	df1.cieDiagnostico as cieDF1,
	df1.detaDiagnostico as detDF1,  
	psyem_seguimiento.idDiag2SegFam,
	df2.cieDiagnostico as cieDF2,
	df2.detaDiagnostico as detDF2,   
	psyem_seguimiento.obsSeg, 
	psyem_seguimiento.idStatusSeg, 
	psyem_estatusseguimiento.detaStatusSeg
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_atencion
	ON 
		psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
	INNER JOIN
	psyem_profesionales
	ON 
		psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
	INNER JOIN
	psyem_tiposeguimiento
	ON 
		psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
	INNER JOIN
	psyem_motivoseguimiento
	ON 
		psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
	INNER JOIN
	psyem_estatusseguimiento
	ON 
		psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
	LEFT JOIN
	psyem_famatencion
	ON 
		psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos as dp2
	ON 
	psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos as df1
	ON 
	psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos as df2
	ON 
	psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
	LEFT JOIN
	psyem_parentescofam
	ON
	psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	WHERE psyem_seguimiento.idStatusSeg != 2
ORDER BY psyem_seguimiento.fRegistrSeg desc, psyem_seguimiento.idSeguimiento desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_SEGUIMIENTOS_F` (IN `_idProfesional` INT(11))   SELECT
psyem_seguimiento.idSeguimiento,
date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg,
psyem_seguimiento.idAtencionPac,
psyem_atencion.cuentaAtencion,
psyem_atencion.tipdocAtencion,
psyem_atencion.nrodocAtencion,
psyem_atencion.historiaAtencion,
psyem_atencion.nombAtencion,
psyem_atencion.apPaternoAtencion,
psyem_atencion.apMaternoAtencion,
psyem_seguimiento.idTipoSeguimiento,
psyem_tiposeguimiento.detaTipSeguimiento,
psyem_seguimiento.idMotSeguimiento,
psyem_motivoseguimiento.detaMotivoSef,
psyem_seguimiento.idProfesional,
psyem_profesionales.nombresProfesional,
psyem_profesionales.apellidosProfesional,
psyem_seguimiento.comunFamSeg,
psyem_seguimiento.idDiag1Seg,
psyem_diagnosticos.cieDiagnostico AS cieP1,
psyem_diagnosticos.detaDiagnostico AS detaD1,
psyem_seguimiento.idDiag2Seg,
dp2.cieDiagnostico AS cieP2,
dp2.detaDiagnostico AS detD2,
psyem_seguimiento.idFamAtSeg,
psyem_famatencion.nombApFamiliar,
psyem_famatencion.telcelFamiliar,
psyem_parentescofam.detaParentesco,
psyem_seguimiento.idDiag1SegFam,
df1.cieDiagnostico AS cieDF1,
df1.detaDiagnostico AS detDF1,
psyem_seguimiento.idDiag2SegFam,
df2.cieDiagnostico AS cieDF2,
df2.detaDiagnostico AS detDF2,
psyem_seguimiento.obsSeg,
psyem_seguimiento.idStatusSeg,
psyem_estatusseguimiento.detaStatusSeg 
FROM
	psyem_seguimiento
	INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
	INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
	INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
	INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
	INNER JOIN psyem_estatusseguimiento ON psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
	LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
	INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	LEFT JOIN psyem_diagnosticos AS dp2 ON psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
	LEFT JOIN psyem_diagnosticos AS df1 ON psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
	LEFT JOIN psyem_diagnosticos AS df2 ON psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
	LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco 
WHERE
	MONTH ( psyem_seguimiento.fRegistrSeg ) = MONTH (
	CURDATE()) AND YEAR( psyem_seguimiento.fRegistrSeg ) = YEAR(CURDATE())
	AND psyem_seguimiento.idStatusSeg != 2  AND psyem_seguimiento.idProfesional = _idProfesional
ORDER BY
	psyem_seguimiento.fRegistrSeg DESC,
	psyem_seguimiento.idSeguimiento DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_SEGUIMIENTOS_FECHAS` (IN `_fechaInicialSeg` DATE, IN `_fechaFinalSeg` DATE, IN `_idProfesional` INT(11))   IF
	( _fechaInicialSeg = _fechaFinalSeg ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg,
		psyem_seguimiento.idAtencionPac,
		psyem_atencion.cuentaAtencion,
		psyem_atencion.tipdocAtencion,
		psyem_atencion.nrodocAtencion,
		psyem_atencion.historiaAtencion,
		psyem_atencion.nombAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_seguimiento.idTipoSeguimiento,
		psyem_tiposeguimiento.detaTipSeguimiento,
		psyem_seguimiento.idMotSeguimiento,
		psyem_motivoseguimiento.detaMotivoSef,
		psyem_seguimiento.idProfesional,
		psyem_profesionales.nombresProfesional,
		psyem_profesionales.apellidosProfesional,
		psyem_seguimiento.comunFamSeg,
		psyem_seguimiento.idDiag1Seg,
		psyem_diagnosticos.cieDiagnostico AS cieP1,
		psyem_diagnosticos.detaDiagnostico AS detaD1,
		psyem_seguimiento.idDiag2Seg,
		dp2.cieDiagnostico AS cieP2,
		dp2.detaDiagnostico AS detD2,
		psyem_seguimiento.idFamAtSeg,
		psyem_famatencion.nombApFamiliar,
		psyem_famatencion.telcelFamiliar,
		psyem_parentescofam.detaParentesco,
		psyem_seguimiento.idDiag1SegFam,
		df1.cieDiagnostico AS cieDF1,
		df1.detaDiagnostico AS detDF1,
		psyem_seguimiento.idDiag2SegFam,
		df2.cieDiagnostico AS cieDF2,
		df2.detaDiagnostico AS detDF2,
		psyem_seguimiento.obsSeg,
		psyem_seguimiento.idStatusSeg,
		psyem_estatusseguimiento.detaStatusSeg 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_estatusseguimiento ON psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS dp2 ON psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS df1 ON psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS df2 ON psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco 
	WHERE
		psyem_seguimiento.idStatusSeg != 2 
		AND psyem_seguimiento.fRegistrSeg = _fechaFinalSeg  AND psyem_seguimiento.idProfesional = _idProfesional
	ORDER BY
		psyem_seguimiento.fRegistrSeg DESC,
		psyem_seguimiento.idSeguimiento DESC;
	ELSE SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg,
		psyem_seguimiento.idAtencionPac,
		psyem_atencion.cuentaAtencion,
		psyem_atencion.tipdocAtencion,
		psyem_atencion.nrodocAtencion,
		psyem_atencion.historiaAtencion,
		psyem_atencion.nombAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_seguimiento.idTipoSeguimiento,
		psyem_tiposeguimiento.detaTipSeguimiento,
		psyem_seguimiento.idMotSeguimiento,
		psyem_motivoseguimiento.detaMotivoSef,
		psyem_seguimiento.idProfesional,
		psyem_profesionales.nombresProfesional,
		psyem_profesionales.apellidosProfesional,
		psyem_seguimiento.comunFamSeg,
		psyem_seguimiento.idDiag1Seg,
		psyem_diagnosticos.cieDiagnostico AS cieP1,
		psyem_diagnosticos.detaDiagnostico AS detaD1,
		psyem_seguimiento.idDiag2Seg,
		dp2.cieDiagnostico AS cieP2,
		dp2.detaDiagnostico AS detD2,
		psyem_seguimiento.idFamAtSeg,
		psyem_famatencion.nombApFamiliar,
		psyem_famatencion.telcelFamiliar,
		psyem_parentescofam.detaParentesco,
		psyem_seguimiento.idDiag1SegFam,
		df1.cieDiagnostico AS cieDF1,
		df1.detaDiagnostico AS detDF1,
		psyem_seguimiento.idDiag2SegFam,
		df2.cieDiagnostico AS cieDF2,
		df2.detaDiagnostico AS detDF2,
		psyem_seguimiento.obsSeg,
		psyem_seguimiento.idStatusSeg,
		psyem_estatusseguimiento.detaStatusSeg 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_estatusseguimiento ON psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS dp2 ON psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS df1 ON psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS df2 ON psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco 
	WHERE
		psyem_seguimiento.idStatusSeg != 2 
		AND 
		psyem_seguimiento.fRegistrSeg BETWEEN _fechaInicialSeg AND _fechaFinalSeg AND psyem_seguimiento.idProfesional = _idProfesional
	ORDER BY
		psyem_seguimiento.fRegistrSeg DESC,
	psyem_seguimiento.idSeguimiento DESC ;
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_SEGUIMIENTOS_MONITOREO` ()   SELECT
	psyem_seguimiento.idSeguimiento, 
	date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg, 
	psyem_seguimiento.idAtencionPac, 
	psyem_estadopaciente.detaEstadoPacAtencion, 
	psyem_atencion.cuentaAtencion, 
	psyem_atencion.tipdocAtencion, 
	psyem_atencion.nrodocAtencion, 
	psyem_atencion.historiaAtencion, 
	psyem_atencion.nombAtencion, 
	psyem_atencion.apPaternoAtencion, 
	psyem_atencion.apMaternoAtencion, 
	psyem_seguimiento.idTipoSeguimiento, 
	psyem_tiposeguimiento.detaTipSeguimiento, 
	psyem_seguimiento.idMotSeguimiento, 
	psyem_motivoseguimiento.detaMotivoSef, 
	psyem_seguimiento.idProfesional, 
	psyem_profesionales.nombresProfesional, 
	psyem_profesionales.apellidosProfesional, 
	psyem_seguimiento.comunFamSeg, 
	psyem_seguimiento.idDiag1Seg, 
	psyem_diagnosticos.cieDiagnostico AS cieP1, 
	psyem_diagnosticos.detaDiagnostico AS detaD1, 
	psyem_seguimiento.idDiag2Seg, 
	dp2.cieDiagnostico AS cieP2, 
	dp2.detaDiagnostico AS detD2, 
	psyem_seguimiento.idFamAtSeg, 
	psyem_famatencion.nombApFamiliar, 
	psyem_famatencion.telcelFamiliar, 
	psyem_parentescofam.detaParentesco, 
	psyem_seguimiento.idDiag1SegFam, 
	df1.cieDiagnostico AS cieDF1, 
	df1.detaDiagnostico AS detDF1, 
	psyem_seguimiento.idDiag2SegFam, 
	df2.cieDiagnostico AS cieDF2, 
	df2.detaDiagnostico AS detDF2, 
	psyem_seguimiento.obsSeg, 
	psyem_seguimiento.idStatusSeg, 
	psyem_estatusseguimiento.detaStatusSeg, 
	psyem_atencion.idEstadoPacAtencion
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_atencion
	ON 
		psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
	INNER JOIN
	psyem_profesionales
	ON 
		psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
	INNER JOIN
	psyem_tiposeguimiento
	ON 
		psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
	INNER JOIN
	psyem_motivoseguimiento
	ON 
		psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
	INNER JOIN
	psyem_estatusseguimiento
	ON 
		psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
	LEFT JOIN
	psyem_famatencion
	ON 
		psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos AS dp2
	ON 
		psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos AS df1
	ON 
		psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos AS df2
	ON 
		psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
	LEFT JOIN
	psyem_parentescofam
	ON 
		psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	INNER JOIN
	psyem_estadopaciente
	ON 
		psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
WHERE
	MONTH ( psyem_seguimiento.fRegistrSeg ) = MONTH (
	CURDATE()) AND
	YEAR( psyem_seguimiento.fRegistrSeg ) = YEAR(CURDATE()) AND
	psyem_seguimiento.idStatusSeg != 2
ORDER BY
	psyem_seguimiento.fRegistrSeg DESC, 
	psyem_seguimiento.idSeguimiento DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_SEGUIMIENTOS_MONITOREO_FECHAS` (IN `_fechaInicialSeg` DATE, IN `_fechaFinalSeg` DATE)   SELECT
	psyem_seguimiento.idSeguimiento, 
	date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fRegistrSeg, 
	psyem_seguimiento.idAtencionPac, 
	psyem_estadopaciente.detaEstadoPacAtencion, 
	psyem_atencion.cuentaAtencion, 
	psyem_atencion.tipdocAtencion, 
	psyem_atencion.nrodocAtencion, 
	psyem_atencion.historiaAtencion, 
	psyem_atencion.nombAtencion, 
	psyem_atencion.apPaternoAtencion, 
	psyem_atencion.apMaternoAtencion, 
	psyem_seguimiento.idTipoSeguimiento, 
	psyem_tiposeguimiento.detaTipSeguimiento, 
	psyem_seguimiento.idMotSeguimiento, 
	psyem_motivoseguimiento.detaMotivoSef, 
	psyem_seguimiento.idProfesional, 
	psyem_profesionales.nombresProfesional, 
	psyem_profesionales.apellidosProfesional, 
	psyem_seguimiento.comunFamSeg, 
	psyem_seguimiento.idDiag1Seg, 
	psyem_diagnosticos.cieDiagnostico AS cieP1, 
	psyem_diagnosticos.detaDiagnostico AS detaD1, 
	psyem_seguimiento.idDiag2Seg, 
	dp2.cieDiagnostico AS cieP2, 
	dp2.detaDiagnostico AS detD2, 
	psyem_seguimiento.idFamAtSeg, 
	psyem_famatencion.nombApFamiliar, 
	psyem_famatencion.telcelFamiliar, 
	psyem_parentescofam.detaParentesco, 
	psyem_seguimiento.idDiag1SegFam, 
	df1.cieDiagnostico AS cieDF1, 
	df1.detaDiagnostico AS detDF1, 
	psyem_seguimiento.idDiag2SegFam, 
	df2.cieDiagnostico AS cieDF2, 
	df2.detaDiagnostico AS detDF2, 
	psyem_seguimiento.obsSeg, 
	psyem_seguimiento.idStatusSeg, 
	psyem_estatusseguimiento.detaStatusSeg, 
	psyem_atencion.idEstadoPacAtencion
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_atencion
	ON 
		psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
	INNER JOIN
	psyem_profesionales
	ON 
		psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
	INNER JOIN
	psyem_tiposeguimiento
	ON 
		psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
	INNER JOIN
	psyem_motivoseguimiento
	ON 
		psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
	INNER JOIN
	psyem_estatusseguimiento
	ON 
		psyem_seguimiento.idStatusSeg = psyem_estatusseguimiento.idStatusSeg
	LEFT JOIN
	psyem_famatencion
	ON 
		psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos AS dp2
	ON 
		psyem_seguimiento.idDiag2Seg = dp2.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos AS df1
	ON 
		psyem_seguimiento.idDiag1SegFam = df1.idDiagnostico
	LEFT JOIN
	psyem_diagnosticos AS df2
	ON 
		psyem_seguimiento.idDiag2SegFam = df2.idDiagnostico
	LEFT JOIN
	psyem_parentescofam
	ON 
		psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	INNER JOIN
	psyem_estadopaciente
	ON 
		psyem_atencion.idEstadoPacAtencion = psyem_estadopaciente.idEstadoPacAtencion
WHERE
	psyem_seguimiento.idStatusSeg != 2 AND psyem_seguimiento.fRegistrSeg BETWEEN _fechaInicialSeg AND _fechaFinalSeg
ORDER BY
	psyem_seguimiento.fRegistrSeg DESC, 
	psyem_seguimiento.idSeguimiento DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_SEXO` ()   SELECT
	psyem_tipsexo.idTipSexo, 
	psyem_tipsexo.detaTipSexo
FROM
	psyem_tipsexo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_TIPO_SEGUIMIENTO` ()   SELECT
	psyem_tiposeguimiento.idTipoSeguimiento, 
	psyem_tiposeguimiento.detaTipSeguimiento
FROM
	psyem_tiposeguimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_USUARIOS` ()   SELECT
	psyem_usuarios.idUsuario, 
	psyem_usuarios.dniUsuario, 
	psyem_usuarios.apellidosUsuario, 
	psyem_usuarios.nombresUsuario, 
	psyem_usuarios.cuentaUsuario, 
	psyem_usuarios.correoUsuario, 
	psyem_usuarios.claveUsuario, 
	psyem_usuarios.intentosUsuario,
	date_format(psyem_usuarios.fechaAlta,'%d/%m/%Y') as fechaAlta, 
	psyem_usuarios.profileUsuario, 
	psyem_usuarios.idPerfil, 
	psyem_perfiles.detallePerfil, 
	psyem_usuarios.idEstado, 
	psyem_estadosu.detalleEstadoU,
	psyem_profesionales.idProfesional, 
	psyem_profesionales.nombresProfesional, 
	psyem_profesionales.apellidosProfesional
FROM
	psyem_usuarios
	INNER JOIN
	psyem_perfiles
	ON 
		psyem_usuarios.idPerfil = psyem_perfiles.idPerfil
	INNER JOIN
	psyem_estadosu
	ON 
		psyem_usuarios.idEstado = psyem_estadosu.idEstado
	LEFT JOIN
	psyem_profesionales
	ON 
		psyem_usuarios.dniUsuario = psyem_profesionales.dniProfesional 
	ORDER BY psyem_usuarios.idPerfil ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_WIDGETS` ()   SELECT COUNT(*) as nseguimientos, (SELECT COUNT(*) from psyem_atencion WHERE idEstadoAte != 3) as natenciones, (SELECT COUNT(*) from psyem_famatencion) as nfamiliares, (SELECT COUNT(*) from psyem_usuarios) as nusuarios,(SELECT COUNT(*) FROM psyem_profesionales) as nprofesionales,(SELECT COUNT(*) FROM psyem_diagnosticos) as ndiagnosticos from psyem_seguimiento WHERE idStatusSeg != 2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGIN_USUARIO` (IN `_cuentaUsuario` VARCHAR(50))   SELECT
	psyem_usuarios.idUsuario, 
	psyem_usuarios.dniUsuario, 
	psyem_usuarios.apellidosUsuario, 
	psyem_usuarios.nombresUsuario, 
	psyem_usuarios.cuentaUsuario, 
	psyem_usuarios.correoUsuario, 
	psyem_usuarios.claveUsuario, 
	psyem_usuarios.intentosUsuario, 
	psyem_usuarios.fechaAlta, 
	psyem_usuarios.profileUsuario, 
	psyem_usuarios.idPerfil, 
	psyem_perfiles.detallePerfil, 
	psyem_usuarios.idEstado, 
	psyem_estadosu.detalleEstadoU,
		psyem_profesionales.idProfesional,
		CONCAT(psyem_profesionales.nombresProfesional,' ',psyem_profesionales.apellidosProfesional) AS profesional
FROM
	psyem_usuarios
	INNER JOIN
	psyem_perfiles
	ON 
		psyem_usuarios.idPerfil = psyem_perfiles.idPerfil
	INNER JOIN
	psyem_estadosu
	ON 
		psyem_usuarios.idEstado = psyem_estadosu.idEstado
	LEFT JOIN
	psyem_profesionales
	ON 
		psyem_usuarios.dniUsuario = psyem_profesionales.dniProfesional 
WHERE psyem_usuarios.cuentaUsuario = _cuentaUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_ATENCION` (IN `_fRegistroAtencion` DATE, IN `_idEpisodio` TEXT, IN `_cuentaAtencion` VARCHAR(20), IN `_historiaAtencion` VARCHAR(20), IN `_idEstadoPacAtencion` INT(11), IN `_fechaPacNacimiento` DATE, IN `_tipdocAtencion` VARCHAR(20), IN `_nrodocAtencion` VARCHAR(15), IN `_apPaternoAtencion` VARCHAR(30), IN `_apMaternoAtencion` VARCHAR(30), IN `_nombAtencion` VARCHAR(30), IN `_fIngresoAtencion` DATE, IN `_servAtencion` VARCHAR(100), IN `_camaAtencion` VARCHAR(20), IN `_distritoAtencion` VARCHAR(100), IN `_edadAtencion` VARCHAR(20), IN `_tipSexoAtencion` INT(11), IN `_financiaAtencion` VARCHAR(50), IN `_idURegAtencion` INT(11))   INSERT INTO psyem_atencion (
	fRegistroAtencion,
	idEpisodio,
	cuentaAtencion,
	historiaAtencion,
	idEstadoPacAtencion,
	fechaPacNacimiento,
	tipdocAtencion,
	nrodocAtencion,
	apPaternoAtencion,
	apMaternoAtencion,
	nombAtencion,
	fIngresoAtencion,
	servAtencion,
	camaAtencion,
	distritoAtencion,
	edadAtencion,
	tipSexoAtencion,
	financiaAtencion,
	idURegAtencion 
)
VALUES
	(
		_fRegistroAtencion,
		_idEpisodio,
		_cuentaAtencion,
		_historiaAtencion,
		_idEstadoPacAtencion,
		_fechaPacNacimiento,
		_tipdocAtencion,
		_nrodocAtencion,
		_apPaternoAtencion,
		_apMaternoAtencion,
		_nombAtencion,
		_fIngresoAtencion,
		_servAtencion,
		_camaAtencion,
		_distritoAtencion,
		_edadAtencion,
		_tipSexoAtencion,
		_financiaAtencion,
	_idURegAtencion 
	)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_AUDATENCION` (IN `_idAtencion` INT(11), IN `_fechaRegAudi` DATE, IN `_idUsuario` INT(11), IN `_AccRealizada` TEXT, IN `_cuentaAnterior` TEXT, IN `_EpisodioAnterior` TEXT, IN `_cuentaNueva` TEXT, IN `_EpisodioNuevo` TEXT)   INSERT INTO zpsyem_aud_atenciones ( idAtencion, fechaRegAudi, idUsuario, AccRealizada, cuentaAnterior, EpisodioAnterior, cuentaNueva, EpisodioNuevo )
VALUES
	(
		_idAtencion,
		_fechaRegAudi,
		_idUsuario,
		_AccRealizada,
		_cuentaAnterior,
		_EpisodioAnterior,
	_cuentaNueva,
	_EpisodioNuevo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_AUDATENCION2` (IN `_idAtencion` INT(11), IN `_fechaRegAudi` DATE, IN `_idUsuario` INT(11), IN `_AccRealizada` TEXT, IN `_cuentaAnterior` TEXT, IN `_EpisodioAnterior` TEXT)   INSERT INTO zpsyem_aud_atenciones (idAtencion, fechaRegAudi, idUsuario, AccRealizada, cuentaAnterior, EpisodioAnterior)
VALUES
	(
		_idAtencion,
		_fechaRegAudi,
		_idUsuario,
		_AccRealizada,
		_cuentaAnterior,
		_EpisodioAnterior)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_AUDFAMILIAR` (IN `_idFamiliar` INT(11), IN `_fecRegAudi` DATE, IN `_idUsuario` INT(11), IN `_AccRealizada` TEXT, IN `_idAtencionAnt` INT(11), IN `_ndocAnt` VARCHAR(20), IN `_idAtencionNueva` INT(11), IN `_ndocNuevo` VARCHAR(20))   INSERT INTO zpsyem_aud_familiares (idFamiliar,fecRegAudi, idUsuario, AccRealizada, idAtencionAnt, ndocAnt, idAtencionNueva, ndocNuevo )
VALUES
	( _idFamiliar,_fecRegAudi, _idUsuario, _AccRealizada, _idAtencionAnt, _ndocAnt, _idAtencionNueva, _ndocNuevo )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_AUDFAMILIAR2` (IN `_idFamiliar` INT(11), IN `_fecRegAudi` DATE, IN `_idUsuario` INT(11), IN `_AccRealizada` TEXT, IN `_idAtencionAnt` INT(11), IN `_ndocAnt` VARCHAR(20))   INSERT INTO zpsyem_aud_familiares ( idFamiliar,fecRegAudi, idUsuario, AccRealizada, idAtencionAnt, ndocAnt)
VALUES
	(_idFamiliar,_fecRegAudi, _idUsuario, _AccRealizada, _idAtencionAnt, _ndocAnt)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_DIAGNOSTICO` (IN `_cieDiagnostico` VARCHAR(20), IN `_detaDiagnostico` VARCHAR(100))   INSERT INTO psyem_diagnosticos(cieDiagnostico,detaDiagnostico) VALUES(_cieDiagnostico,_detaDiagnostico)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_FAMILIARES` (IN `_fechaRegistro` DATE, IN `_idUsuario` INT(11), IN `_idAtencion` INT(11), IN `_idParentesco` INT(11), IN `_idTipSexo` INT(11), IN `_tipdocFamiliar` VARCHAR(20), IN `_ndocFamiliar` VARCHAR(20), IN `_nombApFamiliar` VARCHAR(100), IN `_edadFamiliar` VARCHAR(20), IN `_telcelFamiliar` VARCHAR(12))   INSERT INTO psyem_famatencion ( fechaRegistro, idUsuario, idAtencion, idParentesco, idTipSexo, tipdocFamiliar, ndocFamiliar, nombApFamiliar, edadFamiliar, telcelFamiliar )
VALUES
	( _fechaRegistro, _idUsuario, _idAtencion, _idParentesco, _idTipSexo, _tipdocFamiliar, _ndocFamiliar, _nombApFamiliar, _edadFamiliar, _telcelFamiliar )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_PROFESIONAL` (IN `_idCondicion` INT(11), `_dniProfesional` VARCHAR(15), IN `_cpspProfesional` VARCHAR(25), IN `_apellidosProfesional` VARCHAR(50), IN `_nombresProfesional` VARCHAR(50))   INSERT INTO psyem_profesionales(idCondicion,dniProfesional,cpspProfesional,apellidosProfesional,nombresProfesional) VALUES(_idCondicion,_dniProfesional,_cpspProfesional,_apellidosProfesional,_nombresProfesional)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_SEGUIMIENTO` (IN `_fRegistrSeg` DATE, IN `_idUsuario` INT(11), IN `_idAtencionPac` INT(11), IN `_idProfesional` INT(11), IN `_idTipoSeguimiento` INT(11), IN `_idMotSeguimiento` INT(11), IN `_idDiag1Seg` INT(11), IN `_idDiag2Seg` INT(11), IN `_comunFamSeg` VARCHAR(10), IN `_idFamAtSeg` INT(11), IN `_idDiag1SegFam` INT(11), IN `_idDiag2SegFam` INT(11), IN `_obsSeg` VARCHAR(200))   INSERT INTO psyem_seguimiento (
	fRegistrSeg,
	idUsuario,
	idAtencionPac,
	idProfesional,
	idTipoSeguimiento,
	idMotSeguimiento,
	idDiag1Seg,
	idDiag2Seg,
	comunFamSeg,
	idFamAtSeg,
	idDiag1SegFam,
	idDiag2SegFam,
	obsSeg 
)
VALUES
	(
		_fRegistrSeg,
		_idUsuario,
		_idAtencionPac,
		_idProfesional,
		_idTipoSeguimiento,
		_idMotSeguimiento,
		_idDiag1Seg,
		_idDiag2Seg,
		_comunFamSeg,
		_idFamAtSeg,
		_idDiag1SegFam,
	_idDiag2SegFam,
	_obsSeg)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_USUARIO` (IN `_idPerfil` INT(11), IN `_dniUsuario` VARCHAR(20), IN `_apellidosUsuario` VARCHAR(50), IN `_nombresUsuario` VARCHAR(50), IN `_cuentaUsuario` VARCHAR(50), IN `_correoUsuario` VARCHAR(50), IN `_claveUsuario` VARCHAR(100))   INSERT INTO psyem_usuarios ( idPerfil, dniUsuario, apellidosUsuario, nombresUsuario, cuentaUsuario, correoUsuario, claveUsuario )
VALUES
	( _idPerfil, _dniUsuario, _apellidosUsuario, _nombresUsuario, _cuentaUsuario, _correoUsuario, _claveUsuario )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRO_INTENTOS` (IN `_idUsuario` INT(11))   BEGIN
UPDATE psyem_usuarios SET intentosUsuario = intentosUsuario + 1 WHERE idUsuario = _idUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_ATEREGANU` (IN `_inicio` VARCHAR(10), IN `_fin` VARCHAR(10))   IF _inicio = "" THEN
	SELECT
	MONTH
	( psyem_atencion.fRegistroAtencion ) AS NMES, 
	MES_SPANISH ( psyem_atencion.fRegistroAtencion, 'es_ES' ) AS MES, 
	COUNT(
	IF
	(psyem_estadoatencion.idEstadoAte = 1, 1, NULL )) AS REGISTRADAS,
	COUNT(
	IF
	( psyem_estadoatencion.idEstadoAte = 2, 1, NULL )) AS ANULADAS
FROM
	psyem_atencion
	INNER JOIN
	psyem_estadoatencion
	ON 
		psyem_atencion.idEstadoAte = psyem_estadoatencion.idEstadoAte
WHERE
	YEAR ( psyem_atencion.fRegistroAtencion ) = YEAR (
	CURDATE())
GROUP BY
	NMES, 
	MES
ORDER BY
	MONTH (
	psyem_atencion.fRegistroAtencion);
	ELSE 
	SELECT MONTH
		( psyem_atencion.fRegistroAtencion ) AS NMES,
		MES_SPANISH ( psyem_atencion.fRegistroAtencion, 'es_ES' ) AS MES,
		COUNT(
	IF
	(psyem_estadoatencion.idEstadoAte = 1, 1, NULL )) AS REGISTRADAS,
	COUNT(
	IF
	( psyem_estadoatencion.idEstadoAte = 2, 1, NULL )) AS ANULADAS 
	FROM
		psyem_atencion
		INNER JOIN psyem_estadoatencion ON psyem_atencion.idEstadoAte = psyem_estadoatencion.idEstadoAte 
	WHERE
		psyem_atencion.fRegistroAtencion BETWEEN _inicio 
		AND _fin 
	GROUP BY
		NMES,
		MES
	ORDER BY
	MONTH ( psyem_atencion.fRegistroAtencion ); 
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_AUDIATENCIONES` (IN `_inicio` VARCHAR(10), IN `_fin` VARCHAR(10))   IF
	_inicio = "" THEN
	SELECT
		zpsyem_aud_atenciones.idAuditAte,
		date_format( zpsyem_aud_atenciones.fechaRegAudi, '%d/%m/%Y' ) AS fechaRegistro,
		psyem_atencion.tipdocAtencion,
		psyem_atencion.nrodocAtencion,
		psyem_atencion.nombAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_usuarios.cuentaUsuario,
		zpsyem_aud_atenciones.AccRealizada,
		zpsyem_aud_atenciones.cuentaAnterior,
		zpsyem_aud_atenciones.EpisodioAnterior,
		zpsyem_aud_atenciones.cuentaNueva,
		zpsyem_aud_atenciones.EpisodioNuevo 
	FROM
		zpsyem_aud_atenciones
		INNER JOIN psyem_atencion ON zpsyem_aud_atenciones.idAtencion = psyem_atencion.idAtencion
		INNER JOIN psyem_usuarios ON zpsyem_aud_atenciones.idUsuario = psyem_usuarios.idUsuario 
	WHERE
		YEAR ( psyem_atencion.fRegistroAtencion ) = YEAR (
		CURDATE()) ORDER BY fechaRegAudi;
		ELSE	
		SELECT
		zpsyem_aud_atenciones.idAuditAte,
		date_format( zpsyem_aud_atenciones.fechaRegAudi, '%d/%m/%Y' ) AS fechaRegistro,
		psyem_atencion.tipdocAtencion,
		psyem_atencion.nrodocAtencion,
		psyem_atencion.nombAtencion,
		psyem_atencion.apMaternoAtencion,
		psyem_atencion.apPaternoAtencion,
		psyem_usuarios.cuentaUsuario,
		zpsyem_aud_atenciones.AccRealizada,
		zpsyem_aud_atenciones.cuentaAnterior,
		zpsyem_aud_atenciones.EpisodioAnterior,
		zpsyem_aud_atenciones.cuentaNueva,
		zpsyem_aud_atenciones.EpisodioNuevo 
	FROM
		zpsyem_aud_atenciones
		INNER JOIN psyem_atencion ON zpsyem_aud_atenciones.idAtencion = psyem_atencion.idAtencion
		INNER JOIN psyem_usuarios ON zpsyem_aud_atenciones.idUsuario = psyem_usuarios.idUsuario 
	WHERE zpsyem_aud_atenciones.fechaRegAudi BETWEEN _inicio 
		AND _fin 
	ORDER BY fechaRegAudi; 
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_AUDIFAMILIARES` (IN `_inicio` VARCHAR(10), IN `_fin` VARCHAR(10))   IF _inicio = "" THEN
	SELECT
	zpsyem_aud_familiares.idAudiFam,
	date_format( zpsyem_aud_familiares.fecRegAudi, '%d/%m/%Y' ) AS fechaRegistro,
	psyem_usuarios.cuentaUsuario,
	zpsyem_aud_familiares.AccRealizada,
	zpsyem_aud_familiares.idAtencionAnt,
	zpsyem_aud_familiares.ndocAnt,
	zpsyem_aud_familiares.idAtencionNueva,
	zpsyem_aud_familiares.ndocNuevo,
	psyem_famatencion.tipdocFamiliar,
	psyem_famatencion.ndocFamiliar,
	psyem_famatencion.nombApFamiliar 
FROM
	zpsyem_aud_familiares
	INNER JOIN psyem_famatencion ON zpsyem_aud_familiares.idFamiliar = psyem_famatencion.idFamiliar
	INNER JOIN psyem_usuarios ON zpsyem_aud_familiares.idUsuario = psyem_usuarios.idUsuario 
WHERE
	YEAR ( zpsyem_aud_familiares.fecRegAudi ) = YEAR (
	CURDATE()) 
ORDER BY
	fecRegAudi;
ELSE
	SELECT
	zpsyem_aud_familiares.idAudiFam,
	zpsyem_aud_familiares.fecRegAudi,
	psyem_usuarios.cuentaUsuario,
	zpsyem_aud_familiares.AccRealizada,
	zpsyem_aud_familiares.idAtencionAnt,
	zpsyem_aud_familiares.ndocAnt,
	zpsyem_aud_familiares.idAtencionNueva,
	zpsyem_aud_familiares.ndocNuevo,
	psyem_famatencion.tipdocFamiliar,
	psyem_famatencion.ndocFamiliar,
	psyem_famatencion.nombApFamiliar 
FROM
	zpsyem_aud_familiares
	INNER JOIN psyem_famatencion ON zpsyem_aud_familiares.idFamiliar = psyem_famatencion.idFamiliar
	INNER JOIN psyem_usuarios ON zpsyem_aud_familiares.idUsuario = psyem_usuarios.idUsuario 
WHERE zpsyem_aud_familiares.fecRegAudi BETWEEN _inicio 
		AND _fin 
ORDER BY
	fecRegAudi;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_PARENTESCO` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10))   IF _INICIO = "" THEN
	SELECT
	COUNT( psyem_seguimiento.idSeguimiento ) AS CONTEO,
	psyem_parentescofam.detaParentesco AS PARENTESCO 
FROM
	psyem_famatencion
	INNER JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	INNER JOIN psyem_seguimiento ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar 
WHERE
	YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
	CURDATE()) 
GROUP BY
	PARENTESCO
ORDER BY CONTEO DESC;
ELSE
	SELECT
	COUNT( psyem_seguimiento.idSeguimiento ) AS CONTEO,
	psyem_parentescofam.detaParentesco AS PARENTESCO 
FROM
	psyem_famatencion
	INNER JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
	INNER JOIN psyem_seguimiento ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar 
WHERE
	psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN
GROUP BY
	PARENTESCO
ORDER BY CONTEO DESC;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGMENSXPROFESIONAL` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF _INICIO = "" THEN
	SELECT MONTH
		( psyem_seguimiento.fRegistrSeg ) AS NMES,
		MES_SPANISH ( psyem_seguimiento.fRegistrSeg, 'es_ES' ) AS MES,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) AND psyem_seguimiento.idProfesional = _PROFESIONAL
	GROUP BY
		NMES,
		MES 
	ORDER BY
		MONTH ( psyem_seguimiento.fRegistrSeg );
ELSE
		SELECT MONTH
		( psyem_seguimiento.fRegistrSeg ) AS NMES,
		MES_SPANISH ( psyem_seguimiento.fRegistrSeg, 'es_ES' ) AS MES,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND (psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN)  AND psyem_seguimiento.idProfesional = _PROFESIONAL
	GROUP BY
		NMES,
		MES 
	ORDER BY
		MONTH ( psyem_seguimiento.fRegistrSeg );
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGTIPOXPROFESIONAL` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF _INICIO = "" THEN
	SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE())  AND psyem_seguimiento.idProfesional = _PROFESIONAL
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
ELSE
SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 AND (psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN)  AND psyem_seguimiento.idProfesional = _PROFESIONAL
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMIENTOXDIAGFAM` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF
	( _INICIO = "" AND _PROFESIONAL = 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1SegFam = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL = 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1SegFam = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL = 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1SegFam = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL != 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1SegFam = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL != 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1SegFam = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMIENTOXDIAGPAC` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF
	( _INICIO = "" AND _PROFESIONAL = 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL = 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL = 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL != 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL != 0 ) THEN
SELECT
	COUNT(psyem_seguimiento.idSeguimiento) AS CONTADOR, 
	psyem_diagnosticos.cieDiagnostico AS DIAGNOSTICO
FROM
	psyem_seguimiento
	INNER JOIN
	psyem_diagnosticos
	ON 
		psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		DIAGNOSTICO
	ORDER BY
		CONTADOR DESC;
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMIENTOXPROFESIONAL` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF
	( _INICIO = "" AND _PROFESIONAL = 0 ) THEN
	SELECT
		CONCAT( psyem_profesionales.nombresProfesional, " ", psyem_profesionales.apellidosProfesional ) AS PROFESIONAL,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		PROFESIONAL 
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL = 0 ) THEN
	SELECT
		CONCAT( psyem_profesionales.nombresProfesional, " ", psyem_profesionales.apellidosProfesional ) AS PROFESIONAL,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional 
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
	GROUP BY
		PROFESIONAL 
	ORDER BY
		CONTADOR DESC;
		ELSEIF ( _INICIO = _FIN AND _PROFESIONAL = 0 ) THEN
	SELECT
		CONCAT( psyem_profesionales.nombresProfesional, " ", psyem_profesionales.apellidosProfesional ) AS PROFESIONAL,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		PROFESIONAL 
	ORDER BY
		CONTADOR DESC;
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL != 0 ) THEN
	SELECT
		CONCAT( psyem_profesionales.nombresProfesional, " ", psyem_profesionales.apellidosProfesional ) AS PROFESIONAL,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		PROFESIONAL 
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL != 0 ) THEN
	SELECT
		CONCAT( psyem_profesionales.nombresProfesional, " ", psyem_profesionales.apellidosProfesional ) AS PROFESIONAL,
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional 
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		PROFESIONAL 
	ORDER BY
		CONTADOR DESC;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMIENTOXTIPO` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF
	( _INICIO = "" AND _PROFESIONAL = 0 ) THEN
	SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL = 0 ) THEN
	SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL = 0 ) THEN
	SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL != 0 ) THEN
	SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL != 0 ) THEN
	SELECT
		COUNT( psyem_seguimiento.idSeguimiento ) AS CONTADOR,
		psyem_tiposeguimiento.detaTipSeguimiento AS TIPO 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento 
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	GROUP BY
		TIPO 
	ORDER BY
		CONTADOR DESC;
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMIENTO_JEFATURA` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF
	( _INICIO = "" AND _PROFESIONAL = 0 ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND MONTH ( psyem_seguimiento.fRegistrSeg ) = MONTH (
		CURDATE()) 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	ORDER BY
		fRegistrSeg ASC, idSeguimiento DESC;
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL = 0 ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
	ORDER BY
		idSeguimiento DESC,
		fRegistrSeg ASC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL = 0 ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND MONTH ( psyem_seguimiento.fRegistrSeg ) = MONTH (
		CURDATE()) 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	ORDER BY
		idSeguimiento DESC,
		fRegistrSeg ASC;
	
	ELSEIF ( _INICIO = _FIN AND _PROFESIONAL != 0 ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND MONTH ( psyem_seguimiento.fRegistrSeg ) = MONTH (
		CURDATE()) 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	ORDER BY
		idSeguimiento DESC,
		fRegistrSeg ASC;
	
	ELSEIF ( _INICIO != _FIN AND _PROFESIONAL != 0 ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL
	ORDER BY
		idSeguimiento DESC,
		fRegistrSeg ASC;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMIENTO_PROFESIONAL` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10), IN `_PROFESIONAL` INT(11))   IF
	( _INICIO = "" ) THEN
	SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND MONTH ( psyem_seguimiento.fRegistrSeg ) = MONTH (
		CURDATE()) 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	ORDER BY
		fRegistrSeg DESC,
		idSeguimiento DESC;
	ELSE SELECT
		psyem_seguimiento.idSeguimiento,
		date_format( psyem_seguimiento.fRegistrSeg, '%d/%m/%Y' ) AS fecha,
		psyem_tiposeguimiento.detaTipSeguimiento AS tipo,
		psyem_motivoseguimiento.detaMotivoSef AS motivo,
		CONCAT( psyem_atencion.tipdocAtencion, '-', psyem_atencion.nrodocAtencion ) AS docpaciente,
		psyem_atencion.historiaAtencion,
		CONCAT( psyem_atencion.nombAtencion, " ", psyem_atencion.apPaternoAtencion, " ", psyem_atencion.apMaternoAtencion ) AS nombpaciente,
		psyem_atencion.edadAtencion AS edadPaciente,
		psyem_tipsexo.detaTipSexo AS sexoPac,
		psyem_diagnosticos.cieDiagnostico AS diagPac,
		ACTPAC.cieDiagnostico AS actPac,
		psyem_seguimiento.comunFamSeg AS comunicacion,
		CONCAT( psyem_famatencion.tipdocFamiliar, "-", psyem_famatencion.ndocFamiliar ) AS docfamiliar,
		psyem_famatencion.nombApFamiliar,
		psyem_parentescofam.detaParentesco AS parentesco,
		psyem_famatencion.edadFamiliar,
		sexPaciente.detaTipSexo AS sexoFam,
		diagFam1.cieDiagnostico AS diagFam,
		ACTFAM.cieDiagnostico AS actFam,
		CONCAT( psyem_profesionales.nombresProfesional, ' ', psyem_profesionales.apellidosProfesional ) AS profesional 
	FROM
		psyem_seguimiento
		INNER JOIN psyem_atencion ON psyem_seguimiento.idAtencionPac = psyem_atencion.idAtencion
		INNER JOIN psyem_profesionales ON psyem_seguimiento.idProfesional = psyem_profesionales.idProfesional
		INNER JOIN psyem_tipsexo ON psyem_atencion.tipSexoAtencion = psyem_tipsexo.idTipSexo
		INNER JOIN psyem_tiposeguimiento ON psyem_seguimiento.idTipoSeguimiento = psyem_tiposeguimiento.idTipoSeguimiento
		INNER JOIN psyem_motivoseguimiento ON psyem_seguimiento.idMotSeguimiento = psyem_motivoseguimiento.idMotSeguimiento
		INNER JOIN psyem_diagnosticos ON psyem_seguimiento.idDiag1Seg = psyem_diagnosticos.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTPAC ON psyem_seguimiento.idDiag2Seg = ACTPAC.idDiagnostico
		LEFT JOIN psyem_famatencion ON psyem_seguimiento.idFamAtSeg = psyem_famatencion.idFamiliar
		LEFT JOIN psyem_parentescofam ON psyem_famatencion.idParentesco = psyem_parentescofam.idParentesco
		LEFT JOIN psyem_tipsexo AS sexPaciente ON psyem_famatencion.idTipSexo = sexPaciente.idTipSexo
		LEFT JOIN psyem_diagnosticos AS diagFam1 ON psyem_seguimiento.idDiag1SegFam = diagFam1.idDiagnostico
		LEFT JOIN psyem_diagnosticos AS ACTFAM ON psyem_seguimiento.idDiag2SegFam = ACTFAM.idDiagnostico 
	WHERE
		psyem_seguimiento.idStatusSeg = 1 
		AND ( psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN ) 
		AND psyem_seguimiento.idProfesional = _PROFESIONAL 
	ORDER BY
		idSeguimiento DESC,
		fRegistrSeg DESC;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEGUIMREGS` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10))   IF
	_INICIO = "" THEN
	SELECT MONTH
		( psyem_seguimiento.fRegistrSeg ) AS NMES,
		MES_SPANISH ( psyem_seguimiento.fRegistrSeg, 'es_ES' ) AS MES,
		COUNT( psyem_seguimiento.idSeguimiento ) AS contador 
	FROM
		psyem_seguimiento 
	WHERE
		psyem_seguimiento.idStatusSeg != 2 
		AND YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
		CURDATE()) 
	GROUP BY
		NMES,
		MES 
	ORDER BY
		MONTH ( psyem_seguimiento.fRegistrSeg ); 
		ELSE 
		SELECT MONTH
	( psyem_seguimiento.fRegistrSeg ) AS NMES,
	MES_SPANISH ( psyem_seguimiento.fRegistrSeg, 'es_ES' ) AS MES,
	COUNT( psyem_seguimiento.idSeguimiento ) AS contador 
FROM
	psyem_seguimiento 
WHERE
	psyem_seguimiento.idStatusSeg != 2 
	AND psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN 
GROUP BY
	NMES,
	MES 
ORDER BY
	MONTH ( psyem_seguimiento.fRegistrSeg );
	END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_SEXO` (IN `_INICIO` VARCHAR(10), IN `_FIN` VARCHAR(10))   IF _INICIO = "" THEN
	SELECT
	COUNT( psyem_seguimiento.idSeguimiento ) AS CONTEO,
	psyem_tipsexo.detaTipSexo AS SEXO 
FROM
	psyem_famatencion
	INNER JOIN psyem_tipsexo ON psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo
	INNER JOIN psyem_seguimiento ON psyem_famatencion.idFamiliar = psyem_seguimiento.idFamAtSeg 
WHERE
	YEAR ( psyem_seguimiento.fRegistrSeg ) = YEAR (
	CURDATE()) 
GROUP BY
	SEXO 
ORDER BY
	CONTEO DESC;
ELSE
	SELECT
	COUNT( psyem_seguimiento.idSeguimiento ) AS CONTEO,
	psyem_tipsexo.detaTipSexo AS SEXO 
FROM
	psyem_famatencion
	INNER JOIN psyem_tipsexo ON psyem_famatencion.idTipSexo = psyem_tipsexo.idTipSexo
	INNER JOIN psyem_seguimiento ON psyem_famatencion.idFamiliar = psyem_seguimiento.idFamAtSeg 
WHERE
	psyem_seguimiento.fRegistrSeg BETWEEN _INICIO AND _FIN
GROUP BY
	SEXO 
ORDER BY
	CONTEO DESC;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VALIDA_FAMILIAR` (IN `_idAtencion` INT(11), IN `_ndocFamiliar` VARCHAR(20))   SELECT
	psyem_famatencion.idFamiliar, 
	psyem_famatencion.idAtencion, 
	psyem_famatencion.ndocFamiliar
FROM
	psyem_famatencion
WHERE idAtencion = _idAtencion AND ndocFamiliar = _ndocFamiliar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VERIFICA_ESTADO_LOG` (IN `_USUARIO` INT(11))   SELECT
	psyem_usuarios.idUsuario, 
	psyem_usuarios.idEstado
FROM
	psyem_usuarios
WHERE idUsuario = _USUARIO$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `MES_SPANISH` (`_d` DATE, `_locale` VARCHAR(5)) RETURNS VARCHAR(22) CHARSET utf8  BEGIN
     SET @@lc_time_names = _locale;
     RETURN UPPER(DATE_FORMAT(_d, '%M'));
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_atencion`
--

CREATE TABLE `psyem_atencion` (
  `idAtencion` int(11) NOT NULL,
  `correlativo_Atencion` text COLLATE utf8_bin,
  `fRegistroAtencion` date NOT NULL,
  `idEpisodio` text COLLATE utf8_bin NOT NULL,
  `cuentaAtencion` varchar(20) COLLATE utf8_bin NOT NULL,
  `historiaAtencion` varchar(20) COLLATE utf8_bin NOT NULL,
  `idEstadoPacAtencion` int(11) DEFAULT '0',
  `fechaPacNacimiento` date NOT NULL,
  `tipdocAtencion` varchar(20) COLLATE utf8_bin NOT NULL,
  `nrodocAtencion` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `apPaternoAtencion` varchar(30) COLLATE utf8_bin NOT NULL,
  `apMaternoAtencion` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `nombAtencion` varchar(30) COLLATE utf8_bin NOT NULL,
  `fIngresoAtencion` date NOT NULL,
  `servAtencion` varchar(100) COLLATE utf8_bin NOT NULL,
  `camaAtencion` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `distritoAtencion` varchar(100) COLLATE utf8_bin NOT NULL,
  `edadAtencion` varchar(20) COLLATE utf8_bin NOT NULL,
  `tipSexoAtencion` int(11) NOT NULL,
  `financiaAtencion` varchar(50) COLLATE utf8_bin NOT NULL,
  `idURegAtencion` int(11) NOT NULL,
  `idEstadoAte` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_atencion`
--

INSERT INTO `psyem_atencion` (`idAtencion`, `correlativo_Atencion`, `fRegistroAtencion`, `idEpisodio`, `cuentaAtencion`, `historiaAtencion`, `idEstadoPacAtencion`, `fechaPacNacimiento`, `tipdocAtencion`, `nrodocAtencion`, `apPaternoAtencion`, `apMaternoAtencion`, `nombAtencion`, `fIngresoAtencion`, `servAtencion`, `camaAtencion`, `distritoAtencion`, `edadAtencion`, `tipSexoAtencion`, `financiaAtencion`, `idURegAtencion`, `idEstadoAte`) VALUES
(1, 'ACP-2022-000001', '2022-04-06', '1858340', '1852299', '1274420', 1, '1996-08-31', 'DNI', '77478995', 'CASTRO', 'PALACIOS', 'OLGER IVAN', '2020-10-01', 'SALUD OCUPACIONAL - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '26', 1, 'PROGRAMA NACIONAL', 10, 1),
(2, 'ACP-2022-000002', '2022-04-06', '2033365', '2027335', '1362168', 1, '2015-03-06', 'DNI', '79171909', 'GAROZZI', 'YMAN', 'ALDO VALENTINO', '2022-04-06', 'CIRUGIA PEDIATRICA - EMERGENCIA', '', 'COMAS', '7', 1, 'PARTICULAR', 10, 1);

--
-- Disparadores `psyem_atencion`
--
DELIMITER $$
CREATE TRIGGER `GENERAR_CORRELATIVO_ATENCION` BEFORE INSERT ON `psyem_atencion` FOR EACH ROW BEGIN
    DECLARE cont1 int default 0;
    DECLARE anio text;
    set anio = (SELECT YEAR(CURDATE()));
    SET cont1= (SELECT count(*) FROM psyem_atencion WHERE year(fRegistroAtencion) = year(now()));
    IF (cont1 < 1) THEN
    SET NEW.correlativo_Atencion = CONCAT('ACP-',anio,'-', LPAD(cont1 + 1, 6, '0'));
    ELSE
    SET NEW.correlativo_Atencion = CONCAT('ACP-',anio,'-', LPAD(cont1 + 1, 6, '0'));
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_condicionprof`
--

CREATE TABLE `psyem_condicionprof` (
  `idCondicion` int(11) NOT NULL,
  `detaCondicion` varchar(60) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_condicionprof`
--

INSERT INTO `psyem_condicionprof` (`idCondicion`, `detaCondicion`) VALUES
(1, 'NOMBRADO'),
(2, 'CAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_diagnosticos`
--

CREATE TABLE `psyem_diagnosticos` (
  `idDiagnostico` int(11) NOT NULL,
  `cieDiagnostico` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `cieSinPto` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `detaDiagnostico` text COLLATE utf8_bin,
  `edadMinimo` int(11) DEFAULT '0',
  `edadMaxima` int(11) DEFAULT '0',
  `sexoDx` int(11) DEFAULT '0',
  `dxEstado` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_diagnosticos`
--

INSERT INTO `psyem_diagnosticos` (`idDiagnostico`, `cieDiagnostico`, `cieSinPto`, `detaDiagnostico`, `edadMinimo`, `edadMaxima`, `sexoDx`, `dxEstado`) VALUES
(1, 'F000', 'F000', 'Demencia en la enfermedad de alzheimer, de comienzo temprano', 0, 0, 0, 1),
(2, 'F001', 'F001', 'Demencia en la enfermedad de alzheimer, de comienzo tardio', 0, 0, 0, 1),
(3, 'F002', 'F002', 'Demencia en la enfermedad de alzheimer, atipica o de tipo mixto', 0, 0, 0, 1),
(4, 'F009', 'F009', 'Demencia en la enfermedad de alzheimer, no especificada', 0, 0, 0, 1),
(5, 'F010', 'F010', 'Demencia vascular de comienzo agudo', 0, 0, 0, 1),
(6, 'F011', 'F011', 'Demencia vascular por infartos multiples ', 0, 0, 0, 1),
(7, 'F012', 'F012', 'Demencia vascular subcortical', 0, 0, 0, 1),
(8, 'F013', 'F013', 'Demencia vascular mixta, cortical y subcortical ', 0, 0, 0, 1),
(9, 'F018', 'F018', 'Otras demencias vasculares', 0, 0, 0, 1),
(10, 'F019', 'F019', 'Demencia vascular, no especificada', 0, 0, 0, 1),
(11, 'F020', 'F020', ' Demencia en la enfermedad de Pick', 0, 0, 0, 1),
(12, 'F021', 'F021', 'Demencia en la enfermedad de Creutzfeldt-Jakob', 0, 0, 0, 1),
(13, 'F022', 'F022', 'Demencia en la enfermedad de Huntington', 0, 0, 0, 1),
(14, 'F023', 'F023', 'Demencia en la enfermedad de Parkinson', 0, 0, 0, 1),
(15, 'F024', 'F024', 'Demencia en la enfermedad por virus de la inmu- nodeficiencia humana [VIH]', 0, 0, 0, 1),
(16, 'F028', 'F028', 'Demencia en otras enfermedades especificadas clasificadas en otra parte', 0, 0, 0, 1),
(17, 'F03X', 'F03X', 'Demencia sin especificación.', 0, 0, 0, 1),
(18, 'F04x', 'F04x', 'Síndrome amnésico orgánico, no inducido por alcohol o por otras sustancias psico', 0, 0, 0, 1),
(19, 'F050', 'F050', 'Delirio no superpuesto a un cuadro de demencia, así descrito', 0, 0, 0, 1),
(20, 'F051', 'F051', 'Delirio superpuesto a un cuadro de demencia', 0, 0, 0, 1),
(21, 'F058', 'F058', 'Otros delirios', 0, 0, 0, 1),
(22, 'F059', 'F059', 'Delirio, no especificado', 0, 0, 0, 1),
(23, 'F060', 'F060', 'Alucinosis orgánica', 0, 0, 0, 1),
(24, 'F061', 'F061', 'Trastorno catatónico, orgánico', 0, 0, 0, 1),
(25, 'F062', 'F062', 'Trastorno delirante [esquizofreniforme], orgánico', 0, 0, 0, 1),
(26, 'F063', 'F063', 'Trastornos del humor [afectivos], orgánicos', 0, 0, 0, 1),
(27, 'F064', 'F064', 'Trastorno de ansiedad, orgánico ', 0, 0, 0, 1),
(28, 'F065', 'F065', 'Trastorno disociativo, orgánico', 0, 0, 0, 1),
(29, 'F066', 'F066', 'Trastorno de labilidad emocional [asténico], orgánico', 0, 0, 0, 1),
(30, 'F067', 'F067', 'Trastorno cognoscitivo leve', 0, 0, 0, 1),
(31, 'F068', 'F068', 'Otros trastornos mentales especificados debidos a lesión y disfunción cerebral y a enfermedad física', 0, 0, 0, 1),
(32, 'F069', 'F069', 'Trastorno mental no especificado debido a lesión y disfunción cerebral y a enfermedad', 0, 0, 0, 1),
(33, 'F070', 'F070', 'Trastorno de la personalidad, orgánico', 0, 0, 0, 1),
(34, 'F071', 'F071', 'Síndrome postencefalitico', 0, 0, 0, 1),
(35, 'F072', 'F072', 'Síndrome postconcusional', 0, 0, 0, 1),
(36, 'F078', 'F078', 'Otros trastornos orgánicos de la personalidad y del comportamiento debidos a enfermedad', 0, 0, 0, 1),
(37, 'F079', 'F079', 'Trastorno orgánico de la personalidad y del comportamiento debido a enfermedad, lesión', 0, 0, 0, 1),
(38, 'F100', 'F100', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, intoxicación aguda', 0, 0, 0, 1),
(39, 'F101', 'F101', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, uso nocivo', 0, 0, 0, 1),
(40, 'F102', 'F102', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, síndrome de dependencia', 0, 0, 0, 1),
(41, 'F103', 'F103', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, estado de abstinencia', 0, 0, 0, 1),
(42, 'F104', 'F104', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, estado de abstinencia con delirio', 0, 0, 0, 1),
(43, 'F105', 'F105', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, trastorno psicótico', 0, 0, 0, 1),
(44, 'F106', 'F106', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, síndrome amnésico', 0, 0, 0, 1),
(45, 'F107', 'F107', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(46, 'F108', 'F108', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(47, 'F109', 'F109', 'Trastornos mentales y del comportamiento debidos al uso de alcohol, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(48, 'F110', 'F110', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, intoxicación aguda', 0, 0, 0, 1),
(49, 'F111', 'F111', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, uso nocivo', 0, 0, 0, 1),
(50, 'F112', 'F112', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, síndrome de dependencia', 0, 0, 0, 1),
(51, 'F113', 'F113', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, estado de abstinencia', 0, 0, 0, 1),
(52, 'F114', 'F114', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, estado de abstinencia con delirio', 0, 0, 0, 1),
(53, 'F115', 'F115', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, trastorno psicótico', 0, 0, 0, 1),
(54, 'F116', 'F116', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, síndrome amnésico', 0, 0, 0, 1),
(55, 'F117', 'F117', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(56, 'F118', 'F118', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(57, 'F119', 'F119', 'Trastornos mentales y del comportamiento debidos al uso de opiáceos, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(58, 'F12', 'F12', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides', 0, 0, 0, 1),
(59, 'F120', 'F120', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, intoxicación aguda', 0, 0, 0, 1),
(60, 'F121', 'F121', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, uso nocivo', 0, 0, 0, 1),
(61, 'F122', 'F122', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, síndrome de dependencia', 0, 0, 0, 1),
(62, 'F123', 'F123', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, estado de abstinencia', 0, 0, 0, 1),
(63, 'F124', 'F124', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, estado de abstinencia con delirio', 0, 0, 0, 1),
(64, 'F125', 'F125', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, trastorno psicótico', 0, 0, 0, 1),
(65, 'F126', 'F126', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, síndrome amnésico', 0, 0, 0, 1),
(66, 'F127', 'F127', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(67, 'F128', 'F128', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(68, 'F129', 'F129', 'Trastornos mentales y del comportamiento debidos al uso de cannabinoides, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(69, 'F130', 'F130', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, intoxicación aguda', 0, 0, 0, 1),
(70, 'F131', 'F131', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, uso nocivo', 0, 0, 0, 1),
(71, 'F132', 'F132', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, síndrome de dependencia', 0, 0, 0, 1),
(72, 'F133', 'F133', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, estado de abstinencia', 0, 0, 0, 1),
(73, 'F134', 'F134', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, estado de abstinencia con delirio', 0, 0, 0, 1),
(74, 'F135', 'F135', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, trastorno psicótico', 0, 0, 0, 1),
(75, 'F136', 'F136', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, síndrome amnésico', 0, 0, 0, 1),
(76, 'F137', 'F137', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(77, 'F138', 'F138', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(78, 'F139', 'F139', 'Trastornos mentales y del comportamiento debidos al uso de sedantes o hipnóticos, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(79, 'F140', 'F140', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, intoxicación aguda', 0, 0, 0, 1),
(80, 'F141', 'F141', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, uso nocivo', 0, 0, 0, 1),
(81, 'F142', 'F142', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, síndrome de dependencia', 0, 0, 0, 1),
(82, 'F143', 'F143', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, estado de abstinencia', 0, 0, 0, 1),
(83, 'F144', 'F144', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, estado de abstinencia con delirio', 0, 0, 0, 1),
(84, 'F145', 'F145', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, trastorno psicótico', 0, 0, 0, 1),
(85, 'F146', 'F146', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, síndrome amnésico', 0, 0, 0, 1),
(86, 'F147', 'F147', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(87, 'F148', 'F148', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(88, 'F149', 'F149', 'Trastornos mentales y del comportamiento debidos al uso de cocaína, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(89, 'F150', 'F150', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, intoxicación aguda', 0, 0, 0, 1),
(90, 'F151', 'F151', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, uso nocivo', 0, 0, 0, 1),
(91, 'F152', 'F152', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, síndrome de dependencia', 0, 0, 0, 1),
(92, 'F153', 'F153', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, estado de abstinencia', 0, 0, 0, 1),
(93, 'F154', 'F154', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, estado de abstinencia con delirio', 0, 0, 0, 1),
(94, 'F155', 'F155', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, trastorno psicótico', 0, 0, 0, 1),
(95, 'F156', 'F156', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, síndrome amnésico', 0, 0, 0, 1),
(96, 'F157', 'F157', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(97, 'F158', 'F158', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(98, 'F159', 'F159', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(99, 'F160', 'F160', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, intoxicación aguda', 0, 0, 0, 1),
(100, 'F161', 'F161', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, uso nocivo', 0, 0, 0, 1),
(101, 'F162', 'F162', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, síndrome de dependencia', 0, 0, 0, 1),
(102, 'F163', 'F163', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, estado de abstinencia', 0, 0, 0, 1),
(103, 'F164', 'F164', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, estado de abstinencia con delirio', 0, 0, 0, 1),
(104, 'F165', 'F165', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, trastorno psicótico', 0, 0, 0, 1),
(105, 'F166', 'F166', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, síndrome amnésico', 0, 0, 0, 1),
(106, 'F167', 'F167', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(107, 'F168', 'F168', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(108, 'F169', 'F169', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(109, 'F170', 'F170', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, intoxicación aguda', 0, 0, 0, 1),
(110, 'F171', 'F171', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, uso nocivo', 0, 0, 0, 1),
(111, 'F172', 'F172', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, síndrome de dependencia', 0, 0, 0, 1),
(112, 'F173', 'F173', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, estado de abstinencia', 0, 0, 0, 1),
(113, 'F174', 'F174', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, estado de abstinencia con delirio', 0, 0, 0, 1),
(114, 'F175', 'F175', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, trastorno psicótico', 0, 0, 0, 1),
(115, 'F176', 'F176', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, síndrome amnésico', 0, 0, 0, 1),
(116, 'F177', 'F177', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, trastorno psicótico ', 0, 0, 0, 1),
(117, 'F158', 'F158', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(118, 'F159', 'F159', 'Trastornos mentales y del comportamiento debidos al uso de otros estimulantes, incluida la cafeína, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(119, 'F160', 'F160', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, intoxicación aguda', 0, 0, 0, 1),
(120, 'F161', 'F161', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, uso nocivo', 0, 0, 0, 1),
(121, 'F162', 'F162', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, síndrome de dependencia', 0, 0, 0, 1),
(122, 'F163', 'F163', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, estado de abstinencia', 0, 0, 0, 1),
(123, 'F164', 'F164', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, estado de abstinencia con delirio', 0, 0, 0, 1),
(124, 'F165', 'F165', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, trastorno psicótico', 0, 0, 0, 1),
(125, 'F166', 'F166', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, síndrome amnésico', 0, 0, 0, 1),
(126, 'F167', 'F167', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(127, 'F168', 'F168', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(128, 'F169', 'F169', 'Trastornos mentales y del comportamiento debidos al uso de alucinógenos, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(129, 'F170', 'F170', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, intoxicación aguda', 0, 0, 0, 1),
(130, 'F171', 'F171', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, uso nocivo', 0, 0, 0, 1),
(131, 'F172', 'F172', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, síndrome de dependencia', 0, 0, 0, 1),
(132, 'F173', 'F173', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, estado de abstinencia', 0, 0, 0, 1),
(133, 'F174', 'F174', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, estado de abstinencia con delirio', 0, 0, 0, 1),
(134, 'F175', 'F175', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, trastorno psicótico', 0, 0, 0, 1),
(135, 'F176', 'F176', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, síndrome amnésico', 0, 0, 0, 1),
(136, 'F177', 'F177', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, trastorno psicótico', 0, 0, 0, 1),
(137, 'F178', 'F178', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(138, 'F179', 'F179', 'Trastornos mentales y del comportamiento debidos al uso de tabaco, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(139, 'F180', 'F180', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, intoxicación aguda', 0, 0, 0, 1),
(140, 'F181', 'F181', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, uso nocivo', 0, 0, 0, 1),
(141, 'F182', 'F182', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, síndrome de dependencia', 0, 0, 0, 1),
(142, 'F183', 'F183', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, estado de abstinencia', 0, 0, 0, 1),
(143, 'F184', 'F184', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, estado de abstinencia con delirio', 0, 0, 0, 1),
(144, 'F185', 'F185', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, trastorno psicótico', 0, 0, 0, 1),
(145, 'F186', 'F186', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, síndrome amnésico', 0, 0, 0, 1),
(146, 'F187', 'F187', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(147, 'F188', 'F188', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(148, 'F189', 'F189', 'Trastornos mentales y del comportamiento debidos al uso de disolventes volátiles, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(149, 'F190', 'F190', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, intoxicación aguda', 0, 0, 0, 1),
(150, 'F191', 'F191', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, uso nocivo', 0, 0, 0, 1),
(151, 'F192', 'F192', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, síndrome de dependencia', 0, 0, 0, 1),
(152, 'F193', 'F193', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, estado de abstinencia', 0, 0, 0, 1),
(153, 'F194', 'F194', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, estado de abstinencia con delirio', 0, 0, 0, 1),
(154, 'F195', 'F195', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, trastorno psicótico', 0, 0, 0, 1),
(155, 'F196', 'F196', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, síndrome amnésico', 0, 0, 0, 1),
(156, 'F197', 'F197', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, trastorno psicótico residual y de comienzo tardío', 0, 0, 0, 1),
(157, 'F198', 'F198', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, otros trastornos mentales y del comportamiento', 0, 0, 0, 1),
(158, 'F199', 'F199', 'Trastornos mentales y del comportamiento debidos al uso de múltiples drogas y al uso de otras sustancias psicoactivas, trastorno mental y del comportamiento, no especificado', 0, 0, 0, 1),
(159, 'F200', 'F200', 'Esquizofrenia paranoide', 0, 0, 0, 1),
(160, 'F201', 'F201', 'Esquizofrenia hebefrenica', 0, 0, 0, 1),
(161, 'F202', 'F202', 'Esquizofrenia catatónica', 0, 0, 0, 1),
(162, 'F203', 'F203', 'Esquizofrenia indiferenciada', 0, 0, 0, 1),
(163, 'F204', 'F204', 'Depresión postesquizofrenica ', 0, 0, 0, 1),
(164, 'F205', 'F205', ' Esquizofrenia residual', 0, 0, 0, 1),
(165, 'F206', 'F206', 'Esquizofrenia simple ', 0, 0, 0, 1),
(166, 'F208', 'F208', 'Otras esquizofrenias', 0, 0, 0, 1),
(167, 'F209', 'F209', 'Esquizofrenia no especificada ', 0, 0, 0, 1),
(168, 'F21X', 'F21X', 'Trastorno esquizotipico', 0, 0, 0, 1),
(169, 'F220', 'F220', 'Trastorno delirante', 0, 0, 0, 1),
(170, 'F228', 'F228', 'Otros trastornos delirantes persistentes', 0, 0, 0, 1),
(171, 'F229', 'F229', 'Trastorno delirante persistente, no especificado ', 0, 0, 0, 1),
(172, 'F230', 'F230', 'Trastorno psicótico agudo polimorfo, sin síntomas de esquizofrenia', 0, 0, 0, 1),
(173, 'F231', 'F231', 'Trastorno psicótico agudo polimorfo, con síntomas de esquizofrenia', 0, 0, 0, 1),
(174, 'F232', 'F232', 'Trastorno psicótico agudo de tipo esquizofrénico ', 0, 0, 0, 1),
(175, 'F233', 'F233', 'Otro trastorno psicótico agudo, con predominio de ideas delirantes', 0, 0, 0, 1),
(176, 'F238', 'F238', 'Otros trastornos psicóticos agudos y transitorios', 0, 0, 0, 1),
(177, 'F239', 'F239', 'Trastorno psicótico agudo y transitorio, no especificado', 0, 0, 0, 1),
(178, 'F24x', 'F24x', 'Trastorno delirante inducido', 0, 0, 0, 1),
(179, 'F250', 'F250', 'Trastorno esquizoafectivo de tipo maniaco', 0, 0, 0, 1),
(180, 'F251', 'F251', 'Trastorno esquizoafectivo de tipo depresivo', 0, 0, 0, 1),
(181, 'F252', 'F252', 'Trastorno esquizoafectivo de tipo mixto', 0, 0, 0, 1),
(182, 'F258', 'F258', 'Otros trastornos esquizoafectivos', 0, 0, 0, 1),
(183, 'F259', 'F259', 'Trastorno esquizoafectivo, no especificado', 0, 0, 0, 1),
(184, 'F28x', 'F28x', 'Otros trastornos psicóticos no orgánicos', 0, 0, 0, 1),
(185, 'F29x', 'F29x', 'Psicosis de origen no orgánico, no especificada Trastornos del humor (afectivos)', 0, 0, 0, 1),
(186, 'F300', 'F300', 'Hipomanía', 0, 0, 0, 1),
(187, 'F301', 'F301', 'Manía sin síntomas psicóticos ', 0, 0, 0, 1),
(188, 'F302', 'F302', 'Manía con síntomas psicóticos', 0, 0, 0, 1),
(189, 'F308', 'F308', 'Otros episodios maniacos', 0, 0, 0, 1),
(190, 'F309', 'F309', 'Episodio maniaco no especificado', 0, 0, 0, 1),
(191, 'F310', 'F310', 'Trastorno afectivo bipolar, episodio hipomaniaco presente', 0, 0, 0, 1),
(192, 'F311', 'F311', 'Trastorno afectivo bipolar, episodio maniaco presente sin síntomas psicóticos', 0, 0, 0, 1),
(193, 'F312', 'F312', 'Trastorno afectivo bipolar, episodio maniaco presente con síntomas psicóticos', 0, 0, 0, 1),
(194, 'F313', 'F313', 'Trastorno afectivo bipolar, episodio depresivo presente leve o moderado', 0, 0, 0, 1),
(195, 'F314', 'F314', 'Trastorno afectivo bipolar, episodio depresivo grave presente sin síntomas psicóticos', 0, 0, 0, 1),
(196, 'F315', 'F315', 'Trastorno afectivo bipolar, episodio depresivo grave presente con síntomas psicóticos', 0, 0, 0, 1),
(197, 'F316', 'F316', 'Trastorno afectivo bipolar, episodio mixto presente', 0, 0, 0, 1),
(198, 'F317', 'F317', 'Trastorno afectivo bipolar, actualmente en remisión', 0, 0, 0, 1),
(199, 'F318', 'F318', 'Otros trastornos afectivos bipolares', 0, 0, 0, 1),
(200, 'F319', 'F319', 'Trastorno afectivo bipolar, no especificado', 0, 0, 0, 1),
(201, 'F320', 'F320', 'Episodio depresivo leve', 0, 0, 0, 1),
(202, 'F321', 'F321', 'Episodio depresivo moderado', 0, 0, 0, 1),
(203, 'F322', 'F322', 'Episodio depresivo grave sin síntomas psicóticos', 0, 0, 0, 1),
(204, 'F323', 'F323', 'Episodio depresivo grave con síntomas psicóticos', 0, 0, 0, 1),
(205, 'F328', 'F328', 'Otros episodios depresivos', 0, 0, 0, 1),
(206, 'F329', 'F329', 'Episodio depresivo, no especificado', 0, 0, 0, 1),
(207, 'F330', 'F330', 'Trastorno depresivo recurrente, episodio leve presente', 0, 0, 0, 1),
(208, 'F331', 'F331', 'Trastorno depresivo recurrente, episodio moderado presente', 0, 0, 0, 1),
(209, 'F332', 'F332', 'Trastorno depresivo recurrente, episodio depresivo grave presente sin síntomas psicótico', 0, 0, 0, 1),
(210, 'F333', 'F333', 'Trastorno depresivo recurrente, episodio depresivo grave presente, con síntomas psicóticos', 0, 0, 0, 1),
(211, 'F334', 'F334', 'Trastorno depresivo recurrente actualmente en remisión', 0, 0, 0, 1),
(212, 'F338', 'F338', 'Otros trastornos depresivos recurrentes', 0, 0, 0, 1),
(213, 'F339', 'F339', 'Trastorno depresivo recurrente, no especificado', 0, 0, 0, 1),
(214, 'F340', 'F340', 'Ciclotimia', 0, 0, 0, 1),
(215, 'F341', 'F341', 'Distimia', 0, 0, 0, 1),
(216, 'F348', 'F348', 'Otros trastornos del humor [afectivos] persistentes', 0, 0, 0, 1),
(217, 'F349', 'F349', 'Trastorno persistente del humor (afectivo), no especificado', 0, 0, 0, 1),
(218, 'F380', 'F380', 'Otros trastornos del humor [afectivos], aislados', 0, 0, 0, 1),
(219, 'F381', 'F381', 'Otros trastornos del humor [afectivos], recurrentes', 0, 0, 0, 1),
(220, 'F388', 'F388', 'Otros trastornos del humor [afectivos], especificados', 0, 0, 0, 1),
(221, 'F431', 'F431', 'Trastorno de estrés postraumático', 0, 0, 0, 1),
(222, 'F39x', 'F39x', 'Trastorno del humo sin especificación', 0, 0, 0, 1),
(223, 'F400', 'F400', 'Agorafobia ', 0, 0, 0, 1),
(224, 'F401', 'F401', 'Fobias sociales', 0, 0, 0, 1),
(225, 'F402', 'F402', 'Fobias especificas (aisladas)', 0, 0, 0, 1),
(226, 'F408', 'F408', 'Otros trastornos fóbicos de ansiedad', 0, 0, 0, 1),
(227, 'F409', 'F409', 'Trastorno fóbico de ansiedad, no especificado', 0, 0, 0, 1),
(228, 'F410', 'F410', 'Trastorno de pánico [ansiedad paroxística episódica]', 0, 0, 0, 1),
(229, 'F411  ', 'F411  ', 'Trastorno de ansiedad generalizada', 0, 0, 0, 1),
(230, 'F412', 'F412', 'Trastorno mixto de ansiedad y depresión', 0, 0, 0, 1),
(231, 'F413', 'F413', 'Otros trastornos de ansiedad mixtos', 0, 0, 0, 1),
(232, 'F418', 'F418', 'Otros trastornos de ansiedad especificados', 0, 0, 0, 1),
(233, 'F419', 'F419', 'Trastorno de ansiedad, no especificado', 0, 0, 0, 1),
(234, 'F420', 'F420', 'Predominio de pensamientos o rumiaciones obsesivas', 0, 0, 0, 1),
(235, 'F421', 'F421', 'Predominio de actos compulsivos [rituales obsesivos]', 0, 0, 0, 1),
(236, 'F422', 'F422', 'Actos e ideas obsesivas mixtos', 0, 0, 0, 1),
(237, 'F428', 'F428', 'Otros trastornos obsesivo - compulsivos', 0, 0, 0, 1),
(238, 'F429', 'F429', 'Trastorno obsesivo - compulsivo, no especificado', 0, 0, 0, 1),
(239, 'F430', 'F430', 'Reacción a estrés agudo', 0, 0, 0, 1),
(240, 'F431', 'F431', ' Trastorno de estrés postraumático', 0, 0, 0, 1),
(241, 'F432', 'F432', 'Trastornos de adaptación', 0, 0, 0, 1),
(242, 'F438', 'F438', 'Otras reacciones al estrés grave', 0, 0, 0, 1),
(243, 'F439', 'F439', ' Reacción al estrés grave, no especificada', 0, 0, 0, 1),
(244, 'F440', 'F440', 'Amnesia disociativa', 0, 0, 0, 1),
(245, 'F441', 'F441', 'Fuga disociativa', 0, 0, 0, 1),
(246, 'F442', 'F442', 'Estupor disociativo', 0, 0, 0, 1),
(247, 'F443', 'F443', 'Trastornos de trance y de posesión', 0, 0, 0, 1),
(248, 'F444', 'F444', 'Trastornos disociativos del movimiento', 0, 0, 0, 1),
(249, 'F445', 'F445', 'Convulsiones disociativas', 0, 0, 0, 1),
(250, 'F446', 'F446', 'Anestesia disociativa y perdida sensorial', 0, 0, 0, 1),
(251, 'F447', 'F447', 'Trastornos disociativos mixtos [y de conversión]', 0, 0, 0, 1),
(252, 'F448', 'F448', ' Otros trastornos disociativos [de conversión]', 0, 0, 0, 1),
(253, 'F449', 'F449', 'Trastorno disociativo (de conversión), no especificado', 0, 0, 0, 1),
(254, 'F450', 'F450', 'Trastorno de somatización', 0, 0, 0, 1),
(255, 'F451', 'F451', 'Trastorno somatomorfo indiferenciado', 0, 0, 0, 1),
(256, 'F452', 'F452', 'Trastorno hipocondriaco', 0, 0, 0, 1),
(257, 'F453', 'F453', 'Disfunción autonómica somatomorfa', 0, 0, 0, 1),
(258, 'F454', 'F454', 'Trastorno de dolor persistente somatomorfo', 0, 0, 0, 1),
(259, 'F458', 'F458', 'Otros trastornos somatomorfos', 0, 0, 0, 1),
(260, 'F459', 'F459', 'Trastorno somatomorfo, no especificado', 0, 0, 0, 1),
(261, 'F480', 'F480', 'Neurastenia', 0, 0, 0, 1),
(262, 'F481', 'F481', 'Síndrome de despersonalización y desvinculación de la realidad', 0, 0, 0, 1),
(263, 'F488', 'F488', 'Otros trastornos neuróticos especificados', 0, 0, 0, 1),
(264, 'F489', 'F489', 'Trastorno neurótico, no especificado', 0, 0, 1, 1),
(265, 'F500', 'F500', 'Anorexia nerviosa', 0, 0, 2, 1),
(266, 'F501', 'F501', 'Anorexia nerviosa atípica', 0, 0, 0, 1),
(267, 'F502', 'F502', 'Bulimia nerviosa', 0, 0, 0, 1),
(268, 'F503', 'F503', 'Bulimia nerviosa atípica', 0, 0, 0, 1),
(269, 'F504', 'F504', 'Hiperfagia asociada con otras alteraciones psicológicas', 0, 0, 0, 1),
(270, 'F505', 'F505', 'Vómitos asociados con otras alteraciones psicológicas', 0, 0, 2, 1),
(271, 'F508', 'F508', 'Otros trastornos de la ingestión de alimentos', 0, 0, 2, 1),
(272, 'F509', 'F509', 'Trastorno de la ingestión de alimentos, no especificado', 0, 0, 2, 1),
(273, 'F510', 'F510', 'Insomnio no orgánico', 0, 0, 2, 1),
(274, 'F511', 'F511', 'Hipersomnio no orgánico', 0, 0, 0, 1),
(275, 'F512', 'F512', 'Trastorno no orgánico del ciclo sueño - vigilia', 0, 0, 0, 1),
(276, 'F513', 'F513', 'Sonambulismo', 0, 0, 0, 1),
(277, 'F514', 'F514', ' Terrores del sueño [terrores nocturnos]', 0, 0, 0, 1),
(278, 'F515', 'F515', 'Pesadillas', 0, 0, 0, 1),
(279, 'F518', 'F518', 'Otros trastornos no orgánicos del sueño', 0, 0, 0, 1),
(280, 'F519', 'F519', 'Trastorno no orgánico de sueño, no especificado', 0, 0, 0, 1),
(281, 'F520', 'F520', 'Falta o perdida del deseo sexual', 0, 0, 0, 1),
(282, 'F521', 'F521', 'Aversión al sexo y falta de goce sexual ', 0, 0, 0, 1),
(283, 'F522', 'F522', 'Falla de la respuesta genital', 0, 0, 0, 1),
(284, 'F523', 'F523', 'Disfunción orgásmica', 0, 0, 0, 1),
(285, 'F524', 'F524', 'Eyaculación precoz', 0, 0, 0, 1),
(286, 'F525', 'F525', 'Vaginismo no orgánico', 0, 0, 0, 1),
(287, 'F526', 'F526', 'Dispareunia no orgánica', 0, 0, 0, 1),
(288, 'F527', 'F527', 'Impulso sexual excesivo', 0, 0, 0, 1),
(289, 'F528', 'F528', 'Otras disfunciones sexuales, no ocasionadas por trastorno ni por enfermedad orgánicos', 0, 0, 0, 1),
(290, 'F529', 'F529', 'Disfunción sexual no ocasionada por trastorno ni por enfermedad orgánicos, no especifica', 0, 0, 0, 1),
(291, 'F530', 'F530', ' Trastornos mentales y del comportamiento leves, asociados con el puerperio, no clasifica', 0, 0, 0, 1),
(292, 'F531', 'F531', 'Trastornos mentales y del comportamiento graves, asociados con el puerperio, no clasificados', 0, 0, 0, 1),
(293, 'F538', 'F538', ' Otros trastornos mentales y del comportamiento asociados con el puerperio, no clasificados', 0, 0, 0, 1),
(294, 'F539', 'F539', 'Trastorno mental puerperal, no especificado', 0, 0, 0, 1),
(295, 'F54x', 'F54x', 'Factores psicológicos y del comportamiento asociados con trastornos o enfermedad', 0, 0, 0, 1),
(296, 'F55x', 'F55x', 'Abuso de sustancias que no producen dependencia', 0, 0, 0, 1),
(297, 'F59x', 'F59x', 'Síndromes del comportamiento asociados con alteraciones fisiológicas y factores', 0, 0, 0, 1),
(298, 'F600', 'F600', 'Trastorno paranoide de la personalidad', 0, 0, 0, 1),
(299, 'F601', 'F601', 'Trastorno esquizoide de la personalidad', 0, 0, 0, 1),
(300, 'F602', 'F602', 'Trastorno asocial de la personalidad', 0, 0, 0, 1),
(301, 'F603', 'F603', 'Trastorno de la personalidad emocionalmente inestable', 0, 0, 0, 1),
(302, 'F604', 'F604', 'Trastorno histriónico de la personalidad', 0, 0, 0, 1),
(303, 'F605', 'F605', 'Trastorno anancastico de la personalidad', 0, 0, 0, 1),
(304, 'F606', 'F606', 'Trastorno de la personalidad ansiosa (evasiva, elusiva)', 0, 0, 0, 1),
(305, 'F607', 'F607', 'Trastorno de la personalidad dependiente', 0, 0, 0, 1),
(306, 'F608', 'F608', 'Otros trastornos específicos de la personalidad', 0, 0, 0, 1),
(307, 'F609', 'F609', 'Trastorno de la personalidad sin especificación.', 0, 0, 0, 1),
(308, 'F61x', 'F61x', 'Trastornos mixtos y otros trastornos de la personalidad', 0, 0, 0, 1),
(309, 'F620', 'F620', 'Cambio perdurable de la personalidad después de una experiencia catastrófica', 0, 0, 0, 1),
(310, 'F621', 'F621', 'Cambio perdurable de la personalidad consecutivo a una enfermedad psiquiátrica', 0, 0, 0, 1),
(311, 'F628', 'F628', 'Otros cambios perdurables de la personalidad', 0, 0, 0, 1),
(312, 'F629', 'F629', 'Cambio perdurable de la personalidad, no especificado', 0, 0, 0, 1),
(313, 'F630', 'F630', 'Juego patológico', 0, 0, 0, 1),
(314, 'F631', 'F631', 'Piromanía', 0, 0, 0, 1),
(315, 'F632', 'F632', 'Hurto patológico [cleptomanía]', 0, 0, 0, 1),
(316, 'F633', 'F633', 'Tricotilomanía', 0, 0, 0, 1),
(317, 'F638', 'F638', 'Otros trastornos de los hábitos y de los impulsos', 0, 0, 0, 1),
(318, 'F639', 'F639', 'Trastorno de los hábitos y de los impulsos, no especificado', 0, 0, 0, 1),
(319, 'F640', 'F640', 'Transexualismo', 0, 0, 0, 1),
(320, 'F641', 'F641', 'Travestismo de rol dual', 0, 0, 0, 1),
(321, 'F642', 'F642', 'Trastorno de la identidad de género en la niñez', 0, 0, 0, 1),
(322, 'F648', 'F648', 'Otros trastornos de la identidad de genero', 0, 0, 0, 1),
(323, 'F649', 'F649', 'Trastorno de la identidad de género, no especificado', 0, 0, 0, 1),
(324, 'F650', 'F650', 'Fetichismo', 0, 0, 0, 1),
(325, 'F651', 'F651', 'Travestismo fetichista', 0, 0, 0, 1),
(326, 'F652', 'F652', 'Exhibicionismo', 0, 0, 0, 1),
(327, 'F653', 'F653', 'Voyerismo', 0, 0, 0, 1),
(328, 'F654', 'F654', 'Pedofilia', 0, 0, 0, 1),
(329, 'F655', 'F655', 'Sadomasoquismo', 0, 0, 0, 1),
(330, 'F656', 'F656', 'Trastornos múltiples de la preferencia sexual', 0, 0, 0, 1),
(331, 'F658', 'F658', 'Otros trastornos de la preferencia sexual', 0, 0, 0, 1),
(332, 'F659', 'F659', 'Trastorno de la preferencia sexual, no especificado', 0, 0, 0, 1),
(333, 'F660', 'F660', 'Trastorno de la maduración sexual', 0, 0, 0, 1),
(334, 'F661', 'F661', 'Orientación sexual egodistónica', 0, 0, 0, 1),
(335, 'F662', 'F662', ' Trastorno de la relación sexual', 0, 0, 0, 1),
(336, 'F668', 'F668', ' Otros trastornos del desarrollo psicosexual', 0, 0, 0, 1),
(337, 'F669  ', 'F669  ', 'Trastornos del desarrollo psicosexual, no especificado', 0, 0, 0, 1),
(338, 'F680', 'F680', 'Elaboración de síntomas físicos por causas psicológicas', 0, 0, 0, 1),
(339, 'F681', 'F681', 'Producción intencional o simulación de síntomas o de incapacidades, tanto físicas como', 0, 0, 0, 1),
(340, 'F688', 'F688', 'Otros trastornos especificados de la personalidad y del comportamiento en adultos Retraso mental', 0, 0, 0, 1),
(341, 'F700', 'F700', 'Retraso mental leve, deterioro del comportamiento nulo o mínimo', 0, 0, 0, 1),
(342, 'F701', 'F701', 'Retraso mental leve, deterioro del comportamiento significativo, que requiere atención', 0, 0, 0, 1),
(343, 'F708', 'F708', 'Retraso mental leve, otros deterioros del comportamiento', 0, 0, 0, 1),
(344, 'F709', 'F709', 'Retraso mental leve por deterioro del comportamiento de grado no especificado', 0, 0, 0, 1),
(345, 'F710', 'F710', 'Retraso mental moderado, deterioro del comportamiento nulo o mínimo', 0, 0, 0, 1),
(346, 'F711', 'F711', 'Retraso mental moderado, deterioro del comportamiento significativo, que requiere atención', 0, 0, 0, 1),
(347, 'F718', 'F718', 'Retraso  mental  moderado,  otros  deterioros  del comportamiento', 0, 0, 0, 1),
(348, 'F719', 'F719', 'Retraso mental moderado por deterioro del comportamiento de grado no especificado', 0, 0, 0, 1),
(349, 'F720', 'F720', 'Retraso mental grave por deterioro del comportamiento de grado no especificado', 0, 0, 0, 1),
(350, 'F721', 'F721', 'Retraso  mental  grave,  deterioro  del  comportamiento significativo, que requiere atención', 0, 0, 0, 1),
(351, 'F728', 'F728', 'Retraso  mental  grave,  otros  deterioros  del  comportamiento', 0, 0, 0, 1),
(352, 'F729', 'F729', 'Retraso  mental  grave,  deterioro  del  comportamiento de grado no especificado', 0, 0, 0, 1),
(353, 'F730', 'F730', 'Retraso mental profundo, deterioro del comportamiento nulo o mínimo', 0, 0, 0, 1),
(354, 'F731', 'F731', 'Retraso mental profundo, deterioro del comportamiento significativo, que requiere atención', 0, 0, 0, 1),
(355, 'F738', 'F738', 'Retraso   mental   profundo,   otros   deterioros del comportamiento', 0, 0, 0, 1),
(356, 'F739', 'F739', 'Retraso mental profundo, deterioro del comportamiento de grado no especificado', 0, 0, 0, 1),
(357, 'F780', 'F780', 'Otros tipos de retraso mental, deterioro del comportamiento nulo o mínimo', 0, 0, 0, 1),
(358, 'F781', 'F781', 'Otros tipos de retraso mental, deterioro del Comportamiento significativo, que requiere', 0, 0, 0, 1),
(359, 'F788', 'F788', 'Otros tipos de retraso mental, otros deterioros delComportamiento', 0, 0, 0, 1),
(360, 'F789', 'F789', 'Otros tipos de retraso mental, deterioro del Comportamiento de grado no especificado', 0, 0, 0, 1),
(361, 'F800', 'F800', 'Trastorno especifico de la pronunciación', 0, 0, 0, 1),
(362, 'F801', 'F801', 'Trastorno del lenguaje expresivo', 0, 0, 0, 1),
(363, 'F802', 'F802', 'Trastorno de la recepción del lenguaje', 0, 0, 0, 1),
(364, 'F803', 'F803', 'Afasia adquirida con epilepsia [landau - kleffner]', 0, 0, 0, 1),
(365, 'F808', 'F808', 'Otros trastornos del desarrollo del habla y del lenguaje', 0, 0, 0, 1),
(366, 'F809', 'F809', 'Trastornos específicos del desarrollo del habla y del lenguaje sin especificación.', 0, 0, 0, 1),
(367, 'F810', 'F810', 'Trastorno especifico de la lectura', 0, 0, 0, 1),
(368, 'F811', 'F811', 'Trastorno específico del deletreo [ortografía]', 0, 0, 0, 1),
(369, 'F812', 'F812', 'Trastorno especifico de las habilidades aritméticas', 0, 0, 0, 1),
(370, 'F813', 'F813', 'Trastorno mixto de las habilidades escolares', 0, 0, 0, 1),
(371, 'F818', 'F818', 'Otros trastornos del desarrollo de las habilidades Escolares', 0, 0, 0, 1),
(372, 'F819', 'F819', ' Trastornos específicos del desarrollo del aprendizaje Escolar sin especificación.', 0, 0, 0, 1),
(373, 'F82x', 'F82x', 'Trastorno específico del desarrollo psicomotor', 0, 0, 0, 1),
(374, 'F83x', 'F83x', 'Trastornos específicos mixtos del desarrollo', 0, 0, 0, 1),
(375, 'F840', 'F840', 'Autismo en la niñez', 0, 0, 0, 1),
(376, 'F841', 'F841', 'Autismo atípico', 0, 0, 0, 1),
(377, 'F842', 'F842', 'Síndrome de Rett', 0, 0, 0, 1),
(378, 'F843', 'F843', 'Otro trastorno desintegrativo de la niñez', 0, 0, 0, 1),
(379, 'F844', 'F844', 'Trastorno hiperactivo asociado con retraso mental y Movimientos estereotipados', 0, 0, 0, 1),
(380, 'F845', 'F845', 'Síndrome de asperger', 0, 0, 0, 1),
(381, 'F848', 'F848', 'Otros trastornos generalizados del desarrollo', 0, 0, 0, 1),
(382, 'F849', 'F849', 'Trastorno generalizado del desarrollo, no especificado', 0, 0, 0, 1),
(383, 'F88x', 'F88x', 'Otros trastornos del desarrollo psicológico', 0, 0, 0, 1),
(384, 'F900', 'F900', 'Perturbación de la actividad y de la atención', 0, 0, 0, 1),
(385, 'F901', 'F901', 'Trastorno hipercinético de la conducta', 0, 0, 0, 1),
(386, 'F908', 'F908', 'Otros trastornos hipercinéticos', 0, 0, 0, 1),
(387, 'F909', 'F909', 'Trastorno hipercinético, no especificado', 0, 0, 0, 1),
(388, 'F910', 'F910', 'Trastorno de la conducta limitado al contexto familiar', 0, 0, 0, 1),
(389, 'F911', 'F911', 'Trastorno de la conducta insociable', 0, 0, 0, 1),
(390, 'F912', 'F912', 'Trastorno de la conducta sociable', 0, 0, 0, 1),
(391, 'F913', 'F913', 'Trastorno opositor desafiante', 0, 0, 0, 1),
(392, 'F918', 'F918', 'Otros trastornos de la conducta', 0, 0, 0, 1),
(393, 'F919', 'F919', 'Trastorno de la conducta, no especificado', 0, 0, 0, 1),
(394, 'F920', 'F920', 'Trastorno depresivo de la conducta', 0, 0, 0, 1),
(395, 'F928', 'F928', 'Otros  trastornos  mixtos  de  la  conducta  y  de  las emociones', 0, 0, 0, 1),
(396, 'F929', 'F929', 'Trastorno mixto de la conducta y de las emociones, no especificado', 0, 0, 0, 1),
(397, 'F930', 'F930', 'Trastorno de ansiedad de separación en la niñez', 0, 0, 0, 1),
(398, 'F931', 'F931', 'Trastorno de ansiedad fóbica en la niñez', 0, 0, 0, 1),
(399, 'F932', 'F932', 'Trastorno de ansiedad social en la niñez', 0, 0, 0, 1),
(400, 'F933', 'F933', 'Trastorno de rivalidad entre hermanos', 0, 0, 0, 1),
(401, 'F938', 'F938', 'Otros trastornos emocionales en la niñez', 0, 0, 0, 1),
(402, 'F939', 'F939', 'Trastorno de las emociones de comienzo habitual en la Infancia, no especificado', 0, 0, 0, 1),
(403, 'F940', 'F940', 'Mutismo electivo', 0, 0, 0, 1),
(404, 'F941', 'F941', 'Trastorno de vinculación reactiva en la niñez', 0, 0, 0, 1),
(405, 'F942', 'F942', 'Trastorno de vinculación desinhibida en la niñez', 0, 0, 0, 1),
(406, 'F948', 'F948', 'Otros trastornos del comportamiento social en la niñez', 0, 0, 0, 1),
(407, 'F949', 'F949', 'Trastorno del comportamiento social en la niñez, no Especificado', 0, 0, 0, 1),
(408, 'F950', 'F950', ' Trastorno por tic transitorio', 0, 0, 0, 1),
(409, 'F951', 'F951', 'Trastorno por tic motor o vocal crónico', 0, 0, 0, 1),
(410, 'F952', 'F952', ' Trastorno  por  tics  motores  y  vocales  múltiples combinados [de la tourette]', 0, 0, 0, 1),
(411, 'F958', 'F958', 'Otros trastornos por tics', 0, 0, 0, 1),
(412, 'F959', 'F959', 'Trastorno por tic, no especificado', 0, 0, 0, 1),
(413, 'F980', 'F980', 'Enuresis no orgánica', 0, 0, 0, 1),
(414, 'F981', 'F981', 'Encopresis no orgánica', 0, 0, 0, 1),
(415, 'F982', 'F982', 'Trastorno de la ingestión alimentaria en la infancia y la niñez', 0, 0, 0, 1),
(416, 'F983', 'F983', 'Pica en la infancia y la niñez', 0, 0, 0, 1),
(417, 'F984', 'F984', 'Trastornos de los movimientos estereotipados', 0, 0, 0, 1),
(418, 'F985', 'F985', 'Tartamudez [espasmofemia]', 0, 0, 0, 1),
(419, 'F986', 'F986', 'Farfulleo', 0, 0, 0, 1),
(420, 'F988', 'F988', 'Otros   trastornos   emocionales   y   del   comportamiento que aparecen habitualmente en la niñez', 0, 0, 0, 1),
(421, 'F989', 'F989', 'Trastornos  no  especificados,  emocionales  y  del comportamiento, que aparecen habitualmente', 0, 0, 0, 1),
(422, 'X60', 'X60', 'Envenenamiento   autoinfligido   intencionalmente por y exposición a analgésicos no narcóticos, anti- piréticos y antirreumáticos', 0, 0, 0, 1),
(423, 'X61', 'X61', 'Envenenamiento   autoinfligido   intencionalmente por  y  Exposición  a  drogas  antiepilépticas,  sedan- tes, hipnóticas, anti parkinsonianas y psicotrópicas no clasificadas en otra parte', 0, 0, 0, 1),
(424, 'X62', 'X62', 'Envenenamiento   autoinfligido   intencionalmente por,  y  exposición  a  narcóticos  y  psicodislepticos [alucinógenos], no clasificados en otra parte', 0, 0, 0, 1),
(425, 'X63', 'X63', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición a otras drogas que actúan sobre el sistema nervioso autónomo', 0, 0, 0, 1),
(426, 'X64', 'X64', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición a otras drogas, medicamentos y sustancias biológicas, y los no especificado', 0, 0, 0, 1),
(427, 'X65', 'X65', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición al alcohol', 0, 0, 0, 1),
(428, 'X66', 'X66', 'Envenenamiento   autoinfligido   intencionalmente por y exposición a disolventes orgánicos e hidro- carburos halogenados y sus vapores', 0, 0, 0, 1),
(429, 'X67', 'X67', ' Envenenamiento   autoinfligido   intencionalmente por, y exposición a otros gases y vapores', 0, 0, 0, 1),
(430, 'X68', 'X68', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición a plaguicidas', 0, 0, 0, 1),
(431, 'X70', 'X70', 'Lesión autoinfligida intencionalmente por ahorca- miento, estrangulamiento o sofocación', 0, 0, 0, 1),
(432, 'X71', 'X71', 'Lesión  autoinfligida  intencionalmente  por  ahoga- miento y sumersión', 0, 0, 0, 1),
(433, 'X72', 'X72', 'Lesión autoinfligida intencionalmente por disparo de arma corta', 0, 0, 0, 1),
(434, 'X73', 'X73', 'Lesión autoinfligida intencionalmente por disparo de rifle, escopeta y arma larga', 0, 0, 0, 1),
(435, 'X74', 'X74', 'Lesión autoinfligida intencionalmente por disparo de otras armas de fuego, y las no especificadas', 0, 0, 0, 1),
(436, 'X75', 'X75', 'Lesión autoinfligida intencionalmente por material explosivo', 0, 0, 0, 1),
(437, 'X76', 'X76', 'Lesión  autoinfligida  intencionalmente  por  humo, fuego y llamas', 0, 0, 0, 1),
(438, 'X77', 'X77', 'Lesión  autoinfligida  intencionalmente  por  vapor de agua, vapores y objetos calientes', 0, 0, 0, 1),
(439, 'X78', 'X78', 'Lesión  autoinfligida  intencionalmente  por  objeto cortante', 0, 0, 0, 1),
(440, 'X79', 'X79', 'Lesión  autoinfligida  intencionalmente  por  objeto romo o sin filo', 0, 0, 0, 1),
(441, 'X80', 'X80', 'Lesión   autoinfligida   intencionalmente   al   saltar desde un lugar elevado', 0, 0, 0, 1),
(442, 'X81', 'X81', 'Lesión autoinfligida intencionalmente por arrojarse o colocarse delante de objeto en movimiento', 0, 0, 0, 1),
(443, 'X82', 'X82', 'Lesión autoinfligida intencionalmente por colisión de vehículo de motor', 0, 0, 0, 1),
(444, 'X83', 'X83', 'Lesión  autoinfligida  intencionalmente  por  otros medios especificados', 0, 0, 0, 1),
(445, 'T740', 'T740', 'Negligencia o abandono', 0, 0, 0, 1),
(446, 'T741', 'T741', 'Abuso físico', 0, 0, 0, 1),
(447, 'T742', 'T742', 'Abuso sexual', 0, 0, 0, 1),
(448, 'T743', 'T743', 'Abuso psicológico', 0, 0, 0, 1),
(449, 'T748', 'T748', 'Otros síndromes de maltrato (formas mixtas)', 0, 0, 0, 1),
(450, 'T749', 'T749', 'Sindrome del maltrato no especificado', 0, 0, 0, 1),
(451, 'Y040', 'Y040', 'Agresión con fuerza corporal en vivienda', 0, 0, 0, 1),
(452, 'Y041', 'Y041', 'Agresión  con  fuerza  corporal  en  institución  residencial', 0, 0, 0, 1),
(453, 'Y042', 'Y042', 'Agresión  con  fuerza  corporal  en  escuelas,  otras instituciones y áreas administrativas publicas', 0, 0, 0, 1),
(454, 'Y048', 'Y048', 'Agresión con fuerza corporal en otro lugar especificado', 0, 0, 0, 1),
(455, 'Y049', 'Y049', 'Agresión con fuerza corporal en lugar no especificado', 0, 0, 0, 1),
(456, 'Y050', 'Y050', 'Agresión sexual con fuerza corporal en vivienda', 0, 0, 0, 1),
(457, 'Y051', 'Y051', 'Agresión sexual con fuerza corporal en institución residencial', 0, 0, 0, 1),
(458, 'Y052', 'Y052', 'Agresión  sexual  con  fuerza  corporal  en  escuelas, otras instituciones y áreas administrativas públicas', 0, 0, 0, 1),
(459, 'Y058', 'Y058', 'Agresión sexual con fuerza corporal en otro lugar especificado.', 0, 0, 0, 1),
(460, 'Y059', 'Y059', 'Agresión sexual con fuerza corporal en lugar no especificado', 0, 0, 0, 1),
(461, 'Y060', 'Y060', 'Negligencia y abandono por esposo o pareja ', 0, 0, 0, 1),
(462, 'Y061', 'Y061', 'Negligencia y abandono por padre o madre ', 0, 0, 0, 1),
(463, 'Y062', 'Y062', 'Negligencia y abandono por conocido o amigo', 0, 0, 0, 1),
(464, 'Y068', 'Y068', 'Negligencia y abandono por otra persona especificada', 0, 0, 0, 1),
(465, 'Y070', 'Y070', 'Síndrome de maltrato por esposo o pareja', 0, 0, 0, 1),
(466, 'Y071', 'Y071', 'Otros síndromes de maltrato por padre o madre', 0, 0, 0, 1),
(467, 'Y072', 'Y072', 'Otros síndromes de maltrato por conocido o amigo (bullying).', 0, 0, 0, 1),
(468, 'Y073', 'Y073', 'Otros síndromes de maltrato por autoridades oficiales', 0, 0, 0, 1),
(469, 'Y078', 'Y078', 'Otros síndromes de maltrato por otra persona especificada.', 0, 0, 0, 1),
(470, 'Y079', 'Y079', 'Otros síndromes de maltrato por persona no especificada', 0, 0, 0, 1),
(471, 'Y870', 'Y870', 'Secuelas de lesiones autoinfligidas ', 0, 0, 0, 1),
(472, 'Y871', 'Y871', 'Secuelas de agresiones.', 0, 0, 0, 1),
(473, 'R456', 'R456', 'Problemas relacionados con violencia', 0, 0, 0, 1),
(474, 'Z046', 'Z046', 'Examen psiquiátrico general solicitado por una autoridad', 0, 0, 0, 1),
(475, 'Z133', 'Z133', 'Examen de pesquisa especial para trastornos mentales y del comportamiento.', 0, 0, 0, 1),
(476, 'Z600', 'Z600', 'Problemas relacionados con el ajuste a las transiciones del ciclo vital', 0, 0, 0, 1),
(477, 'Z601', 'Z601', 'Problemas relacionados con situación familiar atípica.', 0, 0, 0, 1),
(478, 'Z602', 'Z602', 'Problemas relacionados con persona que vive sola', 0, 0, 0, 1),
(479, 'Z603', 'Z603', 'Problemas relacionados con la adaptación cultural', 0, 0, 0, 1),
(480, 'Z604', 'Z604', 'Problemas relacionado con la exclusión y rechazo', 0, 0, 0, 1),
(481, 'Z605', 'Z605', 'Problemas  relacionados  con  la  discriminación  y persecución percibidas', 0, 0, 0, 1),
(482, 'Z608', 'Z608', ' Otros problemas relacionados con el ambiente social', 0, 0, 0, 1),
(483, 'Z609', 'Z609', 'Problema no especificado relacionado con el ambiente social.', 0, 0, 0, 1),
(484, 'Z610', 'Z610', 'Problemas relacionados con la pérdida de relación afectiva en la infancia', 0, 0, 0, 1),
(485, 'Z611', 'Z611', 'Problemas relacionados con el alejamiento del hogar en la infancia.', 0, 0, 0, 1),
(486, 'Z612', 'Z612', 'Problemas  relacionados  con  alteración  en  el  patrón de la relación familiar en la infancia', 0, 0, 0, 1),
(487, 'Z613', 'Z613', 'Problemas relacionados con eventos que llevaron a la perdida de la autoestima en la infancia', 0, 0, 0, 1),
(488, 'Z614      ', 'Z614      ', 'Problemas  relacionados  con  el  abuso  sexual  del niño por persona dentro del grupo de apoyo', 0, 0, 0, 1),
(489, 'Z615', 'Z615', 'Problemas  relacionados  con  el  abuso  sexual  del niño por persona ajena al grupo de apoyo', 0, 0, 0, 1),
(490, 'Z616', 'Z616', 'Problemas  relacionados  con  el  abuso  físico  del niño.', 0, 0, 0, 1),
(491, 'Z617', 'Z617', 'Problemas relacionados con experiencias personales atemorizantes en la infancia', 0, 0, 0, 1),
(492, 'Z618', 'Z618', 'Problemas relacionados con otras experiencias negativas en la infancia.', 0, 0, 0, 1),
(493, 'Z619', 'Z619', ' Problemas relacionados con experiencia negativa no especificada en la infancia', 0, 0, 0, 1),
(494, 'Z620', 'Z620', 'Problemas  relacionados  con  la  supervisión  o  el control inadecuado de los padres', 0, 0, 0, 1),
(495, 'Z621', 'Z621', 'Problemas relacionados con la sobreprotección de los padres', 0, 0, 0, 1),
(496, 'Z622', 'Z622', 'Problemas relacionados con la crianza en instituSecuelas de lesiones autoinfligidas intencionalmente, agresiones y eventos de intención no determinada', 0, 0, 0, 1);
INSERT INTO `psyem_diagnosticos` (`idDiagnostico`, `cieDiagnostico`, `cieSinPto`, `detaDiagnostico`, `edadMinimo`, `edadMaxima`, `sexoDx`, `dxEstado`) VALUES
(497, 'Y870', 'Y870', 'Secuelas de lesiones autoinfligidas', 0, 0, 0, 1),
(498, 'Y871', 'Y871', 'Secuelas de agresiones.', 0, 0, 0, 1),
(500, 'Z046', 'Z046', ' Examen psiquiátrico general solicitado por una autoridad', 0, 0, 0, 1),
(501, 'Z133', 'Z133', 'Examen de pesquisa especial para trastornos mentales y del comportamiento.', 0, 0, 0, 1),
(502, 'Z600', 'Z600', 'Problemas relacionados con el ajuste a las transiciones del ciclo vital', 0, 0, 0, 1),
(503, 'Z601', 'Z601', 'Problemas relacionados con situación familiar atípica.', 0, 0, 0, 1),
(504, 'Z602', 'Z602', 'Problemas relacionados con persona que vive sola', 0, 0, 0, 1),
(505, 'Z603', 'Z603', 'Problemas relacionados con la adaptación cultural', 0, 0, 0, 1),
(506, 'Z604', 'Z604', 'Problemas relacionado con la exclusión y rechazo', 0, 0, 0, 1),
(507, 'Z605', 'Z605', 'Problemas  relacionados  con  la  discriminación  y persecución percibidas', 0, 0, 0, 1),
(508, 'Z608', 'Z608', 'Otros problemas relacionados con el ambiente social', 0, 0, 0, 1),
(509, 'Z609', 'Z609', 'Problema no especificado relacionado con el ambiente social.', 0, 0, 0, 1),
(510, 'Z610', 'Z610', 'Problemas relacionados con la pérdida de relación afectiva en la infancia', 0, 0, 0, 1),
(511, 'Z611', 'Z611', 'Problemas relacionados con el alejamiento del hogar en la infancia.', 0, 0, 0, 1),
(512, 'Z612', 'Z612', 'Problemas  relacionados  con  alteración  en  el  patrón de la relación familiar en la infancia', 0, 0, 0, 1),
(513, 'Z613', 'Z613', 'Problemas relacionados con eventos que llevaron a la perdida de la autoestima en la infancia', 0, 0, 0, 1),
(514, 'Z614', 'Z614', 'Problemas  relacionados  con  el  abuso  sexual  del niño por persona dentro del grupo de apoyo', 0, 0, 0, 1),
(515, 'Z615', 'Z615', 'Problemas  relacionados  con  el  abuso  sexual  del niño por persona ajena al grupo de apoyo', 0, 0, 0, 1),
(516, 'Z616', 'Z616', 'Problemas  relacionados  con  el  abuso  físico  del niño.', 0, 0, 0, 1),
(517, 'Z617', 'Z617', 'Problemas relacionados con experiencias personales atemorizantes en la infancia', 0, 0, 0, 1),
(518, 'Z618', 'Z618', 'Problemas relacionados con otras experiencias negativas en la infancia.', 0, 0, 0, 1),
(519, 'Z619', 'Z619', 'Problemas relacionados con experiencia negativa no especificada en la infancia', 0, 0, 0, 1),
(520, 'Z620', 'Z620', 'Problemas  relacionados  con  la  supervisión  o  el control inadecuado de los padres', 0, 0, 0, 1),
(521, 'Z621', 'Z621', 'Problemas relacionados con la sobreprotección de los padres', 0, 0, 0, 1),
(522, 'Z622', 'Z622', 'Problemas relacionados con la crianza en instituciones.', 0, 0, 0, 1),
(523, 'Z623', 'Z623', 'Problemas relacionados con hostilidad y reprobación al niño', 0, 0, 0, 1),
(524, 'Z624', 'Z624', 'Abandono emocional del niño', 0, 0, 0, 1),
(525, 'Z625', 'Z625', 'Otros problemas relacionados con negligencia en la crianza del niño', 0, 0, 0, 1),
(526, 'Z626', 'Z626', 'Problemas relacionados con presiones inapropiadas de los padres y otras anormalidades en la calidad de la crianza', 0, 0, 0, 1),
(527, 'Z628', 'Z628', 'Otros problemas especificados y relacionados con la crianza del niño', 0, 0, 0, 1),
(528, 'Z629', 'Z629', 'Otros  problemas  relacionados  con  la  crianza  del niño (sistemas de creencias)', 0, 0, 0, 1),
(529, 'Z630', 'Z630', 'Problemas relación pareja esposos', 0, 0, 0, 1),
(530, 'Z631', 'Z631', 'Problemas en la relación con los padres políticos familiares', 0, 0, 0, 1),
(531, 'Z632', 'Z632', 'Problemas en relación con el soporte socio-familiar', 0, 0, 0, 1),
(532, 'Z633', 'Z633', 'Ausencia de miembro de la familia', 0, 0, 0, 1),
(533, 'Z634', 'Z634', 'Desaparición o muerte de miembro de la familia', 0, 0, 0, 1),
(534, 'Z635', 'Z635', ' Problemas relacionados con la ruptura familiar por separación o divorcio', 0, 0, 0, 1),
(535, 'Z636', 'Z636', 'Familiar dependiente necesitado de cuidado en el hogar', 0, 0, 0, 1),
(536, 'Z637', 'Z637', 'Problemas  relacionados  con  otros  hechos  estresantes que afectan a la familia y la casa', 0, 0, 0, 1),
(537, 'Z638', 'Z638', 'Otros problemas especificados relacionados con el grupo primario de apoyo', 0, 0, 0, 1),
(538, 'Z639', 'Z639', 'Problema no especificado relacionados con el grupo primario de apoyo', 0, 0, 0, 1),
(539, 'Z640', 'Z640', 'Problemas relacionados con embarazo no deseado', 0, 0, 0, 1),
(540, 'Z641', 'Z641', 'Problemas relacionados con la multiparidad.', 0, 0, 0, 1),
(541, 'Z642', 'Z642', 'Problemas relacionados con la solicitud o aceptación de intervenciones físicas, nutricionales y químicas, conociendo su riesgo y peligro', 0, 0, 0, 1),
(542, 'Z643', 'Z643', 'Problemas relacionados con la solicitud o aceptación de intervenciones psicológicas o de la conducta, conociendo su riesgo y peligro', 0, 0, 0, 1),
(543, 'Z644', 'Z644', 'Problemas  relacionados  con  el  desacuerdo  con consejeros', 0, 0, 0, 1),
(544, 'Z650', 'Z650', 'Problemas  relacionados  con  culpabilidad  en  procedimientos civiles o criminales sin prisión', 0, 0, 0, 1),
(545, 'Z651', 'Z651', 'Problemas relacionados con prisión y otro encarcelamiento', 0, 0, 0, 1),
(546, 'Z652', 'Z652', 'Problemas relacionados con la liberación de la prisión', 0, 0, 0, 1),
(547, 'Z653', 'Z653', 'Problemas  relacionados  con  otras  circunstancias', 0, 0, 0, 1),
(548, 'Z654', 'Z654', 'Víctima de crimen o terrorismo, incluyendo tortura', 0, 0, 0, 1),
(549, 'Z655', 'Z655', 'Exposición a desastre, guerra u otras hostilidades', 0, 0, 0, 1),
(550, '99402.09', '99402.09', 'Consejería  de  Prevención  de  riesgos  en  salud mental', 0, 0, 0, 1),
(551, '99215', '99215', 'Consulta  ambulatoria  especializada  para  la  evaluación y manejo de un paciente continuador', 0, 0, 0, 1),
(552, '99207', '99207', 'Consulta  de salud mental', 0, 0, 0, 1),
(553, '99207.04', '99207.04', 'Psicoeducación al paciente', 0, 0, 0, 1),
(554, '99207.01', '99207.01', 'Intervención individual de salud mental', 0, 0, 0, 1),
(555, '99366', '99366', 'Reunión del o los médicos tratantes con el equipo interdisciplinario de profesionales de la salud(participación de profesional no médicos de la salud), frente a frente con el paciente y/o familia.La reunión tendrá una duración de 30 minutos o más (Plan Individualizado formulado)', 0, 0, 0, 1),
(556, '99285.01', '99285.01', 'Manejo inicial consulta en emergencia problema de alta severidad y pone en riesgo inmediato la vida  o  deterioro  severo  funcional.  (prioridad I)(Intervención en crisis)', 0, 0, 0, 1),
(557, '96100.02', '96100.02', 'Consejería y Orientación psicológica', 0, 0, 0, 1),
(558, '99402.17', '99402.17', 'Consejería de actividad física', 0, 0, 0, 1),
(559, '90861', '90861', 'Terapia de relajación', 0, 0, 0, 1),
(560, '99401.13', '99401.13', 'Consejería en Estilos de Vida saludable', 0, 0, 0, 1),
(561, '96150', '96150', 'Evaluación de salud y comportamiento (ejemplo: entrevista  clínica  enfocada  en  la  salud  observación  de  la  conducta  monitoreo  psicofisiológico cuestionarios orientados a la salud) por cada 15 minutos de contacto cara a cara con el paciente evaluación inicial (Entrevista motivacional)', 0, 0, 0, 1),
(562, '90834', '90834', 'Psicoterapia,  45  minutos  con  el  paciente  y/o miembro de la familia', 0, 0, 0, 1),
(563, '90806', '90806', 'Psicoterapia individual, de soporte, psicodinámi- ca  o  psicoeducativa  o  de  afronte  cognitivo  con- ductual  de  45-60  minutos  de  duración,  cara  a cara realizado por psicólogo', 0, 0, 0, 1),
(564, '90860', '90860', 'Psicoterapia cognitivo conductual', 0, 0, 0, 1),
(565, 'C2111.01', 'C2111.01', 'Psicoeducación  a  la  familia  (Intervención  familiar)', 0, 0, 0, 1),
(566, '96100.01', '96100.01', 'Sesión de psicoterapia de familia (realizado por el psicólogo)', 0, 0, 0, 1),
(567, '90847', '90847', 'Psicoterapia de la familia (psicoterapia conjunta) (con el paciente presente)', 0, 0, 0, 1),
(568, '99207.06', '99207.06', 'Atención en salud mental a mujeres que son vícti- mas de violencia por su pareja o expareja (incluye aplicación de la ficha de valoración de riesgos)', 0, 0, 0, 1),
(569, '99207.02', '99207.02', 'Intervención grupal en salud mental', 0, 0, 0, 1),
(570, 'C0012', 'C0012', 'Sesión de Grupo de ayuda mutua', 0, 0, 0, 1),
(571, '90857', '90857', 'Psicoterapia interactiva de grupo', 0, 0, 0, 1),
(572, '90872', '90872', 'Taller de habilidades sociales', 0, 0, 0, 1),
(573, '99401.15', '99401.15', 'Consejería en habilidades sociales ', 0, 0, 0, 1),
(574, '99401.19', '99401.19', 'Consejería para el autocuidado', 0, 0, 0, 1),
(575, '99401.25', '99401.25', 'Consejería en pautas de crianza buen trato comunicación y cuidados adecuados', 0, 0, 0, 1),
(576, '99401.29', '99401.29', 'Consejería en convivencia saludable en pareja', 0, 0, 0, 1),
(577, '99402.14', '99402.14', 'Consejería en promoción del buen trato y salud mental', 0, 0, 2, 1),
(578, 'C0002', 'C0002', 'Reunión con institución educativa', 0, 0, 2, 1),
(579, 'C0003', 'C0003', 'Reunión de comunidad', 0, 0, 2, 1),
(580, 'C0005', 'C0005', 'Taller para institución educativa', 0, 0, 2, 1),
(581, 'C0006', 'C0006', 'Taller comunitario', 0, 0, 2, 1),
(582, 'C0007', 'C0007', 'Taller para la Familia', 0, 0, 2, 1),
(583, 'C0011', 'C0011', 'Visitas familiares integrales', 0, 0, 2, 1),
(584, 'C0071', 'C0071', 'Análisis de la situación de salud. Identificación de necesidades de salud de la población con partici- pación de la comunidad', 0, 0, 2, 1),
(585, 'C1043', 'C1043', 'Coordinaciones con actores de sectores e institu- ciones en la comunidad (Sesión de movilización de redes de apoyo)', 0, 0, 2, 1),
(586, 'C2111', 'C2111', 'Taller psicoeducativo grupal', 0, 0, 2, 1),
(587, 'C7001', 'C7001', 'Reunión de Monitoreo', 0, 0, 2, 1),
(588, 'C7003', 'C7003', 'Reunión de Evaluación', 0, 0, 0, 1),
(589, '97009', '97009', ' Terapia del lenguaje /sesión', 0, 0, 0, 1),
(590, '96100', '96100', 'Consulta psicológica', 0, 0, 2, 1),
(591, '99499.01', '99499.01', 'Teleconsulta en línea', 0, 0, 2, 1),
(592, '99499.08', '99499.08', 'Teleorientación síncrona', 0, 0, 2, 1),
(593, '99499.10', '99499.10', 'Telemonitoreo', 0, 0, 0, 1),
(594, '99499.11', '99499.11', 'Teleinterconsulta síncrona', 0, 0, 0, 1),
(595, 'APP 093', 'APP 093', 'Actividad con institución educativa', 0, 0, 0, 1),
(596, 'APP 108', 'APP 108', 'Actividad en comunidad', 0, 0, 0, 1),
(597, 'APP 136', 'APP 136', ' Actividad con Familia', 0, 0, 0, 1),
(598, 'APP 138', 'APP 138', 'Actividad con Agentes Comunitarios de Salud', 0, 0, 0, 1),
(599, 'APP 144', 'APP 144', 'Actividad con Docentes', 0, 0, 0, 1),
(600, 'APP 150', 'APP 150', 'Actividad con autoridades y líderes comunales', 0, 0, 0, 1),
(601, 'APP 151', 'APP 151', 'Actividad con Mujeres', 0, 0, 0, 1),
(602, 'APP 166', 'APP 166', 'Actividades con Líderes Escolares', 0, 0, 0, 1),
(603, 'Z379   ', 'Z379   ', 'Producto del parto no especificado', 0, 0, 2, 1),
(604, 'Z390   ', 'Z390   ', 'Atención y examen inmediatamente después del parto', 0, 0, 2, 1),
(605, 'Z391   ', 'Z391   ', 'Atención y examen de madre en período de lactancia', 0, 0, 2, 1),
(606, 'Z392   ', 'Z392   ', 'Seguimiento postparto, de rutina', 0, 0, 2, 1),
(607, 'Z437  ', 'Z437  ', 'Atención de vagina artificial', 0, 0, 2, 1),
(608, 'Z640  ', 'Z640  ', 'Problemas relacionados con embarazo no deseado', 0, 0, 2, 1),
(609, 'Z875  ', 'Z875  ', 'Historia personal de complicaciones del embarazo, del parto y del puerperio', 0, 0, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_estadoatencion`
--

CREATE TABLE `psyem_estadoatencion` (
  `idEstadoAte` int(11) NOT NULL,
  `detaEstadoAte` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_estadoatencion`
--

INSERT INTO `psyem_estadoatencion` (`idEstadoAte`, `detaEstadoAte`) VALUES
(1, 'REGISTRADA'),
(2, 'ANULADA'),
(3, 'FINALIZADA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_estadopaciente`
--

CREATE TABLE `psyem_estadopaciente` (
  `idEstadoPacAtencion` int(11) NOT NULL,
  `detaEstadoPacAtencion` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_estadopaciente`
--

INSERT INTO `psyem_estadopaciente` (`idEstadoPacAtencion`, `detaEstadoPacAtencion`) VALUES
(1, 'HOSPITALIZADO'),
(2, 'ALTA'),
(3, 'FALLECIDO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_estadoprof`
--

CREATE TABLE `psyem_estadoprof` (
  `idEstadoProf` int(11) NOT NULL,
  `detaEstadoProf` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_estadoprof`
--

INSERT INTO `psyem_estadoprof` (`idEstadoProf`, `detaEstadoProf`) VALUES
(1, 'ALTA'),
(2, 'BAJA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_estadosu`
--

CREATE TABLE `psyem_estadosu` (
  `idEstado` int(11) NOT NULL,
  `detalleEstadoU` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_estadosu`
--

INSERT INTO `psyem_estadosu` (`idEstado`, `detalleEstadoU`) VALUES
(1, 'HABILITADO'),
(2, 'INHABILITADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_estatusseguimiento`
--

CREATE TABLE `psyem_estatusseguimiento` (
  `idStatusSeg` int(11) NOT NULL,
  `detaStatusSeg` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_estatusseguimiento`
--

INSERT INTO `psyem_estatusseguimiento` (`idStatusSeg`, `detaStatusSeg`) VALUES
(1, 'REGISTRADO'),
(2, 'ANULADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_famatencion`
--

CREATE TABLE `psyem_famatencion` (
  `idFamiliar` int(11) NOT NULL,
  `fechaRegistro` date DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idAtencion` int(11) DEFAULT NULL,
  `idParentesco` int(11) DEFAULT NULL,
  `idTipSexo` int(11) DEFAULT NULL,
  `tipdocFamiliar` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `ndocFamiliar` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `nombApFamiliar` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `edadFamiliar` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `telcelFamiliar` varchar(12) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_famatencion`
--

INSERT INTO `psyem_famatencion` (`idFamiliar`, `fechaRegistro`, `idUsuario`, `idAtencion`, `idParentesco`, `idTipSexo`, `tipdocFamiliar`, `ndocFamiliar`, `nombApFamiliar`, `edadFamiliar`, `telcelFamiliar`) VALUES
(1, '2022-04-06', 10, 2, 6, 1, 'DNI', '77478995', 'OLGER IVAN CASTRO PALACIOS', '25', '914907409'),
(2, '2022-04-06', 10, 1, 4, 2, 'DNI', '10402790', 'PALERMA VELAZCO CASTRO DE PALACIOS', '72', '914907415');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_motivoseguimiento`
--

CREATE TABLE `psyem_motivoseguimiento` (
  `idMotSeguimiento` int(11) NOT NULL,
  `detaMotivoSef` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_motivoseguimiento`
--

INSERT INTO `psyem_motivoseguimiento` (`idMotSeguimiento`, `detaMotivoSef`) VALUES
(1, 'INFORMACION'),
(2, 'ORIENTACION'),
(3, 'DESPEDIDA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_parentescofam`
--

CREATE TABLE `psyem_parentescofam` (
  `idParentesco` int(11) NOT NULL,
  `detaParentesco` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_parentescofam`
--

INSERT INTO `psyem_parentescofam` (`idParentesco`, `detaParentesco`) VALUES
(1, 'PADRE'),
(2, 'MADRE'),
(3, 'HIJO(A)'),
(4, 'ABUELO(A)'),
(5, 'NIETO(A)'),
(6, 'HERMANO(A)'),
(7, 'TIO(A)'),
(8, 'SOBRINO(A)'),
(9, 'ESPOSO(A)'),
(10, 'PRIMO(A)'),
(11, 'YERNO'),
(12, 'NUERA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_perfiles`
--

CREATE TABLE `psyem_perfiles` (
  `idPerfil` int(11) NOT NULL,
  `detallePerfil` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_perfiles`
--

INSERT INTO `psyem_perfiles` (`idPerfil`, `detallePerfil`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'JEFE'),
(3, 'PSICOLOGO'),
(4, 'MONITOREO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_profesionales`
--

CREATE TABLE `psyem_profesionales` (
  `idProfesional` int(11) NOT NULL,
  `idEstado` int(11) DEFAULT '1',
  `idCondicion` int(11) DEFAULT NULL,
  `dniProfesional` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `cpspProfesional` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  `apellidosProfesional` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `nombresProfesional` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_profesionales`
--

INSERT INTO `psyem_profesionales` (`idProfesional`, `idEstado`, `idCondicion`, `dniProfesional`, `cpspProfesional`, `apellidosProfesional`, `nombresProfesional`) VALUES
(1, 1, 1, '06958470', '12936', 'CORDOVA CACHAY', 'MATILDE'),
(2, 1, 1, '09851044', '4398', 'FLORES CASTILLO', 'IRMA'),
(3, 1, 1, '09512967', '6287', 'MORI ZUBIATE', 'ZONIA EMPERATRIZ'),
(4, 1, 1, '09479664', '32629', 'PABLO JARAMILLO', 'NORMA BEATRIZ'),
(5, 1, 1, '10725238', '10444', 'RAPRI SOLANO', 'EDSON'),
(6, 1, 1, '06781469', '7045', 'SALDAÑA CHAVEZ', 'KELLY'),
(7, 1, 1, '06123251', '10097', 'SANCHEZ AQUINO', 'NORMA NELIDA'),
(8, 1, 2, '10288615', '25775', 'TRUJILLO CASTILLO', 'MIRIAM ROCIO'),
(9, 1, 1, '07178930', '34522', 'VELASQUEZ REYES', 'MARIA ANGELA'),
(10, 1, 2, '46624029', '21470', 'ZAVALETA LOPEZ', 'DARNELLY JAHAIRA'),
(11, 1, 2, '41768412', '53738', 'FERRARI SANTANDER', 'ALEXIS ALBERTO'),
(12, 1, 2, '06790718', '046609', 'CASTILLO USCAMAYTA DE USCAMAYTA', 'JANET MICHELL'),
(13, 1, 2, '45833915', '27254', 'SALAS ATENCIO', 'INDIRA MARGARETH');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_seguimiento`
--

CREATE TABLE `psyem_seguimiento` (
  `idSeguimiento` int(11) NOT NULL,
  `fRegistrSeg` date NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idAtencionPac` int(11) NOT NULL,
  `idProfesional` int(11) NOT NULL,
  `idTipoSeguimiento` int(11) NOT NULL,
  `idMotSeguimiento` int(11) NOT NULL,
  `idDiag1Seg` int(11) NOT NULL,
  `idDiag2Seg` int(11) NOT NULL DEFAULT '0',
  `comunFamSeg` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `idFamAtSeg` int(11) NOT NULL DEFAULT '0',
  `idDiag1SegFam` int(11) NOT NULL DEFAULT '0',
  `idDiag2SegFam` int(11) NOT NULL DEFAULT '0',
  `obsSeg` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `idStatusSeg` int(11) NOT NULL DEFAULT '1',
  `registroSistema` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_seguimiento`
--

INSERT INTO `psyem_seguimiento` (`idSeguimiento`, `fRegistrSeg`, `idUsuario`, `idAtencionPac`, `idProfesional`, `idTipoSeguimiento`, `idMotSeguimiento`, `idDiag1Seg`, `idDiag2Seg`, `comunFamSeg`, `idFamAtSeg`, `idDiag1SegFam`, `idDiag2SegFam`, `obsSeg`, `idStatusSeg`, `registroSistema`) VALUES
(1, '2022-04-06', 10, 2, 8, 2, 1, 434, 433, 'SI', 1, 8, 20, 'XD', 1, '2022-04-06 18:25:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_tiposeguimiento`
--

CREATE TABLE `psyem_tiposeguimiento` (
  `idTipoSeguimiento` int(11) NOT NULL,
  `detaTipSeguimiento` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_tiposeguimiento`
--

INSERT INTO `psyem_tiposeguimiento` (`idTipoSeguimiento`, `detaTipSeguimiento`) VALUES
(1, 'FAM. FALLECIDO'),
(2, 'HOSPITALIZADOS'),
(3, 'PAC. ALTA MEDICA'),
(4, 'PERSONAL DE SALUD');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_tipsexo`
--

CREATE TABLE `psyem_tipsexo` (
  `idTipSexo` int(11) NOT NULL,
  `detaTipSexo` varchar(50) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_tipsexo`
--

INSERT INTO `psyem_tipsexo` (`idTipSexo`, `detaTipSexo`) VALUES
(1, 'MASCULINO'),
(2, 'FEMENINO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psyem_usuarios`
--

CREATE TABLE `psyem_usuarios` (
  `idUsuario` int(11) NOT NULL,
  `idPerfil` int(11) NOT NULL,
  `idEstado` int(11) NOT NULL DEFAULT '2',
  `dniUsuario` varchar(20) COLLATE utf8_bin NOT NULL,
  `apellidosUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `nombresUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `cuentaUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `correoUsuario` varchar(50) COLLATE utf8_bin NOT NULL,
  `claveUsuario` varchar(100) COLLATE utf8_bin NOT NULL,
  `intentosUsuario` int(11) DEFAULT '0',
  `fechaAlta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `profileUsuario` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_usuarios`
--

INSERT INTO `psyem_usuarios` (`idUsuario`, `idPerfil`, `idEstado`, `dniUsuario`, `apellidosUsuario`, `nombresUsuario`, `cuentaUsuario`, `correoUsuario`, `claveUsuario`, `intentosUsuario`, `fechaAlta`, `profileUsuario`) VALUES
(1, 1, 1, '77478995', 'CASTRO PALACIOS', 'OLGER IVAN', 'ocastrop', 'ocastrop@hnseb.gob.pe', '$2a$07$usesomesillystringforeM8r9BbmlBZ9ovuveDN0W0YiCUcwiGOm', 2, '2021-06-01 15:34:46', ''),
(2, 1, 1, '40195996', 'ROSAS SANCHEZ', 'MONICA NOHEMI', 'rosasmn', 'rosasmn@hnseb.gob.pe', '$2a$07$usesomesillystringforeoRNSqF5ebwOJ.HFIcVhNJ65bww3hpNi', 0, '2021-06-01 17:24:22', NULL),
(3, 3, 1, '06958470', 'CORDOVA CACHAY', 'MATILDE', 'mcordovac', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforehgypeI5DRix.IHkznBBhY252VmxlIWG', 0, '2021-06-01 17:24:53', NULL),
(4, 3, 1, '09851044', 'FLORES CASTILLO', 'IRMA', 'ifloresc', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeBMhRE0LIoruOmyFsWj3UQXjUsLK9jbW', 0, '2021-06-01 17:25:46', NULL),
(5, 2, 1, '09512967', 'MORI ZUBIATE', 'ZONIA EMPERATRIZ', 'zmoriz', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringfore5.XZEFBrtJ9.qXuqzFwfY43rZRYXidu', 1, '2021-06-01 17:26:04', NULL),
(6, 3, 1, '09479664', 'PABLO JARAMILLO', 'NORMA BEATRIZ', 'npabloj', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforejafDnGpmQvC62Zn3P5JoKKyWKV4zarq', 0, '2021-06-01 17:26:33', NULL),
(7, 3, 2, '10725238', 'RAPRI SOLANO', 'EDSON', 'erapris', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforelIPayZrI4jRNiLPXnEEGudMyDr2fDY2', 0, '2021-06-01 17:26:54', NULL),
(8, 3, 1, '06781469', 'SALDAÑA CHAVEZ', 'KELLY', 'ksaldañac', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeZpoQa.04HI7d0l.s3qvV9RXq.FhroYq', 0, '2021-06-01 17:27:17', NULL),
(9, 3, 1, '06123251', 'SANCHEZ AQUINO', 'NORMA NELIDA', 'nsancheza', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeYSJzm0jn4URCyGiJ4fg.5wGT.VCsJVa', 0, '2021-06-01 17:27:36', NULL),
(10, 3, 1, '10288615', 'TRUJILLO CASTILLO', 'MIRIAM ROCIO', 'mtrujilloc', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforet.nDPdp7Y6XclmteD.MneoaNId0Wvje', 1, '2021-06-01 17:28:01', NULL),
(11, 3, 1, '07178930', 'VELASQUEZ REYES', 'MARIA ANGELA', 'mvelasquezr', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforedE1OzELbl6PFujI.BSco1Er6IX.Uv6C', 0, '2021-06-01 17:28:22', NULL),
(12, 3, 1, '46624029', 'ZAVALETA LOPEZ', 'DARNELLY JAHAIRA', 'dzavaletal', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeBQPDD/GSseqnB6cro9X9nOHtqDKTXLS', 0, '2021-06-01 17:29:00', NULL),
(13, 1, 1, '09966920', 'SERNAQUE QUINTANA', 'JAVIER OCTAVIO', 'jsernaque', 'jsernaque@hnseb.gob.pe', '$2a$07$usesomesillystringforeAR0AYDLcMUwZJGc02Ta3T98Pn6LH7pi', 0, '2021-07-06 19:35:33', NULL),
(14, 4, 1, '41768412', 'FERRARI SANTANDER', 'ALEXIS ALBERTO', 'aferraris', 'dr.alex.ferrari.s@gmail.com', '$2a$07$usesomesillystringforeSXtcfjIjdiDI0eqt9OsmF.T.sEtEwhy', 1, '2021-08-23 19:46:27', NULL),
(15, 4, 1, '06790718', 'CASTILLO USCAMAYTA DE USCAMAYTA', 'JANET MICHELL', 'jcastillou', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringfore4RW/Ia3rLfbPLbdjrPhqpsjfJ65iXpa', 0, '2021-09-15 17:50:26', NULL),
(16, 3, 1, '45833915', 'SALAS ATENCIO', 'INDIRA MARGARETH', 'isalasa', 'dpsicologia@hnseb.gob.pe', '$2a$07$usesomesillystringforeSJCI5jxBOnt6PgFlYouo/P95cCeFkFu', 2, '2022-01-19 14:01:35', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zpsyem_aud_atenciones`
--

CREATE TABLE `zpsyem_aud_atenciones` (
  `idAuditAte` int(11) NOT NULL,
  `idAtencion` int(11) NOT NULL,
  `fechaRegAudi` date NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `AccRealizada` text COLLATE utf8_bin NOT NULL,
  `cuentaAnterior` text COLLATE utf8_bin,
  `EpisodioAnterior` text COLLATE utf8_bin,
  `cuentaNueva` text COLLATE utf8_bin,
  `EpisodioNuevo` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zpsyem_aud_familiares`
--

CREATE TABLE `zpsyem_aud_familiares` (
  `idAudiFam` int(11) NOT NULL,
  `idFamiliar` int(11) NOT NULL,
  `fecRegAudi` date NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `AccRealizada` text COLLATE utf8_bin NOT NULL,
  `idAtencionAnt` int(11) NOT NULL,
  `ndocAnt` varchar(20) COLLATE utf8_bin NOT NULL,
  `idAtencionNueva` int(11) DEFAULT NULL,
  `ndocNuevo` varchar(20) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `psyem_atencion`
--
ALTER TABLE `psyem_atencion`
  ADD PRIMARY KEY (`idAtencion`),
  ADD KEY `fk_estadoAte` (`idEstadoAte`),
  ADD KEY `fk_estadoPac` (`idEstadoPacAtencion`);

--
-- Indices de la tabla `psyem_condicionprof`
--
ALTER TABLE `psyem_condicionprof`
  ADD PRIMARY KEY (`idCondicion`);

--
-- Indices de la tabla `psyem_diagnosticos`
--
ALTER TABLE `psyem_diagnosticos`
  ADD PRIMARY KEY (`idDiagnostico`);

--
-- Indices de la tabla `psyem_estadoatencion`
--
ALTER TABLE `psyem_estadoatencion`
  ADD PRIMARY KEY (`idEstadoAte`);

--
-- Indices de la tabla `psyem_estadopaciente`
--
ALTER TABLE `psyem_estadopaciente`
  ADD PRIMARY KEY (`idEstadoPacAtencion`);

--
-- Indices de la tabla `psyem_estadoprof`
--
ALTER TABLE `psyem_estadoprof`
  ADD PRIMARY KEY (`idEstadoProf`);

--
-- Indices de la tabla `psyem_estadosu`
--
ALTER TABLE `psyem_estadosu`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `psyem_estatusseguimiento`
--
ALTER TABLE `psyem_estatusseguimiento`
  ADD PRIMARY KEY (`idStatusSeg`);

--
-- Indices de la tabla `psyem_famatencion`
--
ALTER TABLE `psyem_famatencion`
  ADD PRIMARY KEY (`idFamiliar`),
  ADD KEY `fk_atencion` (`idAtencion`),
  ADD KEY `fk_parentesco` (`idParentesco`),
  ADD KEY `fk_sexo` (`idTipSexo`);

--
-- Indices de la tabla `psyem_motivoseguimiento`
--
ALTER TABLE `psyem_motivoseguimiento`
  ADD PRIMARY KEY (`idMotSeguimiento`);

--
-- Indices de la tabla `psyem_parentescofam`
--
ALTER TABLE `psyem_parentescofam`
  ADD PRIMARY KEY (`idParentesco`);

--
-- Indices de la tabla `psyem_perfiles`
--
ALTER TABLE `psyem_perfiles`
  ADD PRIMARY KEY (`idPerfil`);

--
-- Indices de la tabla `psyem_profesionales`
--
ALTER TABLE `psyem_profesionales`
  ADD PRIMARY KEY (`idProfesional`),
  ADD KEY `fk_condicion` (`idCondicion`),
  ADD KEY `fk_estadoProf` (`idEstado`);

--
-- Indices de la tabla `psyem_seguimiento`
--
ALTER TABLE `psyem_seguimiento`
  ADD PRIMARY KEY (`idSeguimiento`),
  ADD KEY `fk_mot` (`idMotSeguimiento`),
  ADD KEY `fk_prof` (`idProfesional`),
  ADD KEY `fk_tipseg` (`idTipoSeguimiento`),
  ADD KEY `fk_user` (`idUsuario`),
  ADD KEY `fk_ate` (`idAtencionPac`);

--
-- Indices de la tabla `psyem_tiposeguimiento`
--
ALTER TABLE `psyem_tiposeguimiento`
  ADD PRIMARY KEY (`idTipoSeguimiento`);

--
-- Indices de la tabla `psyem_tipsexo`
--
ALTER TABLE `psyem_tipsexo`
  ADD PRIMARY KEY (`idTipSexo`);

--
-- Indices de la tabla `psyem_usuarios`
--
ALTER TABLE `psyem_usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_perfil` (`idPerfil`),
  ADD KEY `fk_estadoUsuario` (`idEstado`);

--
-- Indices de la tabla `zpsyem_aud_atenciones`
--
ALTER TABLE `zpsyem_aud_atenciones`
  ADD PRIMARY KEY (`idAuditAte`);

--
-- Indices de la tabla `zpsyem_aud_familiares`
--
ALTER TABLE `zpsyem_aud_familiares`
  ADD PRIMARY KEY (`idAudiFam`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `psyem_atencion`
--
ALTER TABLE `psyem_atencion`
  MODIFY `idAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_condicionprof`
--
ALTER TABLE `psyem_condicionprof`
  MODIFY `idCondicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_diagnosticos`
--
ALTER TABLE `psyem_diagnosticos`
  MODIFY `idDiagnostico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=610;

--
-- AUTO_INCREMENT de la tabla `psyem_estadoatencion`
--
ALTER TABLE `psyem_estadoatencion`
  MODIFY `idEstadoAte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `psyem_estadopaciente`
--
ALTER TABLE `psyem_estadopaciente`
  MODIFY `idEstadoPacAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `psyem_estadoprof`
--
ALTER TABLE `psyem_estadoprof`
  MODIFY `idEstadoProf` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_estadosu`
--
ALTER TABLE `psyem_estadosu`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_estatusseguimiento`
--
ALTER TABLE `psyem_estatusseguimiento`
  MODIFY `idStatusSeg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_famatencion`
--
ALTER TABLE `psyem_famatencion`
  MODIFY `idFamiliar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_motivoseguimiento`
--
ALTER TABLE `psyem_motivoseguimiento`
  MODIFY `idMotSeguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `psyem_parentescofam`
--
ALTER TABLE `psyem_parentescofam`
  MODIFY `idParentesco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `psyem_perfiles`
--
ALTER TABLE `psyem_perfiles`
  MODIFY `idPerfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `psyem_profesionales`
--
ALTER TABLE `psyem_profesionales`
  MODIFY `idProfesional` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `psyem_seguimiento`
--
ALTER TABLE `psyem_seguimiento`
  MODIFY `idSeguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `psyem_tiposeguimiento`
--
ALTER TABLE `psyem_tiposeguimiento`
  MODIFY `idTipoSeguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `psyem_tipsexo`
--
ALTER TABLE `psyem_tipsexo`
  MODIFY `idTipSexo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_usuarios`
--
ALTER TABLE `psyem_usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `zpsyem_aud_atenciones`
--
ALTER TABLE `zpsyem_aud_atenciones`
  MODIFY `idAuditAte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `zpsyem_aud_familiares`
--
ALTER TABLE `zpsyem_aud_familiares`
  MODIFY `idAudiFam` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `psyem_atencion`
--
ALTER TABLE `psyem_atencion`
  ADD CONSTRAINT `fk_estadoAte` FOREIGN KEY (`idEstadoAte`) REFERENCES `psyem_estadoatencion` (`idEstadoAte`),
  ADD CONSTRAINT `fk_estadoPac` FOREIGN KEY (`idEstadoPacAtencion`) REFERENCES `psyem_estadopaciente` (`idEstadoPacAtencion`);

--
-- Filtros para la tabla `psyem_famatencion`
--
ALTER TABLE `psyem_famatencion`
  ADD CONSTRAINT `fk_atencion` FOREIGN KEY (`idAtencion`) REFERENCES `psyem_atencion` (`idAtencion`),
  ADD CONSTRAINT `fk_parentesco` FOREIGN KEY (`idParentesco`) REFERENCES `psyem_parentescofam` (`idParentesco`),
  ADD CONSTRAINT `fk_sexo` FOREIGN KEY (`idTipSexo`) REFERENCES `psyem_tipsexo` (`idTipSexo`);

--
-- Filtros para la tabla `psyem_profesionales`
--
ALTER TABLE `psyem_profesionales`
  ADD CONSTRAINT `fk_condicion` FOREIGN KEY (`idCondicion`) REFERENCES `psyem_condicionprof` (`idCondicion`),
  ADD CONSTRAINT `fk_estadoProf` FOREIGN KEY (`idEstado`) REFERENCES `psyem_estadoprof` (`idEstadoProf`);

--
-- Filtros para la tabla `psyem_seguimiento`
--
ALTER TABLE `psyem_seguimiento`
  ADD CONSTRAINT `fk_ate` FOREIGN KEY (`idAtencionPac`) REFERENCES `psyem_atencion` (`idAtencion`),
  ADD CONSTRAINT `fk_mot` FOREIGN KEY (`idMotSeguimiento`) REFERENCES `psyem_motivoseguimiento` (`idMotSeguimiento`),
  ADD CONSTRAINT `fk_prof` FOREIGN KEY (`idProfesional`) REFERENCES `psyem_profesionales` (`idProfesional`),
  ADD CONSTRAINT `fk_tipseg` FOREIGN KEY (`idTipoSeguimiento`) REFERENCES `psyem_tiposeguimiento` (`idTipoSeguimiento`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`idUsuario`) REFERENCES `psyem_usuarios` (`idUsuario`);

--
-- Filtros para la tabla `psyem_usuarios`
--
ALTER TABLE `psyem_usuarios`
  ADD CONSTRAINT `fk_estadoUsuario` FOREIGN KEY (`idEstado`) REFERENCES `psyem_estadosu` (`idEstado`),
  ADD CONSTRAINT `fk_perfil` FOREIGN KEY (`idPerfil`) REFERENCES `psyem_perfiles` (`idPerfil`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
