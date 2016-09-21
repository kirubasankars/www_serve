\c "users";

INSERT INTO "group" 
	(name)
VALUES
	('admin');

INSERT INTO "group" 
	(name)
VALUES
	('user');

INSERT INTO "token" 
	(name)
VALUES
	('admin');

INSERT INTO "token" 
	(name)
VALUES
	('user');

INSERT INTO "user" 
	(first_name, last_name, email, password)
VALUES
	('admin', 'admin', 'admin@admin.com', 'admin@123');

INSERT INTO "user_groups" 
	(user_id, group_id)
VALUES
	((SELECT id FROM "user" WHERE email = 'admin@admin.com'), (SELECT id FROM "group" WHERE name = 'admin'));

INSERT INTO "user_groups" 
	(user_id, group_id)
VALUES
	((SELECT id FROM "user" WHERE email = 'admin@admin.com'), (SELECT id FROM "group" WHERE name = 'user'));

INSERT INTO "user_tokens" 
	(user_id, token_id)
VALUES
	((SELECT id FROM "user" WHERE email = 'admin@admin.com'), (SELECT id FROM "token" WHERE name = 'admin'));

INSERT INTO "user_tokens" 
	(user_id, token_id)
VALUES
	((SELECT id FROM "user" WHERE email = 'admin@admin.com'), (SELECT id FROM "token" WHERE name = 'user'));

INSERT INTO "application" 
	(id, name, active)
VALUES
	(1, 'testApp', true);

INSERT INTO "application_users" 
	(application_id, user_id, active)
VALUES
	(1, 1, true);

INSERT INTO "connected_apps" 
	(owner_id, application_id, client_id, client_secret, active)
VALUES
	(1, 1, 'id', 'secret', true);

