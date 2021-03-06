USE [licDB]
GO
/****** Object:  Table [dbo].[Contracts]    Script Date: 05-07-2020 20:40:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contracts](
	[ContractID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](100) NOT NULL,
	[Address] [varchar](150) NOT NULL,
	[Gender] [varchar](1) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[Dateofbirth] [datetime2](0) NOT NULL,
	[SaleDate] [datetime2](0) NOT NULL,
	[CoveragePlan] [varchar](15) NULL,
	[NetPrice] [decimal](8, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContractID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoveragePlan]    Script Date: 05-07-2020 20:40:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoveragePlan](
	[CoveragePlan] [varchar](15) NOT NULL,
	[EDateFrom] [datetime2](0) NOT NULL,
	[EDateTo] [datetime2](0) NOT NULL,
	[ECountry] [varchar](35) NOT NULL,
	[CPID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RateChart]    Script Date: 05-07-2020 20:40:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RateChart](
	[CoveragePlan] [varchar](15) NOT NULL,
	[Gender] [varchar](1) NOT NULL,
	[Age] [varchar](25) NOT NULL,
	[NetPrice] [decimal](8, 2) NOT NULL,
	[RCID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contracts] ADD  DEFAULT (NULL) FOR [CoveragePlan]
GO
ALTER TABLE [dbo].[Contracts] ADD  DEFAULT (NULL) FOR [NetPrice]
GO
/****** Object:  StoredProcedure [dbo].[AddEdit_Contract]    Script Date: 05-07-2020 20:40:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[AddEdit_Contract](@p_Name VARCHAR(100), @p_Address VARCHAR(150),@p_ID int, @p_Country varchar(15), @p_SDate varchar(25),@p_Gen varchar(1), @p_Age varchar(25), @p_dob varchar(25), @p_flag varchar(10))
AS
BEGIN
SET NOCOUNT ON;
/*
	Procedure to Create , Modify Insurance Contracs based on Gender, Age group
	Country and SaleDate

*/
    DECLARE @l_cp     VARCHAR(15);
	DECLARE	@l_np	 decimal(8,2);
    
	select Top 1 @l_cp = CoveragePlan   
    from CoveragePlan 
    where @p_SDate between EDateFrom and EDateTo 
    and ECountry = case when @p_Country not in ('USA','CAN') then '*' else @p_Country end;

	SELECT Top 1 @l_np =  RC.NetPrice 
	FROM licDB.dbo.RateChart as  RC 
	where  RC.CoveragePlan  = @l_cp 
	and  RC.Gender  = @p_Gen
	and  RC.Age  = @p_Age;

	-- select l_cp, l_np;
    if (@p_flag = 'Modify')
    begin
		UPDATE licDB.dbo.Contracts
		SET  	 CoveragePlan = @l_cp, 	
				 NetPrice  = @l_np ,
				 Country  = @p_Country,
				 SaleDate  = @p_SDate
		WHERE ContractID = @p_ID;
		
		select * from Contracts where ContractID=@p_ID;
	end;
    else
    begin
		INSERT INTO licDB.dbo.Contracts
		( CustomerName ,	 Address ,	 Gender ,	 Country ,	 Dateofbirth ,
		 SaleDate , 	 CoveragePlan , 	 NetPrice )
		VALUES
		(@p_Name, @p_Address, @p_Gen, @p_Country,@p_dob, @p_SDate, @l_cp, @l_np);
		
		select * from Contracts where ContractID= @@IDENTITY;    
    end;
    
END;
GO
