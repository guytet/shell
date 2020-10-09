#!/bin/bash

address_list=(172.20.1.{1..254})

for i in ${address_list[@]}; do
 ping -c2 $i

 if [ $? -eq 0 ]; then
  echo "$i is alive" >> results.txt
fi

done
