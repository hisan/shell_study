#!/bin/bash
file="number.txt"
for char in $(cat $file)
do 
	echo the char is $char
done
