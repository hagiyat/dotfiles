#!/bin/sh
ps aux | awk 'NR!=1{sum_cpu+=$3;sum_mem+=$4;sum_rss+=$6;} END {printf("CPU: %3.2f% MEM: %2.2f%(%2.2fGB)\n",sum_cpu,sum_mem,sum_rss/1024/1024)}'
