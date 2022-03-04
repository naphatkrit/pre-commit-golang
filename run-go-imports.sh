#!/usr/bin/env bash
#
# Capture and print stdout, since goimports doesn't use proper exit codes
#
set -x
set -e -o pipefail

while getopts "w:" opt; do
  case $opt in
    w)
      cd $OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

exec 5>&1
output="$(goimports -l -w "$@" | tee /dev/fd/5)"
[[ -z "$output" ]]
