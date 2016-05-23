---Second create the table with integers from 1 to (n) that we can use.

CREATE TABLE Sequence
(seq INTEGER NOT NULL PRIMARY KEY
CHECK (seq  > 0))
 --- create a table for prime
 CREATE TABLE Primes
(p INTEGER NOT NULL PRIMARY KEY
  CHECK (p > 1));
-- fill the table
WITH Digits (i)
AS (SELECT i
   FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0)) AS X(i))
INSERT INTO Sequence(seq)
SELECT (D6.i*1000000+D5.i*100000+D4.i*10000+D3.i * 1000 + D2.i * 100 + D1.i * 10 + D0.i + 1) AS seq
    FROM Digits AS D0, Digits AS D1, Digits AS D2, Digits AS D3, Digits AS D4, Digits AS D5, Digits AS D6;
 
-- load the Primes table with candidate numbers using math fact:
--All primes are of the form (6 * n ± 1), but not all number of that form are Primes.  
--For example (n = 1) gives us {5, 7} and they are both primes.  
--But for (n = 4) gives us {23, 25} where (25 = 5 * 5).  
--What this does is remove the multiples of 2 and 3 from consideration.
INSERT INTO Primes (p) 
(SELECT (6 * seq) + 1
  FROM Sequence
WHERE (6 * seq) + 1 <= 1000000
UNION ALL 
SELECT (6 * seq) - 1
  FROM Sequence
WHERE (6 * seq) + 1 <= 1000000)
union all select 2 
union all select 3
--- delete non primes
DELETE FROM Primes
WHERE EXISTS
  (SELECT * 
     FROM Primes AS P1
    WHERE P1.p <= CEILING (SQRT (Primes.p))
      AND (Primes.p % P1.p) = 0);
-- Create stored procedure
create or replace function Nprime2 (
p_n integer
) returns setof integer
as $BODY$
begin
	return query
	select *
	from Primes
	limit p_n;
	return;	
end;
$BODY$ language plpgsql;
---- executing-----
select * from  Nprime2 (1000000)
order by nprime2 desc
