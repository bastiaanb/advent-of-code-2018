#!/bin/bash

readNode() {
  s=0
  read c
  read m
  for((i=0; i < c; i++)); do
    ((s+=$(readNode)))
  done
  for((i=0; i < m; i++)); do
    read v
    ((s+=v))
  done
  echo $s
}

sed 's/ /\n/g' | readNode 
