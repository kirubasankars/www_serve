--(first_name string, last_name string, email string, active boolean)--

INSERT INTO "user" 
	(first_name, last_name, email, active) 
VALUES
	({{first_name}}, {{last_name}}, {{email}}, {{active}})

RETURNING id;
