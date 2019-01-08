#!/bin/bash

declare -A x y z r

maxr=0
maxi=0
i=0
M="pos=<([0-9\-]+),([0-9\-]+),([0-9\-]+)>, r=([0-9\-]+)"
while read line; do
  if [[ $line =~ $M ]]; then
    x[$i]=${BASH_REMATCH[1]}
    y[$i]=${BASH_REMATCH[2]}
    z[$i]=${BASH_REMATCH[3]}
    r[$i]=${BASH_REMATCH[4]}
    if [[ ${r[$i]} -gt $maxr ]]; then
      maxr=${r[$i]}
      maxi=$i
    fi
    ((i++))
  else
    echo unmatched line: $line > /dev/stderr
  fi
done

count_drones() {
  c=0
  for((j=0; j < i; j++)); do
    ((dx=${x[$j]} - ${x[$1]}))
    ((dy=${y[$j]} - ${y[$1]}))
    ((dz=${z[$j]} - ${z[$1]}))
    ((d=${dx#-} + ${dy#-} + ${dz#-}))
    if [[ $d -lt $2 ]]; then
      ((c++))
    fi
  done

  echo $c
}

count_drones $maxi $maxr
