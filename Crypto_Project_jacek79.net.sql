CREATE DATABASE Project_Crypto_tracker
USE Project_Crypto_tracker


CREATE SEQUENCE newSeq AS BIGINT
START WITH 1
INCREMENT BY 1
MINVALUE 1
GO
--ALTER SEQUENCE newSeq RESTART WITH 1


--==================================  Patern for additional coin  ================================================== replace all {/}
--#################################   ###############################################################
/*
CREATE TABLE  {/}
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				  not null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )			   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE {/} ADD CONSTRAINT [Chk_Symbol_UP_{/}]		    CHECK (Symbol = upper('{/}')) 
ALTER TABLE {/} ADD CONSTRAINT [Df_Date_time_{/}]		    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE {/} ADD CONSTRAINT [Df_Trans_type_{/}]          DEFAULT ('B') FOR Trans_type
ALTER TABLE {/} ADD CONSTRAINT [Chk_Trans_type_{/}]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE {/} ADD CONSTRAINT [Df_Unq_nr_{/}]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE {/} ADD CONSTRAINT [Df_defaultName_{/}]       DEFAULT ('{/}') FOR Name
ALTER TABLE {/} ADD CONSTRAINT [Df_sequence_{/}]		   DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_TEST ON {/} (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 
*/
--==================================================================================================================
IF EXISTS (SELECT * FROM  PolcaDot ) DROP TABLE PolcaDot 
CREATE TABLE PolcaDot 
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )			   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE PolcaDot ADD CONSTRAINT [Chk_Symbol_UP]		CHECK (Symbol = upper('DOT')) -- to prevent inserting incorect coins into DOT table 
ALTER TABLE PolcaDot ADD CONSTRAINT [Df_Date_time]		DEFAULT (getdate()) FOR Date_time -- time of inserting into DB 
ALTER TABLE PolcaDot ADD CONSTRAINT [Df_Trans_type_POL] DEFAULT ('B') FOR Trans_type
ALTER TABLE PolcaDot ADD CONSTRAINT [Chk_Trans_type]	CHECK (    Trans_type = upper ('B')     -- Binance
																or Trans_type = upper ('C')	    -- Coinbase 
																or Trans_type = upper ('CR')    -- Crypto.com
																or Trans_type = upper ('H') )   -- Huobi
ALTER TABLE PolcaDot ADD CONSTRAINT [Df_Unq_nr]			DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE PolcaDot ADD CONSTRAINT [Df_defaultName]    DEFAULT ('PolcaDot') FOR Name
ALTER TABLE PolcaDot ADD CONSTRAINT [Df_sequence]		DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction -- Using my sequence for Id_transaction
--ALTER TABLE PolcaDot ADD CONSTRAINT [Un_unq_transaction]   UNIQUE (Transaction_Hash) -- only one null INCORRECT !!!
-- UNIQUE CONSTRAINT allow only one null in column so UNIQUE NONCLUSTERED INDEX will allow more than one NULL and unique  Transaction_Hash key without duplicates as in crypto transaction there  is no way for the transaction keys to be duplicated
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_PolcaDot ON PolcaDot (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 

-----#################################  Chainlink / LINK ####################################
--TRUNCATE TABLE Chainlink
DROP TABLE IF EXISTS  Chainlink 
CREATE TABLE Chainlink 
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)             null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 , 
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE Chainlink ADD CONSTRAINT [Chk_Symbol_UP_LINK]   CHECK (Symbol = upper('LINK'))
ALTER TABLE Chainlink ADD CONSTRAINT [Df_Trans_type_LINK]   DEFAULT ('B') FOR Trans_type
ALTER TABLE Chainlink ADD CONSTRAINT [Df_Date_time_LINK]    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE Chainlink ADD CONSTRAINT [Chk_Trans_type_LINK]  CHECK  (    Trans_type = upper ('B')   -- Binance
																	 or Trans_type = upper ('C')   -- Coinbase 
																     or Trans_type = upper ('CR')  -- Crypto.com
																     or Trans_type = upper ('H') ) -- Huobi
