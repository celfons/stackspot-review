#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$2

# Substitui aspas simples por aspas duplas
results=$(echo "$results" | sed "s/'/\"/g")

# GitHub API URL
API_URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}"

# Processa o JSON e atualiza a descrição do pull request no GitHub
echo "${results}" | jq -c '.[]' | while read -r result; do
    title=$(echo "${result}" | jq -r '.title')
    body=$(echo "${result}" | jq -r '.description')
    curl -X PATCH -H "Authorization: token ${GH_TOKEN}" -H "Accept: application/vnd.github.v3+json" \
    ${API_URL} \
    -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"
done