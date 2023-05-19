-- Alice wants to know how much Delivr spent per month on average during its early months (before September 2018). You'll need to write two queries to solve this problem:

-- A query to calculate cost per month, wrapped in a CTE,
-- A query that averages monthly cost before September 2018 by referencing the CTE.

SQL QUERY:
WITH monthly_cost AS (
  SELECT
    DATE_TRUNC('month', stocking_date)::DATE AS delivr_month,
    SUM(meal_cost * stocked_quantity) AS cost
  FROM meals
  JOIN stock ON meals.meal_id = stock.meal_id
  GROUP BY delivr_month)

SELECT
  -- Calculate the average monthly cost before September
  AVG(cost)
FROM monthly_cost
WHERE delivr_month < '2018-09-01';

-- Delivr is renegotiating its contracts with its eateries. The higher the profit that an eatery generates, the higher the rate that Delivr is willing to pay this eatery for the bulk purchase of meals.

-- The Business Development team asks you to find out how much profit each eatery is generating to strengthen their negotiating positions.

-- Calculate revenue per eatery in the revenue CTE.
-- Calculate cost per eatery in the cost CTE.
-- Join the two CTEs and calculate profit per eatery.
 
 SQL QUERY:
 WITH revenue AS (
  -- Calculate revenue per eatery
  SELECT meals.eatery,
         sum(meal_price * order_quantity) AS revenue
    FROM meals
    JOIN orders ON meals.meal_id = orders.meal_id
   GROUP BY meals.eatery),

  cost AS (
  -- Calculate cost per eatery
  SELECT meals.eatery,
        sum(meal_cost * stocked_quantity) AS cost
    FROM meals
    JOIN stock ON meals.meal_id = stock.meal_id
   GROUP BY meals.eatery)

   -- Calculate profit per eatery
   SELECT revenue.eatery,
          revenue - cost as profit
     FROM revenue
     JOIN cost ON revenue.eatery = cost.eatery
    ORDER BY profit DESC;


-- Bob, the Investment Relations Manager at Delivr, is preparing a pitch deck for a meeting with potential investors. He wants to add a line chart of registrations by month to highlight Delivr's success in gaining new users.

   Send Bob a table of registrations by month.
   
   -- Wrap the query you just wrote in a CTE named reg_dates.
   -- Using reg_dates, return a table of registrations by month.
   
   -- Wrap the query you wrote in a CTE named reg_dates
WITH reg_date AS (
  SELECT
    user_id,
    MIN(order_date) AS reg_date
  FROM orders
  GROUP BY user_id)

SELECT
  -- Count the unique user IDs by registration month
  DATE_TRUNC('MONTH',orders.order_date):: DATE AS delivr_month,
  Count(DISTINCT user_id) AS regs
FROM orders
GROUP BY delivr_month
ORDER BY delivr_month ASC; 

-- You have a suggestion for Bob's pitch deck: Instead of showing registrations by month in the line chart, he can show the registrations running total by month. 
The numbers are bigger that way, and investors always love bigger numbers! He agrees, and you begin to work on a query that returns a table of the registrations running total by month.

-- Return a table of the registrations running total by month.
-- Order by month in ascending order.

WITH reg_dates AS (
  SELECT
    user_id,
    MIN(order_date) AS reg_date
  FROM orders
  GROUP BY user_id),

  regs AS (
  SELECT
    DATE_TRUNC('month', reg_date) :: DATE AS delivr_month,
    COUNT(DISTINCT user_id) AS regs
  FROM reg_dates
  GROUP BY delivr_month)

SELECT
  -- Calculate the registrations running total by month
  delivr_month,
  SUM(regs) OVER(ORDER BY delivr_month) AS regs_rt
FROM regs
-- Order by month in ascending order
ORDER BY delivr_month ASC; 

