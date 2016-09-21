--(@username)--

DECLARE @username as varchar(50);
DECLARE @active as bit = 1;

INSERT INTO [User] (UserName, Password, Active) VALUES(@username, 'test@123', @active)

SELECT		
	Id,
	UserName,
	Active
FROM 
	[User]
WHERE
	Id = @@IDENTITY
