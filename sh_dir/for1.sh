#!/bin/bash
list="a b c d e f g h i j k"
list=$list" l"

#for char in a b c d e f g h i j k
for char in $list
do 
	echo the char is $char
done
