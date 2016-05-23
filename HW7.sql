-- table creation and value insertion
create table Files(
  id integer,
  parentID integer,
  FileType Char,
  name varchar(50)
)

INSERT INTO "FileLocation"."Files"(
            id, parentid, "Filetype", "Name")
    VALUES (1231,123,'F', 'HW7.docx');

Select * from "FileLocation"."Files"

-- query
WITH RECURSIVE t AS
(SELECT id, "Name", parentid,"Name" as path
FROM "FileLocation"."Files"
WHERE id=121

UNION ALL

SELECT si.id, si."Name",
si.parentid, (si."Name" || '/' || sp.path) as path
FROM "FileLocation"."Files" As si
INNER JOIN t AS sp
ON (si.id = sp.parentid)
)
SELECT t.path
FROM t where parentid is null
ORDER BY path