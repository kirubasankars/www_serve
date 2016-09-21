--(name string)--

INSERT INTO "token" (name) VALUES ({{name}});

SELECT * FROM "token" WHERE id = currval('token_id_seq');