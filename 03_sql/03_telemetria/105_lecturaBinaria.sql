use tgv_dev;


select * from  `binRead001`;
select * from  `binRead002`;
select * from  `binRead004`;
select * from  `binRead008`;
select * from  `binRead016`;
select * from  `binRead032`;
select * from  `binRead064`;
select * from  `binRead128`;
select * from  `binRead256`;


-- ----------------------------
-- Table structure for binRead002

/*

CREATE TABLE `binRead001` (
CREATE TABLE `binRead002` (
CREATE TABLE `binRead004` (
CREATE TABLE `binRead008` (
CREATE TABLE `binRead016` (
CREATE TABLE `binRead032` (
CREATE TABLE `binRead064` (
CREATE TABLE `binRead128` (
CREATE TABLE `binRead256` (

  PRIMARY KEY (`Lectura`)
) ENGINE=InnoDB;

*/
-- ----------------------------
DROP TABLE IF EXISTS `binRead256`;

CREATE TABLE `binRead256` (
  `lectura` int NOT NULL AUTO_INCREMENT,
  `dispositivo` int DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  
 `val001` int DEFAULT NULL,	-- 	0
 `val002` int DEFAULT NULL,	-- 	1
 `val003` int DEFAULT NULL,	-- 	
 `val004` int DEFAULT NULL,	-- 	2
 `val005` int DEFAULT NULL,	-- 	
 `val006` int DEFAULT NULL,	-- 	
 `val007` int DEFAULT NULL,	-- 	
 `val008` int DEFAULT NULL,	-- 	3
 `val009` int DEFAULT NULL,	-- 	
 `val010` int DEFAULT NULL,	-- 	
 `val011` int DEFAULT NULL,	-- 	
 `val012` int DEFAULT NULL,	-- 	
 `val013` int DEFAULT NULL,	-- 	
 `val014` int DEFAULT NULL,	-- 	
 `val015` int DEFAULT NULL,	-- 	
 `val016` int DEFAULT NULL,	-- 	4
 `val017` int DEFAULT NULL,	-- 	
 `val018` int DEFAULT NULL,	-- 	
 `val019` int DEFAULT NULL,	-- 	
 `val020` int DEFAULT NULL,	-- 	
 `val021` int DEFAULT NULL,	-- 	
 `val022` int DEFAULT NULL,	-- 	
 `val023` int DEFAULT NULL,	-- 	
 `val024` int DEFAULT NULL,	-- 	
 `val025` int DEFAULT NULL,	-- 	
 `val026` int DEFAULT NULL,	-- 	
 `val027` int DEFAULT NULL,	-- 	
 `val028` int DEFAULT NULL,	-- 	
 `val029` int DEFAULT NULL,	-- 	
 `val030` int DEFAULT NULL,	-- 	
 `val031` int DEFAULT NULL,	-- 	
 `val032` int DEFAULT NULL,	-- 	5
 `val033` int DEFAULT NULL,	-- 	
 `val034` int DEFAULT NULL,	-- 	
 `val035` int DEFAULT NULL,	-- 	
 `val036` int DEFAULT NULL,	-- 	
 `val037` int DEFAULT NULL,	-- 	
 `val038` int DEFAULT NULL,	-- 	
 `val039` int DEFAULT NULL,	-- 	
 `val040` int DEFAULT NULL,	-- 	
 `val041` int DEFAULT NULL,	-- 	
 `val042` int DEFAULT NULL,	-- 	
 `val043` int DEFAULT NULL,	-- 	
 `val044` int DEFAULT NULL,	-- 	
 `val045` int DEFAULT NULL,	-- 	
 `val046` int DEFAULT NULL,	-- 	
 `val047` int DEFAULT NULL,	-- 	
 `val048` int DEFAULT NULL,	-- 	
 `val049` int DEFAULT NULL,	-- 	
 `val050` int DEFAULT NULL,	-- 	
 `val051` int DEFAULT NULL,	-- 	
 `val052` int DEFAULT NULL,	-- 	
 `val053` int DEFAULT NULL,	-- 	
 `val054` int DEFAULT NULL,	-- 	
 `val055` int DEFAULT NULL,	-- 	
 `val056` int DEFAULT NULL,	-- 	
 `val057` int DEFAULT NULL,	-- 	
 `val058` int DEFAULT NULL,	-- 	
 `val059` int DEFAULT NULL,	-- 	
 `val060` int DEFAULT NULL,	-- 	
 `val061` int DEFAULT NULL,	-- 	
 `val062` int DEFAULT NULL,	-- 	
 `val063` int DEFAULT NULL,	-- 	
 `val064` int DEFAULT NULL,	-- 	6
 `val065` int DEFAULT NULL,	-- 	
 `val066` int DEFAULT NULL,	-- 	
 `val067` int DEFAULT NULL,	-- 	
 `val068` int DEFAULT NULL,	-- 	
 `val069` int DEFAULT NULL,	-- 	
 `val070` int DEFAULT NULL,	-- 	
 `val071` int DEFAULT NULL,	-- 	
 `val072` int DEFAULT NULL,	-- 	
 `val073` int DEFAULT NULL,	-- 	
 `val074` int DEFAULT NULL,	-- 	
 `val075` int DEFAULT NULL,	-- 	
 `val076` int DEFAULT NULL,	-- 	
 `val077` int DEFAULT NULL,	-- 	
 `val078` int DEFAULT NULL,	-- 	
 `val079` int DEFAULT NULL,	-- 	
 `val080` int DEFAULT NULL,	-- 	
 `val081` int DEFAULT NULL,	-- 	
 `val082` int DEFAULT NULL,	-- 	
 `val083` int DEFAULT NULL,	-- 	
 `val084` int DEFAULT NULL,	-- 	
 `val085` int DEFAULT NULL,	-- 	
 `val086` int DEFAULT NULL,	-- 	
 `val087` int DEFAULT NULL,	-- 	
 `val088` int DEFAULT NULL,	-- 	
 `val089` int DEFAULT NULL,	-- 	
 `val090` int DEFAULT NULL,	-- 	
 `val091` int DEFAULT NULL,	-- 	
 `val092` int DEFAULT NULL,	-- 	
 `val093` int DEFAULT NULL,	-- 	
 `val094` int DEFAULT NULL,	-- 	
 `val095` int DEFAULT NULL,	-- 	
 `val096` int DEFAULT NULL,	-- 	
 `val097` int DEFAULT NULL,	-- 	
 `val098` int DEFAULT NULL,	-- 	
 `val099` int DEFAULT NULL,	-- 	
 `val100` int DEFAULT NULL,	-- 	
 `val101` int DEFAULT NULL,	-- 	
 `val102` int DEFAULT NULL,	-- 	
 `val103` int DEFAULT NULL,	-- 	
 `val104` int DEFAULT NULL,	-- 	
 `val105` int DEFAULT NULL,	-- 	
 `val106` int DEFAULT NULL,	-- 	
 `val107` int DEFAULT NULL,	-- 	
 `val108` int DEFAULT NULL,	-- 	
 `val109` int DEFAULT NULL,	-- 	
 `val110` int DEFAULT NULL,	-- 	
 `val111` int DEFAULT NULL,	-- 	
 `val112` int DEFAULT NULL,	-- 	
 `val113` int DEFAULT NULL,	-- 	
 `val114` int DEFAULT NULL,	-- 	
 `val115` int DEFAULT NULL,	-- 	
 `val116` int DEFAULT NULL,	-- 	
 `val117` int DEFAULT NULL,	-- 	
 `val118` int DEFAULT NULL,	-- 	
 `val119` int DEFAULT NULL,	-- 	
 `val120` int DEFAULT NULL,	-- 	
 `val121` int DEFAULT NULL,	-- 	
 `val122` int DEFAULT NULL,	-- 	
 `val123` int DEFAULT NULL,	-- 	
 `val124` int DEFAULT NULL,	-- 	
 `val125` int DEFAULT NULL,	-- 	
 `val126` int DEFAULT NULL,	-- 	
 `val127` int DEFAULT NULL,	-- 	
 `val128` int DEFAULT NULL,	-- 	7
 `val129` int DEFAULT NULL,	-- 	
 `val130` int DEFAULT NULL,	-- 	
 `val131` int DEFAULT NULL,	-- 	
 `val132` int DEFAULT NULL,	-- 	
 `val133` int DEFAULT NULL,	-- 	
 `val134` int DEFAULT NULL,	-- 	
 `val135` int DEFAULT NULL,	-- 	
 `val136` int DEFAULT NULL,	-- 	
 `val137` int DEFAULT NULL,	-- 	
 `val138` int DEFAULT NULL,	-- 	
 `val139` int DEFAULT NULL,	-- 	
 `val140` int DEFAULT NULL,	-- 	
 `val141` int DEFAULT NULL,	-- 	
 `val142` int DEFAULT NULL,	-- 	
 `val143` int DEFAULT NULL,	-- 	
 `val144` int DEFAULT NULL,	-- 	
 `val145` int DEFAULT NULL,	-- 	
 `val146` int DEFAULT NULL,	-- 	
 `val147` int DEFAULT NULL,	-- 	
 `val148` int DEFAULT NULL,	-- 	
 `val149` int DEFAULT NULL,	-- 	
 `val150` int DEFAULT NULL,	-- 	
 `val151` int DEFAULT NULL,	-- 	
 `val152` int DEFAULT NULL,	-- 	
 `val153` int DEFAULT NULL,	-- 	
 `val154` int DEFAULT NULL,	-- 	
 `val155` int DEFAULT NULL,	-- 	
 `val156` int DEFAULT NULL,	-- 	
 `val157` int DEFAULT NULL,	-- 	
 `val158` int DEFAULT NULL,	-- 	
 `val159` int DEFAULT NULL,	-- 	
 `val160` int DEFAULT NULL,	-- 	
 `val161` int DEFAULT NULL,	-- 	
 `val162` int DEFAULT NULL,	-- 	
 `val163` int DEFAULT NULL,	-- 	
 `val164` int DEFAULT NULL,	-- 	
 `val165` int DEFAULT NULL,	-- 	
 `val166` int DEFAULT NULL,	-- 	
 `val167` int DEFAULT NULL,	-- 	
 `val168` int DEFAULT NULL,	-- 	
 `val169` int DEFAULT NULL,	-- 	
 `val170` int DEFAULT NULL,	-- 	
 `val171` int DEFAULT NULL,	-- 	
 `val172` int DEFAULT NULL,	-- 	
 `val173` int DEFAULT NULL,	-- 	
 `val174` int DEFAULT NULL,	-- 	
 `val175` int DEFAULT NULL,	-- 	
 `val176` int DEFAULT NULL,	-- 	
 `val177` int DEFAULT NULL,	-- 	
 `val178` int DEFAULT NULL,	-- 	
 `val179` int DEFAULT NULL,	-- 	
 `val180` int DEFAULT NULL,	-- 	
 `val181` int DEFAULT NULL,	-- 	
 `val182` int DEFAULT NULL,	-- 	
 `val183` int DEFAULT NULL,	-- 	
 `val184` int DEFAULT NULL,	-- 	
 `val185` int DEFAULT NULL,	-- 	
 `val186` int DEFAULT NULL,	-- 	
 `val187` int DEFAULT NULL,	-- 	
 `val188` int DEFAULT NULL,	-- 	
 `val189` int DEFAULT NULL,	-- 	
 `val190` int DEFAULT NULL,	-- 	
 `val191` int DEFAULT NULL,	-- 	
 `val192` int DEFAULT NULL,	-- 	
 `val193` int DEFAULT NULL,	-- 	
 `val194` int DEFAULT NULL,	-- 	
 `val195` int DEFAULT NULL,	-- 	
 `val196` int DEFAULT NULL,	-- 	
 `val197` int DEFAULT NULL,	-- 	
 `val198` int DEFAULT NULL,	-- 	
 `val199` int DEFAULT NULL,	-- 	
 `val200` int DEFAULT NULL,	-- 	
 `val201` int DEFAULT NULL,	-- 	
 `val202` int DEFAULT NULL,	-- 	
 `val203` int DEFAULT NULL,	-- 	
 `val204` int DEFAULT NULL,	-- 	
 `val205` int DEFAULT NULL,	-- 	
 `val206` int DEFAULT NULL,	-- 	
 `val207` int DEFAULT NULL,	-- 	
 `val208` int DEFAULT NULL,	-- 	
 `val209` int DEFAULT NULL,	-- 	
 `val210` int DEFAULT NULL,	-- 	
 `val211` int DEFAULT NULL,	-- 	
 `val212` int DEFAULT NULL,	-- 	
 `val213` int DEFAULT NULL,	-- 	
 `val214` int DEFAULT NULL,	-- 	
 `val215` int DEFAULT NULL,	-- 	
 `val216` int DEFAULT NULL,	-- 	
 `val217` int DEFAULT NULL,	-- 	
 `val218` int DEFAULT NULL,	-- 	
 `val219` int DEFAULT NULL,	-- 	
 `val220` int DEFAULT NULL,	-- 	
 `val221` int DEFAULT NULL,	-- 	
 `val222` int DEFAULT NULL,	-- 	
 `val223` int DEFAULT NULL,	-- 	
 `val224` int DEFAULT NULL,	-- 	
 `val225` int DEFAULT NULL,	-- 	
 `val226` int DEFAULT NULL,	-- 	
 `val227` int DEFAULT NULL,	-- 	
 `val228` int DEFAULT NULL,	-- 	
 `val229` int DEFAULT NULL,	-- 	
 `val230` int DEFAULT NULL,	-- 	
 `val231` int DEFAULT NULL,	-- 	
 `val232` int DEFAULT NULL,	-- 	
 `val233` int DEFAULT NULL,	-- 	
 `val234` int DEFAULT NULL,	-- 	
 `val235` int DEFAULT NULL,	-- 	
 `val236` int DEFAULT NULL,	-- 	
 `val237` int DEFAULT NULL,	-- 	
 `val238` int DEFAULT NULL,	-- 	
 `val239` int DEFAULT NULL,	-- 	
 `val240` int DEFAULT NULL,	-- 	
 `val241` int DEFAULT NULL,	-- 	
 `val242` int DEFAULT NULL,	-- 	
 `val243` int DEFAULT NULL,	-- 	
 `val244` int DEFAULT NULL,	-- 	
 `val245` int DEFAULT NULL,	-- 	
 `val246` int DEFAULT NULL,	-- 	
 `val247` int DEFAULT NULL,	-- 	
 `val248` int DEFAULT NULL,	-- 	
 `val249` int DEFAULT NULL,	-- 	
 `val250` int DEFAULT NULL,	-- 	
 `val251` int DEFAULT NULL,	-- 	
 `val252` int DEFAULT NULL,	-- 	
 `val253` int DEFAULT NULL,	-- 	
 `val254` int DEFAULT NULL,	-- 	
 `val255` int DEFAULT NULL,	-- 	
 `val256` int DEFAULT NULL,	-- 	8

  PRIMARY KEY (`Lectura`)
) ENGINE=InnoDB;
