if OBJECT_ID('dbo.usp_MakeFamilyPurchase', 'P') is not null
    drop proc dbo.usp_MakeFamilyPurchase;
go
create proc dbo.usp_MakeFamilyPurchase
    @FamilySurName nvarchar(255)
as
if not exists (select * from dbo.Family where @FamilySurName = SurName)
    declare @msg nvarchar(255) = 
	    formatmessage('The %s entry does not exist!', @FamilySurName);
    throw 50001, @msg, 1;

declare @sumValue INT
select @sumValue = isnull(sum([Value]), 0)
from dbo.Basket as b
    join dbo.Family as f 
	    on b.ID_Family = f.ID
where SurName = @FamilySurName
    
update dbo.Family
    set BudgetValue = BudgetValue - @sumValue
where SurName = @FamilySurName

go