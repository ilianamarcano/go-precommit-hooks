#!/usr/bin/env bash
FILES=$(go list ./...  | grep -v /vendor/)

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Please add 'args: [--minimum-coverage=60])' in your pre-commit config"
    exit 1
fi


gocheckcov check "$@"  ${FILES}

returncode=$?
if [ $returncode -ne 0 ]; then
  echo "minimal coverage check failed"
  exit 1
fi