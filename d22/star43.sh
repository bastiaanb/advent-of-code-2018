#!/bin/bash

depth=8112
targetx=13
targety=743

declare -A erosion
types=('.' '=' '|')

for((x=0; x <= targetx; x++)); do
  g=$((x * 16807))
  erosion["$x:0"]=$(((g+depth) % 20183))
done

for((y=0; y <= targety; y++)); do
  g=$((y * 48271))
  erosion["0:$y"]=$(((g+depth) % 20183))
done

for((y=1; y <= targety; y++)); do
  for((x=1; x <= targetx; x++)); do
    g=$((${erosion["$((x-1)):$y"]} * ${erosion["$x:$((y-1))"]}))
    erosion["$x:$y"]=$(((g+depth) % 20183))
  done
done

risk=0
for((y=0; y <= targety; y++)); do
  for((x=0; x <= targetx; x++)); do
    t=$((${erosion["$x:$y"]} % 3))
    ((risk+=t))
    echo -n ${types[$t]}
  done
    echo
done

((risk-=${erosion["$targetx:$targety"]} % 3))

echo $risk
