create table stores (
    storeID integer PRIMARY KEY,
    state varchar(2),
    zipcode integer(5)
);

create table Items (
    item integer PRIMARY KEY,
    productID integer FOREIGN key,
    price decimal
);

create table Products (
    productID integer primary key,
    carid integer foreign key,
    name varchar(50)
);

create table cars(
    CarID integer primary key,
    storeID integer foreign key,
    model varchar(50),
    color varchar(50),
    brand varchar(50),
    year integer
);

-- find a compatible part from a store
select s.storeID, i.price
from stores S inner join cars c on s.storeID = c.storeID
    inner join  products p on c.carid = p.carid
    inner join items on p.productId = i.productID
where c.brand="Ford" and c.model="Mustang" and c.year=2006 and p.name="hood cover"