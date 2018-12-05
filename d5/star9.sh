#!/bin/bash

read input
polymer=""

for ((i=0; i < ${#input}; i++)); do
  echo $i
  c=${input:$i:1}
  if [[ -z $polymer ]]; then
    polymer=$c
  else
    p=${polymer: -1}
    if [[ ${c^^} == "${p^^}" && $c != "$p" ]]; then
      polymer=${polymer:0:-1}
    else
      polymer="${polymer}$c"
    fi
  fi
done

echo $polymer
echo
echo ${#polymer}
