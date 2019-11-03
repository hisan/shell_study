#!/bin/bash
trap "echo ' sorry! I havae tarped Ctr-C'" SIGINT
trap "echo 'Good bye!'" EXIT
echo This is a test script
count=1
while [ $count -le 4 ]
do 
	echo "Loop #$count"
	sleep 1
	count=$((count + 1))
done 
echo "end"
#remove signal SIGINT
trap -- SIGINT		
count=1
while [ $count -le 10 ]
do 
	echo "Loop #$count"
	sleep 1
	count=$((count + 1))
done 