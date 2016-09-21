--(@id, @order_date, @customer_id)--

DECLARE @id AS INT;
DECLARE @order_date as DateTime;
DECLARE @customer_id as int;

INSERT INTO SalesOrder
  (OrderDate, CustomerId)
VALUES
  (@order_date, @customer_id)

SELECT @@IDENTITY AS id
