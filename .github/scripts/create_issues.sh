#!/bin/bash

# Recebe a string JSON como argumento
results=$1

# Substitui aspas simples por aspas duplas
results=$(echo "$results" | sed "s/'/\"/g")

# Processa o JSON e cria issues no GitHub
echo "${results}" | jq -c '.[]' | while read -r result; do
    correction=$(echo "${result}" | jq -r '.correction')
    title= $(echo "${result}" | jq -r '.severity') > $(echo "${result}" | jq -r '.title')
    body="**Correction:** ${correction}"
    curl -X POST -H "Authorization: token $GH_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/repos/${GITHUB_REPOSITORY}/issues \
        -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"
done
