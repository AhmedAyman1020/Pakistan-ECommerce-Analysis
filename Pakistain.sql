SELECT * FROM clean_data;

SELECT SUM(GRAND_TOTAL) FROM clean_data;

SELECT SUM(GRAND_TOTAL) 
FROM clean_data
where Year = 2017;

--how the total sales for each year (ordered newest to oldest)
SELECT 
	YEAR, SUM(GRAND_TOTAL) AS TOTAL_SALES
FROM clean_data
GROUP BY Year
ORDER BY Year DESC

--Average discount for payment methods with > 100 transactions
SELECT 
    payment_method, 
    AVG(discount_amount) AS Avg_Discount
FROM clean_data
GROUP BY payment_method
HAVING COUNT(*) > 100;

--Top 5 categories by total quantity ordered
SELECT TOP 5 
    category_name_1, 
    SUM(qty_ordered) AS Total_Quantity
FROM clean_data
GROUP BY category_name_1
ORDER BY Total_Quantity DESC;

--Orders with grand_total greater than the average
SELECT 
    increment_id, 
    grand_total
FROM clean_data
WHERE grand_total > (SELECT AVG(grand_total) FROM clean_data);

--First and Latest order date for each customer

SELECT 
    Customer_ID, 
    MIN(created_at) AS First_Order, 
    MAX(created_at) AS Last_Order
FROM clean_data
GROUP BY Customer_ID;

--RANK() based on grand_total within each category
SELECT 
    category_name_1, 
    grand_total,
    RANK() OVER (PARTITION BY category_name_1 ORDER BY grand_total DESC) AS Sales_Rank
FROM clean_data;

--Monthly total sales for 2017 (Assuming 2017 based on your data)
SELECT 
    Month, 
    SUM(grand_total) AS Monthly_Sales
FROM clean_data
WHERE Year = 2017
GROUP BY Month
ORDER BY Month;

--Orders with discount greater than average discount
SELECT
    increment_id, 
    grand_total, 
    discount_amount
FROM clean_data
WHERE discount_amount > (SELECT AVG(discount_amount) FROM clean_data);

--Customers who joined before 2018 and made > 5 orders
SELECT 
    Customer_ID, 
    COUNT(*) AS Orders_Count
FROM clean_data
WHERE Customer_Since < '2018-01-01'
GROUP BY Customer_ID
HAVING COUNT(*) > 5;

--DENSE_RANK() payment methods by total sales
SELECT 
    payment_method, 
    SUM(grand_total) AS Total_Revenue,
    DENSE_RANK() OVER (ORDER BY SUM(grand_total) DESC) AS Rank_Val
FROM clean_data
GROUP BY payment_method;