-- Part 1
with speedtable as(
select carid,
((max (location) over (partition by carid order by "timestamp"  rows between 1 preceding and current row) 
- min (location) over (partition by carid order by "timestamp" rows between 1 preceding and current row))
/((max (timestamp) over (partition by carid order by "timestamp" rows between 1 preceding and current row) 
- min (timestamp) over (partition by carid order by "timestamp" rows between 1 preceding and current row)) as speed
from carsproject.cameras
)
select distinct speedtable.*
from speedtable
where speed > 500

-- Part 2
insert into carsproject.cameras (carid,cameraid,location,"timestamp")
values(2,2,300,0)

insert into carsproject.cameras (carid,cameraid,location,"timestamp")
values(2,2,300,0)

insert into carsproject.cameras (carid,cameraid,location,"timestamp")
values(3,1,200,0)

insert into carsproject.cameras (carid,cameraid,location,"timestamp")
values(1,2,400,10)

insert into carsproject.cameras (carid,cameraid,location,"timestamp")
values(3,2,500,5)

insert into carsproject.cameras (carid,cameraid,location,"timestamp")
values(2,1,200,1)


with speedtable as(
select carid,
max(location) over (partition by carid) distance1,
min (location) over (partition by carid) distance2,
max(timestamp) over (partition by carid) time1,
min (timestamp) over (partition by carid) time2
from carsproject.cameras
)
select distinct *
from speedtable
where (distance2-distance1)/(time2-time1) >10
order by carid