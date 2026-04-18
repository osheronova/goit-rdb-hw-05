USE hw03;

-- Task 1: Subquery in SELECT
SELECT 
    *,
    (SELECT customer_id FROM orders WHERE orders.id = order_details.order_id) AS customer_id
FROM order_details;

-- Task 2: Subquery in WHERE
SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id FROM orders WHERE shipper_id = 3
);

-- Task 3: Subquery in FROM
SELECT order_id, AVG(quantity) AS avg_quantity
FROM (
    SELECT * FROM order_details WHERE quantity > 10
) AS filtered_details
GROUP BY order_id;

-- Task 4: Common Table Expression (CTE)
WITH temp AS (
    SELECT * FROM order_details WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

-- Task 5: Custom function creation and usage
DROP FUNCTION IF EXISTS divide_values;

DELIMITER //

CREATE FUNCTION divide_values(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    RETURN a / b;
END //

DELIMITER ;

SELECT id, order_id, product_id, quantity, divide_values(quantity, 3) AS divided_quantity
FROM order_details;