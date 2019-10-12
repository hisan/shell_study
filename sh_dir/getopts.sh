#!/bin/bash
sequence=1
echo "$sequence.optarg:$OPTARG!"
echo "position:$OPTIND"
sequence=$[$sequence+1];

while getopts :ab:c opt
do 
	echo "$sequence.optarg:$OPTARG!"
	echo "position:$OPTIND"
	sequence=$[$sequence+1];
	case "$opt" in
		a) echo "Found the -a option";;
		b) echo "Found the -b option,with value $OPTARG";;
		c) echo "Found the -c option";;
		*) echo "Unknown option:$opt";;
	esac
done 