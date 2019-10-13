#!/bin/bash
echo "Script process ID:$$"
function func {
	ls -l asckacknalsckn
}

fun2() {
	cat 1.sh
}

count=1
while [ $count -le 4 ]
do 
	echo "Loop #$count"
	sleep 1
	count=$[ $count + 1]
done 
echo "End"
fun2
func
echo "the func's exit status is: $?"