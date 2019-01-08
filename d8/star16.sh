#!/bin/bash

readNode() {
  local sums=()
  local c m s=0
  read c
  read m
  if [[ c -gt 0 ]]; then
    for((i=1; i <= c; i++)); do
      sums[$i]=$(readNode)
    done
#    echo ${sums[@]@A} > /dev/stderr
    for((i=0; i < m; i++)); do
      read v
#      echo "v $v" > /dev/stderr
      ((s+=${sums[$v]:- 0}))
    done
  else
    for((i=0; i < m; i++)); do
      read v
      ((s+=v))
    done
  fi
  echo $s
}

sed 's/ /\n/g' | readNode
