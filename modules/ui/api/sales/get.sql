--(@id, @page, @rows_per_page)--
DECLARE @page AS INT;
DECLARE @rows_per_page AS INT;
DECLARE @id AS INT;

WITH DATA(RowID, Id, OrderDate, CustomerId, LineId, ProductId, Qty) AS
(
	SELECT
	ROW_NUMBER() OVER(ORDER BY SO.ID) AS RowID,
    SO.Id,
	OrderDate,
	SO.CustomerId,
    SOL.Id As LineId,
    SOL.ProductId,
	SOL.Qty
	FROM
	[SalesOrder] SO
		INNER JOIN
    [SalesOrderLine] SOL ON SO.Id = SOL.SalesOrderId
		INNER JOIN
    [Product] P ON SOL.ProductId = P.Id
	WHERE
		(@id IS NULL OR SO.Id = @id)
)
SELECT
	*
FROM
	DATA
WHERE
	RowID BETWEEN ((@page - 1) * @rows_per_page + 1) AND (@Page * @rows_per_page)
