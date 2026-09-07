use tgv_qa;

SET FOREIGN_KEY_CHECKS=0;

-- Arbol
-- Nivel ? 
	-- Arbol, Nivel, Nombre
-- Nodo
	-- Arbol , Nombre, Dispositivo , [ tabla (Operativo), campo (Operativo),    or     Variable ]   

-- Variable

-- TipoDispositivoVariable
-- DispositivoVariable

-- ----------------------------
-- Table structure for variable
-- ----------------------------
DROP TABLE IF EXISTS `variable`;
CREATE TABLE `variable` (
	id INT AUTO_INCREMENT PRIMARY KEY,
  `Nombre` char(30)  NOT NULL,
  `Descripcion` char(255)  DEFAULT NULL,
  `Abreviatura` char(10)  DEFAULT NULL
) ENGINE=InnoDB ;

select * from variable;


/*
{
  "servidor": "localhost",
  "base_de_datos": "tgv_qa",
  "usuario": "root",
  "password": "root",
    "action": "post",
  "token":"Tg#10982278ia123",

  "tabla": "variable",

  "condiciones": {"id":1,"nombre":"21","descripcion": "21","Abreviatura":"x"},

  "limite": 100,
  "offset": 0,

  "displayfields":["id","Nombre","descripcion","Abreviatura"],

  "campos": { 
    "Nombre": "21",
    "Descripcion": "21",
    "Abreviatura":"x"
    }
}

*/

-- ----------------------------
-- Table structure for tipodispositivo
-- ----------------------------
DROP TABLE IF EXISTS `tipodispositivo`;
CREATE TABLE `tipodispositivo` (
	id INT AUTO_INCREMENT PRIMARY KEY,
	`Nombre` char(30)  default NULL,
	`Descripcion` char(255) default NULL
) ENGINE=InnoDB ;

select * from tipodispositivo;

/*
{
  "servidor": "localhost",
  "base_de_datos": "tgv_qa",
  "usuario": "root",
  "password": "root",
    "action": "post",
  "token":"Tg#10982278ia123",

  "tabla": "tipodispositivo",

  "condiciones": {"id":1,"nombre":"21","descripcion": "21"},

  "limite": 100,
  "offset": 0,

  "displayfields":["id","Nombre","descripcion"],

  "campos": { 
    "Nombre": "21",
    "Descripcion": "21"
    }
}

*/
DROP TABLE IF EXISTS `tipodispositivovariable`;
CREATE TABLE `tipodispositivovariable` (
	id INT AUTO_INCREMENT PRIMARY KEY,
	`TipoDispositivo` INT NOT NULL,
	`Variable` INT NOT NULL
    -- min, max, yellow_01, yellow_02, red_01, red_02
) ENGINE=InnoDB ;
/*

{
  "servidor": "localhost",
  "base_de_datos": "tgv_qa",
  "usuario": "root",
  "password": "root",
    "action": "post",
  "token":"Tg#10982278ia123",

  "tabla": "tipodispositivovariable",

 "condiciones": { "id": 2,
            "tipoDispositivo": 1,
            "Variable": 1},
"displayfields": [ "id",
            "tipoDispositivo",
            "Variable"],
  "limite": 100,
  "offset": 0,

  "campos": { 
    
	"tipoDispositivo":"1",
	"Variable":"1"
    }
}


*/
-- FK del tipodispositivovariable apunta a tipodispositivo y a tipovariable 
ALTER TABLE tipodispositivovariable
ADD CONSTRAINT fk_tipodispositivovariable_tipodispositivo
FOREIGN KEY (TipoDispositivo) 
REFERENCES TipoDispositivo(id)
ON DELETE RESTRICT;

ALTER TABLE tipodispositivovariable
ADD CONSTRAINT fk_tipodispositivovariable_variable
FOREIGN KEY (variable) 
REFERENCES variable(id)
ON DELETE RESTRICT;

-- ----------------------------
-- Table structure for dispositivo
-- ----------------------------
DROP TABLE IF EXISTS `dispositivo`;

CREATE TABLE `dispositivo` (
	id INT AUTO_INCREMENT PRIMARY KEY,
	`Nombre` char(30)  not NULL,
	`Descripcion` char(255) default NULL,
    
    `Organizacion` INT default NULL,
	`Owner` INT default NULL,
	`TipoDispositivo` INT default NULL,
    
	`LecturaTablaID` INT default NULL,
	`LecturaTablaNAme` char(30) default NULL,		-- Redundante para hacer mas rapido  
    
    `Status` char(10) default NULL
    
) ENGINE=InnoDB ;

/*

{
  "servidor": "localhost",
  "base_de_datos": "tgv_qa",
  "usuario": "root",
  "password": "root",
    "action": "get",
  "token":"Tg#10982278ia123",

  "tabla": "dispositivo",

  "condiciones": {"id":1,"nombre":"21","descripcion": "21"},

  "limite": 100,
  "offset": 0,

  "displayfields":["id","Nombre","descripcion"],

  "campos": { 
    "Nombre": "21",
    "Descripcion": "21",
    "Organizacion": "21",
	"Owner": "21",
	"TipoDispositivo": "21",
    
	"LecturaTablaID": "21",
	"LecturaTablaNAme": "21",
    
    "Status": "21"
    }
}
*/

-- ----------------------------
-- Table structure for dispositivovariable
-- ----------------------------

DROP TABLE IF EXISTS `dispositivovariable`;
CREATE TABLE `dispositivovariable` (
	id INT AUTO_INCREMENT PRIMARY KEY,
	`Dispositivo` INT NOT NULL,
	`Variable` INT NOT NULL,
	`Abreviatura` char(10)  DEFAULT NULL,
    `minimo` decimal(11,2) default NULL,
    `max` decimal(11,2) default NULL,
    `yellow_01` decimal(11,2) default NULL,
    `yellow_02` decimal(11,2) default NULL,
    `red_01` decimal(11,2) default NULL,
    `red_02` decimal(11,2) default NULL

) ENGINE=InnoDB ;

/*
{
  "servidor": "localhost",
  "base_de_datos": "tgv_qa",
  "usuario": "root",
  "password": "root",
    "action": "get",
  "token":"Tg#10982278ia123",

  "tabla": "dispositivovariable",

 "condiciones": { "id": 2,
            "Dispositivo": 1,
            "Variable": 1},
"displayfields": [ "id",
            "Dispositivo",
            "Variable"],
  "limite": 100,
  "offset": 0,



  "campos": { 
    
	"Dispositivo":"1",
	"Variable":"1",
	"Abreviatura":"21",
    "minimo":"21",
    "max":"21",
    "yellow_01":"21",
    "yellow_02":"21",
    "red_01":"21",
    "red_02":"21"

    }
}
*/



-- FK del tipodispositivovariable apunta a tipodispositivo y a tipovariable 
ALTER TABLE dispositivovariable
ADD CONSTRAINT fk_dispositivovariable_dispositivo
FOREIGN KEY (Dispositivo) 
REFERENCES Dispositivo(id)
ON DELETE RESTRICT;

-- ----------------------------
-- Table structure for lectura
-- ----------------------------
/*
DROP TABLE IF EXISTS `lectura`;
CREATE TABLE `lectura` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `Fecha` datetime NOT NULL,
  `Dispositivo` char(11) NOT NULL default '0',
  `DT01` float default NULL,
  `DT02` decimal(18,4) default NULL,
  `DT03` int(11) default NULL,
  `DT04` float default NULL,
  `DT05` decimal(18,4) default NULL,
  `Cadena` text
) ENGINE=InnoDB ;
*/
