--($parent.id integer, name string)--

INSERT INTO "user_tokens" 
	(user_id, token_id) 
VALUES
	({{$parent.id}}, (SELECT id from "token" WHERE name = {{name}}))