#!/bin/bash
addem() {
	if [ $# -eq 0 ] || [ $# -gt 2 ]
	then 
		echo -1
	elif [ $# -eq 1 ]
	then 
		echo $[ $1 + $1 ]
	else 
		echo $[ $1 + $2 ]
	fi
}

echo -n "Adding 1o and 15: "
#给函数传递参数
value=$(addem 10 15)
echo $value 

echo -n "Let's try adding just one number: "
value=$(addem 10)
echo $value 

echo -n "Try adding no number: "
value=$(addem)
echo $value 

echo -n "Finally,try adding three numbers: "
value=$(addem 10 15 20)
echo $value