ALTER TABLE Chainlink ADD CONSTRAINT [Df_Unq_nr_LINK]	    DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE Chainlink ADD CONSTRAINT [Df_defaultName2]      DEFAULT ('Chainlink') FOR Name
ALTER TABLE Chainlink ADD CONSTRAINT   [Df_sequence_LINK]		DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_Chainlink ON Chainlink (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 



-----#################################  Polygon / MATIC ####################################
drop table if exists  Polygon 
CREATE TABLE Polygon 
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE Polygon ADD CONSTRAINT [Chk_Symbol_UP_MATIC]		CHECK (Symbol = upper('MATIC')) 
ALTER TABLE Polygon ADD CONSTRAINT [Df_Date_time_MATIC]		    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE Polygon ADD CONSTRAINT [Df_Trans_type_MATIC]        DEFAULT ('B') FOR Trans_type
ALTER TABLE Polygon ADD CONSTRAINT [Chk_Trans_type_MATIC]	    CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE Polygon ADD CONSTRAINT [Df_Unq_nr_MATIC]			DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE Polygon ADD CONSTRAINT [Df_defaultName_MATIC]       DEFAULT ('Polygon') FOR Name
ALTER TABLE Polygon ADD CONSTRAINT [Df_sequence_MATIC]		    DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_Polygon ON Polygon (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL




--################################# Fantom / FTM ##############################################
drop table if exists  Fantom 
CREATE TABLE  Fantom
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE Fantom ADD CONSTRAINT [Chk_Symbol_UP_FTM]		    CHECK (Symbol = upper('FTM')) 
ALTER TABLE Fantom ADD CONSTRAINT [Df_Date_time_FTM]		    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE Fantom ADD CONSTRAINT [Df_Trans_type_FTM]           DEFAULT ('B') FOR Trans_type
ALTER TABLE Fantom ADD CONSTRAINT [Chk_Trans_type_FTM]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE Fantom ADD CONSTRAINT [Df_Unq_nr_FTM]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE Fantom ADD CONSTRAINT [Df_defaultName_FTM]         DEFAULT ('Fantom') FOR Name
ALTER TABLE Fantom ADD CONSTRAINT [Df_sequence_FTM]		       DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_Fantom ON Fantom (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL




--################################# Cronos CRO ###############################################################
drop table if exists  Cronos 
CREATE TABLE  Cronos
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE Cronos ADD CONSTRAINT [Chk_Symbol_UP_CRO]		      CHECK (Symbol = upper('CRO')) 
ALTER TABLE Cronos ADD CONSTRAINT [Df_Date_time_CRO]		      DEFAULT (getdate()) FOR Date_time 
ALTER TABLE Cronos ADD CONSTRAINT [Df_Trans_type_CRO}]            DEFAULT ('B') FOR Trans_type
ALTER TABLE Cronos ADD CONSTRAINT [Chk_Trans_type_CRO]	          CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE Cronos ADD CONSTRAINT [Df_Unq_nr_CRO]			    DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE Cronos ADD CONSTRAINT [Df_defaultName_CRO]          DEFAULT ('Cronos') FOR Name
ALTER TABLE Cronos ADD CONSTRAINT [Df_sequence_CRO]		        DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_Cronos ON Cronos (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL




--################################# JasmyCoin JASMY ###############################################################
drop table if exists  JasmyCoin 
CREATE TABLE  JasmyCoin
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE JasmyCoin ADD CONSTRAINT [Chk_Symbol_UP_JASMY]		    CHECK (Symbol = upper('JASMY')) 
ALTER TABLE JasmyCoin ADD CONSTRAINT [Df_Date_time_JASMY]		    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE JasmyCoin ADD CONSTRAINT [Df_Trans_type_JASMY]          DEFAULT ('B') FOR Trans_type
ALTER TABLE JasmyCoin ADD CONSTRAINT [Chk_Trans_type_JASMY]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE JasmyCoin ADD CONSTRAINT [Df_Unq_nr_JASMY]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE JasmyCoin ADD CONSTRAINT [Df_defaultName_JASMY]        DEFAULT ('JasmyCoin') FOR Name
ALTER TABLE JasmyCoin ADD CONSTRAINT [Df_sequence_JASMY]		   DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_JasmyCoin ON JasmyCoin (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 




--################################# TheGraph GRT ###############################################################
drop table if exists  TheGraph 
CREATE TABLE  TheGraph
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE TheGraph ADD CONSTRAINT [Chk_Symbol_UP_GRT]		    CHECK (Symbol = upper('GRT')) 
ALTER TABLE TheGraph ADD CONSTRAINT [Df_Date_time_GRT]		    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE TheGraph ADD CONSTRAINT [Df_Trans_type_GRT]          DEFAULT ('B') FOR Trans_type
ALTER TABLE TheGraph ADD CONSTRAINT [Chk_Trans_type_GRT]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE TheGraph ADD CONSTRAINT [Df_Unq_nr_GRT]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE TheGraph ADD CONSTRAINT [Df_defaultName_GRT]       DEFAULT ('TheGraph') FOR Name
ALTER TABLE TheGraph ADD CONSTRAINT [Df_sequence_GRT]		   DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_JTheGraph ON TheGraph (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 






--################################# BitcoinCash BCH  ###############################################################
drop table if exists BitcoinCash
CREATE TABLE   BitcoinCash
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE BitcoinCash ADD CONSTRAINT [Chk_Symbol_UP_BCH]		    CHECK (Symbol = upper('BCH')) 
ALTER TABLE BitcoinCash ADD CONSTRAINT [Df_Date_time_BCH]		    DEFAULT (getdate()) FOR Date_time 
ALTER TABLE BitcoinCash ADD CONSTRAINT [Df_Trans_type_BCH]          DEFAULT ('B') FOR Trans_type
ALTER TABLE BitcoinCash ADD CONSTRAINT [Chk_Trans_type_BCH]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE BitcoinCash ADD CONSTRAINT [Df_Unq_nr_BCH]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE BitcoinCash ADD CONSTRAINT [Df_defaultName_BCH]        DEFAULT ('BitcoinCash') FOR Name
ALTER TABLE BitcoinCash ADD CONSTRAINT [Df_sequence_BCH]		   DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_BitcoinCash ON BitcoinCash (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 




--################################# Reef REEF   ###############################################################
drop table if exists Reef
CREATE TABLE  Reef
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE Reef ADD CONSTRAINT [Chk_Symbol_UP_REEF]		    CHECK (Symbol = upper('REEF')) 
ALTER TABLE Reef ADD CONSTRAINT [Df_Date_time_REEF]		        DEFAULT (getdate()) FOR Date_time 
ALTER TABLE Reef ADD CONSTRAINT [Df_Trans_type_REEF]            DEFAULT ('B') FOR Trans_type
ALTER TABLE Reef ADD CONSTRAINT [Chk_Trans_type_REEF]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE Reef ADD CONSTRAINT [Df_Unq_nr_REEF]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE Reef ADD CONSTRAINT [Df_defaultName_REEF]          DEFAULT ('Reef') FOR Name
ALTER TABLE Reef ADD CONSTRAINT [Df_sequence_REEF]		       DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_Reef ON Reef (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL  






--################################# Verge XVG  ###############################################################
drop table if exists Verge
CREATE TABLE  Verge
(
[Id_Transaction]				int			          not null	PRIMARY KEY	                   ,
[Name]			         		nvarchar (30)         not null								   ,
[Symbol]						char(10)				  null								   ,
[Date_time]						datetime			  not null								   ,
[Quantity]						decimal(20,4)			  null								   ,
[Current_USD]					money					  null								   ,
[Trans_type]					char(3)				      null								   ,
[Sum_tran]						as cast((Quantity*Current_USD) as decimal(8,2) )				   ,
[Unq_nr]                        uniqueidentifier      not null                                 ,
[Transaction_Hash]              nvarchar(300)             null
)
ALTER TABLE Verge ADD CONSTRAINT [Chk_Symbol_UP_XVG]		    CHECK (Symbol = upper('XVG')) 
ALTER TABLE Verge ADD CONSTRAINT [Df_Date_time_XVG]		        DEFAULT (getdate()) FOR Date_time 
ALTER TABLE Verge ADD CONSTRAINT [Df_Trans_type_XVG]            DEFAULT ('B') FOR Trans_type
ALTER TABLE Verge ADD CONSTRAINT [Chk_Trans_type_XVG]	        CHECK (    
																   Trans_type = upper ('B')   
																or Trans_type = upper ('C')	  
																or Trans_type = upper ('CR')  
																or Trans_type = upper ('H') ) 
ALTER TABLE Verge ADD CONSTRAINT [Df_Unq_nr_XVG]			   DEFAULT NEWSEQUENTIALID() FOR Unq_nr
ALTER TABLE Verge ADD CONSTRAINT [Df_defaultName_XVG]          DEFAULT ('Verge') FOR Name
ALTER TABLE Verge ADD CONSTRAINT [Df_sequence_XVG]		       DEFAULT NEXT VALUE FOR newSeq FOR Id_Transaction 
CREATE UNIQUE NONCLUSTERED INDEX IND_crypto_Verge ON Verge (Transaction_Hash )WHERE Transaction_Hash IS NOT NULL 
-- ##############################################################################################################################








--############################################   STORED PROCEDURE   ################################################################################

/*
creating procedure for transaction (Insert) 
This SP is for quick insert and does not allow to change date 
for inserting with a diferent date than getdate() please use INSERT statement or UPDATE
*/
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'Crypto_INSERT') DROP PROCEDURE Crypto_INSERT
GO

CREATE PROCEDURE Crypto_INSERT 
(  
@Statement			 nvarchar(40) = ''     ,	 
@Quantity			 decimal(20,4)		   ,
@Current_USD		 money			       ,
@Trans_type          CHAR(3)  = default    ,
@Transaction_Hash    nvarchar(300) = DEFAULT
)
AS 
BEGIN 

	if @Statement = 'Link'
	begin
		Insert into Chainlink (Symbol , Quantity  ,Current_USD  , Trans_type ,Transaction_Hash )
		OUTPUT inserted.*
			   values  (  @Statement  , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash )
	end 

    
	if @Statement = 'Dot'
	begin 
   	    Insert into PolcaDot ( Symbol , Quantity  ,Current_USD  , Trans_type ,Transaction_Hash)
		OUTPUT inserted.*
				values  ( @Statement  , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	end

	 if @Statement = 'MATIC'
	 begin 
   	   Insert into Polygon ( Symbol  , Quantity  ,Current_USD  , Trans_type  ,Transaction_Hash)
	   OUTPUT inserted.*
				values  ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	 end


	 if @Statement = 'FTM'
	 begin 
   	   Insert into Fantom ( Symbol   , Quantity  ,Current_USD  , Trans_type  ,Transaction_Hash)
	   OUTPUT inserted.*
				values  ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	 end


	 if @Statement = 'CRO'
	 begin 
   	    Insert into Cronos ( Symbol  , Quantity  ,Current_USD  , Trans_type ,Transaction_Hash)
		OUTPUT inserted.*
				values  ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	 end


	 if @Statement = 'JASMY'
	 begin 
   	   Insert into JasmyCoin ( Symbol , Quantity  ,Current_USD  , Trans_type  ,Transaction_Hash)
	   OUTPUT inserted.*
				values   ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	   end


	 if @Statement = 'GRT'
	 begin 
   	   Insert into TheGraph ( Symbol , Quantity  ,Current_USD  , Trans_type  ,Transaction_Hash)
	   OUTPUT inserted.*
				values  ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	 end


	  if @Statement = 'BCH'
	  begin 
   	   Insert into BitcoinCash ( Symbol , Quantity ,Current_USD , Trans_type   ,Transaction_Hash)
	   OUTPUT inserted.*
				values  ( @Statement   , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	  end


	  if @Statement = 'REEF'
	  begin 
   	   Insert into Reef ( Symbol , Quantity ,Current_USD , Trans_type,Transaction_Hash)
	   OUTPUT inserted.*
				values  ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	  end


	   
	  if @Statement = 'XVG'
	  begin 
   	   Insert into Verge ( Symbol    , Quantity  ,Current_USD  , Trans_type ,Transaction_Hash)
	      OUTPUT inserted.*
				values  ( @Statement , @Quantity ,@Current_USD ,@Trans_type , @Transaction_Hash)
	   end

	      print 'Transaction added into DB'
	 
	 if @Statement not in ('XVG','REEF','BCH','GRT','JASMY','LINK','CRO','DOT','FTM')			
	 begin 
	  select 'Transaction unsuccessful please check symbol of your coin ' as [Information]
	  , CAST(getdate () as nvarchar(20)) as [DateTime]
	  , SYSTEM_USER as [User]
	 end 

	   
END
 -- ##############################################################################################################################






 ---########################  TESTING #############################################################################################
-- inserting 
Insert into PolcaDot ( Symbol , Quantity ,Trans_type ,Current_USD)
			values  ( 'DOT'   , 14.5     , 'B'  , 186.89 )
			       ,( 'DOT'   , 11.3     , 'CR' , 111.12 ) 
				   ,( 'DOT'   , 100      , 'H'  , 186.89 )
----- testing selling >>> negative value 
Insert into PolcaDot ( Symbol , Quantity ,Trans_type ,Current_USD)
			values  ('DOT'   , -12     , 'B' , 100 )

Insert into PolcaDot ( Symbol , Quantity ,Trans_type ,Current_USD ,Transaction_Hash) -- testing with Hash 
			values  ('DOT'   , 10     , 'b' , 30, '0xfeb138c320f01d255e3036c0ec42ce3023aa14bea11fe9218341d3667e4ee18A' ) 
-- success when inserting once , second failing as expected because Unique Nonclustered Index on column hash need to be unique 

Insert into PolcaDot ( Symbol , Quantity ,Trans_type ,Current_USD ) -- testing with Hash 
			values  ('GRT'   , 10     , 'b' , 30 )
-- failed as expected because >>> CHECK constraint "Chk_Symbol_UP". The conflict occurred in database "Project_Crypto_tracker", table "dbo.PolcaDot", column 'Symbol'		

--###############################  TESTING  Stored Procedure ##############################################################

Execute Crypto_INSERT 'Dot' ,19 ,6.93 -- transaction type NULL success !
Execute Crypto_INSERT 'Dot' ,20 ,5.52,'C'  -- testing procedure with mix of letters in symbol column
Execute Crypto_INSERT 'DOT' ,-9 ,6.78,'H'  -- selling (negative value)
Execute Crypto_INSERT 'LINK' ,1990 ,6.60,'cr','0xfeb138c320f01d255e3036c0ec42ce3023aa14bea11fe9218341d3667e4ee18L'
Execute Crypto_INSERT 'CRO' ,50000 ,0.071334
Execute Crypto_INSERT 'XVG' ,50000 ,0.00388400	
Execute Crypto_INSERT 'XVG' ,20000 ,0.00434900
Execute Crypto_INSERT 'XRP' , 10 ,55  -- not existing coin >>>> launches "if not" statement >> correct !
EXEC Crypto_INSERT 'CRO',303,0.071105,'CR'
--##########################################  The test passed successfully ########################################################









-- ##############################################   CREATING VIEW  ################################################################
GO
CREATE VIEW Crypto_View_coins AS
SELECT * FROM PolcaDot
UNION 
SELECT * FROM Chainlink
UNION
SELECT * FROM [dbo].[Verge]
UNION
SELECT * FROM [dbo].[BitcoinCash]
UNION
SELECT * FROM [dbo].[Cronos]
UNION
SELECT * FROM [dbo].[Fantom]
UNION
SELECT * FROM [dbo].[JasmyCoin]
UNION
SELECT * FROM [dbo].[Polygon]
UNION
SELECT * FROM [dbo].[Reef]
UNION
SELECT * FROM [dbo].[TheGraph]

ORDER BY Id_Transaction
OFFSET 0 ROWS 
FETCH NEXT 5000 ROWS ONLY 
-- ##############################################################################################################################








-- ############################################  CREATEING UDF ON VIEW  #########################################################
GO
CREATE FUNCTION QUickView ( @Symbol char(10) )
RETURNS TABLE 
AS RETURN 
         ( SELECT * FROM  Crypto_View_coins WHERE @Symbol = Symbol)

SELECT * FROM QUickView ('XVG')--	testing !! 
-- ##############################################################################################################################










-- ##################################  CREATING TARGET PRICE - table with desired price selling price ###########################
SELECT  
Name
,Symbol
,SUM(Sum_tran) as [Total_USD]
,SUM(Quantity) as [Total_coins]
,[AverageBuyingPrice] =  sum(Sum_tran) / sum(Quantity)
,[My_target] = '--->>>>'
INTO #Target_Price_sell
FROM [dbo].[Crypto_View_coins]
GROUP BY  Name ,Symbol 

ALTER TABLE #Target_Price_sell ADD [Trg_price_coin] DECIMAL (10,2) 

-- insert your desire target coin price 
update #Target_Price_sell SET Trg_price_coin = 400   WHERE Symbol = 'BCH'
update #Target_Price_sell SET Trg_price_coin = 1.50  WHERE Symbol = 'CRO'
update #Target_Price_sell SET Trg_price_coin = 45    WHERE Symbol = 'DOT'
update #Target_Price_sell SET Trg_price_coin = 2     WHERE Symbol = 'FTM'
update #Target_Price_sell SET Trg_price_coin = 1.50  WHERE Symbol = 'GRT'
update #Target_Price_sell SET Trg_price_coin = 0.15  WHERE Symbol = 'JASMY'
update #Target_Price_sell SET Trg_price_coin = 45    WHERE Symbol = 'Link'
update #Target_Price_sell SET Trg_price_coin = 3.50  WHERE Symbol = 'MATIC'
update #Target_Price_sell SET Trg_price_coin = 0.03  WHERE Symbol = 'REEF'
update #Target_Price_sell SET Trg_price_coin = 0.05  WHERE Symbol = 'XVG'


SELECT *
,FORMAT (ceiling (Trg_price_coin / AverageBuyingPrice * 100.0) ,'P0','en-GB' )as [PercentFromBuingPrice]
,FORMAT (Trg_price_coin * Total_coins ,'C','en-US' )  as [Total_Desired_Profit]
INTO Personal_target
FROM #Target_Price_sell

SELECT * FROM Personal_target
-- ##############################################################################################################################








-- ############################################### VIEW Crypto_summary########################################################
GO
CREATE VIEW Crypto_summary as
		SELECT Name 
		,CAST( SUM(Quantity) AS INT  ) as [Total_coins]
		,FORMAT (SUM(Sum_tran),'C','en-US' )AS [USD_invested]
		FROM [dbo].[Crypto_View_coins]
		GROUP BY  Name
		ORDER BY USD_invested desc
		OFFSET 0 ROWS 
		FETCH NEXT 500 ROWS ONLY 

SELECT * FROM Crypto_summary  -- testing 











-- #################################### Now a few query to introduce data investment #################################################

-- OVER 
SELECT -- Running_investment
Name 
,Symbol
,Date_time
,Quantity
,Trans_type
,Sum_tran
,SUM(Sum_tran) OVER ( PARTITION BY [Name]  ORDER BY Sum_tran) as [Running_investment] 
FROM [dbo].[Crypto_View_coins]



-- ROLLUP 
SELECT -- Summary every Month / Year / Total   
Name 
,SUM(Sum_tran) AS [USD_invested]a
,YEAR(Date_time) as [YYdate]
,MONTH(Date_time) as[MMdate]
, CASE WHEN YEAR(Date_time) IS NOT NULL AND MONTH(Date_time) IS NOT NULL THEN 'Month_Summary' 
       WHEN YEAR(Date_time) IS NOT NULL AND MONTH(Date_time) IS     NULL THEN 'Year_Summary'
	   WHEN YEAR(Date_time) IS     NULL AND MONTH(Date_time) IS     NULL THEN 'Coin_Summary'
	   END AS [Info]
FROM [dbo].[Crypto_View_coins]
GROUP BY ROLLUP ( Name ,YEAR(Date_time) ,MONTH(Date_time) )




-- PIVOT 
GO
WITH CTE_PIVOT AS (
					SELECT  
					Sum_tran
					,YEAR(Date_time) as [YYdate]
					,MONTH(Date_time) as[MMdate]
					FROM [dbo].[Crypto_View_coins]
				 )
SELECT    YYdate   ,    ISNULL ([1] ,0.00) AS [January]
                       ,ISNULL ([2] ,0.00) AS [February]
                       ,ISNULL ([3] ,0.00) AS [March]
                       ,ISNULL ([4] ,0.00) AS [April]
                       ,ISNULL ([5] ,0.00) AS [May]
                       ,ISNULL ([6] ,0.00) AS [June]
                       ,ISNULL ([7] ,0.00) AS [July]
                       ,ISNULL ([8] ,0.00) AS [August]
                       ,ISNULL ([9] ,0.00) AS [September]
                       ,ISNULL ([10],0.00) AS [October]
                       ,ISNULL ([11],0.00) AS [November]
                       ,ISNULL ([12],0.00) AS [December] FROM CTE_PIVOT 
PIVOT ( SUM (Sum_tran) FOR  MMdate IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]) ) AS PVT
ORDER BY [YYdate]