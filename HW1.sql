-- Question 1
select description
from product
where productid=42;

-- question 2
select name, address
from customer
where customerid =42;

-- question 3
select p.productid
from purchase p join customer c
on (c.customerid = p.customerid)
where p.customerid=42;

-- Question 4
select c.fname, c.lname
from customer c join purchase p
on (c.customerid = p.customerid)
where (count(p.purchaseid)=0);

-- Question 5
select description
from purchase
where quantity=0;

-- Question 6
select p.description 
from product p join customer c
where c.zip=10001;

-- 7
with total as (select count(distinct customerid) from customer),
purchased as (select count(distinct c.customerid) from customer c join purchase p
on c.customerid=p.customerid
where p.productid = 42)
select cast(purchased as decimal)/(cast total as decimal)*100
from customer;

--8
with total as (select count(distinct c.customerid) from customer c join purchase p
on c.customerid=p.customerid
where p.productid = 42),
purchased as (select count(distinct c.customerid) from customer c join purchase p
on c.customerid=p.customerid
where p.productid = 42 and p.productid=24)
select cast(purchased as decimal)/(cast total as decimal)*100
from customer;

-- 9
select top 1  count(product.description)
from customer c join purchase p join product
on c.customerid = p.customerid and p.productid=product.productid
where c.state='NY'

-- 10
select top 1  count(product.description)
from customer c join purchase p join product
on c.customerid = p.customerid and p.productid=product.productid
where c.state='NY' or c.state='PA' or c.state = 'MA' or c.state = 'VT' 
or c.state='NH' or c.state ='ME' or c.state = 'RI' or c.state='NJ'
or c.state='CT'
