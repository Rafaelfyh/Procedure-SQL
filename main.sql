-- Tabela Stage --

create table [GRP-08/22].[rafael_Queiroz_STAGE] 
 (
	Regiao varchar(100),
 	Pais varchar(200),
 	Tipo_item Varchar(Max),
 	Canal_vendas Varchar(50),
 	Prioridade_pedido varchar(200),
 	Data_pedido datetime, 
 	ID_pedido int,
	Data_envio datetime,
 	Unidades_vendidas int,
 	Preco_unitario float,
 	Custo_unitario float, 
 	Rendimento_total float,
 	Custo_total float, 
 	lucro_total float )

    -- Tabelas dimensao: Canal vendas, Países e regiões  --

CREATE TABLE [GRP-08/22].[Rafael_Queiroz_DIM_CanalVendas]( 
 [Id_pedido] [int] NOT NULL,
 [Canal_vendas] [varchar](50) NULL)

CREATE TABLE [GRP-08/22].[Rafael_Queiroz_DIM_Paises](
 [Id_pedido] [int] NOT NULL,
 [Pais] [varchar](50) NULL)

CREATE TABLE [GRP-08/22].[Rafael_Queiroz_DIM_Regioes](
 [Id_pedido] [int] NOT NULL,
 [Regiao] [varchar](50) NULL
)

-- Tabela Fato -- 

create table[GRP-08/22].[Rafael_Queiroz_Fato](
    [ID_pedido] int,
    [Tipo_item] varchar(100),
    Prioridade_pedido varchar(100),
    Data_pedido datetime,
    Data_envio datetime,
    Unidades_vendidas int,
    Preco_unitario float,
    Custo_unitario float,
    Rendimento_total float,
    Custo_total float,
    Lucro_total float,
	Pais varchar(100)
    )

-- Criação da Procedure --
-- Inserindo dados: Stage, Fato e dimensao --

CREATE PROCEDURE [GRP-08/22].[rafael_queiroz_procedurelab3] 
AS 
BEGIN

-------LIMPANDO AS TABELAS DIM E FATO, toda vez que vc rodar não inserir dados por cima-----
    TRUNCATE TABLE [GRP-08/22].[Rafael_Queiroz_Fato]
    TRUNCATE TABLE [GRP-08/22].[Rafael_Queiroz_DIM_CanalVendas]
    TRUNCATE TABLE [GRP-08/22].[Rafael_Queiroz_DIM_Paises]
    TRUNCATE TABLE [GRP-08/22].[Rafael_Queiroz_DIM_Regioes]

 -------INSERINDO DADOS NA TABELA FATO---------
    INSERT INTO [GRP-08/22].[Rafael_Queiroz_Fato](
			ID_pedido,
            Tipo_item,
            Prioridade_pedido,
            Data_pedido,
            Data_envio,
            Unidades_vendidas,
            Preco_unitario,
            Custo_unitario,
            Rendimento_total,
            Custo_total,
            Lucro_total,
            Pais)
    SELECT  ID_pedido,
            Tipo_item,
            Prioridade_pedido,
            Data_pedido,
            Data_envio,
            Unidades_vendidas,
            Preco_unitario,
            Custo_unitario,
            Rendimento_total,
            Custo_total,
            Lucro_total,
            Pais
    FROM [GRP-08/22].[rafael_Queiroz_STAGE] 

 ----------INSERINDO DADOS NA DIM CANAL VENDAS-------
    INSERT INTO [GRP-08/22].[Rafael_Queiroz_DIM_CanalVendas](
                    Id_pedido,
                    Canal_vendas)
    SELECT DISTINCT Id_pedido,
                    Canal_vendas
    FROM [GRP-08/22].[rafael_Queiroz_STAGE]
    ORDER BY ID_pedido 

-------INSERINDO DADOS DIM PAISES------
    INSERT INTO [GRP-08/22].[Rafael_Queiroz_DIM_Paises](
                     Id_pedido,
                     País)
    SELECT DISTINCT Id_pedido,
                     Pais
    FROM [GRP-08/22].[rafael_Queiroz_STAGE]
    ORDER BY ID_pedido 
    
    ------INSERINDO DADOS DIM REGIAO------
    INSERT INTO [GRP-08/22].[Rafael_Queiroz_DIM_Regioes](
                    Id_pedido,
                    Regiao)
    SELECT DISTINCT Id_pedido,
                    Regiao
    FROM [GRP-08/22].[rafael_Queiroz_STAGE]
    ORDER BY ID_pedido 
    TRUNCATE TABLE [GRP-08/22].[rafael_Queiroz_STAGE] 
END
GO
