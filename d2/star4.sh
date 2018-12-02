#!/bin/bash

cut -b 2- < $1 | sort | uniq -d
for i in {1..25}; do
  cut -b 1-$i,$((i+2))- < $1 | sort | uniq -d
done
