--drop PROCEDURE TOV452_END

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TOV452_END`(IN id_val INT)
BEGIN 

set @x= null; 

START TRANSACTION; 
INSERT INTO TOV452_66 SELECT @x, 

TOV452_ID ,
    rssi ,
    
	consecutivo ,
	eventoID ,
    
	idTrack ,-- PRIMARY KEY,
    now(), -- fecha datetime,
	track text,
    
    
	/*0x0 Contine el valor de frecuencia.*/
    Frequency  , 
    
    /*0x3 Contine los valores de Corriente de las 3 fases.*/
    IFase1 ,
    IFase2 ,
    IFase3 ,

    /*0x6 Contine los valores de Voltaje de las 3 fases*/
    VFase1 ,
    VFase2 ,
    VFase3 ,
    
    /*0x19 Contine los valores de Factor de potencia de las 3 fases*/
    PF1 ,
    PF2 ,
    PF3 ,
    
    /*0xA0 Contine los valores de la relación de transformación Tp.*/
	TP1 ,
    TP2 ,
    /*0xA1               Contine los valores de la relación de transformación Tc.*/
    TC1 ,
    TC2 ,
	-- 0xA2               Contine el valor de consumo de kWh.
	kWh  ,
	-- 0xA3               Contine los valores distorsión de armónica THI 1, 3,5.
    THD_I13  ,
    THD_I15  ,
	-- 0xA4               Contine los valores distorsión de armónica THI 1, 7,9.
    THD_I17  ,
    THD_I19  ,
	-- 0xA5               Contine los valores distorsión de armónica THI 1, 11,13.
    THD_I111  ,
    THD_I113  ,
	-- 0xA6               Contine los valores distorsión de armónica THI 2, 3,5.
    THD_I23 ,
    THD_I25 ,

	-- 0xA7               Contine los valores distorsión de armónica THI 2, 7,9.
    THD_I27  ,
	THD_I29 ,
	-- 0xA8               Contine los valores distorsión de armónica THI 2, 11,13.
    THD_I211  ,
    THD_I213  ,
	-- 0xA9               Contine los valores distorsión de armónica THI 3, 3,5.
    THD_I33  ,
    THD_I35  ,
	-- 0xAA               Contine los valores distorsión de armónica THI 3, 7,9.
    THD_I37  ,
    THD_I39  ,
	-- 0xAB               Contine los valores distorsión de armónica THI 3, 11,13.
    THD_I311  ,
    THD_I313  ,
	-- 0xAD               Contine los valores distorsión de armónica THV 1, 3,5.
    THD_V13  ,
    THD_V15  ,
	-- 0xAE               Contine los valores distorsión de armónica THV 1, 7,9.
    THD_V17  ,
    THD_V19  ,
	-- 0xAF               Contine los valores distorsión de armónica THV 1, 11,13.
    THD_V111  ,
    THD_V113  ,
	-- 0xB0               Contine los valores distorsión de armónica THV 2, 3,5.
    THD_V23  ,
    THD_V25  ,
	-- 0xB1               Contine los valores distorsión de armónica THV 2, 7,9.
    THD_V27  ,
    THD_V28  ,
	-- 0xB2               Contine los valores distorsión de armónica THV 2, 11,13.
    THD_V211  ,
    THD_V213  ,
	-- 0xB3               Contine los valores distorsión de armónica THV 3, 3,5.
    THD_V33  ,
    THD_V35  ,
	-- 0xB4               Contine los valores distorsión de armónica THV 3, 7,9.
    THD_V37  ,
    THD_V39  ,
	-- 0xB5               Contine los valores distorsión de armónica THV 3, 11,13.
    THD_V311  ,
    THD_V313 ,
	-- 0xB6               Contine los valores distorsión de armónica THV T, sumatoria 1, 2. 3
    THD_VST1  ,
    THD_VST2  ,
    THD_VST13 ,
	-- 0xAC               Contine los valores distorsión de armónica THI T, sumatoria 1, 2. 3
    THD_IST1  ,
    THD_IST2 ,
    THD_IST13
 FROM TOV452
 where idtrack = id_val; 
 
 delete from  TOV452_66 where  idtrack = id_val;
 
 COMMIT; -- O ROLLBACK; para deshacer
 
END$$
DELIMITER ;
