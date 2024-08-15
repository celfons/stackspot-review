#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$2

# Formata a string de entrada para JSON válido
formatted_results=$(echo "$results" | sed "s/''/\"/g")

# Processa o JSON e atualiza a descrição do pull request no GitHub
title=$(echo "$formatted_results" | jq -r '.title')
body=$(echo "$formatted_results" | jq -r '.description')

# Realiza a requisição PATCH
curl -X PATCH -H "Authorization: token $GH_TOKEN" \
    -H "Accept: application/vnd.github.full+json" \
    https://api.github.com/repos/celfons/stackspot-review/pulls/${PR_NUMBER} \
    -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"
