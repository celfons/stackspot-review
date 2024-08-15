#!/bin/bash

# Parameters
PR_NUMBER=$1
results=$2

# Substitui aspas simples por vazio
results=$(echo "$results" | sed "s/'//g")

# Processa o JSON e atualiza a descrição do pull request no GitHub
title=$(echo "$results" | jq -r '.title')
body=$(echo "$results" | jq -r '.description')

# Verifica se as variáveis necessárias estão definidas
if [ -z "$GH_TOKEN" ]; then
  echo "Error: GH_TOKEN is not set."
  exit 1
fi

if [ -z "$PR_NUMBER" ]; then
  echo "Error: PR_NUMBER is not set."
  exit 1
fi

# Realiza a requisição PATCH
curl -X PATCH -H "Authorization: token $GH_TOKEN" \
  -H "Accept: application/vnd.github.full+json" \
  https://api.github.com/repos/celfons/stackspot-review/pulls/${PR_NUMBER} \
  -d "$(jq -n --arg title "$title" --arg body "$body" '{title: $title, body: $body}')"
