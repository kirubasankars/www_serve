--(id integer)--

SELECT 
	*
FROM 
	"group"
WHERE 
	{{id}} is NULL OR id = {{id}};