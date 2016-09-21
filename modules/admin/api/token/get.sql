--(id integer)--

SELECT 
	*
FROM 
	"token"
WHERE 
	{{id}} is NULL OR id = {{id}};