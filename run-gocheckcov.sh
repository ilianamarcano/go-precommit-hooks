#!/usr/bin/env bash

IFS='='
read -ra EXCLUDE <<< "$2"
read -ra PACKAGE <<< "$3"
IFS=$'\n'

FILES=$(go list ./...  |  sed  's,'"${PACKAGE[1]}"',,' |  grep -v "${EXCLUDE[1]}" | tail -n +2 )

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Please add 'args: [--minimum-coverage=60])' in your pre-commit config"
    exit 1
fi

PASS=true
for FILE in $FILES; do
  gocheckcov check "$1" "$FILE"
  if [ "$?" -eq 1 ]; then
    PASS=false
  fi
done

if [ "$PASS" = "false" ]; then
    exit 1
fi