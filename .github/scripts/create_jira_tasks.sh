#!/bin/bash

rqc_result=$1
jira_base_url=$2
jira_user_email=$3
jira_api_token=$4

issues=$(echo $rqc_result | jq -c '.[]')

for issue in $issues; do
  summary=$(echo $issue | jq -r '.summary')
  description=$(echo $issue | jq -r '.description')
  correction=$(echo $issue | jq -r '.correction')

  response=$(curl -s -X POST \
    -H "Authorization: Basic $(echo -n $jira_user_email:$jira_api_token | base64)" \
    -H "Content-Type: application/json" \
    --data '{ "fields": { "project": { "key": "STAC" }, "summary": "'"$summary"'", "description": "'"$description"'\n '"$correction"'" } }' \
    $jira_base_url/rest/api/2/issue)

  issue_key=$(echo $response | jq -r '.key')
  echo "Created issue: $issue_key"
done