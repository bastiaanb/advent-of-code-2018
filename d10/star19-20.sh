#!/bin/bash

declare -a px py vx vy

read_input() {
  R="^position=< ?(-?[0-9]+),  ?(-?[0-9]+)> velocity=< ?(-?[0-9]+),  ?(-?[0-9]+)>"
  while read line; do
    if [[ $line =~ $R ]]; then
      px+=(${BASH_REMATCH[1]})
      py+=(${BASH_REMATCH[2]})
      vx+=(${BASH_REMATCH[3]})
      vy+=(${BASH_REMATCH[4]})
    else
      echo unmatched line $line
    fi
  done
}

find_best() {
  # educated guess on bounds
  for ((n=10000; n < 11000; n++)); do
    minx=1000000
    miny=1000000
    maxx=-1000000
    maxy=-1000000
    for ((i=0; i < ${#px[@]}; i++)); do
      x=$((${px[$i]} + n * ${vx[$i]}))
      y=$((${py[$i]} + n * ${vy[$i]}))
      [[ $x -lt $minx ]] && minx=$x
      [[ $y -lt $miny ]] && miny=$y
      [[ $x -gt $maxx ]] && maxx=$x
      [[ $y -gt $maxy ]] && maxy=$y
    done
    echo $n $minx $miny $((maxx - minx)) $((maxy - miny))
  done | sort -n -k 4 | head -1
}

read_input
read n minx miny w h <<< $(find_best)

clear
for ((i=0; i < ${#px[@]}; i++)); do
  x=$((${px[$i]} + n * ${vx[$i]} - minx))
  y=$((${py[$i]} + n * ${vy[$i]} - miny))
  echo -n "$(tput cup $y $x)#"
  sleep 0.01
done

echo "$(tput cup $((h+2)) 0)N=$n"
