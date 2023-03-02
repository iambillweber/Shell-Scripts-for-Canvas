#!/bin/zsh

INPUT_FILE=$1

IFS=','

ACCESS_TOKEN="your_access_token"
CANVAS_URL="your_canvas_url"
API_ENDPOINT="${CANVAS_URL}/api/vi"


while read SUBACCT_ID EMAIL COURSE_CODE ENROLLMENT_TYPE
do

USER_ID=$(curl --request GET  \
	--url "${API_ENDPOINT}/accounts/${SUBACCT_ID}/users?search_term=${EMAIL}" \
    --header "Authorization: Bearer ${ACCESS_TOKEN}" | /usr/local/bin/jq '.[].id')

C_ID=$(curl --request GET \
	--url "${API_ENDPOINT}/accounts/${SUBACCT_ID}/courses?search_term=${COURSE_CODE}" \
    --header "Authorization: Bearer ${ACCESS_TOKEN}" | /usr/local/bin/jq '.[].id')

curl --request POST \
	--header "Authorization: Bearer ${TOKEN}" \
	--url "${API_ENDPOINT}/courses/${C_ID}/enrollments" \
     -F "enrollment[user_id]=${USER_ID}" \
     -F "enrollment[type]=${ENROLLMENT_TYPE}"

done < $INPUT_FILE
