-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para ecommunity
CREATE DATABASE IF NOT EXISTS `ecommunity` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommunity`;

-- Volcando estructura para tabla ecommunity.bitacora
CREATE TABLE IF NOT EXISTS `bitacora` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tabla` varchar(50) NOT NULL DEFAULT '0',
  `id_registro_editado` int NOT NULL DEFAULT '0',
  `accion` varchar(50) NOT NULL DEFAULT '0',
  `fecha_edición` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.bitacora: ~0 rows (aproximadamente)
INSERT INTO `bitacora` (`id`, `tabla`, `id_registro_editado`, `accion`, `fecha_edición`) VALUES
	(1, 'Empresas', 8, 'Información Editada', '2024-07-28 02:53:35'),
	(2, 'Puntos_Recoleccion', 9, 'Información Editada', '2024-07-28 02:56:00'),
	(3, 'Usuarios', 1, 'Información Editada', '2024-07-28 02:56:22'),
	(4, 'Usuarios', 16, 'Información Editada', '2024-07-28 22:15:57');

-- Volcando estructura para tabla ecommunity.empresas
CREATE TABLE IF NOT EXISTS `empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '',
  `ubicacion` varchar(50) NOT NULL DEFAULT '0',
  `correo` varchar(50) NOT NULL DEFAULT '0',
  `telefono` int NOT NULL DEFAULT '0',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.empresas: ~12 rows (aproximadamente)
INSERT INTO `empresas` (`id`, `nombre`, `ubicacion`, `correo`, `telefono`, `fecha_creacion`) VALUES
	(8, 'Empresa Añañin', 'Ubicación A', 'contacto@empresaa.com', 1234567890, '2024-01-01 06:00:00'),
	(9, 'Empresa B', 'Ubicación B', 'contacto@empresab.com', 1234567891, '2024-01-02 06:00:00'),
	(10, 'Empresa C', 'Ubicación C', 'contacto@empresac.com', 1234567892, '2024-01-03 06:00:00'),
	(11, 'Empresa D', 'Ubicación D', 'contacto@empresad.com', 1234567893, '2024-01-04 06:00:00'),
	(12, 'Empresa E', 'Ubicación E', 'contacto@empresaE.com', 1234567894, '2024-01-05 06:00:00'),
	(13, 'Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-18 00:37:17'),
	(21, 'Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-18 01:03:54'),
	(22, 'Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-18 01:33:56'),
	(23, 'Prueba3', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-19 00:34:59'),
	(24, 'Punto Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-20 01:29:35'),
	(25, 'Punto Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-20 01:29:49'),
	(26, 'Prueba', 'Queretaro', 'empresa@prueba.com1', 1234567890, '2024-07-20 01:32:03');

-- Volcando estructura para tabla ecommunity.horarios_recoleccion
CREATE TABLE IF NOT EXISTS `horarios_recoleccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hora_inicio` varchar(50) NOT NULL,
  `hora_final` varchar(50) NOT NULL,
  `dia` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_puntoRecoleccion` int NOT NULL,
  `horario_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `horariosPunto` (`id_puntoRecoleccion`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.horarios_recoleccion: ~30 rows (aproximadamente)
INSERT INTO `horarios_recoleccion` (`id`, `hora_inicio`, `hora_final`, `dia`, `id_puntoRecoleccion`, `horario_creacion`) VALUES
	(6, '10:00:00', '12:00:00', 'Miércoles', 10, '2024-07-16 17:40:18'),
	(7, '11:00:00', '13:00:00', 'Jueves', 11, '2024-07-16 17:40:18'),
	(8, '12:00:00', '14:00:00', 'Viernes', 12, '2024-07-16 17:40:18'),
	(13, '00:47', '12:47', 'Jueves', 15, '2024-07-20 00:47:05'),
	(14, '00:47', '12:47', 'Viernes', 15, '2024-07-20 00:47:05'),
	(15, '14:47', '02:47', 'Lunes', 17, '2024-07-27 14:48:02'),
	(16, '04:48', '14:47', 'Viernes', 17, '2024-07-27 14:48:02'),
	(17, '04:47', '03:47', 'Domingo', 17, '2024-07-27 14:48:02'),
	(19, '14:50', '02:50', 'Martes', 18, '2024-07-27 14:48:32'),
	(21, '03:55', '14:54', 'Lunes', 22, '2024-07-27 14:56:16'),
	(22, '14:54', '03:54', 'Martes', 22, '2024-07-27 14:56:16'),
	(23, '06:54', '02:58', 'Miércoles', 22, '2024-07-27 14:56:16'),
	(24, '04:55', '03:54', 'Viernes', 22, '2024-07-27 14:56:16'),
	(25, '16:08', '16:08', 'Viernes', 26, '2024-07-27 15:08:01'),
	(26, '17:09', '04:09', 'Martes', 27, '2024-07-27 15:08:28'),
	(50, '19:16', '19:16', 'Lunes', 13, '2024-07-27 19:17:27'),
	(51, '19:13', '19:13', 'Martes', 13, '2024-07-27 19:17:27'),
	(52, '19:18', '21:16', 'Miércoles', 13, '2024-07-27 19:17:27'),
	(53, '09:19', '19:17', 'Lunes', 16, '2024-07-27 19:18:09'),
	(54, '09:19', '09:19', 'Viernes', 16, '2024-07-27 19:18:09'),
	(55, '19:18', '11:20', 'Domingo', 16, '2024-07-27 19:18:09'),
	(59, '08:14', '08:14', 'Lunes', 28, '2024-07-27 20:14:43'),
	(60, '21:14', '08:15', 'Viernes', 28, '2024-07-27 20:14:43'),
	(74, '20:30', '20:30', 'Martes', 14, '2024-07-27 20:30:07'),
	(75, '08:00', '09:00', 'Jueves', 14, '2024-07-27 20:30:07'),
	(76, '08:00', '09:00', 'Sábado', 14, '2024-07-27 20:30:07'),
	(77, '08:00', '09:00', 'Domingo', 14, '2024-07-27 20:30:07'),
	(78, '08:00:00', '10:00:00', 'Lunes', 9, '2024-07-27 20:56:00'),
	(79, '09:00:00', '11:00:00', 'Martes', 9, '2024-07-27 20:56:00'),
	(80, '20:29', '20:29', 'Viernes', 9, '2024-07-27 20:56:00');

-- Volcando estructura para tabla ecommunity.puntos_recoleccion
CREATE TABLE IF NOT EXISTS `puntos_recoleccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `ubicacion` varchar(50) NOT NULL DEFAULT '',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.puntos_recoleccion: ~7 rows (aproximadamente)
INSERT INTO `puntos_recoleccion` (`id`, `nombre`, `ubicacion`, `fecha_creacion`) VALUES
	(9, 'Punto Añañin', 'Ubicación A', '2024-07-16 17:35:51'),
	(10, 'Punto B', 'Ubicación B', '2024-07-16 17:35:51'),
	(11, 'Punto C', 'Ubicación C', '2024-07-16 17:35:51'),
	(13, 'Punto Editado', 'Ubicación Editada', '2024-07-16 17:35:51'),
	(15, 'Punto Prueba', 'Queretaro', '2024-07-20 00:47:05'),
	(16, 'Prueba', 'Queretaro', '2024-07-27 14:47:41'),
	(17, 'Prueba', 'Queretaro', '2024-07-27 14:48:02');

