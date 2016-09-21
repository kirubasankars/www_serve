--(id integer)--

SELECT 
	u.id, u.first_name, u.last_name, u.email,
	g.id as group_id, g.name as group_name, ug.active as ugactive,
	t.id as token_id, t.name as token_name, ut.active as utactive
FROM 
	"user" u
LEFT JOIN 
	user_groups ug ON ug.user_id = u.id
LEFT JOIN 
	"group" g ON g.id = ug.group_id
LEFT JOIN
	user_tokens ut ON ut.user_id = u.id
LEFT JOIN 
	token t ON t.id = ut.token_id
WHERE
	{{id}} IS NULL OR u.id = {{id}}
ORDER BY
	u.id, ug.group_id, ut.token_id

