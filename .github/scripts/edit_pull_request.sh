#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$2

# Substitui aspas simples por aspas duplas
results=$(echo "$results" | sed "s/'/\"/g")

# Processa o JSON e atualiza a descrição do pull request no GitHub
title=$(echo "${results}" | jq -r '.title')
body=$(echo "${results}" | jq -r '.description')

curl -L \ -X PATCH \ -H "Accept: application/vnd.github+json" \ -H "Authorization: Bearer ${GH_TOKEN}" \ ${API_URL} \ -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"