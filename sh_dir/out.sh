#!/bin/bash
for file in /home/zhangyb/*
do 
	if [ -d "$file" ]
	then 
		echo "$file is a directory"
	elif [ -f "$file" ]
	then
		echo "$file is a file"
	fi
done > output.txt
