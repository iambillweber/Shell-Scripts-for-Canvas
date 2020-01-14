#!/bin/bash

INPUT_FILE=$1

IFS=','

while read URL SUBACCT_ID COURSE_CODE_FROM COURSE_CODE_TO
do

COURSE_ID_TO=$(curl -s "https://$URL.instructure.com/api/v1/accounts/$SUBACCT_ID/courses?search_term=$COURSE_CODE_TO" \
     -H 'Authorization: <token>' | /usr/local/bin/jq '.[].id')

COURSE_ID_FROM=$(curl -s "https://$URL.instructure.com/api/v1/accounts/$SUBACCT_ID/courses?search_term=$COURSE_CODE_FROM" \
     -H 'Authorization: <token>' | /usr/local/bin/jq '.[].id')


curl -X "POST" "https://$URL.instructure.com/api/v1/courses/$COURSE_ID_TO/content_migrations?migration_type=course_copy_importer&settings%5Bsource_course_id%5D=$COURSE_ID_FROM" \
     -H 'Authorization: <token>'

done < $INPUT_FILE
