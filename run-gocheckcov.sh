#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    echo "Please add 'args: [--minimum-coverage=60])' in your pre-commit config"
    exit 1
fi

gocheckcov check "$@"

returncode=$?
if [ $returncode -ne 0 ]; then
  echo "minimal coverage check failed"
  exit 1
fi