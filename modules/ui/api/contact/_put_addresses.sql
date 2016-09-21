--(@contact_id, @address_id, @address_line1, @address_line2, @city, @state, @zipcode, @is_primary)--

DECLARE @contact_id as int;
DECLARE @address_id as int;
DECLARE @address_line1 as varchar(50);
DECLARE @address_line2 as varchar(50);
DECLARE @city as varchar(50);
DECLARE @state as varchar(2);
DECLARE @zipcode as varchar(6);
DECLARE @is_primary as bit;

IF (EXISTS(SELECT 1 FROM [Address] WHERE ContactId = @contact_id AND Id = @address_id))
BEGIN
	UPDATE [Address] SET
		AddressLine1 = @address_line1, 
		AddressLine2 = @address_line2,
		City = @city,
		[State] = @state, 
		ZipCode = @zipcode, 
		IsPrimary = @is_primary
	WHERE
		ContactId = @contact_id AND Id = @address_id
END
ELSE
BEGIN
	INSERT INTO [Address] 
		(AddressLine1, AddressLine2, City, [State], ZipCode, IsPrimary, ContactID)
	VALUES
		(@address_line1, @address_line2, @city, @state, @zipcode, @is_primary, @contact_id)
END