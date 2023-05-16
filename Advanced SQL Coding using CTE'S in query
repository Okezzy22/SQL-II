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
