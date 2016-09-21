--(id integer)--

UPDATE "group" SET active = false WHERE id = {{id}};

SELECT * FROM "group" WHERE id = {{id}};