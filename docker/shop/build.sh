#!/bin/bash

docker-compose up

docker exec -it namenode hadoop fs -chmod 777 /

#docker exec -it hbase hadoop fs -chmod 777 /