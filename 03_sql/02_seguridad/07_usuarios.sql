use tgv_dev;

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,

  `usuario` char(30)  default NULL,
  `nombre` char(30) default NULL,
  `psw` char(30) default NULL,
  `status` char(10) default NULL,
  `nivel` char(10)  default NULL,
  `telefono` char(30) default NULL,
  `email` char(30) default NULL,
  
  
	-- `contrasena` char(100) default NULL,
	-- `curp` char(30) default NULL,
  
  -- `Paterno` char(30) default NULL,
  -- `Materno` char(30) default NULL,
  -- `fechanacimiento` date DEFAULT NULL,
  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB ;


DROP TABLE IF EXISTS `grupo`;
CREATE TABLE `grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Nombre` char(50)not NULL,
  `Nivel` char(10) not NULL,
  PRIMARY KEY (`id`)
  ) ENGINE=InnoDB ;
  
  DROP TABLE IF EXISTS `usuariogrupo`;
CREATE TABLE `usuariogrupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` int NOT NULL,
  `grupo` int NOT NULL,
  PRIMARY KEY (`id`)
  ) ENGINE=InnoDB ;

