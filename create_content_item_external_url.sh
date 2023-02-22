#!/bin/zsh

INPUT_FILE=$1

IFS=','

while read SITE TOKEN SUB_ACCT TERM MODULE_NAME ITEM_TITLE ITEM_URL
do

	NUM_OF_COURSES=$(curl "https://"$SITE"/api/v1/accounts/"$SUB_ACCT"/courses?enrollment_term_id="$TERM"&hide_enrollmentless_courses=true&per_page=100" \
	-H 'Authorization: Bearer '$TOKEN | jq length) 

	declare -i COUNT=0

	while [ $COUNT -lt $NUM_OF_COURSES ]
	do
		COURSE_ID=$(curl "https://"$SITE"/api/v1/accounts/"$SUB_ACCT"/courses?enrollment_term_id="$TERM"&hide_enrollmentless_courses=true&per_page=100" \
	-H 'Authorization: Bearer '$TOKEN | jq '.['$COUNT'].id') 
		
		MODULE_ID=$(curl -X "POST" "https://"$SITE"/api/v1/courses/"$COURSE_ID"/modules?module%5Bname%5D="$MODULE_NAME \
	-H 'Authorization: Bearer '$TOKEN | jq '.id')

	curl -H 'Authorization: Bearer '$TOKEN "https://"$SITE"/api/v1/courses/"$COURSE_ID"/modules/"$MODULE_ID"/items" \
  		-X "POST" \
  		-F "module_item[title]="$ITEM_TITLE \
  		-F "module_item[type]=ExternalURL" \
  		-F "module_item[external_url]="$ITEM_URL

	((COUNT++))

	done

done < $INPUT_FILE




