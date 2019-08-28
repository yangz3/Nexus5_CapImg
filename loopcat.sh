#!/bin/sh
while [ true ]
do
  sleep 0.05
  adb pull /proc/capacitive_matrix data.csv
done