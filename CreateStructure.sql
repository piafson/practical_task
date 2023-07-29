if OBJECT_ID('dbo.Basket', 'U') is not null
    drop table dbo.Basket

if OBJECT_ID('dbo.Family', 'U') is not null
    drop table dbo.Family

if OBJECT_ID('dbo.SKU', 'U') is not null
    drop table dbo.SKU


create table dbo.SKU
(
    ID int not null identity primary key
    , Code as 's' + cast(ID as varchar(30)) unique
    , [Name] nvarchar(255) not null
);

create table dbo.Family
(
    ID int not null identity primary key
    , SurName nvarchar(255) not null
    , BudgetValue money not null
);


create table dbo.Basket 
(
    ID int not null identity
    , ID_SKU int not null references dbo.SKU(ID)
    , ID_Family int not null references dbo.Family(ID)
    , Quantity int not null
    , [Value]  int not null
    , PurchaseDate date not null default getdate()
    , DiscountValue float not null
    , constraint CHK_Backet_Qty check(Quantity >= 0)
    , constraint CHK_Backet_Value check([Value] >= 0)
);