--(@id, @username, @active)--
DECLARE @id as INT;
DECLARE @username as varchar(50);
DECLARE @active as bit;

UPDATE 
	[User]
SET	
	UserName = @username,
	Active = @active
WHERE 
	Id = @id

SELECT		
	Id,
	UserName,
	Active
FROM 
	[User]
WHERE
	Id = @id
