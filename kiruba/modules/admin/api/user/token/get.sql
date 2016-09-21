--(id integer)--

SELECT 
	t.name
FROM 
	"user" u
INNER JOIN 
	user_groups ug ON ug.user_id = u.id
INNER JOIN 
	"group" g ON g.id = ug.group_id
INNER JOIN
	group_tokens gt ON gt.group_id = g.id
INNER JOIN 
	token t ON t.id = gt.token_id
WHERE	
	u.id = {{id}}

UNION

SELECT 
	t.name
FROM 
	"user" u
INNER JOIN
	user_tokens ut ON ut.user_id = u.id
INNER JOIN 
	token t ON t.id = ut.token_id
WHERE	
	u.id = {{id}}