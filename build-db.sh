#!/bin/bash -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. ${DIR}/config.sh
hostos=`uname -s`

echo "Cleaning data dir ===================================="
test -d _data && rm -r ${DATA_DIR}
mkdir -p ${DATA_DIR}

echo "Downloading data ===================================="
for i in 0 1 2; do
  # Account for variance in `date` flags to get a relative time
  case $hostos in
    Darwin)
      dt_modifier="-v-${i}H"
      ;;
    *)
      dt_modifier="--date=${i} hours ago"
  esac

  # By default all files in a directory are included (must be a "directory").
  # So we have to include the whole directory, exclude all files in it, then
  # include the files we wanted.
  s3_path=`date -u "$dt_modifier" +"$S3_DT_PATH"`
  s3_include=`date -u "$dt_modifier" +"$S3_DT_INCLUDE"`
  aws s3 sync ${s3_path} ${DATA_DIR}/ --exclude='*' --include=${s3_include}
done

echo "Decompressing data ===================================="
yes n | gunzip -k ${DATA_DIR}/*.gz

echo "Converting data to csv ===================================="
# Account for variance in `sed` flags to activate extended regex
case $hostos in
  Darwin)
    sed_regex_flag="-E"
    ;;
  *)
    sed_regex_flag="-r"
esac
jq -c '.Records[]
| select(.eventSource == "redshift.amazonaws.com")
| [
    .eventName,
    .eventTime,
    .userIdentity.type,
    .userIdentity.userName,
    .sourceIPAddress,
    .userAgent
  ]
' ${DATA_DIR}/*.json | sed ${sed_regex_flag} 's/(^\[|\]$)//g' > ${CSV_FILE}

echo "Importing csv to database ===================================="
cat ${DIR}/schema/cloudtrail.sql | sqlite3 ${DB_FILE}

${DIR}/run-report.sh ${DIR}/"reports/Top users over the last few hours.sql"

echo
echo "Done ===================================="
echo "To connect to DB: sqlite3 \"$DB_FILE\""
echo "To run other reports: ./run-report.sh reports/REPORT.sql"
