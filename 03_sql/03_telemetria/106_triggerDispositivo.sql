use tgv_dev;


DROP TRIGGER IF EXISTS `trInsDispositivo`;
-- al grabar  un dispositivo nuevo , que copie las variables del tipo de dispositivo 
-- funcionan for each row
DELIMITER $$


CREATE TRIGGER trInsDispositivo
AFTER INSERT ON dispositivo
FOR EACH ROW
BEGIN
-- Instrucciones SQL

	insert dispositivovariable
    (`dispositivo`,`variable`,`abreviatura`,`escala01`, `escala02`,`minimo`,`max`,`redTop`,`yellowTop`,`yellowBottom`,`redBottom`) 
    select new.id,tdv.variable,'V',10,1,0,220,140,130,110,90    from tipoDispositivoVariable tdv where new.tipoDispositivo = tdv.tipoDispositivo ;
/*
select * from dispositivo;
select * from dispositivoVariable;

select * from dispositivo;
select * from tipodispositivovariable;
select * from tipodispositivo;
select * from variable;

select * from dispositivo ds, tipodispositivo td, tipodispositivovariable tdv,   variable va 
where  ds.tipoDispositivo = td.id   and tdv.tipoDispositivo = td.id and tdv.variable = va.id; 

select * from dispositivoVariable;
 */ 
END;$$

insert into dispositivo (`nombre`,`descripcion`,`sn`,`beetle`,`organizacion`,`owner`,`tipoDispositivo`,`lecturaTablaID` ,`lecturaTablaName` ,`Status`) 
    values      ('TOV electronica','TOV electronica','SN 1234567','btABCDEF',1,1,1,1,'binread004',1);
    
    
	select * from dispositivo;
    select * from dispositivoVariable;
    
    
    
    
    
    