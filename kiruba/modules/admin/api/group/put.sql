--(id integer, name string)--

UPDATE "group" SET name = {{name}} WHERE id = {{id}};

SELECT * FROM "group" WHERE id = {{id}};