--(grant_type string, client_id string, client_secret string, username string, password string)--

SELECT true as error, 1 as code, 'grant_type' as path, 'grant type is missing' as message, 'grant type is missing' as title WHERE {{grant_type}} <> 'password'
UNION ALL
SELECT * FROM (SELECT true as error, 2 as code, 'client_id/client_secret' as path, 'client_id/client_secret is not valid' as message, 'client_id/client_secret is not valid' as title) t WHERE NOT EXISTS 
	(SELECT 1 FROM "connected_apps" ca WHERE ca.client_id = {{client_id}} and ca.client_secret = {{client_secret}});

SELECT * FROM (SELECT true as error, 3 as code, 'username/password' as path, 'username/password is not valid' as message, 'username/password is not valid' as title) t WHERE NOT EXISTS 
	(SELECT 1 FROM "connected_apps" ca INNER JOIN "application_users" au ON au.application_id = ca.application_id INNER JOIN "user" u ON au.user_id = u.id 
		WHERE ca.client_id = {{client_id}} and ca.client_secret = {{client_secret}} and u.first_name = {{username}} and u.password = {{password}});

INSERT INTO access_token (token, user_id, created_at)
SELECT encode(digest(concat(cast(current_timestamp as text), u.id::text), 'sha1'), 'hex') as access_token, u.id as user_id, NOW() 
       FROM "connected_apps" ca INNER JOIN "application_users" au ON au.application_id = ca.application_id INNER JOIN "user" u ON au.user_id = u.id 
       WHERE NOT EXISTS(SELECT * FROM access_token where created_at > (NOW() - INTERVAL '10 min') AND user_id = u.id) AND ca.client_id = {{client_id}} and ca.client_secret = {{client_secret}} and u.first_name = {{username}} and u.password = {{password}};