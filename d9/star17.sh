#!/bin/sh

LC_ALL=C
players=$1
marbles=$2

declare -A score
declare -a previous next

next[0]=0
previous[0]=0
next[$marbles]=0
previous[$marbles]=0

current=0
for ((m=1, player=1; m <= marbles; m++, player=(player + 1) % players )); do
  if [[ $((m % 1000)) -eq 0 ]]; then
    echo $m : $SECONDS
  fi
  if [[ $((m % 23)) -eq 0 ]]; then
    current=${previous[$current]}
    current=${previous[$current]}
    current=${previous[$current]}
    current=${previous[$current]}
    current=${previous[$current]}
    current=${previous[$current]}
    remove=${previous[$current]}
    p=${previous[$remove]}
    next[$p]=$current
    previous[$current]=$p
    next[$remove]=""
    previous[$remove]=""
    ((score[${player}]+=(m + remove) ))
  else
    p=${next[$((current))]}
    n=${next[$p]}
    previous[$m]=$p
    next[$m]=$n
    next[$p]=$m
    previous[$n]=$m
    current=$m
  fi
#  echo "${previous[@]@A}"
done

for i in "${!score[@]}"; do
  echo $i ${score[$i]}
done | sort -n -k 2
