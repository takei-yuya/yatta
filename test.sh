#!/usr/bin/env bash

source "$(dirname "${0}")/lib.sh"

expext_eq() {
  if [ "$1" = "$2" ]; then
    echo "OK ('$1')"
  else
    echo "NG (expect '$1', but '$2')"
  fi
}

# TODO: BSD date does not support human readable time spec

expext_eq "0day"  "$(relative_time $(date +%s -d '1 sec ago'))"
expext_eq "0day"  "$(relative_time $(date +%s -d '5 sec ago'))"
expext_eq "0day" "$(relative_time $(date +%s -d '50 sec ago'))"

expext_eq "0day"  "$(relative_time $(date +%s -d '1 min ago'))"
expext_eq "0day"  "$(relative_time $(date +%s -d '5 min ago'))"
expext_eq "0day" "$(relative_time $(date +%s -d '50 min ago'))"

expext_eq "0day"  "$(relative_time $(date +%s -d '1 hour ago'))"
expext_eq "0day"  "$(relative_time $(date +%s -d '5 hour ago'))"
expext_eq "0day" "$(relative_time $(date +%s -d '22 hour ago'))"


expext_eq "1day"  "$(relative_time $(date +%s -d '1 day ago'))"
expext_eq "5day"  "$(relative_time $(date +%s -d '5 day ago'))"
expext_eq "6day"  "$(relative_time $(date +%s -d '6 day ago'))"

expext_eq "1week"  "$(relative_time $(date +%s -d '1 week ago'))"
expext_eq "2week"  "$(relative_time $(date +%s -d '2 week ago'))"

# NOTE: How many days are there in a month? 29, 30 or 31?
# use '31 day ago' instead of '1 month ago'
expext_eq "1month"  "$(relative_time $(date +%s -d '31 day ago'))"
expext_eq "2month"  "$(relative_time $(date +%s -d '2 month ago'))"
expext_eq "5month"  "$(relative_time $(date +%s -d '5 month ago'))"
expext_eq "11month"  "$(relative_time $(date +%s -d '11 month ago'))"

expext_eq "1year"  "$(relative_time $(date +%s -d '1 year ago'))"
expext_eq "10year" "$(relative_time $(date +%s -d '10 year ago'))"
