--(@first_name, @last_name, @is_company, @company_name, @parent_company_id, @is_vendor, @is_customer)--

DECLARE @first_name as varchar(50);
DECLARE @last_name as varchar(50);
DECLARE @is_company as bit;
DECLARE @company_name as varchar(50);
DECLARE @parent_company_id as int;
DECLARE @is_vendor as bit;
DECLARE @is_customer as bit;

DECLARE @contactId AS INT;

INSERT INTO [Contact] 
	(IsCompany, IsVendor, IsCustomer, IsUser) 
VALUES
	(@is_company, @is_vendor, @is_customer, 0)

SET @contactId = @@IDENTITY;

IF (@is_company = 1)
BEGIN
	INSERT INTO [Company] 
		(Name, ParentId, ContactId)
	Values
		(@company_name, @parent_company_id ,@contactId)
END
ELSE 
BEGIN
	INSERT INTO [Person] 
		(FirstName, LastName, ContactId)
	Values
		(@first_name, @last_name ,@contactId)
END

SELECT @contactId AS contact_id;