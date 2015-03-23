-- Usage by hour for the past 24 hours (reverse chronologically)
SELECT
  date(eventTime) AS dt
  , strftime('%H', eventTime) AS hr
  , count(*) AS num_api_calls
FROM
  cloudtrail
GROUP BY 1, 2
ORDER BY 1 DESC, 2 DESC
LIMIT 24;
