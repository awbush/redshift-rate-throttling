#!/bin/bash -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. ${DIR}/config.sh

# Get the first line from the report SQL and use it to build a banner.
header=`head -1 "$1"`
header="$header --"
echo
echo "$header" | sed 's/./-/g'
echo "$header"
echo "$header" | sed 's/./-/g'
echo

# Run the report
cat ${DIR}/reports/_cli_config.sql "$1" | sqlite3 ${DB_FILE}
