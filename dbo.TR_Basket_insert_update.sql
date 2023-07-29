if OBJECT_ID('dbo.TR_Basket_insert_update') is not null
    drop trigger dbo.TR_Basket_insert_update;
go
create trigger TR_Basket_insert_update on dbo.Basket
after insert, update
as
update dbo.Basket
set DiscountValue = iif(@@rowcount >= 2, [Value] * 5, 0)
where ID_SKU = (select ID_SKU from inserted);

go