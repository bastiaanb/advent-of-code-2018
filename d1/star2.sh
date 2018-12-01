#!/bin/bash

input=$1
v=0

declare -A seen
r=1
while true; do
  echo "round=$((r++)) ${#seen[@]}"
  while read w; do
    v=$(expr $v ${w:0:1} ${w:1})
    if [[ ${seen[$v]} -eq 1 ]] ; then
      echo "found $v"
      exit 1
    fi

    seen[$v]=1
  done < $input
done
