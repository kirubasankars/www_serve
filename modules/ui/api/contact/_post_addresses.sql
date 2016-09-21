--(@contact_id, @address_line1, @address_line2, @city, @state, @zipcode, @is_primary)--

DECLARE @contact_id as int;

DECLARE @address_line1 as varchar(50);
DECLARE @address_line2 as varchar(50);
DECLARE @city as varchar(50);
DECLARE @state as varchar(2);
DECLARE @zipcode as varchar(6);
DECLARE @is_primary as bit;

INSERT INTO [Address] 
	(AddressLine1, AddressLine2, City, [State], ZipCode, IsPrimary, ContactID)
VALUES
	(@address_line1, @address_line2, @city, @state, @zipcode, @is_primary, @contact_id)