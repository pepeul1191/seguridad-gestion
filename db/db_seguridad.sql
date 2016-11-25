-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 25-11-2016 a las 10:30:54
-- Versión del servidor: 5.7.16-0ubuntu0.16.04.1
-- Versión de PHP: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_seguridad`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activos`
--

CREATE TABLE `activos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `capa_id` int(11) NOT NULL,
  `ubicacion_id` int(11) NOT NULL,
  `tipo_activo_id` int(11) NOT NULL,
  `agente_id` int(11) NOT NULL,
  `criticidad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activos_amenazas`
--

CREATE TABLE `activos_amenazas` (
  `id` int(11) NOT NULL,
  `activo_id` int(11) NOT NULL,
  `amenaza_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activos_controles`
--

CREATE TABLE `activos_controles` (
  `id` int(11) NOT NULL,
  `activo_id` int(11) NOT NULL,
  `control_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activos_riesgos`
--

CREATE TABLE `activos_riesgos` (
  `id` int(11) NOT NULL,
  `activo_id` int(11) NOT NULL,
  `riesgo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activos_vulnerabilidades`
--

CREATE TABLE `activos_vulnerabilidades` (
  `id` int(11) NOT NULL,
  `activo_id` int(11) NOT NULL,
  `vulnerabilidad_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `activos`
--
ALTER TABLE `activos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `capa_id` (`capa_id`),
  ADD KEY `ubicacion_id` (`ubicacion_id`),
  ADD KEY `tipo_activo_id` (`tipo_activo_id`),
  ADD KEY `agente_id` (`agente_id`),
  ADD KEY `criticidad_id` (`criticidad_id`);

--
-- Indices de la tabla `activos_amenazas`
--
ALTER TABLE `activos_amenazas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `activos_controles`
--
ALTER TABLE `activos_controles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `activos_riesgos`
--
ALTER TABLE `activos_riesgos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `activos_vulnerabilidades`
--
ALTER TABLE `activos_vulnerabilidades`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `activos`
--
ALTER TABLE `activos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `activos_amenazas`
--
ALTER TABLE `activos_amenazas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `activos_controles`
--
ALTER TABLE `activos_controles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `activos_riesgos`
--
ALTER TABLE `activos_riesgos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `activos_vulnerabilidades`
--
ALTER TABLE `activos_vulnerabilidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `activos`
--
ALTER TABLE `activos`
  ADD CONSTRAINT `activos_ibfk_1` FOREIGN KEY (`capa_id`) REFERENCES `capas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activos_ibfk_2` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activos_ibfk_3` FOREIGN KEY (`tipo_activo_id`) REFERENCES `tipo_activos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activos_ibfk_4` FOREIGN KEY (`agente_id`) REFERENCES `agentes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activos_ibfk_5` FOREIGN KEY (`criticidad_id`) REFERENCES `criticidades` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
