#!/bin/bash

import json

results = json.dumps($1, indent=4)

echo "${results}" | jq -c '.[]' | while read -r result; do
  title=$(echo "${result}" | jq -r '.title')
  severity=$(echo "${result}" | jq -r '.severity')
  correction=$(echo "${result}" | jq -r '.correction')
  body="**Severity:** ${severity}\n\n**Correction:** ${correction}"
  
  curl -X POST -H "Authorization: token $GH_TOKEN" \
       -H "Accept: application/vnd.github.v3+json" \
       https://api.github.com/repos/${GITHUB_REPOSITORY}/issues \
       -d "{\"title\": \"${title}\", \"body\": \"${body}\"}"
done
