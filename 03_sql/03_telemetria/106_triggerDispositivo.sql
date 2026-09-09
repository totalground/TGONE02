
#Compañia: Total Ground
#Rol:  responde como Arquitecto de software
#Accion:  documenta  trigger de mysql
#Formato:  documento de word 
#Antecedentes: 

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
    select new.id,tdv.variable,tdv.abreviatura,tdv.escala01, tdv.escala02,tdv.minimo,tdv.max,tdv.redTop,tdv.yellowTop,tdv.yellowBottom,tdv.redBottom  
       from tipoDispositivoVariable tdv where new.tipoDispositivo = tdv.tipoDispositivo ;
END;$$

insert into dispositivo (`nombre`,`descripcion`,`sn`,`beetle`,`organizacion`,`owner`,`tipoDispositivo`,`lecturaTablaID` ,`lecturaTablaName` ,`Status`) 
    values      ('TOV electronica','TOV electronica','SN 1234567','btABCDEF',1,1,1,1,'binread004',1);
    
    insert into dispositivo (`nombre`,`descripcion`,`sn`,`beetle`,`organizacion`,`owner`,`tipoDispositivo`,`lecturaTablaID` ,`lecturaTablaName` ,`Status`) 
    values      ('TOV electronica','TOV electronica','SN 7654321','btFEDCBA',1,1,2,2,'binread002',1);
    
    /*
	select * from dispositivo;
    select * from dispositivoVariable;
    
    */
    
    delete 
    
    
    
    