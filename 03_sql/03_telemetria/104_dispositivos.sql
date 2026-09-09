use tgv_dev;

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
  `nombre` char(30)  NOT NULL,
  `descripcion` char(255)  DEFAULT NULL,
  `abreviatura` char(10)  DEFAULT NULL
) ENGINE=InnoDB ;

select * from variable;

insert into variable (nombre,descripcion , abreviatura) values ('Voltaje','Voltaje','V');
insert into variable (nombre,descripcion , abreviatura) values ('Frecuencia','Frecuencia','Hz');

insert into variable (nombre,descripcion , abreviatura) values ('Descargas','Ground Fault Detection','GFD');


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
	`nombre` char(30)  default NULL,
	`descripcion` char(255) default NULL
) ENGINE=InnoDB ;

insert into tipodispositivo (nombre,descripcion ) values ('TOV  a 2','TOV reducido a 2');
insert into tipodispositivo (nombre,descripcion ) values ('C Descargas','Contador de decargas');


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
	`tipoDispositivo` INT NOT NULL,
	`variable` INT NOT NULL,
    `orden` INT NOT NULL,
    
    	`abreviatura` char(10)  DEFAULT NULL,
        
	`escala01` decimal(11,2) default NULL,
    `escala02` decimal(11,2) default NULL,
    
    `minimo` decimal(11,2) default NULL,
    `max` decimal(11,2) default NULL,
    
    `redTop` decimal(11,2) default NULL,
    `yellowTop` decimal(11,2) default NULL,
    `yellowBottom` decimal(11,2) default NULL,
    `redBottom` decimal(11,2) default NULL

) ENGINE=InnoDB ;

/*
select * from tipoDispositivo;
Select * from variable;
*/

insert into tipodispositivovariable (tipoDispositivo,variable,orden,abreviatura,escala01,escala02,minimo,max,redTop,yellowTop,yellowBottom,redBottom) 
values (1,1,1,'v' ,5,20,0,150,130,115,110,100);

insert into tipodispositivovariable (tipoDispositivo,variable,orden,abreviatura,escala01,escala02,minimo,max,redTop,yellowTop,yellowBottom,redBottom) 
values (1,2,2,'Hz' ,5,20,0,90,80,170,50,40);

insert into tipodispositivovariable (tipoDispositivo,variable,orden,abreviatura,escala01,escala02,minimo,max,redTop,yellowTop,yellowBottom,redBottom) 
values (2,3,1,'GFD' ,1,5,0,15,5,4,2,1);

select * from tipodispositivovariable;
select * from variable;

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
	`nombre` char(30)  not NULL,
	`descripcion` char(255) default NULL,
    
    `sn` char(30)  not NULL,
    `beetle` char(30)  not NULL,
    `organizacion` INT default NULL,
	`owner` INT default NULL,
	`tipoDispositivo` INT default NULL,
    
	`lecturaTablaID` INT default NULL,
	`lecturaTablaName` char(30) default NULL,		-- Redundante para hacer mas rapido  
    
    `Status` char(10) default NULL
    
) ENGINE=InnoDB ;

select * from dispositivo;

insert into dispositivo (`nombre`,`descripcion`,`sn`,`beetle`,`organizacion`,`owner`,`tipoDispositivo`,`lecturaTablaID` ,`lecturaTablaName` ,`Status`) 
    values      ('TOV electronica','TOV electronica','SN 1234567','btABCDEF',1,1,1,1,'binread004',1);
    
-- update dispositivo set lecturaTablaName = 'binread004'  ;  
    
select * from dispositivo;
select * from tipodispositivovariable;
select * from tipodispositivo;
select * from variable;

select * from dispositivo ds, tipodispositivo td, tipodispositivovariable tdv,   variable va 
where  ds.tipoDispositivo = td.id   and tdv.tipoDispositivo = td.id and tdv.variable = va.id; 



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

ALTER TABLE dispositivo
ADD CONSTRAINT fk_dispositivo_tipodispositivo
FOREIGN KEY (tipoDispositivo) 
REFERENCES tipoDispositivo(id)
ON DELETE RESTRICT;


-- ----------------------------
-- Table structure for dispositivovariable
-- ----------------------------

DROP TABLE IF EXISTS `dispositivovariable`;
CREATE TABLE `dispositivovariable` (
	id INT AUTO_INCREMENT PRIMARY KEY,
	`dispositivo` INT NOT NULL,
	`variable` INT NOT NULL,
	`abreviatura` char(10)  DEFAULT NULL,
    
    `escala01` decimal(11,2) default NULL,
    `escala02` decimal(11,2) default NULL,
    
    `minimo` decimal(11,2) default NULL,
    `max` decimal(11,2) default NULL,
    
    `redTop` decimal(11,2) default NULL,
    `yellowTop` decimal(11,2) default NULL,
    `yellowBottom` decimal(11,2) default NULL,
    `redBottom` decimal(11,2) default NULL

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
