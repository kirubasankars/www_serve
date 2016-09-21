--($parent.id integer, name string, _deleted boolean)--

INSERT INTO "user_groups" 
	(user_id, group_id, active)
VALUES
	({{$parent.id}}, (SELECT id from "group" WHERE name = {{name}}), {{_deleted}})

ON CONFLICT (user_id, group_id)

DO UPDATE SET 
	active = EXCLUDED.active