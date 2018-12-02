#!/bin/bash

two=0
three=0

while read v; do
  egrep -o . <<< $v | sort | uniq -c | egrep -q ' 2 ' && ((two++))
  egrep -o . <<< $v | sort | uniq -c | egrep -q ' 3 ' && ((three++))
done

echo $(( two * three ))
