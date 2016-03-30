-- Top users over the last few hours
SELECT * FROM (
  SELECT
    eventSource
    , userIdentityName
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
    AND eventSource = 'redshift.amazonaws.com'
  GROUP BY 1, 2, 3
  ORDER BY 4 DESC
  LIMIT 20
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
    CROSS JOIN (
      SELECT
        datetime(max(eventTime), '-3 hours') AS min_ts
        , datetime(max(eventTime)) AS max_ts
      FROM
        cloudtrail
    ) aggs
  WHERE
    datetime(eventTime) BETWEEN aggs.min_ts AND aggs.max_ts
    AND eventSource = 'elasticmapreduce.amazonaws.com'
  GROUP BY 1, 2, 3
  ORDER BY 4 DESC
  LIMIT 20
)
;
