#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

if [ ! -f "/usr/bin/chatgpt" ]; then
  sudo ln -s "${DIR}/chatgpt.sh" /usr/bin/chatgpt
fi

if [ ! -f "${DIR}/.env" ]; then
  read -p "Enter OpenAI API-key: " API_KEY
  cp "${DIR}/.env.example" "${DIR}/.env"
  sed -i -e "s/OPENAI_API_KEY=/OPENAI_API_KEY=$API_KEY/g" "${DIR}/.env"
fi

sudo pandoc -s -t man "${DIR}/man/chatgpt.1.md" -o /usr/local/man/man1/chatgpt.1

echo "Installation complete"