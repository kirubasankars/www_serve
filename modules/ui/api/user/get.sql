--(@id, @page, @rows_per_page, @name)--
DECLARE @page AS INT;
DECLARE @rows_per_page AS INT;
DECLARE @id AS INT;
DECLARE @name AS VARCHAR(50);

WITH DATA(RowID, Id, UserName, Active) AS
(
	SELECT
		ROW_NUMBER() OVER(ORDER BY ID) AS RowID,
		Id,
		UserName,
		Active
	FROM 
		[User]
	WHERE
		(@id IS NULL OR Id = @id) AND (@name IS NULL OR UserName like '%' + @name + '%')	
)
SELECT 
	RowID as Sno ,Id, UserName, Active
FROM 
	DATA 
WHERE 
	RowID BETWEEN ((@page - 1) * @rows_per_page + 1) AND (@Page * @rows_per_page)