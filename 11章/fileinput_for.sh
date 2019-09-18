#!/bin/bash
file="number.txt"
IFS=$'\n':;
for char in $(cat $file)
do 
	echo the char is $char
done
