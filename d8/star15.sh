#!/bin/bash

#set -x
w=("c1")
i=0

sed 's/ /\n/g' |
while [[ i -ge 0 ]]; do
  v=${w[$i]}
  unset w[$((i--))]
  n=${v:1}
  case ${v:0:1} in
    'c')
      read c
      read m
      if [[ $((--n)) -gt 0 ]]; then
        w[$((++i))]="c$n";
      fi
      w[$((++i))]="m$m"
      if [[ c -gt 0 ]]; then
        w[$((++i))]="c$c"
      fi
    ;;
    'm')
      for ((j=0; j < n; j++)); do
        read k
        echo $k
      done
    ;;
  esac
#  echo W ${w[@]@A}
done | {
  while read r; do ((s+=r)); done
  echo $s
}
