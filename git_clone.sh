#!/bin/bash

cd ..
echo `pwd`
while ( !  git clone https://github.com/alibaba/canal.git)
do
  echo "再来一次试试"
done
