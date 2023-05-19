-- Return a table of the registrations running total by month.
-- Order by month in ascending order.
-- Fetch the previous month's MAU.

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
  delivr_month,
  SUM(regs) OVER(ORDER BY delivr_month) AS regs_rt
FROM regs
ORDER BY delivr_month ASC; 

-- Fetch the previous month's MAU.

WITH mau AS (
  SELECT
    DATE_TRUNC('month', order_date) :: DATE AS delivr_month,
    COUNT(DISTINCT user_id) AS mau
  FROM orders
  GROUP BY delivr_month)

SELECT
  delivr_month,
  mau,
  COALESCE(
    LAG(mau) OVER(ORDER BY delivr_month ASC),
  0) AS last_mau
FROM mau
ORDER BY delivr_month ASC;
