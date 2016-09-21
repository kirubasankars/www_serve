--(@id)--

DECLARE @id as INT;

SELECT
  ROW_NUMBER() OVER(ORDER BY SO.ID) AS RowID,
  SO.Id,
  OrderDate,
  CustomerId,
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
