-- Top users across all data
SELECT * FROM (
  SELECT
    eventSource
    , userIdentityName
    , userAgent
    , COUNT(*) AS num_api_calls
    , MAX(eventTime) AS most_recent_call
  FROM
    cloudtrail
  WHERE
    eventSource = 'redshift.amazonaws.com'
  GROUP BY 1, 2, 3
  ORDER BY 4 DESC
  LIMIT 10
)

UNION ALL

SELECT * FROM (
  SELECT
    eventSource
    , userIdentityName
    , userAgent
    , COUNT(*) AS num_api_calls
    , MAX(eventTime) AS most_recent_call
  FROM
    cloudtrail
  WHERE
    eventSource = 'elasticmapreduce.amazonaws.com'
  GROUP BY 1, 2, 3
  ORDER BY 4 DESC
  LIMIT 10
)
;
