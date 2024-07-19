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
CREATE DATABASE IF NOT EXISTS `ecommunity` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommunity`;

-- Volcando estructura para tabla ecommunity.empresas
CREATE TABLE IF NOT EXISTS `empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '',
  `ubicacion` varchar(50) NOT NULL DEFAULT '0',
  `correo` varchar(50) NOT NULL DEFAULT '0',
  `telefono` int NOT NULL DEFAULT '0',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.empresas: ~8 rows (aproximadamente)
INSERT INTO `empresas` (`id`, `nombre`, `ubicacion`, `correo`, `telefono`, `fecha_creacion`) VALUES
	(8, 'Empresa A', 'Ubicación A', 'contacto@empresaa.com', 1234567890, '2024-01-01 06:00:00'),
	(9, 'Empresa B', 'Ubicación B', 'contacto@empresab.com', 1234567891, '2024-01-02 06:00:00'),
	(10, 'Empresa C', 'Ubicación C', 'contacto@empresac.com', 1234567892, '2024-01-03 06:00:00'),
	(11, 'Empresa D', 'Ubicación D', 'contacto@empresad.com', 1234567893, '2024-01-04 06:00:00'),
	(12, 'Empresa E', 'Ubicación E', 'contacto@empresaE.com', 1234567894, '2024-01-05 06:00:00'),
	(13, 'Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-18 00:37:17'),
	(21, 'Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-18 01:03:54'),
	(22, 'Prueba', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-18 01:33:56'),
	(23, 'Prueba3', 'Queretaro', 'empresa@prueba.com', 1234567890, '2024-07-19 00:34:59');

-- Volcando estructura para tabla ecommunity.horarios_recoleccion
CREATE TABLE IF NOT EXISTS `horarios_recoleccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hora_inicio` varchar(50) NOT NULL,
  `hora_final` varchar(50) NOT NULL,
  `dia` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_puntoRecoleccion` int NOT NULL,
  `horario_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `horariosPunto` (`id_puntoRecoleccion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.horarios_recoleccion: ~5 rows (aproximadamente)
INSERT INTO `horarios_recoleccion` (`id`, `hora_inicio`, `hora_final`, `dia`, `id_puntoRecoleccion`, `horario_creacion`) VALUES
	(4, '08:00:00', '10:00:00', 'Lunes', 9, '2024-07-16 17:40:18'),
	(5, '09:00:00', '11:00:00', 'Martes', 9, '2024-07-16 17:40:18'),
	(6, '10:00:00', '12:00:00', 'Miércoles', 10, '2024-07-16 17:40:18'),
	(7, '11:00:00', '13:00:00', 'Jueves', 11, '2024-07-16 17:40:18'),
	(8, '12:00:00', '14:00:00', 'Viernes', 12, '2024-07-16 17:40:18');

-- Volcando estructura para tabla ecommunity.puntos_recoleccion
CREATE TABLE IF NOT EXISTS `puntos_recoleccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `ubicacion` varchar(50) NOT NULL DEFAULT '',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.puntos_recoleccion: ~5 rows (aproximadamente)
INSERT INTO `puntos_recoleccion` (`id`, `nombre`, `ubicacion`, `fecha_creacion`) VALUES
	(9, 'Punto A', 'Ubicación A', '2024-07-16 17:35:51'),
	(10, 'Punto B', 'Ubicación B', '2024-07-16 17:35:51'),
	(11, 'Punto C', 'Ubicación C', '2024-07-16 17:35:51'),
	(12, 'Punto D', 'Ubicación D', '2024-07-16 17:35:51'),
	(13, 'Punto E', 'Ubicación E', '2024-07-16 17:35:51');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.puntos_recoleccion_empresa: ~5 rows (aproximadamente)
INSERT INTO `puntos_recoleccion_empresa` (`id`, `id_empresa`, `id_punto_recoleccion`) VALUES
	(6, 8, 9),
	(7, 8, 9),
	(8, 10, 10),
	(9, 11, 11),
	(10, 12, 12);

-- Volcando estructura para tabla ecommunity.recolecciones_usuarios
CREATE TABLE IF NOT EXISTS `recolecciones_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `dia` varchar(50) NOT NULL,
  `hora` varchar(50) NOT NULL,
  `cantidad` float NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '"Pendiente"',
  `punto_recoleccion` varchar(50) NOT NULL DEFAULT '',
  `id_punto_recoleccion` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recoleccion_puntoRecoleccion` (`id_punto_recoleccion`),
  KEY `recoleccion_usuario` (`id_usuario`),
  CONSTRAINT `recoleccion_puntoRecoleccion` FOREIGN KEY (`id_punto_recoleccion`) REFERENCES `puntos_recoleccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recoleccion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.recolecciones_usuarios: ~6 rows (aproximadamente)
INSERT INTO `recolecciones_usuarios` (`id`, `tipo`, `dia`, `hora`, `cantidad`, `status`, `punto_recoleccion`, `id_punto_recoleccion`, `id_usuario`) VALUES
	(1, 'Vidrio', '2024-07-09', '09:00', 12, 'Pendiente', 'Jesses', NULL, NULL),
	(3, 'Vidrio', '2024-07-09', '08:00', 10, 'Completado', '', 9, 1),
	(4, 'Plastico', '2024-07-09', '09:00', 20, 'Completado', '', 10, 1),
	(5, 'Metal', '2024-07-09', '10:00', 30, 'Completado', '', 10, 5),
	(6, 'Vidrio', '2024-07-09', '11:00', 40, 'Completado', '', 11, 6),
	(7, 'Madera', '2024-07-09', '12:00', 50, 'Completado', '', 12, 6);

-- Volcando estructura para tabla ecommunity.tipos_reciclajes_empresas
CREATE TABLE IF NOT EXISTS `tipos_reciclajes_empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_reciclaje` varchar(50) NOT NULL DEFAULT '0',
  `id_empresa` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `empresa_reciclaje` (`id_empresa`),
  CONSTRAINT `empresa_reciclaje` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.tipos_reciclajes_empresas: ~19 rows (aproximadamente)
INSERT INTO `tipos_reciclajes_empresas` (`id`, `tipo_reciclaje`, `id_empresa`) VALUES
	(1, 'Plástico', 8),
	(2, 'Papel', 8),
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
	(39, 'Vidrio', 23);

-- Volcando estructura para tabla ecommunity.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `correo` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `ubicacion` varchar(50) NOT NULL DEFAULT '0',
  `rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla ecommunity.usuarios: ~8 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `password`, `ubicacion`, `rol`, `fecha_creacion`) VALUES
	(1, 'Sebastián Ramírez García', 'sebas@correos.com', 'password123', 'Queretaro', 'Administrador', '2024-07-05 17:35:04'),
	(5, 'Emiliano Alexander Pérez San Luis', 'emi@correo.com', 'emiliano123', 'Queretaro', 'Usuario', '2024-07-05 21:22:40'),
	(6, 'Andrea Alicia Medina Everardo', 'andrea@gmail.com', 'andy12345', 'Queretaro', 'Administrador', '2024-07-05 21:29:54'),
	(9, 'Usuario A', 'usuarioa@example.com', 'password1', 'Queretaro', 'Administrador', '2024-07-16 23:37:00'),
	(10, 'Usuario B', 'usuariob@example.com', 'password2', 'Queretaro', 'Usuario', '2024-07-16 23:37:00'),
	(11, 'Usuario C', 'usuarioc@example.com', 'password3', 'Queretaro', 'Usuario', '2024-07-16 23:37:00'),
	(12, 'Usuario D', 'usuariod@example.com', 'password4', 'Queretaro', 'Usuario', '2024-07-16 23:37:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
