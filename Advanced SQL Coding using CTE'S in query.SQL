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

