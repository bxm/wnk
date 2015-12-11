#!/bin/bash

rm -rf /tmp/repo*

for x in /tmp/repo /tmp/repo1 ; do
  mkdir -p $x
  for y in $(seq 0 1 5) ; do
    touch $x/pkg$y.rpm
  done
done

