--(@id, @product_id, @qty)--

DECLARE @id AS int;
DECLARE @product_id AS int;
DECLARE @qty AS int;

INSERT INTO SalesOrderLine
  (ProductId, Qty, SalesOrderId)
VALUES
  (@product_id, @qty, @id)
