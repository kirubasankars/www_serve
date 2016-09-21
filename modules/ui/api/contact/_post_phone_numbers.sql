--(@contact_id, @phone_number, @phone_type)--

DECLARE @contact_id as int;
DECLARE @phone_number as varchar(10);
DECLARE @phone_type as int;

INSERT INTO [PhoneNumber] 
	([number], [type], ContactID)
VALUES
	(@phone_number, @phone_type, @contact_id)