--(client_id string, client_secret string, username string, password string)--

SELECT  at.token
FROM 
	"connected_apps" ca INNER JOIN "application_users" au ON au.application_id = ca.application_id 
INNER JOIN 
	"user" u ON au.user_id = u.id 
INNER JOIN 
	access_token at ON at.user_id = u.id 
WHERE 
	at.created_at > (NOW() - INTERVAL '10 min') AND ca.client_id = {{client_id}} AND ca.client_secret = {{client_secret}} 
	AND u.first_name = {{username}} and u.password = {{password}};
