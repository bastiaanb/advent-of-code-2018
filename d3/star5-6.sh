#!/bin/bash

##1 @ 817,273: 26x26

declare -A matrix single
c=0

IFSB="$IFS"
IFS="# @,:x"
while read dummy id x y xsize ysize; do
#  echo "id=$id, x=$x, y=$y, xsize=$xsize, ysize=$ysize"
  single[$id]=1
  for ((i=y+ysize-1; i>=y; i--)); do
    for ((j=x+xsize-1; j>=x; j--)); do
      l="$j:$i"
      if [[ ${matrix[$l]+_} ]]; then
        unset single[$id]
        if [[ ! ${matrix[$l]} =~ / ]]; then
          unset single[${matrix[$l]}]
          ((c++))
        fi
        matrix[$l]+="/$id"
      else
        matrix[$l]=$id
      fi
    done
  done
done

echo $c
echo "${!single[@]}"
