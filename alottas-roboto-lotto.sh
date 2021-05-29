#!/usr/bin/env bash
#
# Alotta's Roboto Lotto
#
# Author:   Neel Yadav (https://neelyadav.com)
#   Date:   May 27, 2021
# 

BASE_TWEET="https://twitter.com/money_alotta/status/1397627025079275523" # Replace hardcoded URL with argument $1 for future use
LURP="._entrants.json"
ENTRANTS="entrants.json"

NEXT=`twurl --bearer "/1.1/search/tweets.json?q=${BASE_TWEET}&result_type=recent&count=100" | jq --raw-output '.search_metadata.next_results'`

twurl --bearer "/1.1/search/tweets.json?q=${BASE_TWEET}&result_type=recent&count=100" | jq ".statuses[] | {tweet_id: .id, name: .user.name, handle: .user.screen_name, profile: .user.profile_image_url_https}" > $LURP
twurl --bearer "/1.1/search/tweets.json${NEXT}" | jq ".statuses[] | {tweet_id: .id, name: .user.name, handle: .user.screen_name, profile: .user.profile_image_url_https}" >> $LURP
jq -s . $LURP | jq -s -r .[] | sed -e "s/\(.*\)_normal\(.*\)/\1_200x200\2/" > $ENTRANTS

COUNT=$(cat $ENTRANTS | grep --count "_200x200")
TIME=$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%B %d, %Y — %-l:%M %p %Z")

echo ""
echo -e "Your tweet was quoted by users \033[4m${COUNT}\033[0m times.\r\nInfo on those users exported to: \033[4m${ENTRANTS}\033[0m"
