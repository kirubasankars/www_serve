--(@id, @first_name, @last_name, @is_company, @company_name, @parent_company_id, @is_vendor, @is_customer)--

DECLARE @id AS INT;
DECLARE @first_name as varchar(50);
DECLARE @last_name as varchar(50);
DECLARE @is_company as bit;
DECLARE @company_name as varchar(50);
DECLARE @parent_company_id as int;
DECLARE @is_vendor as bit;
DECLARE @is_customer as bit;

UPDATE [Contact] SET 
	IsCompany = @is_company,
	IsVendor = @is_vendor, 
	IsCustomer = @is_customer 
WHERE
	Id = @id
	
IF (@is_company = 1)
BEGIN			
	IF EXISTS(SELECT 1 FROM [Company] WHERE ContactId = @id)	
		UPDATE [Company] 
			SET Name = @company_name, 
				ParentId = @parent_company_id
		WHERE
			ContactId = @id
	ELSE 
		INSERT INTO [Company] 
			(Name, ParentId, ContactId)
		Values
			(@company_name, @parent_company_id ,@id)
	
	DELETE FROM [Person] WHERE ContactId = @id
END
ELSE 
BEGIN	
	IF EXISTS(SELECT 1 FROM [Person] WHERE ContactId = @id)	
		UPDATE [Person]
			SET FirstName = @first_name, 
				LastName = @last_name
		WHERE
			ContactId = @id
	ELSE 
		INSERT INTO [Person] 
			(FirstName, LastName, ContactId)
		Values
			(@first_name, @last_name ,@id)
							
	DELETE FROM [Company] WHERE ContactId = @id
END

SELECT @id AS contact_id;