-- Top users across all data
SELECT
  userIdentityName
  , userAgent
  , COUNT(*) AS num_api_calls
  , MAX(eventTime) AS most_recent_call
FROM
  cloudtrail
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;
