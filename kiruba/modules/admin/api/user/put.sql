--(id integer, first_name string, last_name string, email string, active boolean)--

UPDATE 
	"user"
SET 	
	first_name = {{first_name}}, 
	last_name = {{last_name}},
	email = {{email}},
	active = {{active}}
WHERE
	id = {{id}};