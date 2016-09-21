--(id integer, name string)--

UPDATE "token" SET name = {{name}} WHERE id = {{id}};

SELECT * FROM "token" WHERE id = {{id}};