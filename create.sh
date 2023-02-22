#!/bin/zsh

INPUT_FILE=$1

IFS=','

while read URL TOKEN SUBACCT_ID COURSE_NAME COURSE_CODE TERM_ID
do

curl -H 'Authorization: Bearer '$TOKEN "https://"$URL".instructure.com/api/v1/accounts/"$SUBACCT_ID"/courses" \
     -X "POST" \
     -F "course[name]="$COURSE_NAME \
     -F "course[course_code]="$COURSE_CODE \
     -F "course[term_id]"=$TERM_ID
     
done < $INPUT_FILE
