#!/bin/bash

INPUT_FILE=$1

IFS=','

while read URL SUBACCT_ID COURSE_NAME COURSE_CODE
do

curl -X "POST" "https://$URL.instructure.com/api/v1/accounts/$SUBACCT_ID/courses?course%5Bname%5D=$COURSE_NAME&course%5Bcourse_code%5D=$COURSE_CODE&course%5Bterm_id%5D=$TERM_ID" \
     -H 'Authorization: <token>'
done < $INPUT_FILE
