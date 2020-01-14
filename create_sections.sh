#!/bin/bash

INPUT_FILE=$1

IFS=','

while read URL SUBACCT_ID COURSE_CODE SECTION_NAME
do

C_ID=$(curl -s "https://$URL.instructure.com/api/v1/accounts/$SUBACCT_ID/courses?search_term=$C_CODE" \
     -H 'Authorization: <token>' | /usr/local/bin/jq '.[].id')

curl -X "POST" "https://$URL.instructure.com/api/v1/courses/$C_ID/sections?course_section%5Bname%5D=$SECTION_NAME" \
     -H 'Authorization: <token>' 

done < $INPUT_FILE
