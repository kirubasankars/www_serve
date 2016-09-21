--($parent.id integer, name string, _deleted boolean)--

INSERT INTO "user_tokens" 
	(user_id, token_id, active)
VALUES
	({{$parent.id}}, (SELECT id from "token" WHERE name = {{name}}), {{_deleted}})

ON CONFLICT (user_id, token_id)

DO UPDATE SET active = EXCLUDED.active; 