--($parent.id integer, name string)--

INSERT INTO "user_groups" 
	(user_id, group_id)
VALUES
	({{$parent.id}}, (SELECT id from "group" WHERE name = {{name}}));