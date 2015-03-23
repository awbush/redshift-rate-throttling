-- Top users over the last few hours
SELECT
  userIdentityName
  , userAgent
  , COUNT(*) AS num_api_calls
  , MAX(eventTime) AS most_recent_call
FROM
  cloudtrail
  CROSS JOIN (
    SELECT
      datetime(max(eventTime), '-3 hours') AS min_ts
      , datetime(max(eventTime)) AS max_ts
    FROM
      cloudtrail
  ) aggs
WHERE
  datetime(eventTime) BETWEEN aggs.min_ts AND aggs.max_ts
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;
