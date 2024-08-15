#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$2

results=$(echo "$results" | sed "s/'/\"/g")

# GitHub API URL
API_URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}"

# Substitui aspas simples por aspas duplas
results=$(echo "$results" | sed "s/'/\"/g")

# Processa o JSON e cria issues no GitHub
echo "${results}" | jq -c '.[]' | while read -r result; do
    description=$(echo "${result}" | jq -r '.description')
    curl -X PATCH -H "Authorization: token ${GH_TOKEN}" -H "Accept: application/vnd.github.v3+json" \
    ${API_URL} \
    -d "{\"body\": \"${description}\"}"
done
