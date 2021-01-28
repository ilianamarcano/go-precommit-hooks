#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Please add 'args: [--minimum-coverage=60])' in your pre-commit config"
    exit 1
fi

EXCLUDE=`echo $2 | sed -e 's/^[^=]*=//g'`
PACKAGE=`echo $3 | sed -e 's/^[^=]*=//g'`

FILES=$(go list ./...  |  sed  's,'"${PACKAGE}"',,' |  grep -v "${EXCLUDE}" | tail -n +2 )

PASS=true
for FILE in $FILES; do
  gocheckcov check "$1" "$FILE"
  if [ "$?" -ne 0 ]; then
    PASS=false
  fi
done

if [ "$PASS" = "false" ]; then
    exit 1
fi
