if OBJECT_ID('dbo.udf_GetSKUPrice') is not null
    drop function dbo.udf_GetSKUPrice;
go

create function dbo.udf_GetSKUPrice
(
    @ID_SKU INT
)
returns decimal(18, 2)
as
begin
    declare @SumValue INT;
    declare @SumQuantity INT;

    select
        @SumValue = SUM([Value]),
        @SumQuantity = SUM(Quantity)
    from Basket
    where ID_SKU = @ID_SKU

    return @SumValue / @SumQuantity
end;

go
