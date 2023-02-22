#!/bin/bash

INPUT_FILE=$1

IFS=','

while read URL TOKEN SUBACCT_ID EMAIL COURSE_CODE SECTION_NAME ENROLLMENT_TYPE
do

USER_ID=$(curl -s "https://"$URL".instructure.com/api/v1/accounts/"$SUBACCT_ID"/users?search_term="$EMAIL \
     -H 'Authorization: Bearer '$TOKEN | /usr/local/bin/jq '.[].id')

C_ID=$(curl -s "https://"$URL".instructure.com/api/v1/accounts/"$SUBACCT_ID"/courses?search_term="$COURSE_CODE \
     -H 'Authorization: Bearer '$TOKEN | /usr/local/bin/jq '.[].id')

SECTION_ID=$(curl "https://"$URL".instructure.com/api/v1/courses/"$C_ID"/sections" \
	-H 'Authorization: Bearer '$TOKEN | /usr/local/bin/jq '.[].id')

curl -H 'Authorization: Bearer '$TOKEN "https://"$URL".instructure.com/api/v1/sections/"$SECTION_ID"/enrollments" \
     -X "POST" \
     -F 'enrollment[user_id]'=$USER_ID \
     -F 'enrollment[type]='$ENROLLMENT_TYPE

done < $INPUT_FILE
