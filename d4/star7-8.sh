#!/bin/bash

#[1518-10-04 00:00] Guard #151 begins shift
#[1518-11-05 00:49] falls asleep
#[1518-07-05 00:59] wakes up

declare -A awake asleep slept

fillGuard() {
#  echo fillGuard "$@"

  for ((i=$3; i < $4; i++ )); do
    l="$1:$i"
    case $2 in
      wake) awake[$l]=$((awake[$l]+1)) ;;
      sleep) asleep[$l]=$((asleep[$l]+1)); ((slept[$1]++)) ;;
      *) echo unknown state $2 ;;
    esac
  done
}

guard="X"
state=wake
m1=0

sort | {
  while read line; do
    if [[ "$line" =~ ^.([0-9]+-[0-9]+-[0-9]+).([0-9]+):([0-9]+)..(.+) ]]; then
      ymd=${BASH_REMATCH[1]}
      hour=${BASH_REMATCH[2]}
      minute=${BASH_REMATCH[3]}
      message=${BASH_REMATCH[4]}
      if [[ $hour -eq 23 ]]; then
        ymd=$(date -u --date="$ymd $hour:$minute-1" '+%Y-%m-%d')
        hour="00"
        minute="00"
      fi
    else
      echo "unmatched: $line"
    fi

    minute="1$minute"
    ((minute-=100))
#    echo "X $ymd/$hour/$minute/$message"

    case "$message" in
      'falls asleep')
        fillGuard $guard wake $m1 $minute
        m1=$minute
        state=sleep
        ;;
      'wakes up')
        fillGuard $guard sleep $m1 $minute
        m1=$minute
        state=wake
        ;;
      Guard*)
        if [[ $1 != "X" ]]; then
          fillGuard $guard $state $m1 60
        fi
        guard=$(echo $message | cut -d\  -f2)
        guard=${guard:1}
        m1=$minute
        state=wake
        ;;
      "*")
        echo unparsed message $message
        ;;
    esac
  done

  g1=$(for i in "${!slept[@]}"; do echo ${slept[$i]:-0} $i; done | sort -n | tail -n 1 | cut -d\  -f 2)
  m1=$(for i in {0..59}; do echo "${asleep["$g1:$i"]:-0}" $i; done | sort -n | tail -n 1 | cut -d\  -f 2)
  echo $((g1 * m1))

  w2=$(for i in "${!asleep[@]}"; do echo ${asleep[$i]:-0} $i; done | sort -n | tail -n 1 | cut -d\  -f 2)
  echo $((${w2#*:} * ${w2%:*}))

}
