#!/usr/bin/env bash

# shellcheck disable=SC2046
export $(grep -v '^#' .env | xargs)

curl https://api.openai.com/v1/completions \
  -s \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${OPENAI_API_KEY}" \
  -d '{
  "model": "'"$MODEL"'",
  "prompt": "'"$1"'",
  "max_tokens": '"$MAX_TOKENS"',
  "temperature": '"$TEMPERATURE"'
}' | jq -r ".choices[0].text"