#!/bin/bash
echo -n "Enter your name:"
read name
echo "your name 's :$name"

if read -t 5 -p "Enter your age:" age
then 
	echo "your arge is $age"
else
	echo 
	echo -n "you input nothing"
fi 


while read -t 3 -p "input your address:" address
do 
	echo "your address is $address"
	break;
done 