-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-06-2022 a las 15:16:58
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Buscar_Diagnosticos` (IN `_termino` TEXT, IN `_opcion` INT, IN `_dxDif` INT, IN `_dxDif2` INT, IN `_dxDif3` INT)   BEGIN
	IF
		( _opcion = 1 ) THEN-- Búsqueda de 1er Dx
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
			OR psyem_diagnosticos.detaDiagnostico LIKE CONCAT( '%', LOWER( _termino ), '%' ));-- Búsqueda de 3 Dx
		
		ELSEIF ( _opcion = 3 ) THEN
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
				OR psyem_diagnosticos.detaDiagnostico LIKE CONCAT( '%', LOWER( _termino ), '%' )) 
			AND psyem_diagnosticos.idDiagnostico != _dxDif 
			AND psyem_diagnosticos.idDiagnostico != _dxDif2;-- Búsqueda de 4 Dx
		
		ELSEIF ( _opcion = 4 ) THEN-- Búsqueda de 2 Dx
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
				OR psyem_diagnosticos.detaDiagnostico LIKE CONCAT( '%', LOWER( _termino ), '%' )) 
			AND psyem_diagnosticos.idDiagnostico != _dxDif 
			AND psyem_diagnosticos.idDiagnostico != _dxDif2 
			AND psyem_diagnosticos.idDiagnostico != _dxDif3;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `EDITAR_SEGUIMIENTO` (IN `_idSeguimiento` INT(11), IN `_fRegistrSeg` DATE, IN `_idAtencionPac` INT(11), IN `_idProfesional` INT(11), IN `_idTipoSeguimiento` INT(11), IN `_idMotSeguimiento` INT(11), IN `_idDiag1Seg` INT(11), IN `_idDiag2Seg` INT(11), IN `_idDiag3Seg` INT(11), IN `_idDiag4Seg` INT(11), IN `_comunFamSeg` VARCHAR(10), IN `_idFamAtSeg` INT(11), IN `_idDiag1SegFam` INT(11), IN `_idDiag2SegFam` INT(11), IN `_idDiag3SegFam` INT(11), IN `_idDiag4SegFam` INT(11), IN `_obsSeg` VARCHAR(200))   UPDATE psyem_seguimiento 
SET fRegistrSeg = _fRegistrSeg,
idAtencionPac = _idAtencionPac,
idProfesional = _idProfesional,
idTipoSeguimiento = _idTipoSeguimiento,
idMotSeguimiento = _idMotSeguimiento,
idDiag1Seg = _idDiag1Seg,
idDiag2Seg = _idDiag2Seg,
idDiag3Seg = _idDiag3Seg,
idDiag4Seg = _idDiag4Seg,
comunFamSeg = _comunFamSeg,
idFamAtSeg = _idFamAtSeg,
idDiag1SegFam = _idDiag1SegFam,
idDiag2SegFam = _idDiag2SegFam,
idDiag3SegFam = _idDiag3SegFam,
idDiag4SegFam = _idDiag4SegFam,
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_SEGUIMIENTO` (IN `_fRegistrSeg` DATE, IN `_idUsuario` INT(11), IN `_idAtencionPac` INT(11), IN `_idProfesional` INT(11), IN `_idTipoSeguimiento` INT(11), IN `_idMotSeguimiento` INT(11), IN `_idDiag1Seg` INT(11), IN `_idDiag2Seg` INT(11), IN `_idDiag3Seg` INT(11), IN `_idDiag4Seg` INT(11), IN `_comunFamSeg` VARCHAR(10), IN `_idFamAtSeg` INT(11), IN `_idDiag1SegFam` INT(11), IN `_idDiag2SegFam` INT(11), IN `_idDiag3SegFam` INT(11), IN `_idDiag4SegFam` INT(11), IN `_obsSeg` VARCHAR(200))   INSERT INTO psyem_seguimiento (
	fRegistrSeg,
	idUsuario,
	idAtencionPac,
	idProfesional,
	idTipoSeguimiento,
	idMotSeguimiento,
	idDiag1Seg,
	idDiag2Seg,
	idDiag3Seg,
	idDiag4Seg,
	comunFamSeg,
	idFamAtSeg,
	idDiag1SegFam,
	idDiag2SegFam,
	idDiag3SegFam,
	idDiag4SegFam,
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
		_idDiag3Seg,
		_idDiag4Seg,
		_comunFamSeg,
		_idFamAtSeg,
		_idDiag1SegFam,
		_idDiag2SegFam,
		_idDiag3SegFam,
	_idDiag4SegFam,
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
(1, 'ACP-2022-000001', '2022-04-15', '2005006', '1998965', '1357655', 2, '1980-09-02', 'DNI', '40636531', 'SANTOYO', 'ALVARADO', 'EMILI DAYANA', '2022-02-19', 'GINECOOBSTETRICIA - EMERGENCIA', '', 'CARABAYLLO', '42', 2, 'PARTICULAR', 10, 1),
(2, 'ACP-2022-000002', '2022-04-27', '2045145', '2039115', '287158', 1, '1952-07-05', 'DNI', '25587864', 'LOPEZ', 'RENGIFO', 'JAIME TOMAS', '2022-04-25', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '70', 1, 'PARTICULAR', 12, 1),
(3, 'ACP-2022-000003', '2022-04-27', '2046902', '2040872', '360370', 1, '1943-05-08', 'DNI', '09030807', 'VILLANUEVA', 'MIRANDA', 'LAURA MARLENE', '2022-04-26', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '79', 2, 'PARTICULAR', 12, 1),
(4, 'ACP-2022-000004', '2022-04-27', '2043944', '2037914', '158775', 1, '1948-03-06', 'DNI', '05393146', 'PEREZ', 'RAMIREZ', 'ALIPIO ', '2022-04-22', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '74', 1, 'PARTICULAR', 12, 1),
(5, 'ACP-2022-000005', '2022-04-27', '2045140', '2039110', '195407', 1, '1980-12-08', 'DNI', '42523303', 'BANDA', 'LEON', 'HILDA ', '2022-04-27', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '42', 2, 'PARTICULAR', 12, 1),
(6, 'ACP-2022-000006', '2022-04-27', '2045981', '2039951', '1358624', 1, '1960-06-10', 'DNI', '09492038', 'PERALTA', 'JARA', 'RONALD ', '2022-04-26', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '62', 1, 'PARTICULAR', 12, 1),
(7, 'ACP-2022-000007', '2022-04-27', '2045514', '2039484', '193275', 1, '1978-09-26', 'DNI', '40132096', 'CAVERO', 'ATAO', 'REBECA ', '2022-04-25', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '44', 2, 'PARTICULAR', 12, 1),
(8, 'ACP-2022-000008', '2022-04-27', '2038239', '2032208', '1213864', 1, '1981-04-08', 'DNI', '44497048', 'GARCIA', 'PAJUELO', 'JUAN CARLOS', '2022-04-15', 'CORONAVIRUS - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '41', 1, 'PARTICULAR', 12, 1),
(9, 'ACP-2022-000009', '2022-04-27', '2037498', '2031467', '1362661', 1, '1998-02-16', 'DNI', '75346676', 'CERACIO', 'PACAYA', 'JORDAN JAIR', '2022-04-13', 'MEDICINA TOPICO - EMERGENCIA', '', 'LOS OLIVOS', '24', 1, 'PARTICULAR', 12, 1),
(10, 'ACP-2022-000010', '2022-04-27', '2044660', '2038630', '1363858', 1, '1965-11-24', 'DNI', '06866137', 'ALVARADO', 'ROJAS', 'MARCOS MANUEL', '2022-04-24', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '57', 1, 'PARTICULAR', 12, 1),
(11, 'ACP-2022-000011', '2022-04-27', '2044718', '2038688', '596509', 1, '1967-10-27', 'DNI', '08665751', 'TARAZONA', 'CASTILLO', 'ROBERTO ANTONIO', '2022-04-24', 'CIRUGIA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '55', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(12, 'ACP-2022-000012', '2022-05-02', '2047814', '2041784', '1363034', 1, '1940-01-24', 'DNI', '07745439', 'MOORE', 'SANCHEZ', 'MARIA SANTOS', '2022-04-27', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '82', 2, 'PARTICULAR', 12, 1),
(13, 'ACP-2022-000013', '2022-05-02', '2048482', '2042452', '1229095', 1, '1946-05-05', 'DNI', '07596364', 'ROJAS', 'IZAGUIRRE', 'ZOILA ROSA', '2022-04-29', 'NEUMO TBC - HOSPITALIZACIÓN ', '', 'COMAS', '76', 2, 'PARTICULAR', 12, 1),
(14, 'ACP-2022-000014', '2022-05-02', '2048484', '2042454', '1278396', 1, '1984-10-23', 'DNI', '42730815', 'PERALES', 'LIÑAN', 'JACKELYNE GIOVANNA', '2022-05-01', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '38', 2, 'PARTICULAR', 12, 1),
(15, 'ACP-2022-000015', '2022-05-02', '2047790', '2041760', '993682', 1, '1941-06-23', 'DNI', '06914858', 'ASTOCONDOR', 'RAMOS', 'AGRIPINA ERLINDA', '2022-04-29', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '81', 2, 'PARTICULAR', 12, 1),
(16, 'ACP-2022-000016', '2022-05-02', '2047636', '2041606', '1357451', 1, '1985-05-30', 'DNI', '43092662', 'PARIONA', 'DOMINGUEZ', 'JUAN CARLOS', '2022-04-27', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '37', 1, 'PARTICULAR', 12, 1),
(17, 'ACP-2022-000017', '2022-05-02', '2050351', '2044321', '1364607', 1, '2003-08-27', 'DNI', '70703780', 'CADILLO', 'ZELADA', 'ISABELLA MORAYMA', '2022-05-02', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '19', 2, 'PARTICULAR', 12, 1),
(18, 'ACP-2022-000018', '2022-05-02', '2050152', '2044122', '1006730', 1, '1981-05-19', 'DNI', '41983517', 'VALDEZ', 'MALPARTIDA', 'KARINA ', '2022-05-01', 'MEDICINA TOPICO - EMERGENCIA', '', 'CANTA', '41', 2, 'PARTICULAR', 12, 1),
(19, 'ACP-2022-000019', '2022-05-02', '2046550', '2040520', '923811', 1, '1961-05-14', 'DNI', '06866746', 'GALINDO', 'ALBITES', 'WILBER FREDDY', '2022-05-02', 'MEDICINA VARONES - HOSPITALIZACIÓN ', '', 'COMAS', '61', 1, 'PARTICULAR', 12, 1),
(20, 'ACP-2022-000020', '2022-05-02', '2048601', '2042571', '234411', 1, '1958-01-20', 'DNI', '06941095', 'RIOS', 'MELGAREJO', 'FELICITAS EUGENIA', '2022-04-28', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '64', 2, 'PARTICULAR', 12, 1),
(21, 'ACP-2022-000021', '2022-05-02', '2050347', '2044317', '911864', 1, '1981-09-22', 'DNI', '41005066', 'COTERA', 'RODRIGUEZ', 'MARIANELA GIOVANA', '2022-05-02', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '41', 2, 'PARTICULAR', 12, 1),
(22, 'ACP-2022-000022', '2022-05-02', '2050234', '2044204', '1304127', 1, '1972-03-11', 'DNI', '23093554', 'MARTINEZ', 'PEDROSO', 'FELICITAS ', '2022-05-01', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '50', 2, 'PARTICULAR', 12, 1),
(23, 'ACP-2022-000023', '2022-05-02', '2050788', '2044758', '1347167', 1, '1955-12-06', 'DNI', '08502751', 'ORDOÑEZ', 'GASCO', 'WALTER ALFREDO', '2022-05-02', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '67', 1, 'PARTICULAR', 12, 1),
(24, 'ACP-2022-000024', '2022-05-02', '2049168', '2043138', '43174', 1, '1973-02-08', 'DNI', '10388743', 'JIMENEZ', 'FAJARDO', 'ROBERT JOHN', '2022-04-29', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '49', 1, 'PARTICULAR', 12, 1),
(25, 'ACP-2022-000025', '2022-05-04', '2051073', '2045043', '1364685', 1, '1942-10-29', 'DNI', '19961217', 'LIMAYLLA', 'LEON', 'ABRAHAM RAUL', '2022-05-02', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '80', 1, 'PARTICULAR', 12, 1),
(26, 'ACP-2022-000026', '2022-05-04', '2051666', '2045636', '1144030', 1, '1989-10-07', 'DNI', '45964563', 'PEREZ', 'ALBARRACIN', 'KATHERINE MILDRED', '2022-05-03', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '33', 2, 'PARTICULAR', 12, 1),
(27, 'ACP-2022-000027', '2022-05-04', '2051144', '2045114', '1363547', 1, '1981-12-07', 'DNI', '41308964', 'CORDOVA', 'RAMIREZ', 'MARIELA ', '2022-05-04', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'COMAS', '41', 2, 'PARTICULAR', 12, 1),
(28, 'ACP-2022-000028', '2022-05-04', '2051132', '2045102', '732520', 1, '1936-12-14', 'DNI', '07407669', 'LAURO', 'HUAMANI', 'POMPEYO ', '2022-05-02', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '86', 1, 'PARTICULAR', 12, 1),
(29, 'ACP-2022-000029', '2022-05-04', '2050242', '2044212', '1363195', 1, '2001-01-23', 'DNI', '62909898', 'RAMOS', 'SAUCEDO', 'MARCO ANTONIO', '2022-05-01', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '21', 1, 'PARTICULAR', 12, 1),
(30, 'ACP-2022-000030', '2022-05-04', '2050790', '2044760', '1310970', 1, '1957-05-27', 'DNI', '06831601', 'SALINAS', 'DE LA CRUZ', 'FERNANDO ', '2022-05-02', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '65', 1, 'PARTICULAR', 12, 1),
(31, 'ACP-2022-000031', '2022-05-04', '2051105', '2045075', '1364690', 1, '1954-05-15', 'DNI', '09227097', 'USHIÑAHUA', 'SOLSOL', 'CONSUELO ', '2022-05-04', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '68', 2, 'PARTICULAR', 12, 1),
(32, 'ACP-2022-000032', '2022-05-04', '2051382', '2045352', '87893', 1, '1938-07-09', 'DNI', '06826923', 'VILLACORTA', 'REGALADO', 'JULIO ', '2022-05-03', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '84', 1, 'PARTICULAR', 12, 1),
(33, 'ACP-2022-000033', '2022-05-04', '2052464', '2046434', '1224287', 1, '1999-05-17', 'DNI', '74174502', 'CRUZ', 'BUSTAMANTE', 'ANGIE CONSUELO', '2022-05-04', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '23', 2, 'PARTICULAR', 12, 1),
(34, 'ACP-2022-000034', '2022-05-06', '2053433', '2047402', '499906', 1, '1998-03-20', 'DNI', '74188858', 'MORENO', 'VILCAPOMA', 'BRIGITTE ESMERALDA', '2022-05-06', 'SOP CIRUGIA - HOSPITALIZACIÓN ', '', 'COMAS', '24', 2, 'PARTICULAR', 12, 1),
(35, 'ACP-2022-000035', '2022-05-06', '2053362', '2047331', '1364977', 1, '1962-10-03', 'DNI', '06873704', 'DELGADO', 'ANDIA', 'JUAN DONICIO', '2022-05-05', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '60', 1, 'PARTICULAR', 12, 1),
(36, 'ACP-2022-000036', '2022-05-06', '2053166', '2047135', '1364957', 1, '1964-08-10', 'CE', '005479126', 'CIACCIA', 'SALAZAR', 'SILVIA MARISOL', '2022-05-05', 'CORONAVIRUS - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '58', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(37, 'ACP-2022-000037', '2022-05-06', '2052686', '2046656', '1364890', 1, '1967-09-29', 'DNI', '09479800', 'CALDAS', 'VALVERDE', 'MIGUEL ', '2022-05-04', 'CIRUGIA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '55', 1, 'PARTICULAR', 12, 1),
(38, 'ACP-2022-000038', '2022-05-06', '2053516', '2047485', '226822', 1, '1970-01-17', 'DNI', '09544765', 'MAMANI', 'VARGAS', 'MARIA ELENA', '2022-05-05', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '52', 2, 'PARTICULAR', 12, 1),
(39, 'ACP-2022-000039', '2022-05-06', '2049983', '2043953', '1364478', 1, '1960-12-21', 'DNI', '06905957', 'DURAND', 'DE LOS SANTOS', 'ROLANDO ', '2022-04-30', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '62', 1, 'PARTICULAR', 12, 1),
(40, 'ACP-2022-000040', '2022-05-09', '2054986', '2048955', '1365249', 1, '2004-09-04', 'DNI', '71768856', 'DAMIAN', 'CHAVEZ', 'BRAYAN WILLIAM', '2022-05-08', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '18', 1, 'PARTICULAR', 12, 1),
(41, 'ACP-2022-000041', '2022-05-09', '2055479', '2049448', '1278647', 1, '1990-11-25', 'CE', '005492428', 'LUCENA', 'ESCALONA', 'HELYS JANETH', '2022-05-09', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '32', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(42, 'ACP-2022-000042', '2022-05-11', '2053004', '2046974', '1341497', 1, '1989-09-22', 'CE', '003501445', 'PEREZ', 'GONZALEZ', 'KATHERINE JOHANNA', '2022-05-12', 'INFECTOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '33', 2, 'SIS', 12, 1),
(43, 'ACP-2022-000043', '2022-05-11', '2055097', '2049066', '1000669', 1, '1999-11-26', 'DNI', '62375413', 'GOMEZ', 'DURAND', 'SAZCKIA NAHOMY', '2022-05-09', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '23', 2, 'PARTICULAR', 12, 1),
(44, 'ACP-2022-000044', '2022-05-11', '2055793', '2049762', '1365363', 1, '2004-04-10', 'DNI', '74381000', 'GUERRERO', 'GUARNIZO', 'EDWIN ', '2022-05-09', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '18', 1, 'PARTICULAR', 12, 1),
(45, 'ACP-2022-000045', '2022-05-11', '2054353', '2048322', '1363407', 1, '1977-11-06', 'DNI', '30960343', 'APAZA', 'CONDORI', 'VERONICA YNES', '2022-05-07', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '45', 2, 'PARTICULAR', 12, 1),
(46, 'ACP-2022-000046', '2022-05-11', '2054636', '2048605', '359230', 2, '1991-04-20', 'DNI', '46938050', 'JACOME', 'ROSALES', 'ROSSMERY MILAGROS', '2022-05-07', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '31', 2, 'PARTICULAR', 12, 1),
(47, 'ACP-2022-000047', '2022-05-11', '2055725', '2049694', '1365349', 1, '1995-12-28', 'DNI', '77424690', 'LEANDRO', 'MORALES', 'KELING ELVIS', '2022-05-09', 'TRAUMA TOPICO - EMERGENCIA', '', 'SAN PEDRO DE CHAULAN', '27', 1, 'PARTICULAR', 12, 1),
(48, 'ACP-2022-000048', '2022-05-11', '2053413', '2047382', '746091', 1, '1952-01-23', 'DNI', '18073639', 'CARBONEL', 'LEDESMA', 'MERCEDES MARGARITA', '2022-05-05', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '70', 2, 'PARTICULAR', 12, 1),
(49, 'ACP-2022-000049', '2022-05-11', '2056259', '2050228', '1269299', 1, '1963-03-02', 'DNI', '06864391', 'PASTOR', 'RENQUIFO', 'NORMA GLADYS', '2022-05-10', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '59', 2, 'PARTICULAR', 12, 1),
(50, 'ACP-2022-000050', '2022-05-11', '2056459', '2050428', '34767', 1, '1946-01-19', 'DNI', '06930917', 'SOSA', 'LUIS', 'AURORA ', '2022-05-10', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '76', 2, 'PARTICULAR', 12, 1),
(51, 'ACP-2022-000051', '2022-05-11', '2055239', '2049208', '1364650', 1, '1951-10-20', 'DNI', '15383786', 'AGUADO', 'DE YALLE', 'CRISTOBAL VICTORIANO', '2022-05-09', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '71', 1, 'PARTICULAR', 12, 1),
(52, 'ACP-2022-000052', '2022-05-11', '2056139', '2050108', '880325', 1, '1979-05-18', 'DNI', '41177549', 'FLORES', 'RODRIGUEZ', 'RAUL MICKY', '2022-05-10', 'TRAUMA TOPICO - EMERGENCIA', '', 'COMAS', '43', 1, 'PARTICULAR', 12, 1),
(53, 'ACP-2022-000053', '2022-05-12', '2056358', '2050327', '962517', 1, '2002-01-11', 'DNI', '73428372', 'GIURFA', 'FERRO', 'JORDANO ARTUR', '2022-05-10', 'TRAUMA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '20', 1, 'PARTICULAR', 12, 1),
(54, 'ACP-2022-000054', '2022-05-12', '2054753', '2048722', '1323483', 1, '1973-01-18', 'DNI', '80449785', 'CARBAJAL', 'CARLOS', 'LUIS ANGEL', '2022-05-07', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '49', 1, 'PARTICULAR', 12, 1),
(55, 'ACP-2022-000055', '2022-05-12', '2055094', '2049063', '1237096', 2, '1971-10-29', 'DNI', '80452276', 'HOYOS', 'DIAZ', 'TOVIAS ', '2022-05-09', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '51', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(56, 'ACP-2022-000056', '2022-05-12', '2057349', '2051318', '1365569', 1, '1954-04-14', 'DNI', '10386545', 'MONTOYA', 'GUEVARA DE MINAYA', 'ZAHI RENE', '2022-05-11', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '68', 2, 'PARTICULAR', 12, 1),
(57, 'ACP-2022-000057', '2022-05-13', '2055814', '2049783', '1365370', 1, '1999-01-03', 'DIE', '154379418', 'UZCANGA', 'ACEVEDO', 'MARIA JOSE', '2022-05-09', 'TRAUMA TOPICO - EMERGENCIA', '', 'COMAS', '23', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(58, 'ACP-2022-000058', '2022-05-13', '2045619', '2039589', '1357959', 1, '1980-08-02', 'DNI', '40939453', 'CHUNGA', 'CARRANZA', 'CHRIST ', '2022-05-16', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '42', 1, 'SIS', 12, 1),
(59, 'ACP-2022-000059', '2022-05-13', '2058171', '2052140', '114750', 1, '1949-04-25', 'DNI', '80236174', 'ROBLES', 'MAQUI', 'MARCELINA ', '2022-05-13', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '73', 2, 'PARTICULAR', 12, 1),
(60, 'ACP-2022-000060', '2022-05-13', '2045721', '2039691', '392580', 1, '1966-10-24', 'DNI', '06958056', 'CCONO', 'MAMANI', 'MARIA DEL PILAR', '2022-05-16', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '56', 2, 'SIS', 12, 1),
(61, 'ACP-2022-000061', '2022-05-13', '2056645', '2050614', '754781', 1, '1973-01-18', 'DNI', '09925724', 'PARRA', 'CRUZ', 'ANTONIA ', '2022-05-10', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '49', 2, 'PARTICULAR', 12, 1),
(62, 'ACP-2022-000062', '2022-05-13', '2053444', '2047413', '96614', 2, '1976-04-13', 'DNI', '80255476', 'PICON', 'PARDAVE', 'EDWIN ALBERTO', '2022-05-05', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '46', 1, 'PARTICULAR', 12, 1),
(63, 'ACP-2022-000063', '2022-05-15', '2009577', '2003536', '1195885', 1, '1984-06-03', 'DNI', '42442875', 'REATEGUI', 'PALACIOS', 'JUANA CINTHIA', '2022-02-26', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '38', 2, 'PARTICULAR', 10, 1),
(64, 'ACP-2022-000064', '2022-05-15', '2006046', '2000005', '1014444', 1, '1993-04-29', 'DNI', '47931883', 'MANRIQUE', 'OJANAMA', 'RAMIRO EFRAIN', '2022-02-21', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '29', 1, 'PARTICULAR', 10, 1),
(65, 'ACP-2022-000065', '2022-05-15', '2055974', '2049943', '1017788', 1, '1992-12-18', 'DNI', '72067411', 'JARAMILLO', 'VILLANUEVA', 'MAYLIN SOLANGE', '2022-05-10', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '30', 2, 'PARTICULAR', 10, 1),
(66, 'ACP-2022-000066', '2022-05-15', '2009364', '2003323', '61394', 2, '1956-12-28', 'DNI', '06830059', 'CARLOS', 'TAMAYO', 'ANTENOR GUMERCINDO', '2022-02-24', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '66', 1, 'PARTICULAR', 10, 1),
(67, 'ACP-2022-000067', '2022-05-15', '2050920', '2044890', '1358538', 1, '1959-10-27', 'DNI', '06958932', 'GUARDAMINO', 'VILLANUEVA', 'ODULIO VICENTE', '2022-05-26', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '63', 1, 'SIS', 10, 1),
(68, 'ACP-2022-000068', '2022-05-15', '2008117', '2002076', '1358242', 1, '1992-11-04', 'DNI', '47495984', 'HUIÑAPI', 'PIZANGO', 'KEKER CRISTIAN', '2022-02-23', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '30', 1, 'PARTICULAR', 10, 1),
(69, 'ACP-2022-000069', '2022-05-15', '2010747', '2004706', '1358583', 1, '1978-04-13', 'DNI', '41899503', 'REGALADO', 'REYES', 'FREDY OSWALDO', '2022-02-26', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 10, 1),
(70, 'ACP-2022-000070', '2022-05-15', '2038993', '2032962', '1093504', 1, '1965-02-26', 'DNI', '42791202', 'NAKAMO', 'HUERTAS', 'LUIS ALBERTO', '2022-05-04', 'ENDOCRINOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '57', 1, 'SIS', 10, 1),
(71, 'ACP-2022-000071', '2022-05-15', '2034493', '2028463', '253757', 1, '1955-02-11', 'DNI', '06831029', 'CHOCAS', 'SIMEON DE CHURAMPI', 'ANDREA EUDOSIA', '2022-05-20', 'CARDIOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '67', 2, 'SIS', 10, 1),
(72, 'ACP-2022-000072', '2022-05-15', '2052144', '2046114', '1291148', 1, '1969-12-01', 'DNI', '43147679', 'QUINCHO', 'CANO', 'PEPE ARTURO', '2022-05-12', 'REUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '53', 1, 'SIS', 10, 1),
(73, 'ACP-2022-000073', '2022-05-15', '2011637', '2005596', '845006', 1, '1990-06-11', 'DNI', '46362404', 'CASTILLO', 'MARICHI', 'SANDY MELISA', '2022-03-03', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '32', 2, 'PARTICULAR', 10, 1),
(74, 'ACP-2022-000074', '2022-05-15', '2054429', '2048398', '943906', 1, '1969-01-10', 'DNI', '40507319', 'TARAZONA', 'ALONSO', 'HONORINA YOLANDA', '2022-05-07', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '53', 2, 'PARTICULAR', 10, 1),
(75, 'ACP-2022-000075', '2022-05-15', '2057943', '2051912', '1358931', 1, '1932-11-30', 'DNI', '06892077', 'PEREZ', 'SALCEDO', 'ANDRES C', '2022-05-12', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '90', 1, 'PARTICULAR', 10, 1),
(76, 'ACP-2022-000076', '2022-05-15', '2012269', '2006228', '1358823', 1, '1984-09-14', 'DNI', '42733572', 'SAENZ', 'VIDAL', 'ROSSMEL EDUARDO', '2022-03-07', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '38', 1, 'PARTICULAR', 10, 1),
(77, 'ACP-2022-000077', '2022-05-15', '2008135', '2002094', '1002696', 1, '1982-12-13', 'DNI', '44280167', 'SAMANEZ', 'SOTO', 'FRED ALBERTO', '2022-03-09', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '40', 1, 'PARTICULAR', 10, 1),
(78, 'ACP-2022-000078', '2022-05-15', '2056786', '2050755', '1279088', 1, '1971-05-29', 'DNI', '09962475', 'TORRES', 'CARDENAS', 'JUAN JOSE', '2022-05-11', 'REHABILITACION - 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '51', 1, 'SIS', 10, 1),
(79, 'ACP-2022-000079', '2022-05-15', '2029154', '2023124', '413263', 1, '1994-07-01', 'DNI', '76073966', 'AGUIRRE', 'PARIMANGO', 'JOHN BRYAN', '2022-04-19', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '28', 1, 'SIS', 10, 1),
(80, 'ACP-2022-000080', '2022-05-15', '2041395', '2035365', '1358810', 1, '1973-06-20', 'DNI', '80350480', 'GUEVARA', 'FRIAS', 'SILVANO ', '2022-05-16', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '49', 1, 'SIS', 10, 1),
(81, 'ACP-2022-000081', '2022-05-15', '2012631', '2006590', '998161', 1, '1936-07-24', 'DNI', '07328085', 'ESPINOZA', 'RODRIGUEZ', 'URCISINO ', '2022-03-02', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '86', 1, 'PARTICULAR', 10, 1),
(82, 'ACP-2022-000082', '2022-05-15', '2014925', '2008884', '1359222', 1, '1974-04-01', 'DNI', '09976703', 'CUTIPA', 'HUILLCA', 'ROSA ', '2022-03-06', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '48', 2, 'PARTICULAR', 10, 1),
(83, 'ACP-2022-000083', '2022-05-15', '2019497', '2013467', '677561', 1, '1981-09-06', 'DNI', '40999000', 'CAMAJUARE', 'LUJERIO', 'CANDY LUISA', '2022-03-15', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '41', 2, 'PARTICULAR', 10, 1),
(84, 'ACP-2022-000084', '2022-05-15', '2057276', '2051245', '227117', 1, '1971-06-17', 'DNI', '45002367', 'ATOCHE', 'DE LA CRUZ', 'EDGARDO JESUS', '2022-05-11', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '51', 1, 'PARTICULAR', 10, 1),
(85, 'ACP-2022-000085', '2022-05-15', '2015063', '2009022', '863627', 1, '1984-08-01', 'DNI', '45375927', 'VILCA', 'YUMBATO', 'LIDIA EDITH', '2022-03-07', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '38', 2, 'PARTICULAR', 10, 1),
(86, 'ACP-2022-000086', '2022-05-15', '2015682', '2009641', '1088138', 1, '2004-08-04', 'DNI', '79544452', 'MORANTE', 'VALLEJOS', 'LIZ MARIANELLA', '2022-03-07', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '18', 2, 'PARTICULAR', 10, 1),
(87, 'ACP-2022-000087', '2022-05-15', '2018602', '2012572', '1358765', 1, '1997-08-26', 'DNI', '73120574', 'HERRERA', 'FLORIAN', 'LUIS ENRRIQUE', '2022-03-14', 'DENTAL - 05 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '25', 1, 'SIS', 10, 1),
(88, 'ACP-2022-000088', '2022-05-15', '2014714', '2008673', '91448', 1, '1968-02-17', 'DNI', '09543536', 'POMATANTA', 'ENRIQUEZ', 'JOSE JONY', '2022-03-09', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '54', 1, 'PARTICULAR', 10, 1),
(89, 'ACP-2022-000089', '2022-05-15', '2015274', '2009233', '1359275', 1, '1999-05-30', 'DNI', '71257504', 'PIO', 'SIGUEÑAS', 'ALEJANDRO FRANCISCO', '2022-03-09', 'CIRUGIA UROLOGIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '23', 1, 'PARTICULAR', 10, 1),
(90, 'ACP-2022-000090', '2022-05-15', '2035357', '2029327', '133537', 1, '1991-12-16', 'DNI', '48001161', 'BALDEON', 'RAMIREZ', 'JOSSELIN ELSA', '2022-04-10', 'GINECOOBSTETRICIA TOPICO - EMERGENCIA', '', 'COMAS', '31', 2, 'PARTICULAR', 10, 1),
(91, 'ACP-2022-000091', '2022-05-15', '2016145', '2010104', '511983', 1, '1956-04-16', 'DNI', '25067463', 'CRUZ', 'ROQUE', 'TORIBIO ', '2022-03-09', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '66', 1, 'PARTICULAR', 10, 1),
(92, 'ACP-2022-000092', '2022-05-15', '2028774', '2022744', '622642', 1, '1945-06-22', 'DNI', '09018541', 'MEZA', 'QUIÑE', 'EUGENIO ALEJANDRO', '2022-04-05', 'HEMATOLOGIA 1- CONSULTA - CONSULTORIOS EXTERNOS', '', 'COMAS', '77', 1, 'SIS', 10, 1),
(93, 'ACP-2022-000093', '2022-05-15', '2015256', '2009215', '597077', 1, '1961-05-16', 'DNI', '06831177', 'SERNAQUE', 'VARGAS', 'ELSA MONICA', '2022-03-07', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 10, 1),
(94, 'ACP-2022-000094', '2022-05-15', '2029957', '2023927', '1352381', 1, '1996-09-21', 'DNI', '72319767', 'OTERO', 'FERREL', 'MIREYA ZORAIDA', '2022-04-18', 'PSIQUIATRIA - NUEVOS - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '26', 2, 'SIS', 10, 1),
(95, 'ACP-2022-000095', '2022-05-16', '2015081', '2009040', '617924', 1, '1950-08-19', 'DNI', '06888839', 'LOZANO', 'JARA', 'LUIS BENJAMIN', '2022-03-28', 'MEDICINA INTERNA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '72', 1, 'SIS', 10, 1),
(96, 'ACP-2022-000096', '2022-05-16', '2016830', '2010789', '866398', 1, '2003-08-14', 'DNI', '73839919', 'BENAZAR', 'GARCIA', 'JOSE LUIS', '2022-03-10', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'CARABAYLLO', '19', 1, 'PARTICULAR', 10, 1),
(97, 'ACP-2022-000097', '2022-05-16', '2024711', '2018681', '1356130', 1, '1997-09-16', 'DNI', '49063965', 'AMARI', 'AGUILAR', 'LADY DIANA', '2022-04-20', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '25', 2, 'SIS', 10, 1),
(98, 'ACP-2022-000098', '2022-05-16', '2017882', '2011850', '689321', 1, '2003-11-19', 'DNI', '74706342', 'YAMO', 'CRUZ', 'JHOMYRA MARYCIELO', '2022-03-12', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '19', 2, 'PARTICULAR', 10, 1),
(99, 'ACP-2022-000099', '2022-05-16', '2017874', '2011842', '638008', 1, '2003-04-18', 'DNI', '72426095', 'QUISPE', 'ARROSTE', 'KIARA BRISETH', '2022-03-12', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '19', 2, 'PARTICULAR', 10, 1),
(100, 'ACP-2022-000100', '2022-05-16', '2017759', '2011727', '1359706', 1, '1978-01-19', 'DNI', '80108468', 'MORALES', 'LOZA', 'WILLIAN ', '2022-03-14', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CAPILLAS', '44', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(101, 'ACP-2022-000101', '2022-05-16', '2018006', '2011976', '995161', 1, '1993-05-03', 'DNI', '47904060', 'FUERTES', 'HERMOSILLA', 'JHENNY KATHERINE', '2022-03-12', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '29', 2, 'PARTICULAR', 10, 1),
(102, 'ACP-2022-000102', '2022-05-16', '2054397', '2048366', '658747', 1, '1972-03-14', 'DNI', '09935689', 'MARTEL', 'RAMIREZ', 'IRMA ', '2022-05-10', 'NEUMO - RIESGO NEUMO - CONSULTORIOS EXTERNOS', '', 'COMAS', '50', 2, 'SIS', 10, 1),
(103, 'ACP-2022-000103', '2022-05-16', '2017999', '2011969', '389763', 1, '1970-03-26', 'DNI', '09737256', 'GOICOCHEA', 'MUCHA', 'NORA ELIZABETH', '2022-03-13', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '52', 2, 'PARTICULAR', 10, 1),
(104, 'ACP-2022-000104', '2022-05-16', '2030553', '2024523', '940978', 1, '1972-09-22', 'DNI', '25719699', 'SILVA', 'FARIAS', 'JOSE CARLOS', '2022-04-22', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '50', 1, 'SIS', 10, 1),
(105, 'ACP-2022-000105', '2022-05-16', '2018280', '2012250', '1359820', 1, '1949-10-28', 'DNI', '05255037', 'CRUZ', 'PADILLA', 'JOSE ORLANDO', '2022-03-13', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '73', 1, 'PARTICULAR', 10, 1),
(106, 'ACP-2022-000106', '2022-05-16', '2018528', '2012498', '994076', 1, '1979-03-01', 'DNI', '80535862', 'JEMPEKIT', 'ORREGO', 'OFENIA ', '2022-03-14', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '43', 2, 'PARTICULAR', 10, 1),
(107, 'ACP-2022-000107', '2022-05-16', '2018023', '2011993', '1023478', 1, '1936-12-22', 'DNI', '06860691', 'ROBLES', 'CUELLAR', 'ISMAEL ', '2022-03-12', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '86', 1, 'PARTICULAR', 10, 1),
(108, 'ACP-2022-000108', '2022-05-16', '2043006', '2036976', '109513', 1, '1970-05-22', 'DNI', '07469480', 'PANDO', 'URETA', 'JUAN JOSE', '2022-04-21', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '52', 1, 'PARTICULAR', 10, 1),
(109, 'ACP-2022-000109', '2022-05-16', '2018753', '2012723', '1074490', 1, '1995-01-11', 'DNI', '73192158', 'PEÑALOZA', 'POMA', 'SILVIA MARIETA', '2022-03-14', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '27', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(110, 'ACP-2022-000110', '2022-05-16', '2053048', '2047018', '1359744', 1, '1992-01-04', 'DNI', '70812858', 'MELCHOR', 'BARRETO', 'GABRIEL ALEJANDRO', '2022-05-26', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '30', 1, 'SIS', 10, 1),
(111, 'ACP-2022-000111', '2022-05-16', '2018992', '2012962', '1357981', 1, '1951-03-04', 'DNI', '06929065', 'PAÑIURA', 'FUENTES', 'CLAUDIO ', '2022-03-14', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '71', 1, 'PARTICULAR', 10, 1),
(112, 'ACP-2022-000112', '2022-05-16', '2019007', '2012977', '400688', 1, '1988-03-29', 'DNI', '45155570', 'VEGA', 'LIÑAN', 'SONIA ', '2022-03-14', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '34', 2, 'PARTICULAR', 10, 1),
(113, 'ACP-2022-000113', '2022-05-16', '2018964', '2012934', '1359964', 1, '1992-09-03', 'DNI', '47765658', 'JAUREGUI', 'CARDENAS', 'ESTEFANIE MADELEYNE', '2022-03-14', 'MEDICINA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '30', 2, 'PARTICULAR', 10, 1),
(114, 'ACP-2022-000114', '2022-05-16', '2019062', '2013032', '340084', 1, '1968-07-28', 'DNI', '09730885', 'GALLUPE', 'MARCAÑAUPA', 'GERMAN JAVIER', '2022-03-15', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '54', 1, 'PARTICULAR', 10, 1),
(115, 'ACP-2022-000115', '2022-05-16', '2050591', '2044561', '1343413', 1, '1997-11-17', 'DIE', '26128986', 'PEÑA', 'PEÑA', 'EMILIS NAILI', '2022-05-04', 'REHABILITACION - 3 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '25', 2, 'PARTICULAR', 10, 1),
(116, 'ACP-2022-000116', '2022-05-16', '2058821', '2052794', '1365748', 1, '1976-12-30', 'DNI', '32497645', 'SOLIS', 'VALENTIN', 'OSCAR VICTOR', '2022-05-13', 'CIRUGIA TOPICO - EMERGENCIA', '', 'PUENTE PIEDRA', '46', 1, 'PARTICULAR', 12, 1),
(117, 'ACP-2022-000117', '2022-05-16', '2059812', '2053785', '580368', 1, '1966-02-15', 'DNI', '10167734', 'ORTIZ', 'SOLIS', 'JOSE ', '2022-05-16', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '56', 1, 'PARTICULAR', 12, 1),
(118, 'ACP-2022-000118', '2022-05-16', '2059498', '2053471', '471557', 1, '1997-01-24', 'DNI', '70510688', 'RAMIREZ', 'TUERO', 'THAIS SUSUKI', '2022-05-15', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '25', 2, 'PARTICULAR', 12, 1),
(119, 'ACP-2022-000119', '2022-05-16', '2059231', '2053204', '1193889', 1, '1976-04-18', 'DNI', '22519235', 'HERRERA', 'HUAMAN', 'NORA BEATRIZ', '2022-05-14', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '46', 2, 'PARTICULAR', 12, 1),
(120, 'ACP-2022-000120', '2022-05-16', '2058689', '2052662', '434614', 1, '1962-08-31', 'DNI', '08123609', 'LIZAMA', 'ZAMUDIO', 'SILVIA RUTH', '2022-05-13', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'COMAS', '60', 2, 'PARTICULAR', 12, 1),
(121, 'ACP-2022-000121', '2022-05-18', '2060789', '2054762', '111069', 1, '1954-09-27', 'DNI', '06865478', 'LEON', 'CALDERON', 'GRACIELA MARGARITA', '2022-05-17', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '68', 2, 'PARTICULAR', 12, 1),
(122, 'ACP-2022-000122', '2022-05-18', '2056860', '2050829', '1365509', 1, '1993-07-26', 'DNI', '47898573', 'BELTRAN', 'SALAZAR', 'JHAM PIERR', '2022-05-11', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '29', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(123, 'ACP-2022-000123', '2022-05-18', '2052919', '2046889', '1297684', 1, '1993-08-20', 'DNI', '70024695', 'LOPEZ', 'OSTOS', 'STEPHANIE WENDY', '2022-05-05', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '29', 2, 'PARTICULAR', 10, 1),
(124, 'ACP-2022-000124', '2022-05-18', '2027553', '2021523', '1201123', 1, '1982-09-26', 'DNI', '41652421', 'ROMERO', 'FEBRES', 'ELIZABET CONSUELO', '2022-04-20', 'GINECOLOGIA - 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '40', 2, 'SIS', 10, 1),
(125, 'ACP-2022-000125', '2022-05-18', '2019512', '2013482', '540968', 1, '1968-01-13', 'DNI', '09300860', 'ORTEGA', 'VALVERDE', 'ZOILA ANA', '2022-03-15', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '54', 2, 'PARTICULAR', 10, 1),
(126, 'ACP-2022-000126', '2022-05-18', '2019346', '2013316', '1197585', 1, '1996-02-13', 'DNI', '72090615', 'LEON', 'JARAMILLO', 'ESTELA ', '2022-03-16', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '26', 2, 'PARTICULAR', 10, 1),
(127, 'ACP-2022-000127', '2022-05-18', '2056387', '2050356', '1360163', 1, '1964-04-27', 'DNI', '06854637', 'CASTILLO', 'LIENDO', 'MIGUEL ANGEL', '2022-06-01', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '58', 1, 'SIS', 10, 1),
(128, 'ACP-2022-000128', '2022-05-18', '2026750', '2020720', '741418', 1, '1954-11-13', 'DNI', '15289235', 'MOLINA', 'BOHORQUEZ', 'JAIME VICTOR', '2022-03-26', 'MEDICINA TOPICO - EMERGENCIA', '', 'LACHAQUI', '68', 1, 'PARTICULAR', 10, 1),
(129, 'ACP-2022-000129', '2022-05-18', '2020276', '2014246', '1354503', 1, '1981-09-23', 'DNI', '41066900', 'HUAMANI', 'PINON DE CHINGA', 'BEDITH ', '2022-03-17', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '41', 2, 'PARTICULAR', 10, 1),
(130, 'ACP-2022-000130', '2022-05-18', '2048712', '2042682', '196946', 1, '1934-06-25', 'DNI', '48860820', 'PADILLA', 'CARTOLÍN', 'GUILLERMO ', '2022-05-23', 'CARDIOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '88', 1, 'SIS', 10, 1),
(131, 'ACP-2022-000131', '2022-05-18', '2032496', '2026466', '1359938', 1, '1991-12-24', 'DNI', '47800234', 'FLORES', 'EXEBIO', 'CESAR JUNIOR', '2022-04-05', 'ENDOSCOPIA (PROC 1) - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '31', 1, 'SIS', 10, 1),
(132, 'ACP-2022-000132', '2022-05-18', '2019533', '2013503', '843450', 1, '1963-03-14', 'DNI', '06887946', 'VELAZCO', 'FUERTES', 'SUSANA ', '2022-03-15', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '59', 2, 'PARTICULAR', 10, 1),
(133, 'ACP-2022-000133', '2022-05-18', '2020922', '2014892', '1360331', 1, '1960-12-21', 'DNI', '45579381', 'ROJAS', 'LOPEZ', 'SEVERIANO IVAN', '2022-03-18', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'COMAS', '62', 1, 'PARTICULAR', 10, 1),
(134, 'ACP-2022-000134', '2022-05-18', '2037220', '2031189', '609064', 1, '1972-06-02', 'DNI', '09670978', 'OLIVA', 'LOAYZA', 'JUAN BERNARDO', '2022-04-22', 'CIRUGIA CABEZA Y CUELLO 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '50', 1, 'SIS', 10, 1),
(135, 'ACP-2022-000135', '2022-05-18', '2028059', '2022029', '1143584', 1, '1986-07-08', 'DNI', '43857220', 'GARAY', 'MARZANO', 'ESTHER MAGNOLIA', '2022-03-28', 'MEDICINA TOPICO - EMERGENCIA', '', 'PUENTE PIEDRA', '36', 2, 'PARTICULAR', 10, 1),
(136, 'ACP-2022-000136', '2022-05-18', '2020278', '2014248', '1360232', 1, '1934-10-05', 'DNI', '08419448', 'MURO', 'AREVALO', 'LUIS DONAL', '2022-03-17', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'CALLAO', '88', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(137, 'ACP-2022-000137', '2022-05-18', '2021050', '2015020', '1261992', 1, '1945-06-25', 'DNI', '07423320', 'SOTIL', 'YEREN DE CHIRA', 'BLANCA LUCY', '2022-03-19', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '77', 2, 'PARTICULAR', 10, 1),
(138, 'ACP-2022-000138', '2022-05-18', '2017801', '2011769', '1359719', 1, '1976-11-30', 'DNI', '80268476', 'PAREJA', 'ANTESANA', 'JUAN MANUEL', '2022-03-11', 'MEDICINA TOPICO - EMERGENCIA', '', 'PIMENTEL', '46', 1, 'PARTICULAR', 10, 1),
(139, 'ACP-2022-000139', '2022-05-18', '2048403', '2042373', '1360436', 1, '1978-02-27', 'DNI', '80654873', 'GOMEZ', 'CERDA', 'SANTOS ', '2022-05-24', 'TRAUMATOLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'COMAS', '44', 1, 'SIS', 10, 1),
(140, 'ACP-2022-000140', '2022-05-18', '2025030', '2019000', '892241', 1, '1986-05-06', 'DNI', '43653637', 'YANAYACO', 'CRIOLLO', 'DIANA ISABEL', '2022-04-11', 'REUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '36', 2, 'SIS', 10, 1),
(141, 'ACP-2022-000141', '2022-05-18', '2021406', '2015376', '420466', 1, '1941-04-05', 'DNI', '06835915', 'CHINCHAY', 'ROSALES', 'VICENTE ZENON', '2022-03-26', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '81', 1, 'PARTICULAR', 10, 1),
(142, 'ACP-2022-000142', '2022-05-18', '2021339', '2015309', '1056049', 1, '1985-02-02', 'DNI', '43138027', 'ROMERO', 'MORALES', 'JUAN CARLOS', '2022-03-19', 'TRAUMA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '37', 1, 'PARTICULAR', 10, 1),
(143, 'ACP-2022-000143', '2022-05-18', '2022724', '2016694', '1286838', 1, '1999-12-12', 'DNI', '78462252', 'GARCIA', 'BENITES', 'INES ', '2022-03-22', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'CARABAYLLO', '23', 2, 'PARTICULAR', 10, 1),
(144, 'ACP-2022-000144', '2022-05-18', '2021608', '2015578', '1360500', 1, '1958-09-08', 'DNI', '06195381', 'DE LA CRUZ', 'RAMON', 'MOISES ADRIAN', '2022-03-23', 'MEDICINA VARONES - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '64', 1, 'PARTICULAR', 10, 1),
(145, 'ACP-2022-000145', '2022-05-18', '2020390', '2014360', '1360247', 1, '1987-10-12', 'DIE', '18848841', 'DIAZ', 'VILLARROEL', 'DAYANA CAROLINA', '2022-03-17', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '35', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(146, 'ACP-2022-000146', '2022-05-18', '2020948', '2014918', '1350938', 1, '1997-10-29', 'DNI', '75455083', 'PERALES', 'MIMBELA', 'BRIAM REYNALDO', '2022-03-26', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '25', 1, 'PARTICULAR', 10, 1),
(147, 'ACP-2022-000147', '2022-05-18', '2023424', '2017394', '669818', 1, '1980-08-29', 'DNI', '40629325', 'BARBOZA', 'CARRASCO', 'YSABEL ', '2022-03-24', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '42', 2, 'PARTICULAR', 10, 1),
(148, 'ACP-2022-000148', '2022-05-18', '2023016', '2016986', '1360673', 1, '1961-09-04', 'DNI', '06228410', 'FASABI', 'FLORES DE CONDOR', 'BEREDITA ', '2022-03-22', 'CIRUGIA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '61', 2, 'PARTICULAR', 10, 1),
(149, 'ACP-2022-000149', '2022-05-18', '2024571', '2018541', '1022328', 1, '1981-12-09', 'DNI', '44665684', 'FERNANDEZ', 'SANCHEZ', 'CARMELA ', '2022-03-26', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '41', 2, 'PARTICULAR', 10, 1),
(150, 'ACP-2022-000150', '2022-05-18', '2047238', '2041208', '1360821', 1, '1993-12-22', 'CE', '21276046', 'RAMOS', 'PIRE', 'DANIEL JOSE', '2022-05-23', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '29', 1, 'PARTICULAR', 10, 1),
(151, 'ACP-2022-000151', '2022-05-18', '2020791', '2014761', '1239707', 1, '1974-06-16', 'DNI', '10213125', 'MUÑOZ', 'SALAS', 'FRANCISCO EDUARDO', '2022-04-02', 'REHABILITACION - 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '48', 1, 'SIS', 10, 1),
(152, 'ACP-2022-000152', '2022-05-18', '2047366', '2041336', '566131', 1, '2001-12-24', 'DNI', '74104432', 'PARIONA', 'ALARCON', 'DANAE KARIN', '2022-05-16', 'REUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '21', 2, 'SIS', 10, 1),
(153, 'ACP-2022-000153', '2022-05-18', '2025860', '2019830', '61017', 1, '1948-11-11', 'DNI', '06921264', 'NOLBERTO', 'PABLO VDA DE ROJAS', 'ERNESTINA ', '2022-03-24', 'MEDICINA TOPICO - EMERGENCIA', '', 'INDEPENDENCIA', '74', 2, 'PARTICULAR', 10, 1),
(154, 'ACP-2022-000154', '2022-05-19', '2030345', '2024315', '356028', 1, '1991-06-21', 'DNI', '47642185', 'TRUJILLO', 'LEON', 'LAURA BEATRIZ', '2022-04-03', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '31', 2, 'PARTICULAR', 10, 1),
(155, 'ACP-2022-000155', '2022-05-19', '2050692', '2044662', '1070613', 1, '1962-11-13', 'DNI', '10154777', 'LOPEZ', 'ALEJOS', 'JUANA MAGDALENA', '2022-05-19', 'REHABILITACION - 2 - CONSULTORIOS EXTERNOS', '', 'COMAS', '60', 2, 'SIS', 10, 1),
(156, 'ACP-2022-000156', '2022-05-19', '2027139', '2021109', '1361157', 1, '1970-02-11', 'DNI', '00969335', 'GUERRA', 'SATALAYA', 'CONSUELO ', '2022-03-26', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '52', 2, 'PARTICULAR', 10, 1),
(157, 'ACP-2022-000157', '2022-05-19', '2041776', '2035746', '207466', 1, '1955-03-20', 'DNI', '06931656', 'REAÑO', 'GUTIERREZ', 'FELIX RAMON', '2022-05-11', 'UROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '67', 1, 'SIS', 10, 1),
(158, 'ACP-2022-000158', '2022-05-19', '2053106', '2047075', '265339', 1, '1965-06-22', 'DNI', '10389562', 'ARIMBORGO', 'VELIZ', 'JUAN LUCIANO', '2022-05-25', 'UROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '57', 1, 'SIS', 10, 1),
(159, 'ACP-2022-000159', '2022-05-19', '2026333', '2020303', '1258151', 1, '1979-03-21', 'DNI', '80613732', 'ARROYO', 'ALATA', 'NILTON LEONELS', '2022-03-25', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '43', 1, 'PARTICULAR', 10, 1),
(160, 'ACP-2022-000160', '2022-05-19', '2034705', '2028675', '1341981', 1, '1955-01-16', 'DNI', '06827096', 'POLANCO', 'RODRIGUEZ', 'MANUEL JESUS', '2022-04-13', 'DENTAL - 01 - CONSULTORIOS EXTERNOS', '', 'COMAS', '67', 1, 'SIS', 10, 1),
(161, 'ACP-2022-000161', '2022-05-19', '2032131', '2026101', '648899', 1, '1971-04-02', 'DNI', '09739607', 'SOTO', 'TERAN DE ALONSO', 'ANGELICA LUCIA', '2022-04-04', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '51', 2, 'PARTICULAR', 10, 1),
(162, 'ACP-2022-000162', '2022-05-19', '2027418', '2021388', '1358001', 1, '1955-02-19', 'DNI', '09027018', 'HINOSTROZA', 'MALVA', 'MARCOS MARCELO', '2022-03-28', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '67', 1, 'PARTICULAR', 10, 1),
(163, 'ACP-2022-000163', '2022-05-19', '2028662', '2022632', '1309981', 1, '2002-03-25', 'DNI', '72465391', 'INGAR', 'HILARIO', 'SAUL JHONATAN', '2022-03-29', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '20', 1, 'PARTICULAR', 10, 1),
(164, 'ACP-2022-000164', '2022-05-19', '2035462', '2029432', '1361241', 1, '1986-02-24', 'CE', '00529252', 'RAMOS', 'COLINA', 'LEURY JENNIFER', '2022-04-14', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '36', 2, 'PARTICULAR', 10, 1),
(165, 'ACP-2022-000165', '2022-05-19', '2053168', '2047137', '427895', 1, '1975-03-25', 'DNI', '10216017', 'AREVALO', 'ALFARO', 'ANA ', '2022-05-25', 'UROLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '47', 2, 'SIS', 10, 1),
(166, 'ACP-2022-000166', '2022-05-19', '2040636', '2034605', '249905', 1, '1969-04-23', 'DNI', '09731153', 'SANCHEZ', 'QUIQUIA', 'LUIS ALBERTO', '2022-05-07', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '53', 1, 'SIS', 10, 1),
(167, 'ACP-2022-000167', '2022-05-19', '2050898', '2044868', '1220487', 1, '1962-06-24', 'DIE', '000235807', 'GOMEZ', '', 'NANCY ', '2022-05-03', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '60', 2, 'PARTICULAR', 10, 1),
(168, 'ACP-2022-000168', '2022-05-19', '2030117', '2024087', '188894', 1, '1974-03-01', 'DNI', '80359276', 'SILVA', 'TREJO', 'LUIS ALEJANDRO', '2022-03-31', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '48', 1, 'PARTICULAR', 10, 1),
(169, 'ACP-2022-000169', '2022-05-19', '2044935', '2038905', '1361625', 1, '1993-10-16', 'DNI', '48559229', 'DIAZ', 'RIOJA', 'JOEL ', '2022-05-06', 'TRAUMATOLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'JOSE LEONARDO ORTIZ', '29', 1, 'SIS', 10, 1),
(170, 'ACP-2022-000170', '2022-05-19', '2060495', '2054468', '638969', 1, '1962-01-03', 'DNI', '06843979', 'ALMEYDA', 'PALACIOS', 'LUIS FERNANDO', '2022-06-14', 'UROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '60', 1, 'SIS', 10, 1),
(171, 'ACP-2022-000171', '2022-05-19', '2049293', '2043263', '961922', 1, '1991-07-10', 'DNI', '48727765', 'GUERRA', 'MEZA', 'ANETH ', '2022-04-29', 'HEMATOLOGIA 1- CONSULTA - CONSULTORIOS EXTERNOS', '', 'COMAS', '31', 2, 'SIS', 10, 1),
(172, 'ACP-2022-000172', '2022-05-19', '2023796', '2017766', '1191261', 1, '1949-10-21', 'DNI', '08033136', 'ORCOTURIO', 'CRUZ', 'JUAN CANCIO', '2022-04-01', 'NEUMOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '73', 1, 'SIS', 10, 1),
(173, 'ACP-2022-000173', '2022-05-19', '2049000', '2042970', '1025137', 1, '1961-11-15', 'DNI', '06125246', 'CARDENAS', 'RUIZ', 'FELIX ', '2022-05-20', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '61', 1, 'SIS', 10, 1),
(174, 'ACP-2022-000174', '2022-05-19', '2039647', '2033616', '412656', 1, '1957-07-24', 'DNI', '09019718', 'RABANAL', 'GAL', 'MARCO ANTONIO', '2022-05-19', 'UROLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '65', 1, 'SIS', 10, 1),
(175, 'ACP-2022-000175', '2022-05-19', '2030885', '2024855', '1325433', 1, '1986-02-15', 'DNI', '44889881', 'MEZA', 'TOCTO', 'RUMALDA ', '2022-04-04', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '36', 2, 'PARTICULAR', 10, 1),
(176, 'ACP-2022-000176', '2022-05-19', '2030353', '2024323', '794261', 1, '1976-09-23', 'DNI', '10333405', 'AZURZA', 'PAUCAR', 'HILDA ', '2022-04-05', 'GINECOLOGIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '46', 2, 'PARTICULAR', 10, 1),
(177, 'ACP-2022-000177', '2022-05-19', '2031634', '2025604', '1361876', 1, '2002-01-11', 'DNI', '72599147', 'DIAZ', 'VEGA', 'JHONNY JEFFY', '2022-04-03', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '20', 1, 'PARTICULAR', 10, 1),
(178, 'ACP-2022-000178', '2022-05-19', '2060082', '2054055', '1361848', 1, '1997-06-29', 'DNI', '76289110', 'CONTRERAS', 'PAULINO', 'JUAN CARLOS', '2022-06-06', 'TRAUMATOLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'LOS OLIVOS', '25', 1, 'SIS', 10, 1),
(179, 'ACP-2022-000179', '2022-05-19', '2050979', '2044949', '1044290', 1, '1978-08-23', 'DNI', '41948981', 'CARDENAS', 'YALTA', 'FRANCISCA ', '2022-05-09', 'INFECTOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '44', 2, 'SIS', 10, 1),
(180, 'ACP-2022-000180', '2022-05-19', '2031652', '2025622', '1361881', 1, '1998-01-17', 'DNI', '74871750', 'CARDENAS', 'MALLQUI', 'SHAN ', '2022-04-03', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '24', 1, 'PARTICULAR', 10, 1),
(181, 'ACP-2022-000181', '2022-05-19', '2031533', '2025503', '446766', 1, '1996-01-07', 'DNI', '76765123', 'CONDE', 'PALOMINO', 'ESTRELLITA ', '2022-04-03', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '26', 2, 'PARTICULAR', 10, 1),
(182, 'ACP-2022-000182', '2022-05-19', '2032381', '2026351', '168215', 1, '1947-08-07', 'DNI', '10386462', 'CONDORI', 'SANTOS', 'ALBERTO ', '2022-04-07', 'MEDICINA VARONES - HOSPITALIZACIÓN ', '', 'COMAS', '75', 1, 'PARTICULAR', 10, 1),
(183, 'ACP-2022-000183', '2022-05-19', '2032309', '2026279', '1361988', 1, '2003-03-18', 'DNI', '73461386', 'VELASQUEZ', 'ATENCIO', 'SARAI JANETH', '2022-04-04', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '19', 2, 'PARTICULAR', 10, 1),
(184, 'ACP-2022-000184', '2022-05-19', '2031562', '2025532', '35894', 1, '1970-06-06', 'DNI', '09737746', 'MARAVI', 'GARCIA', 'ARMANDO ', '2022-04-03', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '52', 1, 'PARTICULAR', 10, 1),
(185, 'ACP-2022-000185', '2022-05-19', '2032394', '2026364', '892667', 1, '1945-02-23', 'DNI', '07389117', 'YUCRA', 'COARITE', 'DAMIANA ', '2022-04-08', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '77', 2, 'PARTICULAR', 10, 1),
(186, 'ACP-2022-000186', '2022-05-19', '1852593', '1846549', '1288296', 1, '1970-05-27', 'CE', '001946319', 'ALVARADO', '', 'FRANCISCO JOSE', '2020-09-11', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '52', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(187, 'ACP-2022-000187', '2022-05-19', '2032336', '2026306', '1361994', 1, '1983-07-08', 'DNI', '45163788', 'CORDOVA', 'GARCIA', 'JOHN TOMAS', '2022-04-04', 'CIRUGIA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '39', 1, 'PARTICULAR', 10, 1),
(188, 'ACP-2022-000188', '2022-05-19', '2032840', '2026810', '113029', 1, '1977-02-19', 'DNI', '80150696', 'HUAMAN', 'GUZMAN', 'JORGE LUIS', '2022-04-06', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '45', 1, 'PARTICULAR', 10, 1),
(189, 'ACP-2022-000189', '2022-05-19', '2028433', '2022403', '1361392', 1, '1993-07-05', 'DNI', '47946557', 'FLORES', 'VILCA', 'MARIEL GIOVANNA', '2022-03-29', 'UCI GENERAL HOSPI - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '29', 2, 'PARTICULAR', 10, 1),
(190, 'ACP-2022-000190', '2022-05-19', '2047991', '2041961', '726013', 1, '2003-06-29', 'DNI', '76495661', 'DE LA CRUZ', 'MANSILLA', 'ESTRELLA GERALDINE', '2022-05-02', 'CIRUGIA GENERAL 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '19', 2, 'SIS', 10, 1),
(191, 'ACP-2022-000191', '2022-05-20', '2033545', '2027515', '1181983', 1, '1998-04-17', 'DNI', '75928977', 'ESCOBAR', 'LANDEO', 'LUIS ANGEL', '2022-04-12', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '24', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(192, 'ACP-2022-000192', '2022-05-20', '2032863', '2026833', '1362124', 1, '1995-04-28', 'DNI', '77537375', 'TIPULA', 'VARGAS', 'CARMEN MILAGROS', '2022-04-06', 'CIRUGIA TOPICO - EMERGENCIA', '', 'PUENTE PIEDRA', '27', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(193, 'ACP-2022-000193', '2022-05-20', '2032861', '2026831', '1362122', 1, '2000-01-21', 'DNI', '71611429', 'UGARTE', 'SAENZ', 'SAMMY ALFONSO', '2022-04-09', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '22', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(194, 'ACP-2022-000194', '2022-05-20', '2034056', '2028026', '1362275', 1, '1960-04-13', 'DNI', '09435939', 'CLEMENTE', 'ASCA', 'APOLONIA ', '2022-04-11', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'SANTA ROSA DE QUIVES', '62', 2, 'PARTICULAR', 10, 1),
(195, 'ACP-2022-000195', '2022-05-20', '2034101', '2028071', '722242', 1, '1983-07-11', 'DNI', '41944014', 'CARRASCO', 'TINEO', 'MARIBEL ', '2022-04-08', 'CIRUGIA DE TORAX Y CARDIOVASCULAR - HOSPITALIZACIÓN ', '', 'COMAS', '39', 2, 'PARTICULAR', 10, 1),
(196, 'ACP-2022-000196', '2022-05-20', '2034760', '2028730', '573158', 1, '1972-07-25', 'DNI', '10213081', 'QUISPE', 'BAUTISTA', 'MARIBEL LUCY', '2022-04-10', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '50', 2, 'PARTICULAR', 10, 1),
(197, 'ACP-2022-000197', '2022-05-20', '2057217', '2051186', '302684', 1, '1986-06-10', 'DNI', '43624200', 'SALAS', 'MARCELO', 'JANET YOVANA', '2022-05-11', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '36', 2, 'PARTICULAR', 10, 1),
(198, 'ACP-2022-000198', '2022-05-20', '2053232', '2047201', '1355190', 1, '1977-03-22', 'DNI', '10399895', 'SANDOVAL', 'QUISPE', 'MICHEL TEODORO', '2022-05-19', 'CARDIOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '45', 1, 'SIS', 10, 1),
(199, 'ACP-2022-000199', '2022-05-20', '2041851', '2035821', '1362516', 1, '1990-04-12', 'DNI', '46609353', 'SORIA', 'RIVERA', 'LANDER ', '2022-05-10', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '32', 1, 'PARTICULAR', 10, 1),
(200, 'ACP-2022-000200', '2022-05-20', '2034366', '2028336', '679530', 1, '1962-09-01', 'DNI', '00985346', 'QUEZADA', 'JARA', 'GIL ', '2022-04-30', 'NEUROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '60', 1, 'SIS', 10, 1),
(201, 'ACP-2022-000201', '2022-05-20', '2038931', '2032900', '1235339', 1, '1992-07-25', 'DNI', '47384350', 'VILLEGAS', 'CRUZ', 'DEISY YANELA', '2022-04-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '30', 2, 'PARTICULAR', 10, 1),
(202, 'ACP-2022-000202', '2022-05-20', '2060405', '2054378', '1186674', 1, '1955-04-24', 'DNI', '07363800', 'CONDORI', 'BLANCO', 'ALEJANDRA ', '2022-06-02', 'NEUMOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'LA VICTORIA', '67', 2, 'SIS', 10, 1),
(203, 'ACP-2022-000203', '2022-05-20', '2061048', '2055021', '1362147', 1, '1985-11-14', 'DNI', '44115121', 'RAMOS', 'SALAS', 'MANUEL JESUS', '2022-05-17', 'NEUMO TBC - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '37', 1, 'PARTICULAR', 10, 1),
(204, 'ACP-2022-000204', '2022-05-20', '2044477', '2038447', '1254294', 1, '1997-02-05', 'DNI', '75343668', 'CAMPOS', 'VARGAS', 'JACKELINE BELAMIN', '2022-04-23', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '25', 2, 'PARTICULAR', 10, 1),
(205, 'ACP-2022-000205', '2022-05-20', '2034863', '2028833', '432973', 1, '1954-04-16', 'DNI', '10404355', 'SAAVEDRA', 'GONZALES', 'LILIA ', '2022-04-08', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '68', 2, 'PARTICULAR', 10, 1),
(206, 'ACP-2022-000206', '2022-05-20', '2060915', '2054888', '1140786', 1, '1961-08-20', 'DNI', '06010157', 'VELASQUEZ', 'VELASQUEZ', 'JOSE LUIS', '2022-06-04', 'ENDOCRINOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'LIMA', '61', 1, 'SIS', 10, 1),
(207, 'ACP-2022-000207', '2022-05-20', '2034689', '2028659', '1362369', 1, '2002-12-07', 'DIE', '29801651', 'FERNANDEZ', 'TORO', 'JHON FRANK', '2022-04-14', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'COMAS', '20', 1, 'PARTICULAR', 10, 1),
(208, 'ACP-2022-000208', '2022-05-20', '2035135', '2029105', '1331154', 1, '2002-07-21', 'DNI', '71894276', 'DIAZ', 'GOMEZ', 'JOSUE ANTONIO', '2022-04-09', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '20', 1, 'PARTICULAR', 10, 1);
INSERT INTO `psyem_atencion` (`idAtencion`, `correlativo_Atencion`, `fRegistroAtencion`, `idEpisodio`, `cuentaAtencion`, `historiaAtencion`, `idEstadoPacAtencion`, `fechaPacNacimiento`, `tipdocAtencion`, `nrodocAtencion`, `apPaternoAtencion`, `apMaternoAtencion`, `nombAtencion`, `fIngresoAtencion`, `servAtencion`, `camaAtencion`, `distritoAtencion`, `edadAtencion`, `tipSexoAtencion`, `financiaAtencion`, `idURegAtencion`, `idEstadoAte`) VALUES
(209, 'ACP-2022-000209', '2022-05-20', '2036945', '2030914', '1035471', 1, '2000-05-18', 'DNI', '74793943', 'CASTILLO', 'ACUÑA', 'ESTELA REYNALDA', '2022-04-12', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'COMAS', '22', 2, 'PARTICULAR', 10, 1),
(210, 'ACP-2022-000210', '2022-05-20', '2055677', '2049646', '923265', 1, '1959-05-07', 'DNI', '02529800', 'YANAPA', 'DE CALSINA', 'DOMITILA ', '2022-06-01', 'UROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '63', 2, 'SIS', 10, 1),
(211, 'ACP-2022-000211', '2022-05-20', '2036946', '2030915', '1361738', 1, '1961-02-15', 'DNI', '06893425', 'PAZOS', 'MORANTE', 'JUAN ALBERTO', '2022-04-12', 'MEDICINA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '61', 1, 'PARTICULAR', 10, 1),
(212, 'ACP-2022-000212', '2022-05-20', '2057415', '2051384', '900787', 1, '1966-07-08', 'DNI', '06830655', 'VALENCIA', 'ARTICA', 'LUIS FELIPE', '2022-05-11', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '56', 1, 'PARTICULAR', 10, 1),
(213, 'ACP-2022-000213', '2022-05-20', '2043504', '2037474', '1143788', 1, '1995-09-24', 'DNI', '77706847', 'SIAS', 'DEL AGUILA', 'JHOMIRA ESTHER', '2022-05-18', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '27', 2, 'SIS', 10, 1),
(214, 'ACP-2022-000214', '2022-05-20', '2038069', '2032038', '518527', 1, '1980-09-06', 'DNI', '42122668', 'VILCHEZ', 'VELASQUEZ', 'PAULO CESAR', '2022-04-16', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'COMAS', '42', 1, 'PARTICULAR', 10, 1),
(215, 'ACP-2022-000215', '2022-05-20', '2038545', '2032514', '1092673', 1, '1946-11-08', 'DNI', '06912180', 'AYRAS', 'QUISPE', 'EMPERATRIZ ESMERALDA', '2022-04-19', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '76', 2, 'PARTICULAR', 10, 1),
(216, 'ACP-2022-000216', '2022-05-20', '2038645', '2032614', '1363131', 1, '2005-03-30', 'DIE', '004192047', 'HUERTA', 'GONZALEZ', 'ANA VERONICA', '2022-04-16', 'MEDICINA TOPICO - EMERGENCIA', '', 'LOS OLIVOS', '17', 2, 'PARTICULAR', 10, 1),
(217, 'ACP-2022-000217', '2022-05-20', '2038792', '2032761', '1363167', 1, '1987-08-13', 'DNI', '45195137', 'CHAVEZ', 'FLORES', 'DIANA SHIRLEY', '2022-04-20', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '35', 2, 'PARTICULAR', 10, 1),
(218, 'ACP-2022-000218', '2022-05-20', '2040159', '2034128', '1363309', 1, '2003-08-16', 'DNI', '75883875', 'MORENO', 'TAPIA', 'MARISOL AMELIA', '2022-04-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '19', 2, 'PARTICULAR', 10, 1),
(219, 'ACP-2022-000219', '2022-05-20', '2038518', '2032487', '968758', 1, '1954-02-18', 'DNI', '06952313', 'RAMOS', 'VILLON', 'MAXIMO CLAUDIO', '2022-05-04', 'ENDOCRINOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '68', 1, 'SIS', 10, 1),
(220, 'ACP-2022-000220', '2022-05-20', '2039167', '2033136', '1363226', 1, '1990-11-11', 'DNI', '47097253', 'MUERAS', 'ESTRELLA', 'IRIS LUZ', '2022-04-19', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '32', 2, 'PARTICULAR', 10, 1),
(221, 'ACP-2022-000221', '2022-05-20', '2033172', '2027142', '282852', 1, '1968-01-01', 'DNI', '09735076', 'SANCHEZ', 'PECHE', 'EDGARD ', '2022-04-21', 'ENDOCRINOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '54', 1, 'SIS', 10, 1),
(222, 'ACP-2022-000222', '2022-05-20', '2048359', '2042329', '1086755', 1, '1960-06-12', 'DNI', '06949406', 'TEJADA', 'PINEDA', 'MARCO ANTONIO', '2022-05-18', 'CARDIOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '62', 1, 'SIS', 10, 1),
(223, 'ACP-2022-000223', '2022-05-20', '2040963', '2034933', '363559', 1, '1991-11-09', 'DNI', '48206670', 'MELO', 'CALDERON', 'TANIA LIZBETH', '2022-04-22', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '31', 2, 'PARTICULAR', 10, 1),
(224, 'ACP-2022-000224', '2022-05-20', '2039804', '2033773', '775482', 1, '1978-10-22', 'DNI', '47977900', 'ACUÑA', 'AGUIRRE', 'MARIO ', '2022-04-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '44', 1, 'PARTICULAR', 10, 1),
(225, 'ACP-2022-000225', '2022-05-20', '2041086', '2035056', '1360565', 1, '1972-05-06', 'DNI', '15727205', 'CASTILLO', 'RODRIGUEZ', 'LUZ MARIA', '2022-04-21', 'NEUMO TBC - HOSPITALIZACIÓN ', '', 'HUACHO', '50', 2, 'PARTICULAR', 10, 1),
(226, 'ACP-2022-000226', '2022-05-20', '2040820', '2034789', '1292653', 1, '1946-05-13', 'DNI', '06948785', 'QUISPE', 'MEZA', 'JUAN PEDRO', '2022-04-19', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '76', 1, 'PARTICULAR', 10, 1),
(227, 'ACP-2022-000227', '2022-05-20', '2061302', '2055275', '541095', 2, '1981-07-23', 'DNI', '42267666', 'MITA', 'BALAREZO', 'MARIA SUSANA', '2022-05-17', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'COMAS', '41', 2, 'PARTICULAR', 12, 1),
(228, 'ACP-2022-000228', '2022-05-20', '2062404', '2056377', '1120506', 2, '1956-11-09', 'DNI', '09466733', 'TERRONES', 'CULQUI', 'MARIA ANTONIETA', '2022-05-19', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '66', 2, 'PARTICULAR', 12, 1),
(229, 'ACP-2022-000229', '2022-05-20', '2060896', '2054869', '1366082', 1, '1989-06-09', 'DNI', '46101393', 'CASHPA', 'CORPUS', 'FERNANDO WALTER', '2022-05-17', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '33', 1, 'PARTICULAR', 12, 1),
(230, 'ACP-2022-000230', '2022-05-20', '2061469', '2055442', '533915', 1, '1981-03-20', 'DNI', '43772459', 'ROMERO', 'HERNANDEZ', 'ERIKA CECILIA', '2022-05-18', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '41', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(231, 'ACP-2022-000231', '2022-05-20', '2062268', '2056241', '1366272', 2, '1977-07-19', 'DNI', '80554439', 'CANGO', 'ORMEÑO', 'BETTY DEL', '2022-05-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '45', 2, 'PARTICULAR', 12, 1),
(232, 'ACP-2022-000232', '2022-05-20', '2061827', '2055800', '116414', 1, '1976-06-07', 'DNI', '40509684', 'BASURTO', 'GONZALES', 'LUIS ALBERTO', '2022-05-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 12, 1),
(233, 'ACP-2022-000233', '2022-05-20', '2059413', '2053386', '1226672', 1, '1956-06-03', 'DNI', '07422102', 'ÑACARI', 'ANAYA', 'JACINTO ', '2022-05-14', 'TRAUMA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '66', 1, 'PARTICULAR', 12, 1),
(234, 'ACP-2022-000234', '2022-05-20', '2062380', '2056353', '1051758', 1, '1950-05-05', 'DNI', '06926033', 'SANCHEZ', 'MORA', 'JOSE ANTONIO', '2022-05-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '72', 1, 'PARTICULAR', 12, 1),
(235, 'ACP-2022-000235', '2022-05-20', '2063166', '2057139', '1366423', 1, '1934-02-23', 'DNI', '06461265', 'ROJAS', 'AGUIRRE DE MEYER', 'LIRA EDADIL', '2022-05-19', 'CIRUGIA TOPICO - EMERGENCIA', '', 'LOS OLIVOS', '88', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(236, 'ACP-2022-000236', '2022-05-20', '2062895', '2056868', '1366368', 1, '1993-04-21', 'DNI', '48778545', 'TORRES', 'MARTOS', 'SEGUNDO ROSARIO', '2022-05-19', 'TRAUMA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '29', 1, 'PARTICULAR', 12, 1),
(237, 'ACP-2022-000237', '2022-05-20', '2063176', '2057149', '570796', 1, '1963-02-28', 'DNI', '25400981', 'VARGAS', 'GUTIERREZ', 'LUISA ', '2022-05-19', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '59', 2, 'PARTICULAR', 12, 1),
(238, 'ACP-2022-000238', '2022-05-20', '2062133', '2056106', '1135277', 1, '1976-02-03', 'DNI', '80506006', 'GUERRA', 'GONZALES', 'LUIS ANTONIO', '2022-05-18', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 12, 1),
(239, 'ACP-2022-000239', '2022-05-21', '2041144', '2035114', '1363433', 1, '1998-05-02', 'DNI', '70247990', 'GUADAMUR', 'QUISPE', 'LUZ CLARITA', '2022-04-24', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '24', 2, 'PARTICULAR', 10, 1),
(240, 'ACP-2022-000240', '2022-05-21', '2050161', '2044131', '1204487', 1, '1998-05-17', 'DNI', '61713363', 'QUIROZ', 'LOZANO', 'MABEL ALEJANDRINA', '2022-05-01', 'PRIORIDAD III-URGENCIA - EMERGENCIA', '', 'COMAS', '24', 2, 'PARTICULAR', 10, 1),
(241, 'ACP-2022-000241', '2022-05-21', '2042211', '2036181', '1362790', 1, '1989-01-12', 'DNI', '47514773', 'ARONI', 'VASQUEZ', 'MONICA BETZABELL', '2022-04-25', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '33', 2, 'PARTICULAR', 10, 1),
(242, 'ACP-2022-000242', '2022-05-21', '2044187', '2038157', '429267', 1, '1995-03-20', 'DNI', '70168307', 'HERRERA', 'ARAUJO', 'JEAN PIERR', '2022-05-20', 'NEUMOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '27', 1, 'SIS', 10, 1),
(243, 'ACP-2022-000243', '2022-05-21', '2043067', '2037037', '1142184', 1, '1973-01-31', 'DNI', '09925955', 'YOSHITOMI', 'CASTILLO', 'MARCOS ANTONIO', '2022-04-21', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '49', 1, 'PARTICULAR', 10, 1),
(244, 'ACP-2022-000244', '2022-05-21', '2041310', '2035280', '689341', 1, '1954-12-01', 'DNI', '10290532', 'PEREZ', 'VERA', 'ANDRES CONSTANCIO', '2022-05-04', 'CARDIOLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'COMAS', '68', 1, 'SIS', 10, 1),
(245, 'ACP-2022-000245', '2022-05-21', '2043754', '2037724', '195066', 1, '1981-06-29', 'DNI', '40944014', 'CHUMPITAZ', 'QUISPE', 'SOLEDAD TERESA', '2022-05-30', 'ALTO RIESGO - 2 - CONSULTORIOS EXTERNOS', '', 'COMAS', '41', 2, 'SIS', 10, 1),
(246, 'ACP-2022-000246', '2022-05-21', '2060331', '2054304', '883294', 1, '1976-06-12', 'DNI', '09865068', 'CARHUAPOMA', 'RAMOS', 'YOLANDA ', '2022-06-02', 'ENDOCRINOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '46', 2, 'SIS', 10, 1),
(247, 'ACP-2022-000247', '2022-05-21', '2058179', '2052148', '720058', 1, '1998-02-03', 'DNI', '75093045', 'MALLQUI', 'MANTARI', 'ALEXANDER ARMANDO', '2022-05-13', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '24', 1, 'PARTICULAR', 10, 1),
(248, 'ACP-2022-000248', '2022-05-21', '2061754', '2055727', '967489', 1, '1950-08-18', 'DNI', '20711196', 'GUILLERMO', 'CHUQUICHAICO', 'ANANIAS LAURO', '2022-06-04', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '72', 1, 'SIS', 10, 1),
(249, 'ACP-2022-000249', '2022-05-21', '2063277', '2057250', '1363937', 1, '1970-08-03', 'DNI', '15282857', 'BERASTIGUE', 'SOTO', 'ESTEBAN PEDRO', '2022-05-23', 'REHABILITACION - 3 - CONSULTORIOS EXTERNOS', '', 'CANTA', '52', 1, 'SIS', 10, 1),
(250, 'ACP-2022-000250', '2022-05-21', '2047852', '2041822', '1125552', 1, '1988-07-18', 'DNI', '45669999', 'CERVANTES', 'GONZALES', 'ROSSALINA CHERILYN', '2022-04-28', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '34', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(251, 'ACP-2022-000251', '2022-05-21', '2047765', '2041735', '1364206', 1, '1951-04-24', 'DNI', '09173156', 'GALVAN', 'SILVA', 'ALICIA ', '2022-05-01', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '71', 2, 'PARTICULAR', 10, 1),
(252, 'ACP-2022-000252', '2022-05-21', '2052691', '2046661', '1363034', 1, '1940-01-24', 'DNI', '07745439', 'MOORE', 'SANCHEZ', 'MARIA SANTOS', '2022-05-05', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '82', 2, 'PARTICULAR', 10, 1),
(253, 'ACP-2022-000253', '2022-05-21', '2049712', '2043682', '1364435', 1, '1999-03-03', 'DIE', '26507999', 'HERRERA', 'GIL', 'JACKSON SMIH', '2022-04-30', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '23', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(254, 'ACP-2022-000254', '2022-05-22', '2062570', '2056543', '1330186', 1, '1969-07-14', 'DNI', '09747024', 'MAMANI', 'LAURA', 'JOSÉ LUIS', '2022-05-19', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '53', 1, 'PARTICULAR', 10, 1),
(255, 'ACP-2022-000255', '2022-05-22', '2048347', '2042317', '77536', 1, '1975-03-04', 'DNI', '10390874', 'CORNEJO', 'SANCHEZ', 'CARLOS EFRAIN', '2022-04-28', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '47', 1, 'PARTICULAR', 10, 1),
(256, 'ACP-2022-000256', '2022-05-22', '2052657', '2046627', '1026055', 1, '1985-04-24', 'DNI', '42928897', 'FLORES', 'UTIA', 'LILA ', '2022-05-04', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '37', 2, 'PARTICULAR', 10, 1),
(257, 'ACP-2022-000257', '2022-05-22', '2050966', '2044936', '193427', 1, '1947-07-28', 'DNI', '06908130', 'VILCATOMA', 'PICHARDO DE GOMEZ', 'IGNACIA ', '2022-05-03', 'SOP TRAUMATOLOGIA - HOSPITALIZACIÓN ', '', 'COMAS', '75', 2, 'PARTICULAR', 10, 1),
(258, 'ACP-2022-000258', '2022-05-22', '2056858', '2050827', '1364685', 1, '1942-10-29', 'DNI', '19961217', 'LIMAYLLA', 'LEON', 'ABRAHAM RAUL', '2022-05-25', 'CARDIOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '80', 1, 'SIS', 10, 1),
(259, 'ACP-2022-000259', '2022-05-22', '2061427', '2055400', '87893', 1, '1938-07-09', 'DNI', '06826923', 'VILLACORTA', 'REGALADO', 'JULIO ', '2022-05-17', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '84', 1, 'PARTICULAR', 10, 1),
(260, 'ACP-2022-000260', '2022-05-22', '2053783', '2047752', '325209', 1, '1988-08-18', 'DNI', '70112917', 'LUIS', 'VALDIVIESO', 'EDWIN BRIAN', '2022-05-07', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'COMAS', '34', 1, 'PARTICULAR', 10, 1),
(261, 'ACP-2022-000261', '2022-05-22', '2053940', '2047909', '240764', 1, '1937-03-01', 'DNI', '06957685', 'RAMON', 'CUBAS', 'ROSENDO ', '2022-05-10', 'MEDICINA VARONES - HOSPITALIZACIÓN ', '', 'COMAS', '85', 1, 'PARTICULAR', 10, 1),
(262, 'ACP-2022-000262', '2022-05-22', '2053494', '2047463', '1364246', 1, '2000-02-02', 'DNI', '74021381', 'BARREDA', 'PACHECO', 'NADIA NICOL', '2022-05-07', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '22', 2, 'PARTICULAR', 10, 1),
(263, 'ACP-2022-000263', '2022-05-22', '2052898', '2046868', '1325305', 1, '1951-07-22', 'DNI', '23212178', 'APONTE', 'QUINTO', 'PAULINO ', '2022-05-11', 'MEDICINA VARONES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '71', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(264, 'ACP-2022-000264', '2022-05-22', '2054211', '2048180', '781211', 1, '1970-12-10', 'DNI', '09552054', 'RAMIREZ', 'RIOS', 'JOSE MARTIN', '2022-05-06', 'TRAUMA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '52', 1, 'PARTICULAR', 10, 1),
(265, 'ACP-2022-000265', '2022-05-22', '2054162', '2048131', '882477', 1, '1963-10-07', 'DNI', '06863989', 'ZUBILETE', 'DOMINGUEZ', 'SERGIO ', '2022-05-12', 'NEUMO NO TBC - HOSPITALIZACIÓN ', '', 'COMAS', '59', 1, 'PARTICULAR', 10, 1),
(266, 'ACP-2022-000266', '2022-05-22', '2053618', '2047587', '866510', 1, '1974-06-20', 'DNI', '10694283', 'FARFAN', 'CONDORI', 'SILVIA ', '2022-05-30', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '48', 2, 'SIS', 10, 1),
(267, 'ACP-2022-000267', '2022-05-22', '2014795', '2008754', '659811', 1, '1983-07-25', 'DNI', '48612846', 'OJEDA', 'VILLANUEVA', 'FREDDY ', '2022-03-06', 'CIRUGIA TOPICO - EMERGENCIA', '', 'LOS OLIVOS', '39', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(268, 'ACP-2022-000268', '2022-05-24', '2063835', '2057808', '685381', 2, '1981-12-24', 'DNI', '41333772', 'CASTRO', 'SOLIS', 'RAUL ', '2022-05-20', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '41', 1, 'PARTICULAR', 12, 1),
(269, 'ACP-2022-000269', '2022-05-24', '2060632', '2054605', '1366049', 1, '1988-12-01', 'DNI', '45435311', 'MENACHO', 'COLACHAGUA', 'MIGUEL ANGEL', '2022-05-17', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '34', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(270, 'ACP-2022-000270', '2022-05-24', '2064210', '2058183', '609488', 1, '1987-05-01', 'DNI', '44280094', 'MITMA', 'ORTIZ', 'YOSSELIN BRENDA', '2022-05-22', 'OBSTETRICIA ARO 1 - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '35', 2, 'PARTICULAR', 12, 1),
(271, 'ACP-2022-000271', '2022-05-24', '2063152', '2057125', '722211', 1, '1958-07-28', 'DNI', '15282369', 'SOSA', 'VELDES', 'F. FAUSTINO', '2022-05-19', 'CIRUGIA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '64', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(272, 'ACP-2022-000272', '2022-05-24', '2064472', '2058445', '1366657', 1, '1981-02-12', 'DIE', '', 'GIMENEZ', 'RAMOS', 'YOANA LIZBETH', '2022-05-22', 'TRAUMA TOPICO - EMERGENCIA', '', 'LOS OLIVOS', '41', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(273, 'ACP-2022-000273', '2022-05-24', '2063231', '2057204', '865901', 1, '1957-12-09', 'DNI', '09028643', 'CABALLERO', 'PAZ', 'JORGE ALFREDO', '2022-05-24', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '65', 1, 'PARTICULAR', 12, 1),
(274, 'ACP-2022-000274', '2022-05-24', '2064646', '2058619', '536351', 1, '1967-04-20', 'DNI', '09402511', 'COCHAS', 'LOZANO', 'EDIT CELIA', '2022-05-22', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '55', 2, 'PARTICULAR', 12, 1),
(275, 'ACP-2022-000275', '2022-05-24', '2065647', '2059620', '303732', 1, '1962-07-15', 'DNI', '06949875', 'LUGO', 'MAGUIÑA', 'DANTE CARLOS', '2022-05-23', 'TRAUMA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 12, 1),
(276, 'ACP-2022-000276', '2022-05-25', '2066142', '2060115', '845762', 1, '1987-03-20', 'DNI', '44728914', 'DE LAMA', 'DONAYRE', 'CINTIA RENEE', '2022-05-25', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '35', 2, 'PARTICULAR', 12, 1),
(277, 'ACP-2022-000277', '2022-05-25', '2066195', '2060168', '1335521', 1, '1982-09-14', 'DNI', '45190850', 'CASTILLO', 'ORO', 'MARTHA MAGDALENA', '2022-05-24', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '40', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(278, 'ACP-2022-000278', '2022-05-25', '2066380', '2060353', '1366660', 1, '1967-04-03', 'DNI', '08665289', 'VEGA', 'IZQUIERDO', 'WENCESLAO RICARDO', '2022-05-24', 'MEDICINA TOPICO - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '55', 1, 'PARTICULAR', 12, 1),
(279, 'ACP-2022-000279', '2022-05-25', '2063439', '2057412', '1366466', 1, '1994-10-29', 'DNI', '48606448', 'MEDICO', 'TOMAS', 'OMER ', '2022-05-25', 'MEDICINA INTERNA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '28', 1, 'SIS', 12, 1),
(280, 'ACP-2022-000280', '2022-05-25', '2066716', '2060689', '1366921', 1, '1953-11-10', 'DNI', '07119130', 'BRITO', 'TUANAMA', 'NANCY MARIA', '2022-05-24', 'CORONAVIRUS - EMERGENCIA', '', 'RIMAC', '69', 2, 'PARTICULAR', 12, 1),
(281, 'ACP-2022-000281', '2022-05-27', '2066830', '2060803', '453742', 1, '1945-08-23', 'DNI', '06227711', 'CASTILLO', 'FAJARDO DE ROLDAN', 'CARMEN ', '2022-05-25', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '77', 2, 'PARTICULAR', 12, 1),
(282, 'ACP-2022-000282', '2022-05-27', '2067541', '2061514', '1035568', 2, '1940-01-27', 'DNI', '06820893', 'PANDURO', 'DIAZ', 'DENIS ', '2022-05-25', 'MEDICINA TOPICO - EMERGENCIA', '', 'CARABAYLLO', '82', 1, 'PARTICULAR', 12, 1),
(283, 'ACP-2022-000283', '2022-05-27', '2068633', '2062606', '816042', 1, '1975-02-06', 'DNI', '40077725', 'GUERRERO', 'JOLKEDA', 'ROBERTO JUAN', '2022-06-09', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '47', 1, 'SIS', 12, 1),
(284, 'ACP-2022-000284', '2022-05-27', '2067186', '2061159', '348771', 1, '1942-02-07', 'DNI', '08038972', 'GARCIA', 'GUERRA DE RAMIREZ', 'TELMA ', '2022-05-25', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '80', 2, 'PARTICULAR', 12, 1),
(285, 'ACP-2022-000285', '2022-05-27', '2068808', '2062781', '714586', 1, '2005-06-11', 'DNI', '62603405', 'TAMAYO', 'PONCE', 'ROSA ISELA', '2022-05-26', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '17', 2, 'PARTICULAR', 12, 1),
(286, 'ACP-2022-000286', '2022-05-27', '2069033', '2063006', '1367075', 1, '1954-10-29', 'DNI', '06951697', 'NICHO', 'VARGAS', 'MIRIAM ESTHER', '2022-05-26', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '68', 2, 'PARTICULAR', 12, 1),
(287, 'ACP-2022-000287', '2022-05-27', '2066467', '2060440', '200132', 1, '1949-08-03', 'DNI', '06948841', 'ESPINOZA', 'DE SANCHEZ', 'ROSA ', '2022-05-24', 'MEDICINA TOPICO - EMERGENCIA', '', 'COMAS', '73', 2, 'PARTICULAR', 12, 1),
(288, 'ACP-2022-000288', '2022-05-27', '2067856', '2061829', '246033', 1, '1959-10-09', 'DNI', '09227050', 'HUAYANAY', 'GARAY', 'ALBERTO MARCELINO', '2022-05-25', 'CIRUGIA TOPICO - EMERGENCIA', '', 'COMAS', '63', 1, 'PARTICULAR', 12, 1),
(289, 'ACP-2022-000289', '2022-05-30', '2070783', '2064756', '626186', 1, '2002-11-27', 'DNI', '70955868', 'HUANGAL', 'FLORES', 'MARGARITA NICOLE', '2022-05-29', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '20', 2, 'PARTICULAR', 12, 1),
(290, 'ACP-2022-000290', '2022-05-30', '2069053', '2063026', '267233', 1, '1950-10-18', 'DNI', '09531272', 'RAMOS', 'MARQUEZ', 'NESTOR ', '2022-05-26', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '72', 1, 'SOAT', 12, 1),
(291, 'ACP-2022-000291', '2022-05-30', '2069631', '2063604', '718161', 1, '1955-01-01', 'DNI', '08254150', 'PILLACA', 'QUISPE', 'MAXIMO ', '2022-05-27', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '67', 1, 'PARTICULAR', 12, 1),
(292, 'ACP-2022-000292', '2022-05-30', '2069950', '2063923', '717921', 1, '2002-10-12', 'DNI', '72994597', 'ALCEDO', 'TAPIA', 'MAURICIO ALEXANDER', '2022-05-28', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '20', 1, 'PARTICULAR', 12, 1),
(293, 'ACP-2022-000293', '2022-05-30', '2069870', '2063843', '337140', 2, '1983-09-13', 'DNI', '42015773', 'RUIZ', 'GAMERO', 'PEDRO ', '2022-05-27', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'COMAS', '39', 1, 'PARTICULAR', 12, 1),
(294, 'ACP-2022-000294', '2022-05-30', '2069335', '2063308', '1299205', 2, '1964-10-17', 'DNI', '09031005', 'INGA', 'MENDEZ', 'LILIANA ROSARIO', '2022-05-27', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '58', 2, 'PARTICULAR', 12, 1),
(295, 'ACP-2022-000295', '2022-05-30', '2070825', '2064798', '1256151', 1, '2000-03-25', 'DNI', '76196654', 'SALVATIERRA', 'SUPO', 'ANA CRISTINA', '2022-05-29', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '22', 2, 'PARTICULAR', 12, 1),
(296, 'ACP-2022-000296', '2022-05-30', '2069899', '2063872', '1367242', 1, '1950-09-03', 'DNI', '07043244', 'URIBE', 'RIVERA', 'ELVIRA ', '2022-05-30', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'COMAS', '72', 2, 'PARTICULAR', 12, 1),
(297, 'ACP-2022-000297', '2022-05-30', '2070799', '2064772', '428340', 1, '1943-12-13', 'DNI', '32266604', 'ORTIZ', 'JARA', 'ANTONIO ', '2022-05-29', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '79', 1, 'PARTICULAR', 12, 1),
(298, 'ACP-2022-000298', '2022-05-30', '2070874', '2064847', '1157823', 1, '1930-08-02', 'DNI', '48862594', 'REYES', 'ROJAS', 'ARCENIA ', '2022-05-29', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '92', 2, 'PARTICULAR', 12, 1),
(299, 'ACP-2022-000299', '2022-05-30', '2070718', '2064691', '1367390', 1, '1976-09-09', 'DNI', '10368533', 'SOLORZANO', 'ALFARO DE CALDERON', 'MARY LUZ', '2022-05-29', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'VEGUETA', '46', 2, 'PARTICULAR', 12, 1),
(300, 'ACP-2022-000300', '2022-06-09', '2071878', '2065851', '1367552', 1, '1962-01-20', 'DNI', '32883674', 'ACERO', 'AYALA', 'HONORATO ', '2022-05-30', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'SAMANCO', '60', 1, 'PARTICULAR', 10, 1),
(301, 'ACP-2022-000301', '2022-06-09', '2075532', '2069505', '1367937', 1, '2006-05-11', 'DNI', '76488050', 'BURGOS', 'REYES', 'DAVID BRANDON', '2022-06-03', 'TOPICO TRAUMA - EMERGENCIA', '', 'COMAS', '16', 1, 'PARTICULAR', 10, 1),
(302, 'ACP-2022-000302', '2022-06-09', '2076537', '2070510', '1368089', 1, '2000-11-24', 'DNI', '76747462', 'LEON', 'ROMERO', 'DYLAN LUCA', '2022-06-05', 'TOPICO CIRUGIA - EMERGENCIA', '', 'LOS OLIVOS', '22', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(303, 'ACP-2022-000303', '2022-06-09', '2078019', '2071992', '39096', 1, '1954-02-13', 'DNI', '06126558', 'ALZAMORA', 'LOPEZ', 'BENEDICTO ', '2022-06-07', 'TOPICO TRAUMA - EMERGENCIA', '', 'COMAS', '68', 1, 'PARTICULAR', 10, 1),
(304, 'ACP-2022-000304', '2022-06-09', '2074317', '2068290', '1085083', 1, '1990-12-13', 'DNI', '46897391', 'FLORES', 'SALAS', 'JOSUE JULIO', '2022-06-02', 'TOPICO CIRUGIA - EMERGENCIA', '', 'COMAS', '32', 1, 'PARTICULAR', 10, 1),
(305, 'ACP-2022-000305', '2022-06-11', '2079179', '2073153', '237093', 1, '1958-03-22', 'DNI', '06875549', 'TORRES', 'ALVARADO', 'DAVID ', '2022-06-08', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '64', 1, 'PARTICULAR', 10, 1),
(306, 'ACP-2022-000306', '2022-06-11', '2078438', '2072412', '1273304', 2, '1962-08-01', 'DNI', '10411697', 'CABELLO', 'GIRALDO', 'JUAN ANDRES', '2022-06-07', 'TOPICO MEDICINA - EMERGENCIA', '', 'PUENTE PIEDRA', '60', 1, 'PARTICULAR', 10, 1),
(307, 'ACP-2022-000307', '2022-06-11', '2079239', '2073213', '1285169', 2, '1983-08-28', 'CE', '000721504', 'USECHE', 'SOLORZANO', 'CARLOS ALFONSO', '2022-06-08', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '39', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(308, 'ACP-2022-000308', '2022-06-11', '2081180', '2075154', '56765', 1, '1943-09-01', 'DNI', '06903613', 'SANCHEZ', 'CARRION', 'FELIX AUGUSTO', '2022-06-21', 'GASTROENTEROLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'COMAS', '79', 1, 'SIS', 10, 1),
(309, 'ACP-2022-000309', '2022-06-11', '2080160', '2074134', '733674', 2, '2005-12-20', 'DNI', '77250397', 'DEZA', 'RAMOS', 'GENESIS YAHAIRA', '2022-06-09', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '17', 2, 'PARTICULAR', 10, 1),
(310, 'ACP-2022-000310', '2022-06-11', '2080174', '2074148', '1368576', 2, '2002-09-18', 'DNI', '71939952', 'YALI', 'VASQUEZ', 'DANIEL OBED', '2022-06-09', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '20', 1, 'PARTICULAR', 10, 1),
(311, 'ACP-2022-000311', '2022-06-11', '2080144', '2074118', '1202917', 1, '1985-11-20', 'DNI', '43731744', 'INGA', 'TANANTA', 'MARIA ESTHER', '2022-06-10', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '37', 2, 'PARTICULAR', 10, 1),
(312, 'ACP-2022-000312', '2022-06-11', '2078490', '2072464', '921919', 1, '1961-01-14', 'DNI', '08244346', 'VASQUEZ', 'CAMPOS', 'HILDEBRANDO ', '2022-06-08', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '61', 1, 'PARTICULAR', 10, 1),
(313, 'ACP-2022-000313', '2022-06-11', '2079392', '2073366', '1367663', 1, '2004-06-03', 'DNI', '73542245', 'SANDOVAL', 'COLLANTES', 'OMAR DEL', '2022-06-08', 'TOPICO TRAUMA - EMERGENCIA', '', 'COMAS', '18', 1, 'PARTICULAR', 10, 1),
(314, 'ACP-2022-000314', '2022-06-11', '2079413', '2073387', '425125', 2, '1956-02-11', 'DNI', '06877549', 'VEGA', 'GOMEZ', 'LOURDES WALDETRUDIS', '2022-06-09', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '66', 2, 'PARTICULAR', 10, 1),
(315, 'ACP-2022-000315', '2022-06-11', '2080941', '2074915', '1142494', 1, '1978-10-13', 'DNI', '40029877', 'MOLINA', 'PAREDES', 'CAROLINA ', '2022-06-10', 'TOPICO CIRUGIA - EMERGENCIA', '', 'COMAS', '44', 2, 'PARTICULAR', 10, 1),
(316, 'ACP-2022-000316', '2022-06-11', '2080156', '2074130', '1368569', 1, '1968-09-09', 'DNI', '08128812', 'CABALLERO', 'ACOSTA', 'JULIO RICARDO', '2022-06-09', 'TOPICO CIRUGIA - EMERGENCIA', '', 'SAN JUAN DE LURIGANCHO', '54', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(317, 'ACP-2022-000317', '2022-06-11', '2080950', '2074924', '1207034', 1, '2000-10-21', 'DNI', '75137911', 'ALVITES', 'VASQUEZ', 'JESUS EDUARDO', '2022-06-10', 'TOPICO CIRUGIA - EMERGENCIA', '', 'COMAS', '22', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(318, 'ACP-2022-000318', '2022-06-11', '2077394', '2071367', '1368178', 1, '1966-02-22', 'DNI', '08917055', 'CAYCHO', 'TRIBIÑOS', 'JAVIER RICARDO', '2022-06-06', 'TOPICO CIRUGIA - EMERGENCIA', '', 'VILLA EL SALVADOR', '56', 1, 'PARTICULAR', 10, 1),
(319, 'ACP-2022-000319', '2022-06-14', '2076508', '2070481', '1368078', 1, '1966-06-09', 'DNI', '08116880', 'ENCISO', 'BRAVO', 'MIGUEL ANGEL', '2022-06-13', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '56', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(320, 'ACP-2022-000320', '2022-06-14', '2077674', '2071647', '753625', 2, '1984-08-14', 'DNI', '43498658', 'SOLIS', 'AGUILAR', 'NESTOR MARTIN', '2022-06-07', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '38', 1, 'PARTICULAR', 10, 1),
(321, 'ACP-2022-000321', '2022-06-14', '2082030', '2076004', '1368858', 2, '1971-07-15', 'DNI', '16679650', 'MIMBELA', 'LARREA', 'CARLOS MARTIN', '2022-06-13', 'TOPICO CIRUGIA - EMERGENCIA', '', 'LOS OLIVOS', '51', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(322, 'ACP-2022-000322', '2022-06-14', '2081815', '2075789', '345114', 1, '1990-10-02', 'DNI', '46998239', 'ALBURQUEQUE', 'OLIVERA', 'MARTHA CRISTEL', '2022-06-12', 'TOPICO TRAUMA - EMERGENCIA', '', 'CARABAYLLO', '32', 2, 'PARTICULAR', 10, 1),
(323, 'ACP-2022-000323', '2022-06-14', '2082872', '2076846', '1202535', 2, '1985-07-10', 'DNI', '43563550', 'GUEVARA', 'MAYTA', 'FRANCISCA ISABEL', '2022-06-14', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '37', 2, 'PARTICULAR', 10, 1),
(324, 'ACP-2022-000324', '2022-06-14', '2081782', '2075756', '271464', 1, '1956-02-24', 'DNI', '09978841', 'ESPINOZA', 'SOTO', 'PRIMITIVA ', '2022-06-12', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '66', 2, 'PARTICULAR', 10, 1),
(325, 'ACP-2022-000325', '2022-06-14', '2082182', '2076156', '1272711', 2, '1968-07-30', 'DNI', '09544132', 'MANYARI', 'SILUPU', 'MARIELA PATRICIA', '2022-06-13', 'TOPICO CIRUGIA - EMERGENCIA', '', 'CARABAYLLO', '54', 2, 'FONCO SOAT', 10, 1),
(326, 'ACP-2022-000326', '2022-06-14', '2081954', '2075928', '1368834', 2, '1996-01-18', 'DNI', '70164795', 'MELENDEZ', 'NAVARRO', 'YOMIRA BRIGITTE', '2022-06-12', 'TOPICO MEDICINA - EMERGENCIA', '', 'CHIMBOTE', '26', 2, 'PARTICULAR', 10, 1),
(327, 'ACP-2022-000327', '2022-06-14', '2083515', '2077489', '919603', 1, '1965-04-03', 'DNI', '01079285', 'ISUIZA', 'SANANCIMA', 'LUZ ', '2022-06-14', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '57', 2, 'PARTICULAR', 10, 1),
(328, 'ACP-2022-000328', '2022-06-14', '2081170', '2075144', '1368683', 1, '1948-03-10', 'DNI', '06932689', 'SHEEN', 'LEON', 'SEVERO FRANCISCO', '2022-06-11', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '74', 1, 'PARTICULAR', 10, 1),
(329, 'ACP-2022-000329', '2022-06-14', '2081870', '2075844', '487300', 1, '1990-09-20', 'DNI', '46764431', 'CALAGUA', 'RIVAS', 'JENNIFER FIORELLA', '2022-06-14', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '32', 2, 'PARTICULAR', 10, 1),
(330, 'ACP-2022-000330', '2022-06-15', '2083524', '2077498', '576615', 1, '1983-03-16', 'DNI', '41842344', 'BALTAZAR', 'CORDERO', 'ANA EVA', '2022-06-14', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '39', 2, 'PARTICULAR', 10, 1),
(331, 'ACP-2022-000331', '2022-06-15', '2083493', '2077467', '160045', 1, '1965-01-04', 'DNI', '06853646', 'RIOS', 'VASQUEZ', 'SEGUNDO MIGUEL', '2022-06-14', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '57', 1, 'PARTICULAR', 10, 1),
(332, 'ACP-2022-000332', '2022-06-15', '2083607', '2077581', '850630', 2, '1976-02-15', 'DNI', '09918412', 'TAMARIZ', 'RIVERA', 'JADE HILIANA', '2022-06-15', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '46', 2, 'PARTICULAR', 10, 1),
(333, 'ACP-2022-000333', '2022-06-15', '2081913', '2075887', '1135737', 1, '1967-04-22', 'DNI', '09030747', 'MURILLO', 'RODRIGUEZ', 'CHARO VICTORIA', '2022-06-12', 'TOPICO TRAUMA - EMERGENCIA', '', 'COMAS', '55', 2, 'PARTICULAR', 10, 1),
(334, 'ACP-2022-000334', '2022-06-15', '2083422', '2077396', '916928', 1, '2010-04-12', 'DNI', '74196903', 'MARIANO', 'CABEZAS', 'ANGELA LISET', '2022-06-14', 'TOPICO PEDIATRIA - EMERGENCIA', '', 'CARABAYLLO', '12', 2, 'PARTICULAR', 10, 1),
(335, 'ACP-2022-000335', '2022-06-16', '2081783', '2075757', '661216', 1, '1977-10-10', 'DNI', '40449586', 'MATOS', 'TORRES', 'TONY JAMY', '2022-06-12', 'TRAUMASHOCK ADULTO - EMERGENCIA', '', 'COMAS', '45', 1, 'PARTICULAR', 10, 1),
(336, 'ACP-2022-000336', '2022-06-16', '2083724', '2077698', '749821', 2, '1966-06-23', 'DNI', '06879104', 'MIO', 'MARIÑOS', 'FERNANDO ', '2022-06-15', 'TOPICO MEDICINA - EMERGENCIA', '', 'CAYALTI', '56', 1, 'PARTICULAR', 10, 1),
(337, 'ACP-2022-000337', '2022-06-20', '2086756', '2080730', '1369535', 1, '1992-05-19', 'DNI', '47000758', 'RONCAL', 'CHUQUIRUNA', 'ROSMEL EDUARDO', '2022-06-20', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '30', 1, 'PARTICULAR', 10, 1),
(338, 'ACP-2022-000338', '2022-06-20', '2085574', '2079548', '122025', 1, '1954-01-22', 'DNI', '10403624', 'SOTO', 'GRIJALVA', 'DORA LUS', '2022-06-17', 'TOPICO TRAUMA - EMERGENCIA', '', 'CARABAYLLO', '68', 2, 'PARTICULAR', 10, 1),
(339, 'ACP-2022-000339', '2022-06-20', '2086719', '2080693', '1369520', 1, '1990-05-01', 'DNI', '47312408', 'GONZALES', 'HUARANGA', 'JOAN ALEJANDRO', '2022-06-19', 'TOPICO CIRUGIA - EMERGENCIA', '', 'COMAS', '32', 1, 'PARTICULAR', 10, 1),
(340, 'ACP-2022-000340', '2022-06-20', '2084147', '2078121', '166539', 2, '1948-05-22', 'DNI', '06820172', 'MANTILLA', 'GALLARDO', 'FAUSTINO EMILIO', '2022-06-15', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '74', 1, 'PARTICULAR', 10, 1),
(341, 'ACP-2022-000341', '2022-06-20', '2083384', '2077358', '169494', 1, '1978-11-24', 'DNI', '45750301', 'ESPINOZA', 'NAVARRO', 'JORGE LEONARDO', '2022-06-14', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 10, 1),
(342, 'ACP-2022-000342', '2022-06-20', '2084292', '2078266', '109513', 1, '1970-05-22', 'DNI', '07469480', 'PANDO', 'URETA', 'JUAN JOSE', '2022-06-17', 'MEDICINA VARONES - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '52', 1, 'PARTICULAR', 10, 1),
(343, 'ACP-2022-000343', '2022-06-20', '2085208', '2079182', '887488', 1, '2009-07-28', 'DNI', '73566501', 'FLORES', 'ASENJO', 'WILLIAMS ALEXANDER', '2022-06-17', 'CIRUGIA PEDIATRICA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '13', 1, 'PARTICULAR', 10, 1),
(344, 'ACP-2022-000344', '2022-06-20', '2077172', '2071145', '1362994', 1, '1961-01-17', 'DNI', '09226357', 'PAZ', 'MERCADO', 'GUILLERMO ERNESTO', '2022-06-23', 'GASTROENTEROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '61', 1, 'SIS', 10, 1),
(345, 'ACP-2022-000345', '2022-06-20', '2085195', '2079169', '303038', 1, '1987-05-29', 'DNI', '47539828', 'ALLENDE', 'IGNACIO', 'JHON WILLIAM', '2022-06-16', 'TOPICO CIRUGIA - EMERGENCIA', '', 'COMAS', '35', 1, 'PARTICULAR', 10, 1),
(346, 'ACP-2022-000346', '2022-06-20', '2084798', '2078772', '1212211', 2, '1960-04-06', 'DNI', '06888539', 'HUACACHE', 'NUNJA', 'GERARDO RICARDO', '2022-06-16', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '62', 1, 'PARTICULAR', 10, 1),
(347, 'ACP-2022-000347', '2022-06-20', '2085998', '2079972', '1204708', 1, '1990-09-25', 'DNI', '47650883', 'TIRADO', 'MEDINA', 'GRACIELA NOEMI', '2022-06-18', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '32', 2, 'PARTICULAR', 10, 1),
(348, 'ACP-2022-000348', '2022-06-20', '2085506', '2079480', '238323', 1, '1966-03-17', 'DNI', '06939763', 'MEJIA', 'MEJIA', 'FERNANDO ROGER', '2022-06-17', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '56', 1, 'PARTICULAR', 10, 1),
(349, 'ACP-2022-000349', '2022-06-20', '2082844', '2076818', '1364184', 1, '1970-06-05', 'DNI', '09738504', 'MORALES', 'ALVARADO', 'MAX SILVIAN', '2022-06-14', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '52', 1, 'PARTICULAR', 10, 1),
(350, 'ACP-2022-000350', '2022-06-20', '2087410', '2081384', '1228717', 1, '1983-11-10', 'DNI', '42073493', 'TAMANI', 'MURAYARI', 'MITZI ', '2022-07-01', 'ENDOCRINOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '39', 2, 'SIS', 10, 1),
(351, 'ACP-2022-000351', '2022-06-20', '2086861', '2080835', '501386', 2, '1966-11-29', 'DNI', '31163780', 'ALLCCAHUAMAN', 'OSCCO', 'FILOMENO DEMETRIO', '2022-06-20', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '56', 1, 'PARTICULAR', 10, 1),
(352, 'ACP-2022-000352', '2022-06-21', '2083174', '2077148', '847134', 1, '1984-05-01', 'DNI', '42389374', 'PUELL', 'MENDOZA', 'NOEMI CAROLINA', '2022-06-15', 'NEUMOLOGIA 2 - CONSULTORIOS EXTERNOS', '', 'TUMBES', '38', 2, 'SIS', 10, 1),
(353, 'ACP-2022-000353', '2022-06-22', '2087631', '2081605', '1369624', 1, '1952-04-22', 'DNI', '07180403', 'MACEDO', 'CARO', 'CLAUDIO ', '2022-06-20', 'TOPICO MEDICINA - EMERGENCIA', '', 'VENTANILLA', '70', 1, 'PARTICULAR', 10, 1),
(354, 'ACP-2022-000354', '2022-06-22', '2087674', '2081648', '1369635', 1, '2002-09-01', 'DNI', '70912509', 'MAUTINO', 'SOLIS', 'VIERI STEVEN', '2022-06-21', 'TRAUMATOLOGIA Y ORTOPEDIA - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '20', 1, 'PARTICULAR', 10, 1),
(355, 'ACP-2022-000355', '2022-06-22', '2087800', '2081774', '1369668', 1, '1978-11-13', 'DNI', '80276357', 'HUATUCO', 'GASPAR', 'CELIA LUZ', '2022-06-21', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '44', 2, 'PARTICULAR', 10, 1),
(356, 'ACP-2022-000356', '2022-06-22', '2088612', '2082586', '1369734', 2, '1975-05-04', 'DNI', '09948336', 'SANCHEZ', 'GORRITTI', 'JUAN JOSE', '2022-06-21', 'TOPICO TRAUMA - EMERGENCIA', '', 'CARABAYLLO', '47', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(357, 'ACP-2022-000357', '2022-06-22', '2088782', '2082756', '1087534', 1, '1963-06-07', 'DNI', '15280155', 'ZEVALLOS', 'BARRETO', 'SABINO GABRIEL', '2022-06-21', 'TOPICO MEDICINA - EMERGENCIA', '', 'SAN BUENAVENTURA', '59', 1, 'PARTICULAR', 10, 1),
(358, 'ACP-2022-000358', '2022-06-22', '2088708', '2082682', '879709', 1, '1945-01-23', 'DNI', '30674786', 'CHOQUE', 'CHUQUIMIA', 'JULIO ERNESTO', '2022-06-21', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '77', 1, 'PARTICULAR', 10, 1),
(359, 'ACP-2022-000359', '2022-06-22', '2084259', '2078233', '1069767', 2, '1985-06-17', 'DNI', '43006867', 'MORENO', 'MORENO', 'YONATAN LUIS', '2022-06-15', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '37', 1, 'PARTICULAR', 10, 1),
(360, 'ACP-2022-000360', '2022-06-22', '2087385', '2081359', '1304216', 1, '1974-09-08', 'DNI', '09979720', 'ROJAS', 'REMENTERIA', 'NATIVIDAD LUISA', '2022-06-21', 'MEDICINA INTERNA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '48', 2, 'SIS', 10, 1),
(361, 'ACP-2022-000361', '2022-06-23', '2089863', '2083837', '239931', 1, '1978-03-25', 'DNI', '10694044', 'REGALADO', 'RIOS', 'ALEJANDRO DANTE', '2022-06-22', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 10, 1),
(362, 'ACP-2022-000362', '2022-06-23', '2089829', '2083803', '1366921', 1, '1953-11-10', 'DNI', '07119130', 'BRITO', 'TUANAMA', 'NANCY MARIA', '2022-06-22', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '69', 2, 'PARTICULAR', 10, 1),
(363, 'ACP-2022-000363', '2022-06-23', '2089936', '2083910', '1369851', 2, '1952-09-29', 'DNI', '06822691', 'ARANDO', 'SOLIS', 'MIGUEL ', '2022-06-22', 'TOPICO MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '70', 1, 'PARTICULAR', 10, 1),
(364, 'ACP-2022-000364', '2022-06-23', '2089265', '2083239', '365808', 2, '1964-09-01', 'DNI', '10386252', 'MATIAS', 'CRUZ', 'JUDITH HERCILIA', '2022-06-22', 'TOPICO TRAUMA - EMERGENCIA', '', 'COMAS', '58', 2, 'PARTICULAR', 10, 1),
(365, 'ACP-2022-000365', '2022-06-23', '2089806', '2083780', '631210', 2, '2000-02-23', 'DNI', '73998229', 'VILLAVICENCIO', 'TORRES', 'DARLENY DANIELA', '2022-06-22', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '22', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(366, 'ACP-2022-000366', '2022-06-25', '2090287', '2084261', '1369884', 2, '1951-06-03', 'DNI', '29318012', 'OLARTE', 'VILLARREAL', 'MARIA CLOTILDE', '2022-06-23', 'TOPICO TRAUMA - EMERGENCIA', '', 'BELLAVISTA', '71', 2, 'PARTICULAR', 10, 1),
(367, 'ACP-2022-000367', '2022-06-25', '2091048', '2085022', '1368589', 1, '1990-07-09', 'DNI', '47137763', 'TACANGA', 'ZAPATA', 'DIANA ARSENIA', '2022-06-23', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '32', 2, 'PARTICULAR', 10, 1),
(368, 'ACP-2022-000368', '2022-06-25', '2088203', '2082177', '1342161', 1, '1970-01-22', 'DNI', '09921065', 'CIERTO', 'FIGUEROA', 'AURELIA ', '2022-06-21', 'TOPICO CIRUGIA - EMERGENCIA', '', 'CARABAYLLO', '52', 2, 'PARTICULAR', 10, 1),
(369, 'ACP-2022-000369', '2022-06-25', '2088196', '2082170', '1369689', 1, '1981-03-23', 'DNI', '40877601', 'RODRIGUEZ', 'GONZALES', 'NANCY ', '2022-06-21', 'TOPICO CIRUGIA - EMERGENCIA', '', 'CARABAYLLO', '41', 2, 'FONCO SOAT', 10, 1),
(370, 'ACP-2022-000370', '2022-06-25', '2087730', '2081704', '1369650', 1, '1947-12-11', 'DNI', '49047323', 'CARI', 'QUILLA', 'CARMEN ', '2022-06-25', 'MEDICINA MUJERES - HOSPITALIZACIÓN ', '', 'COMAS', '75', 2, 'PARTICULAR', 10, 1),
(371, 'ACP-2022-000371', '2022-06-25', '2091026', '2085000', '210382', 1, '1980-09-01', 'DNI', '40632852', 'CRUZ', 'VENTOCILLA', 'MILAGROS EDITH', '2022-07-13', 'TRAUMATOLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'CARABAYLLO', '42', 2, 'SIS', 10, 1),
(372, 'ACP-2022-000372', '2022-06-25', '2086452', '2080426', '700737', 1, '1962-11-28', 'DNI', '06927009', 'BALDEON', 'OJEDA', 'RICHARD ELVIS', '2022-06-18', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '60', 1, 'PARTICULAR', 10, 1),
(373, 'ACP-2022-000373', '2022-06-25', '2092598', '2086572', '158775', 1, '1948-03-06', 'DNI', '05393146', 'PEREZ', 'RAMIREZ', 'ALIPIO ', '2022-06-27', 'NEFROLOGIA 1 - CONSULTORIOS EXTERNOS', '', 'NAPO', '74', 1, 'SIS', 10, 1),
(374, 'ACP-2022-000374', '2022-06-25', '2091483', '2085457', '1369996', 2, '1959-04-16', 'DNI', '43441366', 'ESPINOZA', 'JORGE', 'EDUARDO MARCIAL', '2022-06-24', 'TOPICO CIRUGIA - EMERGENCIA', '', 'COMAS', '63', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(375, 'ACP-2022-000375', '2022-06-25', '2092150', '2086124', '1311220', 1, '1952-06-01', 'DNI', '09020507', 'PILCO', 'LEON', 'SEGUNDO ', '2022-06-24', 'TOPICO MEDICINA - EMERGENCIA', '', 'COMAS', '70', 1, 'PARTICULAR', 10, 1);

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
(15, 'F024', 'F024', 'Demencia en la enfermedad por virus de la inmunodeficiencia humana [VIH]', 0, 0, 0, 1),
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
(422, 'X60', 'X60', 'Envenenamiento   autoinfligido   intencionalmente por y exposición a analgésicos no narcóticos, antipiréticos y antirreumáticos', 0, 0, 0, 1),
(423, 'X61', 'X61', 'Envenenamiento   autoinfligido   intencionalmente por  y  Exposición  a  drogas  antiepilépticas,  sedantes, hipnóticas, anti parkinsonianas y psicotrópicas no clasificadas en otra parte', 0, 0, 0, 1),
(424, 'X62', 'X62', 'Envenenamiento   autoinfligido   intencionalmente por,  y  exposición  a  narcóticos  y  psicodislepticos [alucinógenos], no clasificados en otra parte', 0, 0, 0, 1),
(425, 'X63', 'X63', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición a otras drogas que actúan sobre el sistema nervioso autónomo', 0, 0, 0, 1),
(426, 'X64', 'X64', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición a otras drogas, medicamentos y sustancias biológicas, y los no especificado', 0, 0, 0, 1),
(427, 'X65', 'X65', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición al alcohol', 0, 0, 0, 1),
(428, 'X66', 'X66', 'Envenenamiento   autoinfligido   intencionalmente por y exposición a disolventes orgánicos e hidrocarburos halogenados y sus vapores', 0, 0, 0, 1),
(429, 'X67', 'X67', ' Envenenamiento   autoinfligido   intencionalmente por, y exposición a otros gases y vapores', 0, 0, 0, 1),
(430, 'X68', 'X68', 'Envenenamiento   autoinfligido   intencionalmente por, y exposición a plaguicidas', 0, 0, 0, 1),
(431, 'X70', 'X70', 'Lesión autoinfligida intencionalmente por ahorcamiento, estrangulamiento o sofocación', 0, 0, 0, 1),
(432, 'X71', 'X71', 'Lesión  autoinfligida  intencionalmente  por  ahogamiento y sumersión', 0, 0, 0, 1),
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
(563, '90806', '90806', 'Psicoterapia individual, de soporte, psicodinámica  o  psicoeducativa  o  de  afronte  cognitivo  conductual  de  45-60  minutos  de  duración,  cara  a cara realizado por psicólogo', 0, 0, 0, 1),
(564, '90860', '90860', 'Psicoterapia cognitivo conductual', 0, 0, 0, 1),
(565, 'C2111.01', 'C2111.01', 'Psicoeducación  a  la  familia  (Intervención  familiar)', 0, 0, 0, 1),
(566, '96100.01', '96100.01', 'Sesión de psicoterapia de familia (realizado por el psicólogo)', 0, 0, 0, 1),
(567, '90847', '90847', 'Psicoterapia de la familia (psicoterapia conjunta) (con el paciente presente)', 0, 0, 0, 1),
(568, '99207.06', '99207.06', 'Atención en salud mental a mujeres que son víctimas de violencia por su pareja o expareja (incluye aplicación de la ficha de valoración de riesgos)', 0, 0, 0, 1),
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
(584, 'C0071', 'C0071', 'Análisis de la situación de salud. Identificación de necesidades de salud de la población con participación de la comunidad', 0, 0, 2, 1),
(585, 'C1043', 'C1043', 'Coordinaciones con actores de sectores e instituciones en la comunidad (Sesión de movilización de redes de apoyo)', 0, 0, 2, 1),
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
(609, 'Z875  ', 'Z875  ', 'Historia personal de complicaciones del embarazo, del parto y del puerperio', 0, 0, 2, 1),
(610, 'Z720', 'Z720', 'Problemas relacionados con el uso de tabaco', 0, 0, 0, 0),
(611, 'Z721', 'Z721', 'Problemas relacionados con el uso de alcohol', 0, 0, 0, 0),
(612, 'Z722', 'Z722', 'Problemas relacionados con el uso de drogas', 0, 0, 0, 0),
(613, 'Z728', 'Z728', 'Otros problemas relacionados con el estilo de vida', 0, 0, 0, 0),
(614, 'Z733', 'Z733', 'Problemas relacionados con déficit en habilidades sociales', 0, 0, 0, 0),
(615, 'Z734', 'Z734', 'Problemas relacionados con habilidades sociales inadecuadas', 0, 0, 0, 0),
(616, '96150.01', '9615001', 'Tamizaje en Violencia', 0, 0, 0, 0),
(617, '96150.02', '9615002', 'Tamizaje en Alcohol y Drogas', 0, 0, 0, 0),
(618, '96150.03', '9615003', 'Tamizaje en Transtornos Depresivos', 0, 0, 0, 0),
(619, '96150.04', '9615004', 'Tamizaje en Psicosis', 0, 0, 0, 0);

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
(1, '2022-04-15', 10, 1, 9, 1, 'DNI', '20042165', 'BERIC CAPCHA CHANCA', '52', '994799962'),
(2, '2022-05-04', 12, 33, 2, 2, 'DNI', '09962899', 'STAMANTE BRACAMONTE', '52', '992361674'),
(3, '2022-05-09', 12, 41, 10, 2, 'DNI', '42382622', 'MARIA CARLA HERRERA CANAQUIRI', '38', '941988623'),
(4, '2022-05-09', 12, 40, 2, 2, 'DNI', '09968293', 'ELIZABETH CHAVEZ JUAREZ', '49', '979275735'),
(5, '2022-05-15', 10, 63, 2, 2, 'DNI', '06861370', 'LUZ ANGELICA PALACIOS NESIOSUPE', '55', ''),
(6, '2022-05-15', 10, 64, 6, 1, 'DNI', '42138885', 'PAVEL MANRIQUE OJANAMA', '39', '967527557'),
(7, '2022-05-15', 10, 65, 6, 2, 'DNI', '48358116', 'GRETTEL YASMINE JARAMILLO VILLANUEVA', '28', '949283882'),
(8, '2022-05-15', 10, 66, 6, 1, 'DNI', '06828771', 'ARMANDO FREDY CAMPOS TAMAYO', '65', '944713179'),
(9, '2022-05-15', 10, 66, 9, 2, 'DNI', '19958468', 'CLORINDA ERNESTINA SUAZO CORDOVA', '62', '920590417'),
(10, '2022-05-15', 10, 67, 3, 2, 'DNI', '70569359', 'ROCIO DEL PILAR GUARDAMINO TELLO', '30', '938315149'),
(11, '2022-05-15', 10, 68, 6, 2, 'DNI', '46179113', 'SANDRA CECILIA VERASTEGUI PIZANGO', '38', '933783417'),
(12, '2022-05-15', 10, 69, 6, 1, 'DNI', '10380855', 'JOSE RUBEN AMAYA CARRILLO', '50', '968285427'),
(13, '2022-05-15', 10, 70, 3, 2, 'DNI', '74718437', 'HARUMI NAKAMO IBARROLA', '20', '989871802'),
(14, '2022-05-15', 10, 71, 9, 1, 'DNI', '06823818', 'FELICIANO MAURO CHURAMPI CONDOR', '66', '963451742'),
(15, '2022-05-15', 10, 72, 8, 2, 'DNI', '46585878', 'ANYELI ELIZABETH BALDEON QUINCHO', '31', '929501049'),
(16, '2022-05-15', 10, 73, 2, 2, 'DNI', '08311071', 'BERIDIANA USQUIANO FLORES', '63', '964422529'),
(17, '2022-05-15', 10, 74, 3, 1, 'DNI', '45995404', 'HUGO EBERTH HERRERA TARAZONA', '32', '928322904'),
(18, '2022-05-15', 10, 75, 3, 1, 'DNI', '06247102', 'JOHN CESAR PEREZ VARGAS', '59', '949134184'),
(19, '2022-05-15', 10, 76, 6, 1, 'DNI', '47970618', 'SERGIO DAVID SAENZ VIDAL', '27', '902833430'),
(20, '2022-05-15', 10, 77, 3, 2, 'DNI', '76881822', 'JESENIA BENDITA SAMANEZ HUISA', '21', '923818369'),
(21, '2022-05-15', 10, 78, 8, 2, 'DNI', '46160237', 'ESTEFANI JAZMIN AVILES TORRES', '32', '966751519'),
(22, '2022-05-15', 10, 79, 2, 2, 'DNI', '06878950', 'FRANCISCA VERONICA PARIMANGO DIAZ', '56', ''),
(23, '2022-05-15', 10, 80, 6, 2, 'DNI', '44368996', 'NILMA GUEVARA DELGADO', '37', '981613367'),
(24, '2022-05-15', 10, 81, 3, 2, 'DNI', '09483746', 'ROSA MARIA ESPINOZA VALVERDE', '52', '980400442'),
(25, '2022-05-15', 10, 82, 6, 1, 'DNI', '42168587', 'CARLOS ALBERTO CUTIPA HUILLCA', '41', '993473218'),
(26, '2022-05-15', 10, 84, 8, 2, 'DNI', '41772136', 'ESTHER MAGALY VEGA DE LA CRUZ', '39', '992648801'),
(27, '2022-05-15', 10, 85, 9, 1, 'DNI', '42645420', 'JAVIER SARAVIA AVALOS', '42', '960598904'),
(28, '2022-05-15', 10, 88, 3, 2, 'DNI', '76877090', 'SONIA LESLIE POMATANTA CASTAÑEDA', '26', '962607341'),
(29, '2022-05-15', 10, 91, 3, 2, 'DNI', '72615305', 'MARICELY LUCINA CASTILLO AGUILAR', '22', '959848101'),
(30, '2022-05-15', 10, 92, 3, 2, 'DNI', '10681337', 'ROSA ELVIRA MEZA RODRIGUEZ', '50', '917266425'),
(31, '2022-05-15', 10, 93, 3, 2, 'DNI', '10407853', 'MONICA CRISTINA RAMIREZ SERNAQUE', '45', '903518343'),
(32, '2022-05-16', 10, 94, 2, 2, 'DNI', '10881747', 'LIZ ZORAIDA FERREL MENDOZA', '43', '927521618'),
(33, '2022-05-16', 10, 95, 3, 2, 'DNI', '40470998', 'SARA ALICIA LOZANO SALCEDO', '41', '921679428'),
(34, '2022-05-16', 10, 97, 6, 2, 'DNI', '48804020', 'FLOR MARÍA ZAVALA AGUILAR', '35', '902111638'),
(35, '2022-05-16', 10, 98, 6, 2, 'DNI', '74706341', 'JOSSELYN JHATSURY YAMO CRUZ', '22', '944178329'),
(36, '2022-05-16', 10, 99, 2, 2, 'DNI', '09963548', 'JUANA ANGELINA ARROSTE FERNANDEZ', '49', '922043248'),
(37, '2022-05-16', 10, 100, 3, 2, 'DNI', '70858048', 'JAIMIZ HEBER MORALES QUISPE', '24', '999243769'),
(38, '2022-05-16', 10, 103, 6, 2, 'DNI', '09990775', 'SOFIA MARIBEL GOICOCHEA MUCHA', '47', '991371616'),
(39, '2022-05-16', 10, 104, 9, 2, 'DNI', '41461089', 'ROSA ANGELA FLORES VILLEGAS', '38', '950165708'),
(40, '2022-05-16', 10, 107, 5, 1, 'DNI', '71455748', 'KEVIN MANUEL ACOSTA AGUIRRE', '28', '954772558'),
(41, '2022-05-16', 10, 108, 6, 2, 'DNI', '80487083', 'SANDRA ESMERALDA PANDO URETA', '48', '947519124'),
(42, '2022-05-16', 10, 109, 9, 1, 'DNI', '72232533', 'ALEX EDUARDO DIAZ DELGADO', '27', '977157410'),
(43, '2022-05-16', 10, 110, 6, 1, 'DNI', '70811368', 'JUAN ISAIAS MELCHOR BARRETO', '26', '932964847'),
(44, '2022-05-16', 10, 111, 6, 2, 'DNI', '10577881', 'CAROLINA PAÑIURA FUENTES', '54', '918845911'),
(45, '2022-05-16', 10, 112, 9, 1, 'DNI', '41171799', 'PEDRO SANCHEZ ACUÑA', '41', '925319129'),
(46, '2022-05-16', 10, 114, 3, 1, 'DNI', '47444787', 'YORHET YANY GALLUPE VILCAHUAMAN', '30', '918990923'),
(47, '2022-05-16', 12, 120, 3, 2, 'DNI', '41551148', 'SANDRA VASQUEZ LIZAMA', '39', '980550904'),
(48, '2022-05-18', 10, 124, 6, 2, 'DNI', '41114835', 'SOLEDAD ARASSELI ROMERO FEBRES', '39', '969760337'),
(49, '2022-05-18', 10, 125, 3, 2, 'DNI', '74138691', 'ANA LUCIA TORI ORTEGA', '28', '984777295'),
(50, '2022-05-18', 10, 128, 6, 1, 'DNI', '15281303', 'EGO HEISAIAS MOLINA BOHORQUEZ', '69', '992407750'),
(51, '2022-05-18', 10, 129, 2, 2, 'DNI', '10402310', 'SARA HODETH PINON VELA', '61', '994568012'),
(52, '2022-05-18', 10, 130, 3, 2, 'DNI', '43041860', 'ALICIA ROXANA PADILLA VARA', '41', '950563117'),
(53, '2022-05-18', 10, 132, 6, 1, 'DNI', '06912578', 'JOSE ANTONIO VELAZCO FUERTES', '57', '913928793'),
(54, '2022-05-18', 10, 135, 9, 1, 'DNI', '42436088', 'MICHAEL VERGARA MORENO', '35', '942098327'),
(55, '2022-05-18', 10, 137, 3, 2, 'DNI', '07471329', 'BLANCA ISABEL CHIRA SOTIL', '53', '994697508'),
(56, '2022-05-18', 10, 138, 2, 2, 'DNI', '10204585', 'JUANA ANTEZANA MANSILLA DE ROBLES', '67', '941515909'),
(57, '2022-05-18', 10, 139, 8, 2, 'DNI', '74490627', 'DANIELA DANICZA NUÑEZ PANIAGUA', '21', '956262790'),
(58, '2022-05-18', 10, 142, 6, 1, 'DNI', '10398949', 'JORGE CAMPOS BERNATA', '48', '996542798'),
(59, '2022-05-18', 10, 143, 9, 1, 'DNI', '43699430', 'ALFRED NOVEL PALHUA SILVERIO', '40', '986450419'),
(60, '2022-05-18', 10, 144, 7, 1, 'DNI', '32649266', 'MARIA TERESA VILLAFANE LUIS', '51', '997860423'),
(61, '2022-05-18', 10, 148, 9, 1, 'DNI', '06228411', 'RICARDO CONDOR VALENTIN', '65', '988139561'),
(62, '2022-05-18', 10, 151, 9, 1, 'DNI', '41815883', 'CINTYA PATRICIA RIVERA GUTIERREZ DE MUÑOZ', '39', '925129189'),
(63, '2022-05-18', 10, 152, 9, 2, 'DNI', '75025188', 'GIOVANNY LEANDRO HIDALGO MESTANZA', '21', '936959498'),
(64, '2022-05-18', 10, 153, 3, 1, 'DNI', '09989628', 'GUSTAVO ROJAS NOLBERTO', '47', '986290882'),
(65, '2022-05-19', 10, 154, 9, 1, 'DNI', '44601067', 'ELMER VALUIS MEJIA', '32', '987616504'),
(66, '2022-05-19', 10, 156, 8, 2, 'DNI', '80403524', 'SANDRA MAGUID CARDENAS MOZOMBITE', '44', '900477684'),
(67, '2022-05-19', 10, 158, 9, 1, 'DNI', '45571992', 'KONI RAYMUNDO OLORTEGUI', '33', '921683363'),
(68, '2022-05-19', 10, 159, 9, 2, 'DNI', '48314548', 'ALESSANDRA SHERLY GRACIELA ZAVALA ROJAS', '43', '910951083'),
(69, '2022-05-19', 10, 161, 3, 1, 'DNI', '48171082', 'JUNIOR JEREMY ALONSO SOTO', '29', '953366342'),
(70, '2022-05-19', 10, 162, 3, 2, 'DNI', '10742350', 'LEA ISABEL HINOSTROZA ZAPATA', '44', '943939787'),
(71, '2022-05-19', 10, 163, 1, 1, 'DNI', '10763644', 'GUILLERMO ANTONIO INGAR MEJIA', '46', '933130470'),
(72, '2022-05-19', 10, 166, 9, 2, 'DNI', '09749560', 'GIOVANA ESTHER REINOSO FERREIRA', '50', '982298202'),
(73, '2022-05-19', 10, 168, 2, 2, 'DNI', '06904777', 'CECILIA TREJO COTRINA', '66', ''),
(74, '2022-05-19', 10, 169, 7, 2, 'DNI', '16670866', 'YTALA VIOLETA DIAZ VALLEJOS', '52', '980528198'),
(75, '2022-05-19', 10, 173, 3, 1, 'DNI', '43603403', 'EDER JOEL CARDENAS CABELLO', '35', '955285677'),
(76, '2022-05-19', 10, 174, 9, 2, 'DNI', '09019929', 'ROSA MARIA ROMERO GOMEZ', '62', '992843824'),
(77, '2022-05-19', 10, 175, 9, 1, 'DNI', '42023880', 'DANTE CHUJANDAMA TAMANI', '37', '941968819'),
(78, '2022-05-19', 10, 176, 9, 1, 'DNI', '10408515', 'LEONCIO GUTIERREZ GASPAR', '47', '929608066'),
(80, '2022-05-19', 10, 178, 7, 1, 'DNI', '10201552', 'PERCY MAXIMO CONTRERAS INGA', '46', '955321173'),
(81, '2022-05-19', 10, 178, 1, 1, 'DNI', '20103415', 'JESUS VICTOR CONTRERAS INGA', '45', ''),
(82, '2022-05-19', 10, 179, 3, 1, 'DNI', '77814865', 'ANTHONY MANUEL ARCE CARDENAS', '20', '936884965'),
(83, '2022-05-19', 10, 180, 1, 1, 'DNI', '10405406', 'CIPRIANO CARDENAS TACUCHI', '69', '921247743'),
(84, '2022-05-19', 10, 184, 9, 2, 'DNI', '09984899', 'JACQUELINE IVONNE RAMOS FLORES', '46', '991099698'),
(85, '2022-05-19', 10, 187, 8, 1, 'DNI', '77727388', 'JOHAN ALI COTERA GARCIA', '23', '924154705'),
(86, '2022-05-19', 10, 188, 6, 2, 'DNI', '10215119', 'NILDA ISABEL HUAMAN PALOMINO', '47', '970779673'),
(87, '2022-05-19', 10, 189, 7, 2, 'DNI', '09217318', 'CARMEN ROSA MORIANO PINTO', '65', '912839661'),
(88, '2022-05-19', 10, 190, 9, 1, 'DNI', '74084552', 'ANGEL RICARDO ANAMPA MARIN', '21', '974379714'),
(89, '2022-05-19', 10, 190, 1, 1, 'DNI', '06282258', 'MARCO ANTONIO DE LA CRUZ CARRASCO', '59', '983696801'),
(90, '2022-05-20', 10, 191, 9, 2, 'DNI', '75401807', 'LUCERO DEL ROCIO FERNANDEZ RAMIREZ', '23', ''),
(91, '2022-05-20', 10, 192, 6, 2, 'DNI', '43885925', 'JESSICA TIPULA VARGAS', '34', '900497488'),
(92, '2022-05-20', 10, 195, 6, 2, 'DNI', '76529940', 'PAMELA LISET CARRASCO TINEO', '23', '900521734'),
(93, '2022-05-20', 10, 197, 1, 1, 'DNI', '04018661', 'VICTOR SALAS CHAMORRO', '63', '970966469'),
(94, '2022-05-20', 10, 198, 6, 1, 'DNI', '40148476', 'ANGELO SANDOVAL QUISPE', '43', '917834589'),
(95, '2022-05-20', 10, 198, 2, 2, 'DNI', '06884751', 'CLEOFE QUISPE ROMAN VDA DE SANDOVAL', '66', ''),
(96, '2022-05-20', 10, 200, 3, 2, 'DNI', '81694086', 'INGRID STEFANI QUEZADA FACHIN', '19', '903402178'),
(97, '2022-05-20', 10, 201, 2, 1, 'DNI', '19557639', 'SANTOS ELEUTERIA CRUZ RODRIGUEZ', '53', '947284438'),
(98, '2022-05-20', 10, 202, 6, 2, 'DNI', '07418144', 'NICOLAS CONDORI BLANCO', '68', '946128470'),
(99, '2022-05-20', 10, 203, 2, 2, 'DNI', '06900154', 'MARIA PILAR SALAS CHAVEZ VDA DE RAMOS', '62', '973933930'),
(100, '2022-05-20', 10, 204, 7, 1, 'DNI', '46866404', 'SILVIA MARGARITA VARGAS FIGUEROA', '31', '945596756'),
(101, '2022-05-20', 10, 213, 9, 1, 'DNI', '47438488', 'IVAN RUPAY LEON', '29', '977568908'),
(103, '2022-05-20', 10, 217, 2, 2, 'DNI', '22424742', 'JUANA MARITZA FLORES BENAVIDES', '60', '970645661'),
(104, '2022-05-20', 10, 218, 6, 2, 'DNI', '75883874', 'EMILIA NANCY MORENO TAPIA', '22', '934993750'),
(105, '2022-05-20', 10, 219, 6, 2, 'DNI', '09071548', 'YFIGENIA SINFOROZA RAMOS VILLON', '64', '940584905'),
(106, '2022-05-20', 10, 8, 1, 1, 'DNI', '04029059', 'WALTER GARCIA MATEO', '65', '902548886'),
(107, '2022-05-20', 10, 222, 9, 2, 'DNI', '06936372', 'ELVA ANGELICA MORI PEREYRA', '60', '932205412'),
(108, '2022-05-20', 10, 224, 2, 2, 'DNI', '18038748', 'JULIA YNES AGUIRRE CRUZ', '65', '969652042'),
(109, '2022-05-20', 10, 225, 9, 1, 'DNI', '09888761', 'LUIS ENRIQUE NAZARIO ALARICO', '49', '950457500'),
(110, '2022-05-20', 10, 226, 3, 2, 'DNI', '40504670', 'CONSUELO MARILUZ QUISPE PARCO', '42', '923325147'),
(111, '2022-05-21', 10, 239, 1, 2, 'DNI', '42326363', 'JUAN MARTIN QUISPE GONZALES', '38', '946401962'),
(112, '2022-05-21', 10, 239, 2, 2, 'DNI', '29116612', 'HERMINIA FLOR QUISPE NEYRA', '52', '922391207'),
(113, '2022-05-21', 10, 240, 2, 2, 'DNI', '09484794', 'LUISA MABEL LOZANO CERRATE', '52', '946182417'),
(114, '2022-05-21', 10, 240, 1, 1, 'DNI', '09986111', 'CARLOS JAVIER SOTO ESPINO', '51', '946182417'),
(115, '2022-05-21', 10, 242, 9, 2, 'DNI', '75316150', 'MILAGROS JANETH TOLEDO CHAVEZ', '27', '976969009'),
(116, '2022-05-21', 10, 242, 2, 2, 'DNI', '10395119', 'JULIA ANA ARAUJO CRUZ', '50', ''),
(117, '2022-05-21', 10, 242, 7, 2, 'DNI', '10390241', 'MIRELLA ISABEL ARAUJO CRUZ', '45', '958383624'),
(118, '2022-05-21', 10, 244, 3, 1, 'DNI', '43038375', 'KELLER ANDERSON PEREZ POZO', '38', '914348866'),
(119, '2022-05-21', 10, 5, 6, 1, 'DNI', '47544169', 'ENRIQUE BANDA LEON', '47', '920033698'),
(120, '2022-05-21', 10, 246, 9, 1, 'DNI', '22081769', 'SANTOS CLEMENTE HUAMANI TORRES', '48', '978863312'),
(121, '2022-05-21', 10, 248, 3, 2, 'DNI', '71326594', 'DANIELA DONNA GUILLERMO PINCHI', '24', '92143415'),
(122, '2022-05-21', 10, 249, 3, 2, 'DNI', '76396855', 'GABRIELA STEFANY BERASTIGUE COLAN', '27', '995511852'),
(123, '2022-05-21', 10, 16, 6, 2, 'DNI', '06941046', 'MAGALY ELISA RODRIGUEZ DOMINGUEZ', '52', '947519962'),
(124, '2022-05-21', 10, 251, 5, 1, 'DNI', '77536422', 'ANTHONY IVAN PALACIOS MARTEL', '22', '940205924'),
(125, '2022-05-22', 10, 27, 6, 1, 'DNI', '09741976', 'EDGARDO MANUEL CORDOVA RAMIREZ', '52', '993789385'),
(126, '2022-05-22', 10, 254, 6, 2, 'DNI', '09975342', 'MARIA CRISTINA MAMANI LAURA', '48', '991058980'),
(127, '2022-05-22', 10, 28, 3, 2, 'DNI', '06232679', 'VIRGINIA LAURO GARCIA', '64', '961411132'),
(128, '2022-05-22', 10, 257, 3, 2, 'DNI', '10397973', 'NANCY TORIBIA FLORES NUÑEZ', '51', '955837193'),
(129, '2022-05-22', 10, 32, 6, 1, 'DNI', '06826924', 'DIEGO ESTANISLAO VILLACORTA REGALADO', '70', '925560570'),
(130, '2022-05-22', 10, 39, 3, 2, 'DNI', '44021922', 'KRISTIE BETZABETH DURAND JUAN', '35', '922233746'),
(131, '2022-05-22', 10, 266, 9, 1, 'DNI', '09544373', 'ISIDRO BARTOLOME VILCAPOMA OROZCO', '52', '984257052'),
(132, '2022-05-22', 10, 30, 9, 2, 'DNI', '09736695', 'DORIS ELYZABET POMATANTA DIAZ', '52', '929813324'),
(133, '2022-06-09', 10, 302, 1, 1, 'DNI', '19247769', 'ROBERT EDUARDO LEON ALVITRES', '51', ''),
(134, '2022-06-09', 10, 304, 9, 1, 'DNI', '47835852', 'JACKELINE CAMILA BARAHONA VELASQUEZ', '29', '982503238'),
(135, '2022-06-11', 10, 300, 3, 2, 'DNI', '44654304', 'FIORELLA EDELMIRA ACERO ECHEVARRIA', '35', '918057529'),
(136, '2022-06-11', 10, 301, 2, 2, 'DNI', '04066866', 'DOMITILA REYES TADEO', '50', '934211879'),
(137, '2022-06-11', 10, 310, 6, 1, 'DNI', '43554825', 'ANGEL RENGIFO VASQUEZ', '36', '982564203'),
(138, '2022-06-11', 10, 311, 8, 2, 'DNI', '76012352', 'SARA NORA DEBORA VELA MANRRIQUE', '26', '985809636'),
(139, '2022-06-11', 10, 315, 6, 2, 'DNI', '09991788', 'GIOVANA MOLINA PAREDES', '47', '923073808'),
(140, '2022-06-11', 10, 318, 3, 2, 'DNI', '46018788', 'JHOANNA MILAGROS CAYCHO VERGARAY', '32', ''),
(141, '2022-06-14', 10, 303, 8, 2, 'DNI', '09967378', 'JACQUELINE ALLCCA ALZAMORA', '48', '981359227'),
(142, '2022-06-14', 10, 319, 9, 2, 'DNI', '08032122', 'MARLENI GLADIS ENCISO ROMERO', '56', '947372467'),
(143, '2022-06-14', 10, 323, 3, 1, 'DNI', '75044666', 'JEENS JHONY HUAMAN GUEVARA', '16', '977362832'),
(144, '2022-06-14', 10, 316, 1, 1, 'DNI', '08059302', 'JULIO CABALLERO LOPEZ', '84', '967857983'),
(145, '2022-06-15', 10, 331, 6, 2, 'DNI', '06845066', 'ORFITA RIOS VASQUEZ', '62', ''),
(146, '2022-06-15', 10, 332, 6, 2, 'DNI', '09480048', 'DIANA ESCARLET TAMARIZ RIVERA', '53', '986559455'),
(147, '2022-06-16', 10, 335, 9, 2, 'DNI', '06792380', 'GLORIA ESPERANZA GONZALES BONIFACIO', '47', '925801923'),
(148, '2022-06-16', 10, 336, 3, 2, 'DNI', '48171896', 'GERALDINE ELIANA MIO PUERTAS', '28', '926765967'),
(149, '2022-06-20', 10, 337, 2, 2, 'DNI', '08980946', 'MARINA CHUQUIRUNA BRIONES', '56', '981085462'),
(150, '2022-06-20', 10, 339, 6, 2, 'DNI', '40853949', 'DENISSE SONALI GONZALES LLACSA', '42', '995165038'),
(151, '2022-06-20', 10, 340, 5, 1, 'DNI', '75275159', 'OMAR ENRIQUE PEÑALOZA MANTILLA', '26', '912899673'),
(152, '2022-06-20', 10, 343, 7, 2, 'CE', '20390196', 'JANETZI MARQUEZ', '34', '900113135'),
(153, '2022-06-20', 10, 341, 6, 2, 'DNI', '10402462', 'LOURDES PATRICIA ESPINOZA NAVARRO', '45', '950118192'),
(154, '2022-06-20', 10, 345, 1, 1, 'DNI', '08667682', 'LUIS ALLENDE HEREDIA', '65', '902372601'),
(155, '2022-06-20', 10, 346, 12, 2, 'DNI', '44056781', 'MONICA HAYDEE ORQUIZ GONZALES', '38', '931645535'),
(156, '2022-06-20', 10, 350, 9, 1, 'DNI', '43325868', 'SEGUNDO ROMEL PIÑA SILVA', '44', '912178227'),
(157, '2022-06-20', 10, 351, 9, 2, 'DNI', '09967399', 'RUTH ELIZABETH YANAC RODRIGUEZ DE VILMAS', '49', '912591461'),
(158, '2022-06-21', 10, 217, 9, 1, 'DNI', '41978657', 'ZUMEL ESPINOZA ROJAS', '38', '934075642'),
(159, '2022-06-22', 10, 353, 9, 2, 'DNI', '07520473', 'MARTHA CONSUELO SOUZA ANGULO', '65', '992307560'),
(160, '2022-06-22', 10, 356, 6, 2, 'DNI', '08847557', 'MONICA VIVIANA SANCHEZ GORRITTI', '22', ''),
(161, '2022-06-22', 10, 357, 6, 1, 'DNI', '15280185', 'SANTOS ZEVALLOS BARRETO', '59', '969299684'),
(162, '2022-06-22', 10, 359, 2, 2, 'DNI', '09731551', 'MARY YSABEL MORENO BUIZA', '52', '969600966'),
(163, '2022-06-22', 10, 360, 6, 2, 'DNI', '71262465', 'ADELA FLOR ROJAS REMENTERIA', '32', '993554050'),
(164, '2022-06-23', 10, 363, 11, 1, 'DNI', '47968575', 'GEYCEN CESAR AREVALO MENDOZA', '29', '924119312'),
(165, '2022-06-25', 10, 367, 2, 2, 'DNI', '08242074', 'ARCENIA ZAPATA PACHERREZ', '63', '910742099'),
(166, '2022-06-25', 10, 369, 9, 1, 'DNI', '40120062', 'OLBERT CRUZ SALVADOR', '43', '985573167'),
(167, '2022-06-25', 10, 370, 5, 2, 'DNI', '46530426', 'FIORELA NATALY SERRATO CANAZA', '32', '983410807'),
(168, '2022-06-25', 10, 4, 3, 2, 'DNI', '05371063', 'MARIA ENITA PEREZ MORILLO', '74', '916569913'),
(169, '2022-06-25', 10, 375, 9, 2, 'DNI', '09020844', 'GLORIA GRIMANEZA VALDIVIA VILCA', '67', '984192983');

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
  `idDiag3Seg` int(11) NOT NULL DEFAULT '0',
  `idDiag4Seg` int(11) NOT NULL DEFAULT '0',
  `comunFamSeg` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `idFamAtSeg` int(11) NOT NULL DEFAULT '0',
  `idDiag1SegFam` int(11) NOT NULL DEFAULT '0',
  `idDiag2SegFam` int(11) NOT NULL DEFAULT '0',
  `idDiag3SegFam` int(11) NOT NULL DEFAULT '0',
  `idDiag4SegFam` int(11) NOT NULL DEFAULT '0',
  `obsSeg` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `idStatusSeg` int(11) NOT NULL DEFAULT '1',
  `registroSistema` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_seguimiento`
--

INSERT INTO `psyem_seguimiento` (`idSeguimiento`, `fRegistrSeg`, `idUsuario`, `idAtencionPac`, `idProfesional`, `idTipoSeguimiento`, `idMotSeguimiento`, `idDiag1Seg`, `idDiag2Seg`, `idDiag3Seg`, `idDiag4Seg`, `comunFamSeg`, `idFamAtSeg`, `idDiag1SegFam`, `idDiag2SegFam`, `idDiag3SegFam`, `idDiag4SegFam`, `obsSeg`, `idStatusSeg`, `registroSistema`) VALUES
(1, '2022-02-26', 10, 1, 8, 2, 2, 533, 557, 0, 0, 'SI', 1, 536, 557, 0, 0, 'Z63.4/F41.9', 1, '2022-04-16 01:54:14'),
(2, '2022-04-27', 12, 2, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:07:31'),
(3, '2022-04-27', 12, 3, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:08:32'),
(4, '2022-04-27', 12, 4, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:09:25'),
(5, '2022-04-27', 12, 5, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:10:55'),
(6, '2022-04-27', 12, 6, 10, 2, 1, 536, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:12:33'),
(7, '2022-04-27', 12, 7, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:14:55'),
(8, '2022-04-27', 12, 8, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:16:08'),
(9, '2022-04-27', 12, 9, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:17:40'),
(10, '2022-04-27', 12, 10, 10, 2, 1, 536, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:18:43'),
(11, '2022-04-27', 12, 11, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-04-27 23:19:30'),
(12, '2022-04-29', 12, 12, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:41:53'),
(13, '2022-04-29', 12, 13, 10, 2, 1, 536, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:43:54'),
(14, '2022-04-29', 12, 14, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:46:41'),
(15, '2022-04-29', 12, 15, 10, 2, 1, 536, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:48:29'),
(16, '2022-04-29', 12, 10, 10, 2, 2, 536, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:50:55'),
(17, '2022-04-29', 12, 7, 10, 2, 2, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:51:51'),
(18, '2022-05-02', 12, 16, 10, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:54:13'),
(19, '2022-05-02', 12, 17, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 22:56:42'),
(20, '2022-05-02', 12, 18, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:00:45'),
(21, '2022-05-02', 12, 2, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:01:31'),
(22, '2022-05-02', 12, 19, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:02:59'),
(23, '2022-05-02', 12, 20, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:04:46'),
(24, '2022-05-02', 12, 22, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:08:30'),
(25, '2022-05-02', 12, 23, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:10:47'),
(26, '2022-05-02', 12, 24, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-02 23:12:09'),
(27, '2022-05-04', 12, 25, 10, 2, 1, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:21:02'),
(28, '2022-05-04', 12, 26, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:22:17'),
(29, '2022-05-04', 12, 27, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:26:51'),
(30, '2022-05-04', 12, 28, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:30:25'),
(31, '2022-05-04', 12, 29, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:31:43'),
(32, '2022-05-04', 12, 30, 10, 2, 1, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:35:07'),
(33, '2022-05-04', 12, 17, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:36:35'),
(34, '2022-05-04', 12, 20, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:37:54'),
(35, '2022-05-04', 12, 31, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:41:38'),
(36, '2022-05-04', 12, 24, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:42:45'),
(37, '2022-05-04', 12, 32, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-04 23:44:22'),
(38, '2022-05-04', 12, 33, 10, 2, 1, 430, 557, 0, 0, 'SI', 2, 233, 557, 0, 0, '', 1, '2022-05-04 23:51:49'),
(39, '2022-05-06', 12, 25, 10, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:22:21'),
(40, '2022-05-06', 12, 34, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:23:25'),
(41, '2022-05-06', 12, 35, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:25:44'),
(42, '2022-05-06', 12, 36, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:26:34'),
(43, '2022-05-06', 12, 30, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:29:09'),
(44, '2022-05-06', 12, 32, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:30:16'),
(45, '2022-05-06', 12, 37, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:31:26'),
(46, '2022-05-06', 12, 38, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:33:32'),
(47, '2022-05-06', 12, 39, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-06 23:35:00'),
(48, '2022-05-09', 12, 41, 10, 2, 1, 430, 557, 0, 0, 'SI', 3, 233, 557, 0, 0, '', 1, '2022-05-09 18:34:28'),
(49, '2022-05-09', 12, 40, 10, 2, 1, 423, 557, 0, 0, 'SI', 4, 233, 557, 0, 0, '', 1, '2022-05-09 18:37:36'),
(50, '2022-05-10', 12, 42, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 12:41:20'),
(51, '2022-05-10', 12, 43, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 12:42:14'),
(52, '2022-05-10', 12, 44, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 12:43:05'),
(53, '2022-05-10', 12, 45, 10, 2, 1, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 12:45:04'),
(54, '2022-05-10', 12, 46, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 13:40:43'),
(55, '2022-05-11', 12, 47, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:45:55'),
(56, '2022-05-11', 12, 48, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:47:21'),
(57, '2022-05-11', 12, 49, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:48:21'),
(58, '2022-05-11', 12, 50, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:49:47'),
(59, '2022-05-11', 12, 51, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:50:48'),
(60, '2022-05-11', 12, 52, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:51:54'),
(61, '2022-05-11', 12, 45, 10, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:53:06'),
(62, '2022-05-11', 12, 44, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:55:57'),
(63, '2022-05-11', 12, 43, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-11 17:56:31'),
(64, '2022-05-12', 12, 47, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:51:34'),
(65, '2022-05-12', 12, 53, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:52:58'),
(66, '2022-05-12', 12, 48, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:53:40'),
(67, '2022-05-12', 12, 54, 10, 2, 2, 473, 550, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:55:25'),
(68, '2022-05-12', 12, 50, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:56:13'),
(69, '2022-05-12', 12, 55, 10, 2, 1, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:57:28'),
(70, '2022-05-12', 12, 56, 10, 2, 1, 232, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 16:59:19'),
(71, '2022-05-12', 12, 49, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-12 17:00:05'),
(72, '2022-05-13', 12, 57, 10, 2, 1, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-13 17:09:10'),
(73, '2022-05-13', 12, 58, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-13 17:10:23'),
(74, '2022-05-13', 12, 59, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-13 17:12:11'),
(75, '2022-05-13', 12, 60, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-13 17:13:25'),
(76, '2022-05-13', 12, 61, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-13 17:14:40'),
(77, '2022-05-13', 12, 62, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-13 17:16:01'),
(78, '2022-05-14', 12, 57, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-14 17:29:51'),
(79, '2022-05-14', 12, 62, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-14 17:30:30'),
(80, '2022-02-26', 10, 1, 8, 2, 2, 233, 557, 0, 0, 'SI', 1, 536, 557, 0, 0, '', 2, '2022-05-16 01:53:28'),
(81, '2022-02-26', 10, 63, 8, 2, 2, 430, 557, 0, 0, 'SI', 5, 233, 557, 0, 0, '', 1, '2022-05-16 01:56:56'),
(82, '2022-02-26', 10, 64, 8, 2, 2, 209, 557, 0, 0, 'SI', 6, 536, 557, 0, 0, '', 1, '2022-05-16 02:05:13'),
(83, '2022-02-28', 10, 65, 8, 2, 2, 233, 557, 0, 0, 'SI', 7, 536, 557, 0, 0, '', 1, '2022-05-16 02:14:44'),
(84, '2022-02-28', 10, 66, 8, 2, 2, 233, 557, 0, 0, 'SI', 8, 536, 557, 0, 0, '', 1, '2022-05-16 02:21:39'),
(85, '2022-03-19', 10, 66, 8, 2, 2, 233, 557, 0, 0, 'SI', 8, 536, 557, 0, 0, '', 1, '2022-05-16 02:23:08'),
(86, '2022-03-17', 10, 66, 8, 2, 2, 233, 0, 0, 0, 'SI', 9, 536, 557, 0, 0, '', 1, '2022-05-16 02:27:05'),
(87, '2022-02-28', 10, 67, 8, 2, 2, 233, 557, 0, 0, 'SI', 10, 536, 557, 0, 0, '', 1, '2022-05-16 02:30:13'),
(88, '2022-03-01', 10, 68, 8, 2, 2, 233, 557, 0, 0, 'SI', 11, 536, 557, 0, 0, '', 1, '2022-05-16 02:42:26'),
(89, '2022-03-01', 10, 69, 8, 2, 2, 233, 557, 0, 0, 'SI', 12, 233, 557, 0, 0, '', 1, '2022-05-16 02:49:13'),
(90, '2022-03-01', 10, 70, 8, 2, 2, 230, 557, 0, 0, 'SI', 13, 536, 557, 0, 0, '', 1, '2022-05-16 02:52:55'),
(91, '2022-03-01', 10, 71, 8, 2, 2, 233, 557, 0, 0, 'SI', 14, 536, 557, 0, 0, '', 1, '2022-05-16 03:07:20'),
(92, '2022-03-01', 10, 72, 8, 2, 2, 233, 557, 0, 0, 'SI', 15, 536, 557, 0, 0, '', 1, '2022-05-16 03:15:00'),
(93, '2022-03-03', 10, 73, 8, 2, 2, 230, 557, 0, 0, 'SI', 16, 536, 557, 0, 0, '', 1, '2022-05-16 03:21:55'),
(94, '2022-03-03', 10, 74, 8, 2, 2, 206, 557, 0, 0, 'SI', 17, 536, 557, 0, 0, '', 1, '2022-05-16 03:25:14'),
(95, '2022-03-03', 10, 75, 8, 2, 2, 233, 557, 0, 0, 'SI', 18, 536, 557, 0, 0, '', 1, '2022-05-16 03:29:14'),
(96, '2022-03-03', 10, 76, 8, 2, 1, 233, 557, 0, 0, 'SI', 19, 233, 557, 0, 0, '', 1, '2022-05-16 03:37:12'),
(97, '2022-03-03', 10, 77, 8, 2, 2, 233, 557, 0, 0, 'SI', 20, 536, 557, 0, 0, '', 1, '2022-05-16 03:42:25'),
(98, '2022-03-05', 10, 78, 8, 2, 2, 233, 557, 0, 0, 'SI', 21, 233, 557, 0, 0, '', 1, '2022-05-16 03:47:38'),
(99, '2022-03-05', 10, 79, 8, 2, 2, 233, 557, 0, 0, 'SI', 22, 536, 557, 0, 0, '', 1, '2022-05-16 03:51:29'),
(100, '2022-03-05', 10, 80, 8, 2, 2, 230, 557, 0, 0, 'SI', 23, 536, 557, 0, 0, '', 1, '2022-05-16 03:55:09'),
(101, '2022-03-19', 10, 80, 8, 2, 2, 230, 0, 0, 0, 'SI', 23, 536, 557, 0, 0, '', 1, '2022-05-16 03:57:07'),
(102, '2022-03-07', 10, 81, 8, 2, 2, 549, 557, 0, 0, 'SI', 24, 536, 557, 0, 0, '', 1, '2022-05-16 04:05:42'),
(103, '2022-03-07', 10, 82, 8, 2, 2, 230, 557, 0, 0, 'SI', 25, 536, 557, 0, 0, '', 1, '2022-05-16 04:09:21'),
(104, '2022-03-07', 10, 83, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 04:12:11'),
(105, '2022-03-07', 10, 84, 8, 2, 2, 233, 557, 0, 0, 'SI', 26, 536, 557, 0, 0, '', 1, '2022-05-16 04:16:05'),
(106, '2022-03-08', 10, 85, 8, 2, 2, 230, 557, 0, 0, 'SI', 27, 536, 557, 0, 0, '', 1, '2022-05-16 04:20:50'),
(107, '2022-03-08', 10, 86, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 04:27:27'),
(108, '2022-03-08', 10, 87, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 04:29:47'),
(109, '2022-03-08', 10, 88, 8, 2, 2, 233, 557, 0, 0, 'SI', 28, 536, 557, 0, 0, '', 1, '2022-05-16 04:34:05'),
(110, '2022-03-08', 10, 89, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 04:39:37'),
(111, '2022-03-09', 10, 90, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 04:41:19'),
(112, '2022-03-09', 10, 91, 8, 2, 2, 233, 557, 0, 0, 'SI', 29, 536, 557, 0, 0, '', 1, '2022-05-16 04:45:04'),
(113, '2022-03-09', 10, 92, 8, 2, 2, 233, 557, 0, 0, 'SI', 30, 473, 557, 0, 0, '', 1, '2022-05-16 04:48:24'),
(114, '2022-03-09', 10, 93, 8, 2, 2, 473, 557, 0, 0, 'SI', 31, 233, 557, 0, 0, '', 1, '2022-05-16 04:52:57'),
(115, '2022-03-11', 10, 94, 8, 2, 2, 430, 557, 0, 0, 'SI', 32, 233, 557, 0, 0, '', 1, '2022-05-16 05:02:48'),
(116, '2022-03-11', 10, 95, 8, 2, 2, 233, 557, 0, 0, 'SI', 33, 536, 557, 0, 0, '', 1, '2022-05-16 05:06:06'),
(117, '2022-03-11', 10, 97, 8, 2, 2, 241, 557, 0, 0, 'SI', 34, 233, 557, 0, 0, '', 1, '2022-05-16 05:14:56'),
(118, '2022-03-12', 10, 98, 8, 2, 2, 423, 557, 0, 0, 'SI', 35, 536, 557, 0, 0, '', 1, '2022-05-16 05:20:24'),
(119, '2022-03-11', 10, 99, 8, 2, 2, 208, 557, 0, 0, 'SI', 36, 233, 557, 0, 0, '', 1, '2022-05-16 05:27:56'),
(120, '2022-03-12', 10, 100, 8, 2, 2, 233, 557, 0, 0, 'SI', 37, 233, 557, 0, 0, '', 1, '2022-05-16 05:38:04'),
(121, '2022-03-12', 10, 101, 8, 2, 2, 533, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 05:41:33'),
(122, '2022-03-12', 10, 102, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 05:42:35'),
(123, '2022-03-12', 10, 103, 8, 2, 2, 549, 0, 0, 0, 'SI', 38, 233, 557, 0, 0, '', 1, '2022-05-16 05:45:23'),
(124, '2022-03-14', 10, 104, 8, 2, 2, 233, 557, 0, 0, 'SI', 39, 233, 557, 0, 0, '', 1, '2022-05-16 05:48:21'),
(125, '2022-03-14', 10, 106, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 05:53:16'),
(126, '2022-03-14', 10, 107, 8, 2, 2, 233, 557, 0, 0, 'SI', 40, 536, 557, 0, 0, '', 1, '2022-05-16 05:56:11'),
(127, '2022-03-14', 10, 108, 8, 2, 2, 233, 557, 0, 0, 'SI', 41, 233, 557, 0, 0, '', 1, '2022-05-16 06:02:11'),
(128, '2022-03-14', 10, 109, 8, 2, 2, 423, 557, 0, 0, 'SI', 42, 233, 557, 0, 0, '', 1, '2022-05-16 06:05:18'),
(129, '2022-03-15', 10, 110, 8, 2, 2, 536, 557, 0, 0, 'SI', 43, 536, 557, 0, 0, '', 1, '2022-05-16 06:09:57'),
(130, '2022-03-15', 10, 111, 8, 2, 2, 233, 557, 0, 0, 'SI', 44, 536, 557, 0, 0, '', 1, '2022-05-16 06:14:24'),
(131, '2022-03-15', 10, 112, 8, 2, 2, 233, 557, 0, 0, 'SI', 45, 233, 557, 0, 0, '', 1, '2022-05-16 06:19:44'),
(132, '2022-03-15', 10, 113, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 06:22:09'),
(133, '2022-03-15', 10, 113, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 2, '2022-05-16 06:23:53'),
(134, '2022-03-15', 10, 113, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 2, '2022-05-16 06:28:57'),
(135, '2022-03-15', 10, 115, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 06:32:51'),
(136, '2022-03-15', 10, 114, 8, 2, 2, 233, 557, 0, 0, 'SI', 46, 233, 557, 0, 0, '', 1, '2022-05-16 06:39:18'),
(137, '2022-03-19', 10, 112, 8, 2, 2, 233, 557, 0, 0, 'SI', 45, 233, 557, 0, 0, '', 1, '2022-05-16 06:44:42'),
(138, '2022-05-16', 12, 116, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 17:07:25'),
(139, '2022-05-16', 12, 117, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 17:08:48'),
(140, '2022-05-16', 12, 118, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 17:09:57'),
(141, '2022-05-16', 12, 119, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 17:11:02'),
(142, '2022-05-16', 12, 58, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-16 17:11:36'),
(143, '2022-05-16', 12, 120, 10, 2, 1, 439, 557, 0, 0, 'SI', 47, 233, 557, 0, 0, '', 1, '2022-05-16 17:28:02'),
(144, '2022-05-18', 12, 116, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 16:34:46'),
(145, '2022-05-18', 12, 118, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 16:35:55'),
(146, '2022-05-18', 12, 121, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 16:37:28'),
(147, '2022-05-18', 12, 122, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 16:38:53'),
(148, '2022-03-16', 10, 123, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 22:05:05'),
(149, '2022-03-16', 10, 124, 8, 2, 2, 230, 557, 0, 0, 'SI', 48, 230, 557, 0, 0, '96', 1, '2022-05-18 23:07:56'),
(150, '2022-03-16', 10, 125, 8, 2, 2, 430, 557, 0, 0, 'SI', 49, 233, 557, 0, 0, '', 1, '2022-05-18 23:13:35'),
(151, '2022-03-16', 10, 126, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 23:15:28'),
(152, '2022-03-18', 10, 127, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 23:17:12'),
(153, '2022-03-19', 10, 127, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 23:30:01'),
(154, '2022-03-18', 10, 128, 8, 2, 2, 233, 557, 0, 0, 'SI', 50, 536, 557, 0, 0, '', 1, '2022-05-18 23:32:04'),
(155, '2022-03-18', 10, 129, 8, 2, 2, 241, 557, 0, 0, 'SI', 51, 233, 557, 0, 0, '', 1, '2022-05-18 23:40:46'),
(156, '2022-03-18', 10, 130, 8, 2, 2, 233, 557, 0, 0, 'SI', 52, 233, 557, 0, 0, '', 1, '2022-05-18 23:43:44'),
(157, '2022-03-19', 10, 130, 8, 2, 2, 233, 557, 0, 0, 'SI', 52, 233, 557, 0, 0, '', 1, '2022-05-18 23:44:55'),
(158, '2022-03-18', 10, 131, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 23:46:46'),
(159, '2022-03-18', 10, 132, 8, 2, 2, 206, 557, 0, 0, 'SI', 53, 536, 557, 0, 0, '', 1, '2022-05-18 23:52:24'),
(160, '2022-03-19', 10, 133, 8, 2, 2, 241, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-18 23:56:21'),
(161, '2022-03-19', 10, 134, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 00:06:17'),
(162, '2022-03-19', 10, 135, 8, 2, 2, 206, 557, 0, 0, 'SI', 54, 233, 557, 0, 0, '', 1, '2022-05-19 00:09:36'),
(163, '2021-03-19', 10, 136, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 00:11:21'),
(164, '2022-03-21', 10, 136, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 00:12:19'),
(165, '2022-03-21', 10, 137, 8, 2, 2, 241, 557, 0, 0, 'SI', 55, 536, 557, 0, 0, '', 1, '2022-05-19 00:35:54'),
(166, '2022-03-21', 10, 138, 8, 2, 2, 233, 557, 0, 0, 'SI', 56, 233, 557, 0, 0, '', 1, '2022-05-19 00:40:37'),
(167, '2022-03-21', 10, 139, 8, 2, 2, 206, 557, 0, 0, 'SI', 57, 536, 557, 0, 0, '', 1, '2022-05-19 00:44:46'),
(168, '2022-03-21', 10, 140, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 00:46:28'),
(169, '2022-03-22', 10, 139, 8, 2, 2, 206, 557, 0, 0, 'SI', 57, 536, 557, 0, 0, '', 1, '2022-05-19 00:49:03'),
(170, '2022-03-21', 10, 141, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 00:51:38'),
(171, '2022-03-21', 10, 142, 8, 2, 2, 233, 557, 0, 0, 'SI', 58, 536, 557, 0, 0, '', 1, '2022-05-19 00:59:44'),
(172, '2022-03-22', 10, 143, 8, 2, 2, 430, 557, 0, 0, 'SI', 59, 233, 557, 0, 0, '', 1, '2022-05-19 01:08:42'),
(173, '2022-03-23', 10, 143, 8, 2, 2, 430, 557, 0, 0, 'SI', 59, 233, 557, 0, 0, '', 1, '2022-05-19 01:10:18'),
(174, '2022-03-22', 10, 143, 8, 2, 2, 430, 557, 0, 0, 'SI', 59, 233, 557, 0, 0, '', 2, '2022-05-19 01:16:11'),
(175, '2022-03-23', 10, 143, 8, 2, 2, 430, 557, 0, 0, 'SI', 59, 233, 557, 0, 0, '', 2, '2022-05-19 01:18:10'),
(176, '2022-03-22', 10, 144, 8, 2, 2, 206, 557, 0, 0, 'SI', 60, 536, 557, 0, 0, '', 1, '2022-05-19 01:20:57'),
(177, '2022-03-23', 10, 144, 8, 2, 2, 206, 557, 0, 0, 'SI', 60, 536, 557, 0, 0, '', 1, '2022-05-19 01:23:09'),
(178, '2022-03-22', 10, 142, 8, 2, 2, 233, 557, 0, 0, 'SI', 58, 536, 557, 0, 0, '', 1, '2022-05-19 01:31:30'),
(179, '2022-03-23', 10, 145, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 01:35:46'),
(180, '2022-03-23', 10, 146, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 01:37:42'),
(181, '2022-03-23', 10, 147, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 01:38:38'),
(182, '2022-03-23', 10, 148, 8, 2, 2, 209, 557, 0, 0, 'SI', 61, 536, 557, 0, 0, '', 1, '2022-05-19 04:29:38'),
(183, '2022-03-25', 10, 149, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 04:34:06'),
(184, '2022-03-25', 10, 150, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 04:35:03'),
(185, '2022-03-25', 10, 151, 8, 2, 2, 230, 557, 0, 0, 'SI', 62, 230, 557, 0, 0, '', 1, '2022-05-19 04:39:07'),
(186, '2022-03-25', 10, 152, 8, 2, 2, 233, 557, 0, 0, 'SI', 63, 536, 557, 0, 0, '', 1, '2022-05-19 04:43:34'),
(187, '2022-03-25', 10, 153, 8, 2, 2, 206, 557, 0, 0, 'SI', 64, 536, 557, 0, 0, '', 1, '2022-05-19 04:58:43'),
(188, '2022-03-25', 10, 154, 8, 2, 2, 233, 557, 0, 0, 'SI', 65, 233, 557, 0, 0, '', 1, '2022-05-19 05:03:27'),
(189, '2022-03-25', 10, 155, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 05:04:37'),
(190, '2022-03-28', 10, 156, 8, 2, 2, 230, 557, 0, 0, 'SI', 66, 536, 557, 0, 0, '', 1, '2022-05-19 05:10:03'),
(191, '2022-03-30', 10, 156, 8, 2, 2, 230, 557, 0, 0, 'SI', 66, 536, 557, 0, 0, '', 1, '2022-05-19 05:13:26'),
(192, '2022-03-28', 10, 157, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 05:14:57'),
(193, '2022-03-28', 10, 158, 8, 2, 2, 230, 557, 0, 0, 'SI', 67, 233, 557, 0, 0, '', 1, '2022-05-19 05:20:39'),
(194, '2022-03-28', 10, 159, 8, 2, 2, 233, 557, 0, 0, 'SI', 68, 233, 0, 0, 0, '', 1, '2022-05-19 05:33:24'),
(195, '2022-03-28', 10, 160, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 05:42:20'),
(196, '2022-03-28', 10, 161, 8, 2, 2, 230, 557, 0, 0, 'SI', 69, 536, 557, 0, 0, '', 1, '2022-05-19 05:45:36'),
(197, '2022-03-28', 10, 162, 8, 2, 2, 233, 557, 0, 0, 'SI', 70, 536, 557, 0, 0, '', 1, '2022-05-19 05:48:49'),
(198, '2022-03-30', 10, 163, 8, 2, 2, 423, 557, 0, 0, 'SI', 71, 233, 557, 0, 0, '', 1, '2022-05-19 05:53:44'),
(199, '2022-03-30', 10, 164, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 05:55:42'),
(200, '2022-03-30', 10, 165, 8, 2, 2, 208, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-19 05:57:13'),
(201, '2022-04-01', 10, 166, 8, 2, 2, 233, 557, 0, 0, 'SI', 72, 233, 557, 0, 0, '', 1, '2022-05-20 00:45:28'),
(202, '2022-04-01', 10, 167, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 00:46:36'),
(203, '2022-04-01', 10, 168, 8, 2, 2, 241, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 00:50:04'),
(204, '2022-04-02', 10, 168, 8, 2, 2, 241, 557, 0, 0, 'SI', 73, 536, 557, 0, 0, '', 1, '2022-05-20 00:51:57'),
(205, '2022-04-01', 10, 169, 8, 2, 2, 536, 557, 0, 0, 'SI', 74, 536, 557, 0, 0, '', 1, '2022-05-20 01:05:22'),
(206, '2022-04-01', 10, 170, 8, 2, 2, 241, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 01:06:52'),
(207, '2022-04-01', 10, 171, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 01:08:20'),
(208, '2022-04-05', 10, 171, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 01:09:17'),
(209, '2022-04-19', 10, 171, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 01:10:16'),
(210, '2022-04-02', 10, 172, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 01:23:29'),
(211, '2022-04-02', 10, 173, 8, 2, 2, 241, 557, 0, 0, 'SI', 75, 233, 557, 0, 0, '', 1, '2022-05-20 01:26:36'),
(212, '2022-04-02', 10, 174, 8, 2, 2, 233, 557, 0, 0, 'SI', 76, 233, 557, 0, 0, '', 1, '2022-05-20 01:31:10'),
(213, '2022-04-02', 10, 175, 8, 2, 2, 533, 557, 0, 0, 'SI', 77, 533, 557, 0, 0, '', 1, '2022-05-20 02:25:06'),
(214, '2022-04-04', 10, 176, 8, 2, 2, 233, 557, 0, 0, 'SI', 78, 536, 557, 0, 0, '', 1, '2022-05-20 02:34:50'),
(215, '2022-04-04', 10, 177, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 02:36:39'),
(216, '2022-04-04', 10, 178, 8, 2, 2, 239, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 02:46:31'),
(217, '2022-04-05', 10, 178, 8, 2, 2, 239, 557, 0, 0, 'SI', 80, 536, 557, 0, 0, '', 1, '2022-05-20 02:48:00'),
(218, '2022-04-08', 10, 178, 8, 2, 2, 239, 557, 0, 0, 'SI', 81, 536, 557, 0, 0, '', 1, '2022-05-20 02:48:53'),
(219, '2022-04-04', 10, 179, 8, 2, 2, 233, 557, 0, 0, 'SI', 82, 536, 557, 0, 0, '', 1, '2022-05-20 03:38:07'),
(220, '2022-04-04', 10, 180, 8, 2, 2, 430, 557, 0, 0, 'SI', 83, 233, 557, 0, 0, '', 1, '2022-05-20 03:52:12'),
(221, '2022-04-04', 10, 181, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 03:54:22'),
(222, '2022-04-05', 10, 182, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 03:56:35'),
(223, '2022-04-05', 10, 183, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 03:58:01'),
(224, '2022-04-05', 10, 184, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 04:00:33'),
(225, '2022-04-06', 10, 184, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 04:01:13'),
(226, '2022-04-11', 10, 184, 8, 2, 2, 233, 557, 0, 0, 'SI', 84, 233, 557, 0, 0, '', 1, '2022-05-20 04:02:27'),
(227, '2022-04-06', 10, 185, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 04:04:13'),
(228, '2022-04-06', 10, 186, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 04:34:02'),
(229, '2022-04-06', 10, 187, 8, 2, 2, 233, 557, 0, 0, 'SI', 85, 536, 557, 0, 0, '', 1, '2022-05-20 04:37:19'),
(230, '2022-04-09', 10, 187, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 04:38:29'),
(231, '2022-04-06', 10, 188, 8, 2, 2, 233, 0, 0, 0, 'SI', 86, 233, 557, 0, 0, '', 1, '2022-05-20 04:42:25'),
(232, '2022-04-06', 10, 189, 8, 2, 2, 230, 557, 0, 0, 'SI', 87, 233, 557, 0, 0, '', 1, '2022-05-20 04:48:33'),
(233, '2022-04-07', 10, 190, 8, 2, 2, 473, 557, 0, 0, 'SI', 88, 547, 557, 0, 0, '', 1, '2022-05-20 04:57:25'),
(234, '2022-04-07', 10, 190, 8, 2, 2, 473, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:02:54'),
(235, '2022-04-09', 10, 190, 8, 2, 2, 473, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:07:27'),
(236, '2022-04-13', 10, 190, 8, 2, 2, 473, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:09:35'),
(237, '2022-04-09', 10, 190, 8, 2, 2, 473, 0, 0, 0, 'SI', 89, 0, 557, 0, 0, '', 1, '2022-05-20 05:19:33'),
(238, '2022-04-08', 10, 191, 8, 2, 2, 233, 557, 0, 0, 'SI', 90, 233, 557, 0, 0, '', 1, '2022-05-20 05:30:31'),
(239, '2022-04-09', 10, 191, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:31:26'),
(240, '2022-04-08', 10, 192, 8, 2, 2, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:34:21'),
(241, '2022-04-12', 10, 192, 8, 2, 2, 233, 0, 0, 0, 'SI', 91, 473, 557, 0, 0, '', 1, '2022-05-20 05:35:53'),
(242, '2022-04-08', 10, 193, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:37:08'),
(243, '2022-04-08', 10, 194, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:39:29'),
(244, '2022-04-08', 10, 195, 8, 2, 2, 454, 557, 0, 0, 'SI', 92, 233, 557, 0, 0, '', 1, '2022-05-20 05:42:00'),
(245, '2022-04-09', 10, 196, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 05:43:40'),
(246, '2022-04-09', 10, 197, 8, 2, 2, 230, 557, 0, 0, 'SI', 93, 233, 557, 0, 0, '', 1, '2022-05-20 05:45:52'),
(247, '2022-04-11', 10, 198, 8, 2, 2, 230, 557, 0, 0, 'SI', 94, 536, 557, 0, 0, '', 1, '2022-05-20 06:03:21'),
(248, '2022-04-13', 10, 198, 8, 2, 2, 230, 557, 0, 0, 'SI', 95, 536, 557, 0, 0, '', 1, '2022-05-20 06:06:03'),
(249, '2022-04-11', 10, 199, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:07:15'),
(250, '2022-04-11', 10, 200, 8, 2, 2, 549, 0, 0, 0, 'SI', 96, 233, 557, 0, 0, '', 1, '2022-05-20 06:10:31'),
(251, '2022-04-11', 10, 201, 8, 2, 2, 456, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:13:30'),
(252, '2022-04-18', 10, 201, 8, 2, 2, 456, 0, 0, 0, 'SI', 97, 233, 557, 0, 0, '', 1, '2022-05-20 06:26:32'),
(253, '2022-04-11', 10, 202, 8, 2, 2, 233, 557, 0, 0, 'SI', 98, 536, 557, 0, 0, '', 1, '2022-05-20 06:29:03'),
(254, '2022-04-12', 10, 203, 8, 2, 2, 233, 557, 0, 0, 'SI', 99, 233, 557, 0, 0, '', 1, '2022-05-20 06:31:39'),
(255, '2022-04-12', 10, 204, 8, 2, 2, 221, 557, 0, 0, 'SI', 100, 536, 557, 0, 0, '', 1, '2022-05-20 06:36:09'),
(256, '2022-04-13', 10, 204, 8, 2, 2, 221, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:36:53'),
(257, '2022-04-12', 10, 205, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:38:37'),
(258, '2022-04-12', 10, 206, 8, 2, 2, 537, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:40:03'),
(259, '2022-04-12', 10, 207, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:41:03'),
(260, '2022-04-13', 10, 208, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:42:39'),
(261, '2022-04-13', 10, 209, 8, 2, 2, 423, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:44:12'),
(262, '2022-04-13', 10, 210, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:45:23'),
(263, '2022-04-16', 10, 211, 8, 2, 2, 233, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:49:19'),
(264, '2022-04-18', 10, 211, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:50:01'),
(265, '2022-04-16', 10, 212, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:51:56'),
(266, '2022-04-16', 10, 213, 8, 2, 2, 206, 557, 0, 0, 'SI', 101, 529, 557, 0, 0, '', 1, '2022-05-20 06:54:43'),
(267, '2022-04-16', 10, 214, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:57:08'),
(268, '2022-04-16', 10, 8, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:58:50'),
(269, '2022-04-21', 10, 8, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 06:59:40'),
(270, '2022-04-18', 10, 215, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:01:13'),
(271, '2022-04-18', 10, 216, 8, 2, 2, 473, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:02:29'),
(272, '2022-04-18', 10, 217, 8, 2, 2, 423, 557, 0, 0, 'SI', 103, 233, 557, 0, 0, '', 1, '2022-05-20 07:09:53'),
(273, '2022-04-25', 10, 217, 8, 2, 2, 423, 557, 0, 0, 'SI', 103, 233, 557, 0, 0, '', 1, '2022-05-20 07:10:49'),
(274, '2022-04-18', 10, 117, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:13:53'),
(275, '2022-04-19', 10, 218, 8, 2, 2, 221, 557, 0, 0, 'SI', 104, 221, 557, 0, 0, '', 1, '2022-05-20 07:17:02'),
(276, '2022-04-19', 10, 219, 8, 2, 2, 233, 557, 0, 0, 'SI', 105, 536, 557, 0, 0, '', 1, '2022-05-20 07:20:05'),
(277, '2022-04-19', 10, 8, 8, 2, 2, 233, 557, 0, 0, 'SI', 106, 233, 557, 0, 0, '', 1, '2022-05-20 07:22:56'),
(278, '2022-04-21', 10, 8, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 2, '2022-05-20 07:23:59'),
(279, '2022-04-19', 10, 220, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:25:54'),
(280, '2022-04-19', 10, 221, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:27:16'),
(281, '2022-04-20', 10, 222, 8, 2, 2, 233, 557, 0, 0, 'SI', 107, 536, 557, 0, 0, '', 1, '2022-05-20 07:32:35'),
(282, '2022-04-20', 10, 223, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:34:16'),
(283, '2022-04-20', 10, 224, 8, 2, 2, 233, 557, 0, 0, 'SI', 108, 536, 557, 0, 0, '', 1, '2022-05-20 07:37:28'),
(284, '2022-04-21', 10, 224, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 07:38:23'),
(285, '2022-04-20', 10, 225, 8, 2, 2, 230, 557, 0, 0, 'SI', 109, 536, 557, 0, 0, '', 1, '2022-05-20 07:41:40'),
(286, '2022-04-21', 10, 225, 8, 2, 2, 230, 557, 0, 0, 'SI', 109, 536, 557, 0, 0, '', 1, '2022-05-20 07:43:37'),
(287, '2022-04-20', 10, 226, 8, 2, 2, 536, 557, 0, 0, 'SI', 110, 536, 557, 0, 0, '', 1, '2022-05-20 07:48:00'),
(288, '2022-05-19', 12, 227, 10, 2, 1, 430, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:16:08'),
(289, '2022-05-19', 12, 228, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:18:36'),
(290, '2022-05-19', 12, 229, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:19:56'),
(291, '2022-05-19', 12, 230, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:22:13'),
(292, '2022-05-19', 12, 231, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:24:34'),
(293, '2022-05-19', 12, 232, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:25:58'),
(294, '2022-05-19', 12, 17, 10, 2, 2, 230, 590, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 12:27:01'),
(295, '2022-05-20', 12, 232, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:33:49'),
(296, '2022-05-20', 12, 233, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:34:57'),
(297, '2022-05-20', 12, 234, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:36:13'),
(298, '2022-05-20', 12, 235, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:37:18'),
(299, '2022-05-20', 12, 236, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:38:49'),
(300, '2022-05-20', 12, 237, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:39:39'),
(301, '2022-05-20', 12, 238, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:40:30'),
(302, '2022-05-20', 12, 229, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-20 17:42:43'),
(303, '2022-04-21', 10, 239, 8, 2, 2, 430, 557, 0, 0, 'SI', 111, 233, 557, 0, 0, '', 1, '2022-05-22 01:02:27'),
(304, '2022-04-25', 10, 239, 8, 2, 2, 430, 557, 0, 0, 'SI', 112, 233, 557, 0, 0, '', 1, '2022-05-22 01:04:02'),
(305, '2022-04-22', 10, 240, 8, 2, 2, 430, 557, 0, 0, 'SI', 113, 233, 557, 0, 0, '', 1, '2022-05-22 01:08:35'),
(306, '2022-04-22', 10, 240, 8, 2, 2, 430, 557, 0, 0, 'SI', 114, 233, 557, 0, 0, '', 1, '2022-05-22 01:12:56'),
(307, '2022-04-23', 10, 240, 8, 2, 2, 430, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 01:13:39'),
(308, '2022-04-23', 10, 239, 8, 2, 2, 430, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 01:21:59'),
(309, '2022-04-22', 10, 241, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 02:01:54'),
(310, '2022-04-22', 10, 242, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 02:07:46'),
(311, '2022-04-23', 10, 242, 8, 2, 2, 233, 557, 0, 0, 'SI', 115, 233, 557, 0, 0, '', 1, '2022-05-22 02:11:41'),
(312, '2022-04-25', 10, 242, 8, 2, 2, 233, 557, 0, 0, 'SI', 116, 233, 557, 0, 0, '', 1, '2022-05-22 02:12:51'),
(313, '2022-04-26', 10, 242, 8, 2, 2, 233, 0, 0, 0, 'SI', 117, 536, 557, 0, 0, '', 1, '2022-05-22 02:13:47'),
(314, '2022-04-22', 10, 9, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 02:39:22'),
(315, '2022-04-25', 10, 9, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 02:43:39'),
(316, '2022-04-23', 10, 243, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 02:47:36'),
(317, '2022-04-26', 10, 243, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 02:48:26'),
(318, '2022-04-25', 10, 244, 8, 2, 2, 233, 557, 0, 0, 'SI', 118, 536, 557, 0, 0, '', 1, '2022-05-22 03:31:09'),
(319, '2022-04-26', 10, 5, 8, 2, 2, 233, 557, 0, 0, 'SI', 119, 536, 557, 0, 0, '', 1, '2022-05-22 03:40:43'),
(320, '2022-04-26', 10, 245, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 03:44:10'),
(321, '2022-04-26', 10, 11, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 03:45:37'),
(322, '2022-04-26', 10, 246, 8, 2, 2, 536, 557, 0, 0, 'SI', 120, 536, 557, 0, 0, '', 1, '2022-05-22 03:48:12'),
(323, '2022-04-26', 10, 247, 8, 2, 2, 423, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 03:52:43'),
(324, '2022-04-26', 10, 248, 8, 2, 2, 233, 557, 0, 0, 'SI', 121, 233, 557, 0, 0, '', 1, '2022-05-22 04:00:04'),
(325, '2022-04-26', 10, 4, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:03:35'),
(326, '2022-04-26', 10, 10, 8, 1, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:08:14'),
(327, '2022-04-26', 10, 249, 8, 2, 2, 241, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:11:36'),
(328, '2022-04-28', 10, 249, 8, 2, 2, 241, 557, 0, 0, 'SI', 122, 233, 557, 0, 0, '', 1, '2022-05-22 04:13:47'),
(329, '2022-04-28', 10, 19, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:16:49'),
(330, '2022-04-28', 10, 7, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:18:16'),
(331, '2022-04-28', 10, 16, 8, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:22:27'),
(332, '2022-04-30', 10, 16, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:24:53'),
(333, '2022-05-03', 10, 16, 8, 2, 2, 536, 557, 0, 0, 'SI', 123, 536, 557, 0, 0, '', 1, '2022-05-22 04:26:41'),
(334, '2022-04-28', 10, 250, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:28:42'),
(335, '2022-04-30', 10, 24, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:31:22'),
(336, '2022-05-05', 10, 24, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:33:34'),
(337, '2022-04-30', 10, 10, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:35:28'),
(338, '2022-04-30', 10, 250, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:37:14'),
(339, '2022-04-30', 10, 251, 8, 2, 2, 230, 557, 0, 0, 'SI', 124, 536, 557, 0, 0, '', 1, '2022-05-22 04:42:46'),
(340, '2022-04-30', 10, 12, 8, 2, 2, 445, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:46:48'),
(341, '2022-05-03', 10, 253, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 04:56:03'),
(342, '2022-05-03', 10, 27, 8, 2, 2, 159, 557, 0, 0, 'SI', 125, 536, 557, 0, 0, '', 1, '2022-05-22 05:04:33'),
(343, '2022-05-03', 10, 27, 8, 2, 2, 159, 557, 0, 0, 'SI', 125, 536, 557, 0, 0, '', 2, '2022-05-22 05:41:00'),
(344, '2022-05-03', 10, 254, 8, 2, 2, 241, 557, 0, 0, 'SI', 126, 536, 557, 0, 0, '', 1, '2022-05-22 21:18:08'),
(345, '2022-05-03', 10, 255, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 21:20:45'),
(346, '2022-05-03', 10, 28, 8, 2, 2, 233, 557, 0, 0, 'SI', 127, 233, 557, 0, 0, '', 1, '2022-05-22 21:40:58'),
(347, '2022-05-03', 10, 256, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 21:43:25'),
(348, '2022-05-03', 10, 257, 8, 2, 2, 17, 557, 0, 0, 'SI', 128, 536, 557, 0, 0, '', 1, '2022-05-22 21:47:00'),
(349, '2022-05-03', 10, 23, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 21:49:22'),
(350, '2022-05-05', 10, 25, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 21:50:39'),
(351, '2022-05-05', 10, 29, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 21:51:46'),
(352, '2022-05-05', 10, 32, 8, 2, 2, 17, 557, 0, 0, 'SI', 129, 233, 557, 0, 0, '', 1, '2022-05-22 21:55:15'),
(353, '2022-05-05', 10, 26, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 21:57:56'),
(354, '2022-05-05', 10, 39, 8, 2, 2, 233, 557, 0, 0, 'SI', 130, 536, 557, 0, 0, '', 1, '2022-05-22 22:01:24'),
(355, '2022-05-07', 10, 260, 8, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:02:46'),
(356, '2022-05-07', 10, 261, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:04:38'),
(357, '2022-05-07', 10, 38, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:06:10'),
(358, '2022-05-07', 10, 262, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:09:25'),
(359, '2022-05-07', 10, 263, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:10:49'),
(360, '2022-05-07', 10, 35, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:12:09'),
(361, '2022-05-07', 10, 264, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:28:08'),
(362, '2022-05-07', 10, 265, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-22 22:28:46'),
(363, '2022-05-07', 10, 266, 8, 2, 2, 230, 557, 0, 0, 'SI', 131, 233, 557, 0, 0, '', 1, '2022-05-22 22:32:05'),
(364, '2022-05-07', 10, 30, 8, 2, 2, 230, 557, 0, 0, 'SI', 132, 233, 557, 0, 0, '', 1, '2022-05-22 22:35:11'),
(365, '2022-03-07', 10, 267, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-23 03:46:04'),
(366, '2022-03-14', 10, 109, 8, 2, 2, 423, 557, 0, 0, 'SI', 42, 536, 557, 0, 0, '', 1, '2022-05-23 03:49:46'),
(367, '2022-05-23', 12, 236, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:13:46'),
(368, '2022-05-23', 12, 238, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:14:41'),
(369, '2022-05-23', 12, 235, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:15:19'),
(370, '2022-05-23', 12, 234, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:16:19'),
(371, '2022-05-23', 12, 268, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:17:52'),
(372, '2022-05-23', 12, 269, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:19:16'),
(373, '2022-05-23', 12, 270, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:21:25'),
(374, '2022-05-23', 12, 271, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:23:06'),
(375, '2022-05-23', 12, 272, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 13:55:59'),
(376, '2022-05-24', 12, 271, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:48:46'),
(377, '2022-05-24', 12, 272, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:49:48'),
(378, '2022-05-24', 12, 269, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:50:35'),
(379, '2022-05-24', 12, 270, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:51:37'),
(380, '2022-05-24', 12, 273, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:53:19'),
(381, '2022-05-24', 12, 274, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:55:03'),
(382, '2022-05-24', 12, 275, 10, 2, 1, 229, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-24 16:58:11'),
(383, '2022-05-25', 12, 275, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 2, '2022-05-25 16:40:00'),
(384, '2022-05-25', 12, 274, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 16:40:42'),
(385, '2022-05-25', 12, 275, 10, 2, 2, 229, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 16:41:44'),
(386, '2022-05-25', 12, 276, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 16:43:08'),
(387, '2022-05-25', 12, 277, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 16:45:25'),
(388, '2022-05-25', 12, 278, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 17:07:19'),
(389, '2022-05-25', 12, 279, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 17:09:04'),
(390, '2022-05-25', 12, 280, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-25 17:10:20'),
(391, '2022-05-26', 12, 280, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:47:53'),
(392, '2022-05-26', 12, 277, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:48:44'),
(393, '2022-05-26', 12, 281, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:50:24'),
(394, '2022-05-26', 12, 282, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:52:01'),
(395, '2022-05-26', 12, 283, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:53:34'),
(396, '2022-05-26', 12, 284, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:55:02'),
(397, '2022-05-27', 12, 281, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:56:40'),
(398, '2022-05-27', 12, 283, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:57:26'),
(399, '2022-05-27', 12, 284, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:58:14'),
(400, '2022-05-27', 12, 285, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 16:59:43'),
(401, '2022-05-27', 12, 286, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 17:03:43'),
(402, '2022-05-27', 12, 287, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 17:05:07'),
(403, '2022-05-27', 12, 288, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-27 17:06:43'),
(404, '2022-05-28', 12, 289, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:46:49'),
(405, '2022-05-28', 12, 290, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:47:53'),
(406, '2022-05-28', 12, 291, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:48:53'),
(407, '2022-05-28', 12, 292, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:49:53'),
(408, '2022-05-28', 12, 293, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:50:42'),
(409, '2022-05-28', 12, 286, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:51:33'),
(410, '2022-05-28', 12, 288, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:52:07'),
(411, '2022-05-28', 12, 294, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 12:53:29'),
(412, '2022-05-30', 12, 290, 10, 2, 2, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:22:49'),
(413, '2022-05-30', 12, 291, 10, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:23:28'),
(414, '2022-05-30', 12, 295, 10, 2, 1, 536, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:24:29'),
(415, '2022-05-30', 12, 296, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:25:48'),
(416, '2022-05-30', 12, 297, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:26:37'),
(417, '2022-05-30', 12, 298, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:27:31'),
(418, '2022-05-30', 12, 299, 10, 2, 1, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-05-30 17:28:33'),
(419, '2022-06-08', 10, 300, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-09 18:08:31'),
(420, '2022-06-08', 10, 301, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-09 18:11:01'),
(421, '2022-06-08', 10, 302, 8, 2, 2, 230, 557, 0, 0, 'SI', 133, 233, 557, 0, 0, '', 1, '2022-06-09 18:28:25'),
(422, '2022-06-08', 10, 303, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-09 18:32:52'),
(423, '2022-06-08', 10, 304, 8, 2, 2, 233, 557, 0, 0, 'SI', 134, 536, 557, 0, 0, '', 1, '2022-06-09 18:41:01'),
(424, '2022-06-09', 10, 300, 8, 2, 2, 233, 557, 0, 0, 'SI', 135, 233, 557, 0, 0, '', 1, '2022-06-11 13:35:44'),
(425, '2022-06-09', 10, 301, 8, 2, 2, 233, 557, 0, 0, 'SI', 136, 233, 557, 0, 0, '', 1, '2022-06-11 13:37:04'),
(426, '2022-06-09', 10, 305, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:37:56'),
(427, '2022-06-09', 10, 306, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:38:57'),
(428, '2022-06-09', 10, 307, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:39:38'),
(429, '2022-06-09', 10, 308, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:40:28'),
(430, '2022-06-10', 10, 309, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:41:44'),
(431, '2022-06-10', 10, 310, 8, 2, 2, 423, 557, 0, 0, 'SI', 137, 536, 557, 0, 0, '', 1, '2022-06-11 13:49:05'),
(432, '2022-06-10', 10, 311, 8, 2, 2, 473, 557, 0, 0, 'SI', 138, 536, 557, 0, 0, '', 1, '2022-06-11 13:50:31'),
(433, '2022-06-10', 10, 312, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:51:40'),
(434, '2022-06-10', 10, 313, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:52:25'),
(435, '2022-06-10', 10, 314, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 13:53:51'),
(436, '2022-06-11', 10, 315, 8, 2, 2, 233, 557, 0, 0, 'SI', 139, 536, 557, 0, 0, '', 1, '2022-06-11 17:02:03'),
(437, '2022-06-11', 10, 317, 8, 2, 2, 533, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 17:11:42'),
(438, '2022-06-11', 10, 318, 8, 2, 2, 557, 0, 0, 0, 'SI', 140, 536, 557, 0, 0, '', 1, '2022-06-11 17:20:24'),
(439, '2022-06-11', 10, 316, 8, 2, 2, 233, 557, 0, 0, 'SI', 144, 233, 557, 0, 0, '', 1, '2022-06-11 17:33:30'),
(440, '2022-06-11', 10, 312, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-11 17:34:49'),
(441, '2022-06-13', 10, 303, 8, 2, 2, 233, 557, 0, 0, 'SI', 141, 536, 557, 0, 0, '', 1, '2022-06-15 03:41:27'),
(442, '2022-06-13', 10, 319, 8, 2, 2, 233, 557, 0, 0, 'SI', 142, 233, 557, 0, 0, '', 1, '2022-06-15 03:49:51'),
(443, '2022-06-13', 10, 320, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 03:55:18'),
(444, '2022-06-13', 10, 321, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:15:27'),
(445, '2022-06-13', 10, 322, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:17:43'),
(446, '2022-06-13', 10, 328, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:20:32'),
(447, '2022-06-13', 10, 316, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:22:47'),
(448, '2022-06-14', 10, 323, 8, 2, 2, 230, 557, 0, 0, 'SI', 143, 233, 557, 0, 0, '', 1, '2022-06-15 04:29:13'),
(449, '2022-06-14', 10, 329, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:42:29'),
(450, '2022-06-14', 10, 318, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:43:15'),
(451, '2022-06-14', 10, 324, 8, 2, 2, 241, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:45:44'),
(452, '2022-06-14', 10, 325, 8, 2, 2, 529, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:46:36'),
(453, '2022-06-14', 10, 327, 8, 2, 2, 529, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:47:24'),
(454, '2022-06-14', 10, 326, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:48:58'),
(455, '2022-03-07', 10, 267, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-15 04:59:06'),
(456, '2022-06-15', 10, 330, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-16 00:21:21'),
(457, '2022-06-15', 10, 331, 8, 2, 2, 233, 557, 0, 0, 'SI', 145, 536, 557, 0, 0, '', 1, '2022-06-16 00:26:50'),
(458, '2022-06-15', 10, 332, 8, 2, 2, 230, 557, 0, 0, 'SI', 146, 233, 557, 0, 0, '', 1, '2022-06-16 00:29:40'),
(459, '2022-06-15', 10, 334, 8, 2, 2, 473, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-16 00:31:37'),
(460, '2022-06-15', 10, 333, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-16 00:32:36'),
(461, '2022-06-16', 10, 335, 8, 2, 2, 233, 557, 0, 0, 'SI', 147, 233, 557, 0, 0, '', 1, '2022-06-17 03:11:19'),
(462, '2022-06-16', 10, 336, 8, 2, 2, 230, 557, 0, 0, 'SI', 148, 536, 557, 0, 0, '', 1, '2022-06-17 03:22:05'),
(463, '2022-06-16', 10, 333, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-17 03:29:06'),
(464, '2022-06-20', 10, 337, 8, 2, 2, 233, 557, 0, 0, 'SI', 149, 233, 557, 0, 0, '', 1, '2022-06-20 17:54:10'),
(465, '2022-06-20', 10, 338, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 17:55:12'),
(466, '2022-06-20', 10, 339, 8, 2, 2, 233, 557, 0, 0, 'SI', 150, 536, 557, 0, 0, '', 1, '2022-06-20 17:56:38'),
(467, '2022-06-20', 10, 340, 8, 2, 2, 233, 557, 0, 0, 'SI', 151, 536, 557, 0, 0, '', 1, '2022-06-20 17:57:36'),
(468, '2022-06-20', 10, 341, 8, 2, 2, 47, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 17:58:43'),
(469, '2022-06-17', 10, 108, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:02:44'),
(470, '2022-06-17', 10, 331, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:05:24');
INSERT INTO `psyem_seguimiento` (`idSeguimiento`, `fRegistrSeg`, `idUsuario`, `idAtencionPac`, `idProfesional`, `idTipoSeguimiento`, `idMotSeguimiento`, `idDiag1Seg`, `idDiag2Seg`, `idDiag3Seg`, `idDiag4Seg`, `comunFamSeg`, `idFamAtSeg`, `idDiag1SegFam`, `idDiag2SegFam`, `idDiag3SegFam`, `idDiag4SegFam`, `obsSeg`, `idStatusSeg`, `registroSistema`) VALUES
(471, '2022-06-17', 10, 343, 8, 2, 2, 421, 557, 0, 0, 'SI', 152, 536, 557, 0, 0, '', 1, '2022-06-20 18:08:58'),
(472, '2022-06-17', 10, 341, 8, 2, 2, 47, 557, 0, 0, 'SI', 153, 221, 557, 0, 0, '', 1, '2022-06-20 18:11:45'),
(473, '2022-06-17', 10, 335, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:13:14'),
(474, '2022-06-18', 10, 344, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:14:43'),
(475, '2022-06-18', 10, 345, 8, 2, 2, 233, 557, 0, 0, 'SI', 154, 536, 557, 0, 0, '', 1, '2022-06-20 18:17:33'),
(476, '2022-06-18', 10, 349, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:21:37'),
(477, '2022-06-18', 10, 348, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:22:16'),
(478, '2022-06-18', 10, 347, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-20 18:22:59'),
(479, '2022-06-18', 10, 346, 8, 2, 2, 230, 557, 0, 0, 'SI', 155, 233, 557, 0, 0, '', 1, '2022-06-20 18:24:00'),
(480, '2022-02-26', 10, 350, 8, 2, 2, 239, 557, 0, 0, 'SI', 156, 536, 557, 0, 0, '', 1, '2022-06-21 00:59:51'),
(481, '2022-02-26', 10, 351, 8, 2, 2, 230, 557, 0, 0, 'SI', 157, 233, 557, 0, 0, '', 1, '2022-06-21 01:02:32'),
(482, '2022-03-11', 10, 96, 8, 2, 2, 611, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-21 01:09:39'),
(483, '2022-03-14', 10, 105, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-21 01:13:33'),
(484, '2022-03-14', 10, 105, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-21 01:15:15'),
(485, '2022-04-18', 10, 217, 8, 2, 2, 423, 557, 0, 0, 'SI', 158, 233, 557, 0, 0, '', 1, '2022-06-21 23:15:22'),
(486, '2022-05-03', 10, 352, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-21 23:45:19'),
(487, '2022-06-21', 10, 341, 8, 2, 2, 47, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-23 01:59:00'),
(488, '2022-06-21', 10, 355, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-23 02:00:21'),
(489, '2022-06-21', 10, 354, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-23 02:06:05'),
(490, '2022-06-21', 10, 353, 8, 2, 2, 233, 557, 0, 0, 'SI', 159, 233, 557, 0, 0, '', 1, '2022-06-23 02:07:03'),
(491, '2022-06-22', 10, 356, 8, 2, 2, 233, 557, 0, 0, 'SI', 160, 536, 557, 0, 0, '', 1, '2022-06-23 03:25:38'),
(492, '2022-06-22', 10, 357, 8, 2, 2, 230, 557, 0, 0, 'SI', 161, 233, 557, 0, 0, '', 1, '2022-06-23 03:28:05'),
(493, '2022-06-22', 10, 357, 8, 2, 2, 230, 0, 0, 0, 'SI', 161, 233, 0, 0, 0, '', 1, '2022-06-23 03:58:39'),
(494, '2022-06-22', 10, 358, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-23 04:00:54'),
(495, '2022-06-22', 10, 359, 8, 2, 2, 611, 557, 0, 0, 'SI', 162, 206, 557, 0, 0, '', 1, '2022-06-23 04:04:50'),
(496, '2022-06-22', 10, 360, 8, 2, 2, 473, 557, 0, 0, 'SI', 163, 233, 557, 0, 0, '', 1, '2022-06-23 04:09:33'),
(497, '2022-06-23', 10, 361, 8, 2, 2, 240, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 02:42:26'),
(498, '2022-06-23', 10, 361, 8, 2, 2, 221, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 2, '2022-06-24 02:43:12'),
(499, '2022-06-23', 10, 280, 8, 2, 2, 473, 550, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 03:01:31'),
(500, '2022-06-23', 10, 363, 8, 2, 2, 230, 557, 0, 0, 'SI', 164, 213, 557, 0, 0, '', 1, '2022-06-24 03:11:49'),
(501, '2022-06-23', 10, 353, 8, 2, 2, 230, 0, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 04:08:18'),
(502, '2022-06-23', 10, 364, 8, 2, 2, 206, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 04:14:39'),
(503, '2022-06-23', 10, 365, 8, 2, 2, 473, 550, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 04:17:42'),
(504, '2022-06-23', 10, 338, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 04:21:02'),
(505, '2022-06-23', 10, 357, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-24 04:23:32'),
(506, '2022-06-24', 10, 366, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-25 12:40:42'),
(507, '2022-06-24', 10, 367, 8, 2, 2, 230, 557, 0, 0, 'SI', 165, 233, 557, 0, 0, '', 1, '2022-06-25 12:41:42'),
(508, '2022-06-24', 10, 368, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-25 12:42:30'),
(509, '2022-06-24', 10, 369, 8, 2, 2, 230, 557, 0, 0, 'SI', 166, 233, 557, 0, 0, '', 1, '2022-06-25 12:43:26'),
(510, '2022-06-24', 10, 370, 8, 2, 2, 239, 557, 0, 0, 'SI', 167, 233, 557, 0, 0, '', 1, '2022-06-25 12:44:24'),
(511, '2022-06-24', 10, 371, 8, 2, 2, 473, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-25 12:45:24'),
(512, '2022-06-25', 10, 372, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-25 17:50:42'),
(513, '2022-06-25', 10, 4, 8, 2, 2, 233, 557, 0, 0, 'SI', 168, 233, 557, 0, 0, '', 1, '2022-06-26 03:45:54'),
(514, '2022-06-25', 10, 374, 8, 2, 2, 233, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-26 03:46:40'),
(515, '2022-06-25', 10, 375, 8, 2, 2, 235, 557, 0, 0, 'SI', 169, 233, 557, 0, 0, '', 1, '2022-06-26 03:48:12'),
(516, '2022-06-25', 10, 367, 8, 2, 2, 230, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-26 03:50:02'),
(517, '2022-06-25', 10, 361, 8, 2, 2, 221, 557, 0, 0, 'NO', 0, 0, 0, 0, 0, '', 1, '2022-06-26 03:50:39');

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
(1, 1, 1, '77478995', 'CASTRO PALACIOS', 'OLGER IVAN', 'ocastrop', 'ocastrop@hnseb.gob.pe', '$2a$07$usesomesillystringforeM8r9BbmlBZ9ovuveDN0W0YiCUcwiGOm', 3, '2021-06-01 15:34:46', ''),
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
(14, 2, 1, '41768412', 'FERRARI SANTANDER', 'ALEXIS ALBERTO', 'aferraris', 'dr.alex.ferrari.s@gmail.com', '$2a$07$usesomesillystringforeSXtcfjIjdiDI0eqt9OsmF.T.sEtEwhy', 1, '2021-08-23 19:46:27', NULL),
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

--
-- Volcado de datos para la tabla `zpsyem_aud_atenciones`
--

INSERT INTO `zpsyem_aud_atenciones` (`idAuditAte`, `idAtencion`, `fechaRegAudi`, `idUsuario`, `AccRealizada`, `cuentaAnterior`, `EpisodioAnterior`, `cuentaNueva`, `EpisodioNuevo`) VALUES
(1, 2, '2022-04-27', 12, 'MODIFICACIÓN', '2039115', '2045145', '2039115', '2045145'),
(2, 64, '2022-05-15', 10, 'MODIFICACIÓN', '2000005', '2006046', '2000005', '2006046'),
(3, 63, '2022-05-15', 10, 'MODIFICACIÓN', '2003536', '2009577', '2003536', '2009577'),
(4, 109, '2022-05-16', 10, 'MODIFICACIÓN', '2012723', '2018753', '2012723', '2018753'),
(5, 239, '2022-05-21', 10, 'MODIFICACIÓN', '2035114', '2041144', '2035114', '2041144'),
(6, 302, '2022-06-09', 10, 'MODIFICACIÓN', '2070510', '2076537', '2070510', '2076537');

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
-- Volcado de datos para la tabla `zpsyem_aud_familiares`
--

INSERT INTO `zpsyem_aud_familiares` (`idAudiFam`, `idFamiliar`, `fecRegAudi`, `idUsuario`, `AccRealizada`, `idAtencionAnt`, `ndocAnt`, `idAtencionNueva`, `ndocNuevo`) VALUES
(1, 79, '2022-05-19', 10, 'ELIMINACIÓN', 176, '10408515', NULL, NULL),
(2, 102, '2022-05-20', 10, 'ELIMINACIÓN', 213, '47438488', NULL, NULL),
(3, 133, '2022-06-09', 10, 'ACTUALIZACIÓN', 302, '76747462', 302, '19247769');

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
  MODIFY `idAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=376;

--
-- AUTO_INCREMENT de la tabla `psyem_condicionprof`
--
ALTER TABLE `psyem_condicionprof`
  MODIFY `idCondicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_diagnosticos`
--
ALTER TABLE `psyem_diagnosticos`
  MODIFY `idDiagnostico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=620;

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
  MODIFY `idFamiliar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

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
  MODIFY `idSeguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=518;

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
  MODIFY `idAuditAte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `zpsyem_aud_familiares`
--
ALTER TABLE `zpsyem_aud_familiares`
  MODIFY `idAudiFam` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
