use tgv_dev;
select * from VWTOV452_66;


/* DROP VIEW IF EXISTS `VWTOV452_66`; */

CREATE VIEW VWTOV452_66 AS
select 
	Lectura as id,
    Lectura,
    TOV452_ID   ,
    rssi ,
     
	consecutivo ,
	eventoID ,
    
	idTrack  ,
    fecha, /* datetime, */
	track ,
    
    
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
    THD_V29  ,
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
    THD_VST3 ,
	-- 0xAC               Contine los valores distorsión de armónica THI T, sumatoria 1, 2. 3
    THD_IST1  ,
    THD_IST2 ,
    THD_IST3 ,

    /****************************************calculados*****************************/

        -- Voltaje.
 Fase1_volts ,	"V",
 Fase2_volts ,	"V",
 Fase3_volts ,	"V",
  -- Corriente
Fase1_amps ,	"amp",
Fase2_amps ,	"amp",
Fase3_amps , 	"amp",
 
-- Factor de potencia.
PF1_e ,
PF2_e ,
PF3_e ,

-- Frecuencia:
Frequency_e , 	 "Hz",

/****************************************************************Armonicos ***************************************/
-- 0xA3               Contine los valores distorsión de armónica THI 1, 3,5.
    -- THD_I13  integer,
    THD_I13_e,	"THD",
    -- THD_I15  integer,
    THD_I15_e,	"THD",
    
	-- 0xA4               Contine los valores distorsión de armónica THI 1, 7,9.
    -- THD_I17  integer,
    THD_I17_e,	"THD",
    -- THD_I19  integer,
    THD_I19_e,	"THD",
	-- 0xA5               Contine los valores distorsión de armónica THI 1, 11,13.
    -- THD_I111  integer,
    THD_I111_e,	"THD",
    -- THD_I113  integer,
    THD_I113_e,	"THD",
	-- 0xA6               Contine los valores distorsión de armónica THI 2, 3,5.
    -- THD_I23 integer,
    THD_I23_e,	"THD",
    -- THD_I25 integer,
    THD_I25_e,	"THD",

	-- 0xA7               Contine los valores distorsión de armónica THI 2, 7,9.
    -- THD_I27  integer,
    THD_I27_e,	"THD",
	-- THD_I29 integer,
    THD_I29_e,	"THD",
	-- 0xA8               Contine los valores distorsión de armónica THI 2, 11,13.
    -- THD_I211  integer, ***********************************************************
    THD_I211_e,	"THD",
    -- THD_I213  integer,
    THD_I213_e,	"THD",
	-- 0xA9               Contine los valores distorsión de armónica THI 3, 3,5.
    -- THD_I33  integer,
    THD_I33_e,	"THD",
    -- THD_I35  integer,
    THD_I35_e,	"THD",
	-- 0xAA               Contine los valores distorsión de armónica THI 3, 7,9.
    -- THD_I37  integer,
    THD_I37_e,	"THD",
    -- THD_I39  integer,
    THD_I39_e,	"THD",
	-- 0xAB               Contine los valores distorsión de armónica THI 3, 11,13.
    -- THD_I311  integer,
    THD_I311_e,	"THD",
    -- THD_I313  integer,
    THD_I313_e,	"THD",
	-- 0xAD               Contine los valores distorsión de armónica THV 1, 3,5.
    -- THD_V13  integer,
    THD_V13_e,	"THD",
    -- THD_V15  integer,
    THD_V15_e,	"THD",
	-- 0xAE               Contine los valores distorsión de armónica THV 1, 7,9.
    -- THD_V17  integer,
    THD_V17_e,	"THD",
    -- THD_V19  integer,
    THD_V19_e,	"THD",
	-- 0xAF               Contine los valores distorsión de armónica THV 1, 11,13.
    -- THD_V111  integer,
    THD_V111_e,	"THD",
    -- THD_V113  integer,
    THD_V113_e,	"THD",
	-- 0xB0               Contine los valores distorsión de armónica THV 2, 3,5.
    -- THD_V23  integer,
    THD_V23_e,	"THD",
    -- THD_V25  integer,
    THD_V25_e,	"THD",
	-- 0xB1               Contine los valores distorsión de armónica THV 2, 7,9.
    -- THD_V27  integer,
    THD_V27_e,	"THD",
    -- THD_V29  integer,
    THD_V29_e,	"THD",
	-- 0xB2               Contine los valores distorsión de armónica THV 2, 11,13.
    -- THD_V211  integer,
    THD_V211_e,	"THD",
    -- THD_V213  integer,
    THD_V213_e,	"THD",
	-- 0xB3               Contine los valores distorsión de armónica THV 3, 3,5.
    -- THD_V33  integer,
    THD_V33_e,	"THD",
    -- THD_V35  integer,
    THD_V35_e,	"THD",
	-- 0xB4               Contine los valores distorsión de armónica THV 3, 7,9.
    -- THD_V37  integer,
    THD_V37_e,	"THD",
    -- THD_V39  integer,
    THD_V39_e,	"THD",
	-- 0xB5               Contine los valores distorsión de armónica THV 3, 11,13.
    -- THD_V311  integer,
    THD_V311_e,	"THD",
    -- THD_V313 integer,
    THD_V313_e,	"THD",
	-- 0xB6               Contine los valores distorsión de armónica THV T, sumatoria 1, 2. 3
    -- THD_VST1  integer,
    THD_VST1_e,	"THD",
    -- THD_VST2  integer,
    THD_VST2_e,	"THD",
    -- THD_VST3 integer,
    THD_VST3_e,	"THD",
	-- 0xAC               Contine los valores distorsión de armónica THI T, sumatoria 1, 2. 3
    -- THD_IST1  integer,
    THD_IST1_e,	"THD",
    -- THD_IST2 integer,
    THD_IST2_e, "THD",
    -- THD_IST3 integer
    THD_IST3_e,	"THD",


--     Potencia Aparente. Unidad VA
-- Fase 1, Potencia aparente.
-- Fase1_volts * Fase1_amps as 'Fase1_VA',
Fase1_VA,	"VA",
-- Fase 2, Potencia aparente.
-- Fase2_volts * Fase2_amps as 'Fase2_VA', 
Fase2_VA, 	"VA",
-- Fase 3, Potencia aparente.
-- Fase3_volts * Fase3_amps as 'Fase3_VA'
Fase3_VA, 	"VA",

-- Potencia Real. Unidad W
-- Fase 1, Potencia Real.
Fase1_W, 	"VA",
-- Fase 2, Potencia Real.
Fase2_W, 	"VA", 
-- Fase 3, Potencia Real.
Fase3_W, 	"VA",

-- Potencia Reactiva. Unidad VAr
-- Fase 1, Potencia Reactiva.
Fase1_VAr, 	"VAr",
-- Fase 2, Potencia Reactiva.
Fase2_VAr, 	"VAr",
-- Fase 3, Potencia Reactiva.
Fase3_VAr, 	"VAr",

-- Potencia Aparente del Sistema o Potencia Aparente Total del Sistema
Fase_VA , 	"VA",
-- Potencia Real del Sistema o Potencia Real Total del Sistema
Fase_W , 	"W",
-- Potencia Reactiva del Sistema o Potencia Reactiva Total del Sistema
Fase_VAr, 	"VAr",
-- Factor de Potencia del Sistema o Factor de Potencia Total del Sistema
PF_e
    
from  `TOV452_66`;

select * from VWTOV452_66
 where idtrack =  925 and
		fecha >= "2026-08-03 11:00:00"
order by fecha desc;

select * from usuario
