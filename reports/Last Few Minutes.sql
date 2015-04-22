-- Usage by minute for the last few data points (reverse chronologically)
SELECT
  date(eventTime) || ' ' || strftime('%H-%M', eventTime) AS t
  , count(*) AS num_api_calls
  , userIdentityName AS by_user
  , userAgent AS using_agent
FROM
  cloudtrail
GROUP BY t, by_user, using_agent
ORDER BY t DESC, num_api_calls DESC
LIMIT 24;
