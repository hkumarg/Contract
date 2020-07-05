CREATE  PROCEDURE AddEdit_Contract(@p_Name VARCHAR(100), @p_Address VARCHAR(150),@p_ID int, @p_Country varchar(15), @p_SDate varchar(25),@p_Gen varchar(1), @p_Age varchar(25), @p_dob varchar(25), @p_flag varchar(10))
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
	FROM licdb.RateChart as  RC 
	where  RC.CoveragePlan  = @l_cp 
	and  RC.Gender  = @p_Gen
	and  RC.Age  = @p_Age;

	-- select l_cp, l_np;
    if (@p_flag = 'Modify')
    begin
		UPDATE licdb.Contracts
		SET  	 CoveragePlan = @l_cp, 	
				 NetPrice  = @l_np ,
				 Country  = @p_Country,
				 SaleDate  = @p_SDate
		WHERE ContractID = @p_ID;
		
		select * from Contracts where ContractID=@p_ID;
	end;
    else
    begin
		INSERT INTO licdb.Contracts
		( CustomerName ,	 Address ,	 Gender ,	 Country ,	 Dateofbirth ,
		 SaleDate , 	 CoveragePlan , 	 NetPrice )
		VALUES
		(@p_Name, @p_Address, @p_Gen, @p_Country,@p_dob, @p_SDate, @l_cp, @l_np);
		
		select * from Contracts where ContractID= @@IDENTITY;    
    end;
    
END;
GO