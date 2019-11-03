#!/bin/bash
function arraydblr {
	local originalarray
	local newarray 
	local elements
	local i
	originalarray=($(echo "$@"))
	newarray=($(echo "$@"))
	elements=$[ $# -1 ]
	for ((i = 0 ; i <= $elements; i++))
	{
		newarray[$i]=$[ ${originalarray[$i]} * 2 ] 
	}
	
	echo ${newarray[*]}
}

myarrary=(1,2,3,4,5)
echo -n "The original array is: ${myarrary[*]}"
arg1=$(echo ${myarrary[*]})
echo 
echo -n "1: ${arg1[*]}"
echo 
echo -n "2: $arg1 "
echo 
result=($(arraydblr $arg1))
echo -n "The new arrary is:${result[*]}"