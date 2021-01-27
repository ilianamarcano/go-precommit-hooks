#!/usr/bin/env bash
FILES=$(go list ./...  | grep -v /vendor/)

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Please add `args: [-min-coverage=60]` in your pre-commit config"
    exit 1
fi


gocheckcov check --minimum-coverage $@  ${FILES}

returncode=$?
if [ $returncode -ne 0 ]; then
  echo "minimal coverage check failed"
  exit 1
fi