-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 03-04-2022 a las 20:43:17
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
-- Base de datos: `db_psyemweb`
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
(1, 'ACP-2021-000001', '2021-05-14', '448978', '1897886', '743643', 2, '1996-08-15', 'DNI', '74642267', 'RODRIGUEZ', 'GARRAFA', 'LUIS', '2021-05-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '25', 1, 'PARTICULAR', 1, 1),
(2, 'ACP-2021-000002', '2021-05-14', '449679', '1896174', '1305560', 2, '1977-11-25', 'DNI', '10743021', 'RUIZ', 'VILLEGAS', 'TONY', '2021-05-15', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', '', 'COMAS', '44', 1, 'PARTICULAR', 1, 1),
(3, 'ACP-2021-000003', '2021-05-14', '448431', '1897872', '1336172', 2, '1966-02-05', 'DNI', '09045878', 'ATAUCUSI', 'LUDEÑA', 'ANGEL', '2021-05-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '55', 1, 'PARTICULAR', 1, 1),
(4, 'ACP-2021-000004', '2021-05-14', '449219', '1898576', '491430', 2, '1974-08-31', 'DNI', '09984155', 'RIVERA', 'YUPANQUI', 'YNES', '2021-05-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '47', 2, 'SOAT', 1, 1),
(5, 'ACP-2021-000005', '2021-05-14', '444305', '1893913', '310793', 2, '1942-01-02', 'DNI', '06857535', 'CORONADO', 'CASTILLO', 'TOMAS', '2021-04-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '79', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(6, 'ACP-2021-000006', '2021-05-14', '448733', '1895833', '1335290', 2, '1984-11-25', 'DNI', '44600766', 'SEVERINO', 'RIVAS', 'ISRRAEL', '2021-05-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '37', 1, 'PARTICULAR', 1, 1),
(7, 'ACP-2021-000007', '2021-05-14', '449217', '1898480', '185789', 2, '1953-04-04', 'DNI', '09030560', 'MONGE', 'MUÑOZ', 'JORGE', '2021-05-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '68', 1, 'PARTICULAR', 1, 1),
(8, 'ACP-2021-000008', '2021-05-14', '448708', '1895344', '1335076', 2, '1973-11-22', 'DNI', '48193734', 'ZANCA', 'CUADROS', 'EDSON', '2021-05-11', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', '', 'COMAS', '48', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(9, 'ACP-2021-000009', '2021-05-14', '448735', '1898116', '1336254', 1, '1979-10-21', 'DNI', '80645612', 'ALVA', 'FANO', 'MARCOS', '2021-05-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '42', 1, 'PARTICULAR', 1, 1),
(10, 'ACP-2021-000010', '2021-05-14', '446113', '1895970', '1335355', 3, '1956-09-17', 'DNI', '07074275', 'CHAVEZ', 'ABANTO', 'CARLOS', '2021-04-28', 'CORONAVIRUS - EMERGENCIA', '', 'EL AGUSTINO', '65', 1, 'PARTICULAR', 1, 1),
(11, 'ACP-2021-000011', '2021-05-14', '448246', '1897753', '1116030', 3, '1997-11-26', 'DNI', '73771531', 'QUISPE', 'HANCCO', 'EMILIANA', '2021-05-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '24', 2, 'PARTICULAR', 1, 1),
(12, 'ACP-2021-000012', '2021-05-14', '448249', '1897811', '1336149', 1, '1974-04-23', 'DNI', '10155015', 'COLLANTES', 'CARRASCO', 'PEDRO', '2021-05-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '47', 1, 'PARTICULAR', 1, 1),
(13, 'ACP-2021-000013', '2021-05-14', '449214', '1898553', '1336428', 2, '1967-10-10', 'DNI', '09479847', 'GIRON', 'ARTEAGA', 'CESAR', '2021-05-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '54', 1, 'PARTICULAR', 1, 1),
(14, 'ACP-2021-000014', '2021-05-14', '447059', '1896394', '1335583', 2, '1959-07-07', 'DNI', '06054839', 'GIRALDO', 'ZANABRIA', 'MARIA', '2021-05-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LIMA', '62', 2, 'PARTICULAR', 1, 1),
(15, 'ACP-2021-000015', '2021-05-15', '448809', '1898378', '1336372', 1, '1940-03-04', 'DNI', '06823126', 'CHUIMA', 'AYALA', 'SAUL', '2021-05-11', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '81', 1, 'PARTICULAR', 1, 1),
(16, 'ACP-2021-000016', '2021-05-15', '447611', '1896821', '1335713', 3, '1956-11-29', 'DNI', '06712654', 'SANCHEZ', 'QUIROZ', 'CRISTOBAL', '2021-05-05', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL38', 'SAN MARTIN DE PORRES', '65', 1, 'PARTICULAR', 1, 1),
(17, 'ACP-2021-000017', '2021-05-15', '450791', '1894369', '1197765', 1, '1977-11-13', 'DNI', '03692991', 'COVEÑAS', 'NAMUCHE', 'JOSE', '2021-05-21', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL28', 'COMAS', '44', 1, 'PARTICULAR', 1, 1),
(18, 'ACP-2021-000018', '2021-05-15', '449037', '1898585', '1336442', 3, '1964-10-04', 'DNI', '09250003', 'SANDOVAL', 'JIMENEZ', 'JUAN', '2021-05-12', 'CORONAVIRUS - EMERGENCIA', 'ACE19 ', 'CARABAYLLO', '57', 1, 'PARTICULAR', 1, 1),
(19, 'ACP-2021-000019', '2021-05-15', '444273', '1894054', '1334569', 1, '1958-03-05', 'DNI', '10160446', 'HUAMAN', 'HILARIO', 'ROSARIO', '2021-04-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '63', 2, 'PARTICULAR', 1, 1),
(20, 'ACP-2021-000020', '2021-05-15', '448904', '1898404', '1336381', 1, '1957-01-12', 'DNI', '07815407', 'JINES', 'BRAVO', 'FRANCISCO', '2021-05-12', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL01', 'INDEPENDENCIA', '64', 1, 'PARTICULAR', 1, 1),
(21, 'ACP-2021-000021', '2021-05-15', '448248', '1897804', '1336147', 1, '1956-04-26', 'DNI', '06733983', 'DOLORES', 'AREVALO', 'JULIO', '2021-05-09', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL02', 'PUENTE PIEDRA', '65', 1, 'PARTICULAR', 1, 1),
(22, 'ACP-2021-000022', '2021-05-15', '446676', '1891455', '1333492', 2, '1964-12-12', 'DNI', '08750121', 'CUELLO', 'AGUILAR', 'INES', '2021-05-01', 'COVID LEGADO - HOSPITALIZACIÓN ', 'C004', 'COMAS', '57', 2, 'PARTICULAR', 1, 1),
(23, 'ACP-2021-000023', '2021-05-15', '448732', '1896555', '672407', 2, '1976-10-12', 'DNI', '10391720', 'GUERRERO', 'BELLO', 'PEDRO', '2021-05-11', 'COVID LEGADO - HOSPITALIZACIÓN ', 'C014', 'LINCE', '45', 1, 'PARTICULAR', 1, 1),
(24, 'ACP-2021-000024', '2021-05-15', '443872', '1893458', '657021', 2, '1958-11-03', 'DNI', '07059841', 'AGUIRRE', 'YATACO', 'ANDRES', '2021-04-17', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', 'C010', 'COMAS', '63', 1, 'PARTICULAR', 1, 1),
(25, 'ACP-2021-000025', '2021-05-15', '450703', '1898377', '1062807', 1, '1948-10-16', 'DNI', '22977852', 'HUARANGA', 'CASTAÑEDA', 'FLORENTINO', '2021-05-20', 'MEDICINA - HOSPITALIZACIÓN ', 'MED29', 'COMAS', '73', 1, 'PARTICULAR', 1, 1),
(26, 'ACP-2021-000026', '2021-05-17', '449541', '1898950', '1336546', 1, '1953-10-24', 'DNI', '33255282', 'MORI', 'VEGA', 'RAFAEL', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL32', 'NUEVO CHIMBOTE', '68', 1, 'PARTICULAR', 1, 1),
(27, 'ACP-2021-000027', '2021-05-17', '1905338', '1899297', '1336669', 2, '1967-12-08', 'DNI', '80187653', 'VILLANUEVA', 'MARTINEZ', 'DELIA', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL40', 'MIRAFLORES', '54', 2, 'PARTICULAR', 1, 1),
(28, 'ACP-2021-000028', '2021-05-17', '448148', '1897643', '1336098', 2, '1968-04-06', 'DNI', '09360790', 'CAPCHA', 'CAPCHA', 'FELIX', '2021-05-08', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL29', 'CARABAYLLO', '53', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(29, 'ACP-2021-000029', '2021-05-17', '450224', '1899088', '1336590', 2, '1987-10-15', 'DNI', '48193253', 'PACHECO', 'GUTIERREZ', 'MILAGROS', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL27', 'PUENTE PIEDRA', '34', 2, 'SOAT', 1, 1),
(30, 'ACP-2021-000030', '2021-05-17', '450023', '1899263', '1336657', 1, '1964-05-07', 'DNI', '06892165', 'HUARANGA', 'ROJAS', 'FREDY', '2021-05-17', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL04', 'COMAS', '57', 1, 'PARTICULAR', 1, 1),
(31, 'ACP-2021-000031', '2021-05-17', '446864', '1896652', '607219', 1, '1973-06-28', 'DNI', '09978974', 'BAUTISTA', 'CUEVA', 'JUAN', '2021-05-02', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '48', 1, 'PARTICULAR', 1, 1),
(32, 'ACP-2021-000032', '2021-05-17', '449689', '1898107', '1336251', 2, '1985-05-01', 'DNI', '44469369', 'ALVA', 'MARTINEZ', 'WILBER', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL16', 'PUENTE PIEDRA', '36', 1, 'PARTICULAR', 1, 1),
(33, 'ACP-2021-000033', '2021-05-17', '449692', '1898496', '1219409', 2, '1970-04-13', 'DNI', '07469035', 'JEANNEAU', 'CORNEJO', 'DENIS', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', ' CL48', 'CARABAYLLO', '51', 1, 'PARTICULAR', 1, 1),
(34, 'ACP-2021-000034', '2021-05-17', '438093', '1888321', '733889', 2, '1938-01-19', 'DNI', '06894119', 'HUERTA', 'GAMBOA', 'PLACIDO', '2021-03-21', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', 'C017', 'COMAS', '83', 1, 'PARTICULAR', 1, 1),
(35, 'ACP-2021-000035', '2021-05-17', '448736', '1898115', '932359', 2, '1971-03-07', 'DNI', '10392437', 'PISCOYA', 'MALAVER', 'ELDER', '2021-05-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '50', 1, 'PARTICULAR', 1, 1),
(36, 'ACP-2021-000036', '2021-05-17', '445831', '1895506', '255336', 1, '1968-08-31', 'DNI', '09544910', 'SILVA', 'ALCA', 'ANGEL', '2021-04-27', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '53', 1, 'PARTICULAR', 1, 1),
(37, 'ACP-2021-000037', '2021-05-18', '444537', '1894291', '262835', 2, '1959-05-20', 'DNI', '06902138', 'CASTRO', 'GUZMAN', 'VICTORIA', '2021-04-20', 'COVID VII - HOSPITALIZACIÓN ', 'C008', 'COMAS', '62', 2, 'PARTICULAR', 1, 1),
(38, 'ACP-2021-000038', '2021-05-18', '447606', '1893862', '250999', 1, '1965-09-22', 'DNI', '06878591', 'ESPINOZA', 'HUAMAN', 'NILA', '2021-05-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '56', 2, 'PARTICULAR', 1, 1),
(39, 'ACP-2021-000039', '2021-05-18', '1903122', '1897081', '1335823', 2, '1935-10-02', 'DNI', '32889076', 'ESTRELLA', 'LLANOS', 'CUSTODIO', '2021-05-06', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL13', 'COMAS', '86', 1, 'PARTICULAR', 1, 1),
(40, 'ACP-2021-000040', '2021-05-18', '450221', '1899459', '1336714', 3, '1960-07-20', 'DNI', '08637118', 'ALVARADO', 'RODRIGUEZ', 'RAUL', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL37', 'PUENTE PIEDRA', '61', 1, 'PARTICULAR', 1, 1),
(41, 'ACP-2021-000041', '2021-05-18', '449696', '1898441', '1336395', 2, '1995-07-02', 'DNI', '60087845', 'ROQUE', 'JARAMILLO', 'CESAR', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL40', 'SAN MARTIN DE PORRES', '26', 1, 'PARTICULAR', 1, 1),
(42, 'ACP-2021-000042', '2021-05-18', '450223', '1899192', '1336633', 2, '1989-02-08', 'DNI', '45595288', 'CHAVEZ', 'CRISOSTOMO', 'GIANCARLO', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL25', 'CARABAYLLO', '32', 1, 'PARTICULAR', 1, 1),
(43, 'ACP-2021-000043', '2021-05-18', '449694', '1898420', '1336386', 2, '1951-03-17', 'DNI', '06850616', 'PALLIN', 'HUARCAYA', 'ALEJANDRO', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL45', 'COMAS', '70', 1, 'PARTICULAR', 1, 1),
(44, 'ACP-2021-000044', '2021-05-18', '447603', '1887281', '204522', 1, '1972-05-10', 'DNI', '10396972', 'CALDERON', 'ARGUME', 'ISAAC', '2021-05-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '49', 1, 'PARTICULAR', 1, 1),
(45, 'ACP-2021-000045', '2021-05-19', '1904579', '1898538', '634164', 2, '1965-06-23', 'DNI', '09113777', 'BUITRON', 'VEGA', 'TELMA ROSALIA', '2021-05-12', 'SALUD OCUPACIONAL - CONSULTORIOS EXTERNOS', '', 'VILLA MARIA DEL TRIUNFO', '56', 2, 'PARTICULAR', 1, 1),
(46, 'ACP-2021-000046', '2021-05-19', '0', '1904362', '221448', 2, '1959-10-02', 'DNI', '09193811', 'REINA', 'RODRIGUEZ', 'ADELAIDA', '2021-05-11', 'SALUD OCUPACIONAL - CONSULTORIOS EXTERNOS', NULL, 'COMAS', '62', 2, 'PARTICULAR', 1, 1),
(47, 'ACP-2021-000047', '2021-05-19', '0', '1897247', '846432', 2, '1984-07-02', 'DNI', '42510126', 'FLORES', 'HUETE', 'DIANA YOLANDA', '2021-05-05', 'SALUD OCUPACIONAL - CONSULTORIOS EXTERNOS', NULL, 'COMAS', '37', 2, 'PARTICULAR', 1, 1),
(48, 'ACP-2021-000048', '2021-05-19', '449224', '1898174', '1170373', 3, '1938-02-23', 'DNI', '06933881', 'YSUSQUIZA', 'ARIAS VDA DE FLORES', 'MARGARITA', '2021-05-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '83', 2, 'SOAT', 1, 1),
(49, 'ACP-2021-000049', '2021-05-19', '448436', '1897944', '1336193', 2, '1969-08-19', 'DNI', '09545466', 'RAMIREZ', 'LOZANO DE DELGADO', 'ANA', '2021-05-10', 'COVID LEGADO - HOSPITALIZACIÓN ', 'C009', 'COMAS', '52', 2, 'PARTICULAR', 1, 1),
(50, 'ACP-2021-000050', '2021-05-19', '1898912', '1892871', '821090', 2, '1952-06-30', 'DNI', '06895144', 'CANALES', 'SUAREZ', 'JOSE ISMAEL', '2021-04-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '69', 1, 'PARTICULAR', 1, 1),
(51, 'ACP-2021-000051', '2021-05-19', '450400', '1899641', '833277', 1, '1955-12-25', 'DNI', '08740384', 'QUISPE', 'MALCA', 'JUANA', '2021-05-19', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL36', 'CARABAYLLO', '66', 2, 'PARTICULAR', 1, 1),
(52, 'ACP-2021-000052', '2021-05-19', '450228', '1899508', '1289162', 3, '1951-08-29', 'DNI', '32116792', 'VILLANUEVA', 'DE URQUIZA', 'MARIA', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL21', 'MAGDALENA DEL MAR', '70', 2, 'PARTICULAR', 1, 1),
(53, 'ACP-2021-000053', '2021-05-19', '448734', '1897459', '1336041', 2, '1952-11-19', 'DNI', '06209024', 'ZEVALLOS', 'RODRIGUEZ', 'LUIS', '2021-05-11', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL30', 'LOS OLIVOS', '69', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(54, 'ACP-2021-000054', '2021-05-19', '449688', '1898638', '1336457', 2, '1986-09-29', 'DNI', '43827657', 'NUÑEZ', 'CHACHAPOYAS', 'DECIDERIO', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL05', 'COMAS', '35', 1, 'PARTICULAR', 1, 1),
(55, 'ACP-2021-000055', '2021-05-19', '450399', '1898813', '704771', 2, '1978-10-03', 'DNI', '42642702', 'PAREDES', 'ESPINOZA', 'JIMMY', '2021-05-19', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL06', 'COMAS', '43', 1, 'PARTICULAR', 1, 1),
(56, 'ACP-2021-000056', '2021-05-21', '450784', '1900161', '1336928', 3, '1954-03-28', 'DNI', '07171635', 'RODRIGUEZ', 'HURTADO', 'SANTOS', '2021-05-21', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL30', 'COMAS', '67', 2, 'PARTICULAR', 1, 1),
(57, 'ACP-2021-000057', '2021-05-21', '449225', '1898514', '1179507', 2, '1964-05-22', 'DNI', '06244998', 'RODRIGUEZ', 'CANICOBA', 'AMERICO', '2021-05-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '57', 1, 'PARTICULAR', 1, 1),
(58, 'ACP-2021-000058', '2021-05-21', '1906255', '1900214', '169433', 2, '1960-02-29', 'DNI', '06829321', 'CRISOSTOMO', 'VASQUEZ', 'JUANA', '2021-05-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 1, 1),
(59, 'ACP-2021-000059', '2021-05-21', '1906070', '1900029', '583956', 1, '1951-10-29', 'DNI', '08277253', 'CASTRO', 'GARRO', 'JULIAN', '2021-05-20', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL05', 'COMAS', '70', 1, 'PARTICULAR', 1, 1),
(60, 'ACP-2021-000060', '2021-05-21', '450748', '1900132', '1336918', 1, '1931-09-20', 'DNI', '33570439', 'GALVEZ', 'RODAS', 'CIRO', '2021-05-20', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL42', 'ANCON', '90', 1, 'PARTICULAR', 1, 1),
(61, 'ACP-2021-000061', '2021-05-21', '445813', '1895580', '1269227', 2, '1952-09-02', 'DNI', '22753645', 'NOLASCO', 'MIDOLO', 'ESTEBAN', '2021-04-27', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL04', 'COMAS', '69', 1, 'PARTICULAR', 1, 1),
(62, 'ACP-2021-000062', '2021-05-21', '450235', '1895256', '96012', 1, '1968-11-18', 'DNI', '09477022', 'ALLAUCA', 'SOTELO', 'LUCY', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL03', 'COMAS', '53', 2, 'PARTICULAR', 1, 1),
(63, 'ACP-2021-000063', '2021-05-21', '450237', '1899526', '1336727', 1, '1962-09-10', 'DNI', '10438710', 'CAMARENA', 'CABALLERO', 'WILVER', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL12', 'CARABAYLLO', '59', 1, 'PARTICULAR', 1, 1),
(64, 'ACP-2021-000064', '2021-05-21', '451679', '1898982', '1336560', 1, '1982-04-27', 'DNI', '42386539', 'DIESTRA', 'FLORES', 'MAURA', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL16', 'PUENTE PIEDRA', '39', 2, 'PARTICULAR', 1, 1),
(65, 'ACP-2021-000065', '2021-05-23', '450943', '1900348', '1087967', 3, '1956-07-09', 'DNI', '19546367', 'MARCELO', 'ESTEBAN', 'ANTONIA', '2021-05-21', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '65', 2, 'PARTICULAR', 1, 1),
(66, 'ACP-2021-000066', '2021-05-23', '451680', '1900226', '1239824', 1, '1957-11-10', 'DNI', '06854425', 'ROMERO', 'ESPINOZA', 'JOYA', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '64', 2, 'PARTICULAR', 1, 1),
(67, 'ACP-2021-000067', '2021-05-23', '451683', '1898906', '1186051', 1, '1952-04-20', 'DNI', '01042552', 'SILVA', 'SANDOVAL', 'YOLANDA', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '69', 2, 'PARTICULAR', 1, 1),
(68, 'ACP-2021-000068', '2021-05-23', '451993', '1898978', '1336558', 1, '1988-02-07', 'DNI', '45855221', 'POCLIN', 'MENDOZA', 'WILBERT', '2021-05-26', 'COVID UCI - HOSPITALIZACIÓN ', '', 'COMAS', '33', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(69, 'ACP-2021-000069', '2021-05-23', '450934', '1900336', '1132150', 3, '1972-07-03', 'DNI', '09971482', 'CARRILLO', 'QUIROGA', 'MARCO', '2021-05-21', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '49', 1, 'PARTICULAR', 1, 1),
(70, 'ACP-2021-000070', '2021-05-23', '450932', '1900334', '1336965', 3, '1960-05-21', 'DNI', '08535587', 'LEON', 'ANTAYHUA', 'RAUL', '2021-05-21', 'CORONAVIRUS - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '61', 1, 'PARTICULAR', 1, 1),
(71, 'ACP-2021-000071', '2021-05-23', '451875', '1900234', '1336940', 1, '1968-08-11', 'DNI', '09518612', 'DIAZ', 'BRIOS', 'ENRIQUE', '2021-05-26', 'COVID UCI - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '53', 1, 'PARTICULAR', 1, 1),
(72, 'ACP-2021-000072', '2021-05-24', '451354', '1900642', '1154977', 1, '1972-05-09', 'DNI', '05349441', 'PINEDO', 'IZQUIERDO', 'OFELIA', '2021-05-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '49', 2, 'PARTICULAR', 1, 1),
(73, 'ACP-2021-000073', '2021-05-24', '451353', '1900634', '1337051', 1, '1952-02-21', 'DNI', '07155112', 'REATEGUI', 'GUERRA', 'MIRTHA', '2021-05-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '69', 2, 'PARTICULAR', 1, 1),
(74, 'ACP-2021-000074', '2021-05-24', '451686', '1900504', '1337007', 1, '1986-08-30', 'DNI', '43858360', 'AMADO', 'GUERRERO', 'ROSA', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '35', 2, 'PARTICULAR', 1, 1),
(75, 'ACP-2021-000075', '2021-05-24', '445682', '1895119', '597057', 1, '1976-03-06', 'DNI', '80066220', 'NOLASCO', 'HILARIO', 'LUIS', '2021-04-26', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', '', 'COMAS', '45', 1, 'PARTICULAR', 1, 1),
(76, 'ACP-2021-000076', '2021-05-24', '1903969', '1897928', '1336188', 2, '1982-07-25', 'DNI', '46338604', 'HUAMANCCARI', 'AÑO', 'YANET ', '2021-05-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '39', 2, 'PARTICULAR', 1, 1),
(77, 'ACP-2021-000077', '2021-05-24', '1902948', '1896907', '1335749', 2, '1960-08-10', 'DNI', '06041838', 'INGAROCA', 'VARGAS', 'NERI', '2021-05-10', 'COVID UCI - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '61', 1, 'SOAT', 1, 1),
(78, 'ACP-2021-000078', '2021-05-24', '440495', '1890628', '86365', 1, '1969-09-10', 'DNI', '09730060', 'FLORES', 'LAZARO', 'LUIS', '2021-04-01', 'COVID VII - HOSPITALIZACIÓN ', '', 'COMAS', '52', 1, 'PARTICULAR', 1, 1),
(79, 'ACP-2021-000079', '2021-05-24', '446672', '1896343', '1335549', 1, '1972-08-28', 'DIE', '11418077', 'VERDE', 'BENAVIDES', 'MIGUEL', '2021-05-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '49', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(80, 'ACP-2021-000080', '2021-05-24', '450504', '1899322', '1336679', 3, '1949-02-21', 'DNI', '28306722', 'QUISPE', 'TORRES', 'MAXIMILIANA', '2021-05-19', 'COVID UCI - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '72', 2, 'SOAT', 1, 1),
(81, 'ACP-2021-000081', '2021-05-24', '446669', '1896280', '1335488', 3, '1984-06-17', 'DNI', '42828368', 'YCHPAS', 'VILCA', 'KARINA', '2021-05-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '37', 2, 'PARTICULAR', 1, 1),
(82, 'ACP-2021-000082', '2021-05-24', '445681', '1895363', '358404', 3, '1971-08-13', 'DNI', '10113788', 'CONDORI', 'ANGELINO', 'JOHNNY', '2021-04-26', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', '', 'COMAS', '50', 1, 'PARTICULAR', 1, 1),
(83, 'ACP-2021-000083', '2021-05-24', '451894', '1900573', '1337032', 1, '1963-12-29', 'CE', '8732952', 'GONZALES', 'PAREDES', 'SOL', '2021-05-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '58', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(84, 'ACP-2021-000084', '2021-05-24', '1906565', '1900524', '1337015', 2, '1984-08-31', 'DNI', '45638538', 'CARHUAZ', 'VILLARREAL', 'IVAN ALEX', '2021-06-04', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'JUNIN', '37', 1, 'PARTICULAR', 1, 1),
(85, 'ACP-2021-000085', '2021-05-24', '451626', '1900822', '1156002', 1, '1976-07-16', 'DNI', '10391887', 'PAMPAS', 'ROJAS', 'PERCY', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '45', 1, 'PARTICULAR', 1, 1),
(86, 'ACP-2021-000086', '2021-05-24', '451192', '1900562', '1337028', 3, '1984-03-08', 'DNI', '43478754', 'QUISPE', 'QUINTO', 'JUAN', '2021-05-22', 'CORONAVIRUS - EMERGENCIA', '', 'SAN JUAN DE LURIGANCHO', '37', 1, 'PARTICULAR', 1, 1),
(87, 'ACP-2021-000087', '2021-05-25', '449981', '1899423', '1094254', 1, '1974-09-19', 'DNI', '09980430', 'CONTRERAS', 'TICONA', 'EUCLIDES', '2021-05-17', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '47', 1, 'PARTICULAR', 1, 1),
(88, 'ACP-2021-000088', '2021-05-25', '450995', '1900394', '1336983', 3, '1965-10-21', 'DNI', '07515245', 'MUÑOZ', 'RIOS', 'ROSSANA', '2021-05-21', 'CORONAVIRUS - EMERGENCIA', '', 'LA MOLINA', '56', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(89, 'ACP-2021-000089', '2021-05-25', '448637', '1897876', '1336136', 1, '1955-11-05', 'DNI', '09019081', 'AGUILAR', 'GOMEZ', 'LEONCIO', '2021-05-10', 'MEDICINA - HOSPITALIZACIÓN ', '', 'COMAS', '66', 1, 'PARTICULAR', 1, 1),
(90, 'ACP-2021-000090', '2021-05-25', '451276', '1900644', '1236796', 1, '1931-02-12', 'DNI', '20548719', 'PAUCAR', 'AGUIRRE', 'FAUSTINA', '2021-05-23', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '90', 2, 'PARTICULAR', 1, 1),
(91, 'ACP-2021-000091', '2021-05-25', '451492', '1900838', '1109647', 2, '1936-08-14', 'DNI', '06901199', 'PASTOR', 'RAZA', 'LOLA', '2021-05-24', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '85', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(92, 'ACP-2021-000092', '2021-05-25', '451895', '1900587', '1337036', 1, '1968-09-01', 'DNI', '44610904', 'GONZALES', 'ORBEGOZO', 'JOSE', '2021-05-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '53', 1, 'PARTICULAR', 1, 1),
(93, 'ACP-2021-000093', '2021-05-26', '1906862', '1900821', '1280076', 2, '1940-02-23', 'DNI', '09028181', 'QUISIYUPANQUI', 'TECSE', 'MACARIO', '2021-05-24', 'TRAUMASHOCK - EMERGENCIA', NULL, 'COMAS', '81', 1, 'PROGRAMA NACIONAL', 1, 1),
(94, 'ACP-2021-000094', '2021-05-26', '1898867', '1892826', '437285', 2, '1950-10-02', 'DNI', '09017936', 'PAULINO', 'VELIZ', 'TEOFILO', '2021-05-11', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', 'CL30', 'COMAS', '71', 1, 'PARTICULAR', 1, 1),
(95, 'ACP-2021-000095', '2021-05-26', '451030', '1900341', '1325123', 1, '1956-12-01', 'DNI', '16537352', 'LARA', 'CRUZADO', 'JORGE', '2021-05-22', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CHICLAYO', '65', 1, 'PARTICULAR', 1, 1),
(96, 'ACP-2021-000096', '2021-05-26', '451810', '1901095', '1337179', 3, '1955-12-25', 'DNI', '08543036', 'JARA', 'CHACON', 'MANUEL', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '66', 1, 'PARTICULAR', 1, 1),
(97, 'ACP-2021-000097', '2021-05-26', '1907081', '1901040', '835802', 2, '1952-03-21', 'DNI', '06933227', 'CHAVEZ', 'CARPIO', 'JORGE ADOLFO', '2021-05-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '69', 1, 'SOAT', 1, 1),
(98, 'ACP-2021-000098', '2021-05-26', '451839', '1901138', '1337191', 3, '1966-10-09', 'DNI', '09173481', 'VILA', 'MENDOZA DE LIÑAN', 'EMILIA', '2021-05-26', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '55', 2, 'PARTICULAR', 1, 1),
(99, 'ACP-2021-000099', '2021-05-26', '1907106', '1901065', '169770', 2, '1980-08-26', 'DNI', '40609520', 'DURAND', 'SANCHEZ', 'MARIA', '2021-06-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '41', 2, 'PARTICULAR', 1, 1),
(100, 'ACP-2021-000100', '2021-05-27', '451967', '1901270', '1337235', 3, '1961-07-29', 'DNI', '06891299', 'ARANDA', 'GARCIA', 'JORGE', '2021-05-26', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '60', 1, 'PARTICULAR', 1, 1),
(101, 'ACP-2021-000101', '2021-05-27', '451980', '1901278', '1337238', 1, '1952-07-18', 'DNI', '06915010', 'CHAVEZ', 'MILLA', 'JULIO', '2021-05-26', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '69', 1, 'SOAT', 1, 1),
(102, 'ACP-2021-000102', '2021-05-27', '452403', '1901266', '1299409', 3, '1980-06-11', 'DIE', '15034538', 'MACHADO', 'MEDINA', 'GLEIDYS', '2021-05-28', 'COVID UCI - HOSPITALIZACIÓN ', '', 'COMAS', '41', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(103, 'ACP-2021-000103', '2021-05-27', '451985', '1901283', '1280961', 3, '1981-10-21', 'DNI', '42515485', 'ENRIQUEZ', 'ESPIRITU', 'YARI', '2021-05-26', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '40', 2, 'PARTICULAR', 1, 1),
(104, 'ACP-2021-000104', '2021-05-27', '445258', '1895153', '235498', 1, '1944-01-04', 'DNI', '06863133', 'CUCCHE', 'PEREZ', 'IGNACIO', '2021-04-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '77', 1, 'PARTICULAR', 1, 1),
(105, 'ACP-2021-000105', '2021-05-28', '452208', '1901423', '427787', 2, '1988-07-26', 'DNI', '47008110', 'OLAYA', 'AGUILAR', 'VANESSA', '2021-05-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '33', 2, 'PARTICULAR', 1, 1),
(106, 'ACP-2021-000106', '2021-05-28', '452207', '1901441', '1337278', 2, '1955-08-14', 'DNI', '06565235', 'RIOS', 'CAMARENA', 'MARGARITA', '2021-05-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN JUAN DE LURIGANCHO', '66', 2, 'PARTICULAR', 1, 1),
(107, 'ACP-2021-000107', '2021-05-28', '452170', '1901229', '1337220', 2, '1981-01-19', 'DNI', '41979207', 'TERRONES', 'QUISPE', 'EDGAR', '2021-05-27', 'COVID VI HOSPITALIZACION (PAB_PEDIATRIA) - HOSPITALIZACIÓN ', '', 'COMAS', '40', 1, 'PARTICULAR', 1, 1),
(108, 'ACP-2021-000108', '2021-05-28', '452356', '1901606', '1321508', 1, '1966-09-28', 'DNI', '06904754', 'JUAREZ', 'ESPINOZA', 'JAVIER', '2021-05-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '55', 1, 'PARTICULAR', 1, 1),
(109, 'ACP-2021-000109', '2021-05-28', '452334', '1901581', '1234651', 3, '1961-10-02', 'DNI', '16542300', 'OLIVA', 'VILLANUEVA', 'JOSE', '2021-05-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '60', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(110, 'ACP-2021-000110', '2021-05-29', '452129', '1901419', '328847', 3, '1953-08-29', 'DNI', '08086781', 'FLORES', 'MALDONADO', 'GLORIA', '2021-05-27', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '68', 2, 'PARTICULAR', 1, 1),
(111, 'ACP-2021-000111', '2021-05-31', '452289', '1901554', '581016', 2, '1987-12-24', 'DNI', '44834427', 'GOMEZ', 'ORELLANA', 'VANIA', '2021-05-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '34', 2, 'PARTICULAR', 1, 1),
(112, 'ACP-2021-000112', '2021-05-31', '452388', '1901633', '112293', 3, '1955-11-19', 'DNI', '06834044', 'PACHECO', 'CERRON', 'MARIA', '2021-05-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '66', 2, 'PARTICULAR', 1, 1),
(113, 'ACP-2021-000113', '2021-05-31', '452898', '1901816', '1215322', 1, '1994-06-07', 'DNI', '76046164', 'LIÑAN', 'CHAVEZ', 'ROBINSON', '2021-05-31', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '27', 1, 'PARTICULAR', 1, 1),
(114, 'ACP-2021-000114', '2021-05-31', '452834', '1902028', '267188', 3, '1957-05-02', 'DNI', '06829540', 'CAJALEON', 'GASPAR', 'ALEJANDRO', '2021-05-30', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '64', 1, 'PARTICULAR', 1, 1),
(115, 'ACP-2021-000115', '2021-05-31', '452686', '1901908', '1337421', 3, '1959-11-15', 'DNI', '48965531', 'POMA', 'SALAZAR', 'FLORISA', '2021-05-29', 'CORONAVIRUS - EMERGENCIA', '', 'LA OROYA', '62', 2, 'PARTICULAR', 1, 1),
(116, 'ACP-2021-000116', '2021-05-31', '450481', '1899894', '1042814', 1, '1940-11-19', 'DNI', '06849292', 'MELGAREJO', 'MONTALVO DE BALMACEDA', 'BERTILA', '2021-05-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '81', 2, 'PARTICULAR', 1, 1),
(117, 'ACP-2021-000117', '2021-06-01', '452430', '1901680', '637665', 2, '1965-09-16', 'DNI', '80565221', 'GUEVARA', 'MALHABER', 'EDITHA', '2021-05-28', 'MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '56', 2, 'PARTICULAR', 1, 1),
(118, 'ACP-2021-000118', '2021-06-01', '454160', '1902269', '1337528', 1, '1944-10-11', 'DNI', '31938623', 'SALINAS', 'ALVARADO', 'LUISA', '2021-06-05', 'MEDICINA - HOSPITALIZACIÓN ', '', 'OCROS', '77', 2, 'PARTICULAR', 1, 1),
(119, 'ACP-2021-000119', '2021-06-01', '453850', '1902194', '590725', 2, '1966-10-06', 'DNI', '07723192', 'DUFFAUT', 'GUEMBES', 'MARIA', '2021-06-04', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '55', 2, 'PARTICULAR', 1, 1),
(120, 'ACP-2021-000120', '2021-06-01', '453852', '1902192', '673537', 2, '1972-10-30', 'DNI', '09966862', 'CARRERA', 'MELENDEZ', 'JOSE', '2021-06-04', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '49', 1, 'PARTICULAR', 1, 1),
(121, 'ACP-2021-000121', '2021-06-01', '453084', '1902188', '1337509', 2, '2000-12-07', 'DNI', '70564669', 'VALLEJOS', 'CORRO', 'ALEXANDER', '2021-05-31', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '21', 1, 'PARTICULAR', 1, 1),
(122, 'ACP-2021-000122', '2021-06-01', '452817', '1902011', '1337463', 3, '1962-05-28', 'DNI', '09040826', 'ROMAÑA', 'SOLSOL', 'JOSE', '2021-05-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '59', 1, 'PARTICULAR', 1, 1),
(123, 'ACP-2021-000123', '2021-06-01', '450358', '1899707', '594234', 3, '1963-07-23', 'DNI', '06944579', 'ARAOZ', 'ZUÑIGA', 'JUSTO', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '58', 1, 'PARTICULAR', 1, 1),
(124, 'ACP-2021-000124', '2021-06-02', '448429', '1897871', '1336171', 2, '1955-08-19', 'DNI', '09002214', 'BALDEON', 'VALDEZ', 'ERNESTINA', '2021-05-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'VILLA MARIA DEL TRIUNFO', '66', 2, 'PARTICULAR', 1, 1),
(125, 'ACP-2021-000125', '2021-06-02', '1908291', '1902250', '1337523', 1, '1977-02-11', 'DNI', '10776254', 'ROJAS', 'RODRIGUEZ', 'ELI SAMUEL', '2021-06-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '44', 1, 'PARTICULAR', 1, 1),
(126, 'ACP-2021-000126', '2021-06-02', '453261', '1902401', '1337561', 1, '1953-12-13', 'DNI', '15287636', 'PALACIOS', 'BANDAN', 'PEPE', '2021-06-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '68', 1, 'PARTICULAR', 1, 1),
(127, 'ACP-2021-000127', '2021-06-02', '453301', '1902447', '1337571', 3, '1950-05-01', 'DNI', '07120806', 'PEREZ', 'SORIA', 'MAXIMO', '2021-06-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '71', 1, 'PARTICULAR', 1, 1),
(129, 'ACP-2021-000128', '2021-06-02', '0', '1827659', '1311129', 2, '1967-11-28', 'DNI', '09469023', 'CONTRERAS', 'GIBAJA', 'SATURNINA ELENA', '2021-05-20', 'COVID - HOSPITALIZACION', NULL, 'COMAS', '54', 2, 'PROGRAMA NACIONAL', 1, 1),
(130, 'ACP-2021-000129', '2021-06-02', '375451', '1827660', '1311130', 2, '1958-09-26', 'DNI', '07146387', 'ESTRADA', 'HUARANCCA', 'VIRGILIO', '2020-05-20', 'CORONAVIRUS - EMERGENCIA', 'H012', 'CARABAYLLO', '63', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(131, 'ACP-2021-000130', '2021-06-02', '453455', '1902589', '221328', 2, '1960-07-16', 'DNI', '10388198', 'ALZAMORA', 'MEDINA', 'CARMELON', '2021-06-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '61', 1, 'PARTICULAR', 1, 1),
(132, 'ACP-2021-000131', '2021-06-02', '455842', '1902460', '80954', 1, '1968-11-19', 'DNI', '09733347', 'CHUMBES', 'ROJAS', 'RAFAEL', '2021-06-13', 'COVID LEGADO - HOSPITALIZACIÓN ', 'CL41', 'COMAS', '53', 1, 'PARTICULAR', 1, 1),
(133, 'ACP-2021-000132', '2021-06-03', '452816', '1902005', '37652', 3, '1971-04-14', 'DNI', '80145883', 'MOLERO', 'RAYMI', 'BEATRIZ', '2021-05-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '50', 2, 'PARTICULAR', 1, 1),
(134, 'ACP-2021-000133', '2021-06-03', '453380', '1902340', '113374', 2, '1973-10-03', 'DNI', '09971995', 'RAMOS', 'SAENZ', 'MARGARITA', '2021-06-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '48', 2, 'PARTICULAR', 1, 1),
(135, 'ACP-2021-000134', '2021-06-03', '454663', '1902613', '1156483', 2, '1987-08-24', 'DNI', '44499337', 'RODRIGUEZ', 'NAVEDA', 'JUAN', '2021-06-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '34', 1, 'PARTICULAR', 1, 1),
(136, 'ACP-2021-000135', '2021-06-04', '1908719', '1902678', '616802', 3, '1967-04-26', 'DNI', '09466831', 'MENDOZA', 'REVILLA', 'ALFREDO EDUARDO', '2021-06-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '54', 1, 'PARTICULAR', 1, 1),
(137, 'ACP-2021-000136', '2021-06-04', '453499', '1902652', '1337636', 3, '1955-05-03', 'DNI', '08554136', 'GONZALES', 'EGUSQUIZA', 'BERTHA', '2021-06-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '66', 2, 'PARTICULAR', 1, 1),
(138, 'ACP-2021-000137', '2021-06-04', '453266', '1902356', '713937', 3, '1951-06-01', 'DNI', '06880338', 'DE LA CRUZ', 'AVILA', 'SEGUNDO', '2021-06-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '70', 1, 'PARTICULAR', 1, 1),
(139, 'ACP-2021-000138', '2021-06-04', '453717', '1902904', '1307788', 1, '1964-04-12', 'DNI', '00033764', 'CAPUENA', 'ASPAJO', 'MARIA', '2021-06-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '57', 2, 'SOAT', 1, 1),
(140, 'ACP-2021-000139', '2021-06-04', '453851', '1902876', '1337698', 2, '1961-09-23', 'DNI', '25459554', 'CORDOVA', 'ALONSO', 'CARLOS', '2021-06-04', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 1, 1),
(141, 'ACP-2021-000140', '2021-06-04', '1908961', '1902920', '1337710', 2, '1991-10-27', 'DNI', '47597172', 'ALMANZA', 'CCAMA', 'ALEX DANIEL', '2021-06-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '30', 1, 'PARTICULAR', 1, 1),
(142, 'ACP-2021-000141', '2021-06-04', '453761', '1902932', '987579', 2, '1976-09-26', 'DNI', '25836893', 'SANTOS', 'HOLGUIN', 'ROBERTO', '2021-06-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '45', 1, 'PARTICULAR', 1, 1),
(143, 'ACP-2021-000142', '2021-06-05', '455841', '1903260', '211403', 1, '1983-02-11', 'DNI', '41646789', 'FERNANDEZ', 'MENDIETA', 'LENNART', '2021-06-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '38', 1, 'PARTICULAR', 1, 1),
(144, 'ACP-2021-000143', '2021-06-05', '454755', '1903062', '548921', 1, '1963-08-09', 'DNI', '08381097', 'SALAS', 'GUZMAN', 'JAVIER', '2021-06-08', 'MEDICINA - HOSPITALIZACIÓN ', '', 'COMAS', '58', 1, 'PARTICULAR', 1, 1),
(145, 'ACP-2021-000144', '2021-06-05', '454780', '1903135', '473047', 1, '1960-10-11', 'DNI', '09232069', 'APOLAYA', 'ACOSTA', 'LUIS', '2021-06-08', 'MEDICINA - HOSPITALIZACIÓN ', '', 'COMAS', '61', 1, 'PARTICULAR', 1, 1),
(146, 'ACP-2021-000145', '2021-06-05', '454644', '1902396', '1337559', 1, '1985-08-10', 'DNI', '43093508', 'SHAPIAMA', 'VALLES', 'NELSON', '2021-06-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '36', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(147, 'ACP-2021-000146', '2021-06-05', '453714', '1902873', '354867', 3, '1961-09-17', 'DNI', '06822868', 'LLAMOCCA', 'PRADO', 'JOSE', '2021-06-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 1, 1),
(148, 'ACP-2021-000147', '2021-06-07', '454328', '1903492', '1337887', 3, '1960-10-07', 'DNI', '06657692', 'RIVAS', 'SOLORZANO', 'VICTORIA', '2021-06-06', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '61', 2, 'PARTICULAR', 1, 1),
(149, 'ACP-2021-000148', '2021-06-07', '454935', '1903322', '341444', 1, '1990-04-25', 'DNI', '46438277', 'ALZAMORA', 'MONDRAGON', 'JORGE', '2021-06-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '31', 1, 'PARTICULAR', 1, 1),
(150, 'ACP-2021-000149', '2021-06-07', '454180', '1903349', '326564', 1, '1968-01-31', 'DNI', '10392945', 'VELASQUEZ', 'AVALOS', 'OSCAR', '2021-06-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '53', 1, 'PARTICULAR', 1, 1),
(151, 'ACP-2021-000150', '2021-06-07', '453683', '1902820', '1337676', 2, '1984-12-18', 'DNI', '43327737', 'ALVA', 'CACHIQUE', 'DIANA', '2021-06-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '37', 2, 'PARTICULAR', 1, 1),
(152, 'ACP-2021-000151', '2021-06-08', '453535', '1902296', '1015941', 1, '2009-04-23', 'DNI', '63570876', 'ONOFRE', 'NAZARIO', 'PATRICK', '2021-06-02', 'PEDIATRIA - HOSPITALIZACIÓN ', '', 'COMAS', '12', 1, 'PARTICULAR', 1, 1),
(153, 'ACP-2021-000152', '2021-06-08', '454872', '1903679', '1337950', 1, '1998-03-10', 'DNI', '60259728', 'LOPEZ', 'MATOS', 'GABINA', '2021-06-08', 'OBSTETRICIA - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '23', 2, 'PARTICULAR', 1, 1),
(154, 'ACP-2021-000153', '2021-06-08', '454933', '1903284', '440238', 1, '1966-04-20', 'DNI', '45099391', 'MALLQUI', 'LAURENCIO', 'QUEVEDO', '2021-06-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '55', 1, 'PARTICULAR', 1, 1),
(155, 'ACP-2021-000154', '2021-06-08', '1909751', '1903710', '410452', 2, '1986-12-25', 'DNI', '44086759', 'ALZAMORA', 'MONDRAGON', 'MANUEL', '2021-06-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '35', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(156, 'ACP-2021-000155', '2021-06-08', '453360', '1902481', '1337583', 2, '1967-12-30', 'DNI', '08680845', 'JAQUE', 'VERGARAY', 'HUGO', '2021-06-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '54', 1, 'SOAT', 1, 1),
(157, 'ACP-2021-000156', '2021-06-08', '454641', '1903756', '1337969', 3, '1951-04-23', 'DNI', '08711591', 'SILVA', 'VILCHEZ', 'CESAR', '2021-06-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CALLAO', '70', 1, 'SOAT', 1, 1),
(158, 'ACP-2021-000157', '2021-06-08', '454550', '1903691', '1337953', 1, '1943-10-05', 'DNI', '08466806', 'SANCHEZ', 'AGUILAR', 'FROILAN', '2021-06-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '78', 1, 'PARTICULAR', 1, 1),
(159, 'ACP-2021-000158', '2021-06-09', '450726', '1900102', '1298560', 1, '1941-05-03', 'DNI', '06921471', 'ONSEHUAY', 'OSORIO', 'MAURA', '2021-05-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '80', 2, 'PARTICULAR', 1, 1),
(160, 'ACP-2021-000159', '2021-06-09', '1909903', '1903862', '1107097', 2, '1973-04-12', 'DNI', '07760458', 'VEGA', 'ALEJANDRO', 'JUAN', '2021-06-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '48', 1, 'PARTICULAR', 1, 1),
(161, 'ACP-2021-000160', '2021-06-10', '449693', '1898749', '200448', 2, '1959-06-21', 'DNI', '06940872', 'TAPULLIMA', 'SALDAÑA', 'MARINA', '2021-05-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '62', 2, 'PARTICULAR', 1, 1),
(162, 'ACP-2021-000161', '2021-06-10', '1910249', '1904208', '43737', 2, '1970-01-19', 'DNI', '22516365', 'VASQUEZ', 'CONSA', 'JULIO', '2021-06-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '51', 1, 'SOAT', 1, 1),
(163, 'ACP-2021-000162', '2021-06-10', '448671', '1898217', '1336307', 2, '1940-07-09', 'DNI', '06858227', 'BRICEÑO', 'FARFAN', 'GONZALO', '2021-05-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '81', 1, 'SOAT', 1, 1),
(164, 'ACP-2021-000163', '2021-06-11', '454135', '1903318', '199768', 1, '1941-03-27', 'DNI', '10392739', 'ENCALADA', 'MORALES', 'MARIA', '2021-06-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '80', 2, 'PARTICULAR', 1, 1),
(165, 'ACP-2021-000164', '2021-06-11', '455695', '1904161', '194146', 1, '1966-05-25', 'DNI', '06827023', 'TORRES', 'LONGINOTE', 'CARLOS', '2021-06-12', 'MEDICINA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '55', 1, 'PARTICULAR', 1, 1),
(166, 'ACP-2021-000165', '2021-06-11', '1910487', '1904446', '1338140', 2, '1976-04-02', 'DNI', '08172543', 'CHAUCA', 'CALVO', 'RAFAEL', '2021-06-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '45', 1, 'PARTICULAR', 1, 1),
(167, 'ACP-2021-000166', '2021-06-11', '455349', '1904445', '1338139', 3, '1953-09-22', 'DNI', '00817725', 'APUELA', 'CONCHE', 'MARIA', '2021-06-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '68', 2, 'PARTICULAR', 1, 1),
(168, 'ACP-2021-000167', '2021-06-11', '1909986', '1903945', '1338008', 3, '1961-03-09', 'DNI', '07424994', 'CHUZON', 'ALABAN', 'RICARDO', '2021-06-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 1, 1),
(169, 'ACP-2021-000168', '2021-06-11', '455418', '1904537', '1338159', 1, '1954-06-07', 'DNI', '19810782', 'YAURI', 'RAMIREZ', 'DAVID', '2021-06-11', 'CORONAVIRUS - EMERGENCIA', '', 'PUENTE PIEDRA', '67', 1, 'PARTICULAR', 1, 1),
(170, 'ACP-2021-000169', '2021-06-12', '453264', '1902377', '1337554', 1, '1969-09-02', 'DNI', '09628403', 'PERALES', 'CABEZAS', 'PEDRO', '2021-06-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '52', 1, 'PARTICULAR', 1, 1),
(171, 'ACP-2021-000170', '2021-06-12', '444847', '1894735', '980527', 2, '1980-02-27', 'DNI', '41951009', 'NOLASCO', 'HILARIO', 'JULIAN', '2021-04-22', 'COVID VII - HOSPITALIZACIÓN ', '', 'AMARILIS', '41', 1, 'PARTICULAR', 1, 1),
(172, 'ACP-2021-000171', '2021-06-12', '1910415', '1904374', '1338122', 2, '1991-03-18', 'DNI', '46864205', 'LOPEZ', 'MONTALVO', 'RICHARD', '2021-06-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '30', 1, 'PARTICULAR', 1, 1),
(173, 'ACP-2021-000172', '2021-06-12', '455243', '1904329', '1148569', 3, '1965-09-18', 'DNI', '06902603', 'VERGARA', 'RODRIGUEZ', 'RODOLFO', '2021-06-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '56', 1, 'PARTICULAR', 1, 1),
(174, 'ACP-2021-000173', '2021-06-12', '455645', '1904761', '960050', 3, '1967-07-11', 'DNI', '09470765', 'FERNANDEZ', 'MONTENEGRO', 'CARLOS', '2021-06-12', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '54', 1, 'PARTICULAR', 1, 1),
(175, 'ACP-2021-000174', '2021-06-12', '1910598', '1904557', '217878', 2, '1942-12-06', 'DNI', '00032368', 'PEREZ', 'CORAL', 'MANUEL', '2021-06-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'HONORIA', '79', 1, 'PARTICULAR', 1, 1),
(176, 'ACP-2021-000175', '2021-06-14', '455681', '1904797', '427977', 1, '1969-03-31', 'DNI', '09607189', 'MENDOZA', 'TORIBIO', 'RAUL', '2021-06-12', 'CORONAVIRUS - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '52', 1, 'PARTICULAR', 1, 1),
(177, 'ACP-2021-000176', '2021-06-14', '1907628', '1901587', '1337319', 3, '1982-09-03', 'CE', '002965053', 'JIMENEZ', 'REQUENA', 'LUISCRI', '2021-05-29', 'COVID UCI - HOSPITALIZACIÓN ', '', 'COMAS', '39', 1, 'PARTICULAR', 1, 1),
(178, 'ACP-2021-000177', '2021-06-15', '455972', '1904998', '1338219', 1, '1965-06-30', 'DNI', '15655331', 'VASQUEZ', 'ESPINOZA', 'LUCILA', '2021-06-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '56', 2, 'PARTICULAR', 1, 1),
(179, 'ACP-2021-000178', '2021-06-15', '1910871', '1904830', '1338253', 1, '1950-01-28', 'DNI', '15280950', 'OSCANOA', 'BARRETO', 'INES', '2021-06-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CANTA', '71', 2, 'PARTICULAR', 1, 1),
(180, 'ACP-2021-000179', '2021-06-15', '447087', '1896483', '1335602', 2, '1961-03-13', 'DNI', '32601373', 'MIRANDA', 'VILLANUEVA', 'EPIFANIO', '2021-05-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '60', 1, 'SOAT', 1, 1),
(181, 'ACP-2021-000180', '2021-06-15', '1910846', '1904805', '1338242', 2, '1987-09-09', 'PAS', '150269676', 'GRIMALDO', 'BARRERA', 'KEILE', '2021-06-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '34', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(182, 'ACP-2021-000181', '2021-06-16', '455787', '1904876', '1282239', 3, '1950-11-12', 'DNI', '06233992', 'SANTI', 'RAMIREZ', 'MELANIO', '2021-06-13', 'CORONAVIRUS - EMERGENCIA', '', 'UPAHUACHO', '71', 1, 'PARTICULAR', 1, 1),
(183, 'ACP-2021-000182', '2021-06-16', '1910882', '1904841', '63066', 3, '1957-10-17', 'DNI', '06830948', 'TEJADA', 'LLAUCE', 'HUGO', '2021-06-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '64', 1, 'PARTICULAR', 1, 1),
(184, 'ACP-2021-000183', '2021-06-17', '1911492', '1905451', '935126', 3, '1957-10-29', 'DNI', '06879048', 'NUÑEZ', 'MORALES', 'HUMBERTO', '2021-06-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '64', 1, 'PARTICULAR', 1, 1),
(185, 'ACP-2021-000184', '2021-06-17', '1911043', '1905002', '243714', 3, '1963-04-12', 'DNI', '01766965', 'ROQUE', 'ESTAÑA', 'JULIA', '2021-06-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '58', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(186, 'ACP-2021-000185', '2021-06-17', '1904925', '1898884', '1336528', 2, '1972-04-03', 'DNI', '09340730', 'SANCHEZ', 'AMAT', 'JOHNNY', '2021-06-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN ISIDRO', '49', 1, 'SOAT', 1, 1),
(187, 'ACP-2021-000186', '2021-06-17', '1910676', '1904635', '1338190', 1, '2004-02-21', 'DNI', '81455260', 'CORPUNA', 'VENTURA', 'YASHIRA', '2021-06-12', 'OBSTETRICIA COVID - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '17', 2, 'PARTICULAR', 1, 1),
(188, 'ACP-2021-000187', '2021-06-18', '1911967', '1905926', '1227055', 1, '1962-10-18', 'DNI', '08500162', 'MAZA', 'PALACIOS', 'EDILBERTO', '2021-06-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '59', 1, 'PARTICULAR', 1, 1),
(189, 'ACP-2021-000188', '2021-06-18', '1911975', '1905934', '1338570', 1, '1939-10-20', 'CE', '17849817', 'PERALTA', 'MENDEZ', 'GUSTAVO', '2021-06-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '82', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(190, 'ACP-2021-000189', '2021-06-18', '1911985', '1905944', '1338573', 2, '1977-01-09', 'DNI', '10738340', 'RODRIGUEZ', 'MARTINEZ', 'JOSE', '2021-06-17', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '44', 1, 'PARTICULAR', 1, 1),
(191, 'ACP-2021-000190', '2021-06-18', '1911848', '1905807', '692275', 1, '1956-10-20', 'DNI', '06049688', 'NAVARRO', 'VASQUEZ', 'CAIN', '2021-06-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '65', 1, 'PARTICULAR', 1, 1),
(192, 'ACP-2021-000191', '2021-06-19', '1911935', '1905894', '1199427', 3, '1951-04-21', 'DNI', '45799681', 'QUISPE', 'SANCHEZ', 'YLDA', '2021-06-17', 'CORONAVIRUS - EMERGENCIA', '', 'SANTA ROSA DE QUIVES', '70', 2, 'PARTICULAR', 1, 1),
(193, 'ACP-2021-000192', '2021-06-21', '1912262', '1906221', '517576', 2, '1970-06-06', 'DNI', '09740087', 'TEJEIRA', 'FLORES', 'WILLY', '2021-06-19', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '51', 1, 'PARTICULAR', 1, 1),
(194, 'ACP-2021-000193', '2021-06-21', '1911883', '1905842', '732797', 1, '1980-11-28', 'DNI', '40702469', 'SALDAÑA', 'CERNA', 'RONALD', '2021-06-20', 'COVID UCI - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '41', 1, 'PARTICULAR', 1, 1),
(195, 'ACP-2021-000194', '2021-06-21', '1912465', '1906424', '869202', 1, '1959-12-22', 'DNI', '15591001', 'ROMERO', 'TANTA', 'MANUEL', '2021-06-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '62', 1, 'PARTICULAR', 1, 1),
(196, 'ACP-2021-000195', '2021-06-21', '1912720', '1906679', '1338820', 1, '1974-09-02', 'DNI', '10205169', 'CADILLO', 'MARCOS', 'HUMBERTO', '2021-06-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '47', 1, 'PARTICULAR', 1, 1),
(197, 'ACP-2021-000196', '2021-06-22', '1912767', '1906726', '948965', 1, '1955-04-20', 'DNI', '41689809', 'MINA', 'ROQUE', 'ELIAS', '2021-06-21', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '66', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(198, 'ACP-2021-000197', '2021-06-22', '1912962', '1906921', '572368', 1, '1975-07-29', 'DNI', '33819289', 'SANCHEZ', 'SALDAÑA', 'MERI', '2021-06-22', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '46', 2, 'PARTICULAR', 1, 1),
(199, 'ACP-2021-000198', '2021-06-23', '1912784', '1906743', '1279861', 1, '1951-09-12', 'DNI', '07356967', 'PAREDES', 'BARBOZA', 'ROBERTO', '2021-06-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '70', 1, 'PARTICULAR', 1, 1),
(200, 'ACP-2021-000199', '2021-06-25', '1913512', '1907471', '622143', 1, '1979-08-28', 'DNI', '40556820', 'SOTO', 'OSORIO', 'YANINA SOLEDAD', '2021-06-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '42', 2, 'SOAT', 1, 1),
(201, 'ACP-2021-000200', '2021-06-25', '1913206', '1907165', '762107', 1, '1960-10-02', 'DNI', '08568688', 'CASTRO', 'SINCHI', 'JORGE', '2021-06-23', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '61', 1, 'PARTICULAR', 1, 1),
(202, 'ACP-2021-000201', '2021-06-25', '1913546', '1907505', '1338852', 1, '1971-01-16', 'DNI', '09610131', 'PALACIOS', 'RICALDI', 'MIRTHA', '2021-06-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '50', 2, 'PARTICULAR', 1, 1),
(203, 'ACP-2021-000202', '2021-06-26', '1905387', '1899346', '109201', 2, '1975-02-20', 'DNI', '10381767', 'COBEÑAS', 'JARA', 'OMAR', '2021-05-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '46', 1, 'PARTICULAR', 1, 1),
(204, 'ACP-2021-000203', '2021-06-26', '1909382', '1903341', '1337838', 3, '1953-10-05', 'DNI', '08658555', 'CORDOVA', 'GRIMALDO', 'JUAN', '2021-06-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '68', 1, 'PARTICULAR', 1, 1),
(205, 'ACP-2021-000204', '2021-06-26', '1913764', '1907723', '347290', 1, '1963-10-03', 'DNI', '06843001', 'YUPANQUI', 'HUANCAYA', 'ABEL FRANCISCO', '2021-06-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '58', 1, 'PARTICULAR', 1, 1),
(206, 'ACP-2021-000205', '2021-06-28', '1914167', '1908126', '578257', 1, '1965-04-14', 'DNI', '08039077', 'HUAMANI', 'CHAVEZ', 'FREDDY RUBEN', '2021-06-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '56', 1, 'CONVENIOS PÚBLICOS', 1, 1),
(207, 'ACP-2021-000206', '2021-06-28', '1913912', '1907871', '1254301', 1, '1980-01-10', 'DNI', '40688338', 'TREBEJO', 'AGAMA', 'WILMAN ALFREDO', '2021-06-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CHACCHO', '41', 1, 'PARTICULAR', 1, 1),
(208, 'ACP-2021-000207', '2021-06-28', '1914161', '1908120', '796304', 1, '1991-01-16', 'DNI', '47878500', 'RIVERA', 'VARA', 'ANA MARIA', '2021-06-27', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '30', 2, 'PARTICULAR', 1, 1),
(209, 'ACP-2021-000208', '2021-06-28', '1913803', '1907762', '256170', 1, '1984-11-18', 'DNI', '42805046', 'RIVERA', 'VARA', 'JULIO CESAR', '2021-06-26', 'COVID UCI - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '37', 1, 'PARTICULAR', 1, 1),
(210, 'ACP-2021-000209', '2021-06-28', '1913938', '1907897', '986000', 1, '1973-10-15', 'DNI', '06785135', 'YNOÑAN', 'VENTURA', 'RUBEN ', '2021-06-26', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '48', 1, 'PARTICULAR', 1, 1),
(211, 'ACP-2021-000210', '2021-07-02', '1914372', '1908331', '1296233', 1, '1992-01-04', 'DIE', '003124272', 'ARANGUREN', 'PEREZ', 'ANGELO ANTONIO', '2021-06-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '29', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(212, 'ACP-2021-000211', '2021-07-03', '1914579', '1908538', '343380', 1, '1964-12-09', 'DNI', '21467237', 'QUISPE', 'ENCISO', 'NORA MARIA', '2021-06-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '57', 2, 'PARTICULAR', 3, 1),
(213, 'ACP-2021-000212', '2021-07-03', '1914390', '1908349', '1064726', 1, '1978-11-24', 'DNI', '40063727', 'SANCHEZ', 'FERNANDINI', 'LUIS ANTONIO', '2021-07-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '43', 1, 'PARTICULAR', 3, 1),
(214, 'ACP-2021-000213', '2021-07-03', '1914913', '1908872', '269904', 1, '1966-06-24', 'DNI', '06923155', 'RUIZ', 'TAVARA', 'VICTOR EDUARDO', '2021-07-01', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '55', 1, 'PARTICULAR', 6, 1);
INSERT INTO `psyem_atencion` (`idAtencion`, `correlativo_Atencion`, `fRegistroAtencion`, `idEpisodio`, `cuentaAtencion`, `historiaAtencion`, `idEstadoPacAtencion`, `fechaPacNacimiento`, `tipdocAtencion`, `nrodocAtencion`, `apPaternoAtencion`, `apMaternoAtencion`, `nombAtencion`, `fIngresoAtencion`, `servAtencion`, `camaAtencion`, `distritoAtencion`, `edadAtencion`, `tipSexoAtencion`, `financiaAtencion`, `idURegAtencion`, `idEstadoAte`) VALUES
(215, 'ACP-2021-000214', '2021-07-03', '1914946', '1908905', '721643', 1, '1981-08-28', 'DNI', '43333906', 'GUEVARA', 'PEREZ', 'DIOCELINA ', '2021-07-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '40', 2, 'PARTICULAR', 6, 1),
(216, 'ACP-2021-000215', '2021-07-03', '1914530', '1908489', '308808', 2, '1957-01-07', 'DNI', '06855872', 'VARGAS', 'MONTENEGRO DE CHAVEZ', 'CARMEN GABY', '2021-06-29', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '64', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(217, 'ACP-2021-000216', '2021-07-05', '1914684', '1908643', '381690', 1, '1974-12-08', 'DNI', '10187733', 'PAZ', 'PALOMINO', 'WALTER AUGUSTO', '2021-06-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '47', 1, 'PARTICULAR', 12, 1),
(218, 'ACP-2021-000217', '2021-07-05', '1915185', '1909144', '1339511', 1, '1963-09-05', 'DNI', '06937116', 'CHIPANA', 'JUAREZ', 'LORENZO ROMULO', '2021-07-02', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '58', 1, 'PARTICULAR', 12, 1),
(219, 'ACP-2021-000218', '2021-07-05', '1915302', '1909261', '1269966', 1, '1983-06-04', 'DNI', '45920688', 'NAVARRO', 'AMASIFUEN', 'ESTELA ', '2021-07-02', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '38', 2, 'PARTICULAR', 10, 1),
(220, 'ACP-2021-000219', '2021-07-06', '1915459', '1909418', '780446', 1, '1998-08-04', 'DNI', '74648501', 'QUISPE', 'JARA', 'EDWIN AQUINO', '2021-07-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '23', 1, 'PARTICULAR', 12, 1),
(221, 'ACP-2021-000220', '2021-07-06', '1915371', '1909330', '1339566', 3, '1966-01-29', 'DNI', '08957733', 'ZEVALLOS', 'MALPARTIDA', 'FILOMENA ', '2021-07-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'VILLA MARIA DEL TRIUNFO', '55', 2, 'PARTICULAR', 12, 1),
(222, 'ACP-2021-000221', '2021-07-07', '1916019', '1909978', '1135277', 1, '1976-02-03', 'DNI', '80506006', 'GUERRA', 'GONZALES', 'LUIS ANTONIO', '2021-07-06', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '45', 1, 'PARTICULAR', 10, 1),
(223, 'ACP-2021-000222', '2021-07-07', '1915786', '1909745', '1319350', 1, '1976-08-19', 'DNI', '10625466', 'CURRO', 'HANCCO', 'JAIME ', '2021-07-05', 'CORONAVIRUS - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '45', 1, 'PARTICULAR', 10, 1),
(224, 'ACP-2021-000223', '2021-07-07', '1915880', '1909839', '1339702', 1, '1971-07-30', 'DNI', '07479165', 'ORIHUELA', 'MARTINEZ', 'JOHN ALFRED', '2021-07-05', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '50', 1, 'PARTICULAR', 10, 1),
(225, 'ACP-2021-000224', '2021-07-07', '1915878', '1909837', '1339701', 1, '1975-11-25', 'DNI', '29665210', 'CABEZUDO', 'CHAVEZ', 'ANTONIO TEODULO', '2021-07-05', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 10, 1),
(226, 'ACP-2021-000225', '2021-07-07', '1915989', '1909948', '1339734', 1, '1970-04-09', 'DNI', '01315439', 'MAMANI', 'HUARAYA', 'JUAN CARLOS', '2021-07-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '51', 1, 'SOAT', 10, 1),
(227, 'ACP-2021-000226', '2021-07-09', '1916194', '1910153', '913198', 1, '1961-01-29', 'DNI', '06946823', 'HERNANDEZ', 'ROJAS DE ALVARADO', 'MARIA IRIS', '2021-07-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '60', 2, 'PARTICULAR', 12, 1),
(228, 'ACP-2021-000227', '2021-07-09', '1916409', '1910368', '824540', 1, '1986-12-24', 'DNI', '45201927', 'MOLINA', 'BALDEON', 'JUAN CARLOS', '2021-07-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '35', 1, 'PARTICULAR', 10, 1),
(229, 'ACP-2021-000228', '2021-07-09', '1915866', '1909825', '1339698', 1, '1978-07-05', 'DIE', '', 'SOMASA', 'LOPEZ', 'JOSE ', '2021-07-05', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '43', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(230, 'ACP-2021-000229', '2021-07-09', '1916457', '1910416', '202333', 1, '1971-05-16', 'DNI', '15283003', 'MIRANDA', 'ROSALES', 'PERCY ROGER', '2021-07-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '50', 1, 'PARTICULAR', 10, 1),
(231, 'ACP-2021-000230', '2021-07-10', '1916425', '1910384', '851065', 1, '1964-08-27', 'DNI', '06840964', 'LOPEZ', 'MORALES', 'LUIS ROGER', '2021-07-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '57', 1, 'PARTICULAR', 12, 1),
(232, 'ACP-2021-000231', '2021-07-10', '1916644', '1910603', '1339722', 1, '1989-03-04', 'DNI', '45616120', 'PEREZ', 'ZAVALETA', 'ANDREA MELISSA', '2021-07-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '32', 2, 'PARTICULAR', 12, 1),
(233, 'ACP-2021-000232', '2021-07-10', '1916622', '1910581', '1339272', 1, '1969-03-08', 'DNI', '15730633', 'VASQUEZ', 'ESPINOZA', 'JESUSA ', '2021-07-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '52', 2, 'PARTICULAR', 12, 1),
(234, 'ACP-2021-000233', '2021-07-10', '1916355', '1910314', '1339851', 1, '1986-07-19', 'DNI', '43642772', 'ZAMBRANO', 'URTEAGA', 'JOEL MARTIN', '2021-07-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '35', 1, 'PARTICULAR', 12, 1),
(235, 'ACP-2021-000234', '2021-07-19', '1916833', '1910792', '1339966', 1, '1963-12-06', 'DNI', '06939781', 'CAMONES', 'BARRERA', 'WILLY JULIO', '2021-07-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '58', 1, 'PARTICULAR', 10, 1),
(236, 'ACP-2021-000235', '2021-07-19', '1917657', '1911616', '939249', 1, '1956-10-30', 'DNI', '24662130', 'TTICA', 'APAZA', 'CLAUDIO ', '2021-07-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '65', 1, 'PARTICULAR', 10, 1),
(237, 'ACP-2021-000236', '2021-07-19', '1917180', '1911139', '1340063', 1, '1979-07-30', 'DNI', '40740733', 'VASQUEZ', 'JULCA', 'ROMULO ', '2021-07-10', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '42', 1, 'PARTICULAR', 10, 1),
(238, 'ACP-2021-000237', '2021-07-19', '1917755', '1911714', '1340206', 3, '1975-12-08', 'DNI', '10215921', 'PEREYRA', 'MANRIQUE', 'CONCEPCION CARLOS', '2021-07-13', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 10, 1),
(239, 'ACP-2021-000238', '2021-07-19', '1917085', '1911044', '306709', 3, '1952-04-10', 'DNI', '09471360', 'TORRES', 'CERNA', 'JERENCIA ', '2021-07-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '69', 2, 'PARTICULAR', 12, 1),
(240, 'ACP-2021-000239', '2021-07-19', '1917966', '1911925', '1340257', 1, '1992-05-30', 'DNI', '70785595', 'TOMAYLLA', 'NIETO', 'PEDRO ALEJANDRO', '2021-07-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '29', 1, 'PARTICULAR', 12, 1),
(241, 'ACP-2021-000240', '2021-07-19', '1918025', '1911984', '1340274', 1, '2002-01-03', 'DNI', '72785923', 'BARBOZA', 'CASSANO', 'XIOMARA ELENA', '2021-07-14', 'CORONAVIRUS - EMERGENCIA', '', 'LOS OLIVOS', '19', 2, 'PARTICULAR', 12, 1),
(242, 'ACP-2021-000241', '2021-07-19', '1918467', '1912426', '1057423', 1, '1963-12-12', 'DNI', '07165696', 'PALACIOS', 'PARDAVE DE ROCHA', 'MERY LUZ', '2021-07-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '58', 2, 'PARTICULAR', 12, 1),
(243, 'ACP-2021-000242', '2021-07-19', '1918617', '1912576', '308727', 1, '1982-07-04', 'DNI', '41393331', 'RIVERA', 'VARA', 'PILAR LORELLA', '2021-07-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '39', 2, 'PARTICULAR', 12, 1),
(244, 'ACP-2021-000243', '2021-07-19', '1918137', '1912096', '384039', 1, '1961-01-05', 'DNI', '06953527', 'CHUQUILIN', 'CABANILLAS', 'MANUEL ANTONIO', '2021-07-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '60', 1, 'PARTICULAR', 10, 1),
(245, 'ACP-2021-000244', '2021-07-19', '1917926', '1911885', '44338', 1, '1938-12-17', 'DNI', '06948871', 'ABARCA', 'DELGADO', 'GRIMANESA ', '2021-07-13', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '83', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(246, 'ACP-2021-000245', '2021-07-19', '1918099', '1912058', '169419', 1, '1959-09-26', 'DNI', '07343789', 'LOPEZ', 'ZUTA', 'FLORENTINA ', '2021-07-14', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '62', 2, 'PARTICULAR', 10, 1),
(247, 'ACP-2021-000246', '2021-07-19', '1917641', '1911600', '1340182', 1, '1978-11-05', 'DNI', '40078825', 'CASTILLO', 'MANTILLA', 'BRUCE ENRIQUE', '2021-07-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '43', 1, 'PARTICULAR', 10, 1),
(248, 'ACP-2021-000247', '2021-07-19', '1918708', '1912667', '1340478', 1, '1945-02-23', 'DNI', '33429924', 'ALVARADO', 'TORRES', 'SAUL ANTONIO', '2021-07-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'JESUS MARIA', '76', 1, 'SOAT', 10, 1),
(249, 'ACP-2021-000248', '2021-07-20', '1918719', '1912678', '1340480', 1, '1966-02-11', 'DNI', '80153522', 'HURTADO', 'ZEVALLOS', 'CARMEN DORIS', '2021-07-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '55', 2, 'PARTICULAR', 12, 1),
(250, 'ACP-2021-000249', '2021-07-20', '1918308', '1912267', '1340363', 3, '1975-03-23', 'DNI', '40050604', 'JARA', 'ORDOÑEZ', 'RAUL ', '2021-07-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 12, 1),
(251, 'ACP-2021-000250', '2021-07-20', '1919093', '1913052', '1232432', 1, '1979-04-08', 'DNI', '80289550', 'COTRINA', 'ROJAS', 'ALEX JESUS', '2021-07-18', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '42', 1, 'PARTICULAR', 12, 1),
(252, 'ACP-2021-000251', '2021-07-20', '1919265', '1913224', '155574', 1, '1958-08-28', 'DNI', '06904877', 'TUANAMA', 'TUANAMA', 'MARIA DE LA CRUZ', '2021-07-19', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '63', 2, 'PARTICULAR', 12, 1),
(253, 'ACP-2021-000252', '2021-07-20', '1919085', '1913044', '567515', 1, '2002-03-30', 'DNI', '75635241', 'VENANCIO', 'BERNABE', 'ALEXANDER YUNIOR', '2021-07-18', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '19', 1, 'PARTICULAR', 12, 1),
(254, 'ACP-2021-000253', '2021-07-21', '1914459', '1908418', '293768', 3, '1961-02-01', 'DNI', '06940469', 'AGUINAGA', 'SALAS', 'GUILLERMO ALFONSO', '2021-06-29', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '60', 1, 'PARTICULAR', 1, 1),
(255, 'ACP-2021-000254', '2021-07-21', '1918881', '1912840', '525313', 1, '1951-01-18', 'DNI', '08433936', 'DIAZ', 'SAUCEDO', 'MARIA ANTONIA', '2021-07-17', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '70', 2, 'PARTICULAR', 1, 1),
(256, 'ACP-2021-000255', '2021-07-21', '1919473', '1913432', '1320271', 1, '1938-10-04', 'DNI', '01048115', 'ALVA', 'RAMOS', 'FRANCISCO ', '2021-07-19', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '83', 1, 'PARTICULAR', 1, 1),
(257, 'ACP-2021-000256', '2021-07-21', '1919295', '1913254', '1339269', 1, '1957-08-07', 'CE', '9010391', 'RAMIREZ', 'BELLO', 'ANA BELL', '2021-07-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '64', 2, 'CONVENIOS PÚBLICOS', 1, 1),
(258, 'ACP-2021-000257', '2021-07-22', '1919284', '1913243', '1340660', 1, '1974-04-01', 'DNI', '10383490', 'FALCON', 'PUQUIO', 'WILFREDO ', '2021-07-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '47', 1, 'PARTICULAR', 12, 1),
(259, 'ACP-2021-000258', '2021-07-22', '1919368', '1913327', '1174996', 1, '1975-03-18', 'DNI', '80252572', 'CERDAN', 'VASQUEZ', 'DELFINA MARIA', '2021-07-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '46', 2, 'PARTICULAR', 12, 1),
(260, 'ACP-2021-000259', '2021-07-22', '1919600', '1913559', '245871', 1, '1979-05-08', 'DNI', '80382417', 'CHAVEZ', 'ORE', 'SUSANA ', '2021-07-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '42', 2, 'PARTICULAR', 12, 1),
(261, 'ACP-2021-000260', '2021-07-22', '1919732', '1913691', '464524', 1, '1985-05-23', 'DNI', '43206483', 'LEON', 'MARTINEZ', 'BERTHA LEONELA', '2021-07-20', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '36', 2, 'PARTICULAR', 12, 1),
(262, 'ACP-2021-000261', '2021-07-22', '1919897', '1913856', '292830', 1, '1965-09-29', 'DNI', '06250748', 'TIRADO', 'RAMOS', 'ROSSANA GUADALUPE', '2021-07-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '56', 2, 'PARTICULAR', 10, 1),
(263, 'ACP-2021-000262', '2021-07-23', '1920012', '1913971', '1340872', 1, '1991-09-09', 'DNI', '47442837', 'RAFAEL', 'MANRIQUE', 'ERWIN JAMES', '2021-07-23', 'MEDICINA - HOSPITALIZACIÓN ', 'CAMA 1', 'COMAS', '30', 1, 'PARTICULAR', 12, 1),
(264, 'ACP-2021-000263', '2021-07-24', '1920588', '1914547', '602380', 1, '1967-11-14', 'DNI', '09310433', 'MENDOZA', 'DELGADO DE LUQUE', 'NELLY CONSUELO', '2021-07-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '54', 2, 'PARTICULAR', 10, 1),
(265, 'ACP-2021-000264', '2021-07-24', '1920542', '1914501', '978889', 1, '1972-11-28', 'DNI', '09964008', 'SERRANO', 'CRUZ', 'JULY JANET', '2021-07-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '49', 2, 'PARTICULAR', 10, 1),
(266, 'ACP-2021-000265', '2021-07-26', '1921099', '1915058', '878882', 3, '1949-08-29', 'DNI', '10215061', 'CASAS', 'FUENTES', 'ROBERTO ', '2021-07-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '72', 1, 'PARTICULAR', 12, 1),
(267, 'ACP-2021-000266', '2021-07-26', '1919442', '1913401', '1271412', 3, '1991-11-08', 'DNI', '48051277', 'HUSASQUICHE', 'PADILLA', 'WILLY ANTONIO', '2021-07-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '30', 1, 'CONVENIOS PÚBLICOS', 12, 1),
(268, 'ACP-2021-000267', '2021-07-26', '1920860', '1914819', '1341082', 1, '1957-11-04', 'DNI', '08599697', 'DOMINGUEZ', 'VILLANUEVA', 'PORFIRIA ', '2021-07-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '64', 2, 'PARTICULAR', 12, 1),
(269, 'ACP-2021-000268', '2021-07-26', '1920809', '1914768', '1341064', 1, '1965-04-11', 'DNI', '06822865', 'HERRERA', 'GARCIA', 'VICTOR CIRILO', '2021-07-24', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '56', 1, 'PARTICULAR', 12, 1),
(270, 'ACP-2021-000269', '2021-07-27', '1921261', '1915220', '1341191', 1, '1974-06-28', 'DNI', '16727617', 'ZAPATA', 'SERNAQUE', 'LUIS ANGEL', '2021-07-26', 'CORONAVIRUS - EMERGENCIA', '', 'LOS OLIVOS', '47', 1, 'PARTICULAR', 10, 1),
(271, 'ACP-2021-000270', '2021-07-30', '1921880', '1915839', '289651', 1, '1967-08-25', 'DNI', '09049903', 'VALDERRAMA', 'BEGAZO', 'GRACIELA VERSABE', '2021-07-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '54', 2, 'PARTICULAR', 12, 1),
(272, 'ACP-2021-000271', '2021-07-30', '1921470', '1915429', '902290', 2, '1964-08-29', 'DNI', '80499179', 'VICENTE', 'DE LA CRUZ', 'MATILDE DORIS', '2021-07-27', 'MEDICINA - EMERGENCIA', '', 'COMAS', '57', 2, 'PARTICULAR', 12, 1),
(273, 'ACP-2021-000272', '2021-08-02', '1922346', '1916305', '454791', 1, '1956-08-27', 'DNI', '09318654', 'BOHORQUEZ', 'CANCIO', 'MARCELO ', '2021-07-30', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '65', 1, 'PARTICULAR', 12, 1),
(274, 'ACP-2021-000273', '2021-08-02', '1922734', '1916693', '1341567', 1, '1977-05-07', 'DNI', '10742241', 'LANDEO', 'VARGAS', 'JUVENAL ', '2021-08-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 12, 1),
(275, 'ACP-2021-000274', '2021-08-02', '1922547', '1916506', '1341532', 1, '1982-11-14', 'DNI', '43630092', 'RIVEROS', 'HUAYANAY', 'EDGAR ', '2021-07-31', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN MARTIN DE PORRES', '39', 1, 'PARTICULAR', 12, 1),
(276, 'ACP-2021-000275', '2021-08-03', '1923250', '1917209', '1341700', 1, '1977-01-11', 'DNI', '19429623', 'FLORES', 'BELLO', 'SAMUEL ISMAEL', '2021-08-03', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '44', 1, 'PARTICULAR', 10, 1),
(277, 'ACP-2021-000276', '2021-08-04', '1923249', '1917208', '785300', 1, '1939-10-16', 'DNI', '07338505', 'SALAZAR', 'ZAMALLOA', 'VICTOR HUGO', '2021-08-03', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '82', 1, 'PARTICULAR', 12, 1),
(278, 'ACP-2021-000277', '2021-08-04', '1923403', '1917362', '182266', 1, '1977-07-15', 'DNI', '10409471', 'QUISPE', 'SALAS', 'CARLOS EUSEBIO', '2021-08-03', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 12, 1),
(279, 'ACP-2021-000278', '2021-08-04', '1917964', '1911923', '530089', 1, '1936-11-17', 'DNI', '06945325', 'VERGARA', 'MAZA VDA DE DEXTRE', 'GREGORIA ', '2021-07-14', 'MEDICINA - HOSPITALIZACIÓN ', '', 'COMAS', '85', 2, 'PARTICULAR', 12, 1),
(280, 'ACP-2021-000279', '2021-08-05', '1919097', '1913056', '83992', 2, '1936-11-06', 'DNI', '06955233', 'CABALLERO', 'VALDERRAMA', 'SEVERINO ', '2021-07-20', 'MEDICINA - HOSPITALIZACIÓN ', '', 'COMAS', '85', 1, 'PARTICULAR', 10, 1),
(281, 'ACP-2021-000280', '2021-08-05', '1920263', '1914222', '209290', 1, '1961-02-03', 'DNI', '07436198', 'LINO', 'ROQUE', 'MARIA CARMEN', '2021-07-23', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '60', 2, 'PARTICULAR', 10, 1),
(282, 'ACP-2021-000281', '2021-08-06', '1915461', '1909420', '803612', 1, '1968-08-14', 'DNI', '07866023', 'JARA', 'CHOMBO', 'EUSEBIA ', '2021-07-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '53', 2, 'PARTICULAR', 12, 1),
(283, 'ACP-2021-000282', '2021-08-07', '1924422', '1918381', '756809', 1, '1989-03-12', 'DNI', '45910374', 'LOPEZ', 'USUA', 'EDGAR ', '2021-08-06', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '32', 1, 'PARTICULAR', 10, 1),
(284, 'ACP-2021-000283', '2021-08-09', '1924760', '1918719', '1342056', 1, '1956-09-02', 'DNI', '32395512', 'GRANADOS', 'BRAVO', 'ANTONIO JULIAN', '2021-08-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PAMPAROMAS', '65', 1, 'PARTICULAR', 12, 1),
(285, 'ACP-2021-000284', '2021-08-09', '1924262', '1918221', '1038825', 1, '1983-06-30', 'DNI', '42201884', 'DIAZ', 'VILLEGAS', 'CESAR AUGUSTO', '2021-08-06', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PUENTE PIEDRA', '38', 1, 'PARTICULAR', 12, 1),
(286, 'ACP-2021-000285', '2021-08-10', '1925269', '1919228', '783239', 1, '1973-05-10', 'DNI', '09598495', 'CRUZ', 'AVILA', 'MARIA MARCELA', '2021-08-10', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '48', 2, 'PARTICULAR', 10, 1),
(287, 'ACP-2021-000286', '2021-08-10', '1925118', '1919077', '122341', 1, '1975-10-01', 'DNI', '10395599', 'OCHOA', 'MONTERO', 'JHONNY ', '2021-08-09', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '46', 1, 'PARTICULAR', 10, 1),
(288, 'ACP-2021-000287', '2021-08-12', '1926013', '1919972', '972716', 1, '1992-09-04', 'DNI', '47602357', 'ARANA', 'CUZZIRAMOS', 'LIZETH JESUS', '2021-08-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '29', 2, 'PARTICULAR', 10, 1),
(289, 'ACP-2021-000288', '2021-08-12', '1925554', '1919513', '1342198', 1, '1947-01-01', 'DNI', '10472776', 'GUEVARA', 'DIAZ', 'JESUS EUGENIO', '2021-08-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '74', 1, 'PARTICULAR', 10, 1),
(290, 'ACP-2021-000289', '2021-08-13', '1926147', '1920106', '78776', 1, '1975-04-27', 'DNI', '80396683', 'SALINAS', 'BARZOLA', 'GUILLERMO VICTOR', '2021-08-13', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '46', 1, 'PARTICULAR', 12, 1),
(291, 'ACP-2021-000290', '2021-08-13', '1926270', '1920229', '1342369', 1, '1976-07-22', 'DNI', '16770318', 'FLORES', 'NUÑEZ', 'RODULFO BERTI', '2021-08-12', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '45', 1, 'PARTICULAR', 12, 1),
(292, 'ACP-2021-000291', '2021-08-13', '1926133', '1920092', '27936', 1, '1955-07-28', 'DNI', '20581040', 'SANCHEZ', 'MARTINEZ', 'SONIA ', '2021-08-12', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '66', 2, 'PARTICULAR', 12, 1),
(293, 'ACP-2021-000292', '2021-08-14', '1926643', '1920602', '1342443', 3, '1967-10-06', 'DNI', '27048041', 'GOICOCHEA', 'MONTOYA', 'GERARDO REMIGIO', '2021-08-14', 'CORONAVIRUS - EMERGENCIA', '', 'SAN MARTIN DE PORRES', '54', 1, 'PARTICULAR', 10, 1),
(294, 'ACP-2021-000293', '2021-08-16', '1926983', '1920942', '984102', 1, '1933-12-20', 'DNI', '43091882', 'CHILCON', 'HEREDIA', 'JOSE SANTOS', '2021-08-15', 'CORONAVIRUS - EMERGENCIA', '', 'CUTERVO', '88', 1, 'PARTICULAR', 12, 1),
(295, 'ACP-2021-000294', '2021-08-16', '1926965', '1920924', '1342008', 1, '1989-02-19', 'DNI', '47643681', 'GUZMAN', 'CATUNTA', 'ISAAC VIDAL', '2021-08-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '32', 1, 'PARTICULAR', 12, 1),
(296, 'ACP-2021-000295', '2021-08-16', '1927000', '1920959', '1342558', 1, '1973-07-31', 'DNI', '09977130', 'AREVALO', 'SALDAÑA', 'JORGE ', '2021-08-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '48', 1, 'PARTICULAR', 12, 1),
(297, 'ACP-2021-000296', '2021-08-23', '1928651', '1922610', '1188437', 1, '1994-03-12', 'DNI', '70111912', 'RUMICHE', 'BAUTISTA', 'ANGELY BRENDA', '2021-08-21', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'COMAS', '27', 2, 'PARTICULAR', 12, 1),
(298, 'ACP-2021-000297', '2021-08-23', '1928945', '1922904', '239158', 1, '1984-10-19', 'DNI', '42674041', 'GONZALES', 'MOYA', 'GUSTAVO ADOLFO', '2021-08-22', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '37', 1, 'PARTICULAR', 12, 1),
(299, 'ACP-2021-000298', '2021-08-24', '1929230', '1923189', '967961', 1, '1969-10-12', 'DNI', '10394405', 'AQUINO', 'BARTOLOME', 'HERLINDA GRACIELA', '2021-08-23', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '52', 2, 'PARTICULAR', 10, 1),
(300, 'ACP-2021-000299', '2021-08-25', '1929568', '1923527', '1033772', 1, '1965-01-07', 'DNI', '08051599', 'CASTILLO', 'TORRES', 'JOSE LUIS', '2021-08-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '56', 1, 'PARTICULAR', 12, 1),
(301, 'ACP-2021-000300', '2021-08-26', '1929758', '1923717', '1343261', 1, '1984-01-16', 'DNI', '44851808', 'FLORES', 'LUNA', 'LUZ ROXANA', '2021-08-25', 'CORONAVIRUS - EMERGENCIA', '', 'LIMA', '37', 2, 'PARTICULAR', 10, 1),
(302, 'ACP-2021-000301', '2021-08-26', '1929515', '1923474', '1237570', 1, '1969-02-16', 'DNI', '09985751', 'GONZALES', 'CHAMORRO', 'MARIO WILLIAM', '2021-08-24', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '52', 1, 'PARTICULAR', 10, 1),
(303, 'ACP-2021-000302', '2021-08-27', '1819706', '1813662', '452044', 2, '1962-05-26', 'DNI', '00111643', 'MERCADO', 'RAMOS', 'LORENZA ', '2020-03-12', 'NEUMOLOGIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '59', 2, 'PARTICULAR', 12, 1),
(304, 'ACP-2021-000303', '2021-08-27', '1929941', '1923900', '388360', 1, '1992-06-25', 'DNI', '70577347', 'NIÑO', 'TRIVIÑO', 'ALBERTO AARON', '2021-08-26', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '29', 1, 'SOAT', 12, 1),
(305, 'ACP-2021-000304', '2021-09-03', '1931493', '1925452', '938108', 1, '1983-03-28', 'DNI', '42784307', 'PEREZ', 'AGUILAR', 'ANTHONY ', '2021-08-31', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '38', 1, 'PARTICULAR', 12, 1),
(306, 'ACP-2021-000305', '2021-09-03', '1932428', '1926387', '1343756', 1, '1995-05-05', 'DNI', '76310163', 'CHATA', 'ACHATA', 'KATHERINE PAOLA', '2021-09-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '26', 2, 'PARTICULAR', 12, 1),
(307, 'ACP-2021-000306', '2021-09-03', '1932152', '1926111', '1343849', 1, '1992-12-14', 'DNI', '48288860', 'TERRONES', 'ESCOBAR', 'VICTOR ALEXANDER', '2021-09-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '29', 1, 'PARTICULAR', 12, 1),
(308, 'ACP-2021-000307', '2021-09-04', '1932724', '1926683', '1343961', 1, '1949-08-18', 'DNI', '09229435', 'TELLO', 'MALPARTIDA', 'CARMEN ELENA', '2021-09-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '72', 2, 'PARTICULAR', 10, 1),
(309, 'ACP-2021-000308', '2021-09-04', '1931298', '1925257', '196946', 2, '1934-06-25', 'DNI', '48860820', 'PADILLA', 'CARTOLÍN', 'GUILLERMO ', '2021-08-31', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '87', 1, 'PARTICULAR', 10, 1),
(310, 'ACP-2021-000309', '2021-09-04', '1930166', '1924125', '452044', 2, '1962-05-26', 'DNI', '00111643', 'MERCADO', 'RAMOS', 'LORENZA ', '2021-08-27', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '59', 2, 'PARTICULAR', 10, 1),
(311, 'ACP-2021-000310', '2021-09-06', '1933184', '1927143', '662191', 1, '1981-04-15', 'DNI', '40874212', 'FRIAS', 'PAZ', 'ELENA YSABEL', '2021-09-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '40', 2, 'PARTICULAR', 12, 1),
(312, 'ACP-2021-000311', '2021-09-06', '1933223', '1927182', '1344111', 1, '1973-03-17', 'DNI', '10817069', 'INGA', 'BETETA', 'CASTORIZO ', '2021-09-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'INDEPENDENCIA', '48', 1, 'PARTICULAR', 12, 1),
(313, 'ACP-2021-000312', '2021-09-07', '1933816', '1927775', '1344221', 1, '1993-07-26', 'CE', '22950751', 'CAMPOS', 'ESTEVEZ', 'MAXIMO ', '2021-09-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '28', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(314, 'ACP-2021-000313', '2021-09-10', '1930293', '1924252', '1343392', 1, '1973-10-08', 'DNI', '25582739', 'PALOMINO', 'YUPAN', 'JUAN FRANCISCO', '2021-08-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '48', 1, 'PARTICULAR', 12, 1),
(315, 'ACP-2021-000314', '2021-09-11', '1935424', '1929383', '635435', 1, '1944-06-17', 'DNI', '09023504', 'MORI', 'ARAUJO', 'MANUEL FELIX', '2021-09-10', 'MEDICINA - EMERGENCIA', '', 'COMAS', '77', 1, 'PARTICULAR', 10, 1),
(316, 'ACP-2021-000315', '2021-09-12', '1932139', '1926098', '363559', 2, '1991-11-09', 'DNI', '48206670', 'MELO', 'CALDERON', 'TANIA LIZBETH', '2021-09-01', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '30', 2, 'PARTICULAR', 10, 1),
(317, 'ACP-2021-000316', '2021-09-12', '1931538', '1925497', '620879', 1, '1972-03-13', 'DNI', '09828302', 'ARMACANQUI', 'HERNANDEZ', 'FERNANDO DOMINGO', '2021-09-04', 'MEDICINA - HOSPITALIZACIÓN ', '', 'COMAS', '49', 1, 'PARTICULAR', 10, 1),
(318, 'ACP-2021-000317', '2021-09-14', '1935964', '1929923', '558898', 1, '1951-04-11', 'DNI', '07834079', 'SUAREZ', 'RODAS', 'FELICITAS EUSEBIA', '2021-09-13', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '70', 2, 'PARTICULAR', 10, 1),
(319, 'ACP-2021-000318', '2021-09-14', '1936476', '1930435', '872818', 1, '1987-10-18', 'DNI', '44885849', 'UGAZ', 'AGUILAR', 'CARLOS ANTONIO', '2021-09-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '34', 1, 'PARTICULAR', 10, 1),
(320, 'ACP-2021-000319', '2021-09-15', 'ANULADA', 'ANULADA', '346317', 2, '1990-10-09', 'DNI', '71402291', 'YUPANQUI', 'ATOCHE', 'JUNIOR FRANCISCO', '2020-02-29', 'PSIQUIATRIA 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '31', 1, 'SIS', 14, 2),
(321, 'ACP-2021-000320', '2021-09-15', '1936550', '1930509', '1236995', 1, '1968-04-25', 'DNI', '27417794', 'VASQUEZ', 'TAICA', 'LUCELINA ', '2021-09-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '53', 2, 'PARTICULAR', 12, 1),
(322, 'ACP-2021-000321', '2021-09-15', '1936279', '1930238', '872818', 2, '1987-10-18', 'DNI', '44885849', 'UGAZ', 'AGUILAR', 'CARLOS ANTONIO', '2021-09-13', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '34', 1, 'PARTICULAR', 12, 1),
(323, 'ACP-2021-000322', '2021-09-20', '1938170', '1932129', '897569', 1, '1989-01-25', 'DNI', '70567626', 'ROBLES', 'LAGOS', 'DANIEL MARTIN', '2021-09-20', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '32', 1, 'PARTICULAR', 12, 1),
(324, 'ACP-2021-000323', '2021-09-21', '1938413', '1932372', '1345230', 1, '1964-03-18', 'DNI', '07039106', 'RONCALLO', 'SEMORILE', 'MARISA ANGELICA', '2021-09-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CHORRILLOS', '57', 2, 'PARTICULAR', 10, 1),
(325, 'ACP-2021-000324', '2021-09-22', '1938664', '1932623', '119202', 1, '1977-10-20', 'DNI', '40203298', 'PAZ', 'QUISPE', 'DAMIAN ', '2021-09-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 12, 1),
(326, 'ACP-2021-000325', '2021-09-22', '1938788', '1932747', '1231377', 1, '1968-11-13', 'DNI', '25577645', 'MOLINA', 'RAMOS', 'SARA ROSARIO', '2021-09-22', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '53', 2, 'PARTICULAR', 12, 1),
(327, 'ACP-2021-000326', '2021-09-23', '1930292', '1924251', '1343391', 1, '1981-01-30', 'DNI', '40763892', 'ANGELES', 'YUPAN', 'ANTONIETA VIRGINIA', '2021-08-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '40', 2, 'PARTICULAR', 10, 1),
(328, 'ACP-2021-000327', '2021-09-24', '1939206', '1933165', '1345407', 1, '1954-09-08', 'DNI', '08132842', 'ACERO', 'QUINTANA DE HERRERA', 'DONATILDA URBANA', '2021-09-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'RIMAC', '67', 2, 'PARTICULAR', 12, 1),
(329, 'ACP-2021-000328', '2021-09-25', '1939567', '1933526', '1345483', 1, '1989-07-08', 'DNI', '46831325', 'BAUTISTA', 'QUISPE', 'JHON ANGEL', '2021-09-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '32', 1, 'PARTICULAR', 10, 1),
(330, 'ACP-2021-000329', '2021-09-27', '1940291', '1934250', '640906', 1, '1961-01-15', 'DNI', '29466713', 'AJAHUANA', 'MAMANI', 'PABLO ', '2021-09-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '60', 1, 'PARTICULAR', 12, 1),
(331, 'ACP-2021-000330', '2021-10-01', '1941353', '1935312', '1108205', 1, '1991-03-15', 'DNI', '70523437', 'LUDGARDO', 'PUENTE', 'JEAN PIERRE', '2021-09-30', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '30', 1, 'PARTICULAR', 12, 1),
(332, 'ACP-2021-000331', '2021-10-05', '1943550', '1937509', '816410', 1, '1964-06-29', 'DNI', '21408270', 'YUCRA', 'ALFARO', 'PEDRO PABLO', '2021-10-04', 'CORONAVIRUS - EMERGENCIA', '', 'SANTA ROSA', '57', 1, 'PARTICULAR', 10, 1),
(333, 'ACP-2021-000332', '2021-10-09', '1944398', '1938357', '1346394', 1, '1969-03-20', 'DNI', '10250851', 'CANLLA', 'FLORES', 'MARTHA NOEMI', '2021-10-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'ATE', '52', 2, 'PARTICULAR', 10, 1),
(334, 'ACP-2021-000333', '2021-10-11', '1946170', '1940129', '1346811', 1, '1971-01-08', 'DNI', '09739440', 'ARCE', 'CRUZ', 'ELADIO EMILIO', '2021-10-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '50', 1, 'PARTICULAR', 12, 1),
(335, 'ACP-2021-000334', '2021-10-11', '1946161', '1940120', '1346810', 1, '1992-05-03', 'DNI', '47220417', 'HERRERA', 'MARGARIN', 'HINA HUDITH', '2021-10-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '29', 2, 'PARTICULAR', 12, 1),
(336, 'ACP-2021-000335', '2021-10-13', '1946811', '1940770', '205920', 1, '1976-06-29', 'DNI', '10741178', 'GARAY', 'VILLAR', 'EDITH MARLENI', '2021-10-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '45', 2, 'PARTICULAR', 12, 1),
(337, 'ACP-2021-000336', '2021-10-15', '1947728', '1941687', '1347163', 1, '1952-09-27', 'DNI', '25504420', 'AGUIRRE', 'MULLISACA', 'DAMIAN ', '2021-10-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '69', 1, 'SOAT', 12, 1),
(338, 'ACP-2021-000337', '2021-10-21', '1949365', '1943324', '1347546', 1, '1985-02-15', 'DNI', '42943790', 'HURTADO', 'PINEDO', 'RAUL JUNIOR', '2021-10-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '36', 1, 'PARTICULAR', 10, 1),
(339, 'ACP-2021-000338', '2021-10-21', '1943062', '1937021', '1346146', 1, '1994-11-19', 'DNI', '48465886', 'MENDOZA', 'FELIPE', 'JHON ANDERSON', '2021-10-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '27', 1, 'PARTICULAR', 10, 1),
(340, 'ACP-2021-000339', '2021-10-25', '1951022', '1944981', '552435', 1, '1940-08-26', 'DNI', '10404382', 'FLORES', 'BOHORQUEZ', 'HERNAN CEFERINO', '2021-10-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '81', 1, 'PARTICULAR', 12, 1),
(341, 'ACP-2021-000340', '2021-10-25', '1950590', '1944549', '1239376', 1, '1971-08-12', 'DNI', '40318655', 'NOLASCO', 'RAMIREZ', 'RUIZ ', '2021-10-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '50', 1, 'PARTICULAR', 12, 1),
(342, 'ACP-2021-000341', '2021-10-25', '1950691', '1944650', '1218040', 1, '1986-09-25', 'DNI', '43872248', 'HUERTAS', 'AROSTE', 'MARIA ', '2021-10-24', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '35', 2, 'PARTICULAR', 12, 1),
(343, 'ACP-2021-000342', '2021-10-27', '1951383', '1945342', '609049', 1, '1973-11-23', 'DNI', '80565026', 'CARRANZA', 'ROJAS', 'CARLOS ALBERTO', '2021-10-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '48', 1, 'PARTICULAR', 12, 1),
(344, 'ACP-2021-000343', '2021-11-03', '1952062', '1946021', '1348090', 1, '1958-03-28', 'DNI', '07885532', 'LEONARDO', 'CAMAC', 'DOLORES ', '2021-10-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '63', 2, 'PARTICULAR', 10, 1),
(345, 'ACP-2021-000344', '2021-11-03', '1953206', '1947165', '1348287', 1, '1983-12-03', 'DNI', '42149185', 'APARICIO', 'VASQUEZ', 'JAVIER BERNARDO', '2021-10-31', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '38', 1, 'PARTICULAR', 10, 1),
(346, 'ACP-2021-000345', '2021-11-03', '1865772', '1859731', '1238470', 1, '1999-01-18', 'PAS', '147302889', 'LARA', 'PALMA', 'FRANCHESKA COROMOTO', '2020-10-31', 'MEDICINA - EMERGENCIA', '', 'COMAS', '22', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(348, 'ACP-2021-000346', '2021-11-05', '1951459', '1945418', '1012226', 1, '1958-09-10', 'DNI', '29238883', 'VALTOP', '', 'MARIA ELENA', '2021-10-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '63', 2, 'PARTICULAR', 10, 1),
(349, 'ACP-2021-000347', '2021-11-06', '1952049', '1946008', '30241', 3, '1934-02-28', 'DNI', '06856633', 'ESPINOZA', 'ASENCIOS VDA DE ESPINOZA', 'JOSEFINA ', '2021-10-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '87', 2, 'PARTICULAR', 12, 1),
(350, 'ACP-2021-000348', '2021-11-06', '1950215', '1944174', '1238470', 2, '1999-01-18', 'PAS', '147302889', 'LARA', 'PALMA', 'FRANCHESKA COROMOTO', '2021-10-22', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '22', 2, 'CONVENIOS PÚBLICOS', 12, 1),
(351, 'ACP-2021-000349', '2021-11-06', '1946013', '1939972', '1346782', 3, '1995-10-24', 'DNI', '71337585', 'AGUIRRE', 'GONZALES', 'JORGE ALONSO', '2021-10-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '26', 1, 'SOAT', 10, 1),
(352, 'ACP-2021-000350', '2021-11-09', '1956580', '1950539', '1348840', 1, '1961-10-17', 'DNI', '15287594', 'CRUZ', 'CONDESO', 'MARGARITA VICTORIA', '2021-11-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 2, 'PARTICULAR', 10, 1),
(353, 'ACP-2021-000351', '2021-11-12', '1958107', '1952066', '1349142', 1, '1958-11-17', 'DNI', '06377410', 'CHAVEZ', 'FALCON', 'WALTER ', '2021-11-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '63', 1, 'PARTICULAR', 12, 1),
(354, 'ACP-2021-000352', '2021-11-12', '1958903', '1952862', '864547', 1, '1963-07-02', 'DNI', '08896110', 'ALVARADO', 'CABRERA', 'MARIA LUISA', '2021-11-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'VILLA EL SALVADOR', '58', 2, 'PARTICULAR', 12, 1),
(355, 'ACP-2021-000353', '2021-11-15', '1958614', '1952573', '762355', 1, '1957-12-22', 'DNI', '09447962', 'GUTIERREZ', 'BARCO', 'CARLOS ALBERTO', '2021-11-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '64', 1, 'PARTICULAR', 12, 1),
(356, 'ACP-2021-000354', '2021-11-15', '1959743', '1953702', '669552', 1, '1979-06-06', 'DNI', '40193974', 'GUZMAN', 'NAVARRO', 'ADELAYDA ARASELY', '2021-11-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'PUEBLO LIBRE', '42', 2, 'PARTICULAR', 12, 1),
(357, 'ACP-2021-000355', '2021-11-15', '1960055', '1954014', '1349530', 1, '1971-08-24', 'DNI', '10746075', 'CABRERA', 'ESPINOZA', 'JHON JORGE', '2021-11-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '50', 1, 'PARTICULAR', 12, 1),
(358, 'ACP-2021-000356', '2021-11-16', '1959859', '1953818', '1349502', 1, '1963-02-03', 'DNI', '06677072', 'BENITES', 'SEGURA', 'CARLOS MANUEL', '2021-11-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '58', 1, 'PARTICULAR', 10, 1),
(359, 'ACP-2021-000357', '2021-11-18', '1960846', '1954805', '1006730', 1, '1981-05-19', 'DNI', '41983517', 'VALDEZ', 'MALPARTIDA', 'KARINA ', '2021-11-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '40', 2, 'PARTICULAR', 10, 1),
(360, 'ACP-2021-000358', '2021-11-18', '1957593', '1951552', '1349053', 1, '1961-08-13', 'DNI', '80302591', 'GARCIA', 'VENANCIO', 'JOSE ERNESTO', '2021-11-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'FLORENCIA DE MORA', '60', 1, 'PARTICULAR', 10, 1),
(361, 'ACP-2021-000359', '2021-11-18', '1960022', '1953981', '1091580', 1, '1993-11-18', 'DNI', '73382646', 'GONZALES', 'GAGLIARDI', 'MAYRA ALEJANDRA', '2021-11-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '28', 2, 'PARTICULAR', 10, 1),
(362, 'ACP-2021-000360', '2021-11-19', '1951145', '1945104', '1119749', 1, '1967-07-28', 'DNI', '22483641', 'TRINIDAD', 'MACEDO', 'NAZARIO ', '2021-10-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '54', 1, 'PARTICULAR', 12, 1),
(363, 'ACP-2021-000361', '2021-11-19', '1961305', '1955264', '1199810', 1, '1956-08-20', 'DNI', '22265573', 'HUAMANI', 'PECEROS', 'BERNARDO LUIS', '2021-11-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '65', 1, 'PARTICULAR', 12, 1),
(364, 'ACP-2021-000362', '2021-11-19', '1961556', '1955515', '682487', 1, '1966-08-05', 'DNI', '06874029', 'MORAN', 'RAMOS', 'CELAMIR AGUSTO', '2021-11-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '55', 1, 'PARTICULAR', 12, 1),
(365, 'ACP-2021-000363', '2021-11-23', '1961885', '1955844', '1349887', 1, '1960-05-10', 'DNI', '09851769', 'OSCCORIMA', 'POZO', 'HECTOR ', '2021-11-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'SAN JERONIMO', '61', 1, 'PARTICULAR', 10, 1),
(366, 'ACP-2021-000364', '2021-11-23', '1962045', '1956004', '1349837', 1, '1972-03-25', 'DNI', '09614443', 'PAREDES', 'LUNA', 'JHON DOVER', '2021-11-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '49', 1, 'PARTICULAR', 10, 1),
(367, 'ACP-2021-000365', '2021-11-23', '1963009', '1956968', '1306037', 1, '1960-03-18', 'DNI', '06919203', 'BLAS', 'ARMAS', 'JUANA SUSANA', '2021-11-22', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '61', 2, 'PARTICULAR', 10, 1),
(368, 'ACP-2021-000366', '2021-11-26', '1963805', '1957764', '1350182', 1, '1964-01-09', 'DNI', '01016589', 'DIAZ', 'PANDURO', 'OFELIA ', '2021-11-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'VENTANILLA', '57', 2, 'PARTICULAR', 12, 1),
(369, 'ACP-2021-000367', '2021-11-26', '1961977', '1955936', '206280', 1, '1988-02-01', 'DNI', '44826396', 'CALIXTO', 'MUCHA', 'HUGO CESAR', '2021-11-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '33', 1, 'PARTICULAR', 12, 1),
(370, 'ACP-2021-000368', '2021-11-29', '1966681', '1960640', '1168779', 1, '1982-07-04', 'DNI', '41389085', 'ANGELES', 'VASQUEZ', 'MARIBEL JACQUELINE', '2021-11-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '39', 2, 'PARTICULAR', 12, 1),
(371, 'ACP-2021-000369', '2021-11-29', '1967416', '1961375', '317484', 1, '1988-08-05', 'DNI', '47837858', 'CABALLERO', 'RAMIREZ', 'ALEXIS RICARDO', '2021-11-29', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '33', 1, 'PARTICULAR', 12, 1),
(372, 'ACP-2021-000370', '2021-11-30', '1964931', '1958890', '1350219', 1, '1983-11-19', 'DNI', '43309303', 'ACERO', 'CHUCHON', 'CRISTIAN ALBERTO', '2021-11-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LINCE', '38', 1, 'PARTICULAR', 10, 1),
(373, 'ACP-2021-000371', '2021-11-30', '1965886', '1959845', '535728', 1, '1999-09-18', 'DNI', '74713543', 'SOSA', 'COCHACHIN', 'GISSELL NAOMI', '2021-11-29', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '22', 2, 'PARTICULAR', 10, 1),
(374, 'ACP-2021-000372', '2021-11-30', '1967026', '1960985', '653810', 1, '1975-02-13', 'DNI', '80407036', 'BRAVO', 'SALVADOR', 'TITO OMAR', '2021-11-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '46', 1, 'PARTICULAR', 10, 1),
(375, 'ACP-2021-000373', '2021-11-30', '1967983', '1961942', '756006', 1, '1946-07-12', 'DNI', '41973621', 'RUIZ', 'SOTOMAYOR', 'RUBEN DARIO', '2021-11-29', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '75', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(376, 'ACP-2021-000374', '2021-12-01', '1968447', '1962406', '754354', 1, '1969-04-14', 'DNI', '09480400', 'BALTODANO', 'QUIROZ', 'JEMINA ', '2021-11-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '52', 2, 'PARTICULAR', 12, 1),
(377, 'ACP-2021-000375', '2021-12-02', '1953122', '1947081', '67927', 1, '1962-07-12', 'DNI', '06870675', 'SALAZAR', 'RIMAYCUNA', 'LUIS ALBERTO', '2021-10-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '59', 1, 'PARTICULAR', 10, 1),
(378, 'ACP-2021-000376', '2021-12-03', '1969473', '1963432', '1350942', 1, '1990-05-17', 'DNI', '46308075', 'NEGRON', 'GARCIA', 'RICARDO ALFONSO', '2021-12-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '31', 1, 'PARTICULAR', 12, 1),
(379, 'ACP-2021-000377', '2021-12-03', '1969388', '1963347', '1350826', 1, '1979-04-30', 'DNI', '40190685', 'RUIZ', 'MARTINEZ', 'FELIPE SEGUNDO', '2021-12-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '42', 1, 'PARTICULAR', 12, 1),
(380, 'ACP-2021-000378', '2021-12-03', '1969744', '1963703', '1001495', 1, '1961-03-20', 'DNI', '01076557', 'CHUJUTALLI', 'DE TENAZOA', 'ELINOR ', '2021-12-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 2, 'SOAT', 12, 1),
(381, 'ACP-2021-000379', '2021-12-06', '1970605', '1964564', '1173226', 1, '1935-04-11', 'DNI', '15290575', 'VICUÑA', 'DE YACHACHIN', 'LEONOR ', '2021-12-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '86', 2, 'PARTICULAR', 12, 1),
(382, 'ACP-2021-000380', '2021-12-09', '1971841', '1965800', '166538', 1, '1944-03-27', 'DNI', '07443298', 'ALVARADO', 'CHALLCO DE RODRIGUEZ', 'FORTUNATA ', '2021-12-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '77', 2, 'PARTICULAR', 10, 1),
(383, 'ACP-2021-000381', '2021-12-10', '1961226', '1955185', '1349753', 1, '1998-03-25', 'DNI', '74134376', 'COTRINA', 'TAPIA', 'LUIS FERNANDO', '2021-11-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '23', 1, 'PARTICULAR', 12, 1),
(384, 'ACP-2021-000382', '2021-12-10', '1965380', '1959339', '125028', 1, '1957-09-07', 'DNI', '06945760', 'SALINAS', 'QUIROZ', 'REGINA CLODOMIRA', '2021-12-28', 'CIRUGIA GENERAL 1 - CONSULTORIOS EXTERNOS', '', 'COMAS', '64', 2, 'SIS', 12, 1),
(385, 'ACP-2021-000383', '2021-12-11', '1970111', '1964070', '696095', 1, '1985-04-14', 'DNI', '43868984', 'TORRES', 'CALIZAYA', 'JULIO CESAR', '2021-12-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '36', 1, 'PARTICULAR', 10, 1),
(386, 'ACP-2021-000384', '2021-12-11', '1965183', '1959142', '248903', 1, '1959-01-22', 'DNI', '07588646', 'CHUCHON', 'BAUTISTA', 'FELICITAS ', '2021-11-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '62', 2, 'SOAT', 10, 1),
(387, 'ACP-2021-000385', '2021-12-14', '1973591', '1967550', '876105', 1, '1977-07-28', 'DNI', '10748782', 'CHAHUARA', 'SALAS', 'JUAN CARLOS', '2021-12-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '44', 1, 'PARTICULAR', 10, 1),
(388, 'ACP-2021-000386', '2021-12-14', '1973261', '1967220', '1176536', 1, '1952-06-01', 'DNI', '15940164', 'JIMENEZ', 'CARHUACHAGUA', 'HUBER ', '2021-12-12', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '69', 1, 'PARTICULAR', 10, 1),
(389, 'ACP-2021-000387', '2021-12-17', '1973831', '1967790', '482390', 1, '1997-07-09', 'DNI', '71058241', 'DAVALOS', 'PALLAJO', 'MOISES ALEXANDER', '2021-12-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '24', 1, 'PARTICULAR', 12, 1),
(390, 'ACP-2021-000388', '2021-12-17', '1975251', '1969210', '1352176', 1, '1989-03-14', 'DNI', '45603661', 'CAVERO', 'ESCALANTE', 'WILLIAMS SEFERINO', '2021-12-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '32', 1, 'PARTICULAR', 12, 1),
(391, 'ACP-2021-000389', '2021-12-20', '1975318', '1969277', '1227844', 1, '1979-04-27', 'DNI', '80531890', 'NOVOA', 'SAAVEDRA', 'NICKEL AMIN', '2021-12-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '42', 1, 'PARTICULAR', 12, 1),
(392, 'ACP-2021-000390', '2021-12-23', '1954927', '1948886', '1348572', 3, '1956-05-11', 'DNI', '02783613', 'CANGO', 'PARRILLA', 'ROMELIA ', '2021-11-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '65', 2, 'PARTICULAR', 10, 1),
(393, 'ACP-2021-000391', '2021-12-23', '1968203', '1962162', '1350725', 1, '1977-04-12', 'DNI', '16789455', 'CHANCAFE', 'ANGELES', 'RUBER ', '2021-11-30', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '44', 1, 'SOAT', 10, 1),
(394, 'ACP-2021-000392', '2021-12-27', '1979075', '1973034', '239036', 1, '1969-10-21', 'DNI', '09483703', 'MAGALLANES', 'PILLACA', 'TEODORO ', '2021-12-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '52', 1, 'PARTICULAR', 12, 1),
(395, 'ACP-2021-000393', '2021-12-27', '1976180', '1970139', '1019458', 1, '1960-06-05', 'DNI', '09027390', 'YALTA', 'DELGADO', 'VILMA LETICIA', '2021-12-22', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '61', 2, 'PARTICULAR', 12, 1),
(396, 'ACP-2021-000394', '2021-12-27', '1978448', '1972407', '1033511', 1, '1946-01-17', 'DNI', '09547962', 'SERIN', 'SEGURA DE CANCINO', 'LUCILA ', '2021-12-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '75', 2, 'PARTICULAR', 12, 1),
(397, 'ACP-2021-000395', '2021-12-28', '1971827', '1965786', '192809', 1, '1959-05-17', 'DNI', '06867118', 'MENDOZA', 'AGUILAR', 'ROSA ', '2021-12-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '62', 2, 'PARTICULAR', 10, 1),
(398, 'ACP-2021-000396', '2021-12-30', '1981153', '1975112', '1353203', 1, '1929-07-27', 'DNI', '08484809', 'OSCORIMA', 'ROMAN', 'JOBITA ', '2021-12-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '92', 2, 'PARTICULAR', 10, 1),
(399, 'ACP-2021-000397', '2021-12-30', '1914017', '1907976', '1339212', 2, '1986-06-29', 'DNI', '44854473', 'NEIRA', 'TOCTO', 'BENJAMIN ', '2021-06-27', 'CIRUGIA - EMERGENCIA', '', 'COMAS', '35', 1, 'PARTICULAR', 10, 1),
(400, 'ACP-2021-000398', '2021-12-30', '1980464', '1974423', '1192550', 1, '1955-11-06', 'DNI', '01101441', 'TOCTO', 'VDA DE NEIRA', 'FIDENCIA ', '2021-12-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '66', 2, 'PARTICULAR', 10, 1),
(401, 'ACP-2022-000001', '2022-01-04', '1831392', '1825348', '239036', 2, '1969-10-21', 'DNI', '09483703', 'MAGALLANES', 'PILLACA', 'TEODORO ', '2020-04-26', 'MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '53', 1, 'PARTICULAR', 10, 1),
(402, 'ACP-2022-000002', '2022-01-04', '1982857', '1976816', '1353540', 1, '1998-05-20', 'DNI', '74918533', 'MAURICIO', 'MIRANDA', 'ESMERALDA ', '2022-01-02', 'OBSTETRICIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '24', 2, 'PARTICULAR', 10, 1),
(403, 'ACP-2022-000003', '2022-01-04', '1983703', '1977662', '622268', 1, '1980-07-07', 'DNI', '40599794', 'BALABARCA', 'JARA', 'WUILLIAMS EDUARDO', '2022-01-04', 'TRAUMATOLOGIA - EMERGENCIA', '', 'CARABAYLLO', '42', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(404, 'ACP-2022-000004', '2022-01-04', '1982839', '1976798', '404544', 1, '1989-11-25', 'DNI', '46139966', 'GAVILÁN', 'VALLEJOS', 'RENZO MARCIAL', '2022-01-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '33', 1, 'PARTICULAR', 10, 1),
(405, 'ACP-2022-000005', '2022-01-06', '1983371', '1977330', '1353637', 1, '1949-03-13', 'DNI', '06462683', 'ALAYO', 'DELGADO', 'LUIS MANUEL', '2022-01-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '73', 1, 'PARTICULAR', 10, 1),
(406, 'ACP-2022-000006', '2022-01-08', '1985563', '1979522', '208415', 1, '1972-09-15', 'DNI', '80297357', 'SANTOS', 'CAMPOS', 'ROBERTO CARLOS', '2022-01-07', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'LOS OLIVOS', '50', 1, 'PARTICULAR', 10, 1),
(407, 'ACP-2022-000007', '2022-01-08', '1984963', '1978922', '1353945', 1, '1959-01-19', 'DNI', '08757696', 'ZUÑIGA', 'CHAMORRO', 'PATRICIO PABLO', '2022-01-06', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '63', 1, 'PARTICULAR', 10, 1),
(408, 'ACP-2022-000008', '2022-01-08', '1985865', '1979824', '1351313', 1, '1957-10-23', 'DNI', '08502335', 'BOCANEGRA', 'CRUZ', 'ELODIA CAROLINA', '2022-01-08', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '65', 2, 'PARTICULAR', 10, 1),
(409, 'ACP-2022-000009', '2022-01-11', '1984703', '1978662', '1012745', 2, '1993-04-23', 'DNI', '48034047', 'GAMARRA', 'YAUCE', 'ROXANA MILAGROS', '2022-01-05', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '29', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(410, 'ACP-2022-000010', '2022-01-13', '1987882', '1981841', '1354547', 1, '1927-04-02', 'DNI', '07164784', 'ESPEJO', 'YPARRAGUIRRE', 'TEODORO ', '2022-01-12', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '95', 1, 'PARTICULAR', 10, 1),
(411, 'ACP-2022-000011', '2022-01-13', '1987011', '1980970', '1349014', 1, '1987-11-02', 'DIE', '147744250', 'ALVARADO', 'SOMAZA', 'YERMAING EMPERATRIZ', '2022-01-10', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '35', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(412, 'ACP-2022-000012', '2022-01-13', '1987056', '1981015', '825751', 1, '1961-10-10', 'DNI', '23377675', 'ESCOBAR', 'CHOQUE', 'FRANCISCA ', '2022-01-10', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 10, 1),
(413, 'ACP-2022-000013', '2022-01-13', '1987133', '1981092', '1126212', 1, '1945-09-08', 'DNI', '06936022', 'GALVEZ', 'VILCATOMA DE MACHUCA', 'MARIA NATIVIDAD', '2022-01-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '77', 2, 'PARTICULAR', 10, 1),
(414, 'ACP-2022-000014', '2022-01-15', '1984814', '1978773', '1353918', 1, '1978-12-14', 'DNI', '41114855', 'SUAZO', 'MOSCOSO', 'JOHN RICARDO', '2022-01-06', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 10, 1),
(415, 'ACP-2022-000015', '2022-01-15', '1988995', '1982954', '960471', 1, '1982-03-13', 'DNI', '41403335', 'SUCNO', 'MARRUJO', 'HELLEN NATHALIE', '2022-01-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '40', 2, 'PARTICULAR', 10, 1),
(416, 'ACP-2022-000016', '2022-01-15', '1988559', '1982518', '1354754', 1, '1960-02-20', 'DNI', '06947151', 'VILLANUEVA', 'LEON', 'LEONIDAS ELEUTERIO', '2022-01-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '62', 1, 'PARTICULAR', 10, 1),
(417, 'ACP-2022-000017', '2022-01-15', '1988458', '1982417', '1354723', 1, '1951-12-16', 'DNI', '08649614', 'ESPINAL', 'ZEGARRA DE CORDOVA', 'VILMA ALICIA', '2022-01-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '71', 2, 'PARTICULAR', 10, 1),
(418, 'ACP-2022-000018', '2022-01-15', '1988393', '1982352', '1092673', 1, '1946-11-08', 'DNI', '06912180', 'AYRAS', 'QUISPE', 'EMPERATRIZ ESMERALDA', '2022-01-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '76', 2, 'PARTICULAR', 10, 1),
(419, 'ACP-2022-000019', '2022-01-18', '1990023', '1983982', '1222640', 1, '1955-11-12', 'DNI', '06873883', 'ZAFRA', 'GALVEZ', 'WALTER ALBERTO', '2022-01-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '67', 1, 'PARTICULAR', 10, 1),
(420, 'ACP-2022-000020', '2022-01-18', '1989723', '1983682', '838844', 1, '1991-07-07', 'DNI', '47508120', 'AGUILAR', 'GONZALES', 'KIARA ISABEL', '2022-01-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '31', 2, 'PARTICULAR', 10, 1),
(421, 'ACP-2022-000021', '2022-01-18', '1989825', '1983784', '1116285', 1, '1936-08-30', 'DNI', '80363726', 'ALVITEZ', 'ZELADA', 'ROSA ANGELICA', '2022-01-17', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '86', 2, 'PARTICULAR', 10, 1),
(422, 'ACP-2022-000022', '2022-01-18', '1989424', '1983383', '420354', 1, '1994-11-27', 'DNI', '76315130', 'PAREDES', 'GRADOS', 'ROSARIO EDITH', '2022-01-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '28', 2, 'PARTICULAR', 10, 1),
(423, 'ACP-2022-000023', '2022-01-20', '1990590', '1984549', '1355210', 1, '1983-03-12', 'DNI', '41796260', 'LAGOS', 'CORDOVA', 'GUSTAVO LUIS', '2022-01-19', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '39', 1, 'PARTICULAR', 10, 1),
(424, 'ACP-2022-000024', '2022-01-20', '1990829', '1984788', '1281745', 1, '1941-06-16', 'DNI', '09029152', 'QUIROZ', 'RIOJAS', 'ALEJANDRO ', '2022-01-19', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '81', 1, 'PARTICULAR', 10, 1);
INSERT INTO `psyem_atencion` (`idAtencion`, `correlativo_Atencion`, `fRegistroAtencion`, `idEpisodio`, `cuentaAtencion`, `historiaAtencion`, `idEstadoPacAtencion`, `fechaPacNacimiento`, `tipdocAtencion`, `nrodocAtencion`, `apPaternoAtencion`, `apMaternoAtencion`, `nombAtencion`, `fIngresoAtencion`, `servAtencion`, `camaAtencion`, `distritoAtencion`, `edadAtencion`, `tipSexoAtencion`, `financiaAtencion`, `idURegAtencion`, `idEstadoAte`) VALUES
(425, 'ACP-2022-000025', '2022-01-20', '1990470', '1984429', '50248', 1, '1935-11-28', 'DNI', '09431485', 'GUTIERREZ', 'QUISPE', 'SATURNINO ', '2022-01-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '87', 1, 'PARTICULAR', 10, 1),
(426, 'ACP-2022-000026', '2022-01-20', '1988406', '1982365', '268763', 1, '1968-01-08', 'DNI', '09482114', 'APOLINARIO', 'NARVAJO', 'ROBERT DINO', '2022-01-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '54', 1, 'PARTICULAR', 10, 1),
(427, 'ACP-2022-000027', '2022-01-20', '1990861', '1984820', '1355262', 1, '1956-08-11', 'DNI', '06831748', 'VELA', 'ROJALES', 'SANTOS ROMAN', '2022-01-19', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '66', 1, 'PARTICULAR', 10, 1),
(428, 'ACP-2022-000028', '2022-01-20', '1988631', '1982590', '241796', 1, '1964-10-07', 'DNI', '06947532', 'CACSIRE', 'DAVALOS', 'JOSE LUIS', '2022-01-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '58', 1, 'PARTICULAR', 10, 1),
(429, 'ACP-2022-000029', '2022-01-20', '1989857', '1983816', '1294515', 1, '1967-07-15', 'DNI', '09403267', 'VILCAHUAMAN', 'ARIAS', 'FELIX RAUL', '2022-01-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '55', 1, 'PARTICULAR', 10, 1),
(430, 'ACP-2022-000030', '2022-01-20', '1990406', '1984365', '293379', 1, '1976-12-26', 'DNI', '10399718', 'GONZALES', 'RUIZ', 'YULI ', '2022-01-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '46', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(431, 'ACP-2022-000031', '2022-01-20', '1991142', '1985101', '1355315', 1, '1962-04-27', 'DNI', '07122291', 'MEJIA', 'ZEGARRA', 'ANGEL ALBERTO', '2022-01-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 10, 1),
(432, 'ACP-2022-000032', '2022-01-20', '1990766', '1984725', '1355240', 1, '1963-08-31', 'DNI', '00045748', 'FLORES', 'RIVAS', 'ERWIN WILMER', '2022-01-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '59', 1, 'PARTICULAR', 10, 1),
(433, 'ACP-2022-000033', '2022-01-20', '1988541', '1982500', '682444', 1, '1943-02-18', 'DNI', '33808086', 'OXOLON', 'GOMEZ', 'SIMON ', '2022-01-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '79', 1, 'PARTICULAR', 10, 1),
(434, 'ACP-2022-000034', '2022-01-21', '1990099', '1984058', '110440', 1, '1949-07-09', 'DNI', '09029204', 'ALARCON', 'POMA', 'ANATOLIA ', '2022-01-17', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '73', 2, 'PARTICULAR', 12, 1),
(435, 'ACP-2022-000035', '2022-01-21', '1989266', '1983225', '1354890', 1, '1989-05-19', 'DNI', '45907975', 'CHIA', 'HUAYTA', 'BRENDA ELIANA', '2022-01-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'ICA', '33', 2, 'PARTICULAR', 12, 1),
(436, 'ACP-2022-000036', '2022-01-21', '1985557', '1979516', '42146', 1, '1948-04-17', 'DNI', '09400235', 'VERDE', 'JARAMILLO', 'YLAZARA ANICETA', '2022-01-08', 'GASTROENTEROLOGIA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '74', 2, 'PARTICULAR', 12, 1),
(437, 'ACP-2022-000037', '2022-01-22', '1991192', '1985151', '1355328', 1, '1961-08-28', 'DNI', '09039671', 'RIOS', 'SUAREZ', 'MARIA ELENA', '2022-01-20', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 10, 1),
(438, 'ACP-2022-000038', '2022-01-22', '1991313', '1985272', '355109', 1, '1933-12-13', 'DNI', '48876547', 'FERRUA', 'CABRERA', 'PAULINA ', '2022-01-21', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '89', 2, 'PARTICULAR', 10, 1),
(439, 'ACP-2022-000039', '2022-01-22', '1990397', '1984356', '373736', 2, '1966-12-23', 'DNI', '09467236', 'VERASTEGUI', 'SORIANO', 'OSCAR TEOFILO', '2022-01-19', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '56', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(440, 'ACP-2022-000040', '2022-01-22', '1991587', '1985546', '589864', 1, '1963-09-23', 'DNI', '06238574', 'AGUILAR', 'BULA', 'ROSA AMALIA', '2022-01-21', 'CORONAVIRUS - EMERGENCIA', '', 'COMAS', '59', 2, 'PARTICULAR', 10, 1),
(441, 'ACP-2022-000041', '2022-01-22', '1990684', '1984643', '1143236', 1, '1937-07-30', 'DNI', '10402126', 'RAMOS', 'MEZA', 'FELIX ', '2022-01-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '85', 1, 'PARTICULAR', 10, 1),
(442, 'ACP-2022-000042', '2022-01-22', '1991809', '1985768', '1152907', 1, '1952-05-23', 'DNI', '07322533', 'PADILLA', 'VASQUEZ', 'JOSE MIGUEL', '2022-01-22', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '70', 1, 'PARTICULAR', 10, 1),
(443, 'ACP-2022-000043', '2022-01-22', '1991645', '1985604', '1195611', 1, '1969-12-20', 'DNI', '09733866', 'HURTADO', 'ROMAN', 'DANILO NINO', '2022-01-22', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '53', 1, 'PARTICULAR', 10, 1),
(444, 'ACP-2022-000044', '2022-01-24', '1990090', '1984049', '1180950', 1, '1995-07-12', 'DNI', '70557382', 'HANCCO', 'FALCON', 'NOEMI RUTH', '2022-01-18', 'COVID UCI - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '27', 2, 'PARTICULAR', 12, 1),
(445, 'ACP-2022-000045', '2022-01-24', '1992115', '1986074', '1101337', 1, '1939-10-10', 'DNI', '10402777', 'CUEVA', 'NINA', 'LUIS ', '2022-01-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '83', 1, 'SOAT', 12, 1),
(446, 'ACP-2022-000046', '2022-01-24', '1992116', '1986075', '121810', 1, '1945-04-01', 'DNI', '06835846', 'TRUJILLANO', 'MOLLO', 'TEODORA GRACIELA', '2022-01-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '77', 2, 'PARTICULAR', 12, 1),
(447, 'ACP-2022-000047', '2022-01-24', '1991922', '1985881', '841068', 1, '1955-12-11', 'DNI', '09169591', 'TADEO', 'ARRIETA', 'ALBERTO ', '2022-01-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '67', 1, 'PARTICULAR', 12, 1),
(448, 'ACP-2022-000048', '2022-01-24', '1991582', '1985541', '1355409', 1, '1963-12-20', 'DNI', '06934788', 'GUERRA', 'QUIÑONES', 'CARMEN RAQUEL', '2022-01-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '59', 2, 'PARTICULAR', 12, 1),
(449, 'ACP-2022-000049', '2022-01-24', '1991942', '1985901', '1326522', 1, '1954-03-08', 'DNI', '06820796', 'GUTIERREZ', 'CASTRO VDA DE EGUES', 'MARTHA FELICIA', '2022-01-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '68', 2, 'PARTICULAR', 12, 1),
(450, 'ACP-2022-000050', '2022-01-24', '1992044', '1986003', '287625', 1, '1968-08-24', 'DNI', '09404232', 'MOYA', 'ARANDA', 'BERTHA SOLEDAD', '2022-01-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '54', 2, 'PARTICULAR', 12, 1),
(451, 'ACP-2022-000051', '2022-01-24', '1991776', '1985735', '645627', 1, '1980-09-17', 'DNI', '40609518', 'LOZADA', 'CISNEROS', 'JACQUELINE ROXANA', '2022-01-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '42', 2, 'PARTICULAR', 12, 1),
(452, 'ACP-2022-000052', '2022-01-25', '1993345', '1987304', '1355700', 1, '1991-09-05', 'DNI', '47381279', 'CARBAJAL', 'SILVESTRE', 'DARVIN ELEUTERIO', '2022-01-25', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '31', 1, 'PARTICULAR', 10, 1),
(453, 'ACP-2022-000053', '2022-01-25', '1991860', '1985819', '854937', 1, '1962-09-04', 'DNI', '09479115', 'BARRUETA', 'SAENZ', 'WILLIAMS ', '2022-01-22', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 10, 1),
(454, 'ACP-2022-000054', '2022-01-25', '1992128', '1986087', '167928', 1, '1953-06-12', 'DNI', '06887283', 'MADUEÑO', 'SOTO', 'ADA LEONOR', '2022-01-23', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '69', 2, 'PARTICULAR', 10, 1),
(455, 'ACP-2022-000055', '2022-01-25', '1991195', '1985154', '515056', 1, '1938-05-27', 'DNI', '09403189', 'CACERES', 'PACHAS', 'SANTIAGO ', '2022-01-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '84', 1, 'PARTICULAR', 10, 1),
(456, 'ACP-2022-000056', '2022-01-25', '1990164', '1984123', '424510', 1, '1955-05-14', 'DNI', '06916585', 'TORRES', 'CORTEZ', 'AIDA ZELMIRA', '2022-01-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '67', 2, 'PARTICULAR', 10, 1),
(457, 'ACP-2022-000057', '2022-01-26', '1993871', '1987830', '1355770', 1, '1976-11-16', 'CE', '004071151', 'PEREZ', 'FREITES', 'ELIO DAVID', '2022-01-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 12, 1),
(458, 'ACP-2022-000058', '2022-01-27', '1992195', '1986154', '1113066', 1, '1944-08-30', 'DNI', '80595356', 'COSME', 'MEZA', 'ROSA ', '2022-01-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '78', 2, 'PARTICULAR', 10, 1),
(459, 'ACP-2022-000059', '2022-01-27', '1991780', '1985739', '1355457', 1, '1953-12-03', 'DNI', '06116053', 'DE LA CRUZ', 'VERA', 'JUAN FRANCISCO', '2022-01-22', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '69', 1, 'SOAT', 10, 1),
(460, 'ACP-2022-000060', '2022-01-27', '1990127', '1984086', '1085984', 1, '1956-03-10', 'DNI', '08630272', 'CORTEZ', 'AVELINO', 'SANTOS VICTOR', '2022-01-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '66', 1, 'PARTICULAR', 10, 1),
(461, 'ACP-2022-000061', '2022-01-27', '1993091', '1987050', '1355635', 1, '2005-03-24', 'DNI', '74666670', 'DELGADILLO', 'MORENO', 'LADY DIANA', '2022-01-26', 'COVID OBSTETRICIA  - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '17', 2, 'PARTICULAR', 10, 1),
(462, 'ACP-2022-000062', '2022-01-27', '1993801', '1987760', '117247', 1, '1948-03-06', 'DNI', '09169822', 'RAMIREZ', 'ESCUDERO', 'LUDITH ', '2022-01-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '74', 1, 'PARTICULAR', 10, 1),
(463, 'ACP-2022-000063', '2022-01-27', '1993289', '1987248', '1261645', 1, '1962-01-31', 'DNI', '06856476', 'VASQUEZ', 'CAMPOS', 'JORGE FRANCISCO', '2022-01-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '60', 1, 'PARTICULAR', 10, 1),
(464, 'ACP-2022-000064', '2022-01-27', '1991258', '1985217', '1355343', 1, '1946-06-13', 'DIE', '2982163', 'MANRIQUE', '', 'JOSE ', '2022-01-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '76', 1, 'CONVENIOS PÚBLICOS', 10, 1),
(465, 'ACP-2022-000065', '2022-01-27', '1987547', '1981506', '1354491', 1, '1988-05-21', 'DNI', '46547501', 'VALENCIA', 'IGREDA', 'JOHNNY RAUL', '2022-01-11', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '34', 1, 'PARTICULAR', 10, 1),
(466, 'ACP-2022-000066', '2022-01-27', '1993704', '1987663', '1325269', 1, '1957-06-09', 'DNI', '08286625', 'QUISOCALA', 'AVALOS', 'FELICIANO FELIX', '2022-01-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '65', 1, 'PARTICULAR', 10, 1),
(467, 'ACP-2022-000067', '2022-01-27', '1991685', '1985644', '1355439', 2, '2004-12-23', 'CE', '31363276', 'BLANCO', 'ROJAS', 'WUILMARY ANYELI', '2022-01-23', 'COVID OBSTETRICIA  - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '18', 2, 'PARTICULAR', 10, 1),
(468, 'ACP-2022-000068', '2022-01-28', '1994772', '1988731', '1355878', 1, '1938-11-26', 'DNI', '08360394', 'VARGAS MACHUCA', 'BALAREZO', 'JORGE ', '2022-01-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '84', 1, 'SOAT', 12, 1),
(469, 'ACP-2022-000069', '2022-01-28', '1993785', '1987744', '489715', 1, '1997-08-09', 'DNI', '77473144', 'BECERRA', 'RABANAL', 'WINY ESTHER', '2022-01-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '25', 2, 'PARTICULAR', 12, 1),
(470, 'ACP-2022-000070', '2022-01-28', '1995246', '1989205', '1355955', 1, '1967-01-10', 'DNI', '09554774', 'LOPEZ', 'MARROQUIN', 'LUIS HUMBERTO', '2022-01-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '55', 1, 'PARTICULAR', 12, 1),
(471, 'ACP-2022-000071', '2022-01-29', '1991623', '1985582', '1355421', 3, '1984-10-20', 'DNI', '43594016', 'ANICETO', 'CAMONES', 'DAVID ', '2022-01-22', 'COVID UCI - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '38', 1, 'PARTICULAR', 10, 1),
(472, 'ACP-2022-000072', '2022-01-29', 'ANULADA', 'ANULADA', '1303523', 3, '1938-03-02', 'DNI', '25821194', 'CORDOVA', 'DE MELENDEZ', 'ROSARIO ', '2022-01-20', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '84', 2, 'CREDITO HOSPITALARIO', 10, 2),
(473, 'ACP-2022-000073', '2022-01-29', '1992169', '1986128', '320641', 3, '1955-01-31', 'DNI', '10401335', 'ATENCIO', 'MATIAS', 'JUANA ', '2022-01-24', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '67', 2, 'PARTICULAR', 10, 1),
(474, 'ACP-2022-000074', '2022-01-29', '1989284', '1983243', '315834', 3, '1945-03-24', 'DNI', '06825149', 'ATOCHE', 'CARRANZA DE PEREZ', 'GRIMANEZA YOLANDA', '2022-01-15', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '77', 2, 'PARTICULAR', 10, 1),
(475, 'ACP-2022-000075', '2022-01-29', '1986352', '1980311', '1354252', 1, '1976-07-28', 'DNI', '08176612', 'BULEJE', 'SAENZ', 'PEDRO FELIX', '2022-01-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '46', 1, 'PARTICULAR', 10, 1),
(476, 'ACP-2022-000076', '2022-01-29', '1995371', '1989330', '558257', 1, '1941-05-02', 'DNI', '06931534', 'RODRIGUEZ', 'DELGADO', 'OSCAR ', '2022-01-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '81', 1, 'PARTICULAR', 10, 1),
(477, 'ACP-2022-000077', '2022-01-29', '1994821', '1988780', '466774', 1, '1968-08-28', 'DNI', '10404905', 'ASTUQUIPAN', 'BRICEÑO', 'FLOR SANTOS', '2022-01-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '54', 2, 'PARTICULAR', 10, 1),
(478, 'ACP-2022-000078', '2022-01-29', '1995729', '1989688', '1356028', 1, '1944-03-24', 'DNI', '40996633', 'DAVILA', 'FLORES', 'GABRIEL ', '2022-01-28', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '78', 1, 'SIS', 10, 1),
(479, 'ACP-2022-000079', '2022-01-29', '1986125', '1980084', '1347402', 1, '1982-11-19', 'DNI', '44499591', 'BORDA', 'RAMOS', 'HENRRY ', '2022-01-15', 'MEDICINA - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '40', 1, 'PARTICULAR', 10, 1),
(480, 'ACP-2022-000080', '2022-01-29', '1995387', '1989346', '1315862', 1, '1946-06-28', 'DNI', '44608800', 'NIEVES', 'CORREA', 'JESUSA SANTA', '2022-01-28', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '76', 2, 'PARTICULAR', 10, 1),
(481, 'ACP-2022-000081', '2022-01-31', '1995900', '1989859', '1187092', 2, '1961-10-21', 'DNI', '06828216', 'DE LA CRUZ', 'NEYRA', 'SUSANA ELVIRA', '2022-01-29', 'MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 12, 1),
(482, 'ACP-2022-000082', '2022-01-31', '1990294', '1984253', '1108757', 1, '1954-01-01', 'DNI', '09017715', 'VIRHUEZ', 'ASES', 'JESUS FULGENCIO', '2022-01-21', 'NEUMOLOGIA - HOSPITALIZACIÓN ', '', 'COMAS', '68', 1, 'PARTICULAR', 12, 1),
(483, 'ACP-2022-000083', '2022-01-31', '1991631', '1985590', '239931', 1, '1978-03-25', 'DNI', '10694044', 'REGALADO', 'RIOS', 'ALEJANDRO DANTE', '2022-01-22', 'CIRUGIA GENERAL - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 10, 1),
(484, 'ACP-2022-000084', '2022-01-31', '1995261', '1989220', '821525', 1, '1957-04-16', 'DNI', '07582391', 'MENDOZA', 'CASANA', 'CARMEN ROSARIO', '2022-01-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '65', 2, 'PARTICULAR', 10, 1),
(485, 'ACP-2022-000085', '2022-01-31', '1994776', '1988735', '927766', 1, '1990-09-07', 'DNI', '60070557', 'GUARDAMINO', 'AGUILAR', 'ELIZETH NATIVIDAD', '2022-01-27', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '32', 2, 'CONVENIOS PÚBLICOS', 10, 1),
(486, 'ACP-2022-000086', '2022-01-31', '1993859', '1987818', '1355556', 1, '1950-01-27', 'DNI', '48218004', 'TORRES', 'VARGAS', 'ANGEL CARLOS', '2022-01-25', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '72', 1, 'PARTICULAR', 10, 1),
(487, 'ACP-2022-000087', '2022-02-01', '1996454', '1990413', '312994', 1, '1988-08-04', 'DNI', '70251477', 'CHAPOÑAN', 'BECERRA', 'GRABIELA ISOLINA', '2022-01-30', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '34', 2, 'PARTICULAR', 10, 1),
(488, 'ACP-2022-000088', '2022-02-01', '1996131', '1990090', '1187092', 1, '1961-10-21', 'DNI', '06828216', 'DE LA CRUZ', 'NEYRA', 'SUSANA ELVIRA', '2022-01-31', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 10, 1),
(489, 'ACP-2022-000089', '2022-02-01', '1997407', '1991366', '206946', 1, '1938-06-24', 'DNI', '06924999', 'FLORES', 'PEZO', 'JUAN ', '2022-02-01', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '84', 1, 'PARTICULAR', 10, 1),
(490, 'ACP-2022-000090', '2022-02-02', '1994870', '1988829', '339692', 2, '1961-02-08', 'DNI', '09173117', 'CALMET', 'BRAVO', 'GLADYS YSABEL', '2022-01-27', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '61', 2, 'PARTICULAR', 12, 1),
(491, 'ACP-2022-000091', '2022-02-02', '1997028', '1990987', '1341928', 1, '1958-09-10', 'DNI', '06204194', 'QUIROZ', 'BERROCAL', 'VICTOR TEODORO', '2022-01-31', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '64', 1, 'PARTICULAR', 12, 1),
(492, 'ACP-2022-000092', '2022-02-02', '1997971', '1991930', '1135702', 1, '1967-12-13', 'DNI', '09469927', 'DIONICIO', 'AROTINGO', 'MARIA ELENA', '2022-02-02', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '55', 2, 'PARTICULAR', 12, 1),
(493, 'ACP-2022-000093', '2022-02-03', '1995874', '1989833', '1355906', 1, '1939-11-16', 'DNI', '15205101', 'AGUERO', 'ALDAVE', 'EDMUNDO ', '2022-01-29', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '83', 1, 'PARTICULAR', 10, 1),
(494, 'ACP-2022-000094', '2022-02-03', '1996154', '1990113', '1356106', 1, '1955-11-14', 'DNI', '08020931', 'GONZALES', 'ARIAS', 'SERGIO ', '2022-01-29', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '67', 1, 'PARTICULAR', 10, 1),
(495, 'ACP-2022-000095', '2022-02-04', '1998509', '1992468', '1293336', 1, '1942-07-28', 'DNI', '06930311', 'ESPINOZA', 'SANCHEZ DE SALAS', 'JULIA ELSA', '2022-02-03', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '80', 2, 'PARTICULAR', 12, 1),
(496, 'ACP-2022-000096', '2022-02-06', '1995581', '1989540', '1356008', 1, '2001-07-14', 'DNI', '74007286', 'PORTELLA', 'RUIZ', 'DIEGO ARMANDO', '2022-01-29', 'NEUMOLOGIA - HOSPITALIZACIÓN ', '', 'COMAS', '21', 1, 'PARTICULAR', 10, 1),
(497, 'ACP-2022-000097', '2022-02-07', '1999566', '1993525', '1356766', 1, '1955-05-26', 'DNI', '25600490', 'SANCHEZ', 'DE SEGERSBOL', 'ROSA E', '2022-02-06', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '67', 2, 'PARTICULAR', 12, 1),
(498, 'ACP-2022-000098', '2022-02-09', '2000090', '1994049', '927566', 1, '1970-07-08', 'DNI', '09450593', 'MALAGA', 'RAMIREZ', 'OSWALDO ALEX', '2022-02-07', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '52', 1, 'PARTICULAR', 12, 1),
(499, 'ACP-2022-000099', '2022-02-10', '1997556', '1991515', '374804', 1, '1949-01-26', 'DNI', '09480153', 'IPARRAGUIRRE', 'GIMENES', 'TEOFENES ', '2022-02-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '73', 2, 'PARTICULAR', 10, 1),
(500, 'ACP-2022-000100', '2022-02-11', '2000667', '1994626', '1356992', 1, '1968-02-28', 'DNI', '23156841', 'ESPIRITU', 'FASABI', 'ELVA ERLINDA', '2022-02-09', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '54', 2, 'PARTICULAR', 12, 1),
(501, 'ACP-2022-000101', '2022-02-11', '1990482', '1984441', '1355186', 1, '1982-02-17', 'DNI', '45017160', 'RIVAS', 'CARDENAS', 'JOEL ', '2022-01-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '40', 1, 'PARTICULAR', 12, 1),
(502, 'ACP-2022-000102', '2022-02-12', '1998552', '1992511', '695068', 1, '1947-02-12', 'DNI', '06759089', 'CASTAGNETO', 'UGARTE', 'LUIS ALBERTO', '2022-02-03', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '75', 1, 'PARTICULAR', 10, 1),
(503, 'ACP-2022-000103', '2022-02-15', '2003070', '1997029', '1080563', 1, '1933-06-23', 'DNI', '45657027', 'MARCALAYA', 'ORTIZ', 'AGRIPINA ', '2022-02-14', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '89', 2, 'PARTICULAR', 10, 1),
(504, 'ACP-2022-000104', '2022-02-17', '2003901', '1997860', '320944', 1, '1974-07-22', 'DNI', '10389265', 'TORRES', 'YPANAQUE', 'ANA MARIA', '2022-02-16', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '48', 2, 'PARTICULAR', 10, 1),
(505, 'ACP-2022-000105', '2022-02-17', '2003552', '1997511', '656630', 1, '1978-05-18', 'DNI', '10881331', 'COTARMA', 'PISCO', 'JULIO CESAR', '2022-02-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '44', 1, 'PARTICULAR', 10, 1),
(506, 'ACP-2022-000106', '2022-02-18', '1987560', '1981519', '320944', 2, '1974-07-22', 'DNI', '10389265', 'TORRES', 'YPANAQUE', 'ANA MARIA', '2022-01-11', 'MEDICINA - EMERGENCIA', '', 'CARABAYLLO', '48', 2, 'PARTICULAR', 12, 1),
(507, 'ACP-2022-000107', '2022-02-22', '1990440', '1984399', '1298817', 1, '1945-11-02', 'DNI', '22711946', 'MERINO', 'GOMEZ', 'TOBIAS ', '2022-01-18', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '77', 1, 'PARTICULAR', 10, 1),
(508, 'ACP-2022-000108', '2022-02-22', '1991478', '1985437', '792590', 1, '1964-10-21', 'DNI', '08437475', 'SALAZAR', 'OBISPO', 'ZOTICO CASTRO', '2022-01-21', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '58', 1, 'PARTICULAR', 10, 1),
(509, 'ACP-2022-000109', '2022-02-26', '1990637', '1984596', '634711', 3, '1953-09-23', 'DNI', '07100197', 'NEYRA', 'TERREROS', 'RUBEN ALFREDO', '2022-01-19', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '69', 1, 'PARTICULAR', 10, 1),
(510, 'ACP-2022-000110', '2022-03-01', '1997919', '1991878', '1356429', 1, '1958-07-04', 'DNI', '07553097', 'LUGO', 'CORPUS', 'PABLO EDMUNDO', '2022-02-02', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '64', 1, 'SOAT', 10, 1),
(511, 'ACP-2022-000111', '2022-03-13', '1998092', '1992051', '868412', 2, '1958-08-02', 'DNI', '06168307', 'ARONE', 'VILCHEZ', 'ALFREDO ', '2022-02-02', 'MEDICINA - EMERGENCIA', '', 'COMAS', '64', 1, 'PARTICULAR', 10, 1),
(512, 'ACP-2022-000112', '2022-03-13', '2016537', '2010496', '294884', 2, '1934-07-30', 'DNI', '09627298', 'BENDEZU', 'GARCIA', 'MAXIMILIANA ', '2022-03-09', 'CORONAVIRUS - EMERGENCIA', '', 'CARABAYLLO', '88', 2, 'PARTICULAR', 10, 1),
(513, 'ACP-2022-000113', '2022-03-18', '2018360', '2012330', '623763', 1, '1986-05-04', 'DNI', '43578028', 'TELLO', 'CAFFERATA', 'TEREZINHA ELIANA', '2022-03-13', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '36', 2, 'PARTICULAR', 10, 1),
(514, 'ACP-2022-000114', '2022-03-18', '2020046', '2014016', '1360192', 1, '1944-06-09', 'DNI', '06906152', 'LOAYZA', 'CURAHUA VDA DE CAMPOS', 'JULIA ', '2022-03-16', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'COMAS', '78', 2, 'SOAT', 10, 1),
(515, 'ACP-2022-000115', '2022-04-01', '2026872', '2020842', '923265', 1, '1959-05-07', 'DNI', '02529800', 'YANAPA', 'DE CALSINA', 'DOMITILA ', '2022-03-26', 'COVID LEGADO - HOSPITALIZACIÓN ', '', 'CARABAYLLO', '63', 2, 'PARTICULAR', 10, 1);

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
  `detaDiagnostico` varchar(100) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `psyem_diagnosticos`
--

INSERT INTO `psyem_diagnosticos` (`idDiagnostico`, `cieDiagnostico`, `detaDiagnostico`) VALUES
(1, '99401.19', 'Consejería para el autocuidado'),
(2, 'F32.0', 'Episodio depresivo leve'),
(3, 'F41.2', 'Trastorno mixto de ansiedad y depresión'),
(4, 'F41.9', 'Trastorno de ansiedad, no especificado'),
(5, 'F43.0', 'Reacción al estrés agudo'),
(6, 'F43.1', 'Trastorno de estrés postraumático'),
(7, 'F43.2', 'Trastornos de adaptación'),
(8, 'Z65.5', 'Problemas relacionados con la exposición a desastre, guerra u otras hostilidades'),
(9, '99404', 'Consejería en Salud Mental 1'),
(10, '99404.1', 'Consejería en Salud Mental 2'),
(11, '99404.2', 'Consejería en Salud Mental 3'),
(12, 'Z63.4', 'PROBLEMAS RELACIONADOS CON LA DESAPARICIÓN O MUERTE DE UN MIEMBRO DE LA FAMILIA'),
(13, 'Z63.7', 'Problemas relacionados con otros hechos estresantes que afectan a la familia y la casa'),
(14, '99499.08', 'Teleorientación Síncrona'),
(15, '98968.1', 'Seguimiento Telefónico 1'),
(16, '98968.2', 'Seguimiento Telefónico 2'),
(17, '98968.3', 'Seguimiento Telefónico 3'),
(18, 'SCCIE', 'Seguimiento al paciente'),
(19, 'Z63.2', 'PROBLEMAS RELACIONADOS CON EL APOYO FAMILIAR INADECUADO'),
(20, 'Z63.3', 'PROBLEMAS RELACIONADOS CON LA AUSENCIA DE UN MIEMBRO DE LA FAMILIA'),
(21, '99207.08', 'Primeros auxilios Psicológicos'),
(22, 'F32.9', 'Episodio depresivo sin especificación');

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
(1, '2021-06-18', 1, 1, 2, 2, 'DNI', '06901209', 'PILAR GARRAFA SANCHEZ DE RODRIGUEZ', '61', ''),
(2, '2021-06-18', 1, 1, 6, 1, 'DNI', '41100883', 'JOSLY MIGUEL JARA ALBARRACIN', '40', ''),
(3, '2021-06-18', 1, 2, 6, 2, 'DNI', '08131002', 'JOANA ELSA DEYRA GONZALES', '51', ''),
(4, '2021-06-18', 1, 3, 6, 2, 'DNI', '09521648', 'ROMILIA ELENA ATAUCUSI LUDIÑA', '49', ''),
(5, '2021-06-18', 1, 3, 8, 1, 'DNI', '74885034', 'DANIEL SMIT URRUTIA MEDINA', '28', ''),
(6, '2021-06-18', 1, 4, 3, 2, 'DNI', '72896185', 'PAMELA CRISTINA TARMEÑO RIVERA', '26', ''),
(7, '2021-06-18', 1, 5, 3, 2, 'DNI', '09472422', 'HILDA MARIA CORONADO HUAMAN', '53', ''),
(8, '2021-06-18', 1, 6, 6, 2, 'DNI', '80014709', 'MARIA MERCEDES BOCANEGRA RIVAS', '49', ''),
(9, '2021-06-18', 1, 7, 3, 2, 'DNI', '44739988', 'LISETT SOLEDAD MONGE SOTO', '33', ''),
(10, '2021-06-18', 1, 8, 6, 1, 'DNI', '44366004', 'LUIS ANGEL VIVANCO CUADROS', '35', ''),
(11, '2021-06-18', 1, 9, 9, 2, 'DNI', '40196938', 'EDITH CASTILLO GONZALES', '41', ''),
(12, '2021-06-18', 1, 10, 3, 2, 'DNI', '47221722', 'ZADITH CHAVEZ GIRALDO', '25', ''),
(13, '2021-06-18', 1, 11, 7, 2, 'DNI', '01552621', 'FLORA HANCCO APAZA', '43', ''),
(14, '2021-06-18', 1, 12, 9, 2, 'DNI', '27746345', 'ENMA FLOR GARCIA BERMEO', '50', ''),
(15, '2021-06-18', 1, 13, 9, 2, 'DNI', '09732019', 'HAYDEE FRANCISCA GERONIMO CARBAJAL', '50', ''),
(16, '2021-06-18', 1, 14, 3, 1, 'DNI', '44557018', 'CARLOS MARIO CHAVEZ GIRALDO', '33', ''),
(17, '2021-06-18', 1, 15, 3, 2, 'DNI', '09547020', 'CARMELA FIORELLA CHUIMA LARDIZABAL', '50', ''),
(18, '2021-06-18', 1, 16, 3, 2, 'DNI', '48417368', 'YARUXA YERLANDINE SANCHEZ RAMOS', '27', ''),
(19, '2021-06-18', 1, 17, 9, 2, 'DNI', '80372498', 'MARIA MARTHA IMAN FLORES', '42', ''),
(20, '2021-06-18', 1, 18, 3, 1, 'DNI', '43227196', 'ERICK SANDOVAL VARGAS', '35', ''),
(21, '2021-06-18', 1, 19, 3, 1, 'DNI', '44869333', 'BLAISE PASCAL BERRU HUAMAN', '33', ''),
(22, '2021-06-18', 1, 20, 8, 1, 'DNI', '40586292', 'CARLOS JAVIER MARROQUIN BUIZA', '42', ''),
(23, '2021-06-18', 1, 21, 6, 1, 'DNI', '06779591', 'MIRIAM SOLEDAD NINAHUANCA LAURA', '63', ''),
(24, '2021-06-18', 1, 22, 3, 2, 'DNI', '45103230', 'ANDREA NATHALY MOGOLLON CUELLO', '32', ''),
(25, '2021-06-18', 1, 23, 9, 2, 'DNI', '42368722', 'MARIA DEL PILAR CARHUAYAL SOTO', '38', ''),
(26, '2021-06-18', 1, 24, 3, 1, 'DNI', '41773512', 'CHRISTIAN ANDRES AGUIRRE SAAVEDRA', '38', ''),
(27, '2021-06-18', 1, 25, 3, 2, 'DNI', '40229921', 'RAQUEL CORINA HUARANGA CASTRO DE NAZAR', '42', ''),
(28, '2021-06-18', 1, 26, 3, 1, 'DNI', '45787628', 'NIVARDO RAFAEL MORI MORENO', '31', ''),
(29, '2021-06-18', 1, 27, 3, 1, 'DNI', '76187018', 'JUNIOR YAMPIER BARTOLO VILLANUEVA', '26', ''),
(30, '2021-06-18', 1, 28, 9, 2, 'DNI', '08158916', 'MARILUZ TAZA LOAYZA DE CAPCHA', '47', ''),
(31, '2021-06-18', 1, 29, 6, 2, 'DNI', '73442980', 'MELANNIE DEBBY PACHECO GUTIERREZ', '26', ''),
(32, '2021-06-18', 1, 30, 9, 2, 'DNI', '09745345', 'CARMEN ROSA CARDENAS MEJIA', '50', ''),
(33, '2021-06-18', 1, 31, 6, 1, 'DNI', '07739512', 'FIDEL ANTONIO BAUTISTA CUEVA', '56', ''),
(34, '2021-06-18', 1, 31, 8, 1, 'DNI', '09540751', 'RONNY WILLIAM GONZALES VILCHEZ', '49', ''),
(35, '2021-06-18', 1, 33, 3, 2, 'DNI', '72978357', 'MARIA CLAUDIA JEANNEAU ESPINOZA', '20', ''),
(36, '2021-06-18', 1, 34, 3, 2, 'DNI', '09737376', 'MARIA BEATRIZ HUERTA RODRIGUEZ', '50', ''),
(37, '2021-06-18', 1, 35, 9, 2, 'DNI', '09028968', 'CARMEN SOFIA MERINO ROJAS', '54', ''),
(38, '2021-06-18', 1, 35, 3, 2, 'DNI', '46123673', 'ELISA KATHERINE SAHUANGA PEÑA', '31', ''),
(39, '2021-06-18', 1, 37, 3, 2, 'DNI', '43733218', 'ALCIRA SANCHEZ CASTRO', '34', ''),
(40, '2021-06-18', 1, 38, 9, 1, 'DNI', '06845974', 'TEODORO JUAN DE DIOS CACERES', '60', ''),
(41, '2021-06-18', 1, 39, 8, 1, 'DNI', '40879074', 'ANGEL MIGUEL OLARTE ESTRELLA', '40', ''),
(42, '2021-06-18', 1, 94, 3, 2, 'DNI', '10395972', 'ELIZABETH PAULINO VELIZ', '45', ''),
(43, '2021-06-18', 1, 41, 6, 1, 'DNI', '71648162', 'JHAN CARLOS ROQUE JARAMILLO', '23', ''),
(44, '2021-06-18', 1, 42, 2, 2, 'DNI', '06829321', 'JUANA ISABEL CRISOSTOMO VASQUEZ', '61', ''),
(45, '2021-06-18', 1, 36, 3, 2, 'DNI', '45530511', 'EVELYN DIANA SILVA CHAVEZ', '32', ''),
(46, '2021-06-18', 1, 48, 3, 1, 'DNI', '10744342', 'JOSE MAXIMO FLORES YSUSQUIZA', '43', ''),
(47, '2021-06-18', 1, 49, 3, 2, 'DNI', '46211854', 'SHEYLA ROSARIO DELGADO RAMIREZ', '31', ''),
(48, '2021-06-18', 1, 50, 3, 2, 'DNI', '41352894', 'JAQUELINE TERESA CANALES QUEZADA DE ARROYO', '39', ''),
(49, '2021-06-18', 1, 52, 5, 2, 'DNI', '70471656', 'SILVANA GERALDINE PALOMINO URQUIZA', '24', ''),
(50, '2021-06-18', 1, 53, 3, 2, 'DNI', '42527962', 'ROSSE MARY ZEVALLOS CONDOR DE ALARCON', '41', ''),
(51, '2021-06-18', 1, 54, 9, 2, 'DNI', '45871446', 'CARMEN MERINO QUISPE', '32', ''),
(52, '2021-06-18', 1, 55, 6, 2, 'DNI', '70295027', 'SHEYLA SAYURI CASTILLO ESPINOZA', '28', ''),
(53, '2021-06-18', 1, 44, 3, 1, 'DNI', '76567576', 'JIMMY ANDY CALDERON CACERES', '25', ''),
(54, '2021-06-18', 1, 56, 5, 1, 'DNI', '72804901', 'EDWAR ANDRES VERA COELLO', '20', ''),
(55, '2021-06-18', 1, 57, 6, 2, 'DNI', '09742681', 'MARISOL BENILDA RODRIGUEZ CANICOBA', '49', ''),
(56, '2021-06-18', 1, 59, 3, 2, 'DNI', '76865778', 'YESSLIN HERMOSILLA MAJINO', '25', ''),
(57, '2021-06-18', 1, 51, 8, 2, 'DNI', '47483337', 'MARIA ELBA SUAREZ FLORES', '29', ''),
(58, '2021-06-18', 1, 62, 3, 2, 'DNI', '70509987', 'LUCIA ESTHEFANI MORENO ALLAUCA', '24', ''),
(59, '2021-06-18', 1, 63, 3, 2, 'DNI', '20055260', 'ROSA GIOVANNA SUAREZ LEIVA', '47', ''),
(60, '2021-06-18', 1, 66, 3, 2, 'DNI', '45770089', 'YENIFER GISELA SEGUNDO ROMERO', '31', ''),
(61, '2021-06-18', 1, 58, 6, 1, 'DNI', '10213347', 'ARMANDO MARTIN CRISOSTOMO VASQUEZ', '36', ''),
(62, '2021-06-18', 1, 67, 3, 1, 'DNI', '41706736', 'FERNANDO CASTAÑEDA SILVA', '38', ''),
(63, '2021-06-18', 1, 68, 9, 2, 'DNI', '46801078', 'MEDALITH SUYON CHICANA', '29', ''),
(64, '2021-06-18', 1, 71, 8, 2, 'DNI', '71730262', 'IVETTE MIRELLA CRUZ DIAZ', '29', ''),
(65, '2021-06-18', 1, 72, 3, 2, 'DNI', '71126063', 'JAZMIN OFELIA SIMBALA PINEDO', '23', ''),
(66, '2021-06-18', 1, 75, 3, 2, 'DNI', '77468779', 'EVELYN GABRIELA NOLASCO ROJAS', '20', ''),
(67, '2021-06-18', 1, 76, 9, 1, 'DNI', '08578720', 'FELIX ARMANDO HUAMAN ANO', '56', ''),
(68, '2021-06-18', 1, 77, 3, 1, 'DNI', '46474432', 'ENRIQUE SIMEON INGAROCA QUISPE', '31', ''),
(69, '2021-06-18', 1, 78, 9, 2, 'DNI', '10396416', 'JUDITH MARLENE VALLE TELLO', '49', ''),
(70, '2021-06-18', 1, 79, 6, 2, 'CE', '11422160', 'ELIZABETH VERDE BENAVIDES', '47', ''),
(71, '2021-06-18', 1, 80, 3, 1, 'DNI', '41049738', 'LUIS DIAZ QUISPE', '39', ''),
(72, '2021-06-18', 1, 81, 8, 2, 'DNI', '74543242', 'ISABEL YADHIRA REYNA ZAPANA', '19', ''),
(73, '2021-06-18', 1, 82, 9, 2, 'DNI', '06784402', 'ROCIO ELIZABETH VALDIVIA MUÑANTE', '47', ''),
(74, '2021-06-18', 1, 84, 6, 1, 'DNI', '41343680', 'LUIS CARHUAZ VILLARREAL', '39', ''),
(75, '2021-06-18', 1, 84, 7, 2, 'DNI', '10385324', 'MADAI YENNY RIVERA CHULLUNCUY', '45', ''),
(76, '2021-06-18', 1, 87, 9, 2, 'DNI', '40129966', 'BERTILA VICTORIA MAJI VEGA', '42', ''),
(77, '2021-06-18', 1, 88, 9, 1, 'DNI', '07319523', 'LUIS MIGUEL MEJIA TERREROS', '54', ''),
(78, '2021-06-18', 1, 89, 8, 1, 'DNI', '07202889', 'MIGUEL ALFONSO ZEVALLOS CHAVEZ', '58', ''),
(79, '2021-06-18', 1, 90, 3, 1, 'DNI', '20543457', 'MAXIMO DE LA CRUZ PAUCAR', '58', ''),
(80, '2021-06-18', 1, 91, 3, 1, 'DNI', '06912579', 'EUGENIO EFRAIN MATOS PASTOR', '56', ''),
(81, '2021-06-18', 1, 92, 6, 1, 'DNI', '00374066', 'CARLOS HUMBERTO GONZALES ORBEGOZO', '55', ''),
(82, '2021-06-18', 1, 65, 3, 1, 'DNI', '76593720', 'FILIAM NATIVIDAD PAREDES MARCELO', '22', ''),
(83, '2021-06-18', 1, 70, 3, 2, 'DNI', '48448415', 'KARIN HAYDEE DÍAZ RIVERA', '29', ''),
(84, '2021-06-18', 1, 85, 3, 2, 'DNI', '40587006', 'ERIKA ROJAS PAMPAS', '40', ''),
(85, '2021-06-18', 1, 95, 3, 2, 'DNI', '41665589', 'ORFELINDA LARA LOZANO', '38', ''),
(86, '2021-06-18', 1, 100, 3, 2, 'DNI', '42044775', 'KARLA MARIZOL ARANDA GUTIERREZ', '38', ''),
(87, '2021-06-18', 1, 69, 6, 2, 'DNI', '09982585', 'LOURDES MAGALI CARRILLO QUIROGA', '47', ''),
(88, '2021-06-18', 1, 101, 3, 2, 'DNI', '41720798', 'JACKELINE MOLY CHAVEZ NUÑEZ', '38', ''),
(89, '2021-06-18', 1, 102, 9, 1, 'CE', '19737222', 'MIGUEL ANGEL PAEZ PAEZ', '37', ''),
(90, '2021-06-18', 1, 21, 6, 2, 'DNI', '06779501', 'RAQUEL FRANCISCA DOLORES AREVALO', '49', ''),
(91, '2021-06-18', 1, 104, 3, 2, 'DNI', '09986281', 'MADANY MARILU TASAYCO CUNYARACHE', '45', ''),
(92, '2021-06-18', 1, 74, 6, 1, 'DNI', '42945628', 'CARLOS ENRIQUE AMADO GUERRERO', '42', ''),
(93, '2021-06-18', 1, 105, 8, 2, 'DNI', '47817367', 'MARICRUZ CHARO MEDRANO ARIAS', '31', ''),
(94, '2021-06-18', 1, 109, 9, 2, 'DNI', '09026173', 'ANA MARIA DIAZ GASPAR', '54', ''),
(95, '2021-06-18', 1, 96, 8, 2, 'DNI', '10289008', 'KATTYA LORENA JARA SALAVERRY', '44', ''),
(96, '2021-06-18', 1, 110, 3, 1, 'DNI', '42825547', 'EDSON ALEXANDER CORDOVA FLORES', '37', ''),
(97, '2021-06-18', 1, 99, 3, 2, 'DNI', '43238311', 'GERALDINE VANESSA CURO SANCHEZ', '35', ''),
(98, '2021-06-18', 1, 99, 2, 2, 'DNI', '06926380', 'CELIA OLIMPIDA SANCHEZ SOTO', '59', ''),
(99, '2021-06-18', 1, 111, 7, 2, 'DNI', '06862275', 'HILDA HORTENCIA GOMEZ CARDENAS', '72', ''),
(100, '2021-06-18', 1, 108, 6, 1, 'DNI', '09971890', 'RAFAEL JUAREZ ESPINOZA', '48', ''),
(101, '2021-06-18', 1, 108, 6, 2, 'DNI', '10740514', 'ULIANA INES BORDA FRANCIA', '43', ''),
(102, '2021-06-18', 1, 64, 9, 1, 'DNI', '07121834', 'CIRIACO VEGA DIESTRA', '63', ''),
(103, '2021-06-18', 1, 116, 3, 2, 'DNI', '09747066', 'SELENE BEATRIZ BALMACEDA MELGAREJO', '49', ''),
(104, '2021-06-21', 1, 117, 9, 1, 'DNI', '16508098', 'SEGUNDO CUSTODIO VILLALOBOS CARMONA', '59', ''),
(105, '2021-06-21', 1, 118, 3, 1, 'DNI', '31939354', 'MIGUEL GABRIEL VILLANUEVA SALINAS', '48', ''),
(106, '2021-06-21', 1, 119, 3, 2, 'DNI', '70800471', 'DANIELLA ANALUCIA FALCON DUFFAUT', '18', ''),
(107, '2021-06-21', 1, 120, 9, 2, 'DNI', '08159035', 'ANGELICA DOMITILA ONCOY SANCHEZ DE CARRERA', '47', ''),
(108, '2021-06-21', 1, 122, 6, 2, 'DNI', '10160336', 'GLORIA MERCEDES ROMAÑA SOLSOL', '45', ''),
(109, '2021-06-21', 1, 123, 9, 2, 'DNI', '29559758', 'PATRICIA VERONICA QUISPE RIVERA', '49', ''),
(110, '2021-06-21', 1, 97, 9, 2, 'DNI', '06934704', 'BERTHA GARCIA MENESES DE CHAVEZ', '67', ''),
(111, '2021-06-21', 1, 125, 6, 2, 'DNI', '41413896', 'ELISABETH VERONICA ROJAS RODRIGUEZ', '38', ''),
(112, '2021-06-21', 1, 113, 9, 2, 'DNI', '42284961', 'LUZMILA BEATRIZ MENDIETA MONTALVO', '36', ''),
(113, '2021-06-21', 1, 114, 3, 2, 'DNI', '45477367', 'SOLINKA VANESSA CAJALEON FRANCISCO', '33', ''),
(114, '2021-06-21', 1, 115, 3, 2, 'DNI', '70910405', 'SUSAN JANELY MENDEZ ALLENDE', '30', ''),
(115, '2021-06-21', 1, 115, 3, 2, 'DNI', '62422197', 'HEIMY LUCERO POMA SALAZAR', '22', ''),
(116, '2021-06-21', 1, 131, 9, 2, 'DNI', '09977909', 'JORGINA MONDRAGON PALOMINO', '55', ''),
(117, '2021-06-21', 1, 131, 3, 2, 'DNI', '43051651', 'FELICITAS ALZAMORA MONDRAGON', '35', ''),
(118, '2021-06-21', 1, 133, 9, 1, 'DNI', '04012887', 'JHON HUARANGA FERRER', '55', ''),
(119, '2021-06-21', 1, 135, 9, 2, 'DNI', '70910405', 'SUSAN JANELY MENDEZ ALLENDE', '30', ''),
(120, '2021-06-21', 1, 127, 3, 2, 'DNI', '46525699', 'ELEAZAR PEREZ ALMONACID', '40', ''),
(121, '2021-06-21', 1, 136, 3, 2, 'DNI', '74031717', 'ANYA CHRISTINE MENDOZA RIOS', '20', ''),
(122, '2021-06-21', 1, 112, 3, 1, 'DNI', '40243091', 'CARLOS ENRIQUE SALAZAR PACHECO', '42', ''),
(123, '2021-06-21', 1, 126, 3, 2, 'DNI', '40666313', 'EULALIA MARGOT PALACIOS LIVIA', '40', ''),
(124, '2021-06-21', 1, 126, 3, 1, 'DNI', '44790322', 'JOSE ALBERTO PALACIOS LIVIA', '33', ''),
(125, '2021-06-21', 1, 137, 9, 1, 'DNI', '09478189', 'ANIBAL AGAPITO LOZANO ROJAS', '55', ''),
(126, '2021-06-21', 1, 138, 12, 2, 'DNI', '09368748', 'ZENOBIA CHAUCA CAMPOS', '50', ''),
(127, '2021-06-21', 1, 139, 3, 2, 'DNI', '45211548', 'MARIA MAGDALENA RUCOBA CAPUENA', '33', ''),
(128, '2021-06-21', 1, 140, 9, 2, 'DNI', '10383564', 'ANA MARIA ROQUE ICHAGAY', '47', ''),
(129, '2021-06-21', 1, 142, 9, 2, 'DNI', '40888216', 'ESPERANZA CASAFRANCA DIAZ', '40', ''),
(130, '2021-06-21', 1, 145, 3, 2, 'DNI', '74215274', 'MAYTE BELEN APOLAYA VEGA', '17', ''),
(131, '2021-06-21', 1, 132, 6, 2, 'DNI', '06945836', 'JANET VILMA CHUMBES ROJAS', '55', ''),
(132, '2021-06-21', 1, 146, 6, 2, 'DNI', '42079664', 'LIZ MIRELLY TELLO VALLES', '37', ''),
(133, '2021-06-21', 1, 147, 3, 1, 'DNI', '45807239', 'ALEX SANDER LLAMOCCA PACHECO', '32', ''),
(134, '2021-06-21', 1, 141, 2, 2, 'DNI', '08218139', 'MARGARITA CAMA CACERES', '55', ''),
(135, '2021-06-21', 1, 136, 3, 2, 'DNI', '71730262', 'IVETTE MIRELLA CRUZ DIAZ', '29', ''),
(136, '2021-06-21', 1, 143, 6, 2, 'DNI', '46362094', 'KATIA VELASQUEZ CASTAÑEDA', '31', ''),
(137, '2021-06-21', 1, 154, 9, 2, 'DNI', '40379111', 'BECKSY ANTONIETA RAMOS SANCHEZ', '41', ''),
(138, '2021-06-21', 1, 155, 6, 2, 'DNI', '43051651', 'FELICITAS ALZAMORA MONDRAGON', '35', ''),
(139, '2021-06-21', 1, 156, 9, 2, 'DNI', '41071992', 'MILAGROS DEL PILAR VIDAL LOPEZ DE JAQUE', '39', ''),
(140, '2021-06-21', 1, 157, 3, 2, 'DNI', '40921954', 'LILIANA VANESA SILVA SAAVEDRA', '40', ''),
(141, '2021-06-21', 1, 149, 6, 2, 'DNI', '43051651', 'FELICITAS ALZAMORA MONDRAGON', '35', ''),
(142, '2021-06-21', 1, 158, 3, 2, 'DNI', '08688784', 'OLGA GIOVANA SANCHEZ SOTELO DE CONTRERAS', '52', ''),
(143, '2021-06-21', 1, 73, 6, 1, 'DNI', '09788137', 'JULIO ALBERTO MAZUELOS CERRON', '50', ''),
(144, '2021-06-21', 1, 151, 2, 2, 'DNI', '10538456', 'DOLORES CACHIQUE CAHUAZA', '62', ''),
(145, '2021-06-21', 1, 159, 8, 2, 'DNI', '09732722', 'AIDA GALARZA GONZALES', '48', ''),
(146, '2021-06-21', 1, 163, 8, 1, 'DNI', '09735014', 'FEDERICO MARCIAL BRICEÑO OJEDA', '51', ''),
(147, '2021-06-21', 1, 164, 8, 2, 'DNI', '09735154', 'ZULLY MARIANELA PAREDES SANCHEZ', '54', ''),
(148, '2021-06-21', 1, 165, 3, 2, 'DNI', '42290266', 'ESTHER JUVINA MINAYA MESTANZA', '37', ''),
(149, '2021-06-21', 1, 162, 9, 2, 'DNI', '10749275', 'LUISA JENNY TRUJILLO MAMANI', '42', ''),
(150, '2021-06-21', 1, 166, 9, 2, 'DNI', '41982854', 'BRITT LESLI NUÑEZ DIAZ', '37', ''),
(151, '2021-06-21', 1, 167, 3, 2, 'DNI', '43334221', 'ROSARIO RAQUEL EPIQUEN APUELA', '37', ''),
(152, '2021-06-21', 1, 168, 8, 1, 'DNI', '75009132', 'GERMAN JUNIOR TORRES CHUZON', '27', ''),
(153, '2021-06-21', 1, 150, 3, 2, 'DNI', '70011509', 'MEDALITH STEPHANNY VELASQUEZ PEREZ', '26', ''),
(154, '2021-06-21', 1, 160, 9, 2, 'DNI', '27725904', 'DALILA TAPIA RUBIO', '48', ''),
(155, '2021-06-21', 1, 170, 3, 1, 'DNI', '73884361', 'DIEGO ALEXANDER PERALES PAZ', '20', ''),
(156, '2021-06-21', 1, 138, 3, 1, 'DNI', '40790484', 'JUAN CARLOS DE LA CRUZ MORALES', '42', ''),
(157, '2021-06-21', 1, 143, 6, 1, 'DNI', '45341862', 'ARTURO ANTONY FERNANDEZ MENDIETA', '32', ''),
(158, '2021-06-21', 1, 172, 6, 1, 'DNI', '74848815', 'TOMY RODIALDO CASTILLEJO RIOS', '25', ''),
(159, '2021-06-21', 1, 172, 9, 2, 'DNI', '46354102', 'TANIA ERICA CASTILLEJO RIOS', '33', ''),
(160, '2021-06-21', 1, 173, 3, 2, 'DNI', '72541348', 'MILAGROS ANGELICA VERGARA PAREDES', '22', ''),
(161, '2021-06-21', 1, 174, 3, 1, 'DNI', '47009564', 'JUNIOR ENRIQUE FERNANDEZ ORTIZ', '29', ''),
(162, '2021-06-21', 1, 175, 3, 2, 'DNI', '00076261', 'LIANA PEREZ GARCIA', '52', ''),
(163, '2021-06-21', 1, 176, 3, 2, 'DNI', '46616998', 'MADELEYNE LEYDY MENDOZA CALLE', '32', ''),
(164, '2021-06-21', 1, 177, 10, 2, 'CE', '002945155', 'ROSMARY GARCÍA AGUIAR', '32', ''),
(165, '2021-06-21', 1, 178, 6, 2, 'DNI', '15730633', 'JESUSA VASQUEZ ESPINOZA', '53', ''),
(166, '2021-06-21', 1, 179, 8, 2, 'DNI', '41568972', 'MABEL EVA HUAMAN CAJAVILCA', '40', ''),
(167, '2021-06-21', 1, 169, 3, 2, 'DNI', '45978680', 'JACKELINE BEATRIZ YAURI CAMPOS', '33', ''),
(168, '2021-06-21', 1, 182, 8, 1, 'DNI', '40637236', 'ANDRES HUAYLLAQUISPE SANTI', '41', ''),
(169, '2021-06-21', 1, 183, 8, 2, 'DNI', '47352693', 'KATHERINE JANETH TEJADA RODRIGUEZ', '29', ''),
(170, '2021-06-27', 1, 184, 3, 2, 'DNI', '44725361', 'MARÍA GABRIELA NÚÑEZ SOTELO', '33', ''),
(171, '2021-06-27', 1, 185, 3, 2, 'DNI', '41911987', 'ROSEMARY QUISPE ROQUE', '35', ''),
(172, '2021-06-27', 1, 181, 10, 2, 'CE', '004272135', 'ANDREINA PEREZ LEON', '22', ''),
(173, '2021-06-27', 1, 187, 9, 1, 'DNI', '70569025', 'VICTOR MANUEL ALFARO ROJAS', '22', ''),
(174, '2021-06-27', 1, 188, 9, 2, 'DNI', '06129607', 'OLGA GRACIELA MONGE MUÑOZ', '54', ''),
(175, '2021-06-27', 1, 184, 3, 2, 'DNI', '41559477', 'VERONICA GIANNINA NUÑEZ SOTELO', '38', ''),
(176, '2021-06-27', 1, 190, 9, 2, 'DNI', '40010571', 'EVELYN SARAH CONTRERAS GARCIA', '42', ''),
(177, '2021-06-27', 1, 191, 9, 2, 'DNI', '09945469', 'MARITZA CHILICAHUA TELLO', '47', ''),
(178, '2021-06-27', 1, 183, 3, 1, 'DNI', '72939850', 'RONALD HUGO TEJADA FERNANDEZ', '26', ''),
(179, '2021-06-27', 1, 146, 9, 2, 'DNI', '42130523', 'IMELDA YOSANINE REYES VEGA', '36', ''),
(180, '2021-06-27', 1, 192, 3, 1, 'DNI', '45786206', 'JOSE ELVER SILVA QUISPE', '36', ''),
(181, '2021-06-27', 1, 193, 3, 2, 'DNI', '06873486', 'SATURNINA TEJEIRA FLORES', '58', ''),
(182, '2021-06-27', 1, 194, 9, 2, 'DNI', '41495348', 'LIDA PAOLA CLAUDIO SALAS', '38', ''),
(183, '2021-06-27', 1, 195, 3, 2, 'DNI', '10386479', 'RUTH SYVELLA QUISPE CRUZ', '43', ''),
(184, '2021-06-27', 1, 197, 3, 2, 'DNI', '42940283', 'NASLY FIORELLA MINA FARFAN', '36', ''),
(185, '2021-06-27', 1, 196, 9, 2, 'DNI', '45503222', 'RAQUEL QUISPE CRISTAN', '33', ''),
(186, '2021-06-27', 1, 189, 3, 2, 'CE', '14658624', 'MARIA DEL ROSARIO PERALTA ROMERO', '43', ''),
(187, '2021-06-27', 1, 198, 3, 1, 'DNI', '47223919', 'RICARDO MESTANZA SANCHEZ', '30', ''),
(189, '2021-06-27', 1, 164, 3, 2, 'DNI', '07756598', 'MARLENE YULIANA SANDOVAL ENCALADA', '48', ''),
(190, '2021-06-27', 1, 199, 8, 1, 'DNI', '08164061', 'JOSE ANTONIO VENTOSILLA JARA', '46', ''),
(191, '2021-06-27', 1, 200, 10, 2, 'DNI', '10057176', 'FLOR DE MARIA ALARCON AVALOS', '43', ''),
(192, '2021-06-27', 1, 201, 3, 2, 'DNI', '77401994', 'DAYANS PAOLA VELARDE HERNANDEZ', '20', ''),
(193, '2021-06-27', 1, 202, 6, 1, 'DNI', '09892009', 'KELVIN JOHAN PALACIOS RICALDI', '47', ''),
(194, '2021-06-27', 1, 177, 9, 2, 'DNI', '42504572', 'LOURDES YSABEL SALCEDO MACEDO', '36', ''),
(195, '2021-06-27', 1, 204, 3, 1, 'DNI', '45632016', 'JUAN ADEMIR CORDOVA URBINA', '32', ''),
(196, '2021-06-27', 1, 59, 8, 2, 'DNI', '48062284', 'SARBIA FERNANDITA TORREJON CASTRO', '27', ''),
(197, '2021-06-27', 1, 205, 9, 2, 'DNI', '09735645', 'MERCEDES FAVIOLA ATOCHE RODRIGUEZ', '51', ''),
(198, '2021-06-28', 1, 206, 9, 2, 'DNI', '48885410', 'ROSA MABEL FHON GUISAZOLA', '39', ''),
(199, '2021-06-28', 1, 207, 9, 2, 'DNI', '48384806', 'MARIA VANEZA CASTRO VILLAFANE', '26', ''),
(200, '2021-06-28', 1, 201, 3, 2, 'DNI', '77344331', 'MARJORYE ARACELY SOTIL HERNANDEZ', '25', ''),
(201, '2021-06-28', 1, 208, 9, 2, 'DNI', '71762385', 'SERGIO ROMULO ALVAREZ MORENO', '22', ''),
(202, '2021-06-28', 1, 209, 6, 2, 'DNI', '10213019', 'SILVIA VERONICA RIVERA VARA', '47', ''),
(203, '2021-06-28', 1, 210, 9, 2, 'DNI', '10862530', 'GINA FLOR RIVERA GALLEGOS', '43', ''),
(204, '2021-07-02', 12, 211, 9, 2, 'CE', '20791523', 'GÉNESIS MARCANO AROCHA', '29', ''),
(205, '2021-07-03', 3, 212, 3, 2, 'DNI', '46499037', 'ANA MARIA CASTAÑEDA QUISPE', '30', ''),
(206, '2021-07-03', 3, 213, 10, 2, 'DNI', '48171897', 'BERTHA CECILIA HERNANDEZ GARCIA', '27', ''),
(207, '2021-07-03', 6, 195, 9, 2, 'DNI', '09020368', 'JESUS INES CRUZ GONZALES DE ROMERO', '77', ''),
(208, '2021-07-03', 6, 214, 9, 2, 'DNI', '47610442', 'KEYLA CLEMENTINA JIMENEZ CHULLES', '30', ''),
(209, '2021-07-03', 6, 215, 9, 1, 'DNI', '09401206', 'LEONIDAS ILARIO CRUZ FUENTES', '56', ''),
(210, '2021-07-03', 10, 216, 3, 2, 'DNI', '46820030', 'ESTHEFANIE EMPERATRIZ CHAVEZ VARGAS', '29', ''),
(211, '2021-07-05', 10, 218, 6, 1, 'DNI', '06843989', 'RHOY DANDY CHIPANA JUAREZ', '56', ''),
(212, '2021-07-05', 10, 219, 3, 2, 'DNI', '73307763', 'MIREYA NICOLE BARRIONUEVO NAVARRO', '19', ''),
(213, '2021-07-06', 12, 220, 1, 1, 'DNI', '09168430', 'AQUINO QUISPE SALINAS', '61', ''),
(214, '2021-07-07', 10, 222, 8, 2, 'DNI', '70840750', 'RAQUEL ROCIO GUERRA CHUMPITAZ', '23', ''),
(215, '2021-07-07', 10, 223, 9, 2, 'DNI', '45296280', 'ANGELICA EULALIA PALOMINO QUISPE', '32', ''),
(216, '2021-07-07', 10, 224, 9, 2, 'DNI', '09983585', 'FELICIA GUTIERREZ SEQUEIROS', '50', ''),
(217, '2021-07-07', 10, 225, 1, 1, 'DNI', '10391408', 'AMBROCIO TEODULO CABEZUDO QUISPE', '75', ''),
(218, '2021-07-07', 10, 226, 6, 1, 'DNI', '02799124', 'VICTOR CIPRIANO SULLON LACHIRA', '54', ''),
(219, '2021-07-09', 12, 227, 3, 1, 'DNI', '46482286', 'JUNIOR ALVARADO HERNANDEZ', '29', ''),
(220, '2021-07-09', 10, 228, 6, 1, 'DNI', '70471576', 'LEONARDO MOLINA BALDEON', '24', ''),
(221, '2021-07-09', 10, 229, 8, 2, 'CE', '11093279', 'YOMAIRA SOTOMAYOR BARRIOS', '49', ''),
(222, '2021-07-09', 10, 230, 3, 1, 'DNI', '47790809', 'CHRISTIAN ANDERSON MIRANDA ANCHELIA', '28', ''),
(223, '2021-07-10', 12, 231, 6, 2, 'DNI', '09467040', 'YOLANDA LOPEZ MORALES', '53', ''),
(224, '2021-07-10', 12, 232, 10, 2, 'DNI', '44069746', 'JESSICA JAZMIN BERROCAL MORENO', '37', ''),
(225, '2021-07-10', 12, 233, 6, 2, 'DNI', '15655331', 'LUCILA MIRALVINA VASQUEZ ESPINOZA', '55', ''),
(226, '2021-07-10', 12, 234, 2, 2, 'DNI', '05230252', 'GLADYS URTEAGA PINEDO', '63', ''),
(227, '2021-07-19', 10, 228, 9, 2, 'DNI', '72907743', 'IRENE ROCIO URIOL FARROÑAY', '30', ''),
(228, '2021-07-19', 10, 235, 3, 1, 'DNI', '47500981', 'ALEXANDER ROBERT CAMONES SOTO', '30', ''),
(229, '2021-07-19', 10, 236, 3, 2, 'DNI', '42733640', 'MIRIAM YESERLY TTICA MAMANI', '37', ''),
(230, '2021-07-19', 10, 237, 9, 2, 'DNI', '43008318', 'BETSY ANDER HUILLCA LENES', '35', ''),
(231, '2021-07-19', 10, 238, 9, 2, 'DNI', '44642328', 'JUSTINA CHIPANA MENDOZA', '37', ''),
(232, '2021-07-19', 12, 239, 3, 2, 'DNI', '45696970', 'REBECA MERCEDES IDIAQUEZ TORRES', '32', ''),
(233, '2021-07-19', 12, 242, 3, 2, 'DNI', '42533126', 'ROSELY MERY ROCHA PALACIOS', '36', ''),
(234, '2021-07-19', 12, 217, 9, 2, 'DNI', '05641011', 'RAQUEL GARCIA OJEDA', '43', ''),
(235, '2021-07-19', 12, 243, 9, 1, 'DNI', '41692567', 'DAVID HUAMANI RAMIREZ', '38', ''),
(236, '2021-07-19', 10, 199, 8, 2, 'DNI', '40276732', 'SUSANA AMELIA VASQUEZ PAREDES', '42', ''),
(237, '2021-07-19', 10, 244, 3, 1, 'DNI', '71860808', 'ANTHONY JUNIOR CHUQUILIN GOMEZ', '21', ''),
(238, '2021-07-19', 10, 245, 3, 2, 'DNI', '09985067', 'MIRIAN ELENA CARDENAS ABARCA', '46', ''),
(239, '2021-07-19', 10, 246, 3, 2, 'DNI', '40208392', 'MAGALI YESISICA LOPEZ LOPEZ', '42', ''),
(240, '2021-07-19', 10, 245, 3, 2, 'DNI', '06948111', 'DORA CARDENAS ABARCA', '57', ''),
(241, '2021-07-19', 10, 247, 9, 2, 'DNI', '45031947', 'KETTY YENIFER LUNA VILLANUEVA', '53', ''),
(242, '2021-07-19', 10, 248, 3, 2, 'DNI', '43251896', 'MILUSKA ALVARADO CUEVA', '39', ''),
(243, '2021-07-20', 12, 249, 3, 2, 'DNI', '41729181', 'FLOR DE MARIA AREVALO HURTADO', '42', ''),
(244, '2021-07-20', 12, 250, 9, 2, 'DNI', '40180188', 'RUTH SUAREZ MELENDEZ', '40', ''),
(245, '2021-07-20', 12, 251, 9, 2, 'DNI', '10065122', 'ROCIO PALOMINO ROSAS', '47', ''),
(246, '2021-07-20', 12, 252, 3, 2, 'DNI', '40422344', 'ANA YSABEL VALDIVIA TUANAMA', '42', ''),
(247, '2021-07-20', 12, 253, 2, 2, 'DNI', '10738083', 'EDITD ERIKA BERNABE HUARHUA', '43', ''),
(248, '2021-07-21', 1, 254, 9, 2, 'DNI', '09337424', 'LICEL AIME TOMAS VILLALBA', '51', ''),
(249, '2021-07-21', 1, 256, 3, 2, 'DNI', '45018938', 'MADONA NOELITA ALVA RITUAY', '34', ''),
(250, '2021-07-21', 1, 257, 3, 2, 'CE', '22486245', 'GENESIS SANCHEZ RAMIREZ', '28', ''),
(251, '2021-07-21', 10, 221, 3, 1, 'DNI', '44669174', 'DANIEL ALEXANDER MAXI ZEVALLOS', '33', ''),
(252, '2021-07-22', 12, 258, 9, 2, 'DNI', '09964008', 'JULY JANET SERRANO CRUZ', '48', ''),
(253, '2021-07-22', 12, 259, 9, 1, 'DNI', '80252552', 'JORGE LUIS PACHON PACHERRES', '44', ''),
(254, '2021-07-22', 12, 260, 3, 1, 'DNI', '70111152', 'EDGAR DANIEL HUAMAN CHAVEZ', '24', ''),
(255, '2021-07-22', 12, 261, 9, 1, 'DNI', '09476181', 'LUIS ANGEL BALTAZAR BARRETO', '54', ''),
(256, '2021-07-22', 10, 258, 6, 2, 'DNI', '47663960', 'JOSSELIN GUTIERREZ PUQUIO', '26', '924868179'),
(257, '2021-07-22', 10, 255, 9, 1, 'DNI', '10383384', 'OSCAR PEREZ DIAZ', '58', '990133678'),
(258, '2021-07-22', 10, 262, 3, 2, 'DNI', '70358638', 'RUTH YESSENIA ROMERO TIRADO', '23', '977792205'),
(259, '2021-07-23', 12, 263, 2, 2, 'DNI', '10749458', 'ROXANA MANRIQUE TAPIA', '44', '967767053'),
(260, '2021-07-24', 10, 264, 9, 1, 'DNI', '10640539', 'MANUEL ALBERTO LUQUE CASTILLO', '52', ''),
(261, '2021-07-24', 10, 265, 6, 2, 'DNI', '47663960', 'JOSSELIN GUTIERREZ PUQUIO', '27', ''),
(262, '2021-07-26', 12, 196, 9, 2, 'DNI', '44582347', 'MERCEDES ESPERANZA CASAS TAYPE', '35', '901270644'),
(263, '2021-07-26', 12, 267, 2, 2, 'DNI', '09152057', 'ROSA AMELIA PADILLA CRUZ', '72', '974420271'),
(264, '2021-07-26', 12, 268, 3, 2, 'DNI', '74541226', 'CARMEN GUADALUPE GOMEZ DOMINGUEZ', '25', '981043036'),
(265, '2021-07-26', 12, 266, 3, 2, 'DNI', '44582347', 'MERCEDES ESPERANZA CASAS TAYPE', '35', '988470218'),
(266, '2021-07-26', 12, 269, 9, 2, 'DNI', '15287885', 'RAQUEL CRISTINA CUBAS LLACSA', '46', '945231000'),
(267, '2021-07-27', 10, 270, 6, 2, 'DNI', '80520790', 'EVA ZAPATA SERNAQUE', '49', ''),
(268, '2021-07-30', 12, 271, 6, 2, 'DNI', '07143603', 'MARIA GAUDENCIA VALDERRAMA BEGAZO', '58', '932927901'),
(269, '2021-07-31', 12, 272, 3, 2, 'DNI', '41866421', 'ROXANA GRACIELA MANDUJANO VICENTE', '39', '921902667'),
(270, '2021-08-02', 12, 273, 8, 1, 'DNI', '70869871', 'FREDY BOHORQUEZ FUERTES', '27', '939348555'),
(271, '2021-08-02', 12, 240, 10, 1, 'DNI', '74638504', 'JOSE ANTONIO REYES VILCABANA', '24', '983116456'),
(272, '2021-08-02', 12, 274, 9, 2, 'DNI', '40620065', 'MARIA LILIANA ROJAS PEÑA DE LANDEO', '41', '985123167'),
(273, '2021-08-02', 12, 275, 9, 2, 'DNI', '41350473', 'ISABEL LUISA NALVARTE HUARANGA', '39', '934995712'),
(274, '2021-08-03', 10, 271, 9, 1, 'DNI', '08382817', 'GREGORIO PAREJA VELAZQUE', '59', ''),
(275, '2021-08-03', 10, 268, 3, 1, 'DNI', '45168237', 'JIMMY MITCHELL GOMEZ DOMINGUEZ', '33', '937148857'),
(276, '2021-08-03', 10, 276, 6, 1, 'DNI', '43363035', 'LESTER HUMBERTO FLORES BELLO', '39', ''),
(277, '2021-08-04', 12, 277, 5, 1, 'DNI', '70707229', 'CHARLY STIVEN BUSTAMANTE SALAZAR', '23', '984714191'),
(278, '2021-08-04', 12, 278, 9, 2, 'DNI', '10404566', 'ESPERANZA NANCY QUISPE BUITRON', '44', '980286256'),
(279, '2021-08-05', 10, 280, 3, 2, 'DNI', '09033017', 'GLADYS CABALLERO POLO DE PACOTAYPE', '54', '948993573'),
(280, '2021-08-05', 10, 281, 3, 1, 'DNI', '43791268', 'JONATHAN GIANCARLO PALOMINO LINO', '37', '974771435'),
(281, '2021-08-06', 12, 282, 9, 1, 'DNI', '09168430', 'AQUINO QUISPE SALINAS', '61', '922358761'),
(282, '2021-08-07', 10, 283, 6, 1, 'DNI', '40837259', 'MILLER LOPEZ USUA', '40', '94725601'),
(283, '2021-08-07', 10, 209, 9, 2, 'DNI', '40721093', 'YOJANA HUERTAS CASTILLO', '41', '989226858'),
(284, '2021-08-09', 12, 284, 3, 1, 'DNI', '44025441', 'ERICK MACARIO GRANADOS ANGELES', '38', '971354645'),
(285, '2021-08-09', 12, 285, 9, 2, 'DNI', '46499403', 'EVELING PAREJA VALDERRAMA', '32', '941582691'),
(286, '2021-08-10', 10, 287, 1, 1, 'DNI', '06907163', 'CELESTINO OCHOA MENDOZA', '74', '976983943'),
(287, '2021-08-12', 10, 288, 9, 1, 'DNI', '47716074', 'ERICK ARMANDO LOLY OSORIO', '28', '957219251'),
(288, '2021-08-12', 10, 289, 3, 1, 'DNI', '44879715', 'LUIS ALBERTO GUEVARA LA TORRE', '33', '949700675'),
(289, '2021-08-13', 12, 292, 3, 2, 'DNI', '76567490', 'SAYURI ABIGAIL SANCHEZ MARTINEZ', '23', '924270941'),
(290, '2021-08-14', 10, 290, 2, 2, 'DNI', '06768884', 'AGRIPINA JUANA BARZOLA ZURITA', '76', '900256739'),
(291, '2021-08-14', 10, 291, 6, 2, 'DNI', '44608383', 'AMELITA LORENA FLORES NUÑEZ', '45', '940611339'),
(292, '2021-08-14', 10, 293, 3, 2, 'DNI', '76346052', 'KARIN JASMIN GOICOCHEA CUEVA', '20', '955090880'),
(293, '2021-08-16', 12, 291, 8, 2, 'DNI', '75630393', 'GINA MILUSCA MIRANDA HERNANDEZ', '26', '997703810'),
(294, '2021-08-16', 12, 294, 3, 2, 'DNI', '09385562', 'ANITA CHILCON PAISIG', '51', '969048506'),
(295, '2021-08-16', 12, 295, 9, 2, 'DNI', '48151055', 'MADALEY DIANA ALEJO CRUZ', '28', '935257311'),
(296, '2021-08-16', 12, 296, 9, 2, 'DNI', '10395570', 'MILAGROS ROSARIO MARTINEZ ESTRADA', '48', '930469682'),
(297, '2021-08-21', 10, 292, 3, 1, 'SD', '47212717', 'RICHARD AMILTON CHUQUIPOMA SANCHEZ', '38', '924270941'),
(298, '2021-08-23', 12, 297, 9, 1, 'DNI', '48495873', 'JEAN PAUL CONTRERAS CABREJOS', '27', '980503617'),
(299, '2021-08-23', 12, 298, 9, 2, 'DNI', '43154014', 'JANETH SAYURI COTRINA VICENTE', '40', '923017770'),
(300, '2021-08-24', 10, 299, 3, 2, 'DNI', '75010742', 'HAYDEE LIZETT INOCENTE AQUINO', '19', '921851704'),
(301, '2021-08-26', 10, 286, 9, 2, 'DNI', '06864758', 'LORGIO MANUEL CASTILLO PAZ', '68', '956171432'),
(302, '2021-08-26', 10, 301, 9, 1, 'DNI', '80185046', 'ADRIAN OSCAR GUTIERREZ MEZA', '46', '986931849'),
(303, '2021-08-26', 10, 302, 6, 1, 'DNI', '06233187', 'MIGUEL ANGEL GONZALES CHAMORRO', '66', '964292890'),
(304, '2021-08-28', 10, 304, 2, 1, 'DNI', '10404248', 'ANGELA TRIVIÑO AGURTO', '69', '950272291'),
(305, '2021-08-28', 10, 303, 3, 2, 'DNI', '77335898', 'JENIFER CARMINA MEZA MERCADO', '25', '973967154'),
(306, '2021-09-03', 12, 305, 6, 2, 'DNI', '42907085', 'KATERIN PEREZ AGUILAR', '36', ''),
(307, '2021-09-03', 12, 306, 2, 2, 'DNI', '09982442', 'ROSA RAQUEL ACHATA COLONIA', '46', '959349957'),
(308, '2021-09-03', 12, 307, 6, 1, 'DNI', '46234559', 'ELVIS FABIAN TERRONES ESCOBAR', '31', ''),
(309, '2021-09-04', 10, 308, 3, 2, 'DNI', '07647144', 'MARIANELA ESTELA VALDERRAMA TELLO', '45', '993847183'),
(310, '2021-09-04', 10, 305, 9, 2, 'DNI', '43953144', 'YORSI CRISTINA PAUYAC GAVILAN', '0', '910472993'),
(311, '2021-09-04', 10, 305, 3, 2, 'DNI', '73162705', 'VALERIA PEREZ PAUYAC', '12', '934139483'),
(312, '2021-09-06', 12, 311, 10, 2, 'DNI', '47133474', 'ZAIDA SUSANA PAZ PEÑA', '32', '923793056'),
(313, '2021-09-07', 10, 313, 9, 2, 'CE', '19985526', 'EMMI HINOJOZA TAVORDA', '30', '972026692'),
(314, '2021-09-07', 10, 300, 8, 1, 'DNI', '45231420', 'ALEXANDER ISRAEL GRIMANI CASTILLO', '33', '989693397'),
(315, '2021-09-09', 10, 306, 9, 1, 'DNI', '46090821', 'FRANZ JHONATAN PAYTAN ESTRELLA', '32', '914526027'),
(316, '2021-09-09', 10, 308, 3, 2, 'DNI', '10068094', 'ROXANA JANET VALDERRAMA TELLO', '48', '93847183'),
(317, '2021-09-10', 12, 314, 6, 2, 'DNI', '72798865', 'ANAYELLY SOFIA ANGELES YUPAN', '21', '970425325'),
(318, '2021-09-11', 10, 314, 6, 2, 'DNI', '42166187', 'MARIBEL SUSANA ANGELES YUPAN', '37', '970425325'),
(319, '2021-09-12', 10, 205, 3, 1, 'DNI', '71402291', 'JUNIOR FRANCISCO YUPANQUI ATOCHE', '30', '951678573'),
(320, '2021-09-12', 10, 309, 3, 2, 'DNI', '40355148', 'SUSANA YANETH PADILLA VARA', '43', '920135626'),
(321, '2021-09-14', 10, 318, 3, 1, 'DNI', '07876865', 'LUIS ALBERTO SOLANO SUAREZ', '49', '997034945'),
(322, '2021-09-15', 12, 321, 6, 2, 'DNI', '09733646', 'ANA MARIA VASQUEZ TAYCA', '62', '994360825'),
(323, '2021-09-15', 12, 319, 9, 2, 'DNI', '44879986', 'SARITA MANUELA GARCIA NOLI', '33', '918559861'),
(324, '2021-09-18', 10, 307, 6, 2, 'DNI', '48881985', 'HELEN TERRONES ESCOBAR', '25', '970354523'),
(325, '2021-09-21', 10, 323, 6, 2, 'DNI', '10613468', 'AIME CRISTINA ROBLES LAGOS', '41', '940944022'),
(326, '2021-09-21', 10, 324, 3, 1, 'DNI', '44197851', 'ALEX PEDRO CUETO RONCALLO', '34', '986925803'),
(327, '2021-09-22', 12, 325, 6, 2, 'DNI', '10214047', 'ELIZABETH PAZ QUISPE', '47', '983587766'),
(328, '2021-09-22', 12, 325, 6, 2, 'DNI', '10214047', 'ELIZABETH PAZ QUISPE', '47', '983587766'),
(329, '2021-09-22', 12, 326, 3, 2, 'DNI', '41428852', 'KELLY VANESA QUIÑONES HURTADO', '40', '902893589'),
(330, '2021-09-22', 12, 326, 3, 2, 'DNI', '41428852', 'KELLY VANESA QUIÑONES HURTADO', '40', '902893589'),
(331, '2021-09-23', 10, 327, 6, 2, 'DNI', '42166187', 'MARIBEL SUSANA ANGELES YUPAN', '37', '964056870'),
(332, '2021-09-23', 10, 326, 3, 2, 'DNI', '41217663', 'JUDITH JAQUELINE QUIÑONES HURTADO', '40', '961813017'),
(333, '2021-09-23', 10, 323, 6, 1, 'DNI', '43889691', 'TONY MIGUEL ROBLES LAGOS', '35', '950113377'),
(334, '2021-09-24', 12, 328, 3, 2, 'DNI', '42873675', 'CARMEN ROSA MIRANDA ACERO', '36', '960660791'),
(335, '2021-09-25', 10, 329, 6, 1, 'DNI', '23558660', 'BLADEMIR BAUTISTA QUISPE', '45', '921845180'),
(336, '2021-09-27', 12, 330, 9, 2, 'DNI', '40961226', 'LIDIA SOLEDAD SEDANO RIVERA', '40', '960631988'),
(337, '2021-09-29', 12, 330, 3, 2, 'DNI', '44486491', 'JENNY ELIZABETH AJAHUANA CHAMBILLA', '35', '969976451'),
(338, '2021-10-01', 12, 331, 2, 2, 'DNI', '10749585', 'MELVA PUENTE HUARANGA', '46', '986444374'),
(339, '2021-10-05', 10, 332, 3, 1, 'DNI', '77525704', 'DIEGO ALBERTO MUÑOZ ARONI', '24', '954208344'),
(340, '2021-10-09', 10, 333, 9, 1, 'DNI', '10522131', 'FERNANDO MANUEL SEMINARIO MELENDEZ', '55', '967970336'),
(341, '2021-10-11', 12, 334, 6, 2, 'DNI', '09975008', 'ROCIO ARCE CRUZ ', '47', '977439097'),
(342, '2021-10-11', 12, 335, 6, 2, 'DNI', '77159777', 'ROSA HERRERA MARGARIN', '23', '969754899'),
(343, '2021-10-15', 12, 337, 3, 1, 'DNI', '43526522', 'ELIAS AGUIRRE GONZALES', '35', '985182753'),
(344, '2021-10-15', 12, 326, 3, 2, 'DNI', '70010981', 'JESSENIA RUBY QUIÑONES MOLINA', '27', '902893589'),
(345, '2021-10-16', 10, 336, 9, 1, 'DNI', '41850752', 'RICHARD FREDY POMA ROQUE', '52', '972087645'),
(346, '2021-10-19', 10, 336, 9, 1, 'DNI', '42530673', 'JUAN RUBEN PAREDES REYES', '37', ''),
(347, '2021-10-21', 10, 338, 6, 2, 'DNI', '09963718', 'GLADIS MARLENI HURTADO PINEDO', '58', '901189381'),
(348, '2021-10-21', 10, 339, 2, 2, 'DNI', '09474930', 'MARIA FELIPE CABALLERO', '53', '943553903'),
(349, '2021-10-25', 12, 341, 6, 2, 'DNI', '04070502', 'CARMEN ROSA NOLASCO RAMIREZ', '46', '923520226'),
(350, '2021-10-25', 12, 342, 9, 1, 'DNI', '43876001', 'MILNER CHIRINOS HURTADO', '36', '997128605'),
(351, '2021-10-27', 12, 340, 3, 2, 'DNI', '10390522', 'KARIN GIOVANNA FLORES GIL', '45', '940083612'),
(352, '2021-11-05', 10, 343, 6, 1, 'DNI', '80647457', 'ELVIS CARRANZA ROJAS', '43', '993642905'),
(353, '2021-11-05', 10, 346, 2, 2, 'DNI', '14154667', 'YOSSELIN PALMA RAMIREZ', '42', '929695647'),
(354, '2021-11-05', 10, 345, 6, 1, 'DNI', '42149185', 'JAVIER BERNARDO APARICIO VASQUEZ', '32', '927619941'),
(355, '2021-11-05', 10, 345, 6, 2, 'DNI', '45715376', 'EVELIN VICENTA MEZA ROMERO', '32', '927619941'),
(356, '2021-11-06', 12, 349, 3, 2, 'DNI', '06950727', 'AIDA LUZ ESPINOZA ESPINOZA', '58', '977715515'),
(357, '2021-11-06', 12, 344, 8, 2, 'DNI', '41650305', 'ERIKA ESTELITA FIERRO DIONISIO', '40', '948938677'),
(358, '2021-11-06', 10, 351, 6, 1, 'DNI', '43526522', 'ELIAS AGUIRRE GONZALES', '35', '985182753'),
(359, '2021-11-09', 10, 352, 3, 2, 'DNI', '72615517', 'KELY NATIVIDAD YACHACHIN CRUZ', '27', '916565559'),
(360, '2021-11-11', 10, 351, 9, 2, 'DNI', '70396128', 'ANGIE STEPHANY FLORES ARROYO', '26', '929914776'),
(361, '2021-11-12', 12, 353, 9, 2, 'DNI', '21852073', 'EMMA WOLDI TORRES TORRES', '52', '940285684'),
(362, '2021-11-12', 12, 354, 3, 2, 'DNI', '44360407', 'JANETH ISABEL AREVALO ALVARADO', '34', '926722363'),
(363, '2021-11-15', 12, 335, 6, 1, 'DNI', '45458016', 'HAMILTON HERRERA MARGARIN', '33', '941685855'),
(364, '2021-11-16', 10, 355, 3, 1, 'DNI', '48514945', 'JEAN PIERRE ROGER GUTIERREZ ANGULO', '28', '951639301'),
(365, '2021-11-16', 10, 358, 9, 2, 'DNI', '48503447', 'SILVIA LILIANA ROBINET PINEDA', '58', '982200382'),
(366, '2021-11-18', 10, 359, 3, 2, 'DNI', '72615087', 'ASHLY TAMARA ARMAS VALDEZ', '20', '978634662'),
(367, '2021-11-18', 10, 360, 6, 1, 'DNI', '10489392', 'ROLANDO JESUS PANANA GARCIA', '45', '910763910'),
(368, '2021-11-18', 10, 357, 8, 2, 'DNI', '75456089', 'JENNIFER RUBI DAVILA VASQUEZ', '24', '993125462'),
(369, '2021-11-19', 12, 362, 3, 1, 'DNI', '76170309', 'ISMAEL ABRAHAN TRINIDAD LAGOS', '22', '923104823'),
(370, '2021-11-23', 10, 365, 8, 1, 'DNI', '10745217', 'PERCY HAMILTON OSCCORIMA GALINDO', '43', '949055591'),
(371, '2021-11-23', 10, 366, 9, 2, 'DNI', '06283912', 'SUSANA NORMA AGUILAR ACOSTA', '54', '993415573'),
(372, '2021-11-26', 12, 363, 6, 2, 'DNI', '22269771', 'PEDRO JESUS HUAMANI PECEROS', '50', '955977928'),
(373, '2021-11-26', 12, 368, 6, 2, 'DNI', '09820584', 'LENITH DIAZ PANDURO', '49', '978480743'),
(374, '2021-11-29', 12, 370, 9, 1, 'DNI', '09792183', 'MAURO GIL TICONA', '49', '954167547'),
(375, '2021-11-29', 12, 371, 10, 2, 'DNI', '40119466', 'JENNY YSABEL PAQUIRACHI MONDRAGON', '42', '983856917'),
(376, '2021-11-29', 12, 367, 3, 1, 'DNI', '44263890', 'RUBEN JOHN VARGAS BLAS', '34', '926901135'),
(377, '2021-11-30', 10, 372, 6, 1, 'DNI', '41529738', 'JUAN RAUL ACERO CHUCHON', '39', '997746810'),
(378, '2021-11-30', 10, 373, 2, 2, 'DNI', '40243774', 'MARIA DE LOS ANGELES COCHACHIN MENDOZA', '42', '960280253'),
(379, '2021-11-30', 10, 374, 6, 2, 'DNI', '09472382', 'SONIA LUZ BRAVO SALVADOR', '53', '972055334'),
(380, '2021-11-30', 10, 375, 3, 2, 'DNI', '40555585', 'SANDRA KARINA RUIZ SERRANO DE BACA', '41', '988824850'),
(381, '2021-12-02', 10, 377, 3, 2, 'DNI', '77036440', 'PERLA SOLANGE SALAZAR CERRATE', '26', '956774108'),
(382, '2021-12-03', 12, 376, 3, 2, 'DNI', '76493226', 'SHARON NAOMI COCHA BALTODANO', '19', '934719496'),
(383, '2021-12-03', 12, 380, 3, 2, 'DNI', '44331851', 'FLOR ESPERANZA PARIACHE CHUJUTALLI', '38', '936538241'),
(384, '2021-12-06', 12, 379, 10, 2, 'DNI', '74711231', 'MILENA ELIZABETH QUEZADA VARGAS', '23', '962656193'),
(385, '2021-12-06', 12, 381, 3, 2, 'DNI', '08637258', 'NELLY MARCELINA YACHACHIN VICUÑA', '59', '963075020'),
(386, '2021-12-09', 10, 382, 3, 1, 'DNI', '10392110', 'EDUARDO ERNESTO RODRIGUEZ ALVARADO', '46', ''),
(387, '2021-12-11', 10, 384, 3, 2, 'DNI', '76115371', 'JACKELINE GRACIELA MEGO SALINAS', '20', '961697466'),
(388, '2021-12-11', 10, 386, 3, 1, 'DNI', '41529738', 'JUAN RAUL ACERO CHUCHON', '39', '997746810'),
(389, '2021-12-14', 10, 388, 8, 2, 'DNI', '42968981', 'RUTH JAQUELIN ORIA SANTOS', '36', '977669964'),
(390, '2021-12-16', 10, 387, 6, 1, 'DNI', '06947869', 'ELIZABETH CHAHUARA SALAS DE PRADA', '44', '959329845'),
(392, '2021-12-21', 10, 388, 9, 2, 'DNI', '10400990', 'LIDA MAURA SANTOS CAMPOS', '71', '922913084'),
(393, '2021-12-23', 10, 392, 3, 2, 'DNI', '44433617', 'FANNY ISABEL COVEÑAS CANGO', '34', ''),
(394, '2021-12-23', 10, 351, 1, 1, 'DNI', '25504420', 'DAMIAN AGUIRRE MULLISACA', '69', '985182753'),
(395, '2021-12-23', 10, 393, 9, 2, 'DNI', '40281047', 'VIVIANA CASAS PORRAS', '42', '996721704'),
(396, '2021-12-27', 12, 394, 6, 2, 'DNI', '10379390', 'ELSA MAGALLANES PILLACA', '52', '994111857'),
(397, '2021-12-28', 10, 397, 3, 2, 'DNI', '41213875', 'ALICE NATALIE BERRU MENDOZA DE LEYVA', '39', '959550824'),
(398, '2021-12-28', 10, 396, 3, 1, 'DNI', '41537584', 'ALEXANDER EDUARDO CANCINO SERIN', '39', '976455130'),
(399, '2021-12-30', 10, 398, 3, 2, 'DNI', '09604909', 'JULIA MARLENE TORPOCO OSCCORIMA', '51', '987540095'),
(400, '2021-12-30', 10, 400, 3, 1, 'DNI', '44854473', 'BENJAMIN NEIRA TOCTO', '355', '962253264'),
(401, '2022-01-04', 10, 404, 9, 2, 'DNI', '45873544', 'CARMEN LEDY CÁRDENAS CARO', '32', ''),
(402, '2022-01-08', 10, 408, 3, 2, 'DNI', '41594274', 'TANIA MARILYN PALMA BOCANEGRA', '39', '930453036'),
(403, '2022-01-13', 10, 410, 5, 2, 'DNI', '41287249', 'ROXANA MAGDALENA ISIDRO ESPEJO', '39', '992341795'),
(404, '2022-01-13', 10, 411, 9, 1, 'CE', '004934017', 'REMI MONTESINOS GARCIA', '34', '992693356'),
(405, '2022-01-13', 10, 413, 3, 2, 'DNI', '09033778', 'FERNANDA MACHUCA GALVEZ', '54', '923959428'),
(406, '2022-01-15', 10, 412, 9, 1, 'DNI', '23377319', 'ROSENDO ARECHE NAVARRO', '60', '919019028'),
(407, '2022-01-15', 10, 415, 9, 1, 'DNI', '41104291', 'EDUARDO ALEXANDER DEXTRE COLONIA', '40', '961271615'),
(408, '2022-01-15', 10, 416, 3, 2, 'DNI', '48578403', 'SANDRA MIRELLA VILLANUEVA CRUZALEGUI', '26', '988948976'),
(409, '2022-01-18', 10, 419, 3, 1, 'DNI', '10747309', 'JHONNY WALTER ZAFRA DE LA CRUZ', '45', '989787436'),
(410, '2022-01-18', 10, 420, 9, 1, 'DNI', '41403287', 'ROBERTO SILES FLORES BENDEZU', '43', '963028138'),
(411, '2022-01-18', 10, 421, 3, 2, 'DNI', '80375556', 'LUCIA SAUCEDO ALVITES', '42', '949754676'),
(412, '2022-01-18', 10, 418, 3, 2, 'DNI', '10157588', 'NANCY MARIA LOPEZ AYRAS', '50', '930933873'),
(413, '2022-01-18', 10, 422, 9, 2, 'DNI', '75781763', 'IVAN BRUCE BILLY MEDRANO NUÑEZ', '26', '981951211'),
(414, '2022-01-20', 10, 423, 3, 2, 'DNI', '41333783', 'ANA MARIA LAGOS CORDOVA', '40', '958990265'),
(415, '2022-01-20', 10, 424, 3, 1, 'DNI', '41462725', 'ALEJANDRO RAUL QUIROZ SAAVEDRA', '39', '933726258'),
(416, '2022-01-20', 10, 426, 3, 2, 'DNI', '70282972', 'GHEMMY ANGHY APOLINARIO ACEVEDO', '28', '993735065'),
(417, '2022-01-20', 10, 427, 3, 2, 'DNI', '75538073', 'JUMMY GIULIANA VELA MATOS', '18', '917278579'),
(418, '2022-01-20', 10, 428, 6, 1, 'DNI', '09481085', 'JUAN VICTOR CACSIRE DAVALOS', '53', '016488932'),
(419, '2022-01-20', 10, 430, 3, 1, 'DNI', '71324340', 'FELIX JOEL ABREGU GONZALES', '26', '992525019'),
(420, '2022-01-20', 10, 432, 9, 2, 'DNI', '80280743', 'RUTH GIOVANNA RAMIREZ FLORES', '45', '942848136'),
(421, '2022-01-20', 10, 433, 3, 2, 'DNI', '41062566', 'HILDA OXOLON VELAYARCE', '42', '913967743'),
(422, '2022-01-21', 12, 415, 2, 2, 'DNI', '08030119', 'ROSA MARRUJO CARBAJAL ', '58', '986676605'),
(423, '2022-01-22', 10, 437, 3, 1, 'DNI', '41048422', 'RICHARD FRANK OSORIO RIOS', '40', '964231293'),
(424, '2022-01-22', 10, 438, 3, 2, 'DNI', '09551333', 'HERMENEGILDA TRUCIOS FERRUA', '49', '919024904'),
(425, '2022-01-22', 10, 440, 3, 2, 'DNI', '42850768', 'ANA LUISA MORENO AGUILAR', '37', '991333416'),
(426, '2022-01-22', 10, 441, 3, 2, 'DNI', '42039155', 'ELSA ROXANA RAMOS GARCIA', '38', '922199710'),
(427, '2022-01-22', 10, 434, 3, 2, 'DNI', '47134972', 'DAYSI IVONNE QUEZADA ALARCON', '30', '924881662'),
(428, '2022-01-22', 10, 442, 9, 2, 'DNI', '06208348', 'IRMA RUBELA SUAZO RIVERA', '66', '966616894'),
(429, '2022-01-24', 12, 445, 3, 2, 'DNI', '10694026', 'LILIA CUEVA TRUJILLANO', '43', '950612690'),
(430, '2022-01-24', 12, 446, 3, 2, 'DNI', '10694026', 'LILIA CUEVA TRUJILLANO', '43', '950612690'),
(431, '2022-01-24', 12, 449, 3, 1, 'DNI', '42959311', 'YADER MODESTO EGUES GUTIERREZ', '37', '930252315'),
(432, '2022-01-24', 12, 450, 3, 1, 'DNI', '47404777', 'PABLO EDUARDO ALARCON MOYA', '30', '987130707'),
(433, '2022-01-24', 12, 451, 6, 2, 'DNI', '08177966', 'SUSAN ELOYSA LOZADA CISNEROS', '45', '983157519'),
(434, '2022-01-25', 10, 452, 9, 2, 'DNI', '44660715', 'CARMEN ROSA LLERENA DIAZ', '34', '986355885'),
(435, '2022-01-25', 10, 453, 3, 2, 'DNI', '43429905', 'ROXANA LIDIA BARRUETA VELASQUEZ', '35', '977404802'),
(436, '2022-01-25', 10, 454, 3, 2, 'DNI', '09968921', 'ADA PARIONA MADUEÑO', '48', '989846175'),
(437, '2022-01-25', 10, 447, 3, 1, 'DNI', '72754477', 'JONATHAN BILL TADEO CASHPA', '30', '985422606'),
(438, '2022-01-25', 10, 455, 3, 2, 'DNI', '09168073', 'NILDA EUGENIA CACERES AZALDE', '56', '927772735'),
(439, '2022-01-25', 10, 456, 3, 1, 'DNI', '48523961', 'ANDERSON JOSUE MONTOYA TORRES', '26', '984146942'),
(440, '2022-01-25', 10, 443, 9, 2, 'DNI', '09476300', 'SARA RAQUEL JARA MAZA', '52', '928804510'),
(441, '2022-01-27', 10, 458, 3, 2, 'DNI', '09986993', 'YOLANDA LUZ PABLO COSME', '53', '970724222'),
(442, '2022-01-27', 10, 425, 3, 2, 'DNI', '10397949', 'NELLY CRISTINA CAJA QUINTO', '51', '921871140'),
(443, '2022-01-27', 10, 459, 9, 2, 'DNI', '06065194', 'JESUS LLANOS CHAVIL', '68', '991189816'),
(444, '2022-01-27', 10, 460, 3, 2, 'DNI', '41022430', 'HAYDEE VERONICA CORTEZ SALAZAR', '42', '986106773'),
(445, '2022-01-27', 10, 462, 3, 2, 'DNI', '09400993', 'MITXI LUDITH PIPA RAMIREZ', '55', '980163266'),
(446, '2022-01-27', 10, 463, 6, 2, 'DNI', '09478690', 'JENNY ELIZABETH LUJAN ADAN', '52', '015414654'),
(447, '2022-01-27', 10, 464, 3, 2, 'CE', '004690554', 'LILIANA MARCANO SALAZAR', '35', '968399320'),
(448, '2022-01-27', 10, 466, 9, 2, 'DNI', '09566499', 'JOSEFINA LIMA LLANCA', '55', '927025921'),
(449, '2022-01-27', 10, 465, 2, 2, 'DNI', '10680269', 'EDUVIGES GLADYS IGREDA GRIJALVA', '56', '988364748'),
(450, '2022-01-28', 12, 468, 3, 2, 'DNI', '09582811', 'CECILIA LILIANA VARGAS MACHUCA REBATTA', '51', '944051264'),
(451, '2022-01-28', 12, 469, 2, 2, 'DNI', '06924835', 'SONIA DELIA RABANAL TORRES', '57', '968671419'),
(452, '2022-01-28', 12, 470, 3, 2, 'DNI', '45368107', 'VANIA YAHAIDA ROMERO BELLIDO', '33', '967660372'),
(453, '2022-01-29', 10, 471, 3, 2, 'DNI', '76547933', 'KATHERINE JEANETT ANICETO CAMONES', '27', '921882062'),
(454, '2022-01-29', 10, 474, 3, 2, 'DNI', '09403232', 'YOLANDA ELIZABETH PEREZ ATOCHE', '53', '936700016'),
(455, '2022-01-29', 10, 475, 9, 2, 'DNI', '08177832', 'FABIOLA MILAGROS BRAVO SALGUERO', '48', '914789155'),
(456, '2022-01-29', 10, 476, 3, 2, 'DNI', '09991104', 'MARIA ISABEL RODRIGUEZ PALACIOS', '47', '967554464'),
(457, '2022-01-29', 10, 477, 3, 1, 'DNI', '72216778', 'FRANK SALVADOR PRIETO ASTUQUIPAN', '53', '979197465'),
(458, '2022-01-29', 10, 478, 3, 2, 'DNI', '40027270', 'MARIBEL DAVILA CHAVEZ', '43', '934889755'),
(459, '2022-01-29', 10, 479, 6, 1, 'DNI', '09991421', 'SEGUNDO MOISES BORDA RAMOS', '46', '933286557'),
(460, '2022-01-29', 10, 480, 3, 2, 'DNI', '48322012', 'LISSET ALEXANDRA VEGA LEON', '27', '926563207'),
(461, '2022-01-31', 12, 481, 9, 1, 'DNI', '09172261', 'GREGORIO WENCESLAO MEZA CARBAJAL', '65', '978080285'),
(462, '2022-01-31', 12, 480, 3, 2, 'DNI', '48322012', 'LISSET ALEXANDRA VEGA LEON', '27', '926563207'),
(463, '2022-01-31', 10, 483, 9, 2, 'DNI', '42433683', 'CARLA SUHAYL DAVILA LLATAS', '37', '981545676'),
(464, '2022-01-31', 10, 484, 6, 2, 'DNI', '60070557', 'ELIZETH NATIVIDAD GUARDAMINO AGUILAR', '22', '959848101'),
(465, '2022-01-31', 10, 486, 3, 2, 'DNI', '42682686', 'ILIBETH VANESSA TORRES ZARATE', '37', '937242703'),
(466, '2022-02-01', 10, 466, 3, 2, 'DNI', '45049773', 'SARA NOEMI QUISOCALA QUISPE', '33', '928345199'),
(467, '2022-02-01', 10, 487, 3, 2, 'DNI', '09989070', 'RUTH MARIA CALIXTO HERNANDEZ', '45', '991636330'),
(468, '2022-02-01', 10, 488, 9, 1, 'DNI', '09172261', 'GREGORIO WENCESLAO MEZA CARBAJAL', '65', '978080285'),
(469, '2022-02-01', 10, 489, 3, 2, 'DNI', '80280743', 'RUTH GIOVANNA RAMIREZ FLORES', '46', '942848136'),
(470, '2022-02-02', 12, 468, 3, 2, 'DNI', '09246649', 'ANA MELBA VARGAS MACHUCA GONZALES', '65', '977414238'),
(471, '2022-02-02', 12, 491, 3, 2, 'DNI', '46731955', 'MELISSA MARIBEL QUIROZ REYNALTE', '31', '937033144'),
(472, '2022-02-02', 12, 432, 8, 2, 'DNI', '80280743', 'RUTH GIOVANNA RAMIREZ FLORES', '45', '942848136'),
(473, '2022-02-03', 10, 493, 3, 2, 'DNI', '40867194', 'GEORGINA AGUERO POLIN', '42', '926605442'),
(475, '2022-02-03', 10, 494, 3, 2, 'DNI', '10535196', 'LOURDES ROSMERY GONZALES IBAÑEZ', '46', '997839758'),
(476, '2022-02-03', 10, 484, 3, 2, 'DNI', '70358534', 'NOEMI NATHALY CABEZAS MENDOZA', '24', '901053698'),
(477, '2022-02-04', 12, 495, 3, 2, 'DNI', '08862197', 'JULIA CARMEN OLAZABAL ESPINOZA DE MEDINA', '60', '991943860'),
(478, '2022-02-04', 12, 482, 9, 2, 'DNI', '09029828', 'BENITA GUISADO CARDENAS', '65', '922009540'),
(479, '2022-02-06', 10, 496, 3, 2, 'DNI', '40502333', 'DELICIA ROXANA RUIZ REYES', '41', '912381345'),
(480, '2022-02-07', 12, 448, 9, 1, 'DNI', '09047798', 'JAVIER FERNANDO RUIZ ARNAO', '54', '972983802'),
(481, '2022-02-07', 12, 497, 3, 2, 'DNI', '25792322', 'ERIKA ELIZABETH SEGERSBOL SANCHEZ', '46', '984471981'),
(482, '2022-02-09', 12, 498, 6, 2, 'DNI', '09800402', 'YSABEL JOSEFINA MALAGA RAMIREZ', '49', '941556052'),
(483, '2022-02-09', 10, 489, 3, 2, 'DNI', '05256381', 'DELIA IRENE FLORES RIVAS', '65', '942848136'),
(484, '2022-02-10', 10, 499, 3, 2, 'DNI', '80654401', 'VIOLETA ELIANE PERDOMO IPARRAGUIRRE', '40', '986880694'),
(485, '2022-02-11', 12, 500, 3, 1, 'DNI', '47373056', 'CHRISTI CHANEL CAMPOS ESPIRITU', '33', '914205828'),
(486, '2022-02-11', 12, 478, 3, 2, 'DNI', '40027270', 'MARIBEL DAVILA CHAVEZ', '43', '93488755'),
(487, '2022-02-11', 12, 501, 2, 2, 'DNI', '48712511', 'SAIDA CARDENAS HUAMAN', '57', '928122156'),
(488, '2022-02-12', 10, 502, 3, 2, 'DNI', '43059426', 'LINA CORDOVA VARGAS', '36', '943357927'),
(489, '2022-02-15', 10, 503, 3, 2, 'DNI', '09943764', 'PAULINA AQUINO MARCALAYA', '52', '961256082'),
(490, '2022-02-17', 10, 504, 2, 2, 'DNI', '06821736', 'JACQUELINA LUISA CORTEZ LOPEZ', '56', '954580539'),
(491, '2022-02-22', 10, 470, 3, 2, 'DNI', '75318210', 'ALEJANDRA ANDREA LOPEZ BELLIDO', '22', '998528940'),
(492, '2022-02-22', 10, 507, 3, 2, 'DNI', '80495975', 'GRACIELA MERINO VENTURA', '45', '947796595'),
(493, '2022-02-22', 10, 508, 6, 2, 'DNI', '15283588', 'AVISTENCIA ANGELICA SALAZAR OBISPO', '57', '951429053'),
(494, '2022-02-23', 12, 495, 3, 2, 'DNI', '10391646', 'TANIA VIOLETA SALAS ESPINOZA', '44', '945495928'),
(495, '2022-02-23', 12, 503, 3, 2, 'DNI', '06909836', 'AMANDA AQUINO MARCALAYA', '58', '968201830'),
(496, '2022-02-26', 10, 509, 3, 1, 'DNI', '46635756', 'RUBEN CHRISTIAN NEYRA LEYVA', '33', '936015500'),
(497, '2022-03-01', 10, 510, 3, 2, 'DNI', '41940753', 'BEATRIZ LUZMILA LUGO RODRIGUEZ', '38', '987716867'),
(498, '2022-03-01', 10, 505, 6, 2, 'DNI', '43903252', 'YESICA CECILIA COTARMA PISCO', '41', '986497159'),
(499, '2022-03-13', 10, 511, 8, 1, 'DNI', '46406411', 'JOSE MANUEL ASUNCION ENEQUE SONO', '31', '920518930'),
(500, '2022-03-13', 10, 512, 3, 1, 'DNI', '08666069', 'NICANOR ORDOÑEZ GARCIA', '55', '987325442'),
(501, '2022-03-18', 10, 513, 6, 2, 'DNI', '45197253', 'ROSA ELVIA DEL CARMEN TELLO CAFFERATA', '33', '928824142'),
(502, '2022-03-18', 10, 511, 6, 2, 'DNI', '06911491', 'AURELIA ARONE VILCHEZ', '65', '012505310'),
(503, '2022-03-18', 10, 514, 3, 2, 'DNI', '09738846', 'AURORA PILAR BARRENECHEA CURI', '51', '956282515'),
(504, '2022-04-01', 10, 515, 3, 2, 'DNI', '44380762', 'VILMA CALSINA YANAPA', '34', '934899864');

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
(1, '2021-05-14', 1, 1, 10, 2, 2, 1, 0, 'SI', 1, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(2, '2021-05-14', 1, 2, 1, 2, 2, 5, 0, 'SI', 3, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(3, '2021-05-14', 1, 3, 1, 2, 2, 5, 0, 'SI', 4, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(4, '2021-05-14', 1, 3, 10, 2, 2, 1, 0, 'SI', 5, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(5, '2021-05-14', 1, 4, 1, 2, 2, 5, 0, 'SI', 6, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(6, '2021-05-14', 1, 5, 1, 2, 2, 5, 2, 'SI', 7, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(7, '2021-05-14', 1, 6, 1, 2, 2, 5, 0, 'SI', 8, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(8, '2021-05-14', 1, 7, 1, 2, 2, 5, 0, 'SI', 9, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(9, '2021-05-14', 1, 8, 1, 2, 2, 5, 0, 'SI', 10, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(10, '2021-05-14', 1, 9, 10, 2, 2, 4, 0, 'SI', 11, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(11, '2021-05-14', 1, 9, 10, 2, 2, 4, 0, 'SI', 11, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(12, '2021-05-14', 1, 10, 10, 2, 2, 1, 0, 'SI', 12, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(13, '2021-05-14', 1, 11, 10, 2, 2, 2, 0, 'SI', 13, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(14, '2021-05-14', 1, 12, 10, 2, 2, 4, 0, 'SI', 14, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(15, '2021-05-14', 1, 13, 10, 2, 2, 2, 0, 'SI', 15, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(16, '2021-05-14', 1, 14, 10, 2, 2, 4, 0, 'SI', 16, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(17, '2021-05-14', 1, 15, 10, 2, 2, 1, 0, 'SI', 17, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(18, '2021-05-15', 1, 2, 8, 2, 2, 4, 0, 'SI', 3, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(19, '2021-05-15', 1, 5, 8, 2, 2, 4, 0, 'SI', 7, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(20, '2021-05-15', 1, 16, 8, 2, 2, 4, 0, 'SI', 18, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(21, '2021-05-15', 1, 17, 8, 2, 2, 4, 0, 'SI', 19, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(22, '2021-05-15', 1, 18, 8, 2, 2, 4, 0, 'SI', 20, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(23, '2021-05-15', 1, 19, 8, 2, 2, 4, 0, 'SI', 21, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(24, '2021-05-15', 1, 20, 8, 2, 2, 4, 0, 'SI', 22, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(25, '2021-05-15', 1, 21, 8, 2, 2, 4, 0, 'SI', 90, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(26, '2021-05-15', 1, 22, 8, 2, 2, 4, 0, 'SI', 24, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(27, '2021-05-15', 1, 23, 8, 2, 2, 4, 0, 'SI', 25, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(28, '2021-05-15', 1, 24, 8, 2, 2, 4, 0, 'SI', 26, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(29, '2021-05-15', 1, 25, 8, 2, 2, 2, 0, 'SI', 27, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(30, '2021-05-17', 1, 6, 10, 2, 2, 1, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(31, '2021-05-17', 1, 26, 10, 2, 2, 4, 0, 'SI', 28, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(32, '2021-05-17', 1, 27, 10, 2, 2, 1, 0, 'SI', 29, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(33, '2021-05-17', 1, 28, 10, 2, 2, 1, 0, 'SI', 30, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(34, '2021-05-17', 1, 29, 10, 2, 2, 4, 0, 'SI', 31, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(35, '2021-05-17', 1, 30, 10, 2, 2, 4, 0, 'SI', 32, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(36, '2021-05-17', 1, 31, 10, 2, 2, 4, 0, 'SI', 33, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(37, '2021-05-17', 1, 32, 10, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(38, '2021-05-17', 1, 33, 10, 2, 2, 4, 0, 'SI', 35, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(39, '2021-05-17', 1, 34, 10, 2, 2, 1, 0, 'SI', 36, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(40, '2021-05-17', 1, 35, 10, 2, 2, 4, 0, 'SI', 37, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(41, '2021-05-17', 1, 36, 10, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(42, '2021-05-18', 1, 1, 8, 2, 2, 4, 0, 'SI', 2, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(43, '2021-05-18', 1, 9, 8, 2, 2, 4, 0, 'SI', 11, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(44, '2021-05-18', 1, 22, 1, 2, 2, 5, 0, 'SI', 24, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(45, '2021-05-18', 1, 33, 8, 2, 2, 4, 0, 'SI', 35, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(46, '2021-05-18', 1, 34, 1, 2, 2, 5, 0, 'SI', 36, 2, 5, NULL, 1, '2021-06-29 00:54:42'),
(47, '2021-05-18', 1, 35, 1, 2, 2, 5, 0, 'SI', 38, 2, 5, NULL, 1, '2021-06-29 00:54:42'),
(48, '2021-05-18', 1, 36, 8, 2, 2, 4, 0, 'SI', 45, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(49, '2021-05-18', 1, 37, 1, 2, 2, 5, 0, 'SI', 39, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(50, '2021-05-18', 1, 38, 1, 2, 2, 5, 0, 'SI', 40, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(51, '2021-05-18', 1, 39, 1, 2, 2, 5, 0, 'SI', 41, 5, 0, NULL, 1, '2021-06-29 00:54:42'),
(52, '2021-05-18', 1, 39, 8, 2, 2, 4, 0, 'SI', 41, 3, 0, NULL, 1, '2021-06-29 00:54:42'),
(53, '2021-05-18', 1, 40, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(54, '2021-05-18', 1, 41, 8, 2, 2, 4, 0, 'SI', 43, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(55, '2021-05-18', 1, 42, 8, 2, 2, 3, 0, 'SI', 44, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(56, '2021-05-18', 1, 43, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(57, '2021-05-18', 1, 44, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(58, '2021-05-18', 1, 94, 1, 2, 2, 5, 0, 'SI', 42, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(59, '2021-05-18', 1, 94, 8, 2, 2, 4, 0, 'SI', 42, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(60, '2021-05-19', 1, 2, 1, 2, 2, 5, 0, 'SI', 3, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(61, '2021-05-19', 1, 19, 10, 2, 2, 4, 0, 'SI', 21, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(62, '2021-05-19', 1, 24, 1, 2, 2, 5, 0, 'SI', 26, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(63, '2021-05-19', 1, 36, 1, 2, 2, 5, 0, 'SI', 45, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(64, '2021-05-19', 1, 44, 10, 2, 2, 3, 0, 'SI', 53, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(65, '2021-05-19', 1, 45, 9, 4, 2, 2, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(66, '2021-05-19', 1, 46, 9, 4, 2, 5, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(67, '2021-05-19', 1, 47, 9, 4, 2, 3, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(68, '2021-05-19', 1, 48, 1, 2, 2, 5, 0, 'SI', 46, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(69, '2021-05-19', 1, 49, 1, 2, 2, 5, 0, 'SI', 47, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(70, '2021-05-19', 1, 50, 1, 2, 2, 5, 0, 'SI', 48, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(71, '2021-05-19', 1, 51, 10, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(72, '2021-05-19', 1, 52, 10, 2, 2, 1, 0, 'SI', 49, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(73, '2021-05-19', 1, 53, 10, 2, 2, 4, 0, 'SI', 50, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(74, '2021-05-19', 1, 54, 10, 2, 2, 1, 0, 'SI', 51, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(75, '2021-05-19', 1, 55, 10, 2, 2, 1, 0, 'SI', 52, 1, 0, NULL, 1, '2021-06-29 00:54:42'),
(76, '2021-05-21', 1, 9, 10, 2, 2, 4, 10, 'SI', 11, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(77, '2021-05-21', 1, 12, 10, 2, 2, 13, 10, 'SI', 14, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(78, '2021-05-21', 1, 29, 10, 2, 2, 2, 10, 'SI', 31, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(79, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(80, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(81, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(82, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(83, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(84, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(85, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(86, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(87, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(88, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(89, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(90, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(91, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(92, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(93, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(94, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(95, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(96, '2021-05-21', 1, 33, 10, 2, 2, 4, 10, 'SI', 35, 2, 15, NULL, 1, '2021-06-29 00:54:42'),
(97, '2021-05-21', 1, 40, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(98, '2021-05-21', 1, 51, 10, 2, 2, 4, 10, 'SI', 57, 9, 14, NULL, 1, '2021-06-29 00:54:42'),
(99, '2021-05-21', 1, 52, 10, 2, 2, 13, 10, 'SI', 49, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(100, '2021-05-21', 1, 56, 10, 2, 2, 13, 9, 'SI', 54, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(101, '2021-05-21', 1, 57, 10, 2, 2, 4, 9, 'SI', 55, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(102, '2021-05-21', 1, 58, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(103, '2021-05-21', 1, 59, 10, 2, 2, 13, 9, 'SI', 56, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(104, '2021-05-21', 1, 60, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(105, '2021-05-21', 1, 61, 8, 2, 2, 9, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(106, '2021-05-21', 1, 62, 8, 2, 2, 13, 0, 'SI', 58, 9, 0, NULL, 1, '2021-06-29 00:54:42'),
(107, '2021-05-21', 1, 63, 8, 2, 2, 4, 0, 'SI', 59, 9, 0, NULL, 1, '2021-06-29 00:54:42'),
(108, '2021-05-21', 1, 64, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(109, '2021-05-21', 1, 64, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(110, '2021-05-23', 1, 13, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(111, '2021-05-23', 1, 17, 8, 2, 2, 4, 0, 'SI', 19, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(112, '2021-05-23', 1, 57, 8, 2, 2, 4, 0, 'SI', 55, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(113, '2021-05-23', 1, 58, 8, 2, 2, 4, 0, 'SI', 61, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(114, '2021-05-23', 1, 62, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(115, '2021-05-23', 1, 65, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(116, '2021-05-23', 1, 66, 8, 2, 2, 4, 0, 'SI', 60, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(117, '2021-05-23', 1, 67, 8, 2, 2, 4, 0, 'SI', 62, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(118, '2021-05-23', 1, 68, 8, 2, 2, 3, 0, 'SI', 63, 3, 0, NULL, 1, '2021-06-29 00:54:42'),
(119, '2021-05-23', 1, 69, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(120, '2021-05-23', 1, 70, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(121, '2021-05-23', 1, 71, 8, 2, 2, 4, 0, 'SI', 64, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(122, '2021-05-24', 1, 13, 10, 2, 2, 13, 10, 'SI', 15, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(123, '2021-05-24', 1, 27, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(124, '2021-05-24', 1, 30, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(125, '2021-05-24', 1, 51, 10, 2, 2, 4, 11, 'SI', 57, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(126, '2021-05-24', 1, 57, 10, 2, 2, 4, 10, 'SI', 55, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(127, '2021-05-24', 1, 59, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(128, '2021-05-24', 1, 70, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(129, '2021-05-24', 1, 72, 10, 2, 2, 13, 9, 'SI', 65, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(130, '2021-05-24', 1, 73, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(131, '2021-05-24', 1, 74, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(132, '2021-05-24', 1, 75, 1, 2, 2, 5, 0, 'SI', 66, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(133, '2021-05-24', 1, 76, 1, 2, 2, 5, 0, 'SI', 67, 5, 12, NULL, 1, '2021-06-29 00:54:42'),
(134, '2021-05-24', 1, 77, 1, 2, 2, 5, 0, 'SI', 68, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(135, '2021-05-24', 1, 78, 1, 2, 2, 5, 0, 'SI', 69, 13, 5, NULL, 1, '2021-06-29 00:54:42'),
(136, '2021-05-24', 1, 79, 1, 2, 2, 5, 0, 'SI', 70, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(137, '2021-05-24', 1, 80, 1, 2, 2, 5, 0, 'SI', 71, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(138, '2021-05-24', 1, 81, 1, 2, 2, 5, 0, 'SI', 72, 12, 5, NULL, 1, '2021-06-29 00:54:42'),
(139, '2021-05-24', 1, 82, 1, 2, 2, 5, 0, 'SI', 73, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(140, '2021-05-24', 1, 83, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(141, '2021-05-24', 1, 84, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(142, '2021-05-24', 1, 85, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(143, '2021-05-24', 1, 85, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(144, '2021-05-24', 1, 85, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(145, '2021-05-24', 1, 85, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(146, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(147, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(148, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(149, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(150, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(151, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(152, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(153, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(154, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(155, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(156, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(157, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(158, '2021-05-24', 1, 86, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(159, '2021-05-25', 1, 36, 8, 2, 2, 4, 0, 'SI', 45, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(160, '2021-05-25', 1, 44, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(161, '2021-05-25', 1, 65, 8, 2, 2, 13, 0, 'SI', 82, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(162, '2021-05-25', 1, 70, 8, 2, 2, 4, 0, 'SI', 83, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(163, '2021-05-25', 1, 84, 8, 2, 2, 4, 0, 'SI', 74, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(164, '2021-05-25', 1, 87, 8, 2, 2, 4, 0, 'SI', 76, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(165, '2021-05-25', 1, 88, 8, 2, 2, 8, 0, 'SI', 77, 3, 0, NULL, 1, '2021-06-29 00:54:42'),
(166, '2021-05-25', 1, 89, 8, 2, 2, 4, 0, 'SI', 78, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(167, '2021-05-25', 1, 90, 8, 2, 2, 4, 0, 'SI', 79, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(168, '2021-05-25', 1, 91, 8, 2, 2, 13, 0, 'SI', 80, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(169, '2021-05-25', 1, 92, 8, 2, 2, 13, 0, 'SI', 81, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(170, '2021-05-25', 1, 94, 8, 2, 2, 4, 0, 'SI', 42, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(171, '2021-05-26', 1, 29, 10, 2, 2, 2, 11, 'SI', 31, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(172, '2021-05-26', 1, 30, 10, 2, 2, 4, 11, 'SI', 32, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(173, '2021-05-26', 1, 38, 1, 2, 2, 5, 0, 'SI', 40, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(174, '2021-05-26', 1, 49, 1, 2, 2, 5, 0, 'SI', 47, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(175, '2021-05-26', 1, 59, 10, 2, 2, 13, 11, 'SI', 56, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(176, '2021-05-26', 1, 60, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(177, '2021-05-26', 1, 67, 10, 2, 2, 13, 9, 'SI', 62, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(178, '2021-05-26', 1, 72, 10, 2, 2, 13, 10, 'SI', 65, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(179, '2021-05-26', 1, 74, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(180, '2021-05-26', 1, 83, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(181, '2021-05-26', 1, 85, 10, 2, 2, 13, 10, 'SI', 84, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(182, '2021-05-26', 1, 89, 1, 2, 2, 5, 0, 'SI', 78, 5, 2, NULL, 1, '2021-06-29 00:54:42'),
(183, '2021-05-26', 1, 93, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(184, '2021-05-26', 1, 94, 1, 2, 2, 5, 0, 'SI', 42, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(185, '2021-05-26', 1, 95, 1, 2, 2, 5, 0, 'SI', 85, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(186, '2021-05-26', 1, 96, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(187, '2021-05-26', 1, 97, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(188, '2021-05-26', 1, 98, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(189, '2021-05-26', 1, 99, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(190, '2021-05-27', 1, 20, 8, 2, 2, 4, 0, 'SI', 22, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(191, '2021-05-27', 1, 21, 8, 2, 2, 4, 11, 'SI', 90, 2, 10, NULL, 1, '2021-06-29 00:54:42'),
(192, '2021-05-27', 1, 62, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(193, '2021-05-27', 1, 69, 8, 2, 2, 4, 0, 'SI', 87, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(194, '2021-05-27', 1, 74, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(195, '2021-05-27', 1, 84, 8, 2, 2, 4, 0, 'SI', 74, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(196, '2021-05-27', 1, 87, 8, 2, 2, 4, 0, 'SI', 76, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(197, '2021-05-27', 1, 100, 8, 2, 2, 4, 0, 'SI', 86, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(198, '2021-05-27', 1, 101, 8, 2, 2, 4, 0, 'SI', 88, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(199, '2021-05-27', 1, 102, 8, 2, 2, 13, 0, 'SI', 89, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(200, '2021-05-27', 1, 103, 8, 2, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(201, '2021-05-27', 1, 104, 8, 2, 2, 4, 0, 'SI', 91, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(202, '2021-05-28', 1, 17, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(203, '2021-05-28', 1, 64, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(204, '2021-05-28', 1, 67, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(205, '2021-05-28', 1, 72, 10, 2, 2, 13, 11, 'SI', 65, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(206, '2021-05-28', 1, 74, 10, 2, 2, 13, 11, 'SI', 92, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(207, '2021-05-28', 1, 94, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(208, '2021-05-28', 1, 96, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(209, '2021-05-28', 1, 97, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(210, '2021-05-28', 1, 99, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(211, '2021-05-28', 1, 105, 10, 2, 2, 2, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(212, '2021-05-28', 1, 105, 10, 2, 2, 2, 9, 'SI', 93, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(213, '2021-05-28', 1, 106, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(214, '2021-05-28', 1, 107, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(215, '2021-05-28', 1, 108, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(216, '2021-05-28', 1, 109, 10, 2, 2, 4, 9, 'SI', 94, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(217, '2021-05-29', 1, 15, 8, 2, 2, 4, 9, 'SI', 17, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(218, '2021-05-29', 1, 31, 8, 2, 2, 4, 9, 'SI', 33, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(219, '2021-05-29', 1, 69, 8, 2, 2, 4, 9, 'SI', 87, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(220, '2021-05-29', 1, 76, 8, 2, 2, 13, 0, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(221, '2021-05-29', 1, 84, 8, 2, 2, 4, 0, 'SI', 74, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(222, '2021-05-29', 1, 87, 8, 2, 2, 4, 11, 'SI', 76, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(223, '2021-05-29', 1, 96, 8, 2, 2, 4, 9, 'SI', 95, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(224, '2021-05-29', 1, 99, 8, 2, 2, 13, 9, 'SI', 97, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(225, '2021-05-29', 1, 101, 8, 2, 2, 4, 10, 'SI', 88, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(226, '2021-05-29', 1, 110, 8, 2, 2, 4, 9, 'SI', 96, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(227, '2021-05-31', 1, 21, 1, 2, 2, 5, 0, 'SI', 90, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(228, '2021-05-31', 1, 39, 1, 2, 2, 5, 0, 'SI', 41, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(229, '2021-05-31', 1, 59, 1, 2, 2, 5, 0, 'SI', 56, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(230, '2021-05-31', 1, 62, 1, 2, 2, 5, 0, 'SI', 58, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(231, '2021-05-31', 1, 64, 10, 2, 2, 13, 10, 'SI', 102, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(232, '2021-05-31', 1, 73, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(233, '2021-05-31', 1, 76, 10, 2, 2, 4, 9, 'SI', 67, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(234, '2021-05-31', 1, 85, 10, 2, 2, 13, 11, 'SI', 84, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(235, '2021-05-31', 1, 105, 10, 2, 2, 2, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(236, '2021-05-31', 1, 105, 1, 2, 2, 5, 0, 'SI', 93, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(237, '2021-05-31', 1, 107, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(238, '2021-05-31', 1, 108, 10, 2, 2, 4, 10, 'SI', 100, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(239, '2021-05-31', 1, 111, 10, 2, 2, 13, 9, 'SI', 99, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(240, '2021-05-31', 1, 112, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(241, '2021-05-31', 1, 113, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(242, '2021-05-31', 1, 114, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(243, '2021-05-31', 1, 115, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(244, '2021-05-31', 1, 116, 1, 2, 2, 5, 0, 'SI', 103, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(245, '2021-06-01', 1, 26, 8, 2, 2, 13, 10, 'SI', 28, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(246, '2021-06-01', 1, 39, 8, 2, 2, 4, 10, 'SI', 41, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(247, '2021-06-01', 1, 67, 8, 2, 2, 4, 10, 'SI', 62, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(248, '2021-06-01', 1, 97, 8, 2, 2, 4, 9, 'SI', 110, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(249, '2021-06-01', 1, 117, 8, 2, 2, 4, 9, 'SI', 104, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(250, '2021-06-01', 1, 118, 8, 2, 2, 4, 9, 'SI', 105, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(251, '2021-06-01', 1, 119, 8, 2, 2, 13, 9, 'SI', 106, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(252, '2021-06-01', 1, 120, 8, 2, 2, 13, 9, 'SI', 107, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(253, '2021-06-01', 1, 121, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(254, '2021-06-01', 1, 122, 8, 2, 2, 4, 9, 'SI', 108, 12, 9, NULL, 1, '2021-06-29 00:54:42'),
(255, '2021-06-01', 1, 123, 8, 2, 2, 4, 9, 'SI', 109, 4, 9, NULL, 1, '2021-06-29 00:54:42'),
(256, '2021-06-02', 1, 31, 1, 2, 2, 5, 0, 'SI', 33, 13, 5, NULL, 1, '2021-06-29 00:54:42'),
(257, '2021-06-02', 1, 53, 4, 3, 2, 5, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(258, '2021-06-02', 1, 54, 4, 3, 2, 15, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(259, '2021-06-02', 1, 64, 10, 2, 2, 13, 11, 'SI', 102, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(260, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(261, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(262, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(263, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(264, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(265, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(266, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(267, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(268, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(269, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(270, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(271, '2021-06-02', 1, 76, 10, 2, 2, 4, 10, 'SI', 67, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(272, '2021-06-02', 1, 84, 1, 2, 2, 5, 0, 'SI', 75, 5, 2, NULL, 1, '2021-06-29 00:54:42'),
(273, '2021-06-02', 1, 97, 10, 2, 2, 13, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(274, '2021-06-02', 1, 99, 1, 2, 2, 5, 0, 'SI', 98, 5, 2, NULL, 1, '2021-06-29 00:54:42'),
(275, '2021-06-02', 1, 101, 1, 2, 2, 2, 0, 'SI', 88, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(276, '2021-06-02', 1, 105, 10, 2, 2, 2, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(277, '2021-06-02', 1, 106, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(278, '2021-06-02', 1, 111, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(279, '2021-06-02', 1, 113, 10, 2, 2, 13, 10, 'SI', 112, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(280, '2021-06-02', 1, 114, 1, 2, 2, 5, 0, 'SI', 113, 5, 2, NULL, 1, '2021-06-29 00:54:42'),
(281, '2021-06-02', 1, 115, 1, 2, 2, 5, 0, 'SI', 115, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(282, '2021-06-02', 1, 115, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(283, '2021-06-02', 1, 121, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(284, '2021-06-02', 1, 122, 1, 2, 2, 13, 0, 'SI', 108, 12, 2, NULL, 1, '2021-06-29 00:54:42'),
(285, '2021-06-02', 1, 124, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(286, '2021-06-02', 1, 125, 10, 2, 2, 13, 9, 'SI', 111, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(287, '2021-06-02', 1, 126, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(288, '2021-06-02', 1, 127, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(289, '2021-06-02', 1, 129, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(290, '2021-06-02', 1, 129, 4, 3, 2, 4, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(291, '2021-06-02', 1, 130, 4, 3, 2, 6, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(292, '2021-06-02', 1, 131, 10, 2, 2, 13, 9, 'SI', 116, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(293, '2021-06-02', 1, 132, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(294, '2021-06-03', 1, 59, 8, 2, 2, 4, 9, 'SI', 56, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(295, '2021-06-03', 1, 64, 8, 2, 2, 6, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(296, '2021-06-03', 1, 97, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(297, '2021-06-03', 1, 108, 8, 2, 2, 13, 9, 'SI', 101, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(298, '2021-06-03', 1, 114, 8, 2, 2, 8, 0, 'SI', 113, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(299, '2021-06-03', 1, 115, 8, 2, 2, 8, 0, 'SI', 114, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(300, '2021-06-03', 1, 117, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(301, '2021-06-03', 1, 120, 8, 2, 2, 4, 10, 'SI', 107, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(302, '2021-06-03', 1, 121, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(303, '2021-06-03', 1, 122, 8, 2, 2, 4, 10, 'SI', 108, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(304, '2021-06-03', 1, 127, 8, 2, 2, 4, 9, 'SI', 120, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(305, '2021-06-03', 1, 133, 8, 1, 2, 8, 0, 'SI', 118, 12, 14, NULL, 1, '2021-06-29 00:54:42'),
(306, '2021-06-03', 1, 134, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(307, '2021-06-03', 1, 135, 8, 2, 2, 4, 9, 'SI', 119, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(308, '2021-06-04', 1, 2, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(309, '2021-06-04', 1, 3, 4, 3, 2, 15, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(310, '2021-06-04', 1, 5, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(311, '2021-06-04', 1, 7, 4, 3, 2, 1, 15, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(312, '2021-06-04', 1, 9, 1, 2, 2, 5, 0, 'SI', 11, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(313, '2021-06-04', 1, 19, 1, 2, 2, 5, 0, 'SI', 21, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(314, '2021-06-04', 1, 24, 4, 3, 2, 14, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(315, '2021-06-04', 1, 26, 1, 2, 2, 5, 0, 'SI', 28, 12, 2, NULL, 1, '2021-06-29 00:54:42'),
(316, '2021-06-04', 1, 34, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(317, '2021-06-04', 1, 41, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(318, '2021-06-04', 1, 84, 1, 2, 2, 5, 0, 'SI', 74, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(319, '2021-06-04', 1, 85, 1, 2, 2, 5, 0, 'SI', 84, 5, 2, NULL, 1, '2021-06-29 00:54:42'),
(320, '2021-06-04', 1, 111, 10, 2, 2, 13, 11, 'SI', 99, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(321, '2021-06-04', 1, 112, 1, 2, 2, 5, 0, 'SI', 122, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(322, '2021-06-04', 1, 113, 10, 2, 2, 13, 11, 'SI', 112, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(323, '2021-06-04', 1, 119, 10, 2, 2, 13, 9, 'SI', 106, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(324, '2021-06-04', 1, 125, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(325, '2021-06-04', 1, 126, 10, 2, 2, 13, 10, 'SI', 123, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(326, '2021-06-04', 1, 136, 1, 2, 2, 5, 0, 'SI', 121, 2, 5, NULL, 1, '2021-06-29 00:54:42'),
(327, '2021-06-04', 1, 137, 10, 2, 2, 4, 9, 'SI', 125, 13, 9, NULL, 1, '2021-06-29 00:54:42'),
(328, '2021-06-04', 1, 138, 10, 2, 2, 4, 9, 'SI', 126, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(329, '2021-06-04', 1, 139, 10, 2, 2, 4, 9, 'SI', 127, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(330, '2021-06-04', 1, 140, 10, 2, 2, 2, 9, 'SI', 128, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(331, '2021-06-04', 1, 141, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(332, '2021-06-04', 1, 142, 10, 2, 2, 13, 9, 'SI', 129, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(333, '2021-06-05', 1, 9, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(334, '2021-06-05', 1, 17, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(335, '2021-06-05', 1, 21, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(336, '2021-06-05', 1, 26, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(337, '2021-06-05', 1, 39, 8, 2, 2, 2, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(338, '2021-06-05', 1, 87, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(339, '2021-06-05', 1, 99, 8, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(340, '2021-06-05', 1, 101, 8, 2, 2, 4, 9, 'SI', 88, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(341, '2021-06-05', 1, 122, 8, 2, 2, 4, 11, 'SI', 108, 12, 17, NULL, 1, '2021-06-29 00:54:42'),
(342, '2021-06-05', 1, 132, 8, 2, 2, 4, 9, 'SI', 131, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(343, '2021-06-05', 1, 136, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(344, '2021-06-05', 1, 137, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(345, '2021-06-05', 1, 143, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(346, '2021-06-05', 1, 144, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(347, '2021-06-05', 1, 145, 8, 2, 2, 4, 9, 'SI', 130, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(348, '2021-06-05', 1, 146, 8, 2, 2, 4, 9, 'SI', 132, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(349, '2021-06-05', 1, 147, 8, 2, 2, 4, 9, 'SI', 133, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(350, '2021-06-07', 1, 73, 10, 2, 2, 13, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(351, '2021-06-07', 1, 76, 10, 2, 2, 4, 11, 'SI', 67, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(352, '2021-06-07', 1, 106, 10, 2, 2, 13, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(353, '2021-06-07', 1, 119, 10, 2, 2, 13, 10, 'SI', 106, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(354, '2021-06-07', 1, 131, 10, 2, 2, 13, 10, 'SI', 116, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(355, '2021-06-07', 1, 138, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(356, '2021-06-07', 1, 139, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(357, '2021-06-07', 1, 140, 10, 2, 2, 2, 10, 'SI', 128, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(358, '2021-06-07', 1, 141, 10, 2, 2, 13, 10, 'SI', 134, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(359, '2021-06-07', 1, 142, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(360, '2021-06-07', 1, 148, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(361, '2021-06-07', 1, 149, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(362, '2021-06-07', 1, 150, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(363, '2021-06-07', 1, 151, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(364, '2021-06-08', 1, 27, 8, 2, 2, 13, 0, 'SI', 29, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(365, '2021-06-08', 1, 28, 4, 3, 2, 14, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(366, '2021-06-08', 1, 42, 4, 3, 2, 14, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(367, '2021-06-08', 1, 43, 4, 3, 2, 14, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(368, '2021-06-08', 1, 55, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(369, '2021-06-08', 1, 119, 8, 2, 2, 4, 10, 'SI', 106, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(370, '2021-06-08', 1, 135, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(371, '2021-06-08', 1, 136, 8, 2, 2, 4, 9, 'SI', 121, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(372, '2021-06-08', 1, 141, 8, 2, 2, 4, 9, 'SI', 134, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(373, '2021-06-08', 1, 143, 8, 2, 2, 4, 9, 'SI', 136, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(374, '2021-06-08', 1, 149, 8, 2, 2, 4, 0, 'SI', 141, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(375, '2021-06-08', 1, 152, 4, 2, 2, 4, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(376, '2021-06-08', 1, 153, 4, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(377, '2021-06-08', 1, 154, 8, 2, 2, 3, 9, 'SI', 137, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(378, '2021-06-08', 1, 155, 8, 2, 2, 4, 9, 'SI', 138, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(379, '2021-06-08', 1, 156, 8, 2, 2, 12, 9, 'SI', 139, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(380, '2021-06-08', 1, 157, 8, 2, 2, 4, 9, 'SI', 140, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(381, '2021-06-08', 1, 158, 8, 2, 2, 4, 9, 'SI', 142, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(382, '2021-06-09', 1, 27, 1, 2, 2, 5, 0, 'SI', 29, 5, 13, NULL, 1, '2021-06-29 00:54:42'),
(383, '2021-06-09', 1, 58, 1, 2, 2, 5, 0, 'SI', 61, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(384, '2021-06-09', 1, 73, 1, 2, 2, 5, 0, 'SI', 143, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(385, '2021-06-09', 1, 126, 10, 2, 2, 13, 11, 'SI', 123, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(386, '2021-06-09', 1, 131, 1, 2, 2, 5, 0, 'SI', 117, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(387, '2021-06-09', 1, 137, 10, 2, 2, 4, 10, 'SI', 125, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(388, '2021-06-09', 1, 138, 10, 2, 2, 4, 11, 'SI', 126, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(389, '2021-06-09', 1, 139, 10, 2, 2, 4, 11, 'SI', 127, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(390, '2021-06-09', 1, 140, 10, 2, 2, 2, 11, 'SI', 128, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(391, '2021-06-09', 1, 142, 1, 2, 2, 5, 0, 'SI', 129, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(392, '2021-06-09', 1, 142, 10, 2, 2, 13, 11, 'SI', 129, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(393, '2021-06-09', 1, 151, 10, 2, 2, 13, 10, 'SI', 144, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(394, '2021-06-09', 1, 157, 1, 2, 2, 5, 0, 'SI', 140, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(395, '2021-06-09', 1, 159, 10, 2, 2, 2, 9, 'SI', 145, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(396, '2021-06-09', 1, 160, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(397, '2021-06-10', 1, 19, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(398, '2021-06-10', 1, 19, 8, 2, 2, 13, 10, 'SI', 21, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(399, '2021-06-10', 1, 33, 4, 3, 2, 15, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(400, '2021-06-10', 1, 57, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(401, '2021-06-10', 1, 59, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(402, '2021-06-10', 1, 64, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(403, '2021-06-10', 1, 67, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(404, '2021-06-10', 1, 84, 4, 3, 2, 5, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(405, '2021-06-10', 1, 84, 8, 3, 2, 6, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(406, '2021-06-10', 1, 85, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(407, '2021-06-10', 1, 101, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(408, '2021-06-10', 1, 132, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(409, '2021-06-10', 1, 135, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(410, '2021-06-10', 1, 140, 8, 2, 2, 13, 9, 'SI', 128, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(411, '2021-06-10', 1, 146, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(412, '2021-06-10', 1, 149, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(413, '2021-06-10', 1, 153, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(414, '2021-06-10', 1, 154, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(415, '2021-06-10', 1, 155, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(416, '2021-06-10', 1, 156, 8, 2, 2, 12, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(417, '2021-06-10', 1, 161, 4, 3, 2, 5, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(418, '2021-06-10', 1, 162, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(419, '2021-06-10', 1, 163, 8, 2, 2, 4, 9, 'SI', 146, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(420, '2021-06-11', 1, 31, 1, 2, 2, 5, 0, 'SI', 34, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(421, '2021-06-11', 1, 119, 10, 2, 2, 13, 11, 'SI', 106, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(422, '2021-06-11', 1, 126, 1, 2, 2, 5, 0, 'SI', 124, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(423, '2021-06-11', 1, 137, 10, 2, 2, 4, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(424, '2021-06-11', 1, 150, 10, 2, 2, 13, 10, 'SI', 153, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(425, '2021-06-11', 1, 159, 10, 2, 2, 2, 10, 'SI', 145, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(426, '2021-06-11', 1, 160, 10, 2, 2, 13, 10, 'SI', 154, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(427, '2021-06-11', 1, 162, 1, 2, 2, 5, 0, 'SI', 149, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(428, '2021-06-11', 1, 164, 1, 2, 2, 5, 0, 'SI', 147, 2, 13, NULL, 1, '2021-06-29 00:54:42'),
(429, '2021-06-11', 1, 164, 10, 2, 2, 13, 9, 'SI', 147, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(430, '2021-06-11', 1, 165, 1, 2, 2, 5, 0, 'SI', 148, 12, 13, NULL, 1, '2021-06-29 00:54:42'),
(431, '2021-06-11', 1, 165, 10, 2, 2, 13, 9, 'SI', 148, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(432, '2021-06-11', 1, 166, 1, 2, 2, 5, 0, 'SI', 150, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(433, '2021-06-11', 1, 166, 10, 2, 2, 4, 9, 'SI', 150, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(434, '2021-06-11', 1, 167, 10, 2, 2, 13, 9, 'SI', 151, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(435, '2021-06-11', 1, 168, 10, 2, 2, 4, 9, 'SI', 152, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(436, '2021-06-11', 1, 169, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(437, '2021-06-12', 1, 22, 4, 3, 2, 9, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(438, '2021-06-12', 1, 29, 4, 3, 2, 15, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(439, '2021-06-12', 1, 30, 4, 3, 2, 6, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(440, '2021-06-12', 1, 31, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(441, '2021-06-12', 1, 61, 4, 3, 2, 15, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(442, '2021-06-12', 1, 68, 8, 2, 2, 8, 0, 'SI', 63, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(443, '2021-06-12', 1, 75, 8, 2, 2, 8, 0, 'SI', 66, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(444, '2021-06-12', 1, 101, 8, 2, 2, 4, 11, 'SI', 88, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(445, '2021-06-12', 1, 123, 8, 1, 2, 8, 0, 'SI', 109, 12, 14, NULL, 1, '2021-06-29 00:54:42'),
(446, '2021-06-12', 1, 136, 8, 1, 2, 8, 0, 'SI', 135, 12, 9, NULL, 1, '2021-06-29 00:54:42'),
(447, '2021-06-12', 1, 138, 8, 1, 2, 8, 0, 'SI', 156, 12, 14, NULL, 1, '2021-06-29 00:54:42'),
(448, '2021-06-12', 1, 143, 8, 2, 2, 4, 10, 'SI', 157, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(449, '2021-06-12', 1, 163, 8, 2, 2, 4, 10, 'SI', 146, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(450, '2021-06-12', 1, 170, 8, 2, 2, 8, 0, 'SI', 155, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(451, '2021-06-12', 1, 171, 4, 3, 2, 15, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(452, '2021-06-12', 1, 172, 8, 2, 2, 4, 9, 'SI', 158, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(453, '2021-06-12', 1, 173, 8, 2, 2, 4, 9, 'SI', 160, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(454, '2021-06-12', 1, 174, 8, 2, 2, 4, 9, 'SI', 161, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(455, '2021-06-12', 1, 175, 8, 2, 2, 12, 9, 'SI', 162, 12, 14, NULL, 1, '2021-06-29 00:54:42'),
(456, '2021-06-14', 1, 1, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(457, '2021-06-14', 1, 4, 4, 3, 2, 15, 4, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(458, '2021-06-14', 1, 63, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(459, '2021-06-14', 1, 68, 1, 2, 2, 5, 0, 'SI', 63, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(460, '2021-06-14', 1, 124, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(461, '2021-06-14', 1, 125, 1, 2, 2, 5, 0, 'SI', 111, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(462, '2021-06-14', 1, 143, 10, 2, 2, 4, 9, 'SI', 157, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(463, '2021-06-14', 1, 152, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(464, '2021-06-14', 1, 160, 10, 2, 2, 13, 11, 'SI', 154, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(465, '2021-06-14', 1, 164, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(466, '2021-06-14', 1, 166, 10, 2, 2, 4, 10, 'SI', 150, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(467, '2021-06-14', 1, 167, 1, 2, 2, 5, 0, 'SI', 151, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(468, '2021-06-14', 1, 167, 10, 2, 2, 13, 10, 'SI', 151, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(469, '2021-06-14', 1, 168, 10, 2, 2, 4, 10, 'SI', 152, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(470, '2021-06-14', 1, 169, 10, 2, 2, 13, 10, 'SI', 167, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(471, '2021-06-14', 1, 170, 1, 2, 2, 5, 0, 'SI', 155, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(472, '2021-06-14', 1, 172, 1, 2, 2, 5, 0, 'SI', 159, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(473, '2021-06-14', 1, 176, 1, 2, 2, 5, 0, 'SI', 163, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(474, '2021-06-14', 1, 177, 1, 2, 2, 5, 0, 'SI', 164, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(475, '2021-06-14', 1, 178, 10, 2, 2, 2, 9, 'SI', 165, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(476, '2021-06-14', 1, 179, 10, 2, 2, 13, 9, 'SI', 166, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(477, '2021-06-14', 1, 180, 4, 3, 2, 15, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(478, '2021-06-15', 1, 26, 8, 3, 2, 13, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(479, '2021-06-15', 1, 59, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(480, '2021-06-15', 1, 59, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(481, '2021-06-15', 1, 131, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(482, '2021-06-15', 1, 134, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(483, '2021-06-15', 1, 146, 8, 2, 2, 4, 0, 'SI', 132, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(484, '2021-06-15', 1, 149, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(485, '2021-06-15', 1, 154, 8, 2, 2, 4, 0, 'SI', 137, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(486, '2021-06-15', 1, 155, 8, 2, 2, 4, 0, 'SI', 138, 4, 0, NULL, 1, '2021-06-29 00:54:42'),
(487, '2021-06-15', 1, 162, 8, 2, 2, 4, 0, 'SI', 149, 13, 0, NULL, 1, '2021-06-29 00:54:42'),
(488, '2021-06-15', 1, 172, 8, 2, 2, 4, 0, 'SI', 159, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(489, '2021-06-15', 1, 175, 8, 2, 2, 12, 0, 'SI', 162, 12, 0, NULL, 1, '2021-06-29 00:54:42'),
(490, '2021-06-15', 1, 181, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(491, '2021-06-16', 1, 76, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(492, '2021-06-16', 1, 119, 4, 3, 2, 15, 4, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(493, '2021-06-16', 1, 143, 1, 2, 2, 5, 0, 'SI', 136, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(494, '2021-06-16', 1, 154, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(495, '2021-06-16', 1, 159, 10, 2, 2, 13, 11, 'SI', 145, 4, 17, NULL, 1, '2021-06-29 00:54:42'),
(496, '2021-06-16', 1, 162, 10, 2, 2, 4, 9, 'SI', 149, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(497, '2021-06-16', 1, 164, 10, 2, 2, 13, 11, 'SI', 147, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(498, '2021-06-16', 1, 166, 10, 2, 2, 4, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(499, '2021-06-16', 1, 167, 10, 2, 2, 13, 11, 'SI', 151, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(500, '2021-06-16', 1, 168, 10, 2, 2, 4, 11, 'SI', 152, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(501, '2021-06-16', 1, 169, 1, 2, 2, 5, 0, 'SI', 167, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(502, '2021-06-16', 1, 179, 10, 2, 2, 13, 10, 'SI', 166, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(503, '2021-06-16', 1, 181, 10, 2, 2, 4, 9, 'SI', 172, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(504, '2021-06-16', 1, 182, 1, 2, 2, 5, 0, 'SI', 168, 5, 2, NULL, 1, '2021-06-29 00:54:42'),
(505, '2021-06-16', 1, 183, 1, 2, 2, 5, 0, 'SI', 169, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(506, '2021-06-16', 1, 183, 10, 2, 2, 13, 9, 'SI', 169, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(507, '2021-06-16', 1, 184, 1, 2, 2, 5, 0, 'SI', 170, 13, 1, NULL, 1, '2021-06-29 00:54:42'),
(508, '2021-06-16', 1, 184, 10, 2, 2, 13, 9, 'SI', 170, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(509, '2021-06-16', 1, 185, 1, 2, 2, 5, 0, 'SI', 171, 13, 1, NULL, 1, '2021-06-29 00:54:42'),
(510, '2021-06-17', 1, 27, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(511, '2021-06-17', 1, 58, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(512, '2021-06-17', 1, 94, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(513, '2021-06-17', 1, 116, 8, 2, 2, 4, 9, 'SI', 103, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(514, '2021-06-17', 1, 126, 8, 2, 2, 4, 9, 'SI', 123, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(515, '2021-06-17', 1, 132, 8, 2, 2, 4, 11, 'SI', 131, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(516, '2021-06-17', 1, 146, 8, 2, 2, 4, 11, 'SI', 132, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(517, '2021-06-17', 1, 160, 8, 2, 2, 13, 9, 'SI', 154, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(518, '2021-06-17', 1, 172, 8, 2, 2, 4, 10, 'SI', 159, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(519, '2021-06-17', 1, 184, 8, 2, 2, 4, 9, 'SI', 170, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(520, '2021-06-17', 1, 186, 8, 3, 2, 6, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(521, '2021-06-17', 1, 187, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(522, '2021-06-18', 1, 13, 4, 3, 2, 15, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(523, '2021-06-18', 1, 39, 4, 3, 2, 15, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(524, '2021-06-18', 1, 106, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(525, '2021-06-18', 1, 142, 4, 3, 2, 15, 5, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(526, '2021-06-18', 1, 160, 1, 2, 2, 5, 0, 'SI', 154, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(527, '2021-06-18', 1, 164, 1, 2, 2, 5, 0, 'SI', 147, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(528, '2021-06-18', 1, 167, 4, 3, 2, 9, 1, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(529, '2021-06-18', 1, 169, 10, 2, 2, 13, 11, 'SI', 167, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(530, '2021-06-18', 1, 175, 1, 2, 2, 5, 0, 'SI', 162, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(531, '2021-06-18', 1, 178, 10, 2, 2, 2, 10, 'SI', 165, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(532, '2021-06-18', 1, 179, 10, 2, 2, 13, 11, 'SI', 166, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(533, '2021-06-18', 1, 183, 10, 2, 2, 13, 10, 'SI', 169, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(534, '2021-06-18', 1, 184, 10, 2, 2, 13, 10, 'SI', 170, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(535, '2021-06-18', 1, 184, 1, 2, 2, 5, 0, 'SI', 175, 2, 0, NULL, 1, '2021-06-29 00:54:42'),
(536, '2021-06-18', 1, 187, 10, 2, 2, 4, 9, 'SI', 173, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(537, '2021-06-18', 1, 187, 1, 2, 2, 5, 0, 'SI', 173, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(538, '2021-06-18', 1, 188, 10, 2, 2, 13, 9, 'SI', 174, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(539, '2021-06-18', 1, 188, 1, 2, 2, 5, 0, 'SI', 174, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(540, '2021-06-18', 1, 189, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(541, '2021-06-18', 1, 190, 10, 2, 2, 13, 9, 'SI', 176, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(542, '2021-06-18', 1, 191, 10, 2, 2, 4, 9, 'SI', 177, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(543, '2021-06-19', 1, 132, 8, 2, 2, 4, 9, 'SI', 131, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(544, '2021-06-19', 1, 146, 8, 2, 2, 4, 9, 'SI', 179, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(545, '2021-06-19', 1, 162, 8, 2, 2, 4, 9, 'SI', 149, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(546, '2021-06-19', 1, 166, 8, 2, 2, 13, 9, 'SI', 150, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(547, '2021-06-19', 1, 169, 8, 2, 2, 4, 9, 'SI', 167, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(548, '2021-06-19', 1, 178, 8, 2, 2, 2, 9, 'SI', 165, 13, 14, NULL, 1, '2021-06-29 00:54:42');
INSERT INTO `psyem_seguimiento` (`idSeguimiento`, `fRegistrSeg`, `idUsuario`, `idAtencionPac`, `idProfesional`, `idTipoSeguimiento`, `idMotSeguimiento`, `idDiag1Seg`, `idDiag2Seg`, `comunFamSeg`, `idFamAtSeg`, `idDiag1SegFam`, `idDiag2SegFam`, `obsSeg`, `idStatusSeg`, `registroSistema`) VALUES
(549, '2021-06-19', 1, 181, 8, 2, 2, 4, 9, 'SI', 172, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(550, '2021-06-19', 1, 183, 8, 2, 2, 4, 9, 'SI', 178, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(551, '2021-06-19', 1, 187, 8, 2, 2, 4, 10, 'SI', 173, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(552, '2021-06-19', 1, 188, 8, 2, 2, 13, 9, 'SI', 174, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(553, '2021-06-19', 1, 189, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(554, '2021-06-19', 1, 192, 8, 2, 2, 8, 0, 'SI', 180, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(555, '2021-06-21', 1, 75, 1, 2, 2, 5, 0, 'SI', 66, 13, 1, NULL, 1, '2021-06-29 00:54:42'),
(556, '2021-06-21', 1, 126, 1, 2, 2, 5, 0, 'SI', 124, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(557, '2021-06-21', 1, 146, 1, 2, 2, 5, 0, 'SI', 132, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(558, '2021-06-21', 1, 168, 1, 2, 2, 5, 0, 'SI', 152, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(559, '2021-06-21', 1, 178, 10, 2, 2, 2, 11, 'SI', 165, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(560, '2021-06-21', 1, 183, 10, 2, 2, 13, 11, 'SI', 169, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(561, '2021-06-21', 1, 184, 10, 2, 2, 13, 11, 'SI', 170, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(562, '2021-06-21', 1, 188, 10, 2, 2, 13, 10, 'SI', 174, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(563, '2021-06-21', 1, 189, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(564, '2021-06-21', 1, 190, 1, 2, 2, 5, 0, 'SI', 176, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(565, '2021-06-21', 1, 191, 10, 2, 2, 4, 10, 'SI', 177, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(566, '2021-06-21', 1, 193, 1, 2, 2, 5, 0, 'SI', 181, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(567, '2021-06-21', 1, 194, 1, 2, 2, 2, 0, 'SI', 182, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(568, '2021-06-21', 1, 195, 10, 2, 2, 13, 9, 'SI', 183, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(569, '2021-06-21', 1, 196, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(570, '2021-06-22', 1, 59, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(571, '2021-06-22', 1, 126, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(572, '2021-06-22', 1, 143, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(573, '2021-06-22', 1, 155, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(574, '2021-06-22', 1, 159, 8, 2, 2, 4, 9, 'SI', 145, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(575, '2021-06-22', 1, 172, 4, 3, 2, 6, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(576, '2021-06-22', 1, 175, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(577, '2021-06-22', 1, 179, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(578, '2021-06-22', 1, 187, 8, 2, 2, 4, 9, 'SI', 173, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(579, '2021-06-22', 1, 195, 8, 2, 2, 4, 9, 'SI', 183, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(580, '2021-06-22', 1, 196, 8, 2, 2, 4, 14, 'SI', 185, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(581, '2021-06-22', 1, 197, 8, 2, 2, 13, 9, 'SI', 184, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(582, '2021-06-22', 1, 198, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(583, '2021-06-23', 1, 132, 1, 2, 2, 5, 0, 'SI', 131, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(584, '2021-06-23', 1, 132, 1, 2, 2, 5, 0, 'SI', 131, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(585, '2021-06-23', 1, 132, 1, 2, 2, 5, 0, 'SI', 131, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(586, '2021-06-23', 1, 159, 1, 2, 2, 5, 0, 'SI', 145, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(587, '2021-06-23', 1, 187, 10, 2, 2, 4, 10, 'SI', 173, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(588, '2021-06-23', 1, 188, 10, 2, 2, 13, 11, 'SI', 174, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(589, '2021-06-23', 1, 189, 1, 2, 2, 5, 0, 'SI', 186, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(590, '2021-06-23', 1, 191, 10, 2, 2, 4, 11, 'SI', 177, 4, 16, NULL, 1, '2021-06-29 00:54:42'),
(591, '2021-06-23', 1, 195, 1, 2, 2, 5, 0, 'SI', 183, 2, 5, NULL, 1, '2021-06-29 00:54:42'),
(592, '2021-06-23', 1, 195, 10, 2, 2, 4, 10, 'SI', 183, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(593, '2021-06-23', 1, 196, 1, 2, 2, 5, 0, 'SI', 185, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(594, '2021-06-23', 1, 197, 10, 2, 2, 13, 9, 'SI', 184, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(595, '2021-06-23', 1, 198, 1, 2, 2, 5, 0, 'SI', 187, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(596, '2021-06-23', 1, 198, 10, 2, 2, 13, 9, 'SI', 187, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(597, '2021-06-23', 1, 199, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(598, '2021-06-24', 1, 59, 8, 2, 2, 4, 11, 'SI', 56, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(599, '2021-06-24', 1, 132, 8, 2, 2, 4, 9, 'SI', 131, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(600, '2021-06-24', 1, 157, 8, 1, 2, 8, 0, 'SI', 140, 12, 0, NULL, 1, '2021-06-29 00:54:42'),
(601, '2021-06-24', 1, 159, 8, 2, 2, 4, 9, 'SI', 145, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(602, '2021-06-24', 1, 164, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(603, '2021-06-24', 1, 164, 8, 2, 2, 13, 10, 'SI', 189, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(604, '2021-06-24', 1, 168, 4, 1, 2, 12, 15, 'SI', 152, 6, 9, NULL, 1, '2021-06-29 00:54:42'),
(605, '2021-06-24', 1, 183, 4, 1, 2, 12, 15, 'SI', 169, 7, 9, NULL, 1, '2021-06-29 00:54:42'),
(606, '2021-06-24', 1, 185, 4, 1, 2, 12, 15, 'SI', 171, 14, 7, NULL, 1, '2021-06-29 00:54:42'),
(607, '2021-06-24', 1, 187, 8, 2, 2, 4, 9, 'SI', 173, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(608, '2021-06-24', 1, 190, 4, 3, 2, 4, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(609, '2021-06-24', 1, 191, 8, 2, 2, 4, 9, 'SI', 177, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(610, '2021-06-24', 1, 195, 8, 2, 2, 4, 9, 'SI', 183, 13, 15, NULL, 1, '2021-06-29 00:54:42'),
(611, '2021-06-25', 1, 68, 1, 2, 2, 5, 0, 'SI', 63, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(612, '2021-06-25', 1, 75, 1, 2, 2, 5, 0, 'SI', 66, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(613, '2021-06-25', 1, 99, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(614, '2021-06-25', 1, 120, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(615, '2021-06-25', 1, 125, 1, 2, 2, 5, 0, 'SI', 111, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(616, '2021-06-25', 1, 151, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(617, '2021-06-25', 1, 170, 1, 2, 2, 5, 0, 'SI', 155, 5, 1, NULL, 1, '2021-06-29 00:54:42'),
(618, '2021-06-25', 1, 176, 1, 2, 2, 5, 0, 'SI', 163, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(619, '2021-06-25', 1, 195, 10, 2, 2, 4, 11, 'SI', 183, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(620, '2021-06-25', 1, 198, 10, 2, 2, 13, 10, 'SI', 187, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(621, '2021-06-25', 1, 199, 10, 2, 2, 4, 10, 'SI', 190, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(622, '2021-06-25', 1, 200, 10, 2, 2, 4, 9, 'SI', 191, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(623, '2021-06-25', 1, 201, 1, 2, 2, 5, 0, 'SI', 192, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(624, '2021-06-25', 1, 201, 1, 2, 2, 5, 0, 'SI', 192, 2, 1, NULL, 1, '2021-06-29 00:54:42'),
(625, '2021-06-25', 1, 202, 10, 2, 2, 4, 9, 'SI', 193, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(626, '2021-06-26', 1, 27, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(627, '2021-06-26', 1, 59, 8, 2, 2, 4, 9, 'SI', 196, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(628, '2021-06-26', 1, 76, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(629, '2021-06-26', 1, 77, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(630, '2021-06-26', 1, 126, 8, 2, 2, 4, 11, 'SI', 123, 13, 16, NULL, 1, '2021-06-29 00:54:42'),
(631, '2021-06-26', 1, 132, 8, 2, 2, 4, 11, 'SI', 131, 4, 15, NULL, 1, '2021-06-29 00:54:42'),
(632, '2021-06-26', 1, 160, 4, 3, 2, 1, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(633, '2021-06-26', 1, 162, 4, 3, 2, 6, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(634, '2021-06-26', 1, 177, 4, 1, 2, 8, 0, 'SI', 194, 5, 9, NULL, 1, '2021-06-29 00:54:42'),
(635, '2021-06-26', 1, 184, 4, 1, 2, 8, 0, 'SI', 170, 6, 9, NULL, 1, '2021-06-29 00:54:42'),
(636, '2021-06-26', 1, 191, 4, 3, 2, 13, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(637, '2021-06-26', 1, 200, 8, 2, 2, 4, 9, 'SI', 191, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(638, '2021-06-26', 1, 202, 8, 2, 2, 4, 9, 'SI', 193, 4, 14, NULL, 1, '2021-06-29 00:54:42'),
(639, '2021-06-26', 1, 203, 4, 3, 2, 6, 9, 'NO', 0, 0, 0, NULL, 1, '2021-06-29 00:54:42'),
(640, '2021-06-26', 1, 204, 8, 1, 2, 8, 0, 'SI', 195, 12, 14, NULL, 1, '2021-06-29 00:54:42'),
(641, '2021-06-26', 1, 205, 8, 2, 2, 4, 9, 'SI', 197, 13, 14, NULL, 1, '2021-06-29 00:54:42'),
(642, '2021-06-28', 1, 206, 10, 2, 2, 13, 9, 'SI', 198, 4, 14, '', 1, '2021-06-29 09:42:19'),
(643, '2021-06-28', 1, 207, 10, 2, 2, 13, 9, 'SI', 199, 13, 14, '', 1, '2021-06-29 09:43:16'),
(644, '2021-06-28', 1, 201, 10, 2, 2, 4, 9, 'SI', 200, 13, 14, '', 1, '2021-06-29 09:46:46'),
(645, '2021-06-28', 1, 200, 10, 2, 2, 4, 10, 'SI', 191, 13, 14, '', 1, '2021-06-29 09:56:36'),
(646, '2021-06-28', 1, 208, 10, 2, 2, 4, 9, 'SI', 201, 13, 14, '', 1, '2021-06-29 09:57:46'),
(647, '2021-06-28', 1, 209, 1, 2, 2, 5, 0, 'SI', 202, 5, 1, '', 1, '2021-06-29 10:02:03'),
(648, '2021-06-28', 1, 199, 1, 2, 2, 5, 0, 'SI', 190, 5, 1, '', 1, '2021-06-29 10:02:59'),
(649, '2021-06-28', 1, 188, 1, 2, 2, 5, 0, 'SI', 174, 13, 1, '', 1, '2021-06-29 10:03:46'),
(650, '2021-06-28', 1, 207, 1, 2, 2, 5, 0, 'SI', 199, 2, 1, '', 1, '2021-06-29 10:07:26'),
(651, '2021-06-28', 1, 179, 1, 2, 2, 5, 0, 'SI', 166, 13, 1, '', 1, '2021-06-29 10:09:03'),
(652, '2021-06-28', 1, 59, 1, 2, 2, 5, 0, 'SI', 56, 5, 1, '', 1, '2021-06-29 10:12:26'),
(653, '2021-06-28', 1, 209, 10, 2, 2, 8, 0, 'SI', 202, 4, 14, '', 1, '2021-06-29 10:13:16'),
(654, '2021-06-28', 1, 205, 10, 2, 2, 4, 9, 'SI', 197, 4, 14, '', 1, '2021-06-29 10:14:48'),
(655, '2021-06-28', 1, 210, 10, 2, 2, 4, 9, 'SI', 203, 4, 14, '', 1, '2021-06-29 10:17:16'),
(656, '2021-06-28', 1, 210, 10, 2, 2, 4, 9, 'SI', 203, 4, 14, '', 1, '2021-06-29 10:18:16'),
(657, '2021-06-30', 12, 201, 10, 2, 2, 4, 9, 'SI', 200, 13, 14, '', 1, '2021-07-02 20:03:07'),
(658, '2021-06-30', 12, 208, 10, 2, 2, 4, 10, 'SI', 201, 13, 15, '', 1, '2021-07-02 20:04:18'),
(659, '2021-06-30', 12, 207, 10, 2, 2, 13, 10, 'SI', 199, 13, 15, '', 1, '2021-07-02 20:05:57'),
(660, '2021-06-30', 12, 207, 10, 2, 2, 13, 10, 'SI', 199, 13, 15, '', 1, '2021-07-02 20:07:37'),
(661, '2021-06-30', 12, 200, 10, 2, 2, 4, 11, 'SI', 191, 13, 16, '', 1, '2021-07-02 20:08:41'),
(662, '2021-06-30', 12, 211, 10, 2, 2, 4, 9, 'SI', 204, 13, 14, '', 1, '2021-07-02 20:11:39'),
(663, '2021-07-02', 12, 201, 10, 2, 2, 4, 11, 'SI', 200, 13, 16, '', 1, '2021-07-03 05:33:20'),
(664, '2021-07-02', 12, 208, 10, 2, 2, 4, 11, 'SI', 201, 13, 16, '', 1, '2021-07-03 05:34:39'),
(665, '2021-07-02', 12, 207, 10, 2, 2, 13, 11, 'SI', 199, 13, 16, '', 1, '2021-07-03 05:35:26'),
(666, '2021-07-02', 12, 205, 10, 2, 2, 4, 10, 'SI', 197, 4, 15, '', 1, '2021-07-03 05:36:21'),
(667, '2021-06-30', 3, 212, 1, 2, 2, 5, 0, 'SI', 205, 2, 1, '', 1, '2021-07-03 05:41:44'),
(668, '2021-06-30', 3, 200, 1, 2, 2, 5, 0, 'SI', 191, 13, 1, '', 1, '2021-07-03 05:42:35'),
(669, '2021-06-30', 3, 208, 1, 2, 2, 5, 0, 'SI', 201, 2, 1, '', 1, '2021-07-03 05:43:46'),
(670, '2021-06-30', 3, 213, 1, 2, 2, 5, 0, 'SI', 206, 5, 1, '', 1, '2021-07-03 05:46:56'),
(671, '2021-06-30', 3, 210, 1, 2, 2, 5, 0, 'SI', 203, 2, 1, '', 1, '2021-07-03 05:47:57'),
(672, '2021-06-30', 3, 211, 1, 2, 2, 5, 0, 'SI', 204, 2, 1, '', 1, '2021-07-03 05:49:07'),
(673, '2021-07-02', 3, 75, 1, 2, 2, 5, 0, 'SI', 66, 2, 1, '', 1, '2021-07-03 05:49:51'),
(674, '2021-07-02', 3, 196, 1, 2, 2, 5, 0, 'SI', 185, 2, 1, '', 1, '2021-07-03 05:51:38'),
(675, '2021-07-02', 3, 125, 1, 2, 2, 5, 0, 'SI', 111, 5, 1, '', 1, '2021-07-03 05:52:51'),
(676, '2021-07-02', 3, 212, 1, 2, 2, 5, 0, 'SI', 205, 2, 1, '', 1, '2021-07-03 05:53:57'),
(677, '2021-07-02', 3, 194, 1, 2, 2, 5, 0, 'SI', 182, 5, 1, '', 1, '2021-07-03 05:54:45'),
(678, '2021-07-02', 3, 209, 1, 2, 2, 5, 0, 'SI', 202, 5, 13, '', 1, '2021-07-03 05:55:29'),
(679, '2021-06-30', 6, 68, 4, 2, 2, 8, 15, 'SI', 63, 6, 9, '', 1, '2021-07-03 05:59:10'),
(680, '2021-06-30', 6, 195, 4, 2, 2, 8, 15, 'SI', 207, 4, 9, '', 1, '2021-07-03 06:01:57'),
(681, '2021-06-30', 6, 202, 4, 2, 2, 8, 15, 'SI', 193, 5, 9, '', 1, '2021-07-03 06:03:54'),
(682, '2021-06-30', 10, 59, 8, 2, 2, 13, 17, 'SI', 196, 13, 0, '', 1, '2021-07-03 06:12:09'),
(683, '2021-06-30', 10, 126, 8, 2, 2, 13, 9, 'SI', 123, 13, 16, '', 1, '2021-07-03 06:13:30'),
(684, '2021-06-30', 10, 210, 8, 2, 2, 4, 9, 'SI', 203, 13, 14, '', 1, '2021-07-03 06:14:25'),
(685, '2021-06-30', 10, 216, 8, 2, 2, 4, 11, 'SI', 210, 13, 14, '', 1, '2021-07-03 06:17:07'),
(686, '2021-06-30', 10, 212, 8, 2, 2, 2, 9, 'SI', 205, 13, 14, '', 1, '2021-07-03 06:17:51'),
(687, '2021-07-01', 10, 201, 8, 2, 2, 4, 9, 'SI', 192, 13, 14, '', 1, '2021-07-03 06:19:35'),
(688, '2021-07-01', 10, 208, 8, 2, 2, 13, 9, 'SI', 201, 13, 14, '', 1, '2021-07-03 06:20:35'),
(689, '2021-07-01', 10, 214, 8, 2, 2, 4, 9, 'SI', 208, 13, 14, '', 1, '2021-07-03 06:21:31'),
(690, '2021-07-01', 10, 215, 8, 2, 2, 13, 9, 'SI', 209, 13, 14, '', 1, '2021-07-03 06:22:20'),
(691, '2021-07-01', 10, 211, 8, 2, 2, 4, 9, 'SI', 204, 13, 14, '', 1, '2021-07-03 06:23:33'),
(692, '2021-07-01', 10, 213, 8, 2, 2, 4, 0, 'SI', 206, 13, 14, '', 1, '2021-07-03 06:24:12'),
(693, '2021-07-01', 10, 212, 8, 2, 2, 2, 10, 'SI', 205, 13, 15, '', 1, '2021-07-03 06:27:59'),
(694, '2021-07-01', 10, 159, 8, 2, 2, 4, 9, 'SI', 145, 13, 15, '', 1, '2021-07-03 06:29:24'),
(695, '2021-06-30', 6, 198, 4, 3, 2, 5, 9, 'NO', 0, 0, 0, '', 1, '2021-07-05 15:27:21'),
(696, '2021-07-02', 12, 213, 10, 2, 2, 4, 9, 'SI', 206, 13, 14, '', 1, '2021-07-05 16:00:01'),
(697, '2021-07-02', 12, 217, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-07-05 16:01:31'),
(698, '2021-07-02', 12, 206, 10, 2, 2, 4, 9, 'SI', 198, 4, 15, '', 1, '2021-07-05 16:02:10'),
(699, '2021-07-02', 12, 218, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-07-05 16:03:34'),
(700, '2021-07-02', 12, 214, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-07-05 16:04:38'),
(701, '2021-07-02', 10, 214, 8, 2, 2, 4, 9, 'SI', 208, 13, 15, '', 1, '2021-07-05 16:09:07'),
(702, '2021-07-03', 10, 218, 8, 2, 2, 13, 9, 'SI', 211, 13, 14, '', 1, '2021-07-05 16:11:11'),
(703, '2021-07-03', 10, 219, 8, 2, 2, 4, 9, 'SI', 212, 13, 14, '', 1, '2021-07-05 16:13:50'),
(704, '2021-07-03', 10, 213, 8, 2, 2, 4, 9, 'SI', 206, 13, 15, '', 1, '2021-07-05 16:14:38'),
(705, '2021-07-03', 10, 126, 8, 2, 2, 4, 9, 'SI', 123, 13, 17, '', 1, '2021-07-05 16:15:14'),
(706, '2021-07-03', 10, 208, 8, 2, 2, 13, 9, 'SI', 201, 13, 15, '', 1, '2021-07-05 16:18:30'),
(707, '2021-07-03', 10, 205, 8, 2, 2, 4, 9, 'SI', 197, 4, 14, '', 1, '2021-07-05 16:19:14'),
(708, '2021-07-03', 10, 211, 8, 2, 2, 4, 9, 'SI', 204, 13, 15, '', 1, '2021-07-05 16:20:12'),
(709, '2021-07-03', 10, 211, 8, 2, 2, 4, 9, 'SI', 204, 13, 15, '', 1, '2021-07-05 16:20:58'),
(710, '2021-07-05', 12, 125, 10, 2, 2, 4, 9, 'SI', 111, 13, 14, '', 1, '2021-07-06 19:10:20'),
(711, '2021-07-05', 12, 220, 10, 2, 2, 4, 9, 'SI', 213, 4, 14, '', 1, '2021-07-06 19:12:32'),
(712, '2021-07-05', 12, 209, 10, 2, 2, 8, 0, 'SI', 202, 4, 15, '', 1, '2021-07-06 19:13:10'),
(713, '2021-07-05', 12, 213, 10, 2, 2, 4, 10, 'SI', 206, 13, 15, '', 1, '2021-07-06 19:14:06'),
(714, '2021-07-05', 12, 205, 10, 2, 2, 4, 11, 'SI', 197, 4, 16, '', 1, '2021-07-06 19:15:55'),
(715, '2021-07-05', 12, 211, 10, 2, 2, 4, 0, 'SI', 204, 13, 15, '', 1, '2021-07-06 19:19:23'),
(716, '2021-07-05', 12, 218, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, '', 1, '2021-07-06 19:19:58'),
(717, '2021-07-05', 12, 221, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-07-06 19:23:42'),
(718, '2021-07-06', 10, 222, 8, 2, 2, 4, 9, 'SI', 214, 13, 14, '', 1, '2021-07-07 15:16:58'),
(719, '2021-07-06', 10, 125, 8, 2, 2, 4, 9, 'SI', 111, 13, 14, '', 1, '2021-07-07 15:43:39'),
(720, '2021-07-06', 10, 223, 8, 2, 2, 4, 9, 'SI', 215, 4, 14, '', 1, '2021-07-07 15:46:16'),
(721, '2021-07-06', 10, 224, 8, 2, 2, 4, 9, 'SI', 216, 4, 14, '', 1, '2021-07-07 15:48:04'),
(722, '2021-07-06', 10, 225, 8, 2, 2, 4, 9, 'SI', 217, 4, 14, '', 1, '2021-07-07 15:50:31'),
(723, '2021-07-06', 10, 126, 8, 2, 2, 13, 11, 'SI', 123, 13, 17, '', 1, '2021-07-07 18:57:12'),
(724, '2021-07-06', 10, 213, 8, 2, 2, 4, 11, 'SI', 206, 13, 17, '', 1, '2021-07-07 18:58:29'),
(725, '2021-07-06', 10, 215, 8, 2, 2, 2, 10, 'SI', 209, 4, 16, '', 1, '2021-07-07 18:59:50'),
(726, '2021-07-06', 10, 226, 8, 2, 2, 4, 9, 'SI', 218, 13, 14, '', 1, '2021-07-07 23:57:04'),
(727, '2021-07-06', 10, 201, 8, 2, 2, 13, 10, 'SI', 192, 13, 16, '', 1, '2021-07-08 00:02:06'),
(728, '2021-07-07', 12, 213, 10, 2, 2, 4, 9, 'SI', 206, 13, 16, '', 1, '2021-07-09 16:58:02'),
(729, '2021-07-07', 12, 227, 10, 2, 2, 13, 9, 'SI', 219, 4, 9, '', 1, '2021-07-09 17:01:46'),
(730, '2021-07-07', 12, 211, 10, 2, 2, 4, 9, 'SI', 204, 13, 16, '', 1, '2021-07-09 17:03:05'),
(731, '2021-07-07', 12, 218, 10, 2, 2, 13, 9, 'SI', 211, 13, 14, '', 1, '2021-07-09 17:04:15'),
(732, '2021-07-07', 12, 220, 10, 2, 2, 4, 9, 'SI', 213, 4, 10, '', 1, '2021-07-09 17:05:27'),
(733, '2021-07-07', 12, 225, 10, 2, 2, 4, 9, 'SI', 217, 4, 14, '', 1, '2021-07-09 17:06:18'),
(734, '2021-07-07', 12, 224, 10, 2, 2, 4, 9, 'SI', 216, 4, 14, '', 1, '2021-07-09 17:07:12'),
(735, '2021-07-07', 12, 125, 10, 2, 2, 4, 9, 'SI', 111, 13, 15, '', 1, '2021-07-09 17:10:05'),
(736, '2021-07-08', 10, 75, 8, 2, 2, 4, 9, 'SI', 66, 13, 14, '', 1, '2021-07-09 17:12:30'),
(737, '2021-07-08', 10, 224, 8, 2, 2, 4, 9, 'SI', 216, 13, 15, '', 1, '2021-07-09 17:14:33'),
(738, '2021-07-08', 10, 228, 8, 2, 2, 4, 9, 'SI', 220, 4, 14, '', 1, '2021-07-09 17:21:39'),
(739, '2021-07-08', 10, 126, 8, 2, 2, 13, 0, 'SI', 123, 13, 17, '', 1, '2021-07-09 17:24:07'),
(740, '2021-07-08', 10, 215, 8, 2, 2, 2, 9, 'SI', 209, 4, 17, '', 1, '2021-07-09 17:25:24'),
(741, '2021-07-08', 10, 207, 8, 2, 2, 4, 9, 'SI', 199, 4, 14, '', 1, '2021-07-09 17:26:57'),
(742, '2021-07-08', 10, 229, 8, 2, 2, 4, 9, 'SI', 221, 13, 14, '', 1, '2021-07-09 17:37:24'),
(743, '2021-07-08', 10, 230, 8, 2, 2, 4, 9, 'SI', 222, 13, 14, '', 1, '2021-07-09 17:39:06'),
(744, '2021-07-08', 10, 226, 8, 2, 2, 4, 9, 'SI', 218, 13, 16, '', 1, '2021-07-09 17:40:28'),
(745, '2021-07-09', 12, 220, 10, 2, 2, 4, 11, 'SI', 213, 4, 16, '', 1, '2021-07-10 16:27:09'),
(746, '2021-07-09', 12, 231, 10, 2, 2, 4, 9, 'SI', 223, 4, 14, '', 1, '2021-07-10 16:29:01'),
(747, '2021-07-09', 12, 232, 10, 2, 2, 4, 9, 'SI', 224, 13, 14, '', 1, '2021-07-10 16:31:54'),
(748, '2021-07-09', 12, 233, 10, 2, 2, 4, 9, 'SI', 225, 4, 14, '', 1, '2021-07-10 16:35:23'),
(749, '2021-07-09', 12, 227, 10, 2, 2, 8, 0, 'SI', 219, 4, 15, '', 1, '2021-07-10 16:36:50'),
(750, '2021-07-09', 12, 234, 10, 2, 2, 4, 9, 'SI', 226, 4, 14, '', 1, '2021-07-10 16:38:19'),
(751, '2021-07-09', 12, 125, 10, 2, 2, 4, 11, 'SI', 111, 13, 16, '', 1, '2021-07-10 16:39:02'),
(752, '2021-07-10', 10, 228, 8, 2, 2, 8, 0, 'SI', 227, 4, 14, '', 1, '2021-07-19 15:03:08'),
(753, '2021-07-10', 10, 215, 8, 2, 2, 2, 11, 'SI', 209, 4, 17, '', 1, '2021-07-19 15:04:02'),
(754, '2021-07-10', 10, 201, 8, 2, 2, 13, 9, 'SI', 192, 13, 17, '', 1, '2021-07-19 15:04:40'),
(755, '2021-07-10', 10, 235, 8, 2, 2, 4, 11, 'SI', 228, 13, 14, '', 1, '2021-07-19 15:07:14'),
(756, '2021-07-10', 10, 213, 8, 2, 2, 4, 11, 'SI', 206, 13, 17, '', 1, '2021-07-19 15:08:33'),
(757, '2021-07-10', 10, 230, 8, 2, 2, 4, 10, 'SI', 222, 13, 16, '', 1, '2021-07-19 15:09:18'),
(758, '2021-07-10', 10, 125, 8, 2, 2, 4, 10, 'SI', 111, 4, 16, '', 1, '2021-07-19 15:09:52'),
(759, '2021-07-10', 10, 207, 8, 2, 2, 13, 10, 'SI', 199, 4, 16, '', 1, '2021-07-19 15:10:31'),
(760, '2021-07-13', 10, 236, 8, 2, 2, 4, 9, 'SI', 229, 13, 14, '', 1, '2021-07-19 15:12:05'),
(761, '2021-07-13', 10, 201, 8, 2, 2, 4, 9, 'SI', 192, 13, 17, '', 1, '2021-07-19 15:12:41'),
(762, '2021-07-13', 10, 230, 8, 2, 2, 4, 11, 'SI', 222, 13, 17, '', 1, '2021-07-19 15:13:37'),
(763, '2021-07-13', 10, 215, 8, 2, 2, 2, 9, 'SI', 209, 4, 17, '', 1, '2021-07-19 15:14:35'),
(764, '2021-07-13', 10, 232, 8, 2, 2, 4, 9, 'SI', 224, 13, 14, '', 1, '2021-07-19 15:20:11'),
(765, '2021-07-13', 10, 234, 8, 2, 2, 4, 9, 'SI', 226, 4, 14, '', 1, '2021-07-19 15:20:53'),
(766, '2021-07-13', 10, 125, 8, 2, 2, 4, 11, 'SI', 111, 4, 17, '', 1, '2021-07-19 15:21:30'),
(767, '2021-07-13', 10, 237, 8, 2, 2, 4, 9, 'SI', 230, 4, 14, '', 1, '2021-07-19 15:23:15'),
(768, '2021-07-13', 10, 238, 8, 2, 2, 4, 9, 'SI', 231, 4, 14, '', 1, '2021-07-19 15:24:46'),
(769, '2021-07-14', 12, 234, 10, 2, 2, 4, 10, 'SI', 226, 4, 15, '', 1, '2021-07-19 15:33:08'),
(770, '2021-07-14', 12, 233, 10, 2, 2, 4, 10, 'SI', 225, 4, 15, '', 1, '2021-07-19 15:33:58'),
(771, '2021-07-14', 12, 237, 10, 2, 2, 4, 9, 'SI', 230, 4, 14, '', 1, '2021-07-19 15:35:16'),
(772, '2021-07-14', 12, 231, 10, 2, 2, 4, 10, 'SI', 223, 4, 15, '', 1, '2021-07-19 15:36:48'),
(773, '2021-07-14', 12, 239, 10, 2, 2, 4, 9, 'SI', 232, 4, 14, '', 1, '2021-07-19 15:38:37'),
(774, '2021-07-14', 12, 240, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-07-19 15:39:43'),
(775, '2021-07-14', 12, 241, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-07-19 15:40:11'),
(776, '2021-07-14', 12, 199, 10, 2, 2, 4, 9, 'SI', 190, 13, 14, '', 1, '2021-07-19 15:40:52'),
(777, '2021-07-16', 12, 242, 10, 2, 2, 13, 9, 'SI', 233, 4, 14, '', 1, '2021-07-19 15:44:09'),
(778, '2021-07-16', 12, 234, 10, 2, 2, 4, 11, 'SI', 226, 4, 16, '', 1, '2021-07-19 15:44:46'),
(779, '2021-07-16', 12, 217, 10, 2, 2, 13, 9, 'SI', 234, 13, 14, '', 1, '2021-07-19 15:46:30'),
(780, '2021-07-16', 12, 199, 10, 2, 2, 4, 10, 'SI', 190, 13, 15, '', 1, '2021-07-19 15:48:11'),
(781, '2021-07-16', 12, 236, 10, 2, 2, 13, 9, 'SI', 229, 13, 14, '', 1, '2021-07-19 15:49:01'),
(782, '2021-07-16', 12, 243, 10, 2, 2, 4, 9, 'SI', 235, 13, 14, '', 1, '2021-07-19 15:51:15'),
(783, '2021-07-16', 12, 239, 10, 2, 2, 4, 10, 'SI', 232, 4, 15, '', 1, '2021-07-19 15:51:59'),
(784, '2021-07-15', 10, 199, 8, 2, 2, 4, 9, 'SI', 236, 13, 14, '', 1, '2021-07-19 16:09:10'),
(785, '2021-07-15', 10, 233, 8, 2, 2, 4, 9, 'SI', 225, 4, 14, '', 1, '2021-07-19 16:09:48'),
(786, '2021-07-15', 10, 244, 8, 2, 2, 4, 9, 'SI', 237, 13, 14, '', 1, '2021-07-19 16:12:25'),
(787, '2021-07-15', 10, 237, 8, 2, 2, 4, 0, 'SI', 230, 4, 0, '', 1, '2021-07-19 16:13:00'),
(788, '2021-07-15', 10, 245, 8, 2, 2, 12, 0, 'SI', 238, 4, 14, '', 1, '2021-07-19 16:16:04'),
(789, '2021-07-15', 10, 246, 8, 2, 2, 4, 9, 'SI', 239, 13, 14, '', 1, '2021-07-19 16:18:18'),
(790, '2021-07-15', 10, 245, 8, 2, 2, 12, 0, 'SI', 240, 12, 14, '', 1, '2021-07-19 16:21:28'),
(791, '2021-07-15', 10, 236, 8, 2, 2, 4, 10, 'SI', 229, 13, 16, '', 1, '2021-07-19 16:22:48'),
(792, '2021-07-17', 10, 125, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-07-19 16:24:09'),
(793, '2021-07-17', 10, 236, 8, 2, 2, 4, 11, 'SI', 229, 13, 17, '', 1, '2021-07-19 16:25:02'),
(794, '2021-07-17', 10, 247, 8, 2, 2, 4, 9, 'SI', 241, 13, 14, '', 1, '2021-07-19 16:28:12'),
(795, '2021-07-17', 10, 248, 8, 2, 2, 13, 9, 'SI', 242, 4, 14, '', 1, '2021-07-19 16:29:53'),
(796, '2021-07-17', 10, 75, 8, 3, 2, 5, 14, 'NO', 0, 0, 0, '', 1, '2021-07-19 16:31:16'),
(797, '2021-07-17', 10, 244, 8, 2, 2, 4, 10, 'SI', 237, 13, 16, '', 1, '2021-07-19 16:32:39'),
(798, '2021-07-17', 10, 237, 8, 2, 2, 4, 10, 'SI', 230, 4, 17, '', 1, '2021-07-19 16:33:26'),
(799, '2021-07-17', 10, 231, 8, 2, 2, 4, 9, 'SI', 223, 4, 14, '', 1, '2021-07-19 16:35:05'),
(800, '2021-07-17', 10, 199, 8, 2, 2, 4, 9, 'SI', 236, 13, 16, '', 1, '2021-07-19 16:36:30'),
(801, '2021-07-19', 12, 242, 10, 2, 2, 13, 10, 'SI', 233, 4, 15, '', 1, '2021-07-20 19:05:53'),
(802, '2021-07-19', 12, 199, 10, 2, 2, 4, 11, 'SI', 190, 13, 16, '', 1, '2021-07-20 19:07:08'),
(803, '2021-07-19', 12, 249, 10, 2, 2, 13, 9, 'SI', 243, 4, 14, '', 1, '2021-07-20 19:09:27'),
(804, '2021-07-19', 12, 250, 10, 2, 2, 8, 9, 'SI', 244, 4, 14, '', 1, '2021-07-20 19:11:30'),
(805, '2021-07-19', 12, 243, 10, 2, 2, 4, 10, 'SI', 235, 13, 15, '', 1, '2021-07-20 19:12:11'),
(806, '2021-07-19', 12, 248, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-07-20 19:12:50'),
(807, '2021-07-19', 12, 251, 10, 2, 2, 4, 9, 'SI', 245, 13, 14, '', 1, '2021-07-20 19:15:11'),
(808, '2021-07-19', 12, 252, 10, 2, 2, 4, 9, 'SI', 246, 4, 14, '', 1, '2021-07-20 19:18:03'),
(809, '2021-07-19', 12, 253, 10, 2, 2, 4, 9, 'SI', 247, 13, 14, '', 1, '2021-07-20 19:27:10'),
(810, '2021-07-20', 10, 254, 8, 1, 2, 8, 0, 'SI', 248, 12, 0, '', 1, '2021-07-21 15:58:27'),
(811, '2021-07-20', 10, 221, 8, 1, 2, 9, 0, 'SI', 251, 12, 14, '', 1, '2021-07-21 16:00:17'),
(812, '2021-07-20', 10, 208, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-07-21 16:03:29'),
(813, '2021-07-20', 10, 188, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-07-21 16:03:51'),
(814, '2021-07-20', 10, 236, 8, 2, 2, 4, 11, 'SI', 229, 13, 17, '', 1, '2021-07-21 16:04:34'),
(815, '2021-07-20', 10, 199, 8, 2, 2, 4, 11, 'SI', 236, 13, 17, '', 1, '2021-07-21 16:05:54'),
(816, '2021-07-20', 10, 255, 8, 2, 2, 2, 9, 'NO', 0, 0, 0, '', 1, '2021-07-21 16:06:54'),
(817, '2021-07-20', 10, 256, 8, 2, 2, 2, 9, 'SI', 249, 13, 14, '', 1, '2021-07-21 16:08:22'),
(818, '2021-07-20', 10, 257, 8, 2, 2, 4, 9, 'SI', 250, 13, 9, '', 1, '2021-07-21 16:09:28'),
(819, '2021-07-20', 10, 249, 8, 2, 2, 4, 9, 'SI', 243, 13, 14, '', 1, '2021-07-21 16:10:24'),
(820, '2021-07-21', 12, 243, 10, 2, 2, 4, 11, 'SI', 235, 13, 16, '', 1, '2021-07-22 05:59:44'),
(821, '2021-07-21', 12, 258, 10, 2, 2, 3, 9, 'SI', 252, 4, 14, '', 1, '2021-07-22 06:03:53'),
(822, '2021-07-21', 12, 259, 10, 2, 2, 13, 9, 'SI', 253, 13, 14, '', 1, '2021-07-22 06:05:23'),
(823, '2021-07-21', 12, 260, 10, 2, 2, 4, 9, 'SI', 254, 13, 14, '', 1, '2021-07-22 06:07:00'),
(824, '2021-07-21', 12, 249, 10, 2, 2, 13, 10, 'SI', 243, 4, 15, '', 1, '2021-07-22 06:08:08'),
(825, '2021-07-21', 12, 252, 10, 2, 2, 4, 10, 'SI', 246, 4, 15, '', 1, '2021-07-22 06:09:03'),
(826, '2021-07-21', 12, 261, 10, 2, 2, 4, 9, 'SI', 255, 4, 14, '', 1, '2021-07-22 06:10:36'),
(827, '2021-07-21', 12, 256, 10, 2, 2, 2, 9, 'SI', 249, 13, 14, '', 1, '2021-07-22 06:11:25'),
(828, '2021-07-22', 10, 248, 8, 2, 2, 4, 10, 'SI', 242, 4, 16, '', 1, '2021-07-23 00:17:56'),
(829, '2021-07-22', 10, 236, 8, 2, 2, 4, 11, 'SI', 229, 13, 17, '', 1, '2021-07-23 00:20:20'),
(830, '2021-07-22', 10, 258, 8, 2, 2, 4, 9, 'SI', 256, 4, 14, '', 1, '2021-07-23 00:26:47'),
(831, '2021-07-22', 10, 257, 8, 2, 2, 4, 10, 'SI', 250, 13, 16, '', 1, '2021-07-23 00:28:33'),
(832, '2021-07-22', 10, 59, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-07-23 00:29:52'),
(833, '2021-07-22', 10, 256, 8, 2, 2, 2, 10, 'SI', 249, 13, 16, '', 1, '2021-07-23 00:33:12'),
(834, '2021-07-22', 10, 261, 8, 2, 2, 4, 9, 'SI', 255, 4, 14, '', 1, '2021-07-23 00:36:06'),
(835, '2021-07-22', 10, 255, 8, 2, 2, 2, 10, 'SI', 257, 4, 14, '', 1, '2021-07-23 00:44:40'),
(836, '2021-07-22', 10, 262, 8, 2, 2, 4, 9, 'SI', 258, 13, 14, '', 1, '2021-07-23 01:05:23'),
(837, '2021-07-23', 12, 249, 10, 2, 2, 13, 11, 'SI', 243, 4, 16, '', 1, '2021-07-23 18:53:06'),
(838, '2021-07-23', 12, 259, 10, 2, 2, 4, 10, 'SI', 253, 13, 15, '', 1, '2021-07-23 18:54:13'),
(839, '2021-07-23', 12, 260, 10, 2, 2, 4, 10, 'SI', 254, 13, 15, '', 1, '2021-07-23 18:55:11'),
(840, '2021-07-23', 12, 258, 10, 2, 2, 4, 10, 'SI', 252, 4, 15, '', 1, '2021-07-23 18:56:14'),
(841, '2021-07-23', 12, 252, 10, 2, 2, 4, 11, 'SI', 246, 4, 16, '', 1, '2021-07-23 23:06:57'),
(842, '2021-07-23', 12, 263, 10, 2, 1, 4, 9, 'SI', 259, 13, 14, '', 1, '2021-07-23 23:14:51'),
(843, '2021-07-23', 12, 261, 10, 2, 2, 4, 10, 'SI', 255, 13, 15, '', 1, '2021-07-23 23:16:32'),
(844, '2021-07-24', 10, 205, 8, 1, 2, 8, 0, 'SI', 197, 12, 14, '', 1, '2021-07-24 23:47:47'),
(845, '2021-07-24', 10, 237, 8, 1, 2, 8, 0, 'SI', 230, 12, 14, '', 1, '2021-07-24 23:49:01'),
(846, '2021-07-24', 10, 132, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-07-24 23:50:10'),
(847, '2021-07-24', 10, 135, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-07-24 23:54:04'),
(848, '2021-07-24', 10, 126, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-07-24 23:54:44'),
(849, '2021-07-24', 10, 75, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-07-24 23:55:46'),
(850, '2021-07-24', 10, 258, 8, 2, 2, 4, 10, 'SI', 256, 4, 16, '', 1, '2021-07-25 00:00:21'),
(851, '2021-07-24', 10, 264, 8, 2, 2, 4, 9, 'SI', 260, 4, 14, '', 1, '2021-07-25 00:01:27'),
(852, '2021-07-24', 10, 257, 8, 2, 2, 4, 11, 'SI', 250, 13, 17, '', 1, '2021-07-25 00:06:57'),
(853, '2021-07-24', 10, 265, 8, 2, 2, 4, 9, 'SI', 261, 13, 14, '', 1, '2021-07-25 00:16:28'),
(854, '2021-07-24', 10, 243, 8, 2, 2, 13, 10, 'SI', 235, 13, 16, '', 1, '2021-07-25 00:17:49'),
(855, '2021-07-24', 10, 262, 8, 2, 2, 4, 10, 'SI', 258, 13, 16, '', 1, '2021-07-25 00:19:51'),
(856, '2021-07-24', 10, 249, 8, 2, 2, 4, 10, 'SI', 243, 13, 16, '', 1, '2021-07-25 00:21:08'),
(857, '2021-07-26', 12, 196, 10, 2, 2, 13, 9, 'SI', 185, 13, 14, '', 1, '2021-07-26 23:33:18'),
(858, '2021-07-26', 12, 267, 10, 2, 1, 4, 9, 'SI', 263, 13, 14, '', 1, '2021-07-26 23:35:47'),
(859, '2021-07-26', 12, 268, 10, 2, 1, 2, 9, 'SI', 264, 13, 14, '', 1, '2021-07-26 23:37:50'),
(860, '2021-07-26', 12, 266, 10, 2, 2, 4, 9, 'SI', 265, 13, 14, '', 1, '2021-07-26 23:40:31'),
(861, '2021-07-26', 12, 269, 10, 2, 1, 4, 9, 'SI', 266, 13, 14, '', 1, '2021-07-26 23:42:29'),
(862, '2021-07-26', 12, 262, 10, 2, 2, 4, 9, 'SI', 258, 13, 14, '', 1, '2021-07-26 23:43:06'),
(863, '2021-07-27', 10, 268, 8, 2, 2, 2, 9, 'SI', 264, 13, 14, '', 1, '2021-07-28 00:04:26'),
(864, '2021-07-27', 10, 266, 8, 2, 2, 4, 9, 'SI', 265, 13, 14, '', 1, '2021-07-28 00:06:55'),
(865, '2021-07-27', 10, 199, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-07-28 00:09:03'),
(866, '2021-07-27', 10, 269, 8, 2, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-07-28 00:11:40'),
(867, '2021-07-27', 10, 265, 8, 2, 2, 4, 10, 'SI', 261, 4, 16, '', 1, '2021-07-28 00:22:29'),
(868, '2021-07-27', 10, 261, 8, 2, 2, 4, 10, 'SI', 255, 4, 16, '', 1, '2021-07-28 00:24:52'),
(869, '2021-07-27', 10, 270, 8, 2, 2, 4, 9, 'SI', 267, 4, 14, '', 1, '2021-07-28 00:41:22'),
(870, '2021-07-30', 12, 196, 10, 2, 2, 13, 10, 'SI', 185, 13, 15, '', 1, '2021-07-30 23:54:22'),
(871, '2021-07-30', 12, 267, 10, 2, 2, 4, 10, 'SI', 263, 13, 15, '', 1, '2021-07-30 23:54:56'),
(872, '2021-07-30', 12, 266, 10, 2, 2, 8, 10, 'SI', 265, 4, 15, '', 1, '2021-07-30 23:55:41'),
(873, '2021-07-30', 12, 248, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, '', 1, '2021-07-30 23:56:12'),
(874, '2021-07-30', 12, 271, 10, 2, 1, 4, 9, 'SI', 268, 4, 14, '', 1, '2021-07-30 23:58:35'),
(875, '2021-07-30', 12, 272, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-07-30 23:59:33'),
(876, '2021-07-30', 12, 265, 10, 2, 2, 13, 9, 'SI', 261, 13, 14, '', 1, '2021-07-31 00:01:04'),
(877, '2021-07-31', 12, 271, 10, 2, 2, 4, 10, 'SI', 268, 4, 15, '', 1, '2021-07-31 17:26:40'),
(878, '2021-07-31', 12, 196, 10, 2, 2, 13, 11, 'SI', 185, 16, 13, '', 1, '2021-07-31 17:27:37'),
(879, '2021-07-31', 12, 272, 10, 2, 2, 4, 10, 'SI', 269, 13, 15, '', 1, '2021-07-31 17:30:36'),
(880, '2021-07-31', 10, 265, 8, 2, 2, 13, 11, 'SI', 261, 4, 17, '', 1, '2021-07-31 17:42:08'),
(881, '2021-07-31', 10, 268, 8, 2, 2, 2, 10, 'SI', 264, 13, 16, '', 1, '2021-07-31 17:44:18'),
(882, '2021-07-31', 10, 249, 8, 2, 2, 4, 11, 'SI', 243, 13, 17, '', 1, '2021-07-31 17:46:04'),
(883, '2021-07-31', 10, 258, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-07-31 17:47:57'),
(884, '2021-08-02', 12, 273, 10, 2, 1, 4, 9, 'SI', 270, 4, 14, '', 1, '2021-08-02 23:39:24'),
(885, '2021-08-02', 12, 271, 10, 2, 1, 4, 11, 'SI', 268, 13, 16, '', 1, '2021-08-02 23:40:29'),
(886, '2021-08-02', 12, 240, 10, 2, 2, 4, 9, 'SI', 271, 13, 14, '', 1, '2021-08-02 23:47:52'),
(887, '2021-08-02', 12, 272, 10, 2, 2, 4, 11, 'SI', 269, 13, 16, '', 1, '2021-08-02 23:48:44'),
(888, '2021-08-02', 12, 248, 10, 2, 2, 13, 11, 'NO', 0, 0, 0, '', 1, '2021-08-02 23:50:56'),
(889, '2021-08-02', 12, 275, 10, 2, 1, 13, 9, 'SI', 273, 13, 14, '', 1, '2021-08-02 23:52:55'),
(890, '2021-08-03', 10, 273, 8, 2, 2, 4, 9, 'SI', 270, 13, 14, '', 1, '2021-08-04 00:25:24'),
(891, '2021-08-03', 10, 271, 8, 2, 2, 4, 9, 'SI', 274, 4, 14, '', 1, '2021-08-04 00:29:13'),
(892, '2021-08-03', 10, 249, 8, 2, 2, 4, 11, 'SI', 243, 13, 17, '', 1, '2021-08-04 00:30:31'),
(893, '2021-08-03', 10, 268, 8, 2, 2, 2, 11, 'SI', 275, 4, 14, '', 1, '2021-08-04 00:35:07'),
(894, '2021-08-03', 10, 267, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-04 00:37:48'),
(895, '2021-08-03', 10, 276, 8, 2, 2, 4, 9, 'SI', 276, 4, 14, '', 1, '2021-08-04 00:40:34'),
(896, '2021-08-03', 10, 240, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-04 00:41:23'),
(897, '2021-08-03', 10, 196, 8, 3, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-04 00:42:22'),
(898, '2021-08-03', 10, 265, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-04 00:43:09'),
(899, '2021-08-04', 12, 275, 10, 2, 2, 13, 10, 'SI', 273, 13, 15, '', 1, '2021-08-04 19:31:03'),
(900, '2021-08-04', 12, 274, 10, 2, 2, 4, 10, 'SI', 272, 13, 15, '', 1, '2021-08-04 19:33:22'),
(901, '2021-08-04', 12, 267, 10, 2, 2, 4, 11, 'SI', 263, 13, 16, '', 1, '2021-08-04 19:35:02'),
(902, '2021-08-04', 12, 276, 10, 2, 2, 4, 9, 'SI', 276, 4, 14, '', 1, '2021-08-04 19:39:23'),
(903, '2021-08-04', 12, 277, 10, 2, 1, 4, 9, 'SI', 277, 13, 14, '', 1, '2021-08-04 23:35:03'),
(904, '2021-08-04', 12, 279, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-08-04 23:37:10'),
(905, '2021-08-05', 10, 278, 8, 2, 2, 4, 9, 'SI', 278, 13, 14, '', 1, '2021-08-06 00:04:06'),
(906, '2021-08-05', 10, 277, 8, 2, 2, 9, 0, 'SI', 277, 13, 14, '', 1, '2021-08-06 00:05:21'),
(907, '2021-08-05', 10, 268, 8, 2, 2, 2, 11, 'SI', 275, 4, 17, '', 1, '2021-08-06 00:06:34'),
(908, '2021-08-05', 10, 280, 8, 2, 2, 4, 9, 'SI', 279, 4, 14, '', 1, '2021-08-06 00:31:38'),
(909, '2021-08-05', 10, 281, 8, 2, 2, 4, 0, 'SI', 280, 4, 14, '', 1, '2021-08-06 00:36:38'),
(910, '2021-08-05', 10, 274, 8, 2, 2, 4, 9, 'SI', 272, 13, 14, '', 1, '2021-08-06 00:37:56'),
(911, '2021-08-05', 10, 213, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-06 00:39:58'),
(912, '2021-08-05', 10, 249, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-06 00:41:56'),
(913, '2021-08-05', 10, 211, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-06 00:45:04'),
(914, '2021-08-05', 10, 125, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-06 00:50:10'),
(915, '2021-08-06', 12, 268, 10, 2, 2, 2, 10, 'SI', 264, 13, 15, '', 1, '2021-08-06 23:27:26'),
(916, '2021-08-06', 12, 275, 10, 2, 2, 13, 11, 'SI', 273, 13, 16, '', 1, '2021-08-06 23:28:11'),
(917, '2021-08-06', 12, 278, 10, 2, 2, 4, 10, 'SI', 278, 4, 15, '', 1, '2021-08-06 23:28:46'),
(918, '2021-08-06', 12, 274, 10, 2, 2, 4, 11, 'SI', 272, 13, 16, '', 1, '2021-08-06 23:31:15'),
(919, '2021-08-06', 12, 282, 10, 2, 1, 13, 9, 'SI', 281, 4, 14, '', 1, '2021-08-06 23:34:48'),
(920, '2021-08-06', 12, 281, 10, 2, 2, 4, 9, 'SI', 280, 13, 14, '', 1, '2021-08-06 23:36:30'),
(921, '2021-08-07', 10, 283, 8, 2, 2, 4, 9, 'SI', 282, 13, 14, '', 1, '2021-08-07 23:55:52'),
(922, '2021-08-07', 10, 281, 8, 2, 2, 4, 10, 'SI', 280, 4, 15, '', 1, '2021-08-07 23:56:53'),
(923, '2021-08-07', 10, 278, 8, 2, 2, 4, 10, 'SI', 278, 13, 15, '', 1, '2021-08-08 00:04:02'),
(924, '2021-08-07', 10, 282, 8, 2, 2, 4, 9, 'SI', 281, 4, 14, '', 1, '2021-08-08 00:15:59'),
(925, '2021-08-07', 10, 274, 8, 2, 2, 4, 10, 'SI', 272, 13, 15, '', 1, '2021-08-08 00:17:40'),
(926, '2021-08-07', 10, 236, 8, 2, 2, 4, 11, 'SI', 229, 13, 17, '', 1, '2021-08-08 00:18:45'),
(927, '2021-08-07', 10, 209, 8, 2, 2, 3, 9, 'SI', 283, 13, 14, '', 1, '2021-08-08 00:53:02'),
(928, '2021-08-09', 12, 284, 10, 2, 1, 13, 9, 'SI', 284, 4, 14, '', 1, '2021-08-09 23:54:06'),
(929, '2021-08-09', 12, 282, 10, 2, 2, 13, 10, 'SI', 281, 4, 15, '', 1, '2021-08-09 23:54:44'),
(930, '2021-08-09', 12, 268, 10, 2, 2, 2, 11, 'SI', 264, 13, 16, '', 1, '2021-08-09 23:55:26'),
(931, '2021-08-09', 12, 285, 10, 2, 1, 13, 9, 'SI', 285, 14, 13, '', 1, '2021-08-09 23:57:06'),
(932, '2021-08-09', 12, 209, 10, 2, 1, 4, 9, 'SI', 202, 13, 14, '', 1, '2021-08-09 23:59:02'),
(933, '2021-08-09', 12, 278, 10, 2, 2, 4, 11, 'SI', 278, 4, 16, '', 1, '2021-08-09 23:59:33'),
(934, '2021-08-09', 12, 281, 10, 2, 2, 4, 10, 'SI', 280, 13, 15, '', 1, '2021-08-10 00:00:53'),
(935, '2021-08-10', 10, 209, 8, 2, 2, 3, 10, 'SI', 283, 13, 15, '', 1, '2021-08-11 00:00:53'),
(936, '2021-08-10', 10, 278, 8, 2, 2, 4, 9, 'SI', 278, 13, 16, '', 1, '2021-08-11 00:02:11'),
(937, '2021-08-10', 10, 281, 8, 2, 2, 4, 10, 'SI', 280, 4, 15, '', 1, '2021-08-11 00:05:37'),
(938, '2021-08-10', 10, 271, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-11 00:06:42'),
(939, '2021-08-10', 10, 275, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-11 00:07:29'),
(940, '2021-08-10', 10, 286, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-11 00:16:32'),
(941, '2021-08-10', 10, 287, 8, 2, 2, 4, 9, 'SI', 286, 13, 14, '', 1, '2021-08-11 00:17:48'),
(942, '2021-08-10', 10, 274, 8, 2, 2, 4, 11, 'SI', 272, 13, 16, '', 1, '2021-08-11 00:19:01'),
(943, '2021-08-10', 10, 284, 8, 2, 2, 4, 9, 'SI', 284, 4, 14, '', 1, '2021-08-11 00:20:18'),
(944, '2021-08-10', 12, 282, 10, 2, 2, 13, 11, 'SI', 281, 4, 16, '', 1, '2021-08-11 19:32:57'),
(945, '2021-08-11', 12, 281, 10, 2, 2, 4, 11, 'SI', 280, 13, 16, '', 1, '2021-08-11 19:33:49'),
(946, '2021-08-11', 12, 209, 10, 2, 2, 4, 11, 'SI', 202, 13, 16, '', 1, '2021-08-11 19:35:51'),
(947, '2021-08-11', 12, 285, 10, 2, 2, 13, 10, 'SI', 285, 13, 15, '', 1, '2021-08-11 23:23:11'),
(948, '2021-08-11', 12, 284, 10, 2, 2, 13, 10, 'SI', 284, 4, 15, '', 1, '2021-08-11 23:23:50'),
(949, '2021-08-11', 12, 220, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-11 23:24:49'),
(950, '2021-08-11', 12, 249, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-11 23:25:11'),
(951, '2021-08-12', 10, 209, 8, 2, 2, 3, 11, 'SI', 283, 13, 16, '', 1, '2021-08-13 00:23:32'),
(952, '2021-08-12', 10, 236, 8, 2, 2, 4, 11, 'SI', 229, 13, 17, '', 1, '2021-08-13 00:30:40'),
(953, '2021-08-12', 10, 282, 8, 2, 2, 4, 10, 'SI', 281, 4, 15, '', 1, '2021-08-13 00:32:03'),
(954, '2021-08-12', 10, 288, 8, 2, 2, 4, 9, 'SI', 287, 4, 14, '', 1, '2021-08-13 00:49:29'),
(955, '2021-08-12', 10, 289, 8, 2, 3, 4, 9, 'SI', 288, 13, 14, '', 1, '2021-08-13 00:50:44'),
(956, '2021-08-12', 10, 126, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-13 00:59:12'),
(957, '2021-08-12', 10, 208, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-13 00:59:57'),
(958, '2021-08-12', 10, 275, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 01:00:46'),
(959, '2021-08-12', 10, 276, 8, 2, 2, 8, 0, 'SI', 276, 4, 15, '', 1, '2021-08-13 01:02:34'),
(960, '2021-08-13', 12, 285, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:16:03'),
(961, '2021-08-13', 12, 233, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:16:25'),
(962, '2021-08-13', 12, 178, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:16:48'),
(963, '2021-08-13', 12, 240, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:17:16'),
(964, '2021-08-13', 12, 278, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:17:41'),
(965, '2021-08-13', 12, 274, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:18:09'),
(966, '2021-08-13', 12, 272, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:18:44'),
(967, '2021-08-13', 12, 260, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:19:12'),
(968, '2021-08-13', 12, 290, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:20:10'),
(969, '2021-08-13', 12, 291, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-13 23:21:18'),
(970, '2021-08-13', 12, 292, 10, 2, 1, 4, 9, 'SI', 289, 13, 14, '', 1, '2021-08-13 23:23:04'),
(971, '2021-08-14', 10, 281, 8, 2, 2, 4, 11, 'SI', 280, 4, 17, '', 1, '2021-08-15 00:19:57'),
(972, '2021-08-14', 10, 282, 8, 2, 2, 4, 11, 'SI', 281, 4, 16, '', 1, '2021-08-15 00:21:53'),
(973, '2021-08-14', 10, 290, 8, 2, 2, 13, 9, 'SI', 290, 13, 14, '', 1, '2021-08-15 00:27:12'),
(974, '2021-08-14', 10, 210, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-15 00:28:10'),
(975, '2021-08-14', 10, 236, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-15 00:28:49'),
(976, '2021-08-14', 10, 292, 8, 2, 2, 4, 9, 'SI', 289, 13, 14, '', 1, '2021-08-15 00:30:42'),
(977, '2021-08-14', 10, 291, 8, 2, 2, 4, 9, 'SI', 291, 13, 14, '', 1, '2021-08-15 00:34:22'),
(978, '2021-08-14', 10, 293, 8, 2, 2, 4, 0, 'SI', 292, 13, 14, '', 1, '2021-08-15 00:41:22'),
(979, '2021-08-14', 10, 209, 8, 3, 2, 3, 14, 'NO', 0, 0, 0, '', 1, '2021-08-15 00:42:24'),
(980, '2021-08-14', 10, 265, 8, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-15 00:43:37'),
(981, '2021-08-16', 12, 291, 10, 2, 2, 4, 10, 'SI', 293, 13, 14, '', 1, '2021-08-16 23:25:02'),
(982, '2021-08-16', 12, 292, 10, 2, 2, 4, 10, 'SI', 289, 13, 15, '', 1, '2021-08-16 23:27:24'),
(983, '2021-08-16', 12, 294, 10, 2, 1, 13, 9, 'SI', 294, 4, 14, '', 1, '2021-08-16 23:30:02'),
(984, '2021-08-16', 12, 262, 10, 3, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-08-16 23:30:37'),
(985, '2021-08-16', 12, 259, 10, 3, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-16 23:31:01'),
(986, '2021-08-16', 12, 295, 10, 2, 1, 4, 9, 'SI', 295, 13, 14, '', 1, '2021-08-16 23:36:12'),
(987, '2021-08-16', 12, 296, 10, 2, 1, 4, 9, 'SI', 296, 4, 14, '', 1, '2021-08-16 23:38:34'),
(988, '2021-08-17', 10, 282, 8, 2, 2, 4, 11, 'SI', 281, 4, 17, '', 1, '2021-08-17 23:49:06'),
(989, '2021-08-17', 10, 281, 8, 2, 2, 4, 11, 'SI', 280, 4, 17, '', 1, '2021-08-17 23:51:31'),
(990, '2021-08-17', 10, 295, 8, 2, 2, 4, 9, 'SI', 295, 13, 14, '', 1, '2021-08-17 23:54:35'),
(991, '2021-08-17', 10, 196, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-17 23:55:49'),
(992, '2021-08-17', 10, 214, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-17 23:57:23'),
(993, '2021-08-17', 10, 59, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-17 23:58:07'),
(994, '2021-08-17', 10, 179, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-17 23:59:28'),
(995, '2021-08-17', 10, 125, 8, 3, 2, 6, 16, 'NO', 0, 0, 0, '', 1, '2021-08-18 00:00:57'),
(996, '2021-08-17', 10, 268, 8, 3, 2, 2, 14, 'NO', 0, 0, 0, '', 1, '2021-08-18 00:01:57'),
(997, '2021-08-17', 10, 243, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-18 00:02:49'),
(998, '2021-08-17', 10, 292, 8, 2, 2, 4, 10, 'SI', 289, 13, 15, '', 1, '2021-08-18 00:05:01'),
(999, '2021-08-17', 10, 294, 8, 2, 2, 13, 9, 'SI', 294, 13, 14, '', 1, '2021-08-18 00:16:24'),
(1000, '2021-08-18', 12, 291, 10, 2, 2, 4, 11, 'SI', 293, 13, 15, '', 1, '2021-08-18 18:32:31'),
(1001, '2021-08-18', 12, 295, 10, 2, 2, 4, 10, 'SI', 295, 13, 15, '', 1, '2021-08-18 18:34:38'),
(1002, '2021-08-18', 12, 292, 10, 2, 2, 4, 11, 'SI', 289, 4, 16, '', 1, '2021-08-18 18:35:49'),
(1003, '2021-08-18', 12, 217, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-18 18:37:08'),
(1004, '2021-08-18', 12, 211, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-18 18:37:42'),
(1005, '2021-08-18', 12, 207, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-18 23:20:23'),
(1006, '2021-08-18', 12, 210, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-18 23:20:54'),
(1007, '2021-08-18', 12, 220, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-18 23:21:28'),
(1008, '2021-08-18', 12, 249, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-18 23:21:56'),
(1009, '2021-08-19', 10, 295, 8, 2, 2, 4, 10, 'SI', 295, 4, 15, '', 1, '2021-08-19 23:42:26'),
(1010, '2021-08-19', 10, 291, 8, 2, 2, 4, 9, 'SI', 291, 13, 15, '', 1, '2021-08-19 23:44:20'),
(1011, '2021-08-19', 10, 282, 8, 2, 2, 4, 11, 'SI', 281, 4, 17, '', 1, '2021-08-19 23:45:52'),
(1012, '2021-08-19', 10, 281, 8, 2, 2, 4, 11, 'SI', 280, 4, 17, '', 1, '2021-08-19 23:58:40'),
(1013, '2021-08-19', 10, 292, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-08-20 00:00:26'),
(1014, '2021-08-19', 10, 213, 8, 3, 2, 6, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 00:01:34'),
(1015, '2021-08-19', 10, 59, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 00:02:41'),
(1016, '2021-08-19', 10, 75, 8, 3, 2, 6, 16, 'NO', 0, 0, 0, '', 1, '2021-08-20 00:03:23'),
(1017, '2021-08-19', 10, 205, 8, 1, 2, 8, 0, 'SI', 197, 12, 15, '', 1, '2021-08-20 00:12:34'),
(1018, '2021-08-20', 12, 242, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-20 19:37:06'),
(1019, '2021-08-20', 12, 295, 10, 2, 2, 4, 11, 'SI', 295, 13, 16, '', 1, '2021-08-20 19:37:42'),
(1020, '2021-08-20', 12, 240, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 19:38:20'),
(1021, '2021-08-20', 12, 278, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 19:38:57'),
(1022, '2021-08-20', 12, 274, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 19:39:21'),
(1023, '2021-08-20', 12, 272, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 22:43:32'),
(1024, '2021-08-20', 12, 260, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 22:43:57'),
(1025, '2021-08-20', 12, 285, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 22:44:20'),
(1026, '2021-08-20', 12, 233, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 22:44:41'),
(1027, '2021-08-20', 12, 178, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-20 22:45:07'),
(1028, '2021-08-21', 10, 289, 8, 1, 2, 8, 0, 'SI', 288, 12, 14, '', 1, '2021-08-21 23:27:05'),
(1029, '2021-08-21', 10, 293, 8, 1, 2, 8, 0, 'SI', 292, 12, 9, '', 1, '2021-08-21 23:28:53'),
(1030, '2021-08-21', 10, 280, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-21 23:31:04'),
(1031, '2021-08-21', 10, 268, 8, 3, 2, 2, 15, 'NO', 0, 0, 0, '', 1, '2021-08-21 23:32:43'),
(1032, '2021-08-21', 10, 291, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-08-21 23:33:51'),
(1033, '2021-08-21', 10, 295, 8, 2, 2, 4, 11, 'SI', 295, 4, 16, '', 1, '2021-08-21 23:36:48'),
(1034, '2021-08-21', 10, 264, 8, 2, 2, 4, 9, 'SI', 260, 13, 14, '', 1, '2021-08-21 23:38:07'),
(1035, '2021-08-21', 10, 292, 8, 2, 2, 4, 9, 'SI', 297, 4, 14, '', 1, '2021-08-21 23:45:08'),
(1036, '2021-08-23', 12, 297, 10, 2, 1, 13, 9, 'SI', 298, 4, 14, '', 1, '2021-08-23 19:32:45'),
(1037, '2021-08-23', 12, 288, 10, 2, 1, 13, 9, 'SI', 287, 13, 14, '', 1, '2021-08-23 19:33:43'),
(1038, '2021-08-23', 12, 264, 10, 2, 1, 4, 9, 'SI', 260, 13, 14, '', 1, '2021-08-23 19:34:32'),
(1039, '2021-08-23', 12, 298, 10, 2, 1, 4, 9, 'SI', 299, 13, 14, '', 1, '2021-08-23 23:50:15'),
(1040, '2021-08-23', 12, 211, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-23 23:50:49'),
(1041, '2021-08-23', 12, 217, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-23 23:51:13'),
(1042, '2021-08-23', 12, 207, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-23 23:51:43'),
(1043, '2021-08-23', 12, 210, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-23 23:52:06'),
(1044, '2021-08-24', 10, 295, 8, 2, 2, 4, 11, 'SI', 295, 4, 16, '', 1, '2021-08-25 00:07:12'),
(1045, '2021-08-24', 10, 288, 8, 2, 2, 13, 10, 'SI', 287, 4, 14, '', 1, '2021-08-25 00:10:49'),
(1046, '2021-08-24', 10, 291, 8, 2, 2, 4, 11, 'SI', 291, 13, 17, '', 1, '2021-08-25 00:12:22'),
(1047, '2021-08-24', 10, 299, 8, 2, 2, 4, 9, 'SI', 300, 9, 14, '', 1, '2021-08-25 00:16:58'),
(1048, '2021-08-24', 10, 179, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-25 00:17:49'),
(1049, '2021-08-24', 10, 285, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-25 00:18:32'),
(1050, '2021-08-24', 10, 264, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-25 00:19:12'),
(1051, '2021-08-25', 12, 264, 10, 2, 2, 4, 10, 'SI', 260, 13, 15, '', 1, '2021-08-25 19:22:13'),
(1052, '2021-08-25', 12, 298, 10, 2, 2, 8, 10, 'SI', 299, 4, 15, '', 1, '2021-08-25 19:25:18'),
(1053, '2021-08-25', 12, 288, 10, 2, 2, 13, 16, 'SI', 287, 13, 15, '', 1, '2021-08-25 19:25:55'),
(1054, '2021-08-25', 12, 220, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 2, '2021-08-25 19:27:26'),
(1055, '2021-08-25', 12, 249, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 2, '2021-08-25 19:28:58'),
(1056, '2021-08-25', 12, 240, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 2, '2021-08-25 19:29:36'),
(1057, '2021-08-25', 12, 278, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-25 19:30:59'),
(1058, '2021-08-25', 12, 240, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-25 19:31:54'),
(1059, '2021-08-25', 12, 249, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-25 19:32:23'),
(1060, '2021-08-25', 12, 220, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-25 19:32:53'),
(1061, '2021-08-25', 12, 272, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-25 19:33:20'),
(1062, '2021-08-25', 12, 260, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-08-25 19:33:44'),
(1063, '2021-08-25', 12, 300, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-08-25 23:23:07'),
(1064, '2021-08-26', 10, 295, 8, 2, 2, 13, 11, 'SI', 295, 13, 17, '', 1, '2021-08-27 00:04:42'),
(1065, '2021-08-26', 10, 284, 8, 2, 2, 13, 9, 'SI', 284, 13, 14, '', 1, '2021-08-27 00:05:39'),
(1066, '2021-08-26', 10, 291, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-27 00:06:19'),
(1067, '2021-08-26', 10, 292, 8, 1, 2, 8, 0, 'SI', 297, 12, 14, '', 1, '2021-08-27 00:07:15'),
(1068, '2021-08-26', 10, 292, 8, 1, 2, 8, 0, 'SI', 289, 12, 14, '', 1, '2021-08-27 00:07:56'),
(1069, '2021-08-26', 10, 286, 8, 1, 2, 8, 0, 'SI', 301, 12, 14, '', 1, '2021-08-27 00:10:32'),
(1070, '2021-08-26', 10, 301, 8, 2, 2, 2, 9, 'SI', 302, 13, 14, '', 1, '2021-08-27 00:16:40'),
(1071, '2021-08-26', 10, 302, 8, 2, 2, 13, 9, 'SI', 303, 13, 14, '', 1, '2021-08-27 00:17:43'),
(1072, '2021-08-26', 10, 282, 8, 2, 2, 13, 11, 'SI', 281, 4, 17, '', 1, '2021-08-27 00:19:56'),
(1073, '2021-08-27', 14, 213, 11, 3, 2, 7, 18, 'NO', 0, 0, 0, 'SE BRINDO ATENCION PSIQUIATRICA POR TELEATIENDO, SE INDICO TRATAMIENTO PSICOFARMACOLOGICO Y CONTROL EN 30 DIAS.', 1, '2021-08-27 15:37:09'),
(1074, '2021-08-27', 12, 284, 10, 2, 1, 13, 9, 'SI', 284, 4, 14, '', 1, '2021-08-27 20:11:27'),
(1075, '2021-08-27', 12, 264, 10, 2, 2, 4, 11, 'SI', 260, 13, 16, '', 1, '2021-08-27 20:12:17'),
(1076, '2021-08-27', 12, 233, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-27 20:12:40'),
(1077, '2021-08-27', 12, 178, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-27 20:12:58'),
(1078, '2021-08-27', 12, 303, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-08-27 23:47:20'),
(1079, '2021-08-27', 12, 211, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-27 23:48:24'),
(1080, '2021-08-27', 12, 217, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-08-27 23:49:22'),
(1081, '2021-08-27', 12, 207, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-27 23:50:01'),
(1082, '2021-08-27', 12, 210, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-27 23:50:26'),
(1083, '2021-08-27', 12, 304, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-08-27 23:52:34'),
(1084, '2021-08-28', 10, 304, 8, 2, 2, 4, 9, 'SI', 304, 4, 14, '', 1, '2021-08-28 23:35:09'),
(1085, '2021-08-28', 10, 303, 8, 2, 2, 13, 9, 'SI', 305, 13, 14, '', 1, '2021-08-28 23:38:32'),
(1086, '2021-08-28', 10, 284, 8, 2, 2, 13, 10, 'SI', 284, 13, 14, '', 1, '2021-08-28 23:39:41'),
(1087, '2021-08-28', 10, 295, 8, 2, 2, 4, 0, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:41:28');
INSERT INTO `psyem_seguimiento` (`idSeguimiento`, `fRegistrSeg`, `idUsuario`, `idAtencionPac`, `idProfesional`, `idTipoSeguimiento`, `idMotSeguimiento`, `idDiag1Seg`, `idDiag2Seg`, `comunFamSeg`, `idFamAtSeg`, `idDiag1SegFam`, `idDiag2SegFam`, `obsSeg`, `idStatusSeg`, `registroSistema`) VALUES
(1088, '2021-08-28', 10, 264, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:42:54'),
(1089, '2021-08-28', 10, 274, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:43:28'),
(1090, '2021-08-28', 10, 280, 8, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:44:39'),
(1091, '2021-08-28', 10, 59, 8, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:45:25'),
(1092, '2021-08-28', 10, 126, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:46:36'),
(1093, '2021-08-28', 10, 214, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:47:25'),
(1094, '2021-08-28', 10, 201, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-08-28 23:49:55'),
(1095, '2021-08-31', 12, 120, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-31 16:25:26'),
(1096, '2021-08-31', 12, 99, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-31 16:28:13'),
(1097, '2021-08-31', 12, 151, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-31 16:29:06'),
(1098, '2021-08-31', 12, 262, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-08-31 16:29:39'),
(1099, '2021-08-31', 12, 259, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-08-31 16:30:03'),
(1100, '2021-08-31', 12, 282, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-08-31 16:30:35'),
(1101, '2021-08-31', 10, 298, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-08-31 18:00:44'),
(1102, '2021-08-31', 10, 284, 8, 2, 2, 13, 10, 'SI', 284, 13, 16, '', 1, '2021-08-31 18:02:48'),
(1103, '2021-08-31', 10, 295, 8, 2, 2, 4, 11, 'SI', 295, 4, 17, '', 1, '2021-08-31 18:04:41'),
(1104, '2021-08-31', 10, 264, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-08-31 18:05:26'),
(1105, '2021-09-01', 14, 280, 11, 3, 2, 7, 18, 'NO', 0, 0, 0, 'PACIENTE CON DIAGNOSTICO DE INSOMNIO DE CONCILIACION Y MANTENIMIENTO POR TRASTORNO MENTAL SECUNDARIO A SECUELA NEUROLOGICA Y COVID-19. SE BRINDA ATENCION PSIQUIATRICA POR TELEATIENDO.', 1, '2021-09-01 22:30:20'),
(1106, '2021-09-01', 12, 284, 10, 2, 2, 13, 10, 'SI', 284, 4, 15, '', 1, '2021-09-01 23:09:24'),
(1107, '2021-09-01', 12, 298, 10, 2, 2, 13, 10, 'SI', 299, 13, 15, '', 1, '2021-09-01 23:10:08'),
(1108, '2021-09-01', 12, 220, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:10:50'),
(1109, '2021-09-01', 12, 249, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:11:33'),
(1110, '2021-09-01', 12, 240, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:12:14'),
(1111, '2021-09-01', 12, 278, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:12:56'),
(1112, '2021-09-01', 12, 272, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:13:45'),
(1113, '2021-09-01', 12, 260, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:14:19'),
(1114, '2021-09-01', 12, 233, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-01 23:15:03'),
(1115, '2021-09-03', 12, 284, 10, 2, 2, 13, 11, 'SI', 284, 4, 16, '', 1, '2021-09-03 23:16:56'),
(1116, '2021-09-03', 12, 305, 10, 2, 1, 4, 9, 'SI', 306, 13, 14, '', 1, '2021-09-03 23:20:11'),
(1117, '2021-09-03', 12, 307, 10, 2, 1, 4, 9, 'SI', 308, 13, 14, '', 1, '2021-09-03 23:28:31'),
(1118, '2021-09-03', 12, 282, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-09-03 23:29:11'),
(1119, '2021-09-03', 12, 211, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-03 23:29:37'),
(1120, '2021-09-03', 12, 217, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-03 23:29:56'),
(1121, '2021-09-03', 12, 207, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-03 23:30:20'),
(1122, '2021-08-04', 10, 308, 8, 1, 2, 8, 0, 'SI', 309, 12, 9, '', 1, '2021-09-04 17:52:57'),
(1123, '2021-09-04', 10, 306, 8, 2, 2, 13, 9, 'SI', 307, 13, 14, '', 1, '2021-09-04 17:55:57'),
(1124, '2021-09-04', 10, 308, 8, 1, 2, 8, 0, 'SI', 309, 12, 14, '', 1, '2021-09-04 17:56:57'),
(1125, '2021-09-04', 10, 305, 8, 2, 2, 13, 9, 'SI', 306, 13, 14, '', 1, '2021-09-04 17:59:25'),
(1126, '2021-09-04', 10, 305, 8, 2, 2, 13, 10, 'SI', 310, 13, 14, '', 1, '2021-09-04 18:06:28'),
(1127, '2021-09-04', 10, 305, 8, 2, 2, 13, 10, 'SI', 311, 13, 14, '', 1, '2021-09-04 18:07:32'),
(1128, '2021-09-04', 10, 284, 8, 2, 2, 13, 11, 'SI', 284, 13, 15, '', 1, '2021-09-04 18:21:29'),
(1129, '2021-09-04', 10, 304, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-04 23:21:18'),
(1130, '2021-09-04', 10, 298, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-04 23:22:11'),
(1131, '2021-09-04', 10, 309, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-04 23:50:29'),
(1132, '2021-09-04', 10, 303, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-09-04 23:51:49'),
(1133, '2021-09-04', 10, 295, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-04 23:52:42'),
(1134, '2021-09-04', 10, 291, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-04 23:54:37'),
(1135, '2021-09-06', 12, 305, 10, 2, 2, 4, 10, 'SI', 306, 13, 15, '', 1, '2021-09-06 21:19:03'),
(1136, '2021-09-06', 12, 306, 10, 2, 2, 13, 10, 'SI', 307, 13, 15, '', 1, '2021-09-06 21:19:49'),
(1137, '2021-09-06', 12, 312, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-09-06 21:22:40'),
(1138, '2021-09-06', 12, 284, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-06 21:23:05'),
(1139, '2021-09-06', 12, 120, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-06 21:23:32'),
(1140, '2021-09-06', 12, 99, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-06 21:24:03'),
(1141, '2021-09-06', 12, 151, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-06 21:24:28'),
(1142, '2021-09-07', 10, 311, 8, 2, 2, 4, 9, 'SI', 312, 4, 14, '', 1, '2021-09-07 17:46:39'),
(1143, '2021-09-07', 10, 313, 8, 2, 2, 13, 9, 'SI', 313, 13, 14, '', 1, '2021-09-07 17:50:14'),
(1144, '2021-09-07', 10, 306, 8, 2, 2, 13, 10, 'SI', 307, 13, 15, '', 1, '2021-09-07 17:52:12'),
(1145, '2021-09-07', 10, 312, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-09-07 17:53:03'),
(1146, '2021-09-07', 10, 237, 8, 1, 2, 8, 0, 'SI', 230, 12, 16, '', 1, '2021-09-07 23:07:50'),
(1147, '2021-09-07', 10, 300, 8, 2, 2, 13, 9, 'SI', 314, 13, 14, '', 1, '2021-09-07 23:09:45'),
(1148, '2021-09-07', 10, 214, 8, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-07 23:10:37'),
(1149, '2021-09-07', 10, 236, 8, 3, 2, 7, 17, 'NO', 0, 0, 0, '', 1, '2021-09-07 23:12:38'),
(1150, '2021-09-07', 10, 281, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-09-07 23:20:29'),
(1151, '2021-09-07', 10, 201, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-07 23:22:55'),
(1152, '2021-09-08', 12, 306, 10, 2, 2, 13, 11, 'SI', 307, 13, 16, '', 1, '2021-09-08 18:56:07'),
(1153, '2021-09-08', 12, 300, 10, 2, 2, 4, 10, 'SI', 314, 13, 14, '', 1, '2021-09-08 19:08:57'),
(1154, '2021-09-08', 12, 313, 10, 2, 1, 4, 9, 'SI', 313, 13, 14, '', 1, '2021-09-08 19:17:41'),
(1155, '2021-09-08', 12, 262, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-08 23:16:01'),
(1156, '2021-09-08', 12, 259, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-09-08 23:16:30'),
(1157, '2021-09-08', 12, 282, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-09-08 23:16:58'),
(1158, '2021-09-08', 12, 178, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-08 23:18:20'),
(1159, '2021-09-08', 12, 312, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-08 23:19:36'),
(1160, '2021-09-09', 10, 300, 8, 2, 2, 13, 10, 'NO', 0, 0, 0, '', 1, '2021-09-09 18:21:35'),
(1161, '2021-09-09', 10, 306, 8, 2, 2, 4, 11, 'SI', 315, 13, 14, '', 1, '2021-09-09 18:24:52'),
(1162, '2021-09-09', 10, 295, 8, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-09-09 18:29:31'),
(1163, '2021-09-09', 10, 280, 8, 2, 2, 8, 0, 'SI', 279, 4, 16, '', 1, '2021-09-09 19:04:42'),
(1164, '2021-09-09', 10, 313, 8, 2, 2, 4, 0, 'SI', 313, 4, 15, '', 1, '2021-09-09 19:06:38'),
(1165, '2021-09-09', 10, 213, 8, 3, 2, 7, 15, 'NO', 0, 0, 0, '', 1, '2021-09-09 23:47:14'),
(1166, '2021-09-09', 10, 274, 8, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-09 23:47:48'),
(1167, '2021-09-09', 10, 298, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-09 23:48:56'),
(1168, '2021-09-09', 10, 288, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-09 23:49:37'),
(1169, '2021-09-09', 10, 308, 8, 1, 2, 8, 0, 'SI', 309, 12, 15, '', 1, '2021-09-09 23:50:51'),
(1170, '2021-09-09', 10, 308, 8, 1, 2, 8, 0, 'SI', 316, 12, 14, '', 1, '2021-09-09 23:54:00'),
(1171, '2021-09-02', 10, 284, 8, 2, 2, 13, 9, 'SI', 284, 13, 15, '', 1, '2021-09-10 00:08:43'),
(1172, '2021-09-10', 12, 314, 10, 2, 1, 13, 9, 'SI', 317, 13, 14, '', 1, '2021-09-10 19:50:00'),
(1173, '2021-09-10', 12, 300, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-09-10 19:50:40'),
(1174, '2021-09-10', 12, 220, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 19:51:13'),
(1175, '2021-09-10', 12, 249, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 19:51:52'),
(1176, '2021-09-10', 12, 210, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 23:25:14'),
(1177, '2021-09-10', 12, 284, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 23:25:48'),
(1178, '2021-09-10', 12, 120, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 23:26:14'),
(1179, '2021-09-10', 12, 99, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 23:26:33'),
(1180, '2021-09-10', 12, 151, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-10 23:27:01'),
(1181, '2021-09-11', 10, 314, 8, 2, 2, 2, 9, 'SI', 318, 4, 14, '', 1, '2021-09-11 18:26:51'),
(1182, '2021-09-11', 10, 306, 8, 1, 2, 13, 0, 'SI', 315, 13, 15, '', 1, '2021-09-11 19:19:55'),
(1183, '2021-09-11', 10, 306, 8, 1, 2, 13, 0, 'SI', 307, 13, 17, '', 1, '2021-09-11 23:48:05'),
(1184, '2021-09-11', 10, 305, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-11 23:49:37'),
(1185, '2021-09-11', 10, 309, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-11 23:51:14'),
(1186, '2021-09-11', 10, 303, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-09-11 23:52:31'),
(1187, '2021-09-11', 10, 210, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-11 23:54:14'),
(1188, '2021-09-11', 10, 315, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-09-11 23:56:50'),
(1189, '2021-09-12', 10, 284, 8, 2, 2, 13, 9, 'SI', 284, 13, 15, '', 1, '2021-09-13 01:45:17'),
(1190, '2021-09-12', 10, 307, 8, 2, 2, 2, 9, 'NO', 0, 0, 0, '', 1, '2021-09-13 01:46:11'),
(1191, '2021-09-12', 10, 205, 8, 1, 2, 8, 0, 'SI', 197, 12, 15, '', 1, '2021-09-13 01:47:30'),
(1192, '2021-09-12', 10, 205, 8, 1, 2, 8, 0, 'SI', 319, 12, 14, '', 1, '2021-09-13 01:49:53'),
(1193, '2021-09-12', 10, 125, 8, 3, 2, 7, 15, 'NO', 0, 0, 0, '', 1, '2021-09-13 01:51:00'),
(1194, '2021-09-12', 10, 236, 8, 3, 2, 7, 15, 'NO', 0, 0, 0, '', 1, '2021-09-13 01:52:18'),
(1195, '2021-09-12', 10, 309, 8, 2, 2, 4, 9, 'SI', 320, 13, 14, '', 1, '2021-09-13 01:56:40'),
(1196, '2021-09-12', 10, 305, 8, 2, 2, 13, 14, 'SI', 306, 13, 14, '', 1, '2021-09-13 01:58:42'),
(1197, '2021-09-12', 10, 316, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-09-13 02:00:25'),
(1198, '2021-09-12', 10, 317, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-09-13 02:02:33'),
(1199, '2021-09-13', 12, 314, 10, 2, 2, 4, 10, 'SI', 317, 13, 15, '', 1, '2021-09-13 23:36:38'),
(1200, '2021-09-13', 12, 262, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:37:06'),
(1201, '2021-09-13', 12, 259, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:37:34'),
(1202, '2021-09-13', 12, 282, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:38:23'),
(1203, '2021-09-13', 12, 312, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:38:48'),
(1204, '2021-09-13', 12, 306, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:39:13'),
(1205, '2021-09-13', 12, 300, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:39:34'),
(1206, '2021-09-13', 12, 284, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-13 23:40:22'),
(1207, '2021-09-14', 10, 301, 8, 2, 2, 4, 9, 'SI', 302, 13, 14, '', 1, '2021-09-14 17:56:15'),
(1208, '2021-09-14', 10, 314, 8, 2, 2, 2, 10, 'SI', 317, 13, 14, '', 1, '2021-09-14 18:06:00'),
(1209, '2021-09-14', 10, 319, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-09-14 23:31:07'),
(1210, '2021-09-14', 10, 179, 8, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-09-14 23:32:01'),
(1211, '2021-09-14', 10, 208, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-14 23:32:57'),
(1212, '2021-09-14', 10, 314, 8, 2, 2, 2, 10, 'SI', 318, 4, 15, '', 1, '2021-09-14 23:34:11'),
(1213, '2021-09-14', 10, 225, 8, 1, 2, 8, 0, 'SI', 217, 12, 14, '', 1, '2021-09-14 23:35:40'),
(1214, '2021-09-15', 14, 205, 11, 1, 2, 18, 15, 'SI', 319, 5, 15, 'HIJO DE PACIENTE FALLECIDO POR COVID CON DIAGNOSTICO DE AUTISMO CON SINTOMAS ANSIOSOS DEPRESIVOS PROPIOS DE ADAPTACION PATOLOGICA', 1, '2021-09-15 14:44:05'),
(1215, '2021-09-15', 12, 301, 10, 2, 1, 4, 9, 'SI', 302, 13, 14, '', 1, '2021-09-15 19:49:44'),
(1216, '2021-09-15', 12, 321, 10, 2, 1, 13, 9, 'SI', 322, 4, 14, '', 1, '2021-09-15 19:56:19'),
(1217, '2021-09-15', 12, 319, 10, 2, 1, 4, 9, 'SI', 323, 13, 14, '', 1, '2021-09-15 19:59:41'),
(1218, '2021-09-15', 12, 314, 10, 2, 2, 13, 11, 'SI', 317, 13, 16, '', 1, '2021-09-15 23:11:41'),
(1219, '2021-09-15', 12, 313, 10, 2, 2, 4, 10, 'SI', 313, 13, 15, '', 1, '2021-09-15 23:12:21'),
(1220, '2021-09-15', 12, 284, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-15 23:13:24'),
(1221, '2021-09-15', 12, 306, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-15 23:14:08'),
(1222, '2021-06-19', 10, 301, 8, 2, 2, 4, 10, 'SI', 302, 13, 11, '', 1, '2021-09-16 19:00:05'),
(1223, '2021-09-16', 10, 314, 8, 2, 2, 2, 11, 'SI', 318, 4, 17, '', 1, '2021-09-16 19:01:43'),
(1224, '2021-09-16', 10, 313, 8, 2, 2, 13, 10, 'SI', 313, 13, 16, '', 1, '2021-09-16 19:05:36'),
(1225, '2021-09-16', 10, 301, 8, 2, 2, 4, 10, 'SI', 302, 13, 15, '', 1, '2021-09-16 19:10:02'),
(1226, '2021-09-16', 10, 295, 8, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-16 19:14:07'),
(1227, '2021-09-16', 10, 281, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-16 21:38:02'),
(1228, '2021-09-16', 10, 210, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-16 21:39:21'),
(1229, '2021-09-16', 10, 280, 8, 3, 2, 13, 11, 'NO', 0, 0, 0, '', 1, '2021-09-16 21:48:32'),
(1230, '2021-09-16', 10, 59, 8, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-16 23:46:57'),
(1231, '2021-09-17', 12, 313, 10, 2, 2, 13, 11, 'SI', 313, 13, 16, '', 1, '2021-09-17 19:41:37'),
(1232, '2021-09-17', 12, 301, 10, 2, 2, 4, 10, 'SI', 302, 13, 15, '', 1, '2021-09-17 19:42:33'),
(1233, '2021-09-17', 12, 321, 10, 2, 2, 8, 0, 'SI', 322, 4, 15, '', 1, '2021-09-17 19:43:16'),
(1234, '2021-09-17', 12, 319, 10, 2, 2, 8, 0, 'SI', 323, 4, 15, '', 1, '2021-09-17 23:05:36'),
(1235, '2021-09-17', 12, 312, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-17 23:06:03'),
(1236, '2021-09-17', 12, 300, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-17 23:06:42'),
(1237, '2021-09-17', 12, 306, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-17 23:07:12'),
(1238, '2021-09-18', 10, 301, 8, 2, 2, 3, 11, 'SI', 302, 13, 0, '', 1, '2021-09-18 23:11:57'),
(1239, '2021-09-18', 10, 314, 8, 2, 2, 3, 11, 'NO', 0, 0, 0, '', 1, '2021-09-18 23:13:01'),
(1240, '2021-09-18', 10, 313, 8, 2, 2, 13, 11, 'SI', 313, 13, 0, '', 1, '2021-09-18 23:14:50'),
(1241, '2021-09-18', 10, 318, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-18 23:16:31'),
(1242, '2021-09-18', 10, 311, 8, 2, 2, 8, 0, 'SI', 312, 4, 15, '', 1, '2021-09-18 23:19:12'),
(1243, '2021-09-18', 10, 316, 8, 3, 2, 13, 0, 'NO', 0, 13, 0, '', 1, '2021-09-18 23:22:21'),
(1244, '2021-09-18', 10, 307, 8, 1, 2, 8, 0, 'SI', 324, 12, 14, '', 1, '2021-09-18 23:28:57'),
(1245, '2021-09-20', 12, 301, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-20 23:00:52'),
(1246, '2021-09-20', 12, 313, 10, 2, 2, 13, 11, 'SI', 313, 13, 17, '', 1, '2021-09-20 23:01:19'),
(1247, '2021-09-20', 12, 314, 10, 2, 2, 13, 11, 'SI', 317, 13, 17, '', 1, '2021-09-20 23:01:53'),
(1248, '2021-09-20', 12, 312, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-20 23:02:26'),
(1249, '2021-09-20', 12, 300, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-20 23:02:46'),
(1250, '2021-09-20', 12, 306, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-20 23:03:10'),
(1251, '2021-09-20', 12, 323, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-09-20 23:04:57'),
(1252, '2021-09-21', 10, 313, 8, 2, 2, 4, 17, 'SI', 313, 13, 17, '', 1, '2021-09-21 19:08:07'),
(1253, '2021-09-21', 10, 323, 8, 2, 2, 4, 9, 'SI', 325, 13, 14, '', 1, '2021-09-21 19:13:06'),
(1254, '2021-09-21', 10, 314, 8, 3, 2, 3, 14, 'NO', 0, 0, 0, '', 1, '2021-09-21 22:21:12'),
(1255, '2021-09-21', 10, 316, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-21 22:24:09'),
(1256, '2021-09-21', 10, 291, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-21 22:26:48'),
(1257, '2021-09-21', 10, 303, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-21 22:28:56'),
(1258, '2021-09-21', 10, 324, 8, 2, 2, 4, 9, 'SI', 326, 13, 14, '', 1, '2021-09-22 00:02:38'),
(1259, '2021-09-21', 10, 301, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-22 00:25:23'),
(1260, '2021-09-22', 12, 323, 10, 2, 2, 4, 10, 'SI', 325, 13, 14, '', 1, '2021-09-22 19:54:45'),
(1261, '2021-09-22', 12, 325, 10, 2, 1, 4, 9, 'SI', 327, 13, 14, '', 1, '2021-09-22 20:01:07'),
(1262, '2021-09-22', 12, 301, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-22 20:02:44'),
(1263, '2021-09-22', 12, 326, 10, 2, 1, 4, 9, 'SI', 329, 13, 14, '', 1, '2021-09-22 23:25:25'),
(1264, '2021-09-22', 12, 319, 10, 2, 2, 13, 10, 'SI', 323, 13, 15, '', 1, '2021-09-22 23:26:03'),
(1265, '2021-09-22', 12, 324, 10, 2, 2, 8, 9, 'SI', 326, 13, 14, '', 1, '2021-09-22 23:30:31'),
(1266, '2021-09-23', 10, 301, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-09-23 23:24:10'),
(1267, '2021-09-23', 10, 265, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-23 23:25:17'),
(1268, '2021-09-23', 10, 258, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-23 23:25:57'),
(1269, '2021-09-23', 10, 314, 8, 3, 2, 3, 15, 'NO', 0, 0, 0, '', 1, '2021-09-23 23:26:57'),
(1270, '2021-09-23', 10, 327, 8, 2, 2, 8, 0, 'SI', 331, 4, 17, '', 1, '2021-09-23 23:34:32'),
(1271, '2021-09-23', 10, 326, 8, 2, 2, 4, 9, 'SI', 332, 13, 14, '', 1, '2021-09-23 23:42:46'),
(1272, '2021-09-23', 10, 323, 8, 2, 2, 13, 10, 'SI', 333, 13, 14, '', 1, '2021-09-23 23:45:09'),
(1273, '2021-09-23', 10, 319, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-09-23 23:46:08'),
(1274, '2021-09-23', 10, 323, 8, 2, 2, 13, 10, 'SI', 333, 13, 14, '', 1, '2021-09-23 23:49:24'),
(1275, '2021-09-24', 12, 328, 10, 2, 1, 4, 9, 'SI', 334, 13, 14, '', 1, '2021-09-24 23:13:25'),
(1276, '2021-09-24', 12, 323, 10, 2, 2, 4, 11, 'SI', 325, 13, 16, '', 1, '2021-09-24 23:14:08'),
(1277, '2021-09-24', 12, 319, 10, 2, 2, 13, 11, 'SI', 323, 13, 16, '', 1, '2021-09-24 23:14:55'),
(1278, '2021-09-24', 12, 326, 10, 2, 2, 8, 0, 'SI', 329, 13, 15, '', 1, '2021-09-24 23:16:05'),
(1279, '2021-09-24', 12, 325, 10, 2, 2, 8, 0, 'SI', 327, 13, 15, '', 1, '2021-09-24 23:16:44'),
(1280, '2021-09-24', 12, 321, 10, 2, 2, 8, 0, 'SI', 322, 4, 16, '', 1, '2021-09-24 23:17:26'),
(1281, '2021-09-24', 12, 301, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-24 23:17:59'),
(1282, '2021-09-25', 10, 323, 8, 2, 2, 4, 11, 'SI', 325, 15, 0, '', 1, '2021-09-25 18:32:26'),
(1283, '2021-09-25', 10, 319, 8, 2, 2, 13, 11, 'SI', 323, 13, 14, '', 1, '2021-09-25 18:34:20'),
(1284, '2021-09-25', 10, 313, 8, 2, 2, 13, 11, 'SI', 313, 13, 17, '', 1, '2021-09-25 18:36:09'),
(1285, '2021-09-25', 10, 329, 8, 2, 2, 4, 9, 'SI', 335, 13, 14, '', 1, '2021-09-25 23:31:57'),
(1286, '2021-09-25', 10, 308, 8, 1, 2, 8, 0, 'SI', 309, 12, 16, '', 1, '2021-09-25 23:33:22'),
(1287, '2021-09-25', 10, 295, 8, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-25 23:34:21'),
(1288, '2021-09-25', 10, 293, 8, 1, 2, 8, 0, 'SI', 292, 12, 15, '', 1, '2021-09-25 23:35:45'),
(1289, '2021-09-25', 10, 309, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-09-25 23:40:16'),
(1290, '2021-09-27', 12, 323, 10, 2, 2, 4, 11, 'SI', 325, 13, 17, '', 1, '2021-09-27 20:07:11'),
(1291, '2021-09-27', 12, 319, 10, 2, 2, 13, 11, 'SI', 323, 13, 17, '', 1, '2021-09-27 20:07:57'),
(1292, '2021-09-27', 12, 329, 10, 2, 1, 4, 9, 'SI', 335, 13, 14, '', 1, '2021-09-27 20:08:39'),
(1293, '2021-09-27', 12, 301, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-09-27 23:24:04'),
(1294, '2021-09-27', 12, 313, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-09-27 23:24:56'),
(1295, '2021-09-29', 12, 330, 10, 2, 2, 13, 10, 'SI', 336, 13, 15, '', 1, '2021-09-29 17:58:20'),
(1296, '2021-09-29', 12, 325, 10, 2, 2, 4, 10, 'SI', 328, 13, 16, '', 1, '2021-09-29 17:59:19'),
(1297, '2021-09-29', 12, 330, 10, 2, 2, 13, 10, 'SI', 337, 13, 14, '', 1, '2021-09-29 18:01:55'),
(1298, '2021-10-01', 12, 330, 10, 2, 2, 4, 11, 'SI', 336, 13, 16, '', 1, '2021-10-01 23:05:54'),
(1299, '2021-10-01', 12, 330, 10, 2, 2, 4, 11, 'SI', 337, 13, 15, '', 1, '2021-10-01 23:06:33'),
(1300, '2021-10-01', 12, 325, 10, 2, 2, 4, 11, 'SI', 327, 13, 17, '', 1, '2021-10-01 23:07:17'),
(1301, '2021-10-01', 12, 331, 10, 2, 1, 4, 9, 'SI', 338, 4, 14, '', 1, '2021-10-01 23:09:42'),
(1302, '2021-10-01', 12, 323, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-10-01 23:10:17'),
(1303, '2021-10-01', 12, 319, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-01 23:11:12'),
(1304, '2021-10-01', 12, 313, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-10-01 23:11:48'),
(1305, '2021-10-05', 10, 313, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-05 23:48:03'),
(1306, '2021-10-05', 10, 326, 8, 2, 2, 8, 0, 'SI', 332, 13, 16, '', 1, '2021-10-05 23:49:36'),
(1307, '2021-10-05', 10, 323, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-05 23:50:32'),
(1308, '2021-10-05', 10, 327, 8, 1, 2, 8, 0, 'SI', 331, 12, 16, '', 1, '2021-10-05 23:52:33'),
(1309, '2021-10-05', 10, 329, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-10-05 23:53:32'),
(1310, '2021-10-05', 10, 330, 8, 2, 2, 4, 9, 'SI', 337, 13, 14, '', 1, '2021-10-05 23:55:36'),
(1311, '2021-10-05', 10, 332, 8, 2, 2, 4, 9, 'SI', 339, 13, 14, '', 1, '2021-10-05 23:59:22'),
(1312, '2021-10-07', 10, 332, 8, 2, 2, 4, 0, 'SI', 339, 13, 16, '', 1, '2021-10-07 21:57:30'),
(1313, '2021-10-07', 10, 329, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:00:14'),
(1314, '2021-10-07', 10, 330, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:02:24'),
(1315, '2021-10-07', 10, 282, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:03:26'),
(1316, '2021-10-07', 10, 280, 8, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:04:37'),
(1317, '2021-10-07', 10, 323, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:05:28'),
(1318, '2021-10-07', 10, 322, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:06:26'),
(1319, '2021-10-07', 10, 301, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:08:52'),
(1320, '2021-10-07', 10, 313, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-10-07 22:09:57'),
(1321, '2021-10-09', 10, 333, 8, 2, 2, 4, 9, 'SI', 340, 9, 14, '', 1, '2021-10-10 00:00:44'),
(1322, '2021-10-09', 10, 332, 8, 2, 2, 4, 9, 'SI', 339, 13, 15, '', 1, '2021-10-10 00:01:51'),
(1323, '2021-10-09', 10, 326, 8, 2, 2, 13, 10, 'SI', 332, 13, 16, '', 1, '2021-10-10 00:03:06'),
(1324, '2021-10-11', 12, 334, 10, 2, 2, 13, 9, 'SI', 341, 4, 14, '', 1, '2021-10-11 23:31:31'),
(1325, '2021-10-11', 12, 335, 10, 2, 1, 4, 9, 'SI', 342, 4, 14, '', 1, '2021-10-11 23:33:54'),
(1326, '2021-10-11', 12, 326, 10, 2, 2, 13, 10, 'SI', 329, 13, 16, '', 1, '2021-10-11 23:34:47'),
(1327, '2021-10-13', 12, 336, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-10-13 23:42:56'),
(1328, '2021-10-13', 12, 326, 10, 2, 2, 4, 11, 'SI', 330, 13, 17, '', 1, '2021-10-13 23:43:43'),
(1329, '2021-10-15', 12, 336, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-10-15 23:47:00'),
(1330, '2021-10-15', 12, 337, 10, 2, 2, 4, 9, 'SI', 343, 13, 14, '', 1, '2021-10-15 23:51:05'),
(1331, '2021-10-15', 12, 326, 10, 2, 2, 4, 9, 'SI', 344, 13, 14, '', 1, '2021-10-15 23:55:23'),
(1332, '2021-10-16', 10, 336, 8, 2, 2, 4, 0, 'SI', 345, 13, 14, '', 1, '2021-10-16 23:22:59'),
(1333, '2021-10-16', 10, 280, 8, 2, 2, 4, 0, 'SI', 279, 13, 17, '', 1, '2021-10-16 23:26:21'),
(1334, '2021-10-19', 10, 336, 8, 2, 2, 4, 9, 'SI', 346, 13, 14, '', 1, '2021-10-20 00:07:10'),
(1335, '2021-10-19', 10, 337, 8, 2, 2, 4, 9, 'SI', 343, 13, 14, '', 1, '2021-10-20 00:10:22'),
(1336, '2021-10-19', 10, 326, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-10-20 00:11:14'),
(1337, '2021-10-19', 10, 314, 8, 3, 2, 12, 17, 'NO', 0, 0, 0, '', 1, '2021-10-20 00:12:14'),
(1338, '2021-10-21', 10, 337, 8, 2, 2, 4, 12, 'SI', 343, 12, 14, '', 1, '2021-10-22 00:28:46'),
(1339, '2021-10-21', 10, 338, 8, 2, 2, 4, 9, 'SI', 347, 4, 9, '', 1, '2021-10-22 00:38:46'),
(1340, '2021-10-21', 10, 339, 8, 2, 2, 4, 9, 'SI', 348, 9, 14, '', 1, '2021-10-22 00:39:50'),
(1341, '2021-10-23', 10, 338, 8, 2, 2, 4, 10, 'SI', 347, 4, 15, '', 1, '2021-10-23 23:55:58'),
(1342, '2021-10-23', 10, 339, 8, 2, 2, 4, 10, 'SI', 348, 13, 16, '', 1, '2021-10-23 23:57:23'),
(1343, '2021-10-23', 10, 337, 8, 2, 2, 4, 10, 'SI', 343, 12, 16, '', 1, '2021-10-23 23:58:29'),
(1344, '2021-10-25', 12, 340, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-10-25 23:30:03'),
(1345, '2021-10-25', 12, 341, 10, 2, 1, 4, 9, 'SI', 349, 13, 14, '', 1, '2021-10-25 23:34:06'),
(1346, '2021-10-25', 12, 342, 10, 2, 1, 13, 9, 'SI', 350, 4, 14, '', 1, '2021-10-25 23:38:45'),
(1347, '2021-10-27', 12, 340, 10, 2, 2, 4, 10, 'SI', 351, 13, 14, '', 1, '2021-10-27 23:28:41'),
(1348, '2021-10-27', 12, 343, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-10-27 23:31:52'),
(1349, '2021-10-27', 12, 341, 10, 2, 2, 4, 10, 'SI', 349, 13, 15, '', 1, '2021-10-27 23:32:57'),
(1350, '2021-10-27', 12, 342, 10, 2, 2, 13, 10, 'SI', 350, 4, 15, '', 1, '2021-10-27 23:35:33'),
(1351, '2021-10-28', 10, 337, 8, 3, 2, 12, 0, 'NO', 0, 0, 0, '', 1, '2021-10-28 23:57:44'),
(1352, '2021-11-02', 10, 340, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-04 04:40:00'),
(1353, '2021-11-02', 10, 344, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-11-04 04:43:33'),
(1354, '2021-11-02', 10, 343, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-04 04:44:54'),
(1355, '2021-11-02', 10, 345, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2021-11-04 04:48:55'),
(1356, '2021-11-02', 10, 346, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-04 04:57:30'),
(1357, '2021-11-02', 10, 326, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-11-04 04:59:01'),
(1358, '2021-11-04', 10, 343, 8, 2, 2, 4, 9, 'SI', 352, 13, 14, '', 1, '2021-11-05 11:24:10'),
(1359, '2021-11-04', 10, 346, 8, 2, 2, 4, 10, 'SI', 353, 20, 14, '', 1, '2021-11-05 11:28:02'),
(1360, '2021-11-04', 10, 341, 8, 2, 2, 4, 9, 'SI', 349, 20, 14, '', 1, '2021-11-05 11:31:20'),
(1361, '2021-11-04', 10, 345, 8, 2, 2, 4, 10, 'SI', 355, 20, 14, '', 1, '2021-11-05 11:38:29'),
(1362, '2021-11-02', 10, 348, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-05 11:42:58'),
(1363, '2021-10-29', 12, 349, 10, 2, 1, 4, 9, 'SI', 356, 4, 14, '', 1, '2021-11-06 15:00:45'),
(1364, '2021-10-29', 12, 340, 10, 2, 2, 4, 10, 'SI', 351, 13, 15, '', 1, '2021-11-06 15:02:35'),
(1365, '2021-10-29', 12, 343, 10, 2, 2, 4, 10, 'SI', 352, 13, 14, '', 1, '2021-11-06 15:04:28'),
(1366, '2021-10-29', 12, 341, 10, 2, 2, 4, 10, 'SI', 349, 13, 16, '', 1, '2021-11-06 15:05:51'),
(1367, '2021-10-29', 12, 344, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-11-06 15:06:37'),
(1368, '2021-11-05', 12, 341, 10, 2, 2, 4, 11, 'SI', 349, 13, 17, '', 1, '2021-11-06 15:07:52'),
(1369, '2021-11-05', 12, 343, 10, 2, 2, 4, 11, 'SI', 352, 13, 16, '', 1, '2021-11-06 15:08:34'),
(1370, '2021-11-05', 12, 344, 10, 2, 2, 13, 10, 'SI', 357, 13, 14, '', 1, '2021-11-06 15:10:36'),
(1371, '2021-11-05', 12, 346, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-06 15:13:35'),
(1372, '2021-11-06', 10, 336, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:45:46'),
(1373, '2021-11-06', 10, 337, 8, 3, 2, 12, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:46:46'),
(1374, '2021-11-06', 10, 351, 8, 1, 2, 8, 0, 'SI', 358, 12, 0, '', 1, '2021-11-06 23:51:32'),
(1375, '2021-11-06', 10, 345, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:53:56'),
(1376, '2021-11-06', 10, 340, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:54:47'),
(1377, '2021-11-06', 10, 339, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:55:26'),
(1378, '2021-11-06', 10, 326, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:56:10'),
(1379, '2021-11-06', 10, 338, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-11-06 23:57:03'),
(1380, '2021-11-08', 12, 343, 10, 2, 2, 4, 11, 'SI', 352, 13, 17, '', 1, '2021-11-08 23:29:19'),
(1381, '2021-11-08', 12, 344, 10, 2, 2, 13, 11, 'SI', 357, 13, 16, '', 1, '2021-11-08 23:30:43'),
(1382, '2021-11-09', 10, 334, 8, 2, 2, 4, 9, 'SI', 341, 13, 14, '', 1, '2021-11-09 22:55:30'),
(1383, '2021-11-09', 10, 352, 8, 2, 2, 4, 9, 'SI', 359, 9, 14, '', 1, '2021-11-09 23:04:26'),
(1384, '2021-11-10', 12, 348, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-10 22:43:57'),
(1385, '2021-11-10', 12, 344, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-10 22:44:21'),
(1386, '2021-11-10', 12, 341, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-11-10 22:44:47'),
(1387, '2021-11-10', 12, 342, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-10 22:45:21'),
(1388, '2021-11-10', 12, 350, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-11-10 22:45:55'),
(1389, '2021-11-11', 10, 351, 8, 1, 2, 8, 0, 'SI', 360, 12, 14, '', 1, '2021-11-11 23:44:16'),
(1390, '2021-11-11', 10, 346, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-11 23:47:08'),
(1391, '2021-11-11', 10, 348, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-11-11 23:48:20'),
(1392, '2021-11-11', 10, 344, 8, 3, 2, 9, 14, 'NO', 0, 0, 0, '', 1, '2021-11-11 23:49:56'),
(1393, '2021-11-11', 10, 334, 8, 2, 2, 3, 10, 'SI', 341, 13, 15, '', 1, '2021-11-11 23:55:12'),
(1394, '2021-11-11', 10, 352, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-11 23:57:01'),
(1395, '2021-11-12', 12, 334, 10, 2, 1, 3, 9, 'SI', 341, 13, 14, '', 1, '2021-11-12 23:41:18'),
(1396, '2021-11-12', 12, 352, 10, 2, 1, 4, 9, 'SI', 359, 13, 14, '', 1, '2021-11-12 23:42:18'),
(1397, '2021-11-12', 12, 353, 10, 2, 1, 4, 9, 'SI', 361, 13, 14, '', 1, '2021-11-12 23:43:53'),
(1398, '2021-11-12', 12, 354, 10, 2, 1, 4, 9, 'SI', 362, 4, 14, '', 1, '2021-11-12 23:45:40'),
(1399, '2021-11-15', 12, 335, 10, 2, 2, 22, 9, 'SI', 363, 4, 14, '', 1, '2021-11-15 23:14:40'),
(1400, '2021-11-15', 12, 355, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-15 23:16:41'),
(1401, '2021-11-15', 12, 356, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-15 23:17:07'),
(1402, '2021-11-15', 12, 357, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-15 23:17:47'),
(1403, '2021-11-16', 10, 355, 8, 2, 2, 13, 9, 'SI', 364, 13, 14, '', 1, '2021-11-17 00:18:05'),
(1404, '2021-11-16', 10, 335, 8, 2, 2, 22, 9, 'SI', 342, 20, 14, '', 1, '2021-11-17 00:28:26'),
(1405, '2021-11-16', 10, 358, 8, 2, 2, 4, 9, 'SI', 365, 20, 0, '', 1, '2021-11-17 00:41:13'),
(1406, '2021-11-16', 10, 356, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-17 00:49:49'),
(1407, '2021-11-17', 12, 344, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-11-18 00:04:50'),
(1408, '2021-11-17', 12, 348, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-11-18 00:05:27'),
(1409, '2021-11-17', 12, 341, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-11-18 00:06:06'),
(1410, '2021-11-17', 12, 343, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-11-18 00:06:40'),
(1411, '2021-11-18', 10, 359, 8, 2, 2, 4, 9, 'SI', 366, 13, 14, '', 1, '2021-11-19 00:34:35'),
(1412, '2021-11-18', 10, 360, 8, 2, 2, 4, 9, 'SI', 367, 13, 14, '', 1, '2021-11-19 00:38:42'),
(1413, '2021-11-18', 10, 357, 8, 2, 2, 4, 9, 'SI', 368, 9, 14, '', 1, '2021-11-19 00:42:44'),
(1414, '2021-11-18', 10, 361, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-19 00:46:25'),
(1415, '2021-11-19', 12, 356, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2021-11-19 22:39:42'),
(1416, '2021-11-19', 12, 363, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-19 22:49:30'),
(1417, '2021-11-19', 12, 364, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-11-19 22:50:22'),
(1418, '2021-11-19', 12, 344, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-11-19 22:50:47'),
(1419, '2021-11-19', 12, 348, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-11-19 22:51:14'),
(1420, '2021-11-19', 12, 343, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-11-19 22:51:37'),
(1421, '2021-11-23', 10, 357, 8, 2, 2, 4, 10, 'SI', 368, 13, 15, '', 1, '2021-11-24 00:53:23'),
(1422, '2021-11-23', 10, 364, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-24 00:59:23'),
(1423, '2021-11-23', 10, 365, 8, 2, 2, 4, 9, 'SI', 370, 13, 14, '', 1, '2021-11-24 01:05:09'),
(1424, '2021-11-23', 10, 366, 8, 2, 2, 4, 9, 'SI', 371, 13, 14, '', 1, '2021-11-24 01:11:02'),
(1425, '2021-11-23', 10, 367, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-11-24 01:12:02'),
(1426, '2021-11-26', 12, 363, 10, 2, 2, 4, 10, 'SI', 372, 13, 14, '', 1, '2021-11-26 23:03:22'),
(1427, '2021-11-26', 12, 368, 10, 2, 1, 4, 9, 'SI', 373, 13, 14, '', 1, '2021-11-26 23:06:32'),
(1428, '2021-11-26', 12, 369, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-11-26 23:08:08'),
(1429, '2021-11-26', 12, 344, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-11-26 23:09:22'),
(1430, '2021-11-26', 12, 348, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-11-26 23:09:52'),
(1431, '2021-11-29', 12, 370, 10, 2, 1, 4, 9, 'SI', 374, 4, 14, '', 1, '2021-11-29 23:50:07'),
(1432, '2021-11-29', 12, 371, 10, 2, 1, 4, 9, 'SI', 375, 13, 14, '', 1, '2021-11-29 23:52:02'),
(1433, '2021-11-29', 12, 367, 10, 2, 2, 4, 9, 'SI', 376, 4, 14, '', 1, '2021-11-29 23:53:55'),
(1434, '2021-11-30', 10, 358, 8, 2, 2, 4, 9, 'SI', 365, 13, 14, '', 1, '2021-12-01 00:59:09'),
(1435, '2021-11-30', 10, 372, 8, 2, 2, 4, 9, 'SI', 377, 4, 14, '', 1, '2021-12-01 01:01:52'),
(1436, '2021-11-30', 10, 373, 8, 2, 2, 2, 9, 'SI', 378, 13, 14, '', 1, '2021-12-01 01:04:47'),
(1437, '2021-11-30', 10, 374, 8, 2, 2, 4, 9, 'SI', 379, 9, 14, '', 1, '2021-12-01 01:07:36'),
(1438, '2021-11-30', 10, 375, 8, 2, 2, 4, 9, 'SI', 380, 4, 14, '', 1, '2021-12-01 01:10:51'),
(1439, '2021-12-01', 12, 376, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-01 23:46:37'),
(1440, '2021-12-01', 12, 370, 10, 2, 2, 4, 10, 'SI', 374, 4, 15, '', 1, '2021-12-01 23:47:16'),
(1441, '2021-12-01', 12, 363, 10, 2, 2, 4, 11, 'SI', 372, 13, 16, '', 1, '2021-12-01 23:48:07'),
(1442, '2021-12-01', 12, 371, 10, 2, 2, 4, 10, 'SI', 375, 13, 15, '', 1, '2021-12-01 23:48:47'),
(1443, '2021-12-02', 10, 377, 8, 2, 2, 4, 9, 'SI', 381, 4, 14, '', 1, '2021-12-03 03:39:45'),
(1444, '2021-12-02', 10, 375, 8, 2, 2, 4, 10, 'SI', 380, 4, 15, '', 1, '2021-12-03 03:41:29'),
(1445, '2021-12-02', 10, 374, 8, 2, 2, 4, 10, 'SI', 379, 13, 15, '', 1, '2021-12-03 03:53:13'),
(1446, '2021-12-02', 10, 358, 8, 2, 2, 4, 9, 'SI', 365, 13, 16, '', 1, '2021-12-03 03:54:51'),
(1447, '2021-12-02', 10, 366, 8, 2, 2, 4, 10, 'SI', 371, 4, 16, '', 1, '2021-12-03 03:57:53'),
(1448, '2021-12-02', 10, 365, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-03 03:58:50'),
(1449, '2021-12-03', 12, 376, 10, 2, 2, 13, 10, 'SI', 382, 4, 14, '', 1, '2021-12-03 23:13:32'),
(1450, '2021-12-03', 12, 363, 10, 2, 2, 4, 11, 'SI', 372, 13, 17, '', 1, '2021-12-03 23:14:04'),
(1451, '2021-12-03', 12, 378, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-12-03 23:16:09'),
(1452, '2021-12-03', 12, 379, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-03 23:16:56'),
(1453, '2021-12-03', 12, 371, 10, 2, 2, 4, 11, 'SI', 375, 13, 16, '', 1, '2021-12-03 23:17:37'),
(1454, '2021-12-03', 12, 380, 10, 2, 1, 13, 9, 'SI', 383, 4, 14, '', 1, '2021-12-03 23:19:31'),
(1455, '2021-12-04', 10, 377, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2021-12-05 00:25:33'),
(1456, '2021-12-04', 10, 375, 8, 2, 2, 4, 11, 'SI', 380, 9, 16, '', 1, '2021-12-05 00:26:47'),
(1457, '2021-12-04', 10, 366, 8, 2, 2, 11, 0, 'SI', 371, 9, 16, '', 1, '2021-12-05 00:27:55'),
(1458, '2021-12-04', 10, 358, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-12-05 00:28:58'),
(1459, '2021-12-06', 12, 379, 10, 2, 2, 3, 10, 'SI', 384, 13, 14, '', 1, '2021-12-06 23:35:02'),
(1460, '2021-12-06', 12, 376, 10, 2, 2, 13, 11, 'SI', 382, 4, 16, '', 1, '2021-12-06 23:35:40'),
(1461, '2021-12-06', 12, 381, 10, 2, 1, 13, 9, 'SI', 385, 4, 14, '', 1, '2021-12-06 23:38:14'),
(1462, '2021-12-09', 10, 375, 8, 2, 2, 4, 11, 'SI', 380, 4, 17, '', 1, '2021-12-10 01:00:42'),
(1463, '2021-12-09', 10, 374, 8, 2, 2, 4, 11, 'SI', 379, 13, 16, '', 1, '2021-12-10 01:04:00'),
(1464, '2021-12-09', 10, 382, 8, 2, 2, 4, 9, 'SI', 386, 13, 14, '', 1, '2021-12-10 01:05:09'),
(1465, '2021-12-09', 10, 358, 8, 2, 2, 4, 11, 'SI', 365, 13, 16, '', 1, '2021-12-10 01:06:36'),
(1466, '2021-12-10', 12, 381, 10, 2, 2, 13, 10, 'SI', 385, 4, 15, '', 1, '2021-12-10 22:45:08'),
(1467, '2021-12-10', 12, 383, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-10 22:46:50'),
(1468, '2021-12-10', 12, 384, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-10 22:47:57'),
(1469, '2021-12-10', 12, 379, 10, 2, 2, 3, 11, 'SI', 384, 13, 16, '', 1, '2021-12-10 22:49:41'),
(1470, '2021-12-11', 12, 370, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-11 15:57:58'),
(1471, '2021-12-11', 12, 371, 10, 3, 1, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-11 15:58:25'),
(1472, '2021-12-11', 12, 376, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-11 15:58:52'),
(1473, '2021-12-11', 12, 378, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-11 15:59:26'),
(1474, '2021-12-11', 12, 363, 10, 3, 1, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-11 15:59:59'),
(1475, '2021-12-11', 10, 384, 8, 2, 2, 4, 9, 'SI', 387, 13, 14, '', 1, '2021-12-12 00:39:58'),
(1476, '2021-12-11', 10, 385, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-12 00:41:27'),
(1477, '2021-12-11', 10, 379, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-12 00:42:03'),
(1478, '2021-12-11', 10, 382, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2021-12-12 00:42:59'),
(1479, '2021-12-11', 10, 377, 8, 2, 2, 4, 11, 'SI', 381, 9, 15, '', 1, '2021-12-12 00:44:23'),
(1480, '2021-12-11', 10, 375, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-12 00:45:28'),
(1481, '2021-12-11', 10, 372, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-12 00:46:26'),
(1482, '2021-12-11', 10, 386, 8, 2, 2, 8, 0, 'SI', 388, 4, 14, '', 1, '2021-12-12 00:52:17'),
(1483, '2021-12-13', 12, 370, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-12-13 23:08:58'),
(1484, '2021-12-13', 12, 371, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-12-13 23:09:28'),
(1485, '2021-12-13', 12, 376, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-12-13 23:09:55'),
(1486, '2021-12-13', 12, 378, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-12-13 23:10:25'),
(1487, '2021-12-13', 12, 363, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-12-13 23:11:30'),
(1488, '2021-12-14', 10, 387, 8, 1, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-15 00:30:07'),
(1489, '2021-12-14', 10, 388, 8, 2, 2, 4, 9, 'SI', 389, 13, 14, '', 1, '2021-12-15 00:35:30'),
(1490, '2021-12-14', 10, 384, 8, 2, 2, 4, 10, 'SI', 387, 13, 15, '', 1, '2021-12-15 00:40:40'),
(1491, '2021-12-14', 10, 382, 8, 2, 2, 4, 11, 'SI', 386, 4, 15, '', 1, '2021-12-15 00:45:51'),
(1492, '2021-12-14', 10, 385, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-15 00:51:23'),
(1493, '2021-12-15', 12, 363, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-12-15 23:08:25'),
(1494, '2021-12-15', 12, 371, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-12-15 23:08:53'),
(1495, '2021-12-15', 12, 370, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-12-15 23:09:21'),
(1496, '2021-12-15', 12, 376, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-12-15 23:09:51'),
(1497, '2021-12-15', 12, 378, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2021-12-15 23:10:16'),
(1498, '2021-12-16', 10, 388, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2021-12-17 04:19:38'),
(1499, '2021-12-16', 10, 384, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2021-12-17 04:27:35'),
(1500, '2021-12-16', 10, 379, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-17 04:33:45'),
(1501, '2021-12-16', 10, 382, 8, 2, 2, 4, 11, 'SI', 386, 4, 15, '', 1, '2021-12-17 04:41:42'),
(1502, '2021-12-16', 10, 358, 8, 3, 2, 6, 14, 'NO', 0, 0, 0, '', 1, '2021-12-17 04:45:06'),
(1503, '2021-12-16', 10, 387, 8, 2, 2, 4, 10, 'SI', 390, 13, 14, '', 1, '2021-12-17 04:49:20'),
(1504, '2021-12-17', 12, 389, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-12-17 23:51:01'),
(1505, '2021-12-17', 12, 390, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-12-17 23:51:47'),
(1506, '2021-12-17', 12, 370, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-12-17 23:52:09'),
(1507, '2021-12-17', 12, 378, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-12-17 23:52:30'),
(1508, '2021-12-18', 10, 360, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-18 23:15:16'),
(1509, '2021-12-18', 10, 343, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-18 23:17:49'),
(1510, '2021-12-18', 10, 352, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-18 23:19:44'),
(1511, '2021-12-18', 10, 335, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-18 23:20:26'),
(1512, '2021-12-18', 10, 372, 8, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2021-12-18 23:21:01'),
(1513, '2021-12-18', 10, 361, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-18 23:22:27'),
(1514, '2021-12-20', 12, 390, 10, 2, 2, 13, 10, 'NO', 0, 0, 0, '', 1, '2021-12-20 23:16:38'),
(1515, '2021-12-20', 12, 391, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2021-12-20 23:19:48'),
(1516, '2021-12-20', 12, 371, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-12-20 23:22:02'),
(1517, '2021-12-20', 12, 376, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2021-12-20 23:22:43'),
(1518, '2021-12-20', 12, 363, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2021-12-20 23:25:35'),
(1519, '2021-12-21', 10, 388, 8, 1, 2, 8, 0, 'SI', 392, 12, 14, '', 1, '2021-12-21 20:57:30'),
(1520, '2021-12-21', 10, 385, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-21 21:32:03'),
(1521, '2021-12-21', 10, 384, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-21 22:02:51'),
(1522, '2021-12-21', 10, 375, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-12-21 22:20:23'),
(1523, '2021-12-21', 10, 358, 8, 3, 2, 9, 15, 'NO', 0, 0, 0, '', 1, '2021-12-21 23:07:15'),
(1524, '2021-12-21', 10, 379, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-12-22 00:26:51'),
(1525, '2021-12-22', 12, 389, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-22 23:16:23'),
(1526, '2021-12-22', 12, 390, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-22 23:16:41'),
(1527, '2021-12-22', 12, 383, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-22 23:17:15'),
(1528, '2021-12-22', 12, 391, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-22 23:17:49'),
(1529, '2021-12-22', 12, 380, 10, 2, 2, 8, 0, 'SI', 383, 4, 15, '', 1, '2021-12-22 23:19:40'),
(1530, '2021-12-23', 10, 392, 8, 1, 2, 8, 0, 'SI', 393, 12, 14, '', 1, '2021-12-23 21:14:33'),
(1531, '2021-12-23', 10, 367, 8, 1, 2, 8, 0, 'SI', 376, 12, 14, '', 1, '2021-12-23 21:39:35'),
(1532, '2021-12-23', 10, 386, 8, 2, 2, 8, 0, 'SI', 388, 4, 15, '', 1, '2021-12-23 22:21:32'),
(1533, '2021-12-23', 10, 351, 8, 1, 2, 12, 0, 'SI', 394, 12, 14, '', 1, '2021-12-23 22:27:53'),
(1534, '2021-12-23', 10, 393, 8, 2, 2, 8, 0, 'SI', 395, 20, 14, '', 1, '2021-12-23 23:06:18'),
(1535, '2021-12-27', 12, 394, 10, 2, 1, 4, 9, 'SI', 396, 13, 14, '', 1, '2021-12-27 23:24:18'),
(1536, '2021-12-27', 12, 395, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-27 23:25:48'),
(1537, '2021-12-27', 12, 396, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-27 23:27:37'),
(1538, '2021-12-28', 10, 397, 8, 2, 1, 4, 9, 'SI', 397, 4, 14, '', 1, '2021-12-28 23:28:21'),
(1539, '2021-12-28', 10, 394, 8, 2, 1, 4, 9, 'SI', 396, 13, 14, '', 1, '2021-12-28 23:32:29'),
(1540, '2021-12-28', 10, 396, 8, 2, 2, 2, 9, 'SI', 398, 13, 14, '', 1, '2021-12-28 23:37:18'),
(1541, '2021-12-30', 12, 389, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-12-30 21:16:22'),
(1542, '2021-12-30', 12, 390, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-12-30 21:17:14'),
(1543, '2021-12-30', 12, 380, 10, 2, 2, 8, 0, 'SI', 383, 4, 16, '', 1, '2021-12-30 21:19:15'),
(1544, '2021-12-30', 12, 391, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2021-12-30 21:19:59'),
(1545, '2021-12-30', 12, 383, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2021-12-30 21:20:45'),
(1546, '2021-12-30', 10, 397, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-30 23:39:55'),
(1547, '2021-12-30', 10, 394, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2021-12-30 23:40:32'),
(1548, '2021-12-30', 10, 396, 8, 2, 2, 2, 9, 'NO', 0, 0, 0, '', 1, '2021-12-30 23:41:17'),
(1549, '2021-12-30', 10, 386, 8, 2, 2, 4, 9, 'SI', 388, 4, 14, '', 1, '2021-12-30 23:42:33'),
(1550, '2021-12-30', 10, 398, 8, 2, 2, 8, 0, 'SI', 399, 4, 14, '', 1, '2021-12-30 23:44:09'),
(1551, '2021-12-30', 10, 400, 8, 2, 2, 8, 0, 'SI', 400, 13, 14, '', 1, '2021-12-30 23:45:28'),
(1552, '2021-12-31', 10, 387, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-31 17:12:47'),
(1553, '2021-12-31', 10, 360, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-31 17:14:14'),
(1554, '2021-12-31', 10, 385, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2021-12-31 17:17:21'),
(1555, '2021-12-31', 10, 379, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2021-12-31 17:17:55'),
(1556, '2022-01-03', 12, 389, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2022-01-03 23:20:45'),
(1557, '2022-01-03', 12, 391, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2022-01-03 23:21:10'),
(1558, '2022-01-03', 12, 383, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2022-01-03 23:21:40'),
(1559, '2022-01-04', 10, 394, 8, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2022-01-04 23:58:33'),
(1560, '2022-01-04', 10, 402, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-05 00:16:56'),
(1561, '2022-01-04', 10, 403, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-05 00:25:29'),
(1562, '2022-01-04', 10, 404, 8, 2, 2, 4, 9, 'SI', 401, 13, 14, '', 1, '2022-01-05 00:27:24'),
(1563, '2022-01-04', 10, 386, 8, 2, 2, 4, 3, 'SI', 388, 4, 14, '', 1, '2022-01-05 00:30:49'),
(1564, '2022-01-04', 10, 372, 8, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2022-01-05 00:32:48'),
(1565, '2022-01-05', 12, 383, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2022-01-05 22:47:14'),
(1566, '2022-01-05', 12, 389, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2022-01-05 22:47:44'),
(1567, '2022-01-05', 12, 391, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2022-01-05 22:48:13'),
(1568, '2022-01-05', 12, 390, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2022-01-05 22:48:43'),
(1569, '2021-01-06', 10, 386, 8, 2, 2, 3, 11, 'SI', 388, 4, 14, '', 1, '2022-01-07 00:13:34'),
(1570, '2021-01-06', 10, 397, 8, 2, 2, 4, 11, 'SI', 397, 13, 14, '', 1, '2022-01-07 00:16:30'),
(1571, '2022-01-06', 10, 405, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-07 00:21:29'),
(1572, '2022-01-06', 10, 386, 8, 2, 2, 3, 9, 'SI', 388, 4, 14, '', 1, '2022-01-07 00:27:32'),
(1573, '2022-01-06', 10, 397, 8, 2, 2, 4, 9, 'SI', 397, 13, 14, '', 1, '2022-01-07 00:28:34'),
(1574, '2022-01-08', 10, 406, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-09 00:45:57'),
(1575, '2022-01-08', 10, 407, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-09 00:46:32'),
(1576, '2022-01-08', 10, 400, 8, 2, 2, 8, 0, 'SI', 400, 13, 15, '', 1, '2022-01-09 00:47:41'),
(1577, '2022-01-08', 10, 408, 8, 2, 2, 4, 9, 'SI', 402, 13, 14, '', 1, '2022-01-09 00:50:14'),
(1578, '2022-01-11', 10, 386, 8, 3, 2, 6, 14, 'NO', 0, 0, 0, '', 1, '2022-01-11 23:16:08'),
(1579, '2022-01-11', 10, 372, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-01-11 23:17:48'),
(1580, '2022-01-11', 10, 404, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-01-11 23:20:08'),
(1581, '2022-01-11', 10, 398, 8, 1, 2, 8, 0, 'SI', 399, 12, 0, '', 1, '2022-01-11 23:22:43'),
(1582, '2022-01-11', 10, 409, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-01-11 23:29:01'),
(1583, '2022-01-11', 10, 402, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-01-11 23:30:31'),
(1584, '2022-01-06', 10, 368, 8, 2, 2, 4, 9, 'SI', 373, 13, 0, '', 1, '2022-01-11 23:33:40'),
(1585, '2022-01-13', 10, 410, 8, 2, 2, 4, 9, 'SI', 403, 4, 14, '', 1, '2022-01-13 23:11:01'),
(1586, '2022-01-13', 10, 412, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-13 23:20:02'),
(1587, '2022-01-13', 10, 413, 8, 2, 2, 4, 9, 'SI', 405, 4, 9, '', 1, '2022-01-13 23:29:40'),
(1588, '2022-01-13', 10, 411, 8, 2, 2, 3, 0, 'SI', 404, 13, 14, '', 1, '2022-01-14 00:25:08'),
(1589, '2022-01-15', 10, 414, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-15 22:56:44'),
(1590, '2022-01-15', 10, 412, 8, 2, 2, 4, 10, 'SI', 406, 20, 14, '', 1, '2022-01-15 23:07:30'),
(1591, '2022-01-15', 10, 415, 8, 2, 2, 3, 9, 'SI', 407, 13, 14, '', 1, '2022-01-15 23:19:07'),
(1592, '2022-01-15', 10, 416, 8, 2, 2, 4, 9, 'SI', 408, 4, 14, '', 1, '2022-01-15 23:40:50'),
(1593, '2022-01-15', 10, 417, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-15 23:49:11'),
(1594, '2022-01-15', 10, 418, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-16 00:00:44'),
(1595, '2022-01-18', 10, 419, 8, 2, 2, 13, 9, 'SI', 409, 13, 14, '', 1, '2022-01-18 23:13:58'),
(1596, '2022-01-18', 10, 420, 8, 2, 2, 4, 9, 'SI', 410, 20, 14, '', 1, '2022-01-18 23:21:26'),
(1597, '2022-01-18', 10, 421, 8, 2, 2, 13, 9, 'SI', 411, 4, 14, '', 1, '2022-01-18 23:29:19'),
(1598, '2022-01-18', 10, 418, 8, 2, 2, 4, 9, 'SI', 412, 13, 14, '', 1, '2022-01-18 23:37:28'),
(1599, '2022-01-18', 10, 414, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-01-19 00:02:45'),
(1600, '2022-01-20', 10, 423, 8, 2, 2, 4, 9, 'SI', 414, 13, 14, '', 1, '2022-01-20 23:21:44'),
(1601, '2022-01-20', 10, 424, 8, 2, 2, 4, 9, 'SI', 415, 4, 14, '', 1, '2022-01-20 23:31:11'),
(1602, '2022-01-20', 10, 425, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-20 23:40:57'),
(1603, '2022-01-20', 10, 426, 8, 2, 2, 13, 9, 'SI', 416, 13, 14, '', 1, '2022-01-20 23:58:07'),
(1604, '2022-01-20', 10, 427, 8, 2, 2, 4, 9, 'SI', 417, 13, 0, '', 1, '2022-01-21 00:09:18'),
(1605, '2022-01-20', 10, 428, 8, 2, 2, 4, 9, 'SI', 418, 13, 14, '', 1, '2022-01-21 00:20:17'),
(1606, '2022-01-20', 10, 429, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-01-21 00:24:42'),
(1607, '2022-01-20', 10, 430, 8, 2, 2, 13, 9, 'SI', 419, 13, 14, '', 1, '2022-01-21 00:37:12'),
(1608, '2022-01-20', 10, 431, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 00:43:06'),
(1609, '2022-01-20', 10, 432, 8, 2, 2, 4, 9, 'SI', 420, 9, 14, '', 1, '2022-01-21 00:50:37'),
(1610, '2022-01-20', 10, 433, 8, 2, 2, 4, 9, 'SI', 421, 4, 14, '', 1, '2022-01-21 00:59:05'),
(1611, '2022-01-21', 12, 418, 10, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 23:15:34'),
(1612, '2022-01-21', 12, 415, 10, 2, 2, 4, 9, 'SI', 422, 13, 14, '', 1, '2022-01-21 23:18:43'),
(1613, '2022-01-21', 12, 425, 10, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 23:19:56'),
(1614, '2022-01-21', 12, 434, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 23:21:33'),
(1615, '2022-01-21', 12, 428, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 23:22:36'),
(1616, '2022-01-21', 12, 435, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 23:23:54'),
(1617, '2022-01-21', 12, 436, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-21 23:24:50'),
(1618, '2022-01-22', 10, 437, 8, 2, 2, 13, 9, 'SI', 423, 13, 14, '', 1, '2022-01-22 18:15:56'),
(1619, '2022-01-22', 10, 438, 8, 2, 2, 8, 0, 'SI', 424, 4, 14, '', 1, '2022-01-22 18:36:59'),
(1620, '2022-01-22', 10, 423, 8, 2, 2, 4, 10, 'SI', 414, 13, 15, '', 1, '2022-01-22 18:39:55'),
(1621, '2022-01-22', 10, 435, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-01-22 19:03:34'),
(1622, '2022-01-22', 10, 439, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-01-22 19:16:20'),
(1623, '2022-01-22', 10, 427, 8, 2, 2, 4, 10, 'SI', 417, 13, 14, '', 1, '2022-01-22 23:26:12');
INSERT INTO `psyem_seguimiento` (`idSeguimiento`, `fRegistrSeg`, `idUsuario`, `idAtencionPac`, `idProfesional`, `idTipoSeguimiento`, `idMotSeguimiento`, `idDiag1Seg`, `idDiag2Seg`, `comunFamSeg`, `idFamAtSeg`, `idDiag1SegFam`, `idDiag2SegFam`, `obsSeg`, `idStatusSeg`, `registroSistema`) VALUES
(1624, '2022-01-22', 10, 435, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 2, '2022-01-22 23:39:11'),
(1625, '2022-01-22', 10, 440, 8, 2, 2, 3, 9, 'SI', 425, 13, 14, '', 1, '2022-01-22 23:44:30'),
(1626, '2022-01-22', 10, 424, 8, 2, 2, 4, 10, 'SI', 415, 4, 14, '', 1, '2022-01-22 23:49:19'),
(1627, '2022-01-22', 10, 434, 8, 2, 2, 4, 9, 'SI', 427, 4, 14, '', 1, '2022-01-23 00:13:40'),
(1628, '2022-01-22', 10, 442, 8, 2, 2, 4, 9, 'SI', 428, 4, 14, '', 1, '2022-01-23 00:25:50'),
(1629, '2022-01-22', 10, 443, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-23 00:31:14'),
(1630, '2022-01-22', 10, 436, 8, 3, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-23 00:35:54'),
(1631, '2022-01-24', 12, 444, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-24 23:59:31'),
(1632, '2022-01-24', 12, 445, 10, 2, 1, 13, 9, 'SI', 429, 4, 14, '', 1, '2022-01-25 00:01:37'),
(1633, '2022-01-24', 12, 446, 10, 2, 1, 13, 9, 'SI', 430, 4, 14, '', 1, '2022-01-25 00:03:24'),
(1634, '2022-01-24', 12, 447, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-25 00:04:42'),
(1635, '2022-01-24', 12, 448, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-25 00:05:35'),
(1636, '2022-01-24', 12, 449, 10, 2, 1, 4, 9, 'SI', 431, 4, 14, '', 1, '2022-01-25 00:07:47'),
(1637, '2022-01-24', 12, 450, 10, 2, 1, 13, 9, 'SI', 432, 4, 14, '', 1, '2022-01-25 00:09:41'),
(1638, '2022-01-24', 12, 451, 10, 2, 1, 4, 9, 'SI', 433, 13, 14, '', 1, '2022-01-25 00:11:18'),
(1639, '2022-01-25', 10, 440, 8, 2, 2, 3, 9, 'SI', 425, 13, 16, '', 1, '2022-01-26 00:18:56'),
(1640, '2022-01-25', 10, 452, 8, 2, 2, 4, 9, 'SI', 434, 13, 14, '', 1, '2022-01-26 00:19:54'),
(1641, '2022-01-25', 10, 442, 8, 2, 2, 4, 9, 'SI', 428, 9, 14, '', 1, '2022-01-26 00:20:51'),
(1642, '2022-01-25', 10, 453, 8, 2, 2, 4, 9, 'SI', 435, 9, 14, '', 1, '2022-01-26 00:23:24'),
(1643, '2022-01-25', 10, 430, 8, 2, 2, 3, 9, 'SI', 419, 13, 14, '', 1, '2022-01-26 00:24:38'),
(1644, '2022-01-25', 10, 454, 8, 2, 2, 4, 9, 'SI', 436, 4, 14, '', 1, '2022-01-26 00:26:55'),
(1645, '2022-01-25', 10, 447, 8, 2, 2, 4, 9, 'SI', 437, 13, 14, '', 1, '2022-01-26 00:28:48'),
(1646, '2022-01-25', 10, 455, 8, 2, 2, 4, 9, 'SI', 438, 13, 14, '', 1, '2022-01-26 00:30:57'),
(1647, '2022-01-25', 10, 456, 8, 2, 2, 3, 9, 'SI', 439, 13, 14, '', 1, '2022-01-26 00:33:31'),
(1648, '2022-01-25', 10, 443, 8, 2, 2, 4, 9, 'SI', 440, 13, 14, '', 1, '2022-01-26 00:37:26'),
(1649, '2022-01-26', 12, 446, 10, 2, 2, 13, 10, 'SI', 430, 4, 15, '', 1, '2022-01-26 20:17:24'),
(1650, '2022-01-26', 12, 445, 10, 2, 2, 4, 10, 'SI', 429, 4, 15, '', 1, '2022-01-26 20:18:31'),
(1651, '2022-01-26', 12, 437, 10, 2, 2, 4, 9, 'SI', 423, 13, 14, '', 1, '2022-01-26 20:19:16'),
(1652, '2022-01-26', 12, 449, 10, 2, 2, 4, 10, 'SI', 431, 4, 15, '', 1, '2022-01-26 20:21:33'),
(1653, '2022-01-26', 12, 450, 10, 2, 2, 13, 10, 'SI', 432, 4, 15, '', 1, '2022-01-26 20:23:39'),
(1654, '2022-01-26', 12, 451, 10, 2, 2, 4, 10, 'SI', 433, 13, 15, '', 1, '2022-01-26 20:24:39'),
(1655, '2022-01-26', 12, 457, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-01-26 23:17:07'),
(1656, '2022-01-26', 12, 432, 10, 2, 2, 13, 9, 'SI', 420, 13, 14, '', 1, '2022-01-26 23:18:44'),
(1657, '2022-01-27', 10, 438, 8, 2, 2, 8, 0, 'SI', 424, 4, 14, '', 1, '2022-01-27 23:52:37'),
(1658, '2022-01-27', 10, 458, 8, 2, 2, 4, 0, 'SI', 441, 13, 14, '', 1, '2022-01-28 00:18:33'),
(1659, '2022-01-27', 10, 425, 8, 2, 2, 4, 10, 'SI', 442, 13, 0, '', 1, '2022-01-28 00:25:09'),
(1660, '2022-01-27', 10, 460, 8, 2, 2, 4, 9, 'SI', 444, 9, 14, '', 1, '2022-01-28 00:40:30'),
(1661, '2022-01-27', 10, 459, 8, 2, 2, 4, 9, 'SI', 443, 9, 14, '', 1, '2022-01-28 00:42:42'),
(1662, '2022-01-27', 10, 461, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-01-28 00:59:46'),
(1663, '2022-01-27', 10, 462, 8, 2, 2, 8, 0, 'SI', 445, 4, 14, '', 1, '2022-01-28 01:06:10'),
(1664, '2022-01-27', 10, 463, 8, 2, 2, 4, 9, 'SI', 446, 13, 14, '', 1, '2022-01-28 01:12:52'),
(1665, '2022-01-27', 10, 464, 8, 2, 2, 4, 9, 'SI', 447, 13, 14, '', 1, '2022-01-28 01:21:05'),
(1666, '2022-01-22', 10, 467, 8, 2, 2, 3, 9, 'NO', 0, 0, 0, '', 1, '2022-01-28 01:38:19'),
(1667, '2022-01-27', 10, 465, 8, 2, 2, 4, 9, 'SI', 449, 13, 14, '', 1, '2022-01-28 01:54:29'),
(1668, '2022-01-28', 12, 449, 10, 2, 2, 4, 11, 'SI', 431, 4, 16, '', 1, '2022-01-28 23:06:58'),
(1669, '2022-01-28', 12, 468, 10, 2, 1, 4, 9, 'SI', 450, 4, 14, '', 1, '2022-01-28 23:10:03'),
(1670, '2022-01-28', 12, 452, 10, 2, 2, 4, 9, 'SI', 434, 4, 14, '', 1, '2022-01-28 23:11:38'),
(1671, '2022-01-28', 12, 469, 10, 2, 1, 4, 9, 'SI', 451, 4, 14, '', 1, '2022-01-28 23:13:28'),
(1672, '2022-01-28', 12, 451, 10, 2, 2, 4, 11, 'SI', 433, 13, 16, '', 1, '2022-01-28 23:14:26'),
(1673, '2022-01-28', 12, 456, 10, 2, 2, 4, 9, 'SI', 439, 13, 14, '', 1, '2022-01-28 23:16:38'),
(1674, '2022-01-29', 10, 471, 8, 1, 2, 8, 0, 'SI', 453, 12, 14, '', 1, '2022-01-29 23:47:06'),
(1675, '2022-01-29', 10, 433, 8, 1, 2, 8, 0, 'SI', 421, 12, 14, '', 1, '2022-01-30 00:01:37'),
(1676, '2022-01-29', 10, 474, 8, 1, 2, 8, 0, 'SI', 454, 12, 14, '', 1, '2022-01-30 00:08:21'),
(1677, '2022-01-29', 10, 475, 8, 2, 2, 13, 9, 'SI', 455, 13, 14, '', 1, '2022-01-30 03:03:04'),
(1678, '2022-01-29', 10, 476, 8, 2, 2, 4, 9, 'SI', 456, 13, 14, '', 1, '2022-01-30 03:16:15'),
(1679, '2022-01-29', 10, 441, 8, 2, 2, 4, 10, 'SI', 426, 4, 14, '', 1, '2022-01-30 03:25:39'),
(1680, '2022-01-29', 10, 477, 8, 2, 2, 3, 9, 'SI', 457, 13, 14, '', 1, '2022-01-30 03:43:26'),
(1681, '2022-01-29', 10, 478, 8, 2, 2, 4, 9, 'SI', 458, 13, 14, '', 1, '2022-01-30 03:53:21'),
(1682, '2022-01-29', 10, 463, 8, 2, 2, 4, 10, 'SI', 446, 13, 14, '', 1, '2022-01-30 03:57:54'),
(1683, '2022-01-29', 10, 479, 8, 2, 2, 4, 9, 'SI', 459, 4, 14, '', 1, '2022-01-30 04:24:02'),
(1684, '2022-01-29', 10, 480, 8, 2, 2, 4, 9, 'SI', 460, 13, 14, '', 1, '2022-01-30 04:39:45'),
(1685, '2022-01-29', 10, 453, 8, 2, 2, 4, 10, 'SI', 435, 4, 14, '', 1, '2022-01-30 04:41:41'),
(1686, '2022-01-31', 12, 481, 10, 2, 1, 4, 9, 'SI', 461, 4, 14, '', 1, '2022-01-31 16:19:14'),
(1687, '2022-01-31', 12, 480, 10, 2, 1, 13, 0, 'SI', 460, 13, 14, '', 1, '2022-01-31 16:23:59'),
(1688, '2022-01-31', 12, 457, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2022-01-31 16:25:08'),
(1689, '2022-01-31', 12, 468, 10, 2, 2, 4, 10, 'SI', 450, 4, 15, '', 1, '2022-01-31 16:26:21'),
(1690, '2022-01-31', 12, 482, 10, 2, 1, 2, 9, 'NO', 0, 0, 0, '', 1, '2022-01-31 16:31:17'),
(1691, '2022-01-31', 10, 483, 8, 2, 2, 4, 9, 'SI', 463, 13, 14, '', 1, '2022-01-31 16:36:34'),
(1692, '2022-01-31', 10, 453, 8, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2022-01-31 16:39:42'),
(1693, '2022-01-31', 10, 486, 8, 2, 2, 4, 9, 'SI', 465, 13, 15, '', 1, '2022-01-31 17:16:09'),
(1694, '2022-02-01', 10, 453, 8, 2, 2, 4, 11, 'SI', 435, 4, 16, '', 1, '2022-02-02 02:37:32'),
(1695, '2022-02-01', 10, 466, 8, 2, 2, 4, 10, 'SI', 466, 9, 14, '', 1, '2022-02-02 02:53:45'),
(1696, '2022-02-01', 10, 475, 8, 2, 2, 4, 10, 'SI', 455, 4, 15, '', 1, '2022-02-02 03:09:58'),
(1697, '2022-02-01', 10, 484, 8, 2, 2, 4, 9, 'SI', 464, 4, 15, '', 1, '2022-02-02 03:25:21'),
(1698, '2022-02-01', 10, 487, 8, 2, 2, 3, 9, 'SI', 467, 9, 14, '', 1, '2022-02-02 03:34:40'),
(1699, '2022-02-01', 10, 454, 8, 2, 2, 4, 9, 'SI', 436, 4, 14, '', 1, '2022-02-02 03:40:13'),
(1700, '2022-02-01', 10, 488, 8, 2, 2, 3, 9, 'SI', 468, 9, 14, '', 1, '2022-02-02 04:10:46'),
(1701, '2022-02-01', 10, 489, 8, 2, 2, 4, 0, 'SI', 469, 4, 14, '', 1, '2022-02-02 04:19:29'),
(1702, '2022-02-01', 10, 483, 8, 2, 2, 4, 9, 'SI', 463, 13, 15, '', 1, '2022-02-02 04:28:31'),
(1703, '2022-02-01', 10, 477, 8, 2, 2, 3, 9, 'NO', 0, 0, 0, '', 1, '2022-02-02 04:31:33'),
(1704, '2022-02-01', 10, 434, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-02-02 04:35:39'),
(1705, '2022-02-01', 10, 476, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-02-02 04:40:17'),
(1706, '2022-02-02', 12, 490, 10, 2, 1, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-02-02 21:47:45'),
(1707, '2022-02-02', 12, 468, 10, 2, 2, 4, 11, 'SI', 470, 13, 14, '', 1, '2022-02-02 21:58:40'),
(1708, '2022-02-02', 12, 488, 10, 2, 2, 4, 10, 'SI', 468, 4, 15, '', 1, '2022-02-02 22:02:06'),
(1709, '2022-02-02', 12, 480, 10, 2, 2, 13, 10, 'SI', 460, 13, 15, '', 1, '2022-02-02 22:04:07'),
(1710, '2022-02-02', 12, 491, 10, 2, 1, 13, 9, 'SI', 471, 13, 14, '', 1, '2022-02-02 22:07:39'),
(1711, '2022-02-02', 12, 457, 10, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2022-02-02 22:08:13'),
(1712, '2022-02-02', 12, 432, 10, 2, 2, 4, 10, 'SI', 472, 13, 15, '', 1, '2022-02-02 22:13:33'),
(1713, '2022-02-02', 12, 453, 10, 2, 2, 4, 9, 'SI', 435, 4, 14, '', 1, '2022-02-02 22:18:32'),
(1714, '2022-02-02', 12, 448, 10, 2, 2, 4, 10, 'NO', 0, 0, 0, '', 1, '2022-02-02 23:44:37'),
(1715, '2022-02-03', 10, 493, 8, 2, 2, 4, 9, 'SI', 473, 4, 14, '', 1, '2022-02-03 16:54:26'),
(1716, '2022-02-03', 10, 441, 8, 2, 2, 4, 11, 'SI', 426, 9, 16, '', 1, '2022-02-04 03:09:37'),
(1717, '2022-02-03', 10, 494, 8, 2, 2, 4, 9, 'SI', 475, 3, 14, '', 1, '2022-02-04 03:25:42'),
(1718, '2022-02-03', 10, 434, 8, 2, 2, 4, 9, 'SI', 427, 4, 14, '', 1, '2022-02-04 03:28:29'),
(1719, '2022-02-03', 10, 460, 8, 2, 2, 4, 10, 'SI', 444, 13, 15, '', 1, '2022-02-04 03:30:30'),
(1720, '2022-02-03', 10, 487, 8, 2, 2, 3, 9, 'NO', 0, 0, 0, '', 1, '2022-02-04 03:35:28'),
(1721, '2022-02-03', 10, 484, 8, 2, 2, 4, 11, 'SI', 476, 13, 15, '', 1, '2022-02-04 03:43:15'),
(1722, '2022-02-03', 10, 483, 8, 2, 2, 4, 9, 'SI', 463, 13, 15, '', 1, '2022-02-04 03:44:45'),
(1723, '2022-02-03', 10, 466, 8, 2, 2, 4, 11, 'SI', 466, 13, 16, '', 1, '2022-02-04 03:47:43'),
(1724, '2022-02-03', 10, 453, 8, 2, 2, 4, 11, 'SI', 435, 4, 17, '', 1, '2022-02-04 03:48:58'),
(1725, '2022-02-04', 12, 491, 10, 2, 2, 13, 10, 'SI', 471, 13, 15, '', 1, '2022-02-04 21:28:13'),
(1726, '2022-02-04', 12, 488, 10, 2, 2, 4, 11, 'SI', 468, 4, 16, '', 1, '2022-02-04 21:30:18'),
(1727, '2022-02-04', 12, 468, 10, 2, 2, 4, 11, 'SI', 470, 13, 15, '', 1, '2022-02-04 21:31:48'),
(1728, '2022-02-04', 12, 468, 10, 2, 2, 4, 11, 'SI', 450, 4, 16, '', 1, '2022-02-04 21:32:54'),
(1729, '2022-02-04', 12, 452, 10, 2, 2, 8, 0, 'SI', 434, 4, 15, '', 1, '2022-02-04 21:34:33'),
(1730, '2022-02-04', 12, 469, 10, 2, 2, 4, 10, 'SI', 451, 4, 15, '', 1, '2022-02-04 21:38:04'),
(1731, '2022-02-04', 12, 495, 10, 2, 1, 4, 9, 'SI', 477, 13, 14, '', 1, '2022-02-04 21:41:10'),
(1732, '2022-02-04', 12, 482, 10, 2, 2, 2, 10, 'SI', 478, 13, 14, '', 1, '2022-02-04 22:01:22'),
(1733, '2022-02-04', 12, 448, 10, 2, 2, 4, 11, 'NO', 0, 0, 0, '', 1, '2022-02-04 22:03:21'),
(1734, '2022-02-05', 12, 491, 10, 2, 2, 13, 11, 'SI', 471, 13, 16, '', 1, '2022-02-05 15:52:32'),
(1735, '2022-02-05', 12, 482, 10, 2, 2, 2, 11, 'SI', 478, 13, 15, '', 1, '2022-02-05 15:55:00'),
(1736, '2022-02-05', 12, 495, 10, 2, 2, 4, 10, 'SI', 477, 13, 15, '', 1, '2022-02-05 15:56:11'),
(1737, '2022-02-05', 12, 486, 10, 2, 2, 13, 9, 'SI', 465, 13, 14, '', 1, '2022-02-05 15:58:43'),
(1738, '2022-02-05', 10, 453, 8, 2, 2, 4, 11, 'SI', 435, 4, 17, '', 1, '2022-02-06 18:35:02'),
(1739, '2022-02-05', 10, 460, 8, 2, 2, 4, 11, 'SI', 444, 13, 16, '', 1, '2022-02-06 18:45:47'),
(1740, '2022-02-05', 10, 441, 8, 2, 2, 4, 11, 'SI', 426, 4, 16, '', 1, '2022-02-06 18:50:51'),
(1741, '2022-02-05', 10, 475, 8, 2, 2, 4, 11, 'SI', 455, 4, 16, '', 1, '2022-02-06 18:55:05'),
(1742, '2022-02-05', 10, 488, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-06 20:23:24'),
(1743, '2022-02-05', 10, 480, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-06 20:24:06'),
(1744, '2022-02-05', 10, 457, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-06 20:24:58'),
(1745, '2022-02-05', 10, 490, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-06 20:25:31'),
(1746, '2022-02-05', 10, 496, 8, 2, 2, 4, 9, 'SI', 479, 13, 14, '', 1, '2022-02-06 20:53:20'),
(1747, '2022-02-05', 10, 434, 8, 2, 2, 4, 11, 'SI', 427, 4, 16, '', 1, '2022-02-06 21:02:21'),
(1748, '2022-02-05', 10, 494, 8, 2, 2, 4, 9, 'SI', 475, 3, 14, '', 1, '2022-02-06 21:58:18'),
(1749, '2022-02-07', 12, 495, 10, 2, 2, 4, 11, 'SI', 477, 13, 0, '', 1, '2022-02-07 21:29:27'),
(1750, '2022-02-07', 12, 482, 10, 2, 2, 2, 11, 'SI', 478, 13, 16, '', 1, '2022-02-07 21:30:44'),
(1751, '2022-02-07', 12, 448, 10, 2, 2, 4, 11, 'SI', 480, 13, 15, '', 1, '2022-02-07 21:34:26'),
(1752, '2022-02-07', 12, 497, 10, 2, 2, 4, 9, 'SI', 481, 13, 14, '', 1, '2022-02-07 21:37:47'),
(1753, '2022-02-07', 12, 468, 10, 1, 2, 8, 0, 'SI', 470, 12, 16, '', 1, '2022-02-07 21:39:30'),
(1754, '2022-02-07', 12, 468, 10, 1, 2, 8, 0, 'SI', 450, 12, 17, '', 1, '2022-02-07 21:40:19'),
(1755, '2022-02-09', 12, 498, 10, 2, 1, 4, 9, 'SI', 482, 13, 14, '', 1, '2022-02-09 21:44:51'),
(1756, '2022-02-09', 12, 497, 10, 2, 2, 4, 10, 'SI', 481, 13, 15, '', 1, '2022-02-09 21:45:57'),
(1757, '2022-02-09', 12, 452, 10, 2, 2, 8, 0, 'SI', 434, 4, 17, '', 1, '2022-02-09 21:46:47'),
(1758, '2022-02-09', 12, 482, 10, 2, 2, 2, 11, 'SI', 478, 13, 17, '', 1, '2022-02-09 21:50:21'),
(1759, '2022-02-09', 12, 495, 10, 2, 2, 4, 11, 'SI', 477, 13, 17, '', 1, '2022-02-09 21:51:24'),
(1760, '2022-02-09', 12, 448, 10, 2, 2, 4, 11, 'SI', 480, 13, 16, '', 1, '2022-02-09 21:52:47'),
(1761, '2022-02-08', 10, 489, 8, 2, 2, 8, 0, 'SI', 483, 13, 0, '', 1, '2022-02-10 03:18:24'),
(1762, '2022-02-08', 10, 453, 8, 2, 2, 4, 11, 'SI', 435, 4, 17, '', 1, '2022-02-10 04:48:10'),
(1763, '2022-02-08', 10, 460, 8, 2, 2, 4, 11, 'SI', 444, 13, 17, '', 1, '2022-02-10 04:49:34'),
(1764, '2022-02-08', 10, 475, 8, 2, 2, 4, 11, 'SI', 455, 11, 17, '', 1, '2022-02-10 04:50:34'),
(1765, '2022-02-08', 10, 441, 8, 2, 2, 4, 11, 'SI', 426, 4, 17, '', 1, '2022-02-10 04:51:52'),
(1766, '2022-02-10', 10, 496, 8, 2, 2, 4, 10, 'SI', 479, 4, 15, '', 1, '2022-02-10 23:57:44'),
(1767, '2022-02-10', 10, 498, 8, 2, 2, 4, 10, 'SI', 482, 9, 15, '', 1, '2022-02-11 00:01:33'),
(1768, '2022-02-10', 10, 494, 8, 2, 2, 4, 9, 'SI', 475, 4, 16, '', 1, '2022-02-11 00:03:59'),
(1769, '2022-02-10', 10, 441, 8, 2, 2, 4, 9, 'SI', 426, 4, 17, '', 1, '2022-02-11 00:05:47'),
(1770, '2022-02-10', 10, 460, 8, 2, 2, 4, 11, 'SI', 444, 13, 17, '', 1, '2022-02-11 00:07:18'),
(1771, '2022-02-10', 10, 453, 8, 2, 2, 4, 11, 'SI', 435, 4, 17, '', 1, '2022-02-11 00:09:06'),
(1772, '2022-02-10', 10, 434, 8, 2, 2, 3, 11, 'SI', 427, 4, 17, '', 1, '2022-02-11 00:10:27'),
(1773, '2022-02-10', 10, 499, 8, 2, 2, 13, 9, 'SI', 484, 13, 14, '', 1, '2022-02-11 00:11:32'),
(1774, '2022-02-11', 12, 451, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-11 17:55:41'),
(1775, '2022-02-11', 12, 448, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-11 17:56:20'),
(1776, '2022-02-11', 12, 449, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-11 17:57:01'),
(1777, '2022-02-11', 12, 457, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-11 17:57:42'),
(1778, '2022-02-11', 12, 432, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-11 17:58:45'),
(1779, '2022-02-11', 12, 480, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-11 17:59:29'),
(1780, '2022-02-11', 12, 500, 10, 2, 1, 4, 9, 'SI', 485, 13, 14, '', 1, '2022-02-11 21:53:40'),
(1781, '2022-02-11', 12, 478, 10, 2, 2, 4, 9, 'SI', 458, 13, 14, '', 1, '2022-02-11 21:56:55'),
(1782, '2022-02-11', 12, 501, 10, 2, 2, 8, 0, 'SI', 487, 4, 14, '', 1, '2022-02-11 21:59:09'),
(1783, '2022-02-12', 10, 497, 8, 2, 2, 4, 9, 'SI', 481, 13, 14, '', 1, '2022-02-13 00:10:19'),
(1784, '2022-02-12', 10, 494, 8, 1, 2, 8, 0, 'SI', 475, 12, 14, '', 1, '2022-02-13 00:13:17'),
(1785, '2022-02-12', 10, 434, 8, 2, 2, 3, 11, 'SI', 427, 4, 17, '', 1, '2022-02-13 00:15:21'),
(1786, '2022-02-12', 10, 496, 8, 2, 2, 4, 10, 'SI', 479, 10, 15, '', 1, '2022-02-13 00:17:11'),
(1787, '2022-02-12', 10, 452, 8, 2, 2, 4, 10, 'SI', 434, 13, 15, '', 1, '2022-02-13 00:18:51'),
(1788, '2022-02-12', 10, 502, 8, 2, 2, 4, 9, 'SI', 488, 13, 14, '', 1, '2022-02-13 00:23:36'),
(1789, '2022-02-12', 10, 478, 8, 2, 2, 3, 9, 'NO', 0, 0, 0, '', 1, '2022-02-13 00:25:02'),
(1790, '2022-02-12', 10, 441, 8, 2, 2, 2, 9, 'SI', 426, 4, 17, '', 1, '2022-02-13 00:26:46'),
(1791, '2022-02-14', 12, 500, 10, 2, 2, 13, 10, 'SI', 485, 13, 15, '', 1, '2022-02-15 00:20:38'),
(1792, '2022-02-14', 12, 497, 10, 2, 2, 4, 11, 'SI', 481, 13, 16, '', 1, '2022-02-15 00:21:21'),
(1793, '2022-02-14', 12, 478, 10, 2, 2, 4, 10, 'SI', 458, 13, 15, '', 1, '2022-02-15 00:22:10'),
(1794, '2022-02-14', 12, 469, 10, 2, 2, 4, 11, 'SI', 451, 4, 16, '', 1, '2022-02-15 00:22:59'),
(1795, '2022-02-14', 12, 501, 10, 2, 2, 8, 0, 'SI', 487, 4, 15, '', 1, '2022-02-15 00:24:00'),
(1796, '2022-02-14', 12, 451, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-15 00:24:26'),
(1797, '2022-02-14', 12, 448, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2022-02-15 00:25:00'),
(1798, '2022-02-14', 12, 449, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-15 00:25:24'),
(1799, '2022-02-15', 10, 453, 8, 2, 2, 4, 11, 'SI', 435, 4, 17, '', 1, '2022-02-16 00:12:26'),
(1800, '2022-02-15', 10, 497, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 00:13:54'),
(1801, '2022-02-15', 10, 499, 8, 2, 2, 4, 10, 'SI', 484, 13, 15, '', 1, '2022-02-16 00:15:27'),
(1802, '2022-02-15', 10, 452, 8, 2, 2, 4, 11, 'SI', 434, 13, 16, '', 1, '2022-02-16 00:19:14'),
(1803, '2022-02-15', 10, 488, 8, 3, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-02-16 00:19:57'),
(1804, '2022-02-15', 10, 483, 8, 3, 2, 6, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 00:21:04'),
(1805, '2022-02-15', 10, 479, 8, 3, 2, 4, 9, 'NO', 0, 0, 0, 'TELEORIENTACION', 1, '2022-02-16 00:22:37'),
(1806, '2022-02-15', 10, 477, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 00:24:17'),
(1807, '2022-02-15', 10, 475, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 00:26:02'),
(1808, '2022-02-15', 10, 434, 8, 1, 2, 8, 0, 'SI', 427, 12, 14, '', 1, '2022-02-16 00:27:29'),
(1809, '2022-02-15', 10, 503, 8, 2, 1, 4, 9, 'SI', 489, 13, 14, '', 1, '2022-02-16 00:31:51'),
(1810, '2022-02-16', 12, 497, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 21:59:15'),
(1811, '2022-02-16', 12, 491, 10, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 21:59:54'),
(1812, '2022-02-16', 12, 482, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-16 22:00:40'),
(1813, '2022-02-16', 12, 457, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2022-02-16 22:01:23'),
(1814, '2022-02-16', 12, 468, 10, 1, 2, 8, 0, 'SI', 470, 12, 17, '', 1, '2022-02-16 22:04:44'),
(1815, '2022-02-16', 12, 480, 10, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2022-02-16 22:05:27'),
(1816, '2022-02-16', 12, 500, 10, 2, 2, 13, 11, 'SI', 485, 13, 16, '', 1, '2022-02-16 22:06:47'),
(1817, '2022-02-16', 12, 469, 10, 2, 2, 4, 11, 'SI', 451, 4, 17, '', 1, '2022-02-16 22:07:31'),
(1818, '2022-02-16', 12, 478, 10, 2, 2, 13, 11, 'SI', 458, 13, 16, '', 1, '2022-02-16 22:08:39'),
(1819, '2022-02-17', 10, 452, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-17 22:42:39'),
(1820, '2022-02-17', 10, 505, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-02-17 23:34:13'),
(1821, '2022-02-17', 10, 504, 8, 2, 2, 4, 9, 'SI', 490, 13, 14, '', 1, '2022-02-17 23:38:13'),
(1822, '2022-02-17', 10, 500, 8, 2, 2, 4, 9, 'SI', 485, 13, 14, '', 1, '2022-02-17 23:41:11'),
(1823, '2022-02-17', 10, 502, 8, 2, 2, 4, 10, 'SI', 488, 13, 15, '', 1, '2022-02-18 02:24:03'),
(1824, '2022-02-17', 10, 496, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-18 02:25:04'),
(1825, '2022-02-17', 10, 453, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-18 02:26:02'),
(1826, '2022-02-17', 10, 429, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-18 02:27:39'),
(1827, '2022-02-17', 10, 427, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-18 02:28:34'),
(1828, '2022-02-17', 10, 489, 8, 1, 2, 8, 0, 'SI', 469, 12, 14, '', 1, '2022-02-18 02:31:08'),
(1829, '2022-02-18', 12, 448, 10, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2022-02-18 23:02:00'),
(1830, '2022-02-18', 12, 449, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2022-02-18 23:02:35'),
(1831, '2022-02-18', 12, 482, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-18 23:03:09'),
(1832, '2022-02-18', 12, 501, 10, 2, 2, 8, 0, 'SI', 487, 4, 0, '', 1, '2022-02-18 23:04:34'),
(1833, '2022-02-18', 12, 504, 10, 2, 1, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-02-18 23:05:59'),
(1834, '2022-02-18', 12, 500, 10, 2, 2, 13, 0, 'SI', 485, 13, 17, '', 1, '2022-02-18 23:07:12'),
(1835, '2022-02-18', 12, 478, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-18 23:07:48'),
(1836, '2022-02-18', 12, 451, 10, 3, 2, 4, 16, 'NO', 0, 0, 0, '', 1, '2022-02-18 23:08:23'),
(1837, '2022-02-21', 12, 457, 10, 3, 2, 13, 0, 'NO', 0, 0, 0, '', 1, '2022-02-21 21:14:54'),
(1838, '2022-02-21', 12, 432, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-21 21:15:46'),
(1839, '2022-02-21', 12, 480, 10, 3, 2, 13, 0, 'NO', 0, 0, 0, '', 1, '2022-02-21 21:16:33'),
(1840, '2022-02-21', 12, 452, 10, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-21 21:17:05'),
(1841, '2022-02-21', 12, 470, 10, 2, 2, 4, 10, 'SI', 452, 13, 15, '', 1, '2022-02-21 21:18:01'),
(1842, '2022-02-21', 12, 501, 10, 2, 2, 8, 0, 'SI', 487, 4, 17, '', 1, '2022-02-21 21:18:46'),
(1843, '2022-02-21', 12, 478, 10, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-21 21:19:30'),
(1844, '2022-02-19', 10, 470, 8, 2, 2, 4, 9, 'SI', 491, 13, 14, '', 1, '2022-02-22 06:19:43'),
(1845, '2022-02-19', 10, 507, 8, 2, 2, 8, 9, 'SI', 492, 13, 14, '', 1, '2022-02-22 06:23:47'),
(1846, '2022-02-19', 10, 475, 8, 3, 2, 6, 14, 'NO', 0, 0, 0, '', 1, '2022-02-22 06:24:42'),
(1847, '2022-02-19', 10, 453, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-22 06:26:25'),
(1848, '2022-02-19', 10, 508, 8, 2, 2, 8, 0, 'SI', 493, 4, 14, '', 1, '2022-02-22 06:30:27'),
(1849, '2022-02-19', 10, 499, 8, 2, 2, 4, 11, 'SI', 484, 13, 16, '', 1, '2022-02-22 06:32:21'),
(1850, '2022-02-19', 10, 425, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2022-02-22 06:33:35'),
(1851, '2022-02-19', 10, 428, 8, 3, 2, 3, 14, 'NO', 0, 0, 0, '', 1, '2022-02-22 06:35:18'),
(1852, '2022-02-19', 10, 469, 8, 2, 2, 4, 9, 'NO', 0, 0, 0, '', 1, '2022-02-22 06:36:07'),
(1853, '2022-02-23', 12, 495, 10, 2, 2, 4, 11, 'SI', 494, 4, 9, '', 1, '2022-02-23 22:57:02'),
(1854, '2022-02-23', 12, 503, 10, 2, 2, 8, 0, 'SI', 495, 4, 14, '', 1, '2022-02-23 23:01:48'),
(1855, '2022-02-23', 12, 470, 10, 2, 2, 4, 11, 'SI', 452, 13, 16, '', 1, '2022-02-23 23:02:49'),
(1856, '2022-02-16', 12, 451, 10, 3, 2, 4, 17, 'NO', 0, 0, 0, '', 1, '2022-02-23 23:04:47'),
(1857, '2022-02-23', 12, 448, 10, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2022-02-23 23:05:45'),
(1858, '2022-02-22', 10, 495, 8, 2, 2, 13, 9, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:24:57'),
(1859, '2022-02-22', 10, 469, 8, 2, 2, 4, 11, 'SI', 451, 4, 14, '', 1, '2022-02-25 00:26:17'),
(1860, '2022-02-22', 10, 470, 8, 2, 2, 4, 10, 'SI', 491, 13, 14, '', 1, '2022-02-25 00:27:27'),
(1861, '2022-02-22', 10, 507, 8, 2, 2, 8, 0, 'SI', 492, 13, 14, '', 1, '2022-02-25 00:29:20'),
(1862, '2022-02-22', 10, 410, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:32:42'),
(1863, '2022-02-22', 10, 416, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:33:20'),
(1864, '2022-02-22', 10, 502, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:34:26'),
(1865, '2022-02-22', 10, 386, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:35:13'),
(1866, '2022-02-22', 10, 424, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:36:02'),
(1867, '2022-02-22', 10, 427, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:37:02'),
(1868, '2022-02-24', 10, 495, 8, 2, 2, 13, 10, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:40:43'),
(1869, '2022-02-24', 10, 469, 8, 2, 2, 4, 10, 'SI', 451, 4, 15, '', 1, '2022-02-25 00:43:28'),
(1870, '2022-02-24', 10, 470, 8, 2, 2, 4, 11, 'SI', 491, 16, 0, '', 1, '2022-02-25 00:45:05'),
(1871, '2022-02-24', 10, 502, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:46:12'),
(1872, '2022-02-24', 10, 453, 8, 3, 2, 16, 0, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:48:53'),
(1873, '2022-02-24', 10, 497, 8, 3, 2, 13, 16, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:50:45'),
(1874, '2022-02-24', 10, 424, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:53:11'),
(1875, '2022-02-24', 10, 410, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:54:03'),
(1876, '2022-02-24', 10, 412, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-02-25 00:54:46'),
(1877, '2022-02-26', 10, 509, 8, 1, 2, 8, 0, 'SI', 496, 12, 14, '', 1, '2022-02-26 21:59:03'),
(1878, '2022-02-26', 10, 508, 8, 2, 2, 8, 0, 'SI', 493, 4, 15, '', 1, '2022-02-26 22:01:02'),
(1879, '2022-02-26', 10, 503, 8, 2, 2, 8, 0, 'SI', 489, 13, 15, '', 1, '2022-02-26 22:04:15'),
(1880, '2022-02-26', 10, 507, 8, 2, 2, 8, 0, 'SI', 492, 13, 16, '', 1, '2022-02-26 22:06:39'),
(1881, '2022-02-26', 10, 470, 8, 2, 2, 4, 11, 'SI', 491, 13, 16, '', 1, '2022-02-26 22:09:23'),
(1882, '2022-02-22', 10, 495, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-02-26 22:42:48'),
(1883, '2022-03-01', 10, 469, 8, 2, 2, 4, 11, 'SI', 451, 4, 16, '', 1, '2022-03-01 23:43:28'),
(1884, '2022-03-01', 10, 510, 8, 2, 2, 8, 0, 'SI', 497, 4, 14, '', 1, '2022-03-01 23:46:34'),
(1885, '2022-03-01', 10, 505, 8, 2, 2, 8, 0, 'SI', 498, 13, 14, '', 1, '2022-03-01 23:52:02'),
(1886, '2022-03-01', 10, 508, 8, 2, 2, 8, 0, 'SI', 493, 4, 16, '', 1, '2022-03-01 23:55:09'),
(1887, '2022-03-01', 10, 470, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-03-01 23:57:20'),
(1888, '2022-03-01', 10, 503, 8, 1, 2, 8, 0, 'SI', 489, 12, 14, '', 1, '2022-03-01 23:58:59'),
(1889, '2022-03-01', 10, 447, 8, 2, 2, 8, 0, 'SI', 437, 4, 14, '', 1, '2022-03-02 00:03:57'),
(1890, '2022-03-01', 10, 434, 8, 1, 2, 8, 0, 'SI', 427, 12, 15, '', 1, '2022-03-02 00:14:17'),
(1891, '2022-03-03', 10, 505, 8, 2, 2, 4, 9, 'SI', 498, 13, 15, '', 1, '2022-03-04 00:28:32'),
(1892, '2022-03-03', 10, 497, 8, 3, 2, 13, 15, 'NO', 0, 0, 0, '', 1, '2022-03-04 00:30:23'),
(1893, '2022-03-03', 10, 499, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-03-04 00:32:28'),
(1894, '2022-03-03', 10, 479, 8, 3, 2, 4, 15, 'NO', 0, 0, 0, '', 1, '2022-03-04 00:35:04'),
(1895, '2022-03-03', 10, 372, 8, 3, 2, 13, 17, 'NO', 0, 0, 0, '', 1, '2022-03-04 00:40:05'),
(1896, '2022-03-10', 10, 511, 8, 2, 2, 3, 0, 'SI', 499, 4, 14, '', 1, '2022-03-13 20:04:15'),
(1897, '2022-03-10', 10, 447, 8, 2, 2, 4, 9, 'SI', 437, 4, 14, '', 1, '2022-03-13 20:05:51'),
(1898, '2022-03-17', 10, 513, 8, 2, 2, 3, 9, 'SI', 501, 13, 14, '', 1, '2022-03-19 04:07:42'),
(1899, '2022-03-17', 10, 511, 8, 2, 2, 3, 10, 'SI', 502, 13, 14, '', 1, '2022-03-19 04:10:57'),
(1900, '2022-03-17', 10, 505, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-03-19 04:12:40'),
(1901, '2022-03-17', 10, 514, 8, 2, 2, 8, 0, 'SI', 503, 13, 14, '', 1, '2022-03-19 04:16:13'),
(1902, '2022-03-24', 10, 511, 8, 2, 2, 8, 0, 'SI', 502, 13, 14, '', 1, '2022-03-24 17:27:13'),
(1903, '2022-03-24', 10, 447, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-03-24 17:29:02'),
(1904, '2022-03-24', 10, 513, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-03-24 17:29:42'),
(1905, '2022-03-24', 10, 508, 8, 2, 2, 4, 9, 'SI', 493, 13, 17, '', 1, '2022-03-24 17:34:28'),
(1906, '2022-03-24', 10, 505, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-03-24 17:35:16'),
(1907, '2022-03-24', 10, 500, 8, 1, 2, 8, 0, 'SI', 485, 12, 14, '', 1, '2022-03-24 17:37:39'),
(1908, '2022-03-24', 10, 502, 8, 3, 2, 7, 14, 'NO', 0, 0, 0, '', 1, '2022-03-24 17:39:17'),
(1909, '2022-03-24', 10, 514, 8, 2, 2, 8, 0, 'SI', 503, 13, 15, '', 1, '2022-03-24 17:42:46'),
(1910, '2022-03-24', 10, 441, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-03-24 17:43:30'),
(1911, '2022-03-31', 10, 508, 8, 2, 2, 3, 10, 'SI', 493, 13, 14, '', 1, '2022-04-01 18:13:31'),
(1912, '2022-03-31', 10, 515, 8, 2, 2, 4, 9, 'SI', 504, 13, 14, '', 1, '2022-04-01 18:18:22'),
(1913, '2022-03-31', 10, 469, 8, 3, 2, 13, 14, 'NO', 0, 0, 0, '', 1, '2022-04-01 18:19:06'),
(1914, '2022-03-31', 10, 514, 8, 1, 2, 8, 0, 'SI', 503, 12, 14, '', 1, '2022-04-01 18:20:14'),
(1915, '2022-03-31', 10, 447, 8, 3, 2, 4, 14, 'NO', 0, 0, 0, '', 1, '2022-04-01 18:21:04');

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

--
-- Volcado de datos para la tabla `zpsyem_aud_atenciones`
--

INSERT INTO `zpsyem_aud_atenciones` (`idAuditAte`, `idAtencion`, `fechaRegAudi`, `idUsuario`, `AccRealizada`, `cuentaAnterior`, `EpisodioAnterior`, `cuentaNueva`, `EpisodioNuevo`) VALUES
(1, 234, '2021-07-14', 1, 'MODIFICACIÓN', '1910314', '1916355', '1910314', '1916355'),
(2, 234, '2021-07-14', 1, 'MODIFICACIÓN', '1910314', '1916355', '1910314', '1916355'),
(3, 181, '2021-07-14', 1, 'MODIFICACIÓN', '1904805', '1910846', '1904805', '1910846'),
(4, 233, '2021-07-14', 12, 'MODIFICACIÓN', '1910581', '1916622', '1910581', '1916622'),
(5, 255, '2021-07-21', 1, 'MODIFICACIÓN', '1912989', '1919030', '1912840', '1918881'),
(6, 266, '2021-07-31', 1, 'MODIFICACIÓN', '1915058', '1921099', '1915058', '1921099'),
(7, 278, '2021-08-05', 10, 'MODIFICACIÓN', '1917362', '1923403', '1917362', '1923403'),
(8, 293, '2021-08-16', 1, 'MODIFICACIÓN', '1920602', '1926643', '1920602', '1926643'),
(9, 299, '2021-08-24', 10, 'MODIFICACIÓN', '1923189', '1929230', '1923189', '1929230'),
(10, 280, '2021-09-02', 14, 'MODIFICACIÓN', '1913056', '1919097', '1913056', '1919097'),
(11, 313, '2021-09-08', 12, 'MODIFICACIÓN', '1927775', '1933816', '1927775', '1933816'),
(12, 320, '2021-09-15', 14, 'ANULACION', '1799710', '1805755', NULL, NULL),
(13, 344, '2021-11-03', 10, 'MODIFICACIÓN', '1946021', '1952062', '1946021', '1952062'),
(14, 346, '2021-11-04', 10, 'MODIFICACIÓN', '1859731', '1865772', '1859731', '1865772'),
(15, 347, '2021-11-04', 1, 'ANULACION', '1806976', '1813020', NULL, NULL),
(16, 405, '2022-01-06', 10, 'MODIFICACIÓN', '1977330', '1983371', '1977330', '1983371'),
(17, 411, '2022-01-13', 10, 'MODIFICACIÓN', '1980970', '1987011', '1980970', '1987011'),
(18, 411, '2022-01-13', 10, 'MODIFICACIÓN', '1980970', '1987011', '1980970', '1987011'),
(19, 410, '2022-01-13', 10, 'MODIFICACIÓN', '1981841', '1987882', '1981841', '1987882'),
(20, 424, '2022-01-20', 10, 'MODIFICACIÓN', '1984788', '1990829', '1984788', '1990829'),
(21, 437, '2022-01-22', 10, 'MODIFICACIÓN', '1985151', '1991192', '1985151', '1991192'),
(22, 439, '2022-01-22', 10, 'MODIFICACIÓN', '1984356', '1990397', '1984356', '1990397'),
(23, 472, '2022-01-29', 10, 'ANULACION', '1985249', '1991290', NULL, NULL);

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
(1, 1, '2021-07-14', 1, 'ACTUALIZACIÓN', 1, '2222', 1, '1111'),
(2, 226, '2021-07-14', 1, 'ACTUALIZACIÓN', 234, '05230252', 234, '72914580'),
(3, 226, '2021-07-14', 1, 'ACTUALIZACIÓN', 234, '72914580', 234, '05230252'),
(4, 391, '2021-12-16', 10, 'ELIMINACIÓN', 388, '42168991', NULL, NULL),
(5, 474, '2022-02-03', 10, 'ELIMINACIÓN', 441, '10535196', NULL, NULL);

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
  MODIFY `idAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=516;

--
-- AUTO_INCREMENT de la tabla `psyem_condicionprof`
--
ALTER TABLE `psyem_condicionprof`
  MODIFY `idCondicion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `psyem_diagnosticos`
--
ALTER TABLE `psyem_diagnosticos`
  MODIFY `idDiagnostico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
  MODIFY `idFamiliar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=505;

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
  MODIFY `idSeguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1916;

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
  MODIFY `idAuditAte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `zpsyem_aud_familiares`
--
ALTER TABLE `zpsyem_aud_familiares`
  MODIFY `idAudiFam` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
