--(@contact_id, @phone_id, @phone_number, @phone_type)--

DECLARE @contact_id as int;
DECLARE @phone_id as int;
DECLARE @phone_number as varchar(10);
DECLARE @phone_type as int;

IF(EXISTS(SELECT 1 FROM [PhoneNumber] WHERE ContactID = @contact_id))
BEGIN
	UPDATE [PhoneNumber] SET
		[Number] = @phone_number,
		[Type] = @phone_type
	WHERE
		ContactID = @contact_id
END
ELSE
BEGIN
	INSERT INTO [PhoneNumber] 
		([number], [type], ContactID)
	VALUES
		(@phone_number, @phone_type, @contact_id)
END