-- Volcando estructura para tabla ecommunity.puntos_recoleccion_empresa
CREATE TABLE IF NOT EXISTS `puntos_recoleccion_empresa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_punto_recoleccion` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_puntos_recoleccion` (`id_punto_recoleccion`),
  CONSTRAINT `id_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_puntos_recoleccion` FOREIGN KEY (`id_punto_recoleccion`) REFERENCES `puntos_recoleccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.puntos_recoleccion_empresa: ~5 rows (aproximadamente)
INSERT INTO `puntos_recoleccion_empresa` (`id`, `id_empresa`, `id_punto_recoleccion`) VALUES
	(6, 8, 9),
	(7, 8, 9),
	(8, 10, 10),
	(9, 11, 11);

-- Volcando estructura para tabla ecommunity.recolecciones_usuarios
CREATE TABLE IF NOT EXISTS `recolecciones_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `dia` varchar(50) NOT NULL,
  `hora` varchar(50) NOT NULL,
  `cantidad` float NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '"Pendiente"',
  `id_punto_recoleccion` int NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recoleccion_puntoRecoleccion` (`id_punto_recoleccion`),
  KEY `recoleccion_usuario` (`id_usuario`),
  CONSTRAINT `recoleccion_puntoRecoleccion` FOREIGN KEY (`id_punto_recoleccion`) REFERENCES `puntos_recoleccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recoleccion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.recolecciones_usuarios: ~11 rows (aproximadamente)
INSERT INTO `recolecciones_usuarios` (`id`, `tipo`, `dia`, `hora`, `cantidad`, `status`, `id_punto_recoleccion`, `id_usuario`) VALUES
	(1, 'Vidrio', '2023-07-09', '09:00', 12, 'Completada', 10, 1),
	(3, 'Vidrio', '2023-07-09', '08:00', 10, 'Completada', 9, 1),
	(4, 'Plástico', '2024-07-09', '09:00', 20, 'Cancelada', 10, 1),
	(5, 'Textil', '2023-07-10', '11:00', 28.9, 'Cancelada', 11, 1),
	(6, 'Vidrio', '2024-07-09', '11:00', 40, 'Pendiente', 11, 1),
	(7, 'Textil', '2024-07-09', '10:00', 30, 'Pendiente', 10, 1),
	(8, 'Metal', '2024-07-09', '10:00', 30, 'Pendiente', 10, 1),
	(9, 'Papel/Cartón', '2024-07-02', '23:19', 1, 'Pendiente', 9, 1),
	(10, 'Papel/Cartón', '2024-07-27', '23:21', 3, 'Pendiente', 10, 1),
	(11, 'Residuos Orgánicos', '2024-07-03', '14:10', 12.5, 'Pendiente', 17, 1),
	(12, 'Otros', '2024-07-31', '03:11', 14, 'Pendiente', 11, 1),
	(13, 'Textil', '2024-07-29', '23:45', 12, 'Cancelada', 11, 17);

-- Volcando estructura para tabla ecommunity.tipos_reciclajes_empresas
CREATE TABLE IF NOT EXISTS `tipos_reciclajes_empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_reciclaje` varchar(50) NOT NULL DEFAULT '0',
  `id_empresa` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `empresa_reciclaje` (`id_empresa`),
  CONSTRAINT `empresa_reciclaje` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.tipos_reciclajes_empresas: ~24 rows (aproximadamente)
INSERT INTO `tipos_reciclajes_empresas` (`id`, `tipo_reciclaje`, `id_empresa`) VALUES
	(4, 'Metal', 10),
	(5, 'Orgánico', 11),
	(6, 'Textil', 13),
	(7, 'Metales/Chatarra', 13),
	(9, 'Aparatos Electrónicos', 13),
	(12, 'Plástico', 21),
	(13, 'Vidrio', 21),
	(14, 'Plástico', 22),
	(15, 'Tierra/Escombros', 22),
	(16, 'Aparatos Electrónicos', 22),
	(23, 'Plástico', 9),
	(29, 'Metales/Chatarra', 12),
	(30, 'Tierra/Escombros', 12),
	(36, 'Plástico', 23),
	(37, 'Aparatos Electrónicos', 23),
	(38, 'Papel/Cartón', 23),
	(39, 'Vidrio', 23),
	(40, 'Residuos Orgánicos', 25),
	(41, 'Baterías', 25),
	(42, 'Tierra/Escombros', 26),
	(45, 'Textil', 24),
	(46, 'Residuos Orgánicos', 24),
	(53, 'Papel', 8),
	(54, 'Baterías', 8);

-- Volcando estructura para tabla ecommunity.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `correo` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `ubicacion` varchar(50) NOT NULL DEFAULT '0',
  `rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ecommunity.usuarios: ~9 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password`, `ubicacion`, `rol`, `fecha_creacion`) VALUES
	(1, 'Sebastián Ramírez García', 'sebas@correos.com', 'password', 'Queretaro', 'Administrador', '2024-07-05 17:35:04'),
	(5, 'Emiliano Alexander Pérez San Luis', 'emi@correo.com', 'emiliano123', 'Queretaro', 'Usuario', '2024-07-05 21:22:40'),
	(6, 'Andrea Alicia Medina Everardo', 'andrea@gmail.com', 'andy12345', 'Queretaro', 'Administrador', '2024-07-05 21:29:54'),
	(9, 'Usuario A', 'usuarioa@example.com', 'password1', 'Queretaro', 'Administrador', '2024-07-16 23:37:00'),
	(10, 'Usuario B', 'usuariob@example.com', 'password2', 'Queretaro', 'Usuario', '2024-07-16 23:37:00'),
	(11, 'Usuario C', 'usuarioc@example.com', 'password3', 'Queretaro', 'Usuario', '2024-07-16 23:37:00'),
	(12, 'Usuario D', 'usuariod@example.com', 'password4', 'Queretaro', 'Usuario', '2024-07-16 23:37:00'),
	(16, 'Admin', 'admin@correo.com', '12345678', 'Queretaro', 'Administrador', '2024-07-28 22:15:13'),
	(17, 'Sebas', '121@qw', 'qwe', 'Queretaro', 'Usuario', '2024-07-28 23:10:11');

-- Volcando estructura para procedimiento ecommunity.SP_DeleteEmpresa
DELIMITER //
CREATE PROCEDURE `SP_DeleteEmpresa`(
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	DELETE FROM empresas WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_DeleteHorarios
DELIMITER //
CREATE PROCEDURE `SP_DeleteHorarios`(
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	DELETE FROM horarios_recoleccion WHERE id_puntoRecoleccion=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_DeletePuntosRecoleccion
DELIMITER //
CREATE PROCEDURE `SP_DeletePuntosRecoleccion`(
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	DELETE FROM puntos_recoleccion WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_DeleteRecoleccion
DELIMITER //
CREATE PROCEDURE `SP_DeleteRecoleccion`(
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	UPDATE recolecciones_usuarios SET status="Cancelada" WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_DeleteUsuario
DELIMITER //
CREATE PROCEDURE `SP_DeleteUsuario`(
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	DELETE FROM USUARIOS 
	WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_InsertRecoleccion
DELIMITER //
CREATE PROCEDURE `SP_InsertRecoleccion`(
	IN `v_tipo` VARCHAR(50),
	IN `v_dia` VARCHAR(50),
	IN `v_hora` VARCHAR(50),
	IN `v_cantidad` FLOAT,
	IN `v_status` VARCHAR(50),
	IN `v_id_punto` INT,
	IN `v_id_usuario` INT
)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO recolecciones_usuarios (tipo, dia, hora, cantidad, status, id_punto_recoleccion, id_usuario) 
	VALUES (v_tipo, v_dia, v_hora, v_cantidad, v_status, v_id_punto, v_id_usuario);
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_InsertUsuario
DELIMITER //
CREATE PROCEDURE `SP_InsertUsuario`(
	IN `v_nombre` VARCHAR(100),
	IN `v_correo` VARCHAR(50),
	IN `v_password` VARCHAR(50),
	IN `v_ubicacion` VARCHAR(50),
	IN `v_rol` VARCHAR(50)
)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO USUARIOS (nombre, correo, password, ubicacion, rol) 
	VALUES (v_nombre, v_correo, v_password, v_ubicacion, v_rol);
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Insert_Horarios_Recoleccion
DELIMITER //
CREATE PROCEDURE `SP_Insert_Horarios_Recoleccion`(
	IN `v_hora_inicio` VARCHAR(50),
	IN `v_hora_final` VARCHAR(50),
	IN `v_dia` VARCHAR(50),
	IN `v_id` INT
)
BEGIN
	INSERT INTO horarios_recoleccion (hora_inicio, hora_final, dia, id_puntoRecoleccion) 
	VALUES (v_hora_inicio, v_hora_final, v_dia, v_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Insert_Tipos_Reciclaje_Empresa
DELIMITER //
CREATE PROCEDURE `SP_Insert_Tipos_Reciclaje_Empresa`(
	IN `v_tipo` VARCHAR(50),
	IN `v_id` INT
)
BEGIN
	INSERT INTO tipos_reciclajes_empresas (tipo_reciclaje, id_empresa) 
	VALUES (v_tipo, v_id);
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Login
DELIMITER //
CREATE PROCEDURE `SP_Login`(
	IN `v_correo` VARCHAR(50),
	IN `v_password` VARCHAR(50)
)
    READS SQL DATA
BEGIN
	SELECT * FROM usuarios 
	WHERE correo=v_correo AND PASSWORD=v_password;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_SelectEmpresas
DELIMITER //
CREATE PROCEDURE `SP_SelectEmpresas`()
    READS SQL DATA
BEGIN
	SELECT * FROM empresas;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_SelectPuntosRecoleccion
DELIMITER //
CREATE PROCEDURE `SP_SelectPuntosRecoleccion`()
    READS SQL DATA
BEGIN
	SELECT * FROM puntos_recoleccion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_SelectRecoleccionesUsuario
DELIMITER //
CREATE PROCEDURE `SP_SelectRecoleccionesUsuario`(
	IN `v_id` INT
)
    READS SQL DATA
BEGIN
	SELECT recolecciones_usuarios.id, tipo, dia, hora, cantidad, status, puntos_recoleccion.nombre 
	FROM recolecciones_usuarios 
	INNER JOIN puntos_recoleccion 
	ON puntos_recoleccion.id = recolecciones_usuarios.id_punto_recoleccion 
	WHERE id_usuario=v_id 
	ORDER BY dia, hora;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_SelectUsuarios
DELIMITER //
CREATE PROCEDURE `SP_SelectUsuarios`()
    READS SQL DATA
BEGIN
	SELECT * FROM usuarios;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Select_Empresas_Recientes
DELIMITER //
CREATE PROCEDURE `SP_Select_Empresas_Recientes`()
    READS SQL DATA
BEGIN
	SELECT * FROM empresas ORDER BY id DESC LIMIT 10;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Select_Horarios_Puntos_Recoleccion
DELIMITER //
CREATE PROCEDURE `SP_Select_Horarios_Puntos_Recoleccion`()
    READS SQL DATA
BEGIN
	SELECT id_puntoRecoleccion, nombre, dia, hora_inicio, hora_final 
	FROM puntos_recoleccion 
	INNER JOIN horarios_recoleccion 
	ON puntos_recoleccion.id = horarios_recoleccion.id_puntoRecoleccion;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Select_Tipos_Reciclajes_Empresas
DELIMITER //
CREATE PROCEDURE `SP_Select_Tipos_Reciclajes_Empresas`()
    READS SQL DATA
BEGIN
	SELECT * FROM tipos_reciclajes_empresas;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_Select_Usuarios_Recientes
DELIMITER //
CREATE PROCEDURE `SP_Select_Usuarios_Recientes`()
    READS SQL DATA
BEGIN
	SELECT * FROM usuarios ORDER BY id DESC LIMIT 10;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_UpdateEmpresa
DELIMITER //
CREATE PROCEDURE `SP_UpdateEmpresa`(
	IN `v_nombre` VARCHAR(100),
	IN `v_ubicacion` VARCHAR(50),
	IN `v_correo` VARCHAR(50),
	IN `v_telefono` INT,
	IN `v_id` INT
)
BEGIN
	UPDATE empresas 
	SET nombre=v_nombre, ubicacion=v_ubicacion, correo=v_correo, telefono=v_telefono 
	WHERE id=v_id;
	
	DELETE FROM tipos_reciclajes_empresas 
	WHERE id_empresa=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_UpdatePuntoRecoleccion
DELIMITER //
CREATE PROCEDURE `SP_UpdatePuntoRecoleccion`(
	IN `v_nombre` VARCHAR(50),
	IN `v_ubicacion` VARCHAR(50),
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	UPDATE puntos_recoleccion 
	SET nombre=v_nombre, ubicacion=v_ubicacion 
	WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_UpdateRecoleccion
DELIMITER //
CREATE PROCEDURE `SP_UpdateRecoleccion`(
	IN `v_tipo` VARCHAR(50),
	IN `v_dia` VARCHAR(50),
	IN `v_hora` VARCHAR(50),
	IN `v_cantidad` FLOAT,
	IN `v_id_punto` INT,
	IN `v_id` INT
)
BEGIN
	UPDATE recolecciones_usuarios 
	SET tipo=v_tipo, dia=v_dia, hora=v_hora, cantidad=v_cantidad, id_punto_recoleccion=v_id_punto 
	WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento ecommunity.SP_UpdateUsuario
DELIMITER //
CREATE PROCEDURE `SP_UpdateUsuario`(
	IN `v_nombre` VARCHAR(100),
	IN `v_correo` VARCHAR(50),
	IN `v_password` VARCHAR(50),
	IN `v_ubicacion` VARCHAR(50),
	IN `v_rol` VARCHAR(50),
	IN `v_id` INT
)
    MODIFIES SQL DATA
BEGIN
	UPDATE USUARIOS 
	SET nombre=v_nombre, correo=v_correo, password=v_password, ubicacion=v_ubicacion, rol=v_rol 
	WHERE id=v_id;
END//
DELIMITER ;

-- Volcando estructura para función ecommunity.F_InsertEmpresa
DELIMITER //
CREATE FUNCTION `F_InsertEmpresa`(
	`v_nombre` VARCHAR(50),
	`v_ubicacion` VARCHAR(50),
	`v_correo` VARCHAR(50),
	`v_telefono` INT
) RETURNS int
    MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE v_id INT;
	#INSERT Empresa
	INSERT INTO empresas (nombre, ubicacion, correo, telefono) 
	VALUES (v_nombre, v_ubicacion, v_correo, v_telefono);
	
	#SELECT Id
	SELECT id INTO v_id
	FROM empresas 
	ORDER BY id DESC LIMIT 1;
	
	#RETURN Id
	RETURN v_id;
END//
DELIMITER ;

-- Volcando estructura para función ecommunity.F_InsertPuntoRecoleccion
DELIMITER //
CREATE FUNCTION `F_InsertPuntoRecoleccion`(
	`v_nombre` VARCHAR(100),
	`v_ubicacion` VARCHAR(50)
) RETURNS int
    MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE v_id INT;
	#INSERT Punto de Recolección
	INSERT INTO puntos_recoleccion (nombre, ubicacion) 
	VALUES (v_nombre, v_ubicacion);
	
	#SELECT Id
	SELECT id INTO v_id
	FROM puntos_recoleccion
	ORDER BY id DESC LIMIT 1;
	
	#RETURN Id
	RETURN v_id;
END//
DELIMITER ;

-- Volcando estructura para disparador ecommunity.TR_UpdateEmpresas
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `TR_UpdateEmpresas` AFTER UPDATE ON `empresas` FOR EACH ROW BEGIN
	INSERT INTO bitacora (tabla, id_registro_editado, accion)
	VALUES ('Empresas', NEW.id, 'Información Editada');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ecommunity.TR_UpdatePuntosRecoleccion
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `TR_UpdatePuntosRecoleccion` AFTER UPDATE ON `puntos_recoleccion` FOR EACH ROW BEGIN
	INSERT INTO bitacora (tabla, id_registro_editado, accion)
	VALUES ('Puntos_Recoleccion', NEW.id, 'Información Editada');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ecommunity.TR_UpdateUsuarios
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `TR_UpdateUsuarios` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora (tabla, id_registro_editado, accion)
	VALUES ('Usuarios', NEW.id, 'Información Editada');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
