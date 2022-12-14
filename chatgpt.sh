#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

# shellcheck disable=SC2046
export $(grep -v '^#' "${DIR}/.env" | xargs)

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
    -n)
      N_COMPLETIONS="$2"
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

USER_MD5=$(echo "$USER" | md5sum | cut -f1 -d" ")

curl https://api.openai.com/v1/completions \
  -s \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${OPENAI_API_KEY}" \
  -d '{
  "model": "'"$MODEL"'",
  "prompt": "'"$1"'",
  "max_tokens": '"$MAX_TOKENS"',
  "n": '"$N_COMPLETIONS"',
  "temperature": '"$TEMPERATURE"',
  "user": "'"$USER_MD5"'"
}' | jq -r ".choices[].text"