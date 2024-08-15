#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$(echo "$2" | sed "s/'/\"/g")

# Processa o JSON e atualiza a descrição do pull request no GitHub
title=$(echo "$results" | jq -r '.title')
body=$(echo "$results" | jq -r '.description')

curl -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GH_TOKEN}" \
  "${API_URL}/repos/{owner}/{repo}/pulls/${PR_NUMBER}" \
  -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"
