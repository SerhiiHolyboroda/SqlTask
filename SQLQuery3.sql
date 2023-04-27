SELECT
  YEAR(o.ord_datetime) AS year,
  MONTH(o.ord_datetime) AS month,
  ag.gr_name AS group_name,
  COUNT(*) AS tests_sold,
  SUM(COUNT(*)) OVER (PARTITION BY YEAR(o.ord_datetime), MONTH(o.ord_datetime), ag.gr_name ORDER BY YEAR(o.ord_datetime), MONTH(o.ord_datetime)) AS cumulative_tests_sold
FROM
  Orders o
  JOIN Analysis a ON o.ord_an = a.an_id
  JOIN Analysis_Groups ag ON a.an_group = ag.gr_id
GROUP BY
  YEAR(o.ord_datetime),
  MONTH(o.ord_datetime),
  ag.gr_name
ORDER BY
  YEAR(o.ord_datetime),
  MONTH(o.ord_datetime),
  ag.gr_name