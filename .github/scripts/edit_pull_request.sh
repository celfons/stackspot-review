#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$2

# Processa o JSON e atualiza a descrição do pull request no GitHub
title=$(echo "$results" | jq -r '.title')
body=$(echo "$results" | jq -r '.description')

echo "## https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}"

# Realiza a requisição PATCH
curl -X PATCH -H "Authorization: token $GH_TOKEN" \
    -H "Accept: application/vnd.github.full+json" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER} \
    -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"  
