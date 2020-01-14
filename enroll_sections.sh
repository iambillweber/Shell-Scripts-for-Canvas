#!/bin/bash

INPUT_FILE=$1

IFS=','

while read URL SUBACCT_ID EMAIL COURSE_CODE SECTION_NAME ENROLLMENT_TYPE
do

USER_ID=$(curl -s "https://$URL.instructure.com/api/v1/accounts/$SUBACCT_ID/users?search_term=$EMAIL" \
     -H 'Authorization: <token>' | /usr/local/bin/jq '.[].id')

C_ID=$(curl -s "https://$URL.instructure.com/api/v1/accounts/$SUBACCT_ID/courses?search_term=$COURSE_CODE" \
     -H 'Authorization: <token>' | /usr/local/bin/jq '.[].id')

SECTION_ID=$(curl "https://uws.instructure.com/api/v1/courses/289542/sections" \
	-H 'Authorization: <token>' | /usr/local/bin/jq '.[].id')

curl -X "POST" "https://$URL.instructure.com/api/v1/sections/$SECTION_ID/enrollments?enrollment%5Buser_id%5D=$USER_ID&enrollment%5Btype%5D=$ENROLLMENT_TYPE" \
     -H 'Authorization: <token>' 

done < $INPUT_FILE
