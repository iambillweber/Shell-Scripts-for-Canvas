#!/bin/zsh

INPUT_FILE=$1

IFS=','

while read URL TOKEN SUBACCT_ID COURSE_CODE_FROM COURSE_CODE_TO
do

COURSE_ID_TO=$(curl -s "https://"$URL".instructure.com/api/v1/accounts/"$SUBACCT_ID"/courses?search_term="$COURSE_CODE_TO \
     -H 'Authorization: Bearer '$TOKEN | /usr/local/bin/jq '.[].id')

COURSE_ID_FROM=$(curl -s "https://"$URL".instructure.com/api/v1/accounts/"$SUBACCT_ID"/courses?search_term="$COURSE_CODE_FROM \
     -H 'Authorization: Bearer '$TOKEN | /usr/local/bin/jq '.[].id')


curl -H 'Authorization: Bearer '$TOKEN "https://"$URL".instructure.com/api/v1/courses/"$COURSE_ID_TO"/content_migrations" \
     -X "POST" \
     -F "migration_type=course_copy_importer" \
     -F "settings[source_course_id]="$COURSE_ID_FROM

done < $INPUT_FILE
