DROP TABLE IF EXISTS cloudtrail;

CREATE TABLE cloudtrail (
  eventName text,
  eventTime datetime,
  userIdentityType text,
  userIdentityName text,
  sourceIPAddress text,
  userAgent text
);

.mode csv
.import _data/all.csv cloudtrail
