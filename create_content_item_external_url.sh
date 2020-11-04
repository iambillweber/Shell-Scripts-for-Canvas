#!/bin/bash

INPUT_FILE=$1

IFS=','

while read SITE SUB_ACCT TERM MODULE_NAME ITEM_TITLE ITEM_URL
do

	NUM_OF_COURSES=$(curl "https://$SITE/api/v1/accounts/$SUB_ACCT/courses?enrollment_term_id=$TERM&hide_enrollmentless_courses=true&per_page=100" \
	-H 'Authorization: <TOKEN>' | jq length) 

	declare -i COUNT=0

	while [ $COUNT -lt $NUM_OF_COURSES ]
	do
		COURSE_ID=$(curl "https://$SITE/api/v1/accounts/$SUB_ACCT/courses?enrollment_term_id=$TERM&hide_enrollmentless_courses=true&per_page=100" \
	-H 'Authorization: <TOKEN>' | jq '.['$COUNT'].id') 
		
		MODULE_ID=$(curl -X "POST" "https://$SITE/api/v1/courses/$COURSE_ID/modules?module%5Bname%5D=$MODULE_NAME" \
	-H 'Authorization: <TOKEN>' | jq '.id')

	curl -X "POST" "$SITE/api/v1/courses/$COURSE_ID/modules/$MODULE_ID/items?module_item%5Btitle%5D=$ITEM_TITLE&module_item%5Btype%5D=ExternalURL&module_item%5Bexternal_url%5D=$ITEM_URL" \
  	-H 'Authorization: <TOKEN>'

	((COUNT++))

	done

done < $INPUT_FILE




