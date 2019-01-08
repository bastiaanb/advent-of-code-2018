#!/bin/bash

k=$1
xsize=150
ysize=150
declare -a level grid

serial=5468

#echo calc levels $SECONDS
for ((y=0; y<ysize; y++)); do
  for ((x=0; x<xsize; x++)); do
    l=$(( ((x + 10) * y + serial) * (x + 10) ))
    l=$(( ${l: -3:1} - 5 ))
    level[$((x + xsize * y))]=$l
  done
done

# i=0
# for ((y=0; y < ysize; y++)); do
#   s=0
#   for ((x=0; x < k; x++)); do
#     ((s+=level[$((i++))]))
#   done
#   for ((x=k; x <= xsize; x++)); do
#     grid[$((i - k))]=$s
#     ((s+=level[$i] - level[$(((i++) - k))] ))
#   done
# done

for ((y=0; y<xsize; y++)); do
  for ((x=0; x<(xsize-3); x++)); do
    i=$((x + xsize * y))
    ((grid[i]=(level[i] + level[i+1] + level[i+2]) ))
  done
done

#echo "${grid[@]@A}"

mx=0
my=0
mv=-1000

for ((x=0; x<xsize; x++)); do
  for ((y=0; y<(ysize-3); y++)); do
    i=$((x + xsize * y))
    ((grid[i]+=(grid[i+xsize]+grid[i+xsize+xsize])))
    if [[ ${grid[$i]} -gt $mv ]]; then
      mv=${grid[$i]}
      mx=$x
      my=$y
    fi
  done
done

# for ((x=0; x<xsize; x++)); do
#   s=0
#   for ((y=0; y < k; y++)); do
#     ((s+=grid[$((x + xsize * y))]))
#   done
#   for ((y=k; y <= ysize; y++)); do
#     if [[ $s -gt $mv ]]; then
#       mv=$s
#       mx=$x
#       my=$((y-k))
#     fi
#     ((s+=grid[$((x + xsize * y))] - grid[$((x + xsize * (y-k)))] ))
#   done
# done

echo $SECONDS $mv $mx $my $k
