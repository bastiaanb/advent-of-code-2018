#!/bin/bash

LC_ALL=C

collapse() {
  input=$1
  polymer=""
  for ((i=0; i < ${#input}; i++)); do
#    echo $i
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

  echo ${#polymer}
}

read in

for c in a b c d e f g h i j k l m n o p q r s t u v w x y z; do
  echo -n "$c "
  collapse ${in//[$c${c^}]}
done
