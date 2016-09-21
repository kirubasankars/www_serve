--(@id)--
DECLARE @id AS INT;

SELECT
	C.Id, C.IsCompany,
	P.FirstName, P.LastName,
	CO.Name AS CompanyName, Co.ParentId AS ParentCompanyId,
	CASE WHEN C.IsCompany = 1 THEN CO.Name ELSE P.LastName + ',' + P.FirstName END AS Name,
	C.IsCustomer, C.IsVendor,
	A.Id As AddressID, A.AddressLine1, A.AddressLine2, A.City, A.[State], A.ZipCode, A.IsPrimary As IsPrimaryAddress,
	PN.Id As PhoneId, PN.Number AS PhoneNumber, PN.[Type] AS PhoneType
FROM
	Contact C
LEFT JOIN
	Company CO ON CO.ContactId = C.Id
LEFT JOIN
	Person P ON P.ContactId = C.Id
LEFT JOIN
	[Address] A ON A.ContactId = C.Id
LEFT JOIN
	[PhoneNumber] PN ON PN.ContactId = C.Id
LEFT JOIN
	[PhoneType] PT ON PT.Id = PN.[Type]
WHERE
	(@id IS NULL OR C.Id = @id)
