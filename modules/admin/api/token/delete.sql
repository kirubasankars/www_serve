--(id integer)--

UPDATE "token" SET active = false WHERE id = {{id}};

SELECT * FROM "token" WHERE id = {{id}};