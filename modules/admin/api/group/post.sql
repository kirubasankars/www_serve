--(name string)--

INSERT INTO "group" (name) VALUES ({{name}});

SELECT * FROM "group" WHERE id = currval('group_id_seq');