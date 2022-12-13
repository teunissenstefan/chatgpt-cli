#!/usr/bin/env bash

# shellcheck disable=SC2046
export $(grep -v '^#' .env | xargs)

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --max-tokens)
      MAX_TOKENS="$2"
      shift
      shift
      ;;
    -m|--model)
      MODEL="$2"
      shift
      shift
      ;;
    -t|--temperature)
      TEMPERATURE="$2"
      shift
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

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