-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 10-04-2022 a las 21:48:50
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
-- Base de datos: `rvisitas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTUALIZAR_ACTIVIDAD` (IN `_fechaAct` DATE, IN `_horaAct` TIME, IN `_descAct` VARCHAR(255), IN `_lugarAct` INT(11), IN `_empAct` INT(11), IN `_idActividad` INT(11))   UPDATE rv_actividades SET fechaAct = _fechaAct,horaAct = _horaAct,descAct = _descAct,lugarAct = _lugarAct,empAct = _empAct WHERE idActividad = _idActividad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTUALIZAR_USUARIO` (IN `_oficinaId` INT(11), IN `_rolId` INT(11), IN `_dni` TEXT, IN `_nombres` TEXT, IN `_aPaterno` TEXT, IN `_aMaterno` TEXT, IN `_cuenta` TEXT, IN `_clave` TEXT, IN `_correo` TEXT, IN `_id_usuario` INT(11))   BEGIN
UPDATE rv_usuarios SET oficinaId = _oficinaId,rolId = _rolId,dni = _dni,nombres = _nombres,aPaterno = _aPaterno,aMaterno = _aMaterno,cuenta = _cuenta,clave = _clave,correo = _correo WHERE id_usuario = _id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREAR_USUARIO` (IN `_oficinaId` INT(11), IN `_rolId` INT(11), IN `_dni` TEXT, IN `_nombres` TEXT, IN `_aPaterno` TEXT, IN `_aMaterno` TEXT, IN `_cuenta` TEXT, IN `_clave` TEXT, IN `_correo` TEXT)   BEGIN
INSERT INTO rv_usuarios(oficinaId,rolId,dni,nombres,aPaterno,aMaterno,cuenta,clave,correo) VALUES(_oficinaId,_rolId,_dni,_nombres,_aPaterno,_aMaterno,_cuenta,_clave,_correo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_ACTIVIDAD` (IN `_idActividad` INT(11))   DELETE FROM rv_actividades WHERE idActividad = _idActividad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GRAFICOS` ()   BEGIN
SELECT idVisita,fechaVisita FROM rv_visitas where fechaVisita BETWEEN DATE_SUB(NOW(), INTERVAL 1 YEAR) AND NOW() order by fechaVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GRAFICOS_1` (IN `_fInicio` DATE)   BEGIN
SELECT idVisita,fechaVisita FROM rv_visitas where fechaVisita = _fInicio order by fechaVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GRAFICOS_2` (IN `_fInicio` DATE, IN `_fFin` DATE)   BEGIN
SELECT idVisita,fechaVisita FROM rv_visitas where fechaVisita between _fInicio and _fFin order by fechaVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES` ()   SELECT
	rv_actividades.idActividad, 
	date_format(rv_actividades.fechaAct,'%d/%m/%Y') as fechaAct,
	time_format(rv_actividades.horaAct,'%H:%i %p') as horaAct,
	rv_actividades.descAct, 
	rv_actividades.lugarAct, 
	rv_lugaresact.descLugar, 
	rv_actividades.empAct, 
	rv_empleados.nombresEmp, 
	rv_empleados.cargoEmp
FROM
	rv_actividades
	INNER JOIN
	rv_empleados
	ON 
		rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN
	rv_lugaresact
	ON 
		rv_actividades.lugarAct = rv_lugaresact.idLugar
	ORDER BY fechaAct DESC,horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES_2` (IN `_fechaFinalAct` DATE)   SELECT
	rv_actividades.idActividad, 
	date_format(rv_actividades.fechaAct,'%d/%m/%Y') as fechaAct,
	time_format(rv_actividades.horaAct,'%H:%i %p') as horaAct,
	rv_actividades.descAct, 
	rv_actividades.lugarAct, 
	rv_lugaresact.descLugar, 
	rv_actividades.empAct, 
	rv_empleados.nombresEmp, 
	rv_empleados.cargoEmp
FROM
	rv_actividades
	INNER JOIN
	rv_empleados
	ON 
		rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN
	rv_lugaresact
	ON 
		rv_actividades.lugarAct = rv_lugaresact.idLugar
	WHERE fechaAct = _fechaFinalAct
	ORDER BY fechaAct DESC,horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES_3` (IN `_inicio` DATE, IN `_fin` DATE)   SELECT
rv_actividades.idActividad,
date_format( rv_actividades.fechaAct, '%d/%m/%Y' ) AS fechaAct,
time_format( rv_actividades.horaAct, '%H:%i %p' ) AS horaAct,
rv_actividades.descAct,
rv_actividades.lugarAct,
rv_lugaresact.descLugar,
rv_actividades.empAct,
rv_empleados.nombresEmp,
rv_empleados.cargoEmp 
FROM
	rv_actividades
	INNER JOIN rv_empleados ON rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN rv_lugaresact ON rv_actividades.lugarAct = rv_lugaresact.idLugar 
WHERE fechaAct BETWEEN _inicio AND _fin
ORDER BY
	fechaAct DESC,
	horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES_EDIT` ()   SELECT
	rv_actividades.idActividad, 
	date_format(rv_actividades.fechaAct,'%d/%m/%Y') as fechaAct,
	time_format(rv_actividades.horaAct,'%h:%i %p') as horaAct,
	rv_actividades.descAct, 
	rv_actividades.lugarAct, 
	rv_lugaresact.descLugar, 
	rv_actividades.empAct, 
	rv_empleados.nombresEmp, 
	rv_empleados.cargoEmp
FROM
	rv_actividades
	INNER JOIN
	rv_empleados
	ON 
		rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN
	rv_lugaresact
	ON 
		rv_actividades.lugarAct = rv_lugaresact.idLugar
	ORDER BY fechaAct DESC,horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES_WEB` ()   SELECT
	rv_actividades.idActividad, 
	date_format(rv_actividades.fechaAct,'%d/%m/%Y') as fechaAct,
	time_format(rv_actividades.horaAct,'%H:%i %p') as horaAct,
	rv_actividades.descAct, 
	rv_actividades.lugarAct, 
	rv_lugaresact.descLugar, 
	rv_actividades.empAct, 
	rv_empleados.nombresEmp, 
	rv_empleados.cargoEmp
FROM
	rv_actividades
	INNER JOIN
	rv_empleados
	ON 
		rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN
	rv_lugaresact
	ON 
		rv_actividades.lugarAct = rv_lugaresact.idLugar
	WHERE fechaAct BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()
	ORDER BY fechaAct DESC,horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES_WEB_2` (IN `_fechaFinalAct` DATE)   SELECT
	rv_actividades.idActividad, 
	date_format(rv_actividades.fechaAct,'%d/%m/%Y') as fechaAct,
	time_format(rv_actividades.horaAct,'%H:%i %p') as horaAct,
	rv_actividades.descAct, 
	rv_actividades.lugarAct, 
	rv_lugaresact.descLugar, 
	rv_actividades.empAct, 
	rv_empleados.nombresEmp, 
	rv_empleados.cargoEmp
FROM
	rv_actividades
	INNER JOIN
	rv_empleados
	ON 
		rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN
	rv_lugaresact
	ON 
		rv_actividades.lugarAct = rv_lugaresact.idLugar
	WHERE fechaAct = _fechaFinalAct
	ORDER BY fechaAct DESC,horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_ACTIVIDADES_WEB_3` (IN `_inicio` DATE, IN `_fin` DATE)   SELECT
rv_actividades.idActividad,
date_format( rv_actividades.fechaAct, '%d/%m/%Y' ) AS fechaAct,
time_format( rv_actividades.horaAct, '%H:%i %p' ) AS horaAct,
rv_actividades.descAct,
rv_actividades.lugarAct,
rv_lugaresact.descLugar,
rv_actividades.empAct,
rv_empleados.nombresEmp,
rv_empleados.cargoEmp 
FROM
	rv_actividades
	INNER JOIN rv_empleados ON rv_actividades.empAct = rv_empleados.idEmpleado
	INNER JOIN rv_lugaresact ON rv_actividades.lugarAct = rv_lugaresact.idLugar 
WHERE fechaAct BETWEEN _inicio AND _fin
ORDER BY
	fechaAct DESC,
	horaAct DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_EMPLEADOS` ()   BEGIN
SELECT EMP.idEmpleado,EMP.nombresEmp,EMP.ofiEmp,OFI.descOficina,EMP.cargoEmp FROM rv_empleados AS EMP INNER JOIN rv_oficinas AS OFI ON EMP.ofiEmp = OFI.idOficina;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_EMPLEADO_DATOS` (IN `_idEmpleado` INT(11))   BEGIN
SELECT EMP.idEmpleado,EMP.nombresEmp,EMP.ofiEmp,OFI.descOficina,EMP.cargoEmp FROM rv_empleados AS EMP INNER JOIN rv_oficinas AS OFI ON EMP.ofiEmp = OFI.idOficina WHERE EMP.idEmpleado = _idEmpleado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_LUGARES_ACT` ()   SELECT idLugar,descLugar FROM rv_lugaresact ORDER BY descLugar ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_USUARIOS` ()   BEGIN
SELECT US.id_usuario,US.oficinaId,OF.descOficina,US.rolId,RO.dscRol,US.dni,US.nombres,US.aPaterno,US.aMaterno,US.correo,US.cuenta,US.clave,US.estado FROM rv_usuarios AS US INNER JOIN rv_roles AS RO ON US.rolId = RO.idRol INNER JOIN rv_oficinas AS OF ON US.oficinaId = OF.idOficina;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_USUARIOS_OFICINA` (IN `_ofiEmp` INT(11))   BEGIN
SELECT EMP.idEmpleado,EMP.nombresEmp,EMP.ofiEmp,OFI.descOficina,EMP.cargoEmp FROM rv_empleados AS EMP INNER JOIN rv_oficinas AS OFI ON EMP.ofiEmp = OFI.idOficina WHERE EMP.ofiEmp = _ofiEmp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_VISITAS_1` (IN `_ofidepVisitado` INT(11))   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar WHERE fechaVisita BETWEEN DATE_SUB(NOW(), INTERVAL 1 DAY) AND NOW() and ofidepVisitado = _ofidepVisitado order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_VISITAS_2` (IN `_ofidepVisitado` INT(11), IN `_fechaFinal` DATE)   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar WHERE vis.ofidepVisitado = _ofidepVisitado and vis.fechaVisita = _fechaFinal order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTAR_VISITAS_3` (IN `_ofidepVisitado` INT(11), IN `_fechaInicial` DATE, IN `_fechaFinal` DATE)   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar WHERE vis.ofidepVisitado = _ofidepVisitado and vis.fechaVisita between _fechaInicial and _fechaFinal order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTA_LUGARACTI_FORM` ()   SELECT idLugar,descLugar FROM `rv_lugaresact` ORDER BY descLugar ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LISTA_LUGARACTI_FORM_DESC` (IN `_texto` TEXT)   SELECT idLugar,descLugar FROM `rv_lugaresact` WHERE descLugar LIKE CONCAT('%',_texto,'%') ORDER BY descLugar ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LIST_REGISTRADOR_VISITA` ()   BEGIN
SELECT idVisita,date_format(fechaVisita,'%d/%m/%Y') as fVisita,vstNombre,descTDoc,vstNdoc,vstEntidad,vstMotivo,empVisitado,ofidepVisitado,cargoVisitado,lugarVst,time_format(horaIngreso,'%r') as hEntrada,time_format(horaSalida,'%r') as hSalida,estadoV,descEstado FROM rv_visitas as vis inner join rv_tdoc as tDoc on vis.vstDoc = tDoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTAR_VISITA_REG` (IN `_fechaVisita` DATE, IN `_vstNombre` TEXT, IN `_vstDoc` INT(11), IN `_vstNdoc` TEXT, IN `_vstEntidad` INT(11), IN `_vstMotivo` INT(11), IN `_empVisitado` INT(11), IN `_ofidepVisitado` INT(11), IN `_cargoVisitado` TEXT, IN `_lugarVst` INT(11), IN `_horaIngreso` TIME, IN `_registraIngreso` INT(11))   BEGIN
INSERT INTO rv_visitas(fechaVisita,vstNombre,vstDoc,vstNdoc,vstEntidad,vstMotivo,empVisitado,ofidepVisitado,cargoVisitado,lugarVst,horaIngreso,registraIngreso) VALUES(_fechaVisita,_vstNombre,_vstDoc,_vstNdoc,_vstEntidad,_vstMotivo,_empVisitado,_ofidepVisitado,_cargoVisitado,_lugarVst,_horaIngreso,_registraIngreso);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_ACTIVIDAD` (IN `_fechaAct` DATE, IN `_horaAct` TIME, IN `_descAct` VARCHAR(255), IN `_lugarAct` INT(11), IN `_empAct` INT(11), IN `_usuregAct` INT(11))   INSERT INTO rv_actividades(fechaAct,horaAct,descAct,lugarAct,empAct,usuregAct) VALUES(_fechaAct,_horaAct,_descAct,_lugarAct,_empAct,_usuregAct)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_LUGAR_ACT` (IN `_descLugar` TEXT)   INSERT INTO rv_lugaresact(descLugar) VALUES(_descLugar)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_SALIDA_REG` (IN `_horaSalida` TIME, IN `_fechaHRegSalida` DATE, IN `_registraSalida` INT(11), IN `_estadoV` INT(11), IN `_idVisita` INT(11))   BEGIN
UPDATE rv_visitas set horaSalida = _horaSalida,fechaHRegSalida = _fechaHRegSalida,registraSalida= _registraSalida,estadoV = _estadoV where idVisita = _idVisita;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRO_NUEVO_LUGAR_ACT` (IN `_desclugar` TEXT)   INSERT INTO rv_lugaresact(descLugar) VALUES(_desclugar)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_GENERAL` ()   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,vis.registraIngreso,us1.cuenta as UsuarioRegistro,date_format(vis.fechaHRegSalida,'%d/%m/%Y') as fRegSalida,vis.registraSalida,us2.cuenta as UsuarioSalida,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado,vis.registro as FechaHoraRegistro FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar INNER JOIN rv_usuarios as us1 on vis.registraIngreso = us1.id_usuario INNER JOIN rv_usuarios as us2 on vis.registraSalida = us2.id_usuario WHERE fechaVisita BETWEEN DATE_SUB(NOW(), INTERVAL 1 DAY) AND NOW() order by fechaVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_GENERAL_1` (IN `_fechaFinal` DATE)   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,vis.registraIngreso,us1.cuenta as UsuarioRegistro,date_format(vis.fechaHRegSalida,'%d/%m/%Y') as fRegSalida,vis.registraSalida,us2.cuenta as UsuarioSalida,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado,vis.registro as FechaHoraRegistro FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar INNER JOIN rv_usuarios as us1 on vis.registraIngreso = us1.id_usuario INNER JOIN rv_usuarios as us2 on vis.registraSalida = us2.id_usuario WHERE vis.fechaVisita = _fechaFinal order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORTE_GENERAL_2` (IN `_fechaInicial` DATE, IN `_fechaFinal` DATE)   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,vis.registraIngreso,us1.cuenta as UsuarioRegistro,date_format(vis.fechaHRegSalida,'%d/%m/%Y') as fRegSalida,vis.registraSalida,us2.cuenta as UsuarioSalida,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado,vis.registro as FechaHoraRegistro FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar INNER JOIN rv_usuarios as us1 on vis.registraIngreso = us1.id_usuario INNER JOIN rv_usuarios as us2 on vis.registraSalida = us2.id_usuario WHERE vis.fechaVisita between _fechaInicial and _fechaFinal order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VISITAS_WEB` ()   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar WHERE fechaVisita BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW() order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VISITAS_WEB_1` (IN `_fechaFinal` DATE)   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar WHERE vis.fechaVisita = _fechaFinal order by idVisita desc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VISITAS_WEB_2` (IN `_fechaInicial` DATE, IN `_fechaFinal` DATE)   BEGIN
SELECT vis.idVisita,vis.fechaVisita,date_format(vis.fechaVisita,'%d/%m/%Y') as fVisita,vis.vstNombre,tdoc.descTDoc,vis.vstNdoc,ent.descEntidad,vis.vstMotivo,mot.descMotivo,vis.empVisitado,emp.nombresEmp,vis.ofidepVisitado,of.descOficina,vis.cargoVisitado,vis.lugarVst,lug.descLugar,time_format(vis.horaIngreso,'%r') as hEntrada,time_format(vis.horaSalida,'%r') as hSalida,vis.estadoV,rest.descEstado FROM rv_visitas as vis inner join rv_tdoc as tdoc on vis.vstDoc = tdoc.idTdoc inner join rv_estadovisita as rest on vis.estadoV = rest.idEstado inner join rv_entidades as ent on vis.vstEntidad = ent.idEntidad inner join rv_motivos as mot on vis.vstMotivo = mot.idMotivo inner join rv_empleados as emp on vis.empVisitado = emp.idEmpleado inner join rv_oficinas as of on vis.ofidepVisitado = of.idOficina inner join rv_lugares as lug on vis.lugarVst = lug.idLugar WHERE vis.fechaVisita between _fechaInicial and _fechaFinal order by idVisita desc;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_actividades`
--

CREATE TABLE `rv_actividades` (
  `idActividad` int(11) NOT NULL,
  `fechaAct` date DEFAULT NULL,
  `horaAct` time DEFAULT NULL,
  `descAct` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `lugarAct` int(11) DEFAULT NULL,
  `empAct` int(11) DEFAULT NULL,
  `usuregAct` int(11) NOT NULL,
  `fecha_registroAct` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_actividades`
--

INSERT INTO `rv_actividades` (`idActividad`, `fechaAct`, `horaAct`, `descAct`, `lugarAct`, `empAct`, `usuregAct`, `fecha_registroAct`) VALUES
(1, '2021-05-21', '08:00:00', 'INICIO DE DIA', 2, 1, 2, '2021-05-21 11:09:03'),
(2, '2021-05-21', '11:30:00', 'REUNION CON JEFES DE DEPARTAMENTO SOBRE GUARDIAS HOSPITALARIAS', 2, 1, 7, '2021-05-21 16:04:39'),
(3, '2021-05-24', '10:10:00', 'REUNION CON PRONIS, DIRECCION ADMINISTRATIVA, PLANEAMIENTO ESTRATEGICO, PERSONAL, SOBRE BRECHA DE RECURSOS HUMANOS', 2, 2, 7, '2021-05-24 14:54:16'),
(4, '2021-05-31', '11:00:00', 'REUNION CON JEFES DE LOS DEPARTAMENTOS DE MEDICINA, CIRUGIA, GINECO OBSTETRICIA , PEDIATRIA Y JEFE DE LA OFICINA DE DOCENCIA. TEMA A TRATAR INTERNADO MEDICO', 2, 1, 7, '2021-05-28 20:30:14'),
(5, '2021-06-01', '09:00:00', 'REUNION CON JEFES DE ADMINISTRACION, PLANEAMIENTO ESTRATEGICO, ASESORIA JURIDICA, SERVICIOS GENERALES,  LOGISTICA, ECONOMIA, PERSONAL , ESTADISTICA. AGENDA RETORNO DEL PERSONAL DE ACUERDO AL D.U N°051-2021', 2, 1, 7, '2021-06-01 13:51:36'),
(6, '2021-06-01', '09:30:00', 'REUNION CON JEFES DE DEPARTAMENTOS ASISTENCIALES. AGENDA RETORNO DEL PERSONAL DE ACUERDO AL D.U. N°051-2021', 2, 1, 7, '2021-06-01 14:04:54'),
(7, '2021-06-01', '10:00:00', 'REUNION VIA ZOOM CON CONSORCIO, PRONIS MINSA, DIRECCION  ADJUNTA, ADMINISTRACION. AGENDA PUESTA EN MARCHA CONSTRUCCION DEL HOSPITAL', 2, 1, 7, '2021-06-01 14:21:07'),
(8, '2021-06-03', '11:30:00', 'REUNION CON JEFES DE DEPARTAMENTO DE CIRUGIA, PEDIATRIA, MEDICINA, GINECO OBSTETRICIA, ODONTOLOGIA, LABORATORIO, DIAGNOSTICO POR IMAGENES, CONSULTORIOS EXTERNOS, EMERGENCIA,  COORDINADORA COVID-19. AGENDA  ATENCION EN CONSULTORIOS EXTERNOS', 2, 2, 7, '2021-06-03 16:12:39'),
(9, '2021-06-11', '11:00:00', 'REUNION VIA ZOOM CON CONSORCIO, PRONIS MINSA, JEFES DE DEPARTAMENTOS PEDIATRIA, MEDICINA, GINECO OBSTETRICIA. CIRUGIA. AGENDA PROPUESTA DE SISTEMA DE INTERPRETACIÓN SIMULTÁNEA WORKSHOP', 2, 2, 7, '2021-06-11 14:12:37'),
(10, '2021-06-16', '10:00:00', 'REUNIÓN CON JEFES DE FARMACIA LOGÍSTICA, ECONOMÍA, LABORATORIO, ODONTOLOGÍA, DIAGNOSTICO POR IMÁGENES, SEGUROS Y ADMINISTRACIÓN, AGENDA INTEGRACIÓN DE LA INFORMACIÓN DE LOS SUMINISTROS MÉDICOS SISMED', 2, 1, 7, '2021-06-14 14:30:40'),
(11, '2021-06-23', '12:15:00', 'REUNIÓN CON JEFES DE FARMACIA, EMERGENCIA, LOGÍSTICA, ALMACÉN, ADMINISTRACIÓN. AGENDA ABASTECIMIENTO DE MEDICAMENTOS', 2, 2, 7, '2021-06-23 17:01:44'),
(12, '2021-06-28', '10:15:00', 'REUNION CON JEFES DE DEPARTAMENTOS DE MEDICINA, PEDIATRIA, CIRUGIA, GINECO OBSTETRICIA Y JEFA DE LA OFICINA DE EPIDEMIOLOGIA. AGENDA NUEVA VARIENTE COVID 19', 2, 1, 7, '2021-06-28 15:04:59'),
(14, '2021-08-06', '09:00:00', 'REUNION CON REPRESENTANTES DE SOCIOS EN SALUD SUCURSAL PERU - DRA. JIMENA RUIZ CARDENAS, LIC. BRUNO MARTEL CHAVEZ, SR. JIMMY GALARZA CASTILLO, DR. MARCO TOVAR HUAMANI, DRA. MONICA FERNANDEZ-CABERO Y DR. LEONID LECCA GARCÍA  - AGENDA REVISIÓN DE NUEVA PROP', 2, 1, 7, '2021-07-27 15:56:29'),
(15, '2021-08-06', '12:00:00', 'COMITÉ DE MANEJO DE CADÁVERES. AGENDA REUNIÓN TÉCNICA', 2, 2, 7, '2021-08-06 16:25:15'),
(16, '2021-08-09', '10:00:00', 'REUNION CON REPRESENTANTES DE SOCIOS EN SALUD SUCURSAL PERU - DRA. JIMENA RUIZ CARDENAS, LIC. BRUNO MARTEL CHAVEZ, SR. JIMMY GALARZA CASTILLO, DR. MARCO TOVAR HUAMANI, DRA. MONICA FERNANDEZ-CABERO Y DR. LEONID LECCA GARCÍA -  REVISIÓN DE NUEVA PROPUESTA -', 2, 1, 7, '2021-08-06 16:30:05'),
(17, '2021-08-19', '09:00:00', 'REUNIÓN CON JEFES DE LAS OFICINAS DE PERSONAL Y ESTADÍSTICA. AGENDA  VACUNAS', 2, 1, 7, '2021-08-19 13:29:16'),
(18, '2021-09-02', '11:30:00', 'REUNION CON SINDICATO SINTRACLAS, PRESENTACIÓN DE LA JUNTA DIRECTIVA SINDICAL DE LOS SERVIDORES DEL HOSPITAL NACIONAL SERGIO E. BERNALES', 2, 1, 7, '2021-09-01 19:03:56'),
(19, '2021-09-09', '10:00:00', 'REUNIÓN CON PRONIS CON LA PARTICIPACIÓN DE ALCALDES DE CARABAYLLO Y COMAS, Y REPRESENTANTES DE LA COMISION MULTISECTORAL PRO CONSTRUCCION DEL HNSEB', 2, 1, 7, '2021-09-09 14:33:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_empleados`
--

CREATE TABLE `rv_empleados` (
  `idEmpleado` int(11) NOT NULL,
  `ofiEmp` int(11) NOT NULL,
  `nombresEmp` text COLLATE utf8_spanish_ci NOT NULL,
  `cargoEmp` text COLLATE utf8_spanish_ci NOT NULL,
  `nvisitas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_empleados`
--

INSERT INTO `rv_empleados` (`idEmpleado`, `ofiEmp`, `nombresEmp`, `cargoEmp`, `nvisitas`) VALUES
(1, 1, 'JULIO SILVA RAMOS', 'DIRECTOR GENERAL', 0),
(2, 1, 'JUAN MARTÍN NINA CÁCERES', 'DIRECTOR ADJUNTO', 0),
(3, 1, 'ORLANDO HERRERA ALANIA', 'DIRECTOR GENERAL', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_entidades`
--

CREATE TABLE `rv_entidades` (
  `idEntidad` int(11) NOT NULL,
  `tieneRuc` int(11) DEFAULT NULL,
  `docRuc` text COLLATE utf8_spanish_ci NOT NULL,
  `descEntidad` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_entidades`
--

INSERT INTO `rv_entidades` (`idEntidad`, `tieneRuc`, `docRuc`, `descEntidad`) VALUES
(1, 2, '10000000001', 'PERSONA NATURAL'),
(4, 1, '20160588234', 'HOSPITAL SERGIO E  BERNALES'),
(5, 1, '20131373237', 'MINISTERIO DE SALUD'),
(10, 1, '20168999926', 'PRESIDENCIA DEL CONSEJO DE MINISTROS'),
(12, 1, '20601765226', 'PROGRAMA NACIONAL DE INVERSIONES EN SALUD - PRONIS'),
(13, 1, '20131312955', 'SUPERINTENDENCIA NACIONAL DE ADUANAS Y DE ADMINISTRACION TRIBUTARIA - SUNAT'),
(14, 1, '20295613620', 'REGIST. NAC. DE IDENTIF. Y ESTADO CIVIL RENIEC'),
(15, 1, '20131370645', 'MINISTERIO DE ECONOMIA Y FINANZAS'),
(16, 1, '20131366966', 'MINISTERIO DEL INTERIOR'),
(17, 1, '20131370998', 'MINISTERIO DE EDUCACION'),
(18, 1, '20131378972', 'CONTRALORIA GENERAL DE LA REPUBLICA'),
(23, 2, '10000002582', 'DAMAS VOLUNTARIAS'),
(32, NULL, '20165465009', 'POLICIA NACIONAL DEL PERU'),
(33, NULL, '20377985843', 'SUPERINTENDENCIA NACIONAL DE SALUD'),
(34, NULL, '20131257750', 'ESSALUD'),
(35, NULL, '20505208626', 'SEGURO INTEGRAL DE SALUD'),
(36, NULL, '20546736718', 'UNIDAD EJECUTORA 002 - FONDO INTANGIBLE SOLIDARIO DE SALUD - FISSAL'),
(37, 2, '10000009935', 'COMISION VECINAL PRO CONSTRUCCION DEL NUEVO HOSPITAL NACIONAL SERGIO E  BERNALES'),
(38, 2, '10000003258', 'LEGADO LIMA '),
(39, 2, '10000009625', 'ASOCIACIACIÓN DE DESOCUPADOS DE CONSTRUCCIÓN CIVIL  DE COLLIQUE '),
(40, 2, '10000009013', 'ASOCIACION DE DESOCUPADOS DE CONSTRUCCION CIVIL COLLIQUE '),
(41, 2, '10000003660', 'EMPRESA DE BIENES Y SERVICIOS OLIMPUS SAC'),
(42, 2, '10000004707', 'CLUB DE LEONES DE COMAS'),
(43, 2, '10000001446', 'FENUTSA'),
(44, 2, '10000007141', 'SINTRACLAS'),
(45, 2, '10000001475', 'PARTICULAR'),
(46, 2, '10000009721', 'DIRIS LIMA NORTE '),
(47, 2, '10000008797', 'COORDINADORA DISTRITAL DE SEGURIDAD CIUDADANA COMAS  '),
(48, 2, '10000005151', 'MINISTERIO DE LA MUJER'),
(49, 2, '10000007691', 'MINSA'),
(50, 2, '10000009904', 'MINISTERIO DE TRABAJO'),
(51, 2, '10000002053', 'CUERPO MEDICO HNSEB'),
(52, 2, '10000004329', 'MINISTERIO DE CULTURA'),
(53, 2, '10000001957', 'CONGRESO DE LA REPUBLICA '),
(54, 2, '10000004598', 'CONGRESO DE LA REPUBLICA'),
(55, 2, '10000009879', 'SINDICATO DE ENFERMERAS DEL HNSEB'),
(56, 2, '10000008617', 'INABIF'),
(57, 2, '10000008435', 'COOPERATIVA DE AHORROS EL TUMI'),
(58, 2, '10000004959', 'COOPERATIVA DE AHORROS SESP'),
(59, 2, '10000002323', ' INVESMET'),
(60, 2, '10000006214', 'AMERICA TELEVISION '),
(61, 2, '10000008846', 'DIGESA'),
(62, 2, '10000006008', 'SEÑAL ALTERNATIVA MEDIO DE PRENSA'),
(63, 2, '10000004084', 'HOSPITAL CAYETANO HEREDIA '),
(64, 2, '10000009228', 'DAMAS VOLUNTARIAS GENESIS'),
(65, 2, '10000008720', 'MULTIMED'),
(66, 2, '10000009100', 'DGOS  MINSA'),
(67, 2, '10000002116', 'HOSPITAL ARZOBISPO LOAYZA '),
(68, 2, '10000002847', 'SOCIOS EN SALUD '),
(69, 2, '10000004737', 'DIEM  MINSA'),
(70, 2, '10000006283', 'WILLAX TV'),
(71, 2, '10000001422', 'MUNICIPALIDAD DE COMAS'),
(72, 2, '10000002051', 'RADIO EXITOSA'),
(73, 2, '10000002179', 'UDEX PNP'),
(74, 2, '10000008983', 'FRECUENCIA LATINA '),
(75, 2, '10000008131', 'PANAMERICANA TELEVISION'),
(76, 2, '10000001448', 'SOLUCIONES MEDICAS Y SERVICIOS'),
(77, 2, '10000002480', 'DIARIO LA REPUBLICA '),
(78, 2, '10000001387', 'INTUITIVA TV'),
(79, 2, '10000009954', 'IMPORTACIONES LUCUMA'),
(80, 2, '10000007568', 'LABORATORIO ABBOTT'),
(81, 2, '10000001302', 'SENER INGENERIA DE SISTEMAS SA'),
(82, 2, '10000007500', 'EGIS'),
(83, 2, '10000008258', 'CONSORCIO OHL SALFA'),
(84, 2, '10000006247', 'SUSALUD'),
(85, 2, '10000004197', 'QUINTA  FISCALIA  PENAL'),
(86, 2, '10000002140', 'MÃ‰DICOS SIN FRONTERAS'),
(87, 2, '10000009871', 'MEDICOS SIN FRONTERAS '),
(88, 2, '10000004346', 'PALCOMED'),
(89, 2, '10000003096', 'DININCRI POLICIAL NACIONAL DEL PERU '),
(90, 2, '10000007643', 'JURADO NACIONAL DE ELECCIONES'),
(91, 2, '10000002834', 'CLINICA PRIMAVERA '),
(92, 2, '10000005433', 'LABORATORIO'),
(93, 2, '10000008940', 'LABORATORIO MENARINI'),
(94, 2, '10000009434', 'HOSPITAL CARLOS LANFRANCO LA HOZ'),
(95, 2, '10000005022', 'QMEDICAL'),
(96, 2, '10000002319', 'EMBAJADA DE EE UU'),
(97, 2, '10000001242', 'EMPRESA FRAGANCIA DAMIR'),
(98, 2, '10000008782', 'COMISIÓN DISTRITAL DE SALUD DE PUENTE PIEDRA'),
(99, 2, '10000003072', 'GRUPO QUITO'),
(100, 2, '10000009269', 'PRIMERA FISCALIA PENAL CORPORATIVA DE CARABAYLLO'),
(101, 2, '10000004482', 'COMISARIA  DE CANTA '),
(102, 2, '10000007467', 'MAPFRE'),
(103, 2, '10000001341', 'MAPFRE PERU'),
(104, 2, '10000001436', 'FUNDACION INTERNACIONAL WELOVEU'),
(105, 2, '10000005325', 'SAMPEC'),
(106, 2, '10000008680', 'CLINICA MONTELUZ'),
(107, 2, '10000007027', 'MUNICIPALIDAD DE CARABAYLLO'),
(108, 2, '10000007486', 'EMBAJADA DE FRANCIA'),
(109, 2, '10000008255', 'RED DE SALUD VENTANILLA '),
(110, 2, '10000008762', 'LINDE PERU'),
(111, 2, '10000009853', 'INSTITUTO NACIONAL DE REHABILITACION'),
(112, 2, '10000009062', 'COMISION DE TRABAJADORES DE CONSTRUCION CIVIL DEL DISTRITO DE COMO'),
(113, 2, '10000009364', 'PARTIDO POLITICO PERU LIBRE'),
(114, 2, '10000005700', 'UNIVERSIDAD ALAS PERUANAS'),
(115, 2, '10000007226', 'CONFEDERACION DE TRABAJADORES ESTATAL DEL PERU'),
(116, 2, '10000008592', 'GOBERNABILIDAD DE AÑO NUEVO'),
(117, 2, '10000006531', 'SALUD OCUPACIONAL HNSEB'),
(118, 2, '10000002400', 'EMPRESA SIRED'),
(119, 2, '10000003855', 'ORGANIZACION DE NACIONES UNIDAS'),
(120, 2, '10000006429', 'FERLIMA'),
(121, 2, '10000009250', 'CONGRESISTA DE LA REPUBLICA'),
(122, 2, '10000003730', 'COMITE DE SALUD OCUPACIONAL HNSEB'),
(123, 2, '10000004211', 'COMITE DE LUCHA'),
(124, 2, '10000002841', 'SIPTE'),
(125, 2, '10000005789', 'EMPRESA HRS'),
(126, 2, '10000001069', 'PROGRAMA PESRI'),
(127, 2, '10000008859', 'CLINICA SAN BARTOLOME'),
(128, 2, '10000004785', 'INVERSIONES MARTINEZ CHIHUANTITO'),
(129, 2, '10000001208', 'DIGIEP');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_estadovisita`
--

CREATE TABLE `rv_estadovisita` (
  `idEstado` int(11) NOT NULL,
  `descEstado` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_estadovisita`
--

INSERT INTO `rv_estadovisita` (`idEstado`, `descEstado`) VALUES
(1, 'REGISTRADA'),
(2, 'ATENDIDA'),
(3, 'NO ATENDIDA'),
(4, 'DESESTIMADA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_lugares`
--

CREATE TABLE `rv_lugares` (
  `idLugar` int(11) NOT NULL,
  `descLugar` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_lugares`
--

INSERT INTO `rv_lugares` (`idLugar`, `descLugar`) VALUES
(1, 'AUDITORIO DOCENCIA'),
(2, 'SALA DE REUNIONES DIRECCION'),
(3, 'SALA DE REUNIONES COMUNICACIONES'),
(4, 'AUDITORIO PEDIATRIA'),
(5, 'AUDITORIO EMERGENCIA'),
(6, 'AUDITORIO MEDICINA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_lugaresact`
--

CREATE TABLE `rv_lugaresact` (
  `idLugar` int(11) NOT NULL,
  `descLugar` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_lugaresact`
--

INSERT INTO `rv_lugaresact` (`idLugar`, `descLugar`) VALUES
(1, 'AUDITORIO DOCENCIA'),
(2, 'SALA DE REUNIONES DIRECCION'),
(3, 'SALA DE REUNIONES COMUNICACIONES'),
(4, 'AUDITORIO PEDIATRIA'),
(5, 'AUDITORIO EMERGENCIA'),
(6, 'AUDITORIO MEDICINA'),
(7, 'DESPACHO MINISTERIAL - MINSA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_motivos`
--

CREATE TABLE `rv_motivos` (
  `idMotivo` int(11) NOT NULL,
  `descMotivo` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_motivos`
--

INSERT INTO `rv_motivos` (`idMotivo`, `descMotivo`) VALUES
(1, 'REUNIÓN'),
(5, 'DEJAR DOCUMENTO'),
(6, 'COORDINACION'),
(7, 'PERSONAL'),
(8, 'FIRMA DE DOCUMENTO'),
(9, 'MONITOREO Y EVALUACIÓN'),
(10, 'SUPERVISIÓN');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_oficinas`
--

CREATE TABLE `rv_oficinas` (
  `idOficina` int(11) NOT NULL,
  `descOficina` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_oficinas`
--

INSERT INTO `rv_oficinas` (`idOficina`, `descOficina`) VALUES
(1, 'DIRECCIÓN GENERAL'),
(2, 'ÓRGANO DE CONTROL INSTITUCIONAL'),
(3, 'OFICINA DE ASESORÍA JURÍDICA'),
(4, 'OFICINA DE EPIDEMIOLOGÍA Y SALUD AMBIENTAL'),
(5, 'OFICINA DE GESTIÓN DE CALIDAD'),
(6, 'OFICINA EJECUTIVA DE PLANEAMIENTO ESTRATÉGICO'),
(7, 'OFICINA EJECUTIVA DE ADMINISTRACIÓN'),
(8, 'OFICINA DE ECONOMÍA'),
(9, 'OFICINA DE PERSONAL'),
(10, 'OFICINA DE SERVICIOS GENERALES'),
(11, 'OFICINAL DE LOGÍSTICA'),
(12, 'OFICINA DE APOYO A LA DOCENCIA E INVESTIGACIÓN'),
(13, 'OFICINA DE COMUNICACIONES'),
(14, 'OFICINA DE ESTADÍSTICA E INFORMÁTICA'),
(15, 'OFICINA DE SEGUROS'),
(16, 'DEPARTAMENTO CIRUGÍA'),
(17, 'DEPARTAMENTO DE ANESTESIOLOGÍA Y CENTRO QUIRÚRGICO'),
(18, 'DEPARTAMENTO DE CONSULTA EXTERNA Y HOSPITALIZACIÓN'),
(19, 'DEPARTAMENTO DE DIAGNÓSTICO POR IMÁGENES'),
(20, 'DEPARTAMENTO DE EMERGENCIA Y CUIDADOS CRÍTICOS'),
(21, 'DEPARTAMENTO DE ENFERMERÍA'),
(22, 'DEPARTAMENTO DE FARMACIA'),
(23, 'DEPARTAMENTO DE GINECOLOGÍA Y OBSTETRICIA'),
(24, 'DEPARTAMENTO DE MEDICINA'),
(25, 'DEPARTAMENTO DE MEDICINA FÍSICA Y REHABILITACIÓN'),
(26, 'DEPARTAMENTO DE NUTRICIÓN Y DIETÉTICA'),
(27, 'DEPARTAMENTO DE ODONTOESTOMATOLOGÍA'),
(28, 'DEPARTAMENTO DE PATOLOGÍA CLÍNICA Y ANATOMÍA PATOLÓGICA'),
(29, 'DEPARTAMENTO DE PEDIATRÍA'),
(30, 'DEPARTAMENTO DE PSICOLOGÍA'),
(31, 'DEPARTAMENTO DE SERVICIO SOCIAL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_roles`
--

CREATE TABLE `rv_roles` (
  `idRol` int(11) NOT NULL,
  `dscRol` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_roles`
--

INSERT INTO `rv_roles` (`idRol`, `dscRol`, `fecha_creacion`) VALUES
(1, 'Administrador', '2020-02-20 16:34:02'),
(2, 'Registrador', '2020-02-20 16:34:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_tdoc`
--

CREATE TABLE `rv_tdoc` (
  `idTdoc` int(11) NOT NULL,
  `descTDoc` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_tdoc`
--

INSERT INTO `rv_tdoc` (`idTdoc`, `descTDoc`) VALUES
(1, 'DNI'),
(2, 'CE'),
(3, 'PASAPORTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_usuarios`
--

CREATE TABLE `rv_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `oficinaId` int(11) NOT NULL DEFAULT '0',
  `rolId` int(11) NOT NULL,
  `dni` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `nombres` text COLLATE utf8_spanish_ci NOT NULL,
  `aPaterno` text COLLATE utf8_spanish_ci NOT NULL,
  `aMaterno` text COLLATE utf8_spanish_ci NOT NULL,
  `cuenta` text COLLATE utf8_spanish_ci NOT NULL,
  `clave` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` int(11) NOT NULL DEFAULT '0',
  `correo` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_usuarios`
--

INSERT INTO `rv_usuarios` (`id_usuario`, `oficinaId`, `rolId`, `dni`, `nombres`, `aPaterno`, `aMaterno`, `cuenta`, `clave`, `fecha_registro`, `estado`, `correo`) VALUES
(1, 14, 1, '77478995', 'Olger Ivan', 'Castro', 'Palacios', 'ocastrop', '$2a$07$usesomesillystringforeVF6hLwtgsUBAmUN4cGEd8tYF74gSHRW', '2020-03-02 16:22:25', 1, 'ocastrop@hnseb.gob.pe'),
(2, 1, 2, '08744316', 'Julio Antonio', 'Silva', 'Ramos', 'rvdireccion', '$2a$07$usesomesillystringforewjWfwJ5ZbSPk5uShxHbFyVMRYyIIDoK', '2020-09-23 04:35:19', 1, 'direccion@hnseb.gob.pe'),
(4, 14, 1, '40195996', 'Monica Nohemi', 'Rosas', 'Sanchez', 'rosasmn', '$2a$07$usesomesillystringforeoRNSqF5ebwOJ.HFIcVhNJ65bww3hpNi', '2020-10-05 14:27:13', 1, 'rosasmn@hnseb.gob.pe'),
(5, 14, 1, '09966920', 'Javier Octavio', 'Sernaque', 'Quintana', 'jsernaque', '$2a$07$usesomesillystringforeAR0AYDLcMUwZJGc02Ta3T98Pn6LH7pi', '2020-10-12 16:35:18', 1, 'jsernqueq@hnseb.gob.pe'),
(6, 1, 2, '10402790', 'Palerma', 'Velazco', 'Castro De Palacios', 'pvelazco', '$2a$07$usesomesillystringforeO3AVNdml.2y0/OOD7W9btaaPDN6wCse', '2021-03-17 16:12:15', 1, 'prueba@hnseb.gob.pe'),
(7, 1, 2, '08090376', 'Maria Elena', 'Soto', 'Escudero', 'msoto', '$2a$07$usesomesillystringforeqEnVN4s6PkbBgX8e5lw7pl5YJatiaaS', '2021-05-21 16:00:07', 1, 'direccion@hnseb.gob.pe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rv_visitas`
--

CREATE TABLE `rv_visitas` (
  `idVisita` int(11) NOT NULL,
  `fechaVisita` date DEFAULT NULL,
  `vstNombre` text COLLATE utf8_spanish_ci,
  `vstDoc` int(11) DEFAULT NULL,
  `vstNdoc` text COLLATE utf8_spanish_ci,
  `vstEntidad` int(11) DEFAULT NULL,
  `vstMotivo` int(11) DEFAULT NULL,
  `empVisitado` int(11) DEFAULT NULL,
  `ofidepVisitado` int(11) DEFAULT NULL,
  `cargoVisitado` text COLLATE utf8_spanish_ci,
  `lugarVst` int(11) NOT NULL,
  `horaIngreso` time DEFAULT NULL,
  `registraIngreso` int(11) DEFAULT NULL,
  `horaSalida` time DEFAULT NULL,
  `registraSalida` int(11) DEFAULT NULL,
  `fechaHRegSalida` date DEFAULT NULL,
  `estadoV` int(11) DEFAULT '1',
  `registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rv_visitas`
--

INSERT INTO `rv_visitas` (`idVisita`, `fechaVisita`, `vstNombre`, `vstDoc`, `vstNdoc`, `vstEntidad`, `vstMotivo`, `empVisitado`, `ofidepVisitado`, `cargoVisitado`, `lugarVst`, `horaIngreso`, `registraIngreso`, `horaSalida`, `registraSalida`, `fechaHRegSalida`, `estadoV`, `registro`) VALUES
(36, '2020-12-09', 'MARGARITA NANCY PAREDES LOPEZ', 1, '07547087', 23, 6, 1, 1, 'DIRECTOR GENERAL', 2, '10:06:00', 2, '09:30:00', 2, '2020-12-10', 2, '2020-12-09 15:06:25'),
(37, '2020-12-10', 'JORGE LUIS HUERTAS MURGA', 1, '08458478', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '08:16:00', 2, '08:19:00', 2, '2020-12-10', 2, '2020-12-10 13:16:11'),
(38, '2020-12-10', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 6, 1, 1, 'DIRECTOR GENERAL', 2, '08:54:00', 2, NULL, NULL, NULL, 1, '2020-12-10 13:54:03'),
(39, '2020-12-10', 'OSCAR MANUEL BRIONES LABAN', 1, '10213878', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:29:00', 2, NULL, NULL, NULL, 1, '2020-12-10 14:29:58'),
(40, '2020-12-11', 'SALOME ELIZABETH ESCOBEDO SANTOS', 1, '05376954', 5, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:27:00', 2, '13:05:00', 2, '2020-12-11', 2, '2020-12-11 16:27:10'),
(41, '2020-12-11', 'GLADYS ESMERALDA CORREA BOCANEGRA', 1, '20566954', 5, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:31:00', 2, '13:04:00', 2, '2020-12-11', 2, '2020-12-11 16:31:46'),
(42, '2020-12-11', 'ANGELO SANDOVAL QUISPE', 1, '40148476', 38, 1, 1, 1, 'DIRECTOR GENERAL', 2, '13:37:00', 2, '13:51:00', 2, '2020-12-11', 2, '2020-12-11 18:37:13'),
(43, '2020-12-14', 'ROSARIO  DELGADO ', 1, '09900468', 12, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '10:07:00', 2, '10:30:00', 2, '2020-12-14', 2, '2020-12-14 15:07:38'),
(44, '2020-12-15', 'HECTOR ZUBILETE CANDIOTTE', 1, '80507357', 39, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:20:00', 2, '10:39:00', 2, '2020-12-15', 2, '2020-12-15 15:20:52'),
(45, '2020-12-15', 'BLANCA ELENA LUQUE CHAUCA', 1, '10248797', 5, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:40:00', 2, '11:19:00', 2, '2020-12-15', 2, '2020-12-15 15:40:14'),
(46, '2020-12-15', 'MARGARITA NANCY PAREDES LOPEZ', 1, '07547087', 23, 6, 1, 1, 'DIRECTOR GENERAL', 2, '13:18:00', 2, NULL, NULL, NULL, 1, '2020-12-15 18:18:08'),
(47, '2020-12-16', 'MARCO YSA OSHIRO', 1, '42461678', 35, 6, 1, 1, 'DIRECTOR GENERAL', 2, '09:42:00', 2, '12:54:00', 2, '2020-12-16', 2, '2020-12-16 14:42:29'),
(48, '2020-12-16', 'JOFFRE IVAN UGAZ CACHAY', 1, '41843701', 41, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:59:00', 2, '12:35:00', 2, '2020-12-16', 2, '2020-12-16 16:59:35'),
(49, '2020-12-17', 'ANA MARIA ASTOCONDOR FUERTES', 1, '06199772', 0, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:40:00', 2, NULL, NULL, NULL, 1, '2020-12-17 16:40:27'),
(50, '2020-12-18', 'JAVIER NATIVIDAD ALVAREZ PAREDES', 1, '21460322', 12, 6, 1, 1, 'DIRECTOR GENERAL', 2, '08:29:00', 2, '08:58:00', 2, '2020-12-18', 2, '2020-12-18 13:29:03'),
(51, '2020-12-18', 'ANA CHAPIAMA RUIZ', 1, '05328717', 43, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:44:00', 2, NULL, NULL, NULL, 1, '2020-12-18 16:44:04'),
(52, '2020-12-18', 'MARILUZ TELLO RODRIGUEZ', 1, '01092445', 43, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:45:00', 2, '13:40:00', 2, '2020-12-18', 2, '2020-12-18 16:45:54'),
(53, '2020-12-18', 'ZULY YOVANA QUISPE SOLANO', 1, '09745040', 44, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:46:00', 2, '13:40:00', 2, '2020-12-18', 2, '2020-12-18 16:46:53'),
(54, '2020-12-18', 'GABRIELA CORINA MENDOZA CALCINA', 1, '70010660', 41, 1, 1, 1, 'DIRECTOR GENERAL', 2, '13:51:00', 2, '14:21:00', 2, '2020-12-18', 2, '2020-12-18 18:51:35'),
(55, '2020-12-21', 'MIGUEL EDWARD FARFAN ROZAS', 1, '43346408', 0, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:04:00', 2, NULL, NULL, NULL, 1, '2020-12-21 16:04:30'),
(56, '2020-12-21', 'SHARON KATHERINE DONAIRES SALAZAR', 1, '47206078', 45, 7, 1, 1, 'DIRECTOR GENERAL', 2, '13:29:00', 2, '13:36:00', 2, '2020-12-21', 2, '2020-12-21 18:29:46'),
(57, '2020-12-29', 'JAVIER NATIVIDAD ALVAREZ PAREDES', 1, '21460322', 12, 6, 1, 1, 'DIRECTOR GENERAL', 2, '09:21:00', 2, '10:49:00', 2, '2020-12-29', 2, '2020-12-29 14:21:44'),
(58, '2020-12-29', 'MARIA RUIZ DELGADO', 1, '07709906', 46, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:42:00', 2, '12:23:00', 2, '2020-12-29', 2, '2020-12-29 16:42:34'),
(59, '2020-12-31', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:07:00', 2, '09:16:00', 2, '2020-12-31', 2, '2020-12-31 14:07:08'),
(60, '2021-01-04', 'ARTURO SOTOMAYOR ANGULO', 1, '44428728', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '12:09:00', 2, '09:05:00', 2, '2021-01-05', 2, '2021-01-04 17:09:05'),
(61, '2021-01-05', 'LUIS FERNANDO LLANOS ZAVALAGA', 1, '06522415', 46, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:51:00', 2, '12:10:00', 2, '2021-01-05', 2, '2021-01-05 16:51:01'),
(62, '2021-01-05', 'MARCOS GONZALES ARICA ', 1, '07971986', 5, 1, 1, 1, 'DIRECTOR GENERAL', 2, '13:24:00', 2, '13:34:00', 2, '2021-01-05', 2, '2021-01-05 18:24:24'),
(63, '2021-01-05', 'AZUCENA CHUTAZ RODAS', 1, '09017589', 47, 6, 1, 1, 'DIRECTOR GENERAL', 2, '13:36:00', 2, '13:54:00', 2, '2021-01-05', 2, '2021-01-05 18:36:42'),
(64, '2021-01-07', 'MIGUEL EDWARD FARFAN ROZAS', 1, '43346408', 0, 1, 1, 1, 'DIRECTOR GENERAL', 2, '14:54:00', 2, NULL, NULL, NULL, 1, '2021-01-07 19:54:55'),
(65, '2021-01-07', 'MIGUEL FARFAN ROSAS', 1, '43346408', 59, 1, 1, 1, 'DIRECTOR GENERAL', 2, '14:56:00', 2, NULL, NULL, NULL, 1, '2021-01-07 19:56:16'),
(66, '2021-01-08', 'BLANCA LUQUE CHAUCA ', 1, '10248797', 49, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:24:00', 2, '11:10:00', 2, '2021-01-08', 2, '2021-01-08 15:24:47'),
(67, '2021-01-11', 'JOSE LUIS PACHECO ABAD', 1, '72526788', 60, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:09:00', 2, '11:33:00', 2, '2021-01-11', 2, '2021-01-11 16:09:52'),
(68, '2021-01-12', 'MIRIAM GISSELLA CARRASCO YARLEQUE', 1, '43970654', 61, 6, 1, 1, 'DIRECTOR GENERAL', 2, '15:08:00', 2, NULL, NULL, NULL, 1, '2021-01-12 20:08:46'),
(69, '2021-01-13', 'OSCAR LARENAS NUÑEZ', 1, '08009859', 62, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:20:00', 2, '11:20:00', 2, '2021-01-13', 2, '2021-01-13 15:20:26'),
(70, '2021-01-14', 'CARLOS LUIS RICSE CATAÑO', 1, '06183697', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:42:00', 2, '09:03:00', 2, '2021-01-14', 2, '2021-01-14 13:42:23'),
(71, '2021-01-14', 'CLAUDIO WILLBERT RAMIREZ ATENCIO', 1, '01264142', 46, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:04:00', 2, '11:47:00', 2, '2021-01-14', 2, '2021-01-14 14:04:47'),
(72, '2021-01-15', 'AIDA CECILIA ROSA PALACIOS RAMIREZ', 1, '00000000', 0, 1, 1, 1, 'DIRECTOR GENERAL', 1, '09:06:00', 2, NULL, NULL, NULL, 1, '2021-01-15 14:06:30'),
(73, '2021-01-15', 'MARGARITA NANCY PAREDES LOPEZ', 1, '07547087', 64, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '10:13:00', 2, '11:11:00', 2, '2021-01-15', 2, '2021-01-15 15:13:32'),
(74, '2021-01-15', 'AIDA CECILIA ROSA PALACIOS RAMIREZ', 1, '07795281', 63, 1, 1, 1, 'DIRECTOR GENERAL', 1, '11:13:00', 2, NULL, NULL, NULL, 1, '2021-01-15 16:13:01'),
(75, '2021-01-15', 'LENNY PATRICIA WONG MONTOYA', 1, '22102147', 59, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:52:00', 2, '12:02:00', 2, '2021-01-15', 2, '2021-01-15 16:52:13'),
(76, '2021-01-15', 'MIGUEL EDWARD FARFAN ROZAS', 1, '43346408', 59, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:53:00', 2, NULL, NULL, NULL, 1, '2021-01-15 16:53:18'),
(77, '2021-01-15', 'PATRICIA VALDIVIESO GRISANTA ', 1, '09951700', 65, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:07:00', 2, NULL, NULL, NULL, 1, '2021-01-15 17:07:07'),
(78, '2021-01-19', 'LUIS LLANOS ZAVALAGA', 1, '11111111', 46, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:29:00', 2, '11:59:00', 2, '2021-01-19', 2, '2021-01-19 16:29:07'),
(79, '2021-01-19', 'JAIME MORENO EUSTAQUIO', 1, '17807678', 0, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:55:00', 2, NULL, NULL, NULL, 1, '2021-01-19 16:55:37'),
(80, '2021-01-19', 'JAIME MORENO EUSTAQUIO', 1, '17807678', 66, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:59:00', 2, '12:48:00', 2, '2021-01-19', 2, '2021-01-19 16:59:24'),
(81, '2021-01-20', 'ELIBRANDO LORENZO TABOADA CASTILLO', 1, '06239696', 49, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:34:00', 2, '22:39:00', 2, '2021-01-20', 2, '2021-01-20 15:34:40'),
(82, '2021-01-21', 'ROBINSON GUPIOC RIOS ', 1, '11111111', 53, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:42:00', 2, '22:30:00', 2, '2021-01-21', 2, '2021-01-21 14:42:41'),
(83, '2021-01-25', 'JESUS MUÑOZ QUISPE', 1, '43287842', 67, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:10:00', 2, '12:13:00', 2, '2021-01-25', 2, '2021-01-25 17:10:35'),
(84, '2021-01-27', 'GLADYS CORREA BOCANEGRA', 1, '11111111', 66, 6, 1, 1, 'DIRECTOR GENERAL', 2, '09:44:00', 2, '10:07:00', 2, '2021-01-27', 2, '2021-01-27 14:44:42'),
(85, '2021-01-28', 'MARCO ANTONIO TOVAR HUAMANI', 1, '07870679', 68, 1, 1, 1, 'DIRECTOR GENERAL', 2, '13:39:00', 2, '14:58:00', 2, '2021-01-28', 2, '2021-01-28 18:39:29'),
(86, '2021-02-01', 'DANNY DANIEL MARCELO MALLQUI', 1, '44944933', 33, 6, 1, 1, 'DIRECTOR GENERAL', 2, '08:36:00', 2, '09:02:00', 2, '2021-02-01', 2, '2021-02-01 13:36:10'),
(87, '2021-02-01', 'ELIBRANDO LORENZO TABOADA CASTILLO', 1, '06239696', 0, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:44:00', 2, NULL, NULL, NULL, 1, '2021-02-01 13:44:38'),
(88, '2021-02-01', 'ELIBRANDO LORENZO TABOADA CASTILLO', 1, '06239696', 69, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:03:00', 2, '09:45:00', 2, '2021-02-01', 2, '2021-02-01 14:03:41'),
(89, '2021-02-01', 'LUIS LLANOS ZAVALAGA', 1, '06522415', 46, 6, 1, 1, 'DIRECTOR GENERAL', 1, '12:09:00', 2, '15:10:00', 2, '2021-02-01', 2, '2021-02-01 17:09:34'),
(90, '2021-02-02', 'LUIS ALBERTO SUAZO CAVERO', 1, '09341175', 43, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:08:00', 2, NULL, NULL, NULL, 1, '2021-02-02 15:08:59'),
(91, '2021-02-03', 'JOSE PACHECO ABAD ', 1, '72526788', 60, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:20:00', 2, '11:12:00', 2, '2021-02-03', 2, '2021-02-03 14:20:20'),
(92, '2021-02-03', 'VICTOR JUNIOR CHAVEZ MALAVER', 1, '43657426', 70, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:47:00', 2, '12:02:00', 2, '2021-02-03', 2, '2021-02-03 16:47:42'),
(93, '2021-02-03', 'WILLIAM VALLADARES ESCOBEDO', 1, '44538609', 71, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:03:00', 2, '12:28:00', 2, '2021-02-03', 2, '2021-02-03 17:03:16'),
(94, '2021-02-03', 'IVAN ESCOBEDO VILLANUEVA ', 1, '11111111', 72, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:39:00', 2, '12:52:00', 2, '2021-02-03', 2, '2021-02-03 17:39:31'),
(95, '2021-02-03', 'IVAN FLORENCIO ESCUDERO VILLANUEVA', 1, '48100812', 72, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:52:00', 2, '14:12:00', 2, '2021-02-03', 2, '2021-02-03 17:52:20'),
(96, '2021-02-08', 'MARCELO FELIPE PAREDES', 1, '07572401', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '10:23:00', 2, '10:31:00', 2, '2021-02-08', 2, '2021-02-08 15:23:28'),
(97, '2021-02-08', 'LIZANDRO AMANCIO VEGA ESPEJO', 1, '10153137', 32, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:52:00', 2, '11:57:00', 2, '2021-02-08', 2, '2021-02-08 16:52:14'),
(98, '2021-02-09', 'ANGIE RIVERA GUTARRA', 1, '48301108', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:22:00', 2, '13:01:00', 2, '2021-02-09', 2, '2021-02-09 16:22:14'),
(99, '2021-02-10', 'UDEX', 1, '07572401', 73, 6, 1, 1, 'DIRECTOR GENERAL', 2, '12:53:00', 2, NULL, NULL, NULL, 1, '2021-02-10 17:53:12'),
(100, '2021-02-12', 'JUAN ANDRES IZQUIERDO OBLITAS', 1, '43645783', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:23:00', 2, '11:45:00', 2, '2021-02-12', 2, '2021-02-12 16:23:56'),
(101, '2021-02-15', 'TOMAS MARTIN MALAGA ASCENCIO', 1, '09923720', 60, 1, 1, 1, 'DIRECTOR GENERAL', 3, '08:18:00', 2, '09:05:00', 2, '2021-02-15', 2, '2021-02-15 13:18:54'),
(102, '2021-02-15', 'VANESSA MILAGROS SANCHEZ BIFFI', 1, '47470702', 0, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:08:00', 2, NULL, NULL, NULL, 1, '2021-02-15 15:08:47'),
(103, '2021-02-15', 'STEFANY ECHEGARAY HUERTAS', 1, '72001400', 75, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:06:00', 2, '13:48:00', 2, '2021-02-15', 2, '2021-02-15 17:06:20'),
(104, '2021-02-17', 'JUAN MARTIN VASQUEZ SIERRA', 1, '08472426', 76, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '09:09:00', 2, '09:46:00', 2, '2021-02-17', 2, '2021-02-17 14:09:19'),
(105, '2021-02-18', 'JOHANN CARLOS KLUG GUEVARA', 1, '74220798', 77, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:38:00', 2, '10:13:00', 2, '2021-02-18', 2, '2021-02-18 14:38:52'),
(106, '2021-02-18', 'FRANK ERICK GARCILAZO FLORES', 1, '73737848', 78, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:39:00', 2, '09:56:00', 2, '2021-02-18', 2, '2021-02-18 14:39:36'),
(107, '2021-02-22', 'OSCAR MANUEL BRIONES LABAN', 1, '10213878', 12, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:25:00', 2, '13:36:00', 2, '2021-02-22', 2, '2021-02-22 16:25:58'),
(108, '2021-02-25', 'LEONID WILBERT LECCA GARCIA', 1, '10280370', 68, 6, 1, 1, 'DIRECTOR GENERAL', 2, '08:32:00', 2, '09:49:00', 2, '2021-02-25', 2, '2021-02-25 13:32:18'),
(109, '2021-02-25', 'SEGUNDO MISAEL GUERRERO BARCO', 1, '10166319', 79, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '09:58:00', 2, '10:27:00', 2, '2021-02-25', 2, '2021-02-25 14:58:39'),
(110, '2021-02-25', 'JUAN ANDRES IZQUIERDO OBLITAS', 1, '43645783', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '10:27:00', 2, '11:22:00', 2, '2021-02-25', 2, '2021-02-25 15:27:37'),
(111, '2021-03-01', 'JAVIER YOVERA', 1, '09987713', 75, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:45:00', 2, NULL, NULL, NULL, 1, '2021-03-01 15:45:32'),
(112, '2021-03-01', 'JAVIER YOVERA', 1, '09987713', 75, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:46:00', 2, '11:38:00', 2, '2021-03-01', 2, '2021-03-01 15:46:57'),
(113, '2021-03-02', 'MIGUEL EDWARD FARFAN ROZAS', 1, '43346408', 59, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:11:00', 2, '11:41:00', 2, '2021-03-02', 2, '2021-03-02 15:11:42'),
(114, '2021-03-03', 'EDGARD ALBERTO RUIZ TORRES', 1, '25763139', 71, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:59:00', 2, '10:23:00', 2, '2021-03-03', 2, '2021-03-03 14:59:46'),
(115, '2021-03-04', 'BEN FERNANDO VARGAS FERNANDEZ', 1, '09438700', 80, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:46:00', 2, '14:10:00', 2, '2021-03-04', 2, '2021-03-04 17:46:20'),
(116, '2021-03-08', 'MARCOS SIFUENTES ROMERO ', 1, '06999834', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:47:00', 2, NULL, NULL, NULL, 1, '2021-03-08 14:47:56'),
(117, '2021-03-08', 'MARCOS SIFUENTES ROMERO ', 1, '06999834', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:02:00', 2, '11:16:00', 2, '2021-03-08', 2, '2021-03-08 16:02:33'),
(118, '2021-03-09', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:30:00', 2, '10:18:00', 2, '2021-03-09', 2, '2021-03-09 14:30:29'),
(119, '2021-03-11', 'ARTURO GIBAJA NIETO', 3, '26513688', 81, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:02:00', 2, '11:42:00', 2, '2021-03-11', 2, '2021-03-11 16:02:36'),
(120, '2021-03-12', 'ARMANDO SANCHEZ MEDINA', 1, '40041290', 82, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:06:00', 2, '09:35:00', 2, '2021-03-12', 2, '2021-03-12 14:06:08'),
(121, '2021-03-12', 'JOSE CARLOS CASTRO LEVANO', 1, '21878926', 83, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:06:00', 2, '09:35:00', 2, '2021-03-12', 2, '2021-03-12 14:06:57'),
(122, '2021-03-12', 'MARCOS SIFUENTES ', 1, '06999834', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:13:00', 2, '09:35:00', 2, '2021-03-12', 2, '2021-03-12 14:13:09'),
(123, '2021-03-15', 'RICHARD LLANCA FLORES ', 1, '09759932', 66, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:17:00', 2, '11:53:00', 2, '2021-03-15', 2, '2021-03-15 14:17:12'),
(124, '2021-03-15', 'DANNY DANIEL MARCELO MALLQUI', 1, '44944933', 84, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:19:00', 2, '11:52:00', 2, '2021-03-15', 2, '2021-03-15 14:19:34'),
(125, '2021-03-15', 'FLOR DE MARIA CORDOVA GARAY', 1, '46468638', 0, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:31:00', 2, NULL, NULL, NULL, 1, '2021-03-15 17:31:50'),
(126, '2021-03-15', 'FLOR DE MARIA CORDOVA GARAY', 1, '46468638', 57, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:32:00', 2, '13:04:00', 2, '2021-03-15', 2, '2021-03-15 17:32:25'),
(127, '2021-03-16', 'DIANA MORALES LLERENA', 1, '06933351', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:52:00', 2, NULL, NULL, NULL, 1, '2021-03-16 13:52:04'),
(128, '2021-03-17', 'EVA PARIOTA', 3, '111111111', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:00:00', 2, '12:01:00', 2, '2021-03-17', 2, '2021-03-17 14:00:18'),
(129, '2021-03-17', 'ALICE LEGROS', 3, '11111111', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:00:00', 2, '12:00:00', 2, '2021-03-17', 2, '2021-03-17 14:00:55'),
(130, '2021-03-18', 'ESTHER NOEMI PAREJA OLORTIGUE', 1, '41342074', 85, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:55:00', 2, '12:42:00', 2, '2021-03-18', 2, '2021-03-18 14:55:28'),
(131, '2021-03-18', 'SELENE MANGA CHAVEZ ', 1, '29281357', 87, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:45:00', 2, NULL, NULL, NULL, 1, '2021-03-18 17:45:01'),
(132, '2021-03-19', 'LUIS GUILLERMO ALCANTARA OYOLA', 1, '06216417', 45, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:51:00', 2, '13:03:00', 2, '2021-03-19', 2, '2021-03-19 15:51:15'),
(133, '2021-03-24', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:44:00', 2, '09:23:00', 2, '2021-03-24', 2, '2021-03-24 13:44:05'),
(134, '2021-03-26', 'YELITSE CEIBA BOLIVAR ', 3, '018892653', 88, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '12:10:00', 2, NULL, NULL, NULL, 1, '2021-03-26 17:10:38'),
(135, '2021-03-30', 'CARLOS ALBERTO QUILIANO MORENO', 1, '09543669', 45, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:47:00', 2, '14:02:00', 2, '2021-03-30', 2, '2021-03-30 13:47:17'),
(136, '2021-03-31', 'LUIS FERNANDO LLANOS ZAVALAGA', 1, '06522415', 46, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:55:00', 2, '10:52:00', 2, '2021-03-31', 2, '2021-03-31 13:55:03'),
(137, '2021-03-31', 'JUAN ANDRES IZQUIERDO OBLITAS', 1, '43645783', 32, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:52:00', 2, '10:52:00', 2, '2021-03-31', 2, '2021-03-31 15:52:18'),
(138, '2021-03-31', 'MIRKO ELISVAN PASQUEL SANTILLAN', 1, '40367144', 89, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:42:00', 2, '12:54:00', 2, '2021-03-31', 2, '2021-03-31 16:42:59'),
(139, '2021-04-05', 'CARMEN LAURA LIVIA SEGOVIA', 1, '07483745', 46, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:56:00', 2, '12:54:00', 2, '2021-04-06', 2, '2021-04-05 16:56:40'),
(140, '2021-04-06', 'NATHALY BEATRIZ RODRIGUEZ QUIROZ', 1, '73377611', 90, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:42:00', 2, '12:49:00', 2, '2021-04-06', 2, '2021-04-06 16:42:07'),
(141, '2021-04-09', 'CARMEN LAURA LIVIA SEGOVIA', 1, '07483745', 46, 6, 1, 1, 'DIRECTOR GENERAL', 2, '08:54:00', 2, '10:42:00', 2, '2021-04-09', 2, '2021-04-09 13:54:59'),
(142, '2021-04-12', 'JOSE BERNARDO SALAZAR HUAPAYA', 1, '10549119', 46, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '09:37:00', 2, '10:21:00', 2, '2021-04-13', 2, '2021-04-12 14:37:56'),
(143, '2021-04-13', 'CHRISTIAN GUERRERO SOTO', 1, '43698930', 66, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '14:41:00', 2, '14:49:00', 2, '2021-04-13', 2, '2021-04-13 19:41:59'),
(144, '2021-04-14', 'ROSA VIOLETA ROJAS CHAVEZ', 1, '10189245', 91, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:46:00', 2, NULL, NULL, NULL, 1, '2021-04-14 15:46:11'),
(145, '2021-04-14', 'MIGUEL EDWARD FARFAN ROZAS', 1, '43346408', 59, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:56:00', 2, '12:02:00', 2, '2021-04-14', 2, '2021-04-14 15:56:20'),
(146, '2021-04-16', 'RODOLFO TOMAS AVILES HERRERA', 1, '07908397', 12, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '09:34:00', 2, '10:04:00', 2, '2021-04-16', 2, '2021-04-16 14:34:45'),
(147, '2021-04-28', 'LIZET YAJAHIRA QUINTANA MENDOZA', 1, '46649733', 46, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '10:20:00', 2, '10:37:00', 2, '2021-04-28', 2, '2021-04-28 15:20:22'),
(148, '2021-04-29', 'ELMER MARIO LOPEZ LOPEZ', 1, '10187971', 66, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:23:00', 2, '11:42:00', 2, '2021-04-29', 2, '2021-04-29 16:23:06'),
(149, '2021-05-03', 'DAVID VICTORINO JUMPA ARMAS', 1, '44653164', 84, 1, 1, 1, 'DIRECTOR GENERAL', 2, '14:36:00', 2, '14:54:00', 2, '2021-05-03', 2, '2021-05-03 19:36:52'),
(150, '2021-05-06', 'ALBERT BILMARCK CALDERON VIGO', 1, '09397337', 93, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:15:00', 2, '13:16:00', 2, '2021-05-06', 2, '2021-05-06 17:15:21'),
(151, '2021-05-10', 'DANIEL MARCELO BOZA FALCON', 1, '45009696', 46, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:02:00', 2, '12:20:00', 2, '2021-05-10', 2, '2021-05-10 16:02:07'),
(152, '2021-05-18', 'MARTIN MODESTO HUAMANI NINAPAITAN', 1, '06645847', 90, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '13:28:00', 2, '15:13:00', 2, '2021-05-18', 2, '2021-05-18 18:28:29'),
(153, '2021-05-19', 'MIGUEL EDWARD FARFAN ROZAS', 1, '43346408', 59, 6, 1, 1, 'DIRECTOR GENERAL', 2, '10:44:00', 2, '12:21:00', 2, '2021-05-19', 2, '2021-05-19 15:44:01'),
(154, '2021-05-19', 'JORGE FERNANDO RUIZ TORRES', 1, '08130859', 0, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:29:00', 2, NULL, NULL, NULL, 1, '2021-05-19 16:29:31'),
(155, '2021-05-19', 'JORGE FERNANDO RUIZ TORRES', 1, '08130859', 94, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:31:00', 2, '12:18:00', 2, '2021-05-19', 2, '2021-05-19 16:31:07'),
(156, '2021-05-21', 'LUZ MARINA LAGOS GARCIA', 1, '10204046', 95, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:12:00', 2, '10:21:00', 2, '2021-05-21', 2, '2021-05-21 15:12:34'),
(157, '2021-05-24', 'MARGARITA NANCY PAREDES LOPEZ', 1, '07547087', 64, 6, 1, 1, 'DIRECTOR GENERAL', 2, '09:54:00', 2, '10:15:00', 2, '2021-05-24', 2, '2021-05-24 14:54:13'),
(158, '2021-06-04', 'ABRAHAM ALVARADO ', 2, '20192106', 96, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:53:00', 2, '10:27:00', 2, '2021-06-04', 2, '2021-06-04 14:53:44'),
(159, '2021-06-10', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:00:00', 2, '09:35:00', 2, '2021-06-10', 2, '2021-06-10 14:00:43'),
(160, '2021-06-10', 'LILIANA SONIA MONZON RODRIGUEZ', 1, '07219687', 66, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:44:00', 2, '10:41:00', 2, '2021-06-10', 2, '2021-06-10 14:44:58'),
(161, '2021-06-16', 'LILIANA SONIA MONZON RODRIGUEZ', 1, '07219687', 66, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:09:00', 2, '15:36:00', 2, '2021-06-16', 2, '2021-06-16 15:09:22'),
(162, '2021-07-01', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '10:19:00', 2, '12:39:00', 2, '2021-07-01', 2, '2021-07-01 15:19:58'),
(163, '2021-07-07', 'ABEL ANTONIO VEGA ESPINOZA', 1, '76067446', 97, 7, 1, 1, 'DIRECTOR GENERAL', 2, '09:19:00', 2, '09:50:00', 2, '2021-07-07', 2, '2021-07-07 14:19:16'),
(164, '2021-07-13', 'CESAR AUGUSTO CASTILLEGO', 1, '09981529', 98, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:35:00', 2, '09:55:00', 2, '2021-07-13', 2, '2021-07-13 14:35:10'),
(165, '2021-07-15', 'ANA MARITZA CASTILLO MORAN', 1, '17805877', 99, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:24:00', 2, '11:00:00', 2, '2021-07-15', 2, '2021-07-15 15:24:27'),
(166, '2021-07-21', 'ALBERTO GONZÁLES GUZMÁN', 1, '41878712', 68, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:07:00', 2, '13:30:00', 2, '2021-07-21', 2, '2021-07-21 15:07:38'),
(167, '2021-07-21', 'LUIS FERNANDO LLANOS ZAVALAGA', 1, '06522415', 46, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:08:00', 2, '13:30:00', 2, '2021-07-21', 2, '2021-07-21 15:08:04'),
(168, '2021-08-06', 'LEONID WILBERT LECCA GARCIA', 1, '10280370', 68, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:11:00', 2, '10:52:00', 2, '2021-08-06', 2, '2021-08-06 14:11:28'),
(169, '2021-08-10', 'ZEBASTIAN ZEGARRA GONZALES', 1, '73800564', 100, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '13:15:00', 2, '13:47:00', 2, '2021-08-10', 2, '2021-08-10 18:15:36'),
(170, '2021-08-11', 'LUIS FERNANDO LLANOS ZAVALAGA', 1, '06522415', 46, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:53:00', 2, '12:02:00', 2, '2021-08-11', 2, '2021-08-11 14:53:43'),
(171, '2021-08-11', 'ALBERTO GONZÁLES GUZMÁN', 1, '41878712', 68, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:06:00', 2, '12:01:00', 2, '2021-08-11', 2, '2021-08-11 15:06:07'),
(172, '2021-08-16', 'JORGE LUIS GUARDAMINO ZAVALA', 1, '10215940', 101, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '08:58:00', 2, '09:06:00', 2, '2021-08-16', 2, '2021-08-16 13:58:55'),
(173, '2021-08-16', 'CARMEN MONICA ACUÑA JARA', 1, '10073191', 71, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:58:00', 2, '12:18:00', 2, '2021-08-16', 2, '2021-08-16 15:58:24'),
(174, '2021-08-16', 'CARMEN ROSA GOMEZ HUAMAN', 1, '09172238', 23, 1, 1, 1, 'DIRECTOR GENERAL', 2, '12:19:00', 2, '13:32:00', 2, '2021-08-16', 2, '2021-08-16 17:19:30'),
(175, '2021-08-17', 'LEONID WILBERT LECCA GARCIA', 1, '10280370', 68, 1, 1, 1, 'DIRECTOR GENERAL', 2, '13:25:00', 2, '13:57:00', 2, '2021-08-17', 2, '2021-08-17 18:25:57'),
(176, '2021-08-25', 'PEDRO MANUEL ABAD BARREDO', 1, '10296594', 102, 1, 1, 1, 'DIRECTOR GENERAL', 2, '14:48:00', 2, '16:03:00', 2, '2021-08-25', 2, '2021-08-25 19:48:59'),
(177, '2021-08-26', 'EDGAR LEONIDAS CAMPOS MATOS', 1, '41081369', 104, 6, 1, 1, 'DIRECTOR GENERAL', 2, '11:45:00', 2, '11:56:00', 2, '2021-08-26', 2, '2021-08-26 16:45:22'),
(178, '2021-08-31', 'RICHARD JOSE SAM ZAVALA', 1, '25829023', 105, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:27:00', 2, '12:24:00', 2, '2021-08-31', 2, '2021-08-31 16:27:26'),
(179, '2021-09-01', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '08:42:00', 2, '11:01:00', 2, '2021-09-01', 2, '2021-09-01 13:42:21'),
(180, '2021-09-01', 'INGRID MARISSA GONZALES BERNAL', 1, '41812542', 93, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:03:00', 2, '11:18:00', 2, '2021-09-01', 2, '2021-09-01 16:03:59'),
(181, '2021-09-01', 'JOHNNY ROGER TOMA JAIMES', 1, '09545976', 71, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:20:00', 2, '11:45:00', 2, '2021-09-01', 2, '2021-09-01 16:20:17'),
(182, '2021-09-01', 'JULIO CESAR ALARCON CANCHARI', 1, '10764884', 32, 6, 1, 1, 'DIRECTOR GENERAL', 2, '12:08:00', 2, NULL, NULL, NULL, 1, '2021-09-01 17:08:25'),
(183, '2021-09-06', 'AIDA MARILU MEJIA LARA', 1, '10068677', 106, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:52:00', 2, '10:52:00', 2, '2021-09-06', 2, '2021-09-06 14:52:22'),
(184, '2021-09-07', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 7, 1, 1, 'DIRECTOR GENERAL', 2, '09:19:00', 2, '11:48:00', 2, '2021-09-07', 2, '2021-09-07 14:19:29'),
(185, '2021-09-08', 'OSCAR DOLORES AREVALO ', 1, '06739505', 107, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:15:00', 2, '10:25:00', 2, '2021-09-08', 2, '2021-09-08 14:15:52'),
(186, '2021-09-09', 'LILIANA SONIA MONZON RODRIGUEZ', 1, '07219687', 66, 10, 1, 1, 'DIRECTOR GENERAL', 2, '08:58:00', 2, '13:28:00', 2, '2021-09-09', 2, '2021-09-09 13:58:44'),
(187, '2021-09-09', 'ERIC CCONISLLA PALOMINO', 1, '41921949', 84, 10, 1, 1, 'DIRECTOR GENERAL', 2, '09:14:00', 2, '13:28:00', 2, '2021-09-09', 2, '2021-09-09 14:14:09'),
(188, '2021-09-09', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:57:00', 2, '13:28:00', 2, '2021-09-09', 2, '2021-09-09 15:57:39'),
(189, '2021-09-09', 'DINA EMILIA MORALES LLERENA', 1, '06933351', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:58:00', 2, '13:27:00', 2, '2021-09-09', 2, '2021-09-09 15:58:08'),
(190, '2021-09-09', 'OSCAR ELVIS DOLORES AREVALO', 1, '06739505', 107, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:58:00', 2, '13:27:00', 2, '2021-09-09', 2, '2021-09-09 15:58:41'),
(191, '2021-09-09', 'ENMANUEL DAVID SIXDENIER', 2, '004624150', 108, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:00:00', 2, '13:27:00', 2, '2021-09-09', 2, '2021-09-09 16:00:19'),
(192, '2021-09-09', 'MARCO ANTONIO SIFUENTES ROMERO', 1, '06999834', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:11:00', 2, '13:27:00', 2, '2021-09-09', 2, '2021-09-09 16:11:29'),
(193, '2021-09-09', 'LUIS ALBERTO NAVARRETE TORRES', 1, '00790513', 12, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:28:00', 2, '13:26:00', 2, '2021-09-09', 2, '2021-09-09 16:28:31'),
(194, '2021-09-10', 'RODOLFO TOMAS AVILES HERRERA', 1, '07908397', 12, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '10:11:00', 2, '11:22:00', 2, '2021-09-10', 2, '2021-09-10 15:11:15'),
(195, '2021-09-10', 'DANIEL MARCELO BOZA FALCON', 1, '45009696', 46, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '11:28:00', 2, '13:01:00', 2, '2021-09-10', 2, '2021-09-10 16:28:35'),
(196, '2021-09-13', 'LUIS ANTONIO PERICHE RAMIREZ', 1, '25723533', 109, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:27:00', 2, '12:08:00', 2, '2021-09-13', 2, '2021-09-13 16:27:48'),
(197, '2021-09-13', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:33:00', 2, '12:08:00', 2, '2021-09-13', 2, '2021-09-13 16:33:55'),
(198, '2021-09-13', 'VICTOR RODRIGUEZ MORALES', 1, '97104617', 49, 1, 1, 1, 'DIRECTOR GENERAL', 2, '11:35:00', 2, '12:08:00', 2, '2021-09-13', 2, '2021-09-13 16:35:01'),
(199, '2021-09-14', 'KARINA SOLEDAD ROJAS TENORIO', 1, '43355898', 110, 6, 1, 1, 'DIRECTOR GENERAL', 2, '09:14:00', 7, '09:18:00', 7, '2021-09-14', 2, '2021-09-14 14:14:17'),
(200, '2021-09-15', 'ROCIO ARAUJO ', 1, '40131617', 46, 6, 2, 1, 'DIRECTOR ADJUNTO', 2, '08:41:00', 2, '10:32:00', 2, '2021-09-15', 2, '2021-09-15 13:41:30'),
(201, '2021-09-15', 'MARIA CARLA DEL PILAR ATENCIO VERGARA', 1, '46056290', 74, 1, 1, 1, 'DIRECTOR GENERAL', 2, '10:32:00', 2, '12:00:00', 2, '2021-09-15', 2, '2021-09-15 15:32:48'),
(202, '2021-09-21', 'SHARON ANTHUANET NEVES CARDENAS', 1, '45892726', 100, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '09:23:00', 2, '10:26:00', 2, '2021-09-22', 2, '2021-09-21 14:23:55'),
(203, '2021-09-22', 'LILY PINGUZ VERGARA', 1, '25673315', 111, 1, 1, 1, 'DIRECTOR GENERAL', 2, '14:13:00', 2, NULL, NULL, NULL, 1, '2021-09-22 19:13:45'),
(204, '2021-09-28', 'GUSTAVO ELESCANO CHANTA', 1, '80254548', 112, 1, 1, 1, 'DIRECTOR GENERAL', 2, '09:33:00', 2, '10:14:00', 2, '2021-09-28', 2, '2021-09-28 14:33:33'),
(205, '2021-09-28', 'MARITA GUTIERREZ', 1, '08084345', 48, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '13:27:00', 2, '14:06:00', 2, '2021-09-28', 2, '2021-09-28 18:27:18'),
(206, '2021-10-01', 'JULISSA MARCELINA RIVAS BERROCAL', 1, '45494869', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:18:00', 2, '14:24:00', 2, '2021-10-01', 2, '2021-10-01 18:18:57'),
(207, '2021-10-01', 'LUIS ALBERTO ARICA CORREA', 1, '08529116', 113, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:58:00', 2, NULL, NULL, NULL, 1, '2021-10-01 18:58:07'),
(208, '2021-10-04', 'TERESA ELIZABETH PARDO VILCHEZ', 1, '06886281', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:47:00', 2, NULL, NULL, NULL, 1, '2021-10-04 14:47:38'),
(209, '2021-10-13', 'ISRAEL VIRGILIO MORENO CHUNGA', 1, '06685185', 114, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:20:00', 2, '11:30:00', 2, '2021-10-13', 2, '2021-10-13 16:20:50'),
(210, '2021-10-13', 'JUAN MARTIN VASQUEZ SIERRA', 1, '08472426', 76, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:30:00', 2, '12:35:00', 2, '2021-10-13', 2, '2021-10-13 17:30:02'),
(211, '2021-10-13', 'PATRICIA REYMER FLORES', 1, '09543271', 115, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:27:00', 2, '15:39:00', 2, '2021-10-13', 2, '2021-10-13 20:27:14'),
(212, '2021-10-13', 'PEDRO MANUEL ABAD BARREDO', 1, '10296594', 103, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:30:00', 2, '15:49:00', 2, '2021-10-13', 2, '2021-10-13 20:30:44'),
(213, '2021-10-14', 'MAGDALENA GLADYS SANCHEZ FERNANDEZ', 1, '09467144', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:47:00', 2, '11:13:00', 2, '2021-10-14', 2, '2021-10-14 14:47:43'),
(214, '2021-10-18', 'CARLOS CONSTANTINO URIBE GARCIA', 1, '21419974', 49, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:11:00', 2, '11:40:00', 2, '2021-10-18', 2, '2021-10-18 14:11:53'),
(215, '2021-10-18', 'JIMENA GABRIELA RUIZ CARDENAS', 1, '46255460', 68, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:12:00', 2, '11:05:00', 2, '2021-10-18', 2, '2021-10-18 14:12:26'),
(216, '2021-10-18', 'JOHN FELIPE BENDEZU REYES', 1, '09470318', 116, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:41:00', 2, '16:01:00', 2, '2021-10-18', 2, '2021-10-18 20:41:15'),
(217, '2021-10-19', 'GUSTAVO ELESCANO CHANTA', 1, '80254548', 112, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:36:00', 2, '09:41:00', 2, '2021-10-19', 2, '2021-10-19 14:36:26'),
(218, '2021-10-20', 'CESAR MATIAS LUCHINI', 1, '09037255', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '08:18:00', 2, '09:21:00', 2, '2021-10-20', 2, '2021-10-20 13:18:29'),
(219, '2021-10-26', 'GUILLERMO HERNAN CAUZO ESCALANTE', 1, '09194454', 49, 6, 3, 1, 'DIRECTOR GENERAL', 2, '09:02:00', 2, '09:38:00', 2, '2021-10-26', 2, '2021-10-26 14:02:44'),
(220, '2021-10-26', 'SUSSAN ROXANA MENESES QUISPE', 1, '44436785', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:37:00', 2, '13:33:00', 2, '2021-10-26', 2, '2021-10-26 16:37:51'),
(221, '2021-10-29', 'CARDELIA FLOREZ NUÑEZ DE LA TORRE', 1, '06832466', 44, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:12:00', 2, '13:33:00', 2, '2021-10-29', 2, '2021-10-29 17:12:42'),
(222, '2021-11-02', 'SANDRO LUIS RAMIREZ MARTINEZ', 1, '32487261', 117, 1, 3, 1, 'DIRECTOR GENERAL', 2, '08:38:00', 2, '09:30:00', 2, '2021-11-02', 2, '2021-11-02 13:38:10'),
(223, '2021-11-03', 'YENNI CHANTA CENTURION', 1, '10749571', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:16:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:16:40'),
(224, '2021-11-03', 'JOHEL RIVADENEYRA', 1, '06867988', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:17:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:17:41'),
(225, '2021-11-03', 'PERCY CESAR JESUS BAUTISTA BAUTISTA', 1, '09989766', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:25:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:25:01'),
(226, '2021-11-03', 'JESUS ERLINDA CAMPOS CALIXTRO', 1, '10214367', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:26:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:26:32'),
(227, '2021-11-03', 'YANE DIAZ VASQUEZ', 1, '80243689', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:29:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:29:31'),
(228, '2021-11-03', 'LAURA MARGARITA VERANO FLORES', 1, '06927588', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:30:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:30:32'),
(229, '2021-11-03', 'MARGOT NATIVIDAD ANAMPA CHIPANA', 1, '09746612', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:31:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:31:11'),
(230, '2021-11-03', 'LUIS IVAN VILCHEZ RETTO', 1, '10694863', 45, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:31:00', 2, NULL, NULL, NULL, 1, '2021-11-03 18:31:55'),
(231, '2021-11-05', 'ANGEL HEDISON ROJAS LIVIA', 1, '41386253', 53, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:14:00', 2, '09:27:00', 2, '2021-11-05', 2, '2021-11-05 14:14:08'),
(232, '2021-11-09', 'PABLO FERNANDO VEGA LEVANO', 1, '41947800', 118, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:09:00', 2, '14:36:00', 2, '2021-11-09', 2, '2021-11-09 17:09:14'),
(233, '2021-11-09', 'GIULIO ANDRES CHAVARRY ALVAREZ', 1, '47012039', 118, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:09:00', 2, '14:36:00', 2, '2021-11-09', 2, '2021-11-09 17:09:44'),
(234, '2021-11-09', 'KELY MARLENI RETUERTO MURILLO', 1, '41071993', 55, 1, 3, 1, 'DIRECTOR GENERAL', 2, '14:37:00', 2, NULL, NULL, NULL, 1, '2021-11-09 19:37:16'),
(235, '2021-11-10', 'SANDRO LUIS RAMIREZ MARTINEZ', 1, '32487261', 117, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '09:24:00', 2, '14:06:00', 2, '2021-11-10', 2, '2021-11-10 14:24:34'),
(236, '2021-11-11', 'CARDELIA FLOREZ NUÑEZ DE LA TORRE', 1, '06832466', 44, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:14:00', 2, '12:00:00', 2, '2021-11-11', 2, '2021-11-11 16:14:22'),
(237, '2021-11-23', 'ESSENIN FERNANDO FERNANDEZ RENGIFO', 1, '06802452', 84, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:19:00', 2, '10:45:00', 2, '2021-11-23', 2, '2021-11-23 14:19:00'),
(238, '2021-11-24', 'SUSANA LUCERO GONZALES CORONADO', 1, '45780977', 5, 1, 2, 1, 'DIRECTOR ADJUNTO', 2, '10:23:00', 2, '11:23:00', 2, '2021-11-24', 2, '2021-11-24 15:23:02'),
(239, '2021-11-25', 'RAFAEL NICOLAS MUNDACA PEÑARANDA', 1, '73375053', 119, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:49:00', 2, '11:33:00', 2, '2021-11-25', 2, '2021-11-25 14:49:51'),
(240, '2021-12-02', 'CARDELIA FLOREZ NUÑEZ DE LA TORRE', 1, '06832466', 44, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:36:00', 2, '14:54:00', 2, '2021-12-02', 2, '2021-12-02 16:36:49'),
(241, '2021-12-02', 'JOSE RAMIRO GALLO ROJAS', 1, '08048253', 120, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:39:00', 2, '14:53:00', 2, '2021-12-02', 2, '2021-12-02 16:39:10'),
(242, '2021-12-02', 'HECTOR VALER PINTO', 1, '25567150', 121, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:49:00', 2, '14:53:00', 2, '2021-12-02', 2, '2021-12-02 18:49:58'),
(243, '2021-12-03', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:07:00', 2, '12:23:00', 2, '2021-12-03', 2, '2021-12-03 16:07:11'),
(244, '2021-12-07', 'KELY MARLENI RETUERTO MURILLO', 1, '41071993', 55, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:17:00', 2, '14:10:00', 2, '2021-12-07', 2, '2021-12-07 18:17:14'),
(245, '2021-12-13', 'SANDRO LUIS RAMIREZ MARTINEZ', 1, '32487261', 122, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:17:00', 2, '11:22:00', 2, '2021-12-13', 2, '2021-12-13 14:17:51'),
(246, '2021-12-15', 'LUIS ALBERTO ARICA CORREA', 1, '08529116', 113, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:25:00', 2, '14:46:00', 2, '2021-12-15', 2, '2021-12-15 18:25:35'),
(247, '2021-12-30', 'JANET PINTADO DAVILA', 1, '06733057', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:39:00', 2, '12:10:00', 2, '2021-12-30', 2, '2021-12-30 14:39:30'),
(248, '2022-01-05', 'MARLENY CARRERA PEZE', 1, '41156815', 66, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:31:00', 2, '16:11:00', 2, '2022-01-05', 2, '2022-01-05 16:31:21'),
(249, '2022-01-07', 'CARDELIA FLOREZ NUÑEZ DE LA TORRE', 1, '06832466', 44, 1, 3, 1, 'DIRECTOR GENERAL', 2, '14:31:00', 2, '16:09:00', 2, '2022-01-07', 2, '2022-01-07 19:31:01'),
(250, '2022-01-10', 'ARTEMIO TORO SANDOVAL', 1, '06840603', 37, 1, 3, 1, 'DIRECTOR GENERAL', 2, '08:50:00', 2, '13:05:00', 2, '2022-01-10', 2, '2022-01-10 13:50:46'),
(251, '2022-01-14', 'JIMENA GABRIELA RUIZ CARDENAS', 1, '46255460', 68, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:37:00', 2, '11:13:00', 2, '2022-01-14', 2, '2022-01-14 14:37:05'),
(252, '2022-01-18', 'RUBEN PACHECO CASTAÑEDA', 1, '08103222', 12, 1, 3, 1, 'DIRECTOR GENERAL', 2, '10:36:00', 2, '11:49:00', 2, '2022-01-18', 2, '2022-01-18 15:36:10'),
(253, '2022-01-25', 'YENNI CHANTA CENTURION', 1, '10749571', 123, 1, 3, 1, 'DIRECTOR GENERAL', 2, '14:30:00', 2, '15:12:00', 2, '2022-01-25', 2, '2022-01-25 19:30:40'),
(254, '2022-02-16', 'CARDELIA FLOREZ NUÑEZ DE LA TORRE', 1, '06832466', 44, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:07:00', 2, '12:30:00', 2, '2022-02-16', 2, '2022-02-16 17:07:00'),
(255, '2022-02-16', 'KELY MARLENI RETUERTO MURILLO', 1, '41071993', 124, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:08:00', 2, '12:30:00', 2, '2022-02-16', 2, '2022-02-16 17:08:50'),
(256, '2022-02-21', 'ANA MARITZA CASTILLO MORAN', 1, '17805877', 125, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:40:00', 2, '16:07:00', 2, '2022-02-21', 2, '2022-02-21 20:40:55'),
(257, '2022-02-21', 'FRANK JAMMIR FLORES AGAMA', 1, '74699447', 125, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:41:00', 2, '16:07:00', 2, '2022-02-21', 2, '2022-02-21 20:41:33'),
(258, '2022-02-23', 'ALEX ULISES TADEO ARRIETA', 1, '40814878', 107, 1, 3, 1, 'DIRECTOR GENERAL', 2, '10:24:00', 2, '14:31:00', 2, '2022-02-23', 2, '2022-02-23 15:24:54'),
(259, '2022-02-23', 'GIOVANA MARIA TADEO ARRIETA', 1, '40386007', 107, 1, 3, 1, 'DIRECTOR GENERAL', 2, '10:25:00', 2, '14:29:00', 2, '2022-02-23', 2, '2022-02-23 15:25:43'),
(260, '2022-02-28', 'FLAVIO ALFREDO SAYAN COTRINA', 1, '06839659', 71, 1, 3, 1, 'DIRECTOR GENERAL', 2, '12:40:00', 2, '13:13:00', 2, '2022-02-28', 2, '2022-02-28 17:40:06'),
(261, '2022-03-03', 'JOSE ANGEL VALDEZ FLORES', 1, '41343797', 49, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:44:00', 2, '12:18:00', 2, '2022-03-03', 2, '2022-03-03 16:44:44'),
(262, '2022-03-03', 'GUILLERMO EDUARDO FRIAS MARTINELLI', 1, '07729287', 126, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:51:00', 2, '16:12:00', 2, '2022-03-03', 2, '2022-03-03 20:51:38'),
(263, '2022-03-03', 'LILIANA DEL CARMEN LA ROSA HUERTAS', 1, '10374314', 126, 1, 3, 1, 'DIRECTOR GENERAL', 2, '15:52:00', 2, '16:13:00', 2, '2022-03-03', 2, '2022-03-03 20:52:07'),
(264, '2022-03-07', 'HECTOR GONZALO QUISPE CARRASCAL', 1, '21520089', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:39:00', 2, '12:58:00', 2, '2022-03-07', 2, '2022-03-07 14:39:13'),
(265, '2022-03-07', 'RAUL VICTOR TORRES CASTAÑEDA', 1, '04067983', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:50:00', 2, '12:58:00', 2, '2022-03-07', 2, '2022-03-07 14:50:01'),
(266, '2022-03-08', 'JORGE ELIAS PALACIOS BAZAN', 1, '10206718', 127, 1, 3, 1, 'DIRECTOR GENERAL', 2, '13:20:00', 2, '15:07:00', 2, '2022-03-08', 2, '2022-03-08 18:20:36'),
(267, '2022-03-09', 'ERIC VASQUEZ ESPINOZA', 1, '00868968', 43, 1, 3, 1, 'DIRECTOR GENERAL', 2, '10:59:00', 2, NULL, NULL, NULL, 1, '2022-03-09 15:59:45'),
(268, '2022-03-09', 'TERESA TAFUR', 1, '10989832', 43, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:00:00', 2, NULL, NULL, NULL, 1, '2022-03-09 16:00:20'),
(269, '2022-03-09', 'WILMER ANTON MAYANGA', 1, '17555386', 43, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:00:00', 2, NULL, NULL, NULL, 1, '2022-03-09 16:00:57'),
(270, '2022-03-17', 'YESSICA DEL PILAR DIAZ CANALES', 1, '47470424', 128, 1, 3, 1, 'DIRECTOR GENERAL', 2, '11:45:00', 2, '12:48:00', 2, '2022-03-17', 2, '2022-03-17 16:45:17'),
(271, '2022-03-22', 'JUAN BARTOLOME BURGOS OLIVEROS', 1, '18080185', 121, 1, 3, 1, 'DIRECTOR GENERAL', 2, '10:26:00', 2, NULL, NULL, NULL, 1, '2022-03-22 15:26:28'),
(272, '2022-04-01', 'CARLOS ALFREDO CELESTINO SOLIS', 1, '10169785', 49, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:14:00', 2, '15:33:00', 2, '2022-04-01', 2, '2022-04-01 14:14:16'),
(273, '2022-04-01', 'RICHARD CLEOFE LLANCA FLORES', 1, '09759932', 66, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:15:00', 2, '15:33:00', 2, '2022-04-01', 2, '2022-04-01 14:15:14'),
(274, '2022-04-07', 'HONORIO MARTIN MEJIA LIÑAN', 1, '09049310', 46, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:43:00', 2, NULL, NULL, NULL, 1, '2022-04-07 14:43:40'),
(275, '2022-04-07', 'MICHAEL FRANKLIN YURIVILCA ALVA', 1, '09608454', 129, 1, 3, 1, 'DIRECTOR GENERAL', 2, '09:47:00', 2, NULL, NULL, NULL, 1, '2022-04-07 14:47:35');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `rv_actividades`
--
ALTER TABLE `rv_actividades`
  ADD PRIMARY KEY (`idActividad`);

--
-- Indices de la tabla `rv_empleados`
--
ALTER TABLE `rv_empleados`
  ADD PRIMARY KEY (`idEmpleado`);

--
-- Indices de la tabla `rv_entidades`
--
ALTER TABLE `rv_entidades`
  ADD PRIMARY KEY (`idEntidad`);

--
-- Indices de la tabla `rv_estadovisita`
--
ALTER TABLE `rv_estadovisita`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `rv_lugares`
--
ALTER TABLE `rv_lugares`
  ADD PRIMARY KEY (`idLugar`);

--
-- Indices de la tabla `rv_lugaresact`
--
ALTER TABLE `rv_lugaresact`
  ADD PRIMARY KEY (`idLugar`);

--
-- Indices de la tabla `rv_motivos`
--
ALTER TABLE `rv_motivos`
  ADD PRIMARY KEY (`idMotivo`);

--
-- Indices de la tabla `rv_oficinas`
--
ALTER TABLE `rv_oficinas`
  ADD PRIMARY KEY (`idOficina`);

--
-- Indices de la tabla `rv_roles`
--
ALTER TABLE `rv_roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `rv_tdoc`
--
ALTER TABLE `rv_tdoc`
  ADD PRIMARY KEY (`idTdoc`);

--
-- Indices de la tabla `rv_usuarios`
--
ALTER TABLE `rv_usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `rv_visitas`
--
ALTER TABLE `rv_visitas`
  ADD PRIMARY KEY (`idVisita`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `rv_actividades`
--
ALTER TABLE `rv_actividades`
  MODIFY `idActividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `rv_empleados`
--
ALTER TABLE `rv_empleados`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rv_entidades`
--
ALTER TABLE `rv_entidades`
  MODIFY `idEntidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT de la tabla `rv_estadovisita`
--
ALTER TABLE `rv_estadovisita`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `rv_lugares`
--
ALTER TABLE `rv_lugares`
  MODIFY `idLugar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `rv_lugaresact`
--
ALTER TABLE `rv_lugaresact`
  MODIFY `idLugar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `rv_motivos`
--
ALTER TABLE `rv_motivos`
  MODIFY `idMotivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `rv_oficinas`
--
ALTER TABLE `rv_oficinas`
  MODIFY `idOficina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `rv_roles`
--
ALTER TABLE `rv_roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rv_tdoc`
--
ALTER TABLE `rv_tdoc`
  MODIFY `idTdoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rv_usuarios`
--
ALTER TABLE `rv_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `rv_visitas`
--
ALTER TABLE `rv_visitas`
  MODIFY `idVisita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=276;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
