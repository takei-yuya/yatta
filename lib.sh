#!/usr/bin/env bash

# Usage: choise VAR CHOISE1 [CHOISE2...]
choise() {
  local var="$1"
  shift
  local items=("${@}")
  local choise=""
  while [ -z "${choise}" ]; do
    for i in "${!items[@]}"; do
      echo "$((i+1)): ${items[i]}"
    done
    printf "or input another choise: "
    read choise
  done
  for i in "${!items[@]}"; do
    if [ "$((i+1))" = "${choise}" ]; then
      printf -v "${var}" "%s" "${items[i]%#*}"
      return
    fi
  done
  printf -v "${var}" "%s" "${choise}"
}

# Usage: confirm PROMPT
confirm() {
  # TODO: default value option
  local ans=""
  while :; do
    printf "%s (y/N): " "$1"
    read ans
    case "${ans}" in
      [yY]|[yY][eE][sS]) return 0 ;;
      [nN]|[nN][oO]|"") return 1;;
      *) echo "Unknown answer: ${ans}"
    esac
  done
}

# Usage: simple_time UNIXTIME
simple_time() {
  LANG=C TZ=GMT date -d"@${1}" +"%Y/%m/%d (%a)"
}

# Usage: relative_time UNIXTIME
# NOTE: a little bit sloppy
relative_time() {
  local -i at="${1}"
  local -i now="$(date +%s)"
  local -i diff=$((now - at))
  if [ ${diff} -le 0 ]; then
     # TODO:
     echo "0day"
    return
  fi
  diff=$((diff + 252460800))  # @252460800 = 1978/1/1 is first Sunday New Year's Day (to calc week number)
  local year month week day hour minute second
  eval $(TZ=GMT date +"year=%-Y month=%-m week=%-U day=%-d hour=%-H minute=%-M second=%-S" -d"@${diff}")
  year=$((year - 1978))
  month=$((month - 1))
  week=$((week - 1))
  day=$((day - 1))
  case "${year}/${month}/${week}/${day}/${hour}/${minute}/${second}" in
# TODO: select minimal unit
#    0/0/0/0/0/0/*) echo "${second}sec" ;;
#    0/0/0/0/0/*) echo "${minute}min" ;;
#    0/0/0/0/*) echo "${hour}hour" ;;
    0/0/0/*) echo "${day}day" ;;
    0/0/*) echo "${week}week" ;;
    0/*) echo "${month}month" ;;
    *) echo "${year}year" ;;
  esac
